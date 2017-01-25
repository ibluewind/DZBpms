package com.dizzo.bpms.service;

import java.util.List;

import com.dizzo.bpms.model.Company;

public interface CompanyService {
	
	public List<Company>	list();
	public Company			getById(String id);
	public Company			save(Company company);
	public Company			delete(String id);
	public Company			update(Company company);
}
