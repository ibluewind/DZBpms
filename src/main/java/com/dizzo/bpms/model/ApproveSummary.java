package com.dizzo.bpms.model;

import java.util.Date;

public class ApproveSummary {

	private String	appId;
	private String	formId;
	private String	title;
	private String	userId;
	private String	userName;
	private Date	created;
	private Date	modified;
	private String	status;
	
	public ApproveSummary() {}

	public String getAppId() {
		return appId;
	}

	public void setAppId(String appId) {
		this.appId = appId;
	}

	public String getFormId() {
		return formId;
	}

	public void setFormId(String formId) {
		this.formId = formId;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
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

	public Date getCreated() {
		return created;
	}

	public void setCreated(Date created) {
		this.created = created;
	}

	public Date getModified() {
		return modified;
	}

	public void setModified(Date modified) {
		this.modified = modified;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	public String toString() {
		return "ApproveSummary: {appId: " + appId + ", formId: " + formId + ", title: " + title + ", userId: " + userId + ", created: " + created + ", status: " + status +"}";
	}
}