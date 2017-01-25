package com.dizzo.bpms.model;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.springframework.jdbc.core.RowMapper;

public class UserRowMapper implements RowMapper<User> {

	@SuppressWarnings("serial")
	@Override
	public User mapRow(ResultSet rs, int rowNum) throws SQLException {
		User	user = new User();
		final UserDepartmentPosition	deptPosition = new UserDepartmentPosition();
		
		user.setUserId(rs.getString("userid"));
		user.setFirstName(rs.getString("firstname"));
		user.setLastName(rs.getString("lastname"));
		user.setPassword(rs.getString("password"));
		user.setState(rs.getString("state"));
		
		deptPosition.setUserId(user.getUserId());
		deptPosition.setDeptId(rs.getString("deptid"));
		deptPosition.setDeptName(rs.getString("deptname"));
		deptPosition.setPositionId(rs.getString("positionid"));
		deptPosition.setPositionName(rs.getString("positionname"));
		deptPosition.setPositionType(rs.getString("positiontype"));
		user.setCompanies(new ArrayList<Company>());
		user.setDeptPositions(new ArrayList<UserDepartmentPosition>() {{ add(deptPosition); }});
		user.setUserAuthorities(new ArrayList<UserAuthority>());
		
		return user;
	}

}
