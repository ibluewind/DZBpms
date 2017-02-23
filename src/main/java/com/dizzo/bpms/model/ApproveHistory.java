package com.dizzo.bpms.model;

import java.util.Date;

public class ApproveHistory {

	// DB Table fields
	private String	historyId;
	private String	appId;
	private String	comment;
	private Date	created;
	private String	userId;
	private String	status;
	
	// 추가 field
	private String	title;			// 결재 문서 제목
	private String	creatorId;		// 작성자 ID
	private String	creatorName;	// 작성자 이름
	private String	userName;		// 결재자 이름
	
	public ApproveHistory() {}
	
	public String getHistoryId() {
		return historyId;
	}
	public void setHistoryId(String historyId) {
		this.historyId = historyId;
	}
	public String getAppId() {
		return appId;
	}
	public void setAppId(String appId) {
		this.appId = appId;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public Date getCreated() {
		return created;
	}
	public void setCreated(Date created) {
		this.created = created;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getCreatorId() {
		return creatorId;
	}
	public void setCreatorId(String creatorId) {
		this.creatorId = creatorId;
	}
	public String getCreatorName() {
		return creatorName;
	}
	public void setCreatorName(String creatorName) {
		this.creatorName = creatorName;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	
	public String toString() {
		return "ApproveHistory: {historyID: " + historyId + ", appId: " + appId + ", comment: " + comment + ", userId: " + userId + ", status: " + status + "}";
	}
}