package com.dizzo.bpms.model;

public enum ScheduleType {

	TASK("T"),
	VOCATION("V"),
	PERSONAL("P");
	
	private String type;
	
	private ScheduleType(final String type) {
		this.type = type;
	}
	
	public String getType() {
		return this.type;
	}
	
	@Override
	public String toString() {
		return this.type;
	}
}
