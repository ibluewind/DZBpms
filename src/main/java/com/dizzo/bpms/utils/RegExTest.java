package com.dizzo.bpms.utils;

import java.util.regex.Pattern;

public class RegExTest {

	public static void main(String[] args) {
		String	email = "andrew@chosun.com";
		String	id = "398rfd-d98re09wqr-df9dasf0das-djasofd";
		String	regEx = "^[_a-z0-9]+(.[_a-z0-9]+)*@(?:\\w+\\.)+\\w+$";
		
		System.out.println(Pattern.matches(regEx, email));
		System.out.println(Pattern.matches(regEx, id));

	}

}
