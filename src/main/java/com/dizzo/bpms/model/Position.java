package com.dizzo.bpms.model;

import java.util.UUID;

public class Position {

	String	id;
	String	name;
	String	type;
	int		seq;
	
	public Position() {
		this.id = UUID.randomUUID().toString();
		this.name = null;
		this.type = null;
		this.seq = -1;
	}
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
}
