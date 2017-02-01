package com.dizzo.bpms.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

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
import com.dizzo.bpms.model.CustomApproveLine;
import com.dizzo.bpms.model.Form;
import com.dizzo.bpms.model.FormField;
import com.dizzo.bpms.model.User;
import com.dizzo.bpms.service.ApproveFormFieldService;
import com.dizzo.bpms.service.ApproveLineService;
import com.dizzo.bpms.service.ApproveSummaryService;
import com.dizzo.bpms.service.CustomApproveLineService;
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
	UserService				userService;
	
	@RequestMapping(value="/save", method=RequestMethod.POST)
	public Object saveApprove(@RequestBody ApproveFormField form) {
		System.out.println("Save Approve: " + form);
		return form;
	}
	
	@RequestMapping(value="/summary", method=RequestMethod.POST)
	public ApproveSummary saveApproveSummary(@RequestBody ApproveSummary summary) {
		System.out.println("saving summary: " + summary);
		return summaryService.insert(summary);
	}
	
	/**
	 * 결재 요약 정보를 수정하는 경우는 사용자가 결재문서를 저장했다가 불러와서 상신하거나, 재 저장을 할 떄이다.
	 * 기존 요약 정보의 내용을 수정하고, 기존의 양식 필드와 결재 라인 정보를 삭제한다.
	 * 양식 필드와 결재 라인 정보는 스크립트에서 새로운 정보를 저장한다.
	 * WAS에서 이렇게 처리함으로써 JS에서는 좀 더 단순한 프로세스 플로우를 작성할 수 있다.
	 * 저장이던 수정이던, 항상 양식 필드 정보와 결재 라인은 저장만 한다.
	 * @param summary
	 * @return
	 */
	@RequestMapping(value="/summary", method=RequestMethod.PUT)
	public ApproveSummary updateApproveSummary(@RequestBody ApproveSummary summary) {
		/**
		 * summary update의 경우, 반드시 이어서 수정된 form field를 저장해야 한다.
		 * 그러면, 여기서 아예 기존 form field를 삭제하고 JS에서 save하는 것이 나을 듯...
		 */
		formFieldService.delete(summary.getAppId());
		/**
		 * 기존의 결재라인 정보를 삭제한다.
		 * 새로운(또는 변경 없는) 결재라인은 JS에서 저장을 호출한다.
		 */
		appLineService.deleteAll(summary.getAppId());
		
		return summaryService.update(summary);
	}
	
	@RequestMapping(value="/formField", method=RequestMethod.POST)
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
	
	@RequestMapping(value="/formFields/{appId}", method=RequestMethod.GET)
	public List<FormField> getApproveFormFields(@PathVariable String appId) {
		return formFieldService.getFormFields(appId);
	}
	
	@RequestMapping(value="/summary/{userId}/", method=RequestMethod.GET)
	public List<ApproveSummary> getApproveSummaryList(@PathVariable String userId) {
		System.out.println("get approve summary list for " + userId);
		return summaryService.list(userId);
	}
	
	@RequestMapping(value="/summary/get/{appId}", method=RequestMethod.GET)
	public ApproveSummary getApproveSummaryByAppId(@PathVariable String appId) {
		return summaryService.getByAppId(appId);
	}
	
	@RequestMapping(value="/form/{appId}", method=RequestMethod.GET)
	public Form getFormInformationByApproveId(@PathVariable String appId) {
		return formService.getByAppId(appId);
	}
	
	/**
	 * 결재 문서를 작성할 때, 사용자에게 필요한 결재라인을 조회하여 반환한다.
	 * 결재 아이디는 아직 정해지지 않았으며, 결재라인 아이디도 정해지지 않은 상태이다.
	 * @param formId
	 * @return 사용자 정의 결재 라인
	 */
	@RequestMapping(value="/line/{formId}", method=RequestMethod.GET)
	public List<ApproveLine> getAppoveLines(@PathVariable String formId) {
		String	userId = getPrincipal();
		List<ApproveLine>	lines = null;
		
		/**
		 * 사용자가 정의한 결재라인이 있는지 확인해 있으면 사용자 정의 결재라인을 시스템에서 사용하는 결재라인으로 변환하여 반환한다.
		 * 사용자가 정의한 결재라인이 없으면, 조직도를 이용하여 사용자에게 맞는 결재라인을 반환한다.
		 */
		List<CustomApproveLine> customLines = customAppLineService.getApproveLines(userId, formId);
		if (customLines != null && customLines.size() > 0) {
			lines = convertApproveLine(customLines);
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
			line.setStatus(ApproveStatus.PROCESSING.getStatus());
			
			lines = appLineService.getByOrganize(userId);
			lines.add(0, line);
		}
		return lines;
	}
	
	/**
	 * 저장된 결재 문서를 불러 오거나, 상신 결재 문서를 결재하기 위해 불러 올 때 정의된 결재 라인을 조회한다.
	 * @return
	 */
	@RequestMapping(value="/line/save/{appId}", method=RequestMethod.GET)
	public List<ApproveLine> getSavedApproveLine(@PathVariable String appId) {
		return appLineService.getByAppId(appId);
	}
	
	/**
	 * 결재 문서를 저장하거나 상신할 때, 결재 라인을 저장한다.
	 * @return
	 */
	@RequestMapping(value="/line/save", method=RequestMethod.POST)
	public List<ApproveLine> saveApporveLine(@RequestBody List<ApproveLine> appLines) {
		return appLineService.insert(appLines);
	}
	
	/**
	 * 결재 문서 승인 처리
	 */
	
	/**
	 * 결재 라인을 수정한다. 결재 라인의 수정은 결재 문서가 저장 상태일 때만 가능하고, 상신 이후에는 절대 수정할 수 없다.
	 * 따라서, 결재라인 수정은 기존의 결재라인을 삭제하고 새로운 결재 라인을 저장한다.
	 */
	@RequestMapping(value="/line/{appId}", method=RequestMethod.PUT)
	public List<ApproveLine> updateApproveLine(@PathVariable String appId, @RequestBody List<ApproveLine> appLines) {
		appLineService.deleteAll(appId);
		return appLineService.insert(appLines);
	}
	
	/**
	 * 저장되어 있는 결재 문서 정보를 삭제한다.
	 * 삭제할 결재 관련 테이블은 approve_form_field, approve_line, approve_summary 이다.
	 * @param appId
	 * @return
	 */
	@RequestMapping(value="/{appId}", method=RequestMethod.DELETE)
	public ApproveSummary cancelApprove(@PathVariable String appId) {
		formFieldService.delete(appId);
		appLineService.deleteAll(appId);
		return summaryService.delete(appId);
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
			appLine.setSeq(line.getOrder());
			
			appLines.add(appLine);
		}
		
		return appLines;
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
