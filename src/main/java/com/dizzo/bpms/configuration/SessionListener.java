package com.dizzo.bpms.configuration;

import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

public class SessionListener implements HttpSessionListener {

	/**
	 * Session timeout 설정
	 */
	@Override
	public void sessionCreated(HttpSessionEvent event) {
		System.out.println("==== Session Created ====");
		event.getSession().setMaxInactiveInterval(10 * 60);		// 10분

	}

	@Override
	public void sessionDestroyed(HttpSessionEvent event) {
		System.out.println("==== Session Destroyed ====");
	}

}
