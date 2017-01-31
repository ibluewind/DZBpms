package com.dizzo.bpms.model;

public enum ApproveStatus {

	CHECK("C"),			// 결재 확인
	SAVE("S"),			// 임시 저장
	FINISH("F"),		// 결재 완료
	PROCESSING("P"),	// 결재 진행 중
	DEFERRED("D"),		// 결재 보류
	REJECT("R");		// 결재 반려
	
	String status;
	
	private ApproveStatus(String status) {
		this.status = status;
	}
	
	public String getStatus() {
		return this.status;
	}
}
