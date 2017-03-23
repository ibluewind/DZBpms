package com.dizzo.bpms.utils;

import java.text.ParseException;
import java.util.Date;

public class CalendarTimeZone {

	public static void main(String[] args) throws ParseException {
		long t = 1488034800000l;
		Date d = new Date(t);
		
		System.out.println("date: " + d);
	}

}
