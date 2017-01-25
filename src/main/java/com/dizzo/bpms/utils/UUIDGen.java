package com.dizzo.bpms.utils;

import java.util.UUID;

public class UUIDGen {

	public static void main(String[] args) {
		String 	id = "company-12";
		Line	line = new Line();
		line.setName("Andrew");
		Line	l = line;
		l.setId(UUID.randomUUID().toString());
		
		System.out.println("line.id : " + line.getId() + ", l.id : " + l.getId());
		
		System.out.println("CompanyId = " + Integer.parseInt(id.split("-")[1]));
		System.out.println("UUID = " + UUID.randomUUID().toString());
	}

}

class Line {
	private String id;
	private String name;
	
	public Line() {}

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
	
	
}
