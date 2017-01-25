package com.dizzo.bpms.model;

import java.util.Date;

public class TaskHistory {

	private String	historyId;
	private String	taskId;
	private String	comment;
	private Date	created;
	private String	creator;
	private String	creatorName;
	private String	worker;
	private String	workerName;
	private String	action;
	private int		procRate;
	
	public TaskHistory() {}

	public String getHistoryId() {
		return historyId;
	}

	public void setHistoryId(String historyId) {
		this.historyId = historyId;
	}

	public String getTaskId() {
		return taskId;
	}

	public void setTaskId(String taskId) {
		this.taskId = taskId;
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

	public String getCreator() {
		return creator;
	}

	public void setCreator(String creator) {
		this.creator = creator;
	}

	public String getWorker() {
		return worker;
	}

	public void setWorker(String worker) {
		this.worker = worker;
	}

	public int getProcRate() {
		return procRate;
	}

	public void setProcRate(int procRate) {
		this.procRate = procRate;
	}
	
	public String getCreatorName() {
		return creatorName;
	}

	public void setCreatorName(String creatorName) {
		this.creatorName = creatorName;
	}

	public String getWorkerName() {
		return workerName;
	}

	public void setWorkerName(String workerName) {
		this.workerName = workerName;
	}

	public String getAction() {
		return action;
	}

	public void setAction(String action) {
		this.action = action;
	}

	public String toString() {
		return "{historyId: " + historyId + ", taskId: " + taskId + ", comment: " + comment + ", creator: " + creator + ", worker: " + worker + ", procRate: " + procRate + ", craeted: " + created + "}";
	}
}