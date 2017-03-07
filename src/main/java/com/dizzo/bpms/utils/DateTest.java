package com.dizzo.bpms.utils;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class DateTest {

	public static void main(String[] args) throws ParseException {
		Date today = new Date();
		String	strDate = "2017-03-01T05:49:14.719Z";
		
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss");
		today = format.parse(strDate);
		System.out.println("today = " + today);
	}

}
