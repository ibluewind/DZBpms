package com.dizzo.bpms.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.dizzo.bpms.dao.UserDao;
import com.dizzo.bpms.model.User;

@Service("userService")
public class UserServiceImpl implements UserService {

	@Autowired
	UserDao		dao;
	
	@Autowired
	PasswordEncoder	passwordEncoder;
	
	@Override
	public List<User> listAll() {
		return dao.getAll();
	}

	@Override
	public List<User> listForDeptId(String deptId) {
		return dao.getListByDeptarment(deptId);
	}

	@Override
	public User getByUserId(String userId) {
		return dao.getByUserId(userId);
	}

	@Override
	public User delete(String userId) {
		return dao.delete(userId);
	}

	@Override
	public User update(User user) {
		user.setPassword(passwordEncoder.encode(user.getPassword()));
		return dao.update(user);
	}

	@Override
	public User save(User user) {
		user.setPassword(passwordEncoder.encode(user.getPassword()));
		return dao.save(user);
	}
}
