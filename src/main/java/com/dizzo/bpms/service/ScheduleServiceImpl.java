package com.dizzo.bpms.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dizzo.bpms.dao.ScheduleDao;
import com.dizzo.bpms.model.Schedule;

@Service("scheduleService")
public class ScheduleServiceImpl implements ScheduleService {

	@Autowired
	ScheduleDao		dao;
	
	@Override
	public Schedule get(String id) {
		return dao.get(id);
	}

	@Override
	public List<Schedule> list(String userId, Date start, Date end) {
		return dao.list(userId, start, end);
	}

	@Override
	public Schedule save(Schedule schedule) {
		return dao.save(schedule);
	}

	@Override
	public Schedule update(Schedule schedule) {
		return dao.update(schedule);
	}

	@Override
	public Schedule delete(String id) {
		return dao.delete(id);
	}

}
