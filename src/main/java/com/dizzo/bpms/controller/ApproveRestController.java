package com.dizzo.bpms.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.dizzo.bpms.model.ApproveFormField;
import com.dizzo.bpms.model.ApproveLine;
import com.dizzo.bpms.model.ApproveStatus;
import com.dizzo.bpms.model.ApproveSummary;
import com.dizzo.bpms.model.ApproveTray;
import com.dizzo.bpms.model.ApproveTrayType;
import com.dizzo.bpms.model.CustomApproveLine;
import com.dizzo.bpms.model.DocumentManager;
import com.dizzo.bpms.model.Form;
import com.dizzo.bpms.model.FormField;
import com.dizzo.bpms.model.User;
import com.dizzo.bpms.model.UserDepartmentPosition;
import com.dizzo.bpms.service.ApproveFormFieldService;
import com.dizzo.bpms.service.ApproveLineService;
import com.dizzo.bpms.service.ApproveSummaryService;
import com.dizzo.bpms.service.ApproveTrayService;
import com.dizzo.bpms.service.CustomApproveLineService;
import com.dizzo.bpms.service.DepartmentService;
import com.dizzo.bpms.service.FormService;
import com.dizzo.bpms.service.UserService;

@CrossOrigin(origins="*", maxAge=3600)
@RestController
@RequestMapping("/rest/approve")
public class ApproveRestController {

	@Autowired
	ApproveSummaryService	summaryService;
	
	@Autowired
	ApproveFormFieldService	formFieldService;
	
	@Autowired
	FormService				formService;
	
	@Autowired
	CustomApproveLineService	customAppLineService;
	
	@Autowired
	ApproveLineService			appLineService;
	
	@Autowired
	ApproveTrayService			appTrayService;
	
	@Autowired
	UserService				userService;
	
	@Autowired
	DepartmentService		deptService;
	
	@RequestMapping(value="/form/{appId}", method=RequestMethod.GET)
	public Form getFormInformationByApproveId(@PathVariable String appId) {
		return formService.getByAppId(appId);
	}

	/**
	 * 저장되어 있는 결재 문서 정보를 삭제한다.
	 * 삭제할 결재 관련 테이블은 approve_form_field, approve_line, approve_summary 이다.
	 * @param appId
	 * @return
	 */
	@RequestMapping(value="/{appId}", method=RequestMethod.DELETE)
	public ApproveSummary deleteApprove(@PathVariable String appId) {
		formFieldService.delete(appId);
		appLineService.deleteAll(appId);
		appTrayService.deleteAll(appId);
		return summaryService.delete(appId);
	}
	
	/**
	 * 결재 문서 승인 처리
	 * 결재라인의 상태를 결재 완료로 업데이트하고, 결재함 정보를 수정한다.
	 */
	@RequestMapping(method=RequestMethod.POST)
	public ApproveLine submitApprove(@RequestBody ApproveLine line) {
		System.out.println("DEBUG: Submit Approve Line: " + line);
		line.setStatus(ApproveStatus.FINISH.getStatus());
		line = appLineService.update(line);
		
		List<ApproveTray> trays = appTrayService.submitTray(line);
		
		if (trays == null) {
			// 결재가 완료 됨.
			// 다음 처리 부서가 있는지 확인해서 처리 부서로 결재 문서를 전달하거나, 모든 결재가 완료되었으면 해당 양식에 정의된 후 처리를 수행한다.
			// 휴가원의 경우 사용자의 부재 일정을 부서 일정에 등록하거나, 결재 관리 시스템에 휴가 정보를 등록한다. 할 수 있다면...
			
			String	appId = line.getAppId();
			Form form = formService.getByAppId(appId);
			
			if (form.getProcDept() == null) {
				// 처리부서가 없으므로, 모든 결재가 완료되었음.
				return null;
			} else {
				ApproveSummary	summary = getApproveSummaryByAppId(appId);
				
				/**
				 * 의뢰부서와 처리부서의 모든 결재가 완료되었는지 확인한다.
				 * 처리부서까지 결재가 완료된 상태면, 결재 요약 정보를 갱신하고 작성자의 완료함에 결재문서 정보를 보관한다.
				 * 완료함은 개념적인 의미의 보관장소이고, 시스템에서는 결재 요약 정보의 상태가 완료인 것을 조회한다.
				 */
				if (isCompletedApprove(appId)) {
					summary.setStatus(ApproveStatus.FINISH.getStatus());
					summaryService.update(summary);
					return null;
				}
				
				/**
				 * 문서 작성자의 부서가 처리부서와 같은지 확인한다.
				 * 같은 부서라면 결재를 완료한다.
				 * 다른 부서라면 처리 부서의 문서 담당자 결재함에 해당 결재 정보를 등록한다.
				 */
				
				DocumentManager docManager = getDocumentManager(summary, form.getProcDept());
				if (docManager == null) {
					System.out.println("Finished approve processing");
					return null;
				} else {
					// 처리부서의 문서 담당자 결재함에 결재 정보를 등록한다.
					ApproveTray	tray = new ApproveTray();
					tray.setAppId(appId);
					tray.setAppTitle(summary.getTitle());
					tray.setUserId(docManager.getUserId());
					tray.setType(ApproveTrayType.UNDECIDE.getType());
					tray.setCreator(summary.getUserId());
					tray.setCreatorName(summary.getUserId());
					
					appTrayService.insert(tray);
				}
			}
		}
		return line;
	}

