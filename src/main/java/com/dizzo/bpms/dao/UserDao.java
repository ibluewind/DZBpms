package com.dizzo.bpms.dao;

import java.util.List;

import com.dizzo.bpms.model.User;

public interface UserDao {
	public User		save(User user);
	public User		update(User user);
	public User		delete(String id);
	public User		getByUserId(String userId);
	public List<User>	getAll();
	public List<User>	getListByDeptarment(String deptId);
	public List<User>	getListByCompany(String companyId);
}
