package com.dizzo.bpms.model;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

public class FileAttachRowMapper implements RowMapper<FileAttach>{

	@Override
	public FileAttach mapRow(ResultSet rs, int rowNum) throws SQLException {
		FileAttach	fileAttach = new FileAttach();
		
		fileAttach.setMainId(rs.getString("mainId"));
		fileAttach.setAttachId(rs.getString("attachId"));
		fileAttach.setType(rs.getString("type"));
		fileAttach.setPath(rs.getString("path"));
		fileAttach.setName(rs.getString("name"));
		fileAttach.setOriginName(rs.getString("originName"));
		fileAttach.setModified(rs.getDate("modified"));
		fileAttach.setSize(rs.getLong("size"));
		
		return fileAttach;
	}

	
}
