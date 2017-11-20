package com.dizzo.bpms.message.dao;

import java.util.List;
import java.util.UUID;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.dizzo.bpms.controller.IndexController;
import com.dizzo.bpms.message.WFMessage;
import com.dizzo.bpms.message.WFMessageRowMapper;

@Repository("messageDao")
public class WFMessageDaoImpl implements WFMessageDao {

	@Autowired
	DataSource		dataSource;
	
	@Override
	public WFMessage insert(WFMessage msg) {
		String query = "INSERT INTO message_queue(id, type, origin, userid, message, readyn, created)"
					 + "  VALUES (?, ?, ?, ?, ?, 'N', now())";
		msg.setId(UUID.randomUUID().toString());
		new JdbcTemplate(dataSource).update(query, new Object[] {
				msg.getId(),
				msg.getType(),
				msg.getOrigin(),
				msg.getUserId(),
				msg.getMessage()
		});
		
		return msg;
	}

	@Override
	public WFMessage getById(String id) {
		String query = "SELECT id,"
					 + " 	   	type,"
					 + " 		origin,"
					 + " 		userid,"
					 + " 		getUserName(userId) userName,"
					 + " 		message,"
					 + " 		readyn,"
					 + "		created"
					 + " FROM message_queue"
					 + " WHERE id = ?";
		return new JdbcTemplate(dataSource).queryForObject(query, new Object[] { id }, new WFMessageRowMapper());
	}

	@Override
	public WFMessage update(WFMessage msg) {
		String	query = "UPDATE message_queue SET readyn=?, message=? WHERE id=?";
		new JdbcTemplate(dataSource).update(query, new Object[] {
			msg.getReadYn(),
			msg.getMessage(),
			msg.getId()
		});
		return msg;
	}

	@Override
	public WFMessage delete(String id) {
		WFMessage	msg = getById(id);
		String	query = "DELETE FROM message_queue WHERE id=?";
		
		new JdbcTemplate(dataSource).update(query, new Object[] { id });
		return msg;
	}

	@Override
	public List<WFMessage> listByUserId(String userId) {
		String query = "SELECT id,"
					 + " type,"
					 + " origin,"
					 + " userid,"
					 + " getUserName(userId) userName,"
					 + " message,"
					 + " readyn,"
					 + " created"
					 + " FROM message_queue"
					 + " WHERE userid = ?"
					 + " ORDER BY created";
		return new JdbcTemplate(dataSource).query(query, new Object[] { userId }, new WFMessageRowMapper());
	}

	@Override
	public void deleteAll(String userId) {
		String query = "DELETE FROM message_queue WHERE userId=?";
		new JdbcTemplate(dataSource).update(query, new Object[] { userId });
	}

	@Override
	public List<WFMessage> listForUnRead(String userId) {
		String query = "SELECT id,"
				 + " type,"
				 + " origin,"
				 + " userid,"
				 + " getUserName(userId) userName,"
				 + " message,"
				 + " readyn,"
				 + " created"
				 + " FROM message_queue"
				 + " WHERE userid = ? AND readyn = 'N'"
				 + " ORDER BY created";
		return new JdbcTemplate(dataSource).query(query, new Object[] { userId }, new WFMessageRowMapper());
	}

	@Override
	public void setReadedAll(String	userId) {
		String	query = "UPDATE message_queue SET readyn='Y' WHERE userId=?";
		
		new JdbcTemplate(dataSource).update(query, new Object[] { userId });
		return;
	}

}
