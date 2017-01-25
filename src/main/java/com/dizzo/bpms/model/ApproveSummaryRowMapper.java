package com.dizzo.bpms.model;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

public class ApproveSummaryRowMapper implements RowMapper<ApproveSummary> {

	@Override
	public ApproveSummary mapRow(ResultSet rs, int rowNum) throws SQLException {
		ApproveSummary	appSum = new ApproveSummary();
		
		appSum.setAppId(rs.getString("appId"));
		appSum.setFormId(rs.getString("formId"));
		appSum.setTitle(rs.getString("title"));
		appSum.setUserId(rs.getString("userId"));
		appSum.setUserName(rs.getString("userName"));
		appSum.setCreated(rs.getTimestamp("created"));
		appSum.setModified(rs.getTimestamp("modified"));
		appSum.setStatus(rs.getString("status"));
		
		System.out.println("DEBUG : ApproveSummary: " + appSum);
		return appSum;
	}

}
