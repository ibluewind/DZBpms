package com.dizzo.bpms.model;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

public class DepartmentRowMapper implements RowMapper<Department> {

	@Override
	public Department mapRow(ResultSet rs, int rowNum) throws SQLException {
		Department	dept = new Department();
		
		dept.setCompanyId(rs.getString("companyid"));
		dept.setpId(rs.getString("pid"));
		dept.setName(rs.getString("name"));
		dept.setDeptId(rs.getString("deptid"));
		dept.setUseYN(rs.getString("useyn"));
		dept.setLastModified(rs.getDate("lastmodified"));
		dept.setCompanyName(rs.getString("companyName"));
		dept.setParentName(rs.getString("parentName"));
		dept.setDepth(rs.getInt("depth"));
		
		return dept;
	}

}
