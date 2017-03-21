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
		schedule.setRefId(rs.getString("refId"));
		schedule.setUserId(rs.getString("userId"));
		schedule.setUserName(rs.getString("userName"));
		return schedule;
	}

}
