package com.dizzo.bpms.model;

public enum ApproveTrayType {
	UNDECIDE("U"),			// 미결함
	COMPLETED("C"),			// 완료함
	FINISHED("F"),			// 기결함
	REJECT("R"),			// 반려함
	DEFER("D"),				// 보류함
	EXPECTED("E");			// 예정함
	
	String	type;
	
	private ApproveTrayType(String type) {
		this.type = type;
	}
	
	public String getType() {
		return this.type;
	}
}
