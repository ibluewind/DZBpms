package com.dizzo.bpms.model;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

public class CustomApproveLineRowMapper implements RowMapper<CustomApproveLine> {

	@Override
	public CustomApproveLine mapRow(ResultSet rs, int row) throws SQLException {
		CustomApproveLine	line = new CustomApproveLine();
		
		line.setFormId(rs.getString("formId"));
		line.setFormTitle(rs.getString("formTitle"));
		line.setUserId(rs.getString("userId"));
		line.setUserName(rs.getString("userName"));
		line.setApprovalId(rs.getString("approvalId"));
		line.setApprovalName(rs.getString("approvalName"));
		line.setApprovalPosition(rs.getString("approvalPosition"));
		line.setSeq(rs.getInt("seq"));
		
		return line;
	}

}
