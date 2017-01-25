package com.dizzo.bpms.model;

import java.util.Date;

public class Form {

	private String	id;
	private String	title;
	private String	comment;
	private Date	created;
	private Date	modified;
	private String	creator;		// 생정자 userId;
	private String	creatorName;
	private String	procDept;
	private	String	procDeptName;
	
	public Form() {}
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
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

	public Date getModified() {
		return modified;
	}

	public void setModified(Date modified) {
		this.modified = modified;
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

	public String getProcDept() {
		return procDept;
	}

	public void setProcDept(String procDept) {
		this.procDept = procDept;
	}

	public String getProcDeptName() {
		return procDeptName;
	}

	public void setProcDeptName(String procDeptName) {
		this.procDeptName = procDeptName;
	}

	public String toString() {
		return "Form: {id: " + id + ", title: " + title + ", comment: " + comment + ", created: " + created + ", modified: " + modified + ", creator: " + creator +"}";
	}
}