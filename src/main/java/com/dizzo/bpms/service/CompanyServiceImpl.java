package com.dizzo.bpms.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dizzo.bpms.dao.CompanyDao;
import com.dizzo.bpms.model.Company;

@Service("companyService")
public class CompanyServiceImpl implements CompanyService {

	@Autowired
	CompanyDao		dao;
	
	@Override
	public List<Company> list() {
		return dao.getAll();
	}

	@Override
	public Company getById(String id) {
		return dao.getById(id);
	}

	@Override
	public Company save(Company company) {
		return dao.save(company);
	}

	@Override
	public Company delete(String id) {
		return dao.delete(id);
	}

	@Override
	public Company update(Company company) {
		return dao.update(company);
	}
}