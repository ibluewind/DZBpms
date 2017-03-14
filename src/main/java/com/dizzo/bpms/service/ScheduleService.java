package com.dizzo.bpms.service;

import java.util.Date;
import java.util.List;

import com.dizzo.bpms.model.Schedule;

public interface ScheduleService {

	public Schedule			get(String id);
	public List<Schedule>	list(Date start, Date end);
	public Schedule			save(Schedule schedule);
	public Schedule			update(Schedule schedule);
	public Schedule			delete(String id);
}
