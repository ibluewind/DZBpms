package com.dizzo.bpms.model;

import java.util.Date;

public class ApproveLine {

	private String	lineId;
	private String	appId;
	private String	approvalId;			/* 결재자 사용자 아이디 */
	private String	status;
	private Date	modified;
	private	int		seq;
	private String	type;
	
	private String 	approvalName;		/* 결재자 사용자 이름 */
	private String	approvalPosition;	/* 결재자의 직급/직책 */
	
	public ApproveLine() {}

	public String getLineId() {
		return lineId;
	}

	public void setLineId(String lineId) {
		this.lineId = lineId;
	}

	public String getAppId() {
		return appId;
	}

	public void setAppId(String appId) {
		this.appId = appId;
	}

	public String getApprovalId() {
		return approvalId;
	}

	public void setApprovalId(String userId) {
		this.approvalId = userId;
	}

	public String getApprovalName() {
		return approvalName;
	}

	public void setApprovalName(String approvalName) {
		this.approvalName = approvalName;
	}

	public String getApprovalPosition() {
		return approvalPosition;
	}

	public void setApprovalPosition(String approvalPosition) {
		this.approvalPosition = approvalPosition;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Date getModified() {
		return modified;
	}

	public void setModified(Date modified) {
		this.modified = modified;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int order) {
		this.seq = order;
	}
	
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String toString() {
		return "ApproveLine: {lineId: " + lineId + ", appId: " + appId + ", approvalId: " + approvalId + ", approvalName: " + approvalName + ", approvalPosition: " + approvalPosition + ", seq: " + seq + ", type: " + type + "}";
	}
}