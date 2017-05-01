package com.dizzo.bpms.utils;

import com.dizzo.bpms.model.Task;

public class ProjectTask extends Task {

	private String	prevTaskId;
	private String	nextTaskId;
	private int		period;
	
	public ProjectTask() {
		
		super();
	}
	
	public String getPrevTaskId() {
		return prevTaskId;
	}
	public void setPrevTaskId(String prevTaskId) {
		this.prevTaskId = prevTaskId;
	}
	public String getNextTaskId() {
		return nextTaskId;
	}
	public void setNextTaskId(String nextTaskId) {
		this.nextTaskId = nextTaskId;
	}
	public int getPeriod() {
		return period;
	}
	public void setPeriod(int period) {
		this.period = period;
	}

	@Override
	public String toString() {
		String	obj = super.toString() + ", prevTaskId=" + prevTaskId + ", nextTaskId=" + nextTaskId + ", period=" + period;
		return obj;
	}
	
	
}
