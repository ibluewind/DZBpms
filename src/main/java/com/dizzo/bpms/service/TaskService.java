package com.dizzo.bpms.service;

import java.util.List;

import com.dizzo.bpms.model.Task;

public interface TaskService {

	public Task	save(Task task);
	public List<Task>	listByWorker(String userId);
	public List<Task>	listByCreator(String userId);
	public List<Task>	listByDept(String deptId);
	public Task			getById(String taskId);
	public Task			upate(Task task);
	public Task			delete(String taskId);
}
