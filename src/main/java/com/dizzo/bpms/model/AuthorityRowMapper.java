package com.dizzo.bpms.model;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.jdbc.core.RowMapper;

public class AuthorityRowMapper implements RowMapper<Authority> {

	static final	Logger	log = LoggerFactory.getLogger(AuthorityRowMapper.class);
	
	@Override
	public Authority mapRow(ResultSet rs, int rowNum) throws SQLException {
		Authority	auth = new Authority();
		
		auth.setAuthId(rs.getString("id"));
		auth.setRoleName(rs.getString("rolename"));
		auth.setComment(rs.getString("comment"));
		
		log.info("Authority : {}", auth);
		return auth;
	}

	
}
