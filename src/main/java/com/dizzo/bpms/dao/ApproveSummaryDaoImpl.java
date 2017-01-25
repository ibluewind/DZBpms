package com.dizzo.bpms.dao;

import java.util.List;
import java.util.UUID;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.dizzo.bpms.model.ApproveSummary;
import com.dizzo.bpms.model.ApproveSummaryRowMapper;

@Repository("approveSummaryDao")
public class ApproveSummaryDaoImpl implements ApproveSummaryDao {

	@Autowired
	DataSource	dataSource;
	
	@Override
	public ApproveSummary insert(ApproveSummary summary) {
		String	query = "insert into approve_summary (appId, formId, title, userId, created, modified, status) values (?, ?, ?, ?, now(), now(), ?)";
		summary.setAppId(UUID.randomUUID().toString());
		new JdbcTemplate(dataSource).update(query, new Object[] {
			summary.getAppId(),
			summary.getFormId(),
			summary.getTitle(),
			summary.getUserId(),
			summary.getStatus()
		});
		return summary;
	}

	@Override
	public ApproveSummary getByAppId(String appId) {
		String query = "SELECT s.appId,"
				     + " s.formId,"
				     + " s.title,"
				     + " s.userId,"
					 + " concat(u.lastName, u.firstName) 'userName',"
				     + " s.created,"
				     + " s.modified,"
				     + " s.status"
				+ " FROM approve_summary s, users u"
				+ " WHERE s.appId = ? and s.userId = u.userid";
		
		return new JdbcTemplate(dataSource).queryForObject(query, new Object[] {appId}, new ApproveSummaryRowMapper());
	}

	@Override
	public ApproveSummary update(ApproveSummary summary) {
		String query = "update approve_summary set title=?, modified=now(), status=? where appId=?";
		new JdbcTemplate(dataSource).update(query, new Object[] {
			summary.getTitle(),
			summary.getStatus(),
			summary.getAppId()
		});
		return summary;
	}

	@Override
	public ApproveSummary delete(String appId) {
		String query = "delete from approve_summary where appId=?";
		ApproveSummary	summary = getByAppId(appId);
		new JdbcTemplate(dataSource).update(query, new Object[] { appId });
		return summary;
	}

	@Override
	public List<ApproveSummary> list(String userId) {
		String query = "SELECT s.appId,"
				     + " s.formId,"
				     + " s.title,"
				     + " s.userId,"
					 + " concat(u.lastName, u.firstName) 'userName',"
				     + " s.created,"
				     + " s.modified,"
				     + " s.status"
				+ " FROM approve_summary s, users u"
			+ " WHERE s.userid=? and s.userId = u.userid";
		return new JdbcTemplate(dataSource).query(query, new Object[] {userId}, new ApproveSummaryRowMapper());
	}

}
