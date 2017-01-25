package com.dizzo.bpms.service;

import java.util.List;

import com.dizzo.bpms.model.Authority;

public interface AuthorityService {
	public List<Authority>	list();
	public Authority	save(Authority authority);
	public Authority	update(Authority authority);
	public Authority	delete(String id);
	public Authority	getById(String id);
}