	/**
	 * 모든 결재가 완료되었는지 확인다.
	 * 처리부서가 있는 경우이므로, 처리부서의 결재 상태가 모두 완료인지 확인한다.
	 * @param appId
	 * @return
	 */
	private boolean isCompletedApprove(String appId) {
		List<ApproveLine>	lines = appLineService.getByAppId(appId);
		List<ApproveLine>	procLines = lines.stream().filter(t -> t.getType().equals("P")).collect(Collectors.toList());	// 처리부서의 결재라인만 필터링.
		boolean	completed = true;
		
		System.out.println("DEBUG: lines: " + lines);
		System.out.println("DEBUG: procLines: " + procLines);
		if (procLines.isEmpty()) {
			System.out.println("Not yet assigned processing department");
			return false;
		}
		
		for (int i = 0; i < procLines.size(); i++) {
			if (!procLines.get(i).getStatus().equals(ApproveStatus.FINISH.getStatus())) {
				completed = false;
				break;
			}
		}
		
		return completed;
	}
	/**
	 * 처리부서의 문서 담당자를 조회한다.
	 * 결재 문서를 작성한 담당자가 처리부서이면, 처리부서를 null로 반환한다.
	 */
	private DocumentManager getDocumentManager(ApproveSummary summary, String procDept) {
		User	charge = userService.getByUserId(summary.getUserId());
		DocumentManager	docManager = null;
		List<UserDepartmentPosition>	upds = charge.getDeptPositions();
		Iterator<UserDepartmentPosition> it = upds.iterator();

		/**
		 * 결재문서 작성자가 처리부서 직원인지 검사한다.
		 * 내재된 오류: 직원들은 겸직을 할 수 있다. 문서를 작성한 담당자가 처리부서와 아닌 부서로 등록되어 있는 경우에 처리부서가 아닌 부서로 결재를
		 * 상신하면, 처리부서 결재를 받아야 함에도, 결재 완료 처리가 될 수 있다. (어떡하지??? ㅡㅡ;;)
		 */
		while (it.hasNext()) {
			UserDepartmentPosition dp = it.next();
			
			if (dp.getDeptId().equals(procDept)) {
				// 결재 작성자가 처리부서 직원이면, 결재 완료 처리
				return null;
			}
		}
		
		/**
		 * 문서 담당자는 정/부로 등록되는 것이 원칙이지만, '정'만 등록되는 경우도 있다.
		 * 문서 담당자의 부재 처리를 위한 로직도 필요하다.
		 * '정'이 부재시에는 '부'가 문서 담당자로 지정되어야 한다.
		 */
		List<DocumentManager>	docManagers = deptService.getDocumentManagersByDeptId(procDept);
		
		for (int i = 0; i < docManagers.size(); i++) {
			docManager = docManagers.get(i);
			if (docManager.getType().equals("M"))	break;
		}
		
		return docManager;
	}
	
	@RequestMapping(value="/summary", method=RequestMethod.POST)
	public ApproveSummary saveApproveSummary(@RequestBody ApproveSummary summary) {
		System.out.println("saving summary: " + summary);
		return summaryService.insert(summary);
	}

	@RequestMapping(value="/summary", method=RequestMethod.PUT)
	public ApproveSummary updateApproveSummary(@RequestBody ApproveSummary summary) {
		return summaryService.update(summary);
	}

