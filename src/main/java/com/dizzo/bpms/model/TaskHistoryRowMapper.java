package com.dizzo.bpms.model;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

public class TaskHistoryRowMapper implements RowMapper<TaskHistory> {

	@Override
	public TaskHistory mapRow(ResultSet rs, int rowNum) throws SQLException {
		TaskHistory	history = new TaskHistory();
		
		history.setHistoryId(rs.getString("historyId"));
		history.setTaskId(rs.getString("taskId"));
		history.setComment(rs.getString("comment"));
		history.setCreated(rs.getTimestamp("created"));
		history.setCreator(rs.getString("creator"));
		history.setCreatorName(rs.getString("creatorName"));
		history.setWorker(rs.getString("worker"));
		history.setWorkerName(rs.getString("workerName"));
		history.setAction(rs.getString("action"));
		history.setProcRate(rs.getInt("procRate"));
		
		return history;
	}

}
