package com.dizzo.bpms.model;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

public class FormFieldRowMapper implements RowMapper<FormField> {

	@Override
	public FormField mapRow(ResultSet rs, int rowNum) throws SQLException {
		FormField	field = new FormField();
		
		field.setFormId(rs.getString("formId"));
		field.setCategory(rs.getInt("category"));
		field.setClause(rs.getInt("clause"));
		field.setName(rs.getString("name"));
		field.setValue(rs.getString("value"));
		
		return field;
	}
}
