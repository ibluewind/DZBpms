package com.dizzo.bpms.model;

import java.util.Date;

public class CustomApproveLineSummary {

	/**
	 * DB Table member
	 */
	private String	lineId;
	private String	formId;
	private String	userId;
	private String	title;
	private Date	modified;
	
	/**
	 * 부가 정보
	 */
	private String	formTitle;
	private String	userName;
	
	public CustomApproveLineSummary() {}
	
	public String getLineId() {
		return lineId;
	}
	public void setLineId(String lineId) {
		this.lineId = lineId;
	}
	public String getFormId() {
		return formId;
	}
	public void setFormId(String formId) {
		this.formId = formId;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getFormTitle() {
		return formTitle;
	}
	public void setFormTitle(String formTitle) {
		this.formTitle = formTitle;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	
	public Date getModified() {
		return modified;
	}

	public void setModified(Date modified) {
		this.modified = modified;
	}

	public String toString() {
		return "CustomApproveLineSummary {lineId: " + lineId + ", formId: " + formId + ", userId: " + userId + ", title: " + title + "}";
	}
}
