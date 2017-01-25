package com.dizzo.bpms.utils;

import java.util.ArrayList;

public class RoleTest {

	public static void main(String[] args) {
		ArrayList<String>	actions = new ArrayList<String>();
		
		actions.add("A");
		actions.add("KOREA");
		actions.add("GET TITLE");
		
		System.out.println(actions.toString().substring(1, actions.toString().length() - 1));
	}

}
