package com.dizzo.bpms.utils;

import java.util.ArrayList;
import java.util.List;

import com.dizzo.bpms.model.User;
import com.dizzo.bpms.model.UserAuthority;
import com.dizzo.bpms.model.UserDepartmentPosition;
import com.fasterxml.jackson.databind.ObjectMapper;

public class JsonMapping {

	public static void main(String[] args) {
		ObjectMapper	mapper = new ObjectMapper();
		
		/*Map<String, Object> carMap = new HashMap<String, Object>();
		
		carMap.put("car", "Audi");
		carMap.put("price", "30000");
		carMap.put("model", "2010");
		
		List<String>	colors = new ArrayList<String>();
		colors.add("Grey");
		colors.add("White");
		colors.add("Black");
		
		carMap.put("colors", colors);
		
		try {
			mapper.writeValue(System.out, carMap);
		} catch(Exception e) {
			e.printStackTrace(System.out);
		}*/
		
		User	user = new User();
		user.setUserId("andrew@chosun.com");
		user.setFirstName("현곤");
		user.setLastName("김");
		user.setPassword("1234");
		user.setState("Y");
		
		List<UserDepartmentPosition> deptPositions = new ArrayList<UserDepartmentPosition>();
		UserDepartmentPosition	udp = new UserDepartmentPosition();
		udp.setDeptId("9c247a2d-77b1-457a-ba9b-43c972125ab6");
		udp.setDeptName("시너지개발부");
		udp.setPositionId("cb37711b-aaec-11e6-8cda-d067e51fd421");
		udp.setPositionName("부장");
		udp.setUserId(user.getUserId());
		deptPositions.add(udp);
		user.setDeptPositions(deptPositions);
		
		List<UserAuthority> userAuthorities = new ArrayList<UserAuthority>();
		UserAuthority	ua = new UserAuthority();
		ua.setUserId("andrew@chosun.com");
		ua.setAuthId("45338ea5-aaea-11e6-8cda-d067e51fd414");
		ua.setRoleName("USER");
		userAuthorities.add(ua);
		
		ua = new UserAuthority();
		ua.setUserId("andrew@chosun.com");
		ua.setAuthId("45338ea5-aaea-11e6-8cda-d067e51fd419");
		ua.setRoleName("DL");
		
		userAuthorities.add(ua);
		user.setUserAuthorities(userAuthorities);
		try {
			mapper.writeValue(System.out, user);
		} catch(Exception e) {
			e.printStackTrace();
		}
	}

}
