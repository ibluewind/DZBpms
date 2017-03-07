package com.dizzo.bpms.model;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

public class ScheduleRowMapper implements RowMapper<Schedule> {

	@Override
	public Schedule mapRow(ResultSet rs, int rowNum) throws SQLException {
		Schedule	schedule = new Schedule();
		
		schedule.setId(rs.getString("id"));
		schedule.setTitle(rs.getString("title"));
		schedule.setContent(rs.getString("content"));
		schedule.setStartDate(rs.getTimestamp("start"));
		schedule.setEndDate(rs.getTimestamp("end"));
		schedule.setType(rs.getString("type"));
		schedule.setRefUrl(rs.getString("referUrl"));
		schedule.setUserId(rs.getString("userId"));
		schedule.setUserName(rs.getString("userName"));
		schedule.setDeptName(rs.getString("deptName"));
		schedule.setPositionName(rs.getString("positionName"));
		return schedule;
	}

}
