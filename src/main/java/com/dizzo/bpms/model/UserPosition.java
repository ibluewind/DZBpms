package com.dizzo.bpms.model;

public enum UserPosition {
	WORKER("사원"),
	DEPUTY("대리"),
	SECTION_TREAT("과장대우"),
	SECTION("과장"),
	DEPUTY_HEAD_TREAT("차장대우"),
	DEPUTY_HEAD("차장"),
	DEPARTMENT_HEAD_TREAT("부장대우"),
	DEPARTMENT_HEAD("부장"),
	VICE_GENERAL_MANGER_TREAT("부국장대우"),
	VICE_GENERAL_MANAGER("부국장"),
	GENERAL_MANAGER_TREAT("국장대우"),
	GENERAL_MANAGER("국장"),
	INSTITUTE_CHIEF("소장"),
	DEPARTMENT_CHIED("실장"),
	R_DEPARTMENT_HEAD("부장"),
	R_GENERAL_MANAGER("국장"),
	R_TEAM_LEADER("팀장"),
	R_PART_LEADER("파트장");
	
	String	userPosition;
	
	private UserPosition(String userPosition) {
		this.userPosition = userPosition;
	}
	
	public String getUserPosition() {
		return userPosition;
	}

}
