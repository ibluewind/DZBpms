package com.dizzo.bpms.model;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

public class UserDepartmentPositionRowMapper implements RowMapper<UserDepartmentPosition> {

	@Override
	public UserDepartmentPosition mapRow(ResultSet rs, int rowNum) throws SQLException {
		UserDepartmentPosition	udp = new UserDepartmentPosition();
		udp.setUserId(rs.getString("userid"));
		udp.setDeptId(rs.getString("deptid"));
		udp.setPositionId(rs.getString("positionid"));
		udp.setDeptName(rs.getString("deptname"));
		udp.setDeptPid(rs.getString("deptpid"));
		udp.setPositionName(rs.getString("positionname"));
		udp.setPositionType(rs.getString("positiontype"));
		return udp;
	}

	
}
