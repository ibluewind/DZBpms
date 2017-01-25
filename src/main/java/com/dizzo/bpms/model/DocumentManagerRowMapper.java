package com.dizzo.bpms.model;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

public class DocumentManagerRowMapper implements RowMapper<DocumentManager> {

	@Override
	public DocumentManager mapRow(ResultSet rs, int rowNum) throws SQLException {
		DocumentManager	docManager = new DocumentManager();
		
		docManager.setDeptId(rs.getString("deptId"));
		docManager.setUserId(rs.getString("userId"));
		docManager.setUserName(rs.getString("userName"));
		docManager.setType(rs.getString("type"));
		
		return docManager;
	}

}
