package com.dizzo.bpms.message;

import java.io.Serializable;
import java.util.Date;

public class WFMessage implements Serializable {
	
	private static final long serialVersionUID = 1216836382658571985L;
	private String	id;
	private String	type;
	private String	origin;
	private String	userId;
	private String	message;
	private String	readYn;
	private	Date	created;
	
	private String	userName;

	public WFMessage() {}
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getOrigin() {
		return origin;
	}

	public void setOrigin(String origin) {
		this.origin = origin;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getReadYn() {
		return readYn;
	}

	public void setReadYn(String readYn) {
		this.readYn = readYn;
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

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		WFMessage	other = (WFMessage)obj;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!other.id.equals(id))
			return false;
		
		return true;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		return result;
	}

	@Override
	public String toString() {
		return "Message [id=" + id + ", type=" + type + ", origin=" + origin + ",userId=" + userId + ", message=" + message + ", readYn=" + readYn + ", userName=" + userName + "]";
	}

	
}
