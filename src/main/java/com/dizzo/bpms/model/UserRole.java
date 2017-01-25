package com.dizzo.bpms.model;

public enum UserRole {

	USER("사용자"),
	ADMIN("관리자"),
	DBA("DBA"),
	TL("팀장"),
	PL("파트장"),
	DL("부서장");
	
	String	userRole;
	
	private UserRole(String userRole) {
		this.userRole = userRole;
	}
	
	public String getUserRole() {
		return this.userRole;
	}
}