	@RequestMapping(value="/summary/user/{userId}/", method=RequestMethod.GET)
	public List<ApproveSummary> getApproveSummaryList(@PathVariable String userId) {
		System.out.println("get approve summary list for " + userId);
		return summaryService.list(userId);
	}

	@RequestMapping(value="/summary/doc/{appId}", method=RequestMethod.GET)
	public ApproveSummary getApproveSummaryByAppId(@PathVariable String appId) {
		return summaryService.getByAppId(appId);
	}

	@RequestMapping(value="/fields", method=RequestMethod.POST)
	public ApproveFormField saveApproveFormField(@RequestBody ApproveFormField formField) {
		/**
		 * ApproveFormField 객체는 Restfule API를 위한 개체이면 DAO에 사용되는 개체는 ApproveFormField의
		 * 멤버 변수인 List<FormField>이다.
		 */
		String	appId = formField.getAppId();
		String	formId = formField.getFormId();
		List<FormField>	fields = formField.getFormFields();
		
		formFieldService.insert(appId, formId, fields);
		return formField;
	}

	@RequestMapping(value="/fields", method=RequestMethod.PUT)
	public ApproveFormField updateApproveFormField(@RequestBody ApproveFormField formFields) {
		// 기존의 form fields를 삭제하고 새로 저장한다.
		String	appId = formFields.getAppId();
		String	formId = formFields.getFormId();
		List<FormField>	fields = formFields.getFormFields();
		
		System.out.println("update form fields");
		System.out.println("formFields: " + formFields);
		
		formFieldService.delete(appId);
		formFieldService.insert(appId, formId, fields);
		return formFields;
	}
	
	@RequestMapping(value="/fields/{appId}", method=RequestMethod.DELETE)
	public String deleteFormFields(@PathVariable String appId) {
		return formFieldService.delete(appId);
	}
	
	@RequestMapping(value="/fields/{appId}", method=RequestMethod.GET)
	public List<FormField> getApproveFormFields(@PathVariable String appId) {
		return formFieldService.getFormFields(appId);
	}

	@RequestMapping(value="/lines/{appId}", method=RequestMethod.DELETE)
	public List<ApproveLine> deleteApproveLines(@PathVariable String appId) {
		return appLineService.deleteAll(appId);
	}
	
	/**
	 * 결재 문서를 작성할 때, 사용자에게 필요한 결재라인을 조회하여 반환한다.
	 * 결재 아이디는 아직 정해지지 않았으며, 결재라인 아이디도 정해지지 않은 상태이다.
	 * @param formId
	 * @return 사용자 정의 결재 라인
	 */
	@RequestMapping(value="/lines/{formId}", method=RequestMethod.GET)
	public List<ApproveLine> getAppoveLines(@PathVariable String formId) {
		String	userId = getPrincipal();
		List<ApproveLine>	lines = null;
		
		/**
		 * 사용자가 정의한 결재라인이 있는지 확인해 있으면 사용자 정의 결재라인을 시스템에서 사용하는 결재라인으로 변환하여 반환한다.
		 * 사용자가 정의한 결재라인이 없으면, 조직도를 이용하여 사용자에게 맞는 결재라인을 반환한다.
		 */
		List<CustomApproveLine> customLines = customAppLineService.getApproveLines(userId, formId);
		if (customLines != null && customLines.size() > 0) {
			System.out.println("customLines: " + customLines);
			lines = convertApproveLine(customLines);
			System.out.println("lines: " + lines);
		} else {
			System.out.println("There is no custom approve line. Fetching organize");
			// 본인이 제외됨으로 본인의 결재 라인을 맨 처음에 배치되도록 한다.
			User	user = userService.getByUserId(userId);
			ApproveLine	line = new ApproveLine();
			line.setAppId(null);
			line.setLineId(null);
			line.setApprovalId(userId);
			line.setApprovalName(user.getLastName() + user.getFirstName());
			line.setApprovalPosition(user.getDeptPositions().get(0).getPositionName());
			line.setModified(new Date());
			line.setSeq(0);
			line.setType("R");
			line.setStatus(ApproveStatus.PROCESSING.getStatus());
			
			lines = appLineService.getByOrganize(userId);
			System.out.println("DEBUG: lines: " + lines);
			lines.add(0, line);
		}
		
		// 무슨 이유에서인지 조회 결과에 seq가 모두 0으로 세팅된다. 아무래도 rownum의 타입이 다른 것 같은데 별 수를 다 써도 안됨.
		// 무식하게 seq를 재 저장함.
		for (int i = 0; i < lines.size(); i++) {
			lines.get(i).setSeq(i);
		}
		System.out.println("DEBUG: lines: " + lines);
		return lines;
	}
	
