package com.dizzo.bpms.service;

import java.util.List;

import com.dizzo.bpms.model.TaskHistory;

public interface TaskHistoryService {
	public TaskHistory	save(TaskHistory taskHistory);
	public List<TaskHistory>	listByTaskId(String taskId);
	public TaskHistory	getByHistoryId(String historyId);
}
