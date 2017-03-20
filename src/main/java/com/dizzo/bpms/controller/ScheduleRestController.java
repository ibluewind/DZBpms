package com.dizzo.bpms.controller;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.dizzo.bpms.model.Schedule;
import com.dizzo.bpms.service.ScheduleService;

@CrossOrigin(origins="*", maxAge=3600)
@RestController
@RequestMapping("/rest/schedule")
public class ScheduleRestController {

	@Autowired
	ScheduleService	scheduleService;
	
	@RequestMapping(method=RequestMethod.GET)
	public List<Schedule> list(@RequestParam String start, @RequestParam String end) throws ParseException {
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss");
		
		return scheduleService.list(format.parse(start), format.parse(end));
	}
	
	@RequestMapping(method=RequestMethod.POST)
	public Schedule save(@RequestBody Schedule schedule) {
		schedule.setUserId(IndexController.getPrincipal());
		return scheduleService.save(schedule);
	}
}
