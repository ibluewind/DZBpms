package com.dizzo.bpms.configuration;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

@Component
public class CustomSuccessHandler extends SimpleUrlAuthenticationSuccessHandler {

	private RedirectStrategy	redirectStrategy = new DefaultRedirectStrategy();

	@Override
	protected void handle(HttpServletRequest request, HttpServletResponse response, Authentication authentication)
			throws IOException, ServletException {
		String	targetUrl = determineTargetUrl(authentication);
		
		if (response.isCommitted())	return;
		
		redirectStrategy.sendRedirect(request, response, targetUrl);
	}
	
	private String determineTargetUrl(Authentication auth) {
		String	url = "";
		
		Collection<? extends GrantedAuthority> authorities = auth.getAuthorities();
		List<String>	roles = new ArrayList<String>();
		
		for (GrantedAuthority a: authorities) {
			roles.add(a.getAuthority());
		}
		
		if (isAdmin(roles))			url = "/admin";
		else if (isUser(roles))		url = "/home";
		else						url = "/accessDenied";
		
		return url;
	}
	
	private boolean isAdmin(List<String> roles) {
		if (roles.contains("ROLE_ADMIN"))	return true;
		
		return false;
	}
	
	private boolean isUser(List<String> roles) {
		if (roles.contains("ROLE_USER"))	return true;
		
		return false;
	}

	public RedirectStrategy getRedirectStrategy() {
		return redirectStrategy;
	}

	public void setRedirectStrategy(RedirectStrategy redirectStrategy) {
		this.redirectStrategy = redirectStrategy;
	}
}