package com.dizzo.bpms.dao;

import java.util.List;

import com.dizzo.bpms.model.Authority;

public interface AuthorityDao {
	public Authority		save(Authority authority);
	public Authority		getById(String id);
	public List<Authority>	getAll();
	public Authority		update(Authority authority);
	public Authority		delete(String id);
}
