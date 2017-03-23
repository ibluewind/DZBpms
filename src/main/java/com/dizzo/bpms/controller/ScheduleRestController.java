package com.dizzo.bpms.controller;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PathVariable;
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
	public List<Schedule> list(@RequestParam long start, @RequestParam long end) throws ParseException {
		return scheduleService.list(new Date(start), new Date(end));
	}
	
	@RequestMapping(method=RequestMethod.POST)
	public Schedule save(@RequestBody Schedule schedule) {
		schedule.setUserId(IndexController.getPrincipal());
		
		System.out.println("DEBUG: schedule: " + schedule);
		return scheduleService.save(schedule);
	}
	
	@RequestMapping(value="/{id}", method=RequestMethod.GET)
	public Schedule get(@PathVariable String id) {
		return scheduleService.get(id);
	}
	
	@RequestMapping(method=RequestMethod.PUT)
	public Schedule update(@RequestBody Schedule schedule) {
		System.out.println("DEBUG: update scheduel " + schedule);
		return scheduleService.update(schedule);
	}
	
	@RequestMapping(value="/{id}", method=RequestMethod.DELETE)
	public Schedule delete(@PathVariable String id) {
		System.out.println("DEBUG: delete schedule " + id);
		return scheduleService.delete(id);
	}
}
