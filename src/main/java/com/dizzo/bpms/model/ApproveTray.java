package com.dizzo.bpms.model;

import java.util.Date;

public class ApproveTray {

	// DB Table Fields
	private String	appId;
	private String	userId;			// 결재자 ID
	private Date	modified;		// 결재함 도착 일자
	private String	type;			// 결재함 종류
	
	// 추가 정보 Fields
	private String	creator;		// 작성자ID
	private String	creatorName;	// 작성자 이름
	private Date	created;		// 작성 일자
	private String	appTitle;		// 결재 문서 제목
	
	public ApproveTray() {}
	
	public String getAppId() {
		return appId;
	}
	public void setAppId(String appId) {
		this.appId = appId;
	}
	public String getAppTitle() {
		return appTitle;
	}
	public void setAppTitle(String appTitle) {
		this.appTitle = appTitle;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getCreator() {
		return creator;
	}
	public void setCreator(String creator) {
		this.creator = creator;
	}
	public String getCreatorName() {
		return creatorName;
	}
	public void setCreatorName(String creatorName) {
		this.creatorName = creatorName;
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

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	
	public String toString() {
		return "ApproveTray: {appId: " + appId + ", userId: " + userId + ", type: " + type + "}";
	}
}