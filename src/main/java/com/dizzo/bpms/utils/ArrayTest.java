package com.dizzo.bpms.utils;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import com.dizzo.bpms.model.ApproveLine;
import com.dizzo.bpms.model.UserDepartmentPosition;

public class ArrayTest {

	public static void main(String[] args) {
		List<UserDepartmentPosition>	udps = new ArrayList<>();
		UserDepartmentPosition u = new UserDepartmentPosition();
		
		u.setUserId("bigfoot@chosun.com");
		u.setDeptId("aaaaaa");
		u.setDeptName("미디어부문");
		u.setDeptPid("aaaadfdfd");
		u.setPositionId("1111");
		u.setPositionName("부장");
		u.setPositionType("R");
		
		udps.add(u);
		
		u = new UserDepartmentPosition();
		u.setUserId("bigfoot@chosun.com");
		u.setDeptId("aaaaaa");
		u.setDeptName("미디어부분");
		u.setDeptPid("aaaadfdfd");
		u.setPositionId("222222");
		u.setPositionName("국장");
		u.setPositionType("P");
		
		udps.add(u);
		
		u = new UserDepartmentPosition();
		u.setUserId("bigfoot@chosun.com");
		u.setDeptId("bbbbbb");
		u.setDeptName("미디어기술부");
		u.setDeptPid("aaaaaa");
		u.setPositionId("1111");
		u.setPositionName("부장");
		u.setPositionType("R");
		
		udps.add(u);
		
		u = new UserDepartmentPosition();
		u.setUserId("bigfoot@chosun.com");
		u.setDeptId("cccccc");
		u.setDeptName("미디어개발부");
		u.setDeptPid("111111");
		u.setPositionId("1111");
		u.setPositionName("부장");
		u.setPositionType("R");
		
		udps.add(u);
		
		u = new UserDepartmentPosition();
		u.setUserId("bigfoot@chosun.com");
		u.setDeptId("dddddd");
		u.setDeptName("미디어개발팀");
		u.setDeptPid("cccccc");
		u.setPositionId("3333");
		u.setPositionName("팀장");
		u.setPositionType("R");
		
		udps.add(u);
		
		udps = udps.stream().filter(t -> t.getPositionType().equals("R")).collect(Collectors.toList());
		
		System.out.println("upds: " + udps);
		//System.out.println("rls: " + rls);
	}

}
