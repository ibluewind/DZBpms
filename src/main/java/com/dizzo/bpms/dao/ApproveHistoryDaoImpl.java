package com.dizzo.bpms.dao;

import java.util.List;
import java.util.UUID;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.dizzo.bpms.model.ApproveHistory;
import com.dizzo.bpms.model.ApproveHistoryRowMapper;

@Repository("approveHistoryDao")
public class ApproveHistoryDaoImpl implements ApproveHistoryDao {

	@Autowired
	DataSource		dataSource;
	
	@Override
	public ApproveHistory insert(ApproveHistory history) {
		String	query = "INSERT INTO approve_history(historyId, appId, comment, created, userId, status)"
					  + " VALUES (?, ?, ?, now(), ?, ?)";
		
		history.setHistoryId(UUID.randomUUID().toString());
		
		new JdbcTemplate(dataSource).update(query, new Object[] {
			history.getHistoryId(),
			history.getAppId(),
			history.getComment(),
			history.getUserId(),
			history.getStatus()
		});
		
		return history;
	}

	@Override
	public ApproveHistory update(ApproveHistory history) {
		String	query = "UPDATE approve_history SET comment=?, created=now(), status=?"
					  + " WHERE historyId=?";
		
		new JdbcTemplate(dataSource).update(query, new Object[] {
			history.getComment(),
			history.getStatus()
		});
		
		return history;
	}

	@Override
	public ApproveHistory delete(String historyId) {
		ApproveHistory	history = getById(historyId);
		String	query = "DELETE FROM approve_history WHERE historyId=?";
		
		new JdbcTemplate(dataSource).update(query, new Object[] {historyId});
		return history;
	}

	@Override
	public ApproveHistory getById(String id) {
		String query = "SELECT h.historyId,"
					 + " h.appId,"
					 + " h.comment,"
					 + " h.created,"
					 + " h.userId,"
					 + " h.status,"
					 +" s.title,"
					 + " c.userid 'creatorId',"
					 + " concat(c.lastname, c.firstname) 'creatorName',"
					 + " concat(u.lastName, u.firstName) 'userName'"
					 + " FROM approve_history h,"
					 + " approve_summary s,"
					 + " users u,"
					 + "users c"
					 + " WHERE     h.historyId = ?"
					 + " AND s.appid = h.appId"
					 + " AND u.userid = h.userId"
					 + " AND s.userId = c.userid";
		
		return new JdbcTemplate(dataSource).queryForObject(query, new Object[] {id}, new ApproveHistoryRowMapper());
	}

	@Override
	public List<ApproveHistory> getListByApproveId(String appId) {
		String query = "SELECT h.historyId,"
				 + " h.appId,"
				 + " h.comment,"
				 + " h.created,"
				 + " h.userId,"
				 + " h.status,"
				 +" s.title,"
				 + " c.userid 'creatorId',"
				 + " concat(c.lastname, c.firstname) 'creatorName',"
				 + " concat(u.lastName, u.firstName) 'userName'"
				 + " FROM approve_history h,"
				 + " approve_summary s,"
				 + " users u,"
				 + "users c"
				 + " WHERE     h.appId = ?"
				 + " AND s.appid = h.appId"
				 + " AND u.userid = h.userId"
				 + " AND s.userId = c.userid";
		
		return new JdbcTemplate(dataSource).query(query, new Object[] {appId}, new ApproveHistoryRowMapper());
	}
}