package com.dizzo.bpms.model;

import java.util.Date;

public class FileAttach {

	private String	attachId;
	private String	type;			// 파일 타입
	private String	path;
	private String	name;			// 서버와 DB에 저장된 이름
	private String	originName;		// 실제 파일 이름
	private String	mainId;
	private Date	modified;
	private long	size;
	
	public FileAttach() {}

	public String getAttachId() {
		return attachId;
	}

	public void setAttachId(String attachId) {
		this.attachId = attachId;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getOriginName() {
		return originName;
	}

	public void setOriginName(String originName) {
		this.originName = originName;
	}

	public String getMainId() {
		return mainId;
	}

	public void setMainId(String mainId) {
		this.mainId = mainId;
	}

	public Date getModified() {
		return modified;
	}

	public void setModified(Date modified) {
		this.modified = modified;
	}
	
	public long getSize() {
		return size;
	}

	public void setSize(long size) {
		this.size = size;
	}

	public String toString() {
		return "TaskAttach: {attachId: " + attachId + ", type: " + type + ", path: " + path
				+ ", name: " + name + ", originName: " + originName + ", mainId: " + mainId + ", modified: " + modified + "}";
	}
}