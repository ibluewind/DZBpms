package com.dizzo.bpms.model;

public class CustomApproveLine {

	/**
	 * DB Table member
	 */
	private String	lineId;
	private String	approvalId;
	private int		seq;
	
	private String	approvalName;
	private String	approvalPosition;
	
	public CustomApproveLine() {}
	
	public String getLineId() {
		return lineId;
	}
	public void setLineId(String lineId) {
		this.lineId = lineId;
	}
	public String getApprovalId() {
		return approvalId;
	}
	public void setApprovalId(String approvalId) {
		this.approvalId = approvalId;
	}
	public String getApprovalName() {
		return approvalName;
	}
	public void setApprovalName(String approvalName) {
		this.approvalName = approvalName;
	}
	public String getApprovalPosition() {
		return approvalPosition;
	}
	public void setApprovalPosition(String approvalPosition) {
		this.approvalPosition = approvalPosition;
	}
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	
	public String toString() {
		return "CustomApproveLine: {lineId: " + lineId + ", approvalId: " + approvalId + ", seq: " + seq + "}";
	}
}