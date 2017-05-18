package com.dizzo.bpms.controller;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@Scope("session")
@RequestMapping("/home")
public class HomeController {

	@RequestMapping(value="/task/list", method=RequestMethod.GET)
	public String getTaskListPage() {
		return "/task/task_list";
	}
	
	@RequestMapping(value="/task/new", method=RequestMethod.GET)
	public String getNewTaskPage() {
		return "/task/new_task";
	}
	
	@RequestMapping(value="/task/view", method=RequestMethod.GET)
	public String getEditTaskPage() {
		return "/task/view_task";
	}
	
	@RequestMapping(value="/task/delayed", method=RequestMethod.GET)
	public String getDelayedTaskPage() {
		return "/task/delayed_task";
	}
	
	@RequestMapping(value="/task/expect", method=RequestMethod.GET)
	public String getExceptTask() {
		return "/task/expect_task";
	}
	
	@RequestMapping(value="/dashboard", method=RequestMethod.GET)
	public String getDashboardPage() {
		return "/home/dashboard";
	}
	
	@RequestMapping(value="/report", method=RequestMethod.GET)
	public String getReportPage() {
		return "/home/report";
	}
	
	@RequestMapping(value="/regist_project", method=RequestMethod.GET)
	public String getRegistProjectPage() {
		return "/project/regist_project";
	}
	
	@RequestMapping(value="/forms/vocation", method=RequestMethod.GET)
	public String getVocationFormPage() {
		return "/forms/vocation_form";
	}
}