	/**
	 * 저장된 결재 문서를 불러 오거나, 상신 결재 문서를 결재하기 위해 불러 올 때 정의된 결재 라인을 조회한다.
	 * @return
	 */
	@RequestMapping(value="/lines/save/{appId}", method=RequestMethod.GET)
	public List<ApproveLine> getSavedApproveLine(@PathVariable String appId) {
		return appLineService.getByAppId(appId);
	}
	
	/**
	 * 결재 문서를 저장하거나 상신할 때, 결재 라인을 저장한다.
	 * @return
	 */
	@RequestMapping(value="/lines/save", method=RequestMethod.POST)
	public List<ApproveLine> saveApporveLine(@RequestBody List<ApproveLine> appLines) {
		return appLineService.insert(appLines);
	}
	
	@RequestMapping(value="/lines/custom/{formId}", method=RequestMethod.POST)
	public List<ApproveLine> saveCustomApproveLine(@PathVariable String formId, @RequestBody List<ApproveLine> lines) {
		List<CustomApproveLine>	customLines = convertApproveLineToCustomApproveLine(formId, lines);
		customAppLineService.saveApproveLines(customLines);
		return lines;
	}
	
	/**
	 * 결재 라인을 수정한다. 결재 라인의 수정은 결재 문서가 저장 상태일 때만 가능하고, 상신 이후에는 절대 수정할 수 없다.
	 * 따라서, 결재라인 수정은 기존의 결재라인을 삭제하고 새로운 결재 라인을 저장한다.
	 */
	@RequestMapping(value="/lines/{appId}", method=RequestMethod.PUT)
	public List<ApproveLine> updateApproveLine(@PathVariable String appId, @RequestBody List<ApproveLine> appLines) {
		appLineService.deleteAll(appId);
		return appLineService.insert(appLines);
	}
	
	/**
	 * 사용자 지정 결재 라인을 시스템에 사용되는 ApproveLine으로 변환한다.
	 * @param customLines
	 * @return
	 */
	private List<ApproveLine> convertApproveLine(List<CustomApproveLine> customLines) {
		List<ApproveLine>	appLines = new ArrayList<ApproveLine>();
		Iterator<CustomApproveLine> lines = customLines.iterator();
		
		while (lines.hasNext()) {
			CustomApproveLine line = lines.next();
			ApproveLine	appLine = new ApproveLine();
			
			appLine.setAppId(null);
			appLine.setApprovalId(line.getApprovalId());
			appLine.setApprovalName(line.getApprovalName());
			appLine.setApprovalPosition(line.getApprovalPosition());
			appLine.setLineId(null);
			appLine.setModified(null);
			appLine.setStatus(ApproveStatus.PROCESSING.getStatus());
			appLine.setSeq(line.getSeq());
			
			appLines.add(appLine);
		}
		
		return appLines;
	}
	
	private List<CustomApproveLine> convertApproveLineToCustomApproveLine(String formId, List<ApproveLine> lines) {
		List<CustomApproveLine>	customLines = new ArrayList<CustomApproveLine>();
		Iterator<ApproveLine>	it = lines.iterator();
		String	userId = getPrincipal();
		
		System.out.println("DEBUG: lines: " + lines);
		
		while (it.hasNext()) {
			ApproveLine l = it.next();
			CustomApproveLine c = new CustomApproveLine();
			
			c.setFormId(formId);
			c.setApprovalId(l.getApprovalId());
			c.setSeq(l.getSeq());
			c.setUserId(userId);
			
			customLines.add(c);
		}
		
		System.out.println("DEBUG: customLines: " + customLines);
		return customLines;
	}
	
	private String getPrincipal() {
		String	userName = null;
		Object	principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		
		if (principal instanceof UserDetails) {
			userName = ((UserDetails)principal).getUsername();
		} else {
			userName = principal.toString();
		}
		
		System.out.println("userName : " + userName);
		if (userName.equals("anonymousUser"))	userName = null;
		return userName;
	}
}
