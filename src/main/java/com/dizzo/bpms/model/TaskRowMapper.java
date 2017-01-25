package com.dizzo.bpms.model;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

public class TaskRowMapper implements RowMapper<Task> {

	@Override
	public Task mapRow(ResultSet rs, int rowNum) throws SQLException {
		Task	task = new Task();
		
		task.setTaskId(rs.getString("taskId"));
		task.setUserId(rs.getString("userId"));
		task.setUserName(rs.getString("userName"));
		task.setWorkerId(rs.getString("workerId"));
		task.setWorkerName(rs.getString("workerName"));
		task.setCreateDate(rs.getDate("createDate"));
		task.setEndDate(rs.getDate("endDate"));
		task.setStatus(rs.getString("status"));
		task.setPriority(rs.getString("priority"));
		task.setTargetRate(rs.getInt("targetRate"));
		task.setCurrentRate(rs.getInt("currentRate"));
		task.setOpened(rs.getString("opened"));
		task.setTitle(rs.getString("title"));
		task.setContent(rs.getString("content"));
		
		return task;
	}

}
