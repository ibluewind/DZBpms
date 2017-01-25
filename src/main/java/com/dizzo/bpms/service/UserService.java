package com.dizzo.bpms.service;

import java.util.List;

import com.dizzo.bpms.model.User;

public interface UserService {

	public List<User>	listAll();
	public List<User>	listForDeptId(String deptId);
	public User			getByUserId(String userId);
	public User			delete(String id);
	public User			update(User user);
	public User			save(User user);
}
