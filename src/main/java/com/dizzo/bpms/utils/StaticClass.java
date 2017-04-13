package com.dizzo.bpms.utils;

public class StaticClass {

	public static String UPLOAD_LOCATION;
	public static String FORM_LOCATION;
	
	static {
		UPLOAD_LOCATION = "e:/upload";
		FORM_LOCATION = "e:/form/upload/";
	}
}
