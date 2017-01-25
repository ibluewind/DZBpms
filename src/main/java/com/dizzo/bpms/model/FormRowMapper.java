package com.dizzo.bpms.model;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

public class FormRowMapper implements RowMapper<Form> {

	@Override
	public Form mapRow(ResultSet rs, int rowNum) throws SQLException {
		Form	form = new Form();
		
		form.setId(rs.getString("id"));
		form.setTitle(rs.getString("title"));
		form.setComment(rs.getString("comment"));
		form.setCreated(rs.getTimestamp("created"));
		form.setModified(rs.getTimestamp("modified"));
		form.setCreator(rs.getString("creator"));
		form.setCreatorName(rs.getString("creatorname"));
		form.setProcDept(rs.getString("procDept"));
		form.setProcDeptName(rs.getString("procDeptName"));
		return form;
	}

	
}
