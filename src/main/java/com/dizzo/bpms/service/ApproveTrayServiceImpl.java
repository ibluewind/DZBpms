package com.dizzo.bpms.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dizzo.bpms.dao.ApproveTrayDao;
import com.dizzo.bpms.model.ApproveTray;

@Service("approveTrayService")
public class ApproveTrayServiceImpl implements ApproveTrayService {

	@Autowired
	ApproveTrayDao		dao;
	
	@Override
	public ApproveTray insert(ApproveTray tray) {
		return dao.insert(tray);
	}

	@Override
	public ApproveTray delete(ApproveTray tray) {
		return dao.delete(tray);
	}

	@Override
	public List<ApproveTray> listByUserId(String userId) {
		return dao.listByUserId(userId);
	}

	@Override
	public List<ApproveTray> listByAppId(String appId) {
		return dao.listByAppId(appId);
	}

	@Override
	public List<ApproveTray> insertAll(List<ApproveTray> trays) {
		return dao.insertAll(trays);
	}

	@Override
	public List<ApproveTray> deleteAll(String appId) {
		return dao.deleteAll(appId);
	}

	@Override
	public List<ApproveTray> resetTray(String appId) {
		return dao.resetTray(appId);
	}

	@Override
	public ApproveTray update(ApproveTray tray) {
		return dao.update(tray);
	}

	@Override
	public ApproveTray getApproveTrayForUser(String userId, String appId) {
		return dao.getApproveTrayForUser(userId, appId);
	}

	@Override
	public List<ApproveTray> undecideTray(String userId) {
		return dao.undecideTray(userId);
	}

	@Override
	public List<ApproveTray> completedTray(String userId) {
		return dao.completedTray(userId);
	}

	@Override
	public List<ApproveTray> deferTray(String userId) {
		return dao.deferTray(userId);
	}

	@Override
	public List<ApproveTray> expectedTray(String userId) {
		return dao.expectedTray(userId);
	}

}
