package com.dizzo.bpms.model;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

public class CustomApproveLineSummaryRowMapper implements RowMapper<CustomApproveLineSummary> {

	@Override
	public CustomApproveLineSummary mapRow(ResultSet rs, int rowNum) throws SQLException {
		CustomApproveLineSummary	summary = new CustomApproveLineSummary();
		
		summary.setLineId(rs.getString("lineId"));
		summary.setFormId(rs.getString("formId"));
		summary.setFormTitle(rs.getString("formTitle"));
		summary.setTitle(rs.getString("title"));
		summary.setUserId(rs.getString("userId"));
		summary.setUserName(rs.getString("userName"));
		summary.setModified(rs.getTimestamp("modified"));
		
		return summary;
	}

}
