package com.dizzo.bpms.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dizzo.bpms.dao.TaskHistoryDao;
import com.dizzo.bpms.model.TaskHistory;

@Service("taskHistoryService")
public class TaskHistoryServiceImpl implements TaskHistoryService {

	@Autowired
	TaskHistoryDao	dao;
	
	@Override
	public TaskHistory save(TaskHistory taskHistory) {
		System.out.println("save history: " + taskHistory);
		return dao.save(taskHistory);
	}

	@Override
	public List<TaskHistory> listByTaskId(String taskId) {
		return dao.listByTaskId(taskId);
	}

	@Override
	public TaskHistory getByHistoryId(String historyId) {
		return dao.getByHitoryId(historyId);
	}

}
