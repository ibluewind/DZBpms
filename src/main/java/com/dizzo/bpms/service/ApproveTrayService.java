package com.dizzo.bpms.service;

import java.util.List;

import com.dizzo.bpms.model.ApproveLine;
import com.dizzo.bpms.model.ApproveTray;

public interface ApproveTrayService {

	public ApproveTray			insert(ApproveTray tray);
	public ApproveTray			delete(ApproveTray tray);
	public List<ApproveTray>	listByUserId(String userId);
	public List<ApproveTray>	listByAppId(String appId);
	public List<ApproveTray>	insertAll(List<ApproveTray> trays);
	public List<ApproveTray>	deleteAll(String appId);
	public List<ApproveTray>	resetTray(String appId);
	public ApproveTray			update(ApproveTray tray);
	
	public ApproveTray			getApproveTrayForUser(String userId, String appId);
	
	// user's own tray
	public List<ApproveTray>	undecideTray(String userId);
	public List<ApproveTray>	completedTray(String userId);
	public List<ApproveTray>	finishedTray(String userId);
	public List<ApproveTray>	deferTray(String userId);
	public List<ApproveTray>	expectedTray(String userId);
	public List<ApproveTray>	referTray(String userId);
	public List<ApproveTray>	agreeTray(String userId);
	
	// 결재 승인 처리
	public List<ApproveTray>	submitTray(ApproveLine line);
}
