package com.dizzo.bpms.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dizzo.bpms.dao.TaskDao;
import com.dizzo.bpms.model.Task;

@Service("taskService")
public class TaskServiceImpl implements TaskService {

	@Autowired
	TaskDao		dao;
	
	@Override
	public Task save(Task task) {
		return dao.save(task);
	}

	@Override
	public List<Task> listByWorker(String userId) {
		return dao.listByWorker(userId);
	}

	@Override
	public List<Task> listByCreator(String userId) {
		return dao.listByCreator(userId);
	}

	@Override
	public List<Task> listByDept(String deptId) {
		return dao.listByDept(deptId);
	}

	@Override
	public Task getById(String taskId) {
		return dao.getById(taskId);
	}

	@Override
	public Task upate(Task task) {
		return dao.update(task);
	}

	@Override
	public Task delete(String taskId) {
		return dao.delete(taskId);
	}
}