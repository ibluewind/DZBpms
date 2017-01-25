package com.dizzo.bpms.dao;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BatchPreparedStatementSetter;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.dizzo.bpms.model.FormField;
import com.dizzo.bpms.model.FormFieldRowMapper;

@Repository("formFieldDao")
public class ApproveFormFieldDaoImpl implements ApproveFormFieldDao {

	@Autowired
	DataSource		dataSource;
	
	@Override
	public List<FormField> insert(String appId, String formId, List<FormField> formFields) {
		String query = "insert into approve_form_field (appId, formId, category, clause, name, value) "
				+ "values (?, ?, ?, ?, ?, ?)";
		
		new JdbcTemplate(dataSource).batchUpdate(query, new BatchPreparedStatementSetter() {
			
			@Override
			public void setValues(PreparedStatement ps, int idx) throws SQLException {
				ps.setString(1, appId);
				ps.setString(2, formId);
				ps.setInt(3, formFields.get(idx).getCategory());
				ps.setInt(4, formFields.get(idx).getClause());
				ps.setString(5, formFields.get(idx).getName());
				ps.setString(6, formFields.get(idx).getValue());
			}
			
			@Override
			public int getBatchSize() {
				return formFields.size();
			}
		});
		
		return formFields;
	}

	@Override
	public List<FormField> update(String appId, List<FormField> formFields) {
		String query = "update approve_form_field set category=?, clause=?, name=?, value=? where appId=?";
		
		new JdbcTemplate(dataSource).batchUpdate(query, new BatchPreparedStatementSetter() {
			
			@Override
			public void setValues(PreparedStatement ps, int idx) throws SQLException {
				ps.setInt(1, formFields.get(idx).getCategory());
				ps.setInt(2, formFields.get(idx).getClause());
				ps.setString(3, formFields.get(idx).getName());
				ps.setString(4, formFields.get(idx).getValue());
				ps.setString(5, appId);
			}
			
			@Override
			public int getBatchSize() {
				return formFields.size();
			}
		});
		return formFields;
	}

	@Override
	public String delete(String appId) {
		String	query = "delete from approve_form_field where appId=?";
		new JdbcTemplate(dataSource).update(query, new Object[] { appId });
		return appId;
	}

	@Override
	public List<FormField> getFormFieldsByAppId(String appId) {
		String query = "select appId, formId, category, clause, name, value from approve_form_field where appId=?";
		return new JdbcTemplate(dataSource).query(query, new Object[] { appId }, new FormFieldRowMapper());
	}

}
