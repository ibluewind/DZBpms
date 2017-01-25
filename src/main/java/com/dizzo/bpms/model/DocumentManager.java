package com.dizzo.bpms.model;

public class DocumentManager {

	private String 	deptId;
	private String	userId;
	private String	userName;
	private String	type;
	
	public DocumentManager() {}
	
	public String getDeptId() {
		return deptId;
	}
	public void setDeptId(String deptId) {
		this.deptId = deptId;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}
	
	public String toString() {
		return "DocumentManager: {deptId: " + deptId + ", userId: " + userId + ", userName: " + userName + ", type: " + type + "}";
	}
}