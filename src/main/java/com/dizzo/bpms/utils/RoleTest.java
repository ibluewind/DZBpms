package com.dizzo.bpms.utils;

import java.util.ArrayList;
import java.util.List;

import com.dizzo.bpms.model.UserAuthority;

public class RoleTest {

	public static void main(String[] args) {
		List<UserAuthority>	auths = new ArrayList<>();
		
		UserAuthority	ua = new UserAuthority();
		ua.setUserId("andrew");
		ua.setAuthId("1111");
		ua.setRoleName("TL");
		auths.add(ua);
		ua = new UserAuthority();
		ua.setUserId("andrew");
		ua.setAuthId("22222");
		ua.setRoleName("DBA");
		auths.add(ua);
		
		ua = new UserAuthority();
		ua.setUserId("andrew");
		ua.setAuthId("33333");
		ua.setRoleName("ADMIN");
		auths.add(ua);
		
		System.out.println(auths);
		
		if (auths.contains(new UserAuthority("andrew", "1111", "TL"))) {
			System.out.println("Has leader previlege");
		} else {
			System.out.println("Has no leader previledge");
		}
	}

}
