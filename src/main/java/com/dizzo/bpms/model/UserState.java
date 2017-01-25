package com.dizzo.bpms.model;

public enum UserState {
	ACTIVE("Y"),
	RETIRED("R"),
	DELETED("D"),
	LOCKED("L");
	
	String state;
	
	private UserState(String state) {
		this.state = state;
	}
	
	public String getState() {
		return this.state;
	}
}
