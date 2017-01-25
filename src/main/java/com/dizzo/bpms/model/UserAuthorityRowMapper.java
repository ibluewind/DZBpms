package com.dizzo.bpms.model;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

public class UserAuthorityRowMapper implements RowMapper<UserAuthority> {

	@Override
	public UserAuthority mapRow(ResultSet rs, int rowNum) throws SQLException {
		UserAuthority	ua = new UserAuthority();
		ua.setUserId(rs.getString("userid"));
		ua.setAuthId(rs.getString("authid"));
		ua.setRoleName(rs.getString("rolename"));
		return ua;
	}

}
