package com.dizzo.bpms.model;

public class CustomApproveLine {

	private String	formId;
	private String	formTitle;
	private String	userId;
	private String	userName;
	private String	approvalId;
	private String	approvalName;
	private String	approvalPosition;
	private int		seq;
	
	public CustomApproveLine() {}
	
	public String getFormId() {
		return formId;
	}
	public void setFormId(String formId) {
		this.formId = formId;
	}
	public String getFormTitle() {
		return formTitle;
	}
	public void setFormTitle(String formTitle) {
		this.formTitle = formTitle;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getApprovalId() {
		return approvalId;
	}
	public void setApprovalId(String approvalId) {
		this.approvalId = approvalId;
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
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	
	public String toString() {
		return "CustomApproveLine: {formId: " + formId + ", userId: " + userId + ", approvalId: " + approvalId + ", seq: " + seq + "}";
	}
}