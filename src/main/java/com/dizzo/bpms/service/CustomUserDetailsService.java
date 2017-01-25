package com.dizzo.bpms.service;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dizzo.bpms.model.User;
import com.dizzo.bpms.model.UserAuthority;

@Service("customUserDetailsService")
public class CustomUserDetailsService implements UserDetailsService {

	static final Logger	log = LoggerFactory.getLogger(CustomUserDetailsService.class);
	
	@Autowired
	UserService	userService;
	
	@Transactional(readOnly=true)
	@Override
	public UserDetails loadUserByUsername(String userId) throws UsernameNotFoundException {
		
		User	user = userService.getByUserId(userId);
		log.info("userId : " + userId);
		log.info("User : " + user);
		if (user == null)
			throw new UsernameNotFoundException("Username not found");
		
		return new org.springframework.security.core.userdetails.User(
				user.getUserId(),
				user.getPassword(),
				user.getState().equals("Y"),
				true,
				true,
				true,
				getGrantedAuthorities(user));
	}
	
	private List<GrantedAuthority>	getGrantedAuthorities(User user) {
		List<GrantedAuthority>	authorites = new ArrayList<GrantedAuthority>();
		
		for (UserAuthority auth: user.getUserAuthorities()) {
			log.info("ROLE : " + auth.getRoleName());
			authorites.add(new SimpleGrantedAuthority("ROLE_" + auth.getRoleName()));
		}
		
		return authorites;
	}
}
