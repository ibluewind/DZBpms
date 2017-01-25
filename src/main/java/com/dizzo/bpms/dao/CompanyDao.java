package com.dizzo.bpms.dao;

import java.util.List;

import com.dizzo.bpms.model.Company;

public interface CompanyDao {

	public List<Company>	getAll();
	public Company			getById(String id);
	public Company			save(Company company);
	public Company			update(Company company);
	public Company			delete(String id);
}
