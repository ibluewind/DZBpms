package com.dizzo.bpms.utils;

import java.util.Calendar;
import java.util.Date;
import java.util.concurrent.TimeUnit;

public class CalendarTest {

	public static void main(String[] args) {
		Calendar	start = Calendar.getInstance(), end = Calendar.getInstance();

		//start.set(Calendar.MONTH, Calendar.APRIL);
		end = (Calendar) start.clone();
		
		start.set(Calendar.HOUR, 0);
		start.set(Calendar.MINUTE, 0);
		start.set(Calendar.SECOND, 0);
		
		end.set(Calendar.HOUR, 23);
		end.set(Calendar.MINUTE, 59);
		end.set(Calendar.SECOND, 59);
		
		start.set(Calendar.DATE, 1);
		start.add(Calendar.DATE, (start.getFirstDayOfWeek() - start.get(Calendar.DAY_OF_WEEK)));
		
		//end.set(Calendar.MONTH, end.get(Calendar.MONTH) + 1);
		end.add(Calendar.DATE, 27);
		end.set(Calendar.DATE, 0);
		end.add(Calendar.DATE, (Calendar.SATURDAY - end.get(Calendar.DAY_OF_WEEK)));
		
		System.out.println("start: " + (start.get(Calendar.MONTH) + 1) + "/" + start.get(Calendar.DATE));
		System.out.println("end: " + (end.get(Calendar.MONTH) + 1) + "/" + end.get(Calendar.DATE));
		
		System.out.println("Date diff: " + TimeUnit.DAYS.convert(end.getTimeInMillis() - start.getTimeInMillis(), TimeUnit.MILLISECONDS));
		long dateDiff = TimeUnit.DAYS.convert(end.getTimeInMillis() - start.getTimeInMillis(), TimeUnit.MILLISECONDS);
		int numOfWeeks = (int)Math.ceil(dateDiff / 7);
		
		System.out.println("numOfWeeks = " + (numOfWeeks + 1));
		
		for (int i = 0; i <= numOfWeeks; i++) {
			end = (Calendar) start.clone();
			end.add(Calendar.DATE, 6);
			
			Date	s = new Date();
			Date	e = new Date();
			
			s.setYear(start.get(Calendar.YEAR));
			s.setMonth(start.get(Calendar.MONTH));
			s.setDate(start.get(Calendar.DATE));
			
			e.setYear(end.get(Calendar.YEAR));
			e.setMonth(end.get(Calendar.MONTH));
			e.setDate(end.get(Calendar.DATE));
			
			/*s.setTime(start.getTimeInMillis());
			e.setTime(end.getTimeInMillis());*/
			
			System.out.println("start: " + s);
			System.out.println("end: " + e);
			end.add(Calendar.DATE, 1);
			start = (Calendar) end.clone();
		}
	}

}
