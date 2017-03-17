package com.dizzo.bpms.controller;

import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.dizzo.bpms.model.User;
import com.dizzo.bpms.service.UserService;

@Controller
@RequestMapping("/")
public class IndexController {
	@Autowired
	UserService	userService;

	@RequestMapping(method=RequestMethod.GET)
	public String getIndexPage() {
		if (getPrincipal() == null)
			return "redirect:/login";
		return "/home/index";
	}
	
	@RequestMapping(value="/login", method=RequestMethod.GET)
	public String getLoginPage() {
		HttpServletRequest	req = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();

		Enumeration<String> names = req.getHeaderNames();
		while (names.hasMoreElements()) {
			String name = names.nextElement();
			System.out.println("HEADER[" + name + "] : " + req.getHeader(name));
		}
		
		String	ip = req.getHeader("X-FORWARDED-FOR");
		if (ip == null)
			ip = req.getRemoteAddr();
		
		System.out.println("Connect IP : " + ip);
		return "/login";
	}
	
	@RequestMapping(value="/logout", method=RequestMethod.GET)
	public String logoutPage(HttpServletRequest request, HttpServletResponse response) {
		Authentication	auth = SecurityContextHolder.getContext().getAuthentication();
		
		if (auth != null)
			new SecurityContextLogoutHandler().logout(request, response, auth);
		
		return "redirect:/login?logout";
	}
	
	@RequestMapping(value="/home", method=RequestMethod.GET)
	public String getHomePage(ModelMap model) {
		User user = userService.getByUserId(getPrincipal());
		model.addAttribute("user", user);
		model.addAttribute("company", user.getCompanies().get(0));
		return "/home/index";
	}
	
	@RequestMapping(value="/Access_Denied", method=RequestMethod.GET)
	public String getAccessDeniedPage() {
		return "/accessDenied";
	}
	
	@RequestMapping(value="/admin", method=RequestMethod.GET)
	public String getAdminPage() {
		return "/admin/admin";
	}
	
	@RequestMapping(value="/home/peekcalendar", method=RequestMethod.GET)
	public String getPeekCalendarpage() {
		return "/home/partial/peekcalendar";
	}
	
	@RequestMapping(value="/home/registschedule", method=RequestMethod.GET)
	public String getRegistSchedulePopoverPage() {
		return "/home/partial/registschedule";
	}
	/*
	 * MODAL Windows
	 */
	@RequestMapping(value="/common/select_dept_modal", method=RequestMethod.GET)
	public String getSelectDeptModalPartialPage() {
		return "/common/partial/select_dept_modal";
	}
	
	@RequestMapping(value="/common/confirm_modal", method=RequestMethod.GET)
	public String getConfirmModalPartialPage() {
		return "/common/partial/confirm_modal";
	}
	
	@RequestMapping(value="/common/department_modal", method=RequestMethod.GET)
	public String getDepartmentSelectModalPartialPage() {
		return "/common/partial/department_select_modal";
	}
	
	@RequestMapping(value="/common/position_modal", method=RequestMethod.GET)
	public String getPositionSelectModalPartialPage() {
		return "/common/partial/position_select_modal";
	}
	
	@RequestMapping(value="/common/select_user", method=RequestMethod.GET)
	public String getSelectUserModalPartialPage() {
		return "/common/partial/select_user_modal";
	}
	
	@RequestMapping(value="/common/warning_modal", method=RequestMethod.GET)
	public String getWarningModalWindowPage() {
		return "/common/partial/warning_modal";
	}
	
	@RequestMapping(value="/common/comment_modal", method=RequestMethod.GET)
	public String getCommentModalWindowPage() {
		return "/common/partial/comment_modal";
	}
	
	@RequestMapping(value="/common/fileupload", method=RequestMethod.GET)
	public String getFileUploadTemplate() {
		return "/common/partial/fileupload";
	}
	
	@RequestMapping(value="/task_history_modal", method=RequestMethod.GET)
	public String getTaskHistoryDetailModalPage() {
		return "/task/task_history_modal";
	}
	
	public static String getPrincipal() {
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
