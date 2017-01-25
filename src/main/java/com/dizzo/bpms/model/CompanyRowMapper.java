package com.dizzo.bpms.model;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.jdbc.core.RowMapper;

public class CompanyRowMapper implements RowMapper<Company> {

	static final Logger	log = LoggerFactory.getLogger(CompanyRowMapper.class);
	
	@Override
	public Company mapRow(ResultSet rs, int rowNum) throws SQLException {
		Company	company = new Company();
		
		company.setId(rs.getString("id"));
		company.setName(rs.getString("name"));
		company.setCeo(rs.getString("ceo"));
		
		log.info("Company : {}", company);
		return company;
	}

	
}
