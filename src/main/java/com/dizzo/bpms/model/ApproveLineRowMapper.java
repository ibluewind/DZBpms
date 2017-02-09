package com.dizzo.bpms.model;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

public class ApproveLineRowMapper implements RowMapper<ApproveLine> {

	@Override
	public ApproveLine mapRow(ResultSet rs, int rowNum) throws SQLException {
		ApproveLine	appLine = new ApproveLine();
		
		appLine.setLineId(rs.getString("lineId"));
		appLine.setAppId(rs.getString("appId"));
		appLine.setApprovalId(rs.getString("userId"));
		appLine.setApprovalName(rs.getString("userName"));
		appLine.setApprovalPosition(rs.getString("positionName"));
		appLine.setStatus(rs.getString("status"));
		appLine.setModified(rs.getTimestamp("modified"));
		appLine.setSeq(rowNum);
		appLine.setType(rs.getString("type"));
		return appLine;
	}

}
