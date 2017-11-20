package com.dizzo.bpms.utils;

import java.util.ArrayList;
import java.util.List;

import org.springframework.web.servlet.handler.UserRoleAuthorizationInterceptor;

import com.dizzo.bpms.model.UserAuthority;
import com.dizzo.bpms.model.UserDepartmentPosition;
import com.dizzo.bpms.model.UserRole;

public class RoleTest {

	public static void main(String[] args) throws Exception {
		System.out.println("DL: " + UserRole.DL.name().equals("DL"));
	}
}
