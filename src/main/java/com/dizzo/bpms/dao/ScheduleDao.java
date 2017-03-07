package com.dizzo.bpms.dao;

import java.util.Date;
import java.util.List;

import com.dizzo.bpms.model.Schedule;

public interface ScheduleDao {
	
	public Schedule			get(String id);
	public List<Schedule> 	list(String userId, Date start, Date end);
	public Schedule			save(Schedule schedule);
	public Schedule			update(Schedule schedule);
	public Schedule			delete(String id);
}