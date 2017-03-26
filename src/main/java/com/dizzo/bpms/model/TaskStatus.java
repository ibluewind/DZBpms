package com.dizzo.bpms.model;

public enum TaskStatus {
	NEW("N"),
	PROCESS("P"),
	HOLD("H"),
	REJECT("R"),
	CANCEL("C"),
	DELEGATE("D"),
	LATE("L"),
	FINISH("F"),
	RESUBMIT("S");
	
	private String status;
	
	private TaskStatus(final String status) {
		this.status = status;
	}
	
	public String getStatus() {
		return this.status;
	}
}
