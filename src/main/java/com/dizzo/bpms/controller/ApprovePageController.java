package com.dizzo.bpms.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.dizzo.bpms.model.ApproveTrayType;
import com.dizzo.bpms.model.FileAttach;
import com.dizzo.bpms.model.Form;
import com.dizzo.bpms.service.FileAttachService;
import com.dizzo.bpms.service.FormService;

@Controller
@RequestMapping("/approve")
public class ApprovePageController {
	
	@Autowired
	FormService		formService;
	
	@Autowired
	FileAttachService	fileService;

	@RequestMapping(value="/list", method=RequestMethod.GET)
	public String getListApprovePage() {
		return "/approve/list";
	}
	
	/**
	 * may be not used
	 * @return
	 */
	@RequestMapping(value="/regist", method=RequestMethod.GET)
	public String getRegistApprovePage() {
		return "/approve/regist";
	}
	
	/**
	 * 결재 등록 메뉴
	 * 선택한 결재 양식의 경로와 양식 정보를 조회하여 페이지를 반환한다.
	 * @param formId
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/regist/{formId}", method=RequestMethod.GET)
	public String getFormTemplate(@PathVariable String formId, ModelMap model) {
		System.out.println("formid = " + formId);
		Form		form = formService.getById(formId);
		List<FileAttach>	files = fileService.listByMainId(formId);
		FileAttach	file = files.get(0);
		String	formPath = "/forms/" + file.getName();
		
		// formPath에서 extension을 제거해야 함.
		formPath = formPath.substring(0,  formPath.indexOf(".jsp"));
		
		// 양식명 표시를 위해 model을 추가한다.
		model.addAttribute("form", form);
		return formPath;
	}
	
	/**
	 * 결재 문서 수정.
	 * 작성중인 결재 문서를 선택한 경우, 해당 결재 양식 경로와 양식 정보를 조회하여 페이지를 반환한다.
	 * @param appId
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/edit/{appId}", method=RequestMethod.GET)
	public String getFormTemplateByAppId(@PathVariable String appId, ModelMap model) {
		Form	form = formService.getByAppId(appId);
		List<FileAttach>	files = fileService.listByMainId(form.getId());
		FileAttach	file = files.get(0);
		String	formPath = "/forms/" + file.getName();
		
		formPath = formPath.substring(0, formPath.indexOf(".jsp"));
		
		model.addAttribute("form", form);
		return formPath;
	}
	
	@RequestMapping(value="/tray/list/{type}", method=RequestMethod.GET)
	public String getApproveTrayPage(@PathVariable String type) {
		String	page = null;
		
		if (type.equals(ApproveTrayType.UNDECIDE.getType()))			// 미결함
			page = "/approve/undecide";
		else if (type.equals(ApproveTrayType.DEFER.getType()))			// 보류함
			page = "/approve/defer";
		else if (type.equals(ApproveTrayType.COMPLETED.getType()))		// 완료함
			page = "/approve/completed";
		else if (type.equals(ApproveTrayType.FINISHED.getType()))		// 기결함
			page = "/approve/finished";
		else if (type.equals(ApproveTrayType.EXPECTED.getType()))		// 예정함
			page = "/approve/expected";
		else if (type.equals(ApproveTrayType.REJECT.getType()))			// 반려함
			page = "/approve/reject";
		
		return page;
	}
	
	@RequestMapping(value="/manappline", method=RequestMethod.GET)
	public String getManageApproveLinePage() {
		System.out.println("return man_appline.jsp");
		return "/approve/man_appline";
	}
}
