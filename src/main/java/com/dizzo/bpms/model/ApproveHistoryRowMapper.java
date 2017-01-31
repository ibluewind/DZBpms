package com.dizzo.bpms.model;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

public class ApproveHistoryRowMapper implements RowMapper<ApproveHistory> {

	@Override
	public ApproveHistory mapRow(ResultSet rs, int rowNum) throws SQLException {
		ApproveHistory	history = new ApproveHistory();
		
		history.setHistoryId(rs.getString("historyId"));
		history.setAppId(rs.getString("appId"));
		history.setComment(rs.getString("comment"));
		history.setCreated(rs.getTime("created"));
		history.setUserId(rs.getString("userId"));
		history.setStatus(rs.getString("status"));
		
		history.setTitle(rs.getString("title"));
		history.setCreatorId(rs.getString("creatorId"));
		history.setCreatorName(rs.getString("creatorName"));
		history.setUserName(rs.getString("userName"));
		
		return history;
	}

}
