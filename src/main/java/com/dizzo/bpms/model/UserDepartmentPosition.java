package com.dizzo.bpms.model;

public class UserDepartmentPosition {
	
	String	userId;
	String	deptId;
	String	positionId;
	
	String	deptName;
	String	deptPid;
	String	positionName;
	String	positionType;
	
	public UserDepartmentPosition() {}
	
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getDeptId() {
		return deptId;
	}
	public void setDeptId(String deptId) {
		this.deptId = deptId;
	}
	public String getDeptName() {
		return deptName;
	}
	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}
	public String getDeptPid() {
		return deptPid;
	}

	public void setDeptPid(String deptPid) {
		this.deptPid = deptPid;
	}

	public String getPositionId() {
		return positionId;
	}
	public void setPositionId(String positionId) {
		this.positionId = positionId;
	}
	public String getPositionName() {
		return positionName;
	}
	public void setPositionName(String positionName) {
		this.positionName = positionName;
	}
	
	public String getPositionType() {
		return positionType;
	}

	public void setPositionType(String positionType) {
		this.positionType = positionType;
	}

	public String toString() {
		return "UserDepartmentPosition = {userID : " + userId + ", deptId : " + deptId + ", pid : " + deptPid + ", deptName : " + deptName + ", positionId : " + positionId + ", positionName : " + positionName + ", positionType: " + positionType + "}";
	}
}
