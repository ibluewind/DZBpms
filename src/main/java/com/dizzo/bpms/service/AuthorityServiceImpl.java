package com.dizzo.bpms.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dizzo.bpms.dao.AuthorityDao;
import com.dizzo.bpms.model.Authority;

@Service("authorityService")
public class AuthorityServiceImpl implements AuthorityService {

	@Autowired
	AuthorityDao		dao;
	
	@Override
	public List<Authority> list() {
		return dao.getAll();
	}

	@Override
	public Authority save(Authority authority) {
		return dao.save(authority);
	}

	@Override
	public Authority update(Authority authority) {
		return dao.update(authority);
	}

	@Override
	public Authority delete(String id) {
		return dao.delete(id);
	}

	@Override
	public Authority getById(String id) {
		return dao.getById(id);
	}

}
