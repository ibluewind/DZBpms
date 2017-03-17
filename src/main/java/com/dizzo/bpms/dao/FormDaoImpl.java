package com.dizzo.bpms.dao;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;
import java.util.UUID;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BatchPreparedStatementSetter;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.dizzo.bpms.model.Form;
import com.dizzo.bpms.model.FormField;
import com.dizzo.bpms.model.FormFieldRowMapper;
import com.dizzo.bpms.model.FormRowMapper;

@Repository("formDao")
@Transactional
public class FormDaoImpl implements FormDao {
	
	@Autowired
	DataSource	dataSource;

	@Override
	public Form save(Form form) {
		String	query = "insert into form (id, title, comment, created, modified, creator, procDept, postProc) values (?, ?, ?, now(), now(), ?, ?, ?)";
		form.setId(UUID.randomUUID().toString());
		new JdbcTemplate(dataSource).update(query, new Object[] {
			form.getId(),
			form.getTitle(),
			form.getComment(),
			form.getCreator(),
			form.getProcDept(),
			form.getPostProc()
		});
		
		return form;
	}

	@Override
	public List<Form> list() {
		String query = "SELECT f.id,"
					 + " f.title,"
					 + " f.comment,"
					 + " f.created,"
					 + " f.modified,"
					 + " f.creator,"
					 + " concat(u.lastName, u.firstName) 'creatorName',"
					 + " f.useYN,"
					 + " f.procDept,"
					 + " f.postProc,"
					 + " d.name 'procDeptName'"
					 + " FROM form f"
					 + " LEFT JOIN departments d ON f.procDept = d.deptid, users u"
					 + " WHERE u.userId = f.creator";
		List<Form>	forms = new JdbcTemplate(dataSource).query(query, new FormRowMapper());
		return forms;
	}

	@Override
	public Form getById(String id) {
		String query = "SELECT f.id,"
				 + " f.title,"
				 + " f.comment,"
				 + " f.created,"
				 + " f.modified,"
				 + " f.creator,"
				 + " concat(u.lastName, u.firstName) 'creatorName',"
				 + " f.useYN,"
				 + " f.procDept,"
				 + " f.postProc,"
				 + " d.name 'procDeptName'"
				 + " FROM form f"
				 + " LEFT JOIN departments d ON f.procDept = d.deptid, users u"
				 + " WHERE u.userId = f.creator AND f.id=?";
		Form form = new JdbcTemplate(dataSource).queryForObject(query, new Object[] {id}, new FormRowMapper());
		return form;
	}

	@Override
	public Form update(Form form) {
		String	query = "update form set title=?, comment=?, modified=now(), procDept=?, postProc=? where id=?";
		System.out.println("update form: " + form);
		new JdbcTemplate(dataSource).update(query, new Object[] {
				form.getTitle(),
				form.getComment(),
				form.getProcDept(),
				form.getPostProc(),
				form.getId()
		});
		return form;
	}

	@Override
	public Form delete(String id) {
		Form	form = getById(id);
		String	query = "update form set useYN='N' where id=?";
		new JdbcTemplate(dataSource).update(query, new Object[] { id });
		return form;
	}

	@Override
	public void saveFormField(String formId, List<FormField> fields) {
		String	query = "insert into form_field (formId, category, clause, name, value) values (?, ?, ?, ?, ?)";
		
		new JdbcTemplate(dataSource).batchUpdate(query, new BatchPreparedStatementSetter() {
			
			@Override
			public void setValues(PreparedStatement ps, int idx) throws SQLException {
				ps.setString(1, formId);
				ps.setInt(2, fields.get(idx).getCategory());
				ps.setInt(3, fields.get(idx).getClause());
				ps.setString(4, fields.get(idx).getName());
				ps.setString(5, "");
			}
			
			@Override
			public int getBatchSize() {
				return fields.size();
			}
		});
	}

	@Override
	public List<FormField> getFormField(String formId) {
		String	query = "select formId, category, clause, name, value from form_field where formId=?";
		
		return new JdbcTemplate(dataSource).query(query, new Object[] {formId}, new FormFieldRowMapper());
	}

	@Override
	public Form getByAppId(String appId) {
		String query = "SELECT f.id,"
					 + " f.title,"
					 + " f.comment,"
       				 + " f.created,"
       				 + " f.modified,"
       				 + " f.creator,"
	   				 + " concat(u.lastName, u.firstName) 'creatorName',"
       				 + " f.useYN,"
	   				 + " f.procDept,"
       				 + " f.postProc,"
	   				 + " d.name 'procDeptName'"
	   				 + " FROM form f LEFT JOIN departments d ON f.procDept=d.deptid, approve_summary s, users u"
	   				 + " WHERE f.id = s.formId AND f.creator=u.userid AND s.appId=?";
		
		return new JdbcTemplate(dataSource).queryForObject(query, new Object[] { appId }, new FormRowMapper());
	}
}
