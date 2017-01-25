package com.dizzo.bpms.model;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

public class PositionRowMapper implements RowMapper<Position> {

	@Override
	public Position mapRow(ResultSet rs, int rowNum) throws SQLException {
		Position	position = new Position();
		
		position.setId(rs.getString("id"));
		position.setName(rs.getString("name"));
		position.setType(rs.getString("type"));
		position.setSeq(rs.getInt("seq"));
		return position;
	}

	
}
