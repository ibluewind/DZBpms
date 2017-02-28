package com.dizzo.bpms.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping(value="/home/calendar")
public class CalendarController {

	@RequestMapping(value="", method=RequestMethod.GET)
	public String getCalendarPage() {
		return "/home/partial/calendar";
	}
}
