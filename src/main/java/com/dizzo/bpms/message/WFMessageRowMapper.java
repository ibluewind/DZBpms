package com.dizzo.bpms.message;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

public class WFMessageRowMapper implements RowMapper<WFMessage> {

	@Override
	public WFMessage mapRow(ResultSet rs, int rowNum) throws SQLException {
		WFMessage	message = new WFMessage();
		
		message.setId(rs.getString("id"));
		message.setType(rs.getString("type"));
		message.setOrigin(rs.getString("origin"));
		message.setUserId(rs.getString("userId"));
		message.setMessage(rs.getString("message"));
		message.setReadYn(rs.getString("readYn"));
		message.setCreated(rs.getTimestamp("created"));
		message.setUserName(rs.getString("userName"));
		return message;
	}

}
