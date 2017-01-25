package com.dizzo.bpms.model;

public class Authority {
	String	authId;
	String	roleName;
	String	comment;
	
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
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	
	public String toString() {
		return "Authority: {authId = " + authId + ", roleName = " + roleName + ", comment = " + comment + "}";
	}
}
