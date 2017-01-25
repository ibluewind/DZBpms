package com.dizzo.bpms.model;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

public class ApproveTrayRowMapper implements RowMapper<ApproveTray> {

	@Override
	public ApproveTray mapRow(ResultSet rs, int rowNum) throws SQLException {
		ApproveTray	tray = new ApproveTray();
		
		tray.setAppId(rs.getString("appId"));
		tray.setAppTitle(rs.getString("appTitle"));
		tray.setUserId(rs.getString("userId"));
		tray.setCreator(rs.getString("creator"));
		tray.setCreatorName(rs.getString("creatorName"));
		tray.setCreated(rs.getTimestamp("created"));
		tray.setModified(rs.getTimestamp("modified"));
		tray.setType(rs.getString("type"));
		return tray;
	}

}
