package com.dizzo.bpms.dao;

import java.util.List;

import com.dizzo.bpms.model.Task;

public interface TaskDao {

	public Task			save(Task task);
	public List<Task>	listByWorker(String userId);
	public List<Task>	listByCreator(String userId);
	public List<Task>	listByDept(String deptId);
	public Task			getById(String taskId);
	public Task 		update(Task task);
	public Task			delete(String taskId);
}
