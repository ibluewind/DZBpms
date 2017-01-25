package com.dizzo.bpms.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.dizzo.bpms.model.FileAttach;
import com.dizzo.bpms.model.Form;
import com.dizzo.bpms.service.FileAttachService;
import com.dizzo.bpms.service.FormService;

@Controller
@RequestMapping("/app")
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
	
	/**
	 * 미결함.
	 * 결재해야할 결재 문서 목록을 표시할 페이지를 반환한다.
	 * @return
	 */
	@RequestMapping(value="/undecide", method=RequestMethod.GET)
	public String getUndeciedApprovePage() {
		return "/approve/undecide";
	}
	
	/**
	 * 보류함.
	 * 결재 문서중 결재자가 보류 처리한 결재 문서 목록 페이지
	 * @return
	 */
	@RequestMapping(value="/defer", method=RequestMethod.GET)
	public String getDeferApprovePage() {
		return "/approve/defer";
	}
	
	/**
	 * 완료함.
	 * 로그인 사용자가 작성한 결재 문서중에 결재가 완료된 문서 보관함.
	 * @return
	 */
	@RequestMapping(value="/completed", method=RequestMethod.GET)
	public String getCompletedApprovePage() {
		return "/approve/completed";
	}
	
	/**
	 * 기결함.
	 * 결재자가 이미 결재한 문서 목록 페이지
	 * @return
	 */
	@RequestMapping(value="/decided", method=RequestMethod.GET)
	public String getDecidedApprovePage() {
		return "/approve/decided";
	}
	
	/**
	 * 예결함.
	 * 결재자가 결재해야할 문서 목록 페이지.
	 * 아직 결재자의 결재 순서가 되지 않은 목록 페이지 이다.
	 * @return
	 */
	@RequestMapping(value="/expect", method=RequestMethod.GET)
	public String getExpectApprovePage() {
		return "/approve/expect";
	}
	
	@RequestMapping(value="/manappline", method=RequestMethod.GET)
	public String getManageApproveLinePage() {
		System.out.println("return man_appline.jsp");
		return "/approve/man_appline";
	}
}
