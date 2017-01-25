package com.dizzo.bpms.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.dizzo.bpms.model.ApproveTray;
import com.dizzo.bpms.model.ApproveTrayType;
import com.dizzo.bpms.service.ApproveTrayService;

@CrossOrigin(origins="*", maxAge=3600)
@RestController
@RequestMapping("/rest/approve/tray")
public class ApproveTrayRestController {

	@Autowired
	ApproveTrayService		trayService;
	
	@RequestMapping(value="/{type}", method=RequestMethod.GET)
	public List<ApproveTray> getTray(@PathVariable String type) {
		
		String	userId = getPrincipal();
		List<ApproveTray>	trays = null;
		
		System.out.println("DEBUG: getTray() type = " + type + ", userId = " + userId);
		
		if (type.equals(ApproveTrayType.UNDECIDE.getType())) {
			trays = trayService.undecideTray(userId);
		} else if (type.equals(ApproveTrayType.COMPLETED.getType())) {
			trays = trayService.completedTray(userId);
		} else if (type.equals(ApproveTrayType.DEFER.getType())) {
			trays = trayService.deferTray(userId);
		} else if (type.equals(ApproveTrayType.EXPECTED.getType())) {
			trays = trayService.expectedTray(userId);
		}
		
		return trays;
	}
	
	private String getPrincipal() {
		String	userName = null;
		Object	principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		
		if (principal instanceof UserDetails) {
			userName = ((UserDetails)principal).getUsername();
		} else {
			userName = principal.toString();
		}
		
		System.out.println("userName : " + userName);
		if (userName.equals("anonymousUser"))	userName = null;
		return userName;
	}
}
