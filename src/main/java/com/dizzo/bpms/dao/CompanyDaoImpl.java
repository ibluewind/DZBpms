package com.dizzo.bpms.dao;

import java.util.List;
import java.util.UUID;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.dizzo.bpms.model.Company;
import com.dizzo.bpms.model.CompanyRowMapper;

@Repository("companyDao")
@Transactional
public class CompanyDaoImpl implements CompanyDao {

	@Autowired
	DataSource		dataSource;
	
	@Override
	public List<Company> getAll() {
		String	query = "select id, name, ceo from company";
		
		return new JdbcTemplate(dataSource).query(query, new CompanyRowMapper());
	}

	@Override
	public Company getById(String id) {
		String	query = "select id, name, ceo from company where id=?";
		JdbcTemplate jdbcTemplate =  new JdbcTemplate(dataSource);
		
		try {
			return jdbcTemplate.queryForObject(query, new Object[] { id }, new CompanyRowMapper());
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}

	@Override
	public Company save(Company company) {
		if (!isUniqueCompany(company))	return update(company);

		company.setId(UUID.randomUUID().toString());
		String	query = "insert into company (id, name, ceo) values (?, ?, ?)";
		new JdbcTemplate(dataSource).update(query, new Object[] {
				company.getId(),
				company.getName(),
				company.getCeo()
		});
		
		return company;
	}

	@Override
	public Company update(Company company) {
		String	query = "update company set name=?, ceo=? where id=?";
		new JdbcTemplate(dataSource).update(query, new Object[] {
				company.getName(),
				company.getCeo(),
				company.getId()
		});
		
		return company;
	}

	@Override
	public Company delete(String id) {
		Company company = getById(id);
		String	query = "delete from company where id=?";
		new JdbcTemplate(dataSource).update(query, new Object[] { id });
		
		return company;
	}

	private boolean isUniqueCompany(Company company) {
		Company	_comp = getById(company.getId());
		
		if (_comp == null)		return true;
		
		return false;
		
	}
}
