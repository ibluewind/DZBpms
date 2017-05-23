package com.dizzo.bpms.configuration;

import javax.servlet.Filter;
import javax.servlet.MultipartConfigElement;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRegistration.Dynamic;

import org.springframework.web.filter.CharacterEncodingFilter;
import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;

public class DZBpmInitializer extends AbstractAnnotationConfigDispatcherServletInitializer {

	@Override
	protected Class<?>[] getRootConfigClasses() {
		return new Class[] { DZBpmConfiguration.class };
	}

	@Override
	protected Class<?>[] getServletConfigClasses() {
		return null;
	}

	@Override
	protected String[] getServletMappings() {
		return new String[] { "/" };
	}

	@Override
	protected Filter[] getServletFilters() {
		CharacterEncodingFilter	encodingFilter = new CharacterEncodingFilter();
		
		/*
		 * 어떤 경우에 발생하는지는 모르겠지만, 가끔 MySQL DB에 저장된 한글이 깨지는 경우가 있다.
		 * 이를 방지하기 위해서 Encoding Filter를 등록한다.
		 */
		encodingFilter.setEncoding("UTF-8");
		encodingFilter.setForceEncoding(true);
		
		//CORSFilter()는 생략한다. @RestController가 정의된 class에 @CrossOrigin annotation을 사용하는 것이 낫다.
		//return new Filter[] { encodingFilter, new CORSFilter(), new CSRFHeaderFilter() };
		return new Filter[] { encodingFilter };
	}
	
	@Override
	public void onStartup(ServletContext servletContext) throws ServletException {
		super.onStartup(servletContext);
		servletContext.addListener(new SessionListener());
	}

	/**
	 * 파일 업로드를 위한 MultipartConfigElement 설정
	 * DZBpmConfiguration에 MultipartResolver Bean을 설정해야 한다.
	 */
	@Override
	protected void customizeRegistration(Dynamic registration) {
		registration.setMultipartConfig(getMultipartConfigElement());
	}

	private MultipartConfigElement getMultipartConfigElement() {
		MultipartConfigElement element = new MultipartConfigElement(LOCATION, MAX_FILE_SIZE, MAX_REQUEST_SIZE, FILE_SIZE_THRESHOLD);
		return element;
	}
	
	private static final String	LOCATION = "e:/temp";
	private static final long 	MAX_FILE_SIZE = 1024 * 1024 * 10;		// 10MB
	private static final long 	MAX_REQUEST_SIZE = 1024 * 1024 * 20;
	private static final int	FILE_SIZE_THRESHOLD = 0;
}