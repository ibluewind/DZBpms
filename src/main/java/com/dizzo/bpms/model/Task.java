package com.dizzo.bpms.model;

import java.util.Date;

public class Task {

	private String	taskId;
	private String	title;
	private String	content;
	private String	userId;
	private String	userName;
	private String	workerId;
	private String	workerName;
	private Date	createDate;
	private Date	endDate;
	private String	status;
	private String	priority;
	private int		targetRate;
	private int		currentRate;
	private String	opened;
	private String	comment;		// 이력관리를 위한 필드이며, task table에 저장되지 않는다.
	private String	action;			// 이력관리를 위한 작업 내용이며, task table에 저장되지 않는다.
	
	public Task() {
		this.comment = "";
		this.action = "";		
	}

	public String getTaskId() {
		return taskId;
	}

	public void setTaskId(String taskId) {
		this.taskId = taskId;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
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

	public String getWorkerId() {
		return workerId;
	}

	public void setWorkerId(String workerId) {
		this.workerId = workerId;
	}

	public String getWorkerName() {
		return workerName;
	}

	public void setWorkerName(String workerName) {
		this.workerName = workerName;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getPriority() {
		return priority;
	}

	public void setPriority(String priority) {
		this.priority = priority;
	}

	public int getTargetRate() {
		return targetRate;
	}

	public void setTargetRate(int targetRate) {
		this.targetRate = targetRate;
	}

	public int getCurrentRate() {
		return currentRate;
	}

	public void setCurrentRate(int currentRate) {
		this.currentRate = currentRate;
	}

	public String getOpened() {
		return opened;
	}

	public void setOpened(String opened) {
		this.opened = opened;
	}
	
	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public String getAction() {
		return action;
	}

	public void setAction(String action) {
		this.action = action;
	}

	public String toString() {
		return "TASK : {taskId: " + taskId + ", title: " + title + ", content: " + content + ", userId: " + userId
				+ ", userName: " + userName
				+ ", workerId: " + workerId
				+ ", workerName: " + workerName
				+ ", endDate: " + endDate + ", status: " + status
				+ ", priority: " + priority + ", targetRate: " + targetRate + ", currentRate: " + currentRate
				+ ", opened: " + opened + ", comment: " + comment + ", action: " + action + "}";
	}
}