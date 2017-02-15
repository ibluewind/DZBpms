package com.dizzo.bpms.model;

public enum ApproveTrayType {
	UNDECIDE("U"),
	COMPLETED("C"),
	FINISHED("F"),
	REJECT("R"),
	DEFER("D"),
	EXPECTED("E");
	
	String	type;
	
	private ApproveTrayType(String type) {
		this.type = type;
	}
	
	public String getType() {
		return this.type;
	}
}
