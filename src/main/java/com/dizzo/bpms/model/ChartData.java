package com.dizzo.bpms.model;

public class ChartData {

	private String 	status;
	private String	id;
	private String	name;
	private int		count;
	
	public ChartData() {}
	
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
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
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	
	public String toString() {
		return "ChartData: {status: " + status + ", id: " + id + ", name: " + name + ", count: " + count + "}";
	}
}
