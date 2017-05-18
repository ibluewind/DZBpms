package com.dizzo.bpms.configuration;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletResponse;

/**
 * CORS 처리 때문에 사용되는 filter인데, RestfulController나 @RestController가 정의된 class에
 * 그냥 @CrossOring annotation을 정의해서 사용하는게 번거롭지 않다.
 * filter를 등록해서 사용하는 경우 http.OPTIONS에 대한 처리가 제대로 되지 않는다.
 * 무슨 pre-flight 때문이라는데...
 * @author 김현곤
 *
 */
public class CORSFilter implements Filter {

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
	}

	@Override
	public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
			throws IOException, ServletException {
		HttpServletResponse	response = (HttpServletResponse) res;
		response.setHeader("Access-Control-Allow-Origin", "*");
		response.setHeader("Access-Control-Allow-Credentials", "true");
		response.setHeader("Access-Control-Allow-Methods", "POST, GET, PUT, OPTIONS, DELETE");
		response.setHeader("Access-Control-Max-Age", "3600");
		response.setHeader("Access-Control-Allow-Headers", "x-requested-with, Content-Type");
//		response.setHeader("X-Frame-Options", "SAMEORIGIN");
		chain.doFilter(req, response);
	}

	@Override
	public void destroy() {
	}
}