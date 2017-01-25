package com.dizzo.bpms.model;

public class UserAuthority {
	
	private String	userId;
	private String	authId;
	private String	roleName;
	
	public UserAuthority() {}
	
	public UserAuthority(String userId, String authId, String roleName) {
		this.userId = userId;
		this.authId = authId;
		this.roleName = roleName;
	}
	
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getAuthId() {
		return authId;
	}
	public void setAuthId(String authId) {
		this.authId = authId;
	}
	public String getRoleName() {
		return roleName;
	}
	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}
	
	public String toString() {
		return "UserAuthority = {userId : " + userId + ", authId : " + authId + ", roleName : " + roleName + "}";
	}
}
