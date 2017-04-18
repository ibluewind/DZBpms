package com.dizzo.bpms.model;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

public class ChartDataRowMapper implements RowMapper<ChartData> {

	@Override
	public ChartData mapRow(ResultSet rs, int rowNum) throws SQLException {
		ChartData	chart = new ChartData();
		
		chart.setId(rs.getString("id"));
		chart.setName(rs.getString("name"));
		chart.setStatus(rs.getString("status"));
		chart.setCount(rs.getInt("num"));;
		return chart;
	}

}
