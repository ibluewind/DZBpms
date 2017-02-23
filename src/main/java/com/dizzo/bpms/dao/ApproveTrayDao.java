package com.dizzo.bpms.dao;

import java.util.List;

import com.dizzo.bpms.model.ApproveLine;
import com.dizzo.bpms.model.ApproveTray;

public interface ApproveTrayDao {

	public ApproveTray			insert(ApproveTray tray);
	public ApproveTray			delete(ApproveTray tray);
	public List<ApproveTray>	listByUserId(String userId);
	public List<ApproveTray>	listByAppId(String appId);
	public List<ApproveTray>	insertAll(List<ApproveTray> trays);
	public List<ApproveTray>	deleteAll(String appId);
	public List<ApproveTray>	resetTray(String appId);
	public ApproveTray			update(ApproveTray tray);
	
	// 사용자의 특정 결재문서함 정보
	public ApproveTray			getApproveTrayForUser(String userId, String appId);
	
	// user's own tray
	public List<ApproveTray>	undecideTray(String userId);	// 미결함
	public List<ApproveTray>	completedTray(String userId);	// 기결함
	public List<ApproveTray>	finishedTray(String userId);	// 완료함
	public List<ApproveTray>	deferTray(String userId);		// 보류함
	public List<ApproveTray>	expectedTray(String userId);	// 예정함
	public List<ApproveTray>	referTray(String userId);		// 참조함
	public List<ApproveTray>	agreeTray(String userId);		// 합의함
	
	// 결재 승인 처리
	public List<ApproveTray>	submitTray(ApproveLine line);
}
