package com.dizzo.bpms.dao;

import java.util.List;

import com.dizzo.bpms.model.Task;
import com.dizzo.bpms.model.User;

public interface TaskDao {

	public Task			save(Task task);
	public List<Task>	listByWorker(String userId);
	public List<Task>	listByCreator(String userId);
	public List<Task>	listByDept(String deptId);
	public List<Task>	listByAuthority(User user);
	public Task			getById(String taskId);
	public Task 		update(Task task);
	public Task			delete(String taskId);
}
