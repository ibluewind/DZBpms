package com.dizzo.bpms.model;

public class Company {

	private String		id;
	private String	name;
	private String	ceo;
	
	public Company() {}
	
	public Company(String id, String name, String ceo) {
		this.id = id;
		this.name = name;
		this.ceo = ceo;
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
	public String getCeo() {
		return ceo;
	}
	public void setCeo(String ceo) {
		this.ceo = ceo;
	}
	
	public String toString() {
		return "[Company: {id = " + id + ", name = " + name +  ", ceo = " + ceo + "}]";
	}
}
