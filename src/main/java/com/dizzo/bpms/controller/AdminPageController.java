package com.dizzo.bpms.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.dizzo.bpms.model.Company;
import com.dizzo.bpms.model.User;
import com.dizzo.bpms.service.CompanyService;
import com.dizzo.bpms.service.UserService;

@Controller
@RequestMapping("/admin")
public class AdminPageController {

	@Autowired
	UserService		userService;
	
	@Autowired
	CompanyService	companyService;
	
	@RequestMapping(value="/dept", method=RequestMethod.GET)
	public String adminDepartmentDashboard(ModelMap model) {
		User	user = userService.getByUserId(getPrincipal());
		Company	company = null;
		
		if (user.getCompanies().size() == 0)
			company = new Company("d4d8448b-aaea-11e6-8cda-d067e51fd415", "디지틀조선일보", "김찬");
		else
			company = user.getCompanies().get(0);
		
		model.addAttribute("company", company);		// TODO 관리자가 소속된 회사를 추가한다.
		model.addAttribute("companies", companyService.list());
		return "/admin/admin_dept";
	}
	
	@RequestMapping(value="/dept/edit", method=RequestMethod.GET)
	public String editDepartment() {
		return "/admin/regist_dept";
	}
	
	@RequestMapping(value="/dept/add", method=RequestMethod.GET)
	public String addDepartment() {
		return "/admin/regist_dept";
	}
	
	@RequestMapping(value="/users", method=RequestMethod.GET)
	public String userDashBoard(ModelMap model) {
		User	user = userService.getByUserId(getPrincipal());
		Company	company = null;
		
		if (user.getCompanies().size() == 0)
			company = new Company("d4d8448b-aaea-11e6-8cda-d067e51fd415", "디지틀조선일보", "김찬");
		else
			company = user.getCompanies().get(0);
		
		model.addAttribute("company", company);		// TODO 관리자가 소속된 회사를 추가한다.
		model.addAttribute("companies", companyService.list());
		return "/admin/admin_users";
	}
	
	@RequestMapping(value="/user/list", method=RequestMethod.GET)
	public String userList() {
		return "/admin/user_list";
	}
	
	@RequestMapping(value="/user/add", method=RequestMethod.GET)
	public String registerUser() {
		return "/admin/regist_user";
	}
	
	@RequestMapping(value="/user/edit", method=RequestMethod.GET)
	public String editUser() {
		return "/admin/regist_user";
	}
	
	@RequestMapping(value="/authority")
	public String getAuthPage() {
		return "/admin/admin_authcode";
	}
	
	@RequestMapping(value="/position")
	public String getPositionPage() {
		return "/admin/admin_position";
	}
	
	@RequestMapping(value="/auth/regist_auth", method=RequestMethod.GET)
	public String getRegistAuthorityPage() {
		return "/common/partial/regist_auth";
	}
	
	@RequestMapping(value="/position/regist_position", method=RequestMethod.GET)
	public String getRegistPositionPage() {
		return "/common/partial/regist_position";
	}
	
	@RequestMapping(value="/company/", method=RequestMethod.GET)
	public String getCompanyPage() {
		return "/admin/admin_company";
	}
	
	@RequestMapping(value="/company/regist_company", method=RequestMethod.GET)
	public String getRegistCompanyPage() {
		return "/common/partial/regist_company";
	}
	
	@RequestMapping(value="/form", method=RequestMethod.GET)
	public String getAdminFormPage(ModelMap model) {
		User	user = userService.getByUserId(getPrincipal());
		Company	company = null;
		
		if (user.getCompanies().size() == 0)
			company = new Company("d4d8448b-aaea-11e6-8cda-d067e51fd415", "디지틀조선일보", "김찬");
		else
			company = user.getCompanies().get(0);
		
		model.addAttribute("company", company);
		return "/admin/admin_form";
	}
	@RequestMapping(value="/form/regist", method=RequestMethod.GET)
	public String getCreateFormPage() {
		return "/admin/form/regist_form";
	}
	
	@RequestMapping(value="/form/list", method=RequestMethod.GET)
	public String getListFormPage() {
		return "/admin/form/list_form";
	}
	
	@RequestMapping(value="/form/edit", method=RequestMethod.GET)
	public String editFormPage() {
		return "/admin/form/regist_form";
	}
	
	private String getPrincipal() {
		return IndexController.getPrincipal();
	}
}
