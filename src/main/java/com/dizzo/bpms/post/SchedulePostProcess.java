package com.dizzo.bpms.post;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;

import com.dizzo.bpms.model.Schedule;
import com.dizzo.bpms.model.ScheduleType;
import com.dizzo.bpms.service.ScheduleService;

public class SchedulePostProcess implements PostProcess {
	
	private Schedule	schedule;
	
	@Autowired
	ScheduleService	scheduleService;
	
	public SchedulePostProcess() {
		schedule = new Schedule();
	}

	@Override
	public void setFields(Map<String, String> fields) {
		schedule.setUserId(fields.get("userId"));
		schedule.setStartDate(convertToDate(fields.get("startDate"), true));
		schedule.setEndDate(convertToDate(fields.get("endDate"), false));
		schedule.setType(ScheduleType.VOCATION.getType());
		schedule.setTitle(fields.get("title"));
		schedule.setContent(fields.get("content"));
		schedule.setRefId(fields.get("refId"));
		schedule.setRefUrl(fields.get("refUrl"));
	}

	@Override
	public void process() {
		System.out.println("service: " + scheduleService.toString());
		System.out.println("POST PROCESS: schedule: " + schedule);
		scheduleService.save(schedule);
	}

	private Date convertToDate(String date, boolean am) {
		Date d = new Date();
		DateFormat	format = new SimpleDateFormat("yyyy-MM-dd");
		
		try {
			d = format.parse(date);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		Calendar c = Calendar.getInstance();
		c.setTime(d);
		
		if (am) {
			c.set(Calendar.HOUR_OF_DAY, 0);
			c.set(Calendar.MINUTE, 0);
			c.set(Calendar.SECOND, 0);
		} else {
			c.set(Calendar.HOUR_OF_DAY, 23);
			c.set(Calendar.MINUTE, 59);
			c.set(Calendar.SECOND, 59);
		}
		
		d = c.getTime();
		return d;
	}
}
