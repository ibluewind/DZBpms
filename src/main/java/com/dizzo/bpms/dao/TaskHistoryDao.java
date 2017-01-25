package com.dizzo.bpms.dao;

import java.util.List;

import com.dizzo.bpms.model.TaskHistory;

public interface TaskHistoryDao {

	public TaskHistory	save(TaskHistory taskHistory);
	public List<TaskHistory> listByTaskId(String taskId);
	public TaskHistory	getByHitoryId(String historyId);
}
