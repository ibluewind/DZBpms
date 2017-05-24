package com.dizzo.bpms.configuration;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.rememberme.JdbcTokenRepositoryImpl;
import org.springframework.security.web.authentication.rememberme.PersistentTokenRepository;
import org.springframework.security.web.csrf.CsrfFilter;
import org.springframework.security.web.csrf.CsrfTokenRepository;
import org.springframework.security.web.csrf.HttpSessionCsrfTokenRepository;
import org.springframework.security.web.session.HttpSessionEventPublisher;

@Configuration
@EnableWebSecurity
public class SecurityConfiguration extends WebSecurityConfigurerAdapter {

	@Autowired
	@Qualifier("customUserDetailsService")
	UserDetailsService		userDetailsService;
	
	@Autowired
	CustomSuccessHandler	customSuccessHandler;
	
	@Autowired
	DataSource			dataSource;
	
	@Autowired
	public void configureGlobalSecurity(AuthenticationManagerBuilder auth) throws Exception {
		auth.userDetailsService(userDetailsService);
		auth.authenticationProvider(authenticationProvider());
	}
	
	@Bean
	public PasswordEncoder	passwordEncoder() {
		return new BCryptPasswordEncoder();
	}
	
	@Bean
	public DaoAuthenticationProvider authenticationProvider() {
		DaoAuthenticationProvider	provider = new DaoAuthenticationProvider();
		provider.setUserDetailsService(userDetailsService);
		provider.setPasswordEncoder(passwordEncoder());
		
		return provider;
	}
	
	@Bean
	public HttpSessionEventPublisher	httpSessionEventPublisher() {
		return new HttpSessionEventPublisher();
	}
	
	/**
	 * Spring Security 설정
	 */
	@Override
	protected void configure(HttpSecurity http) throws Exception {
		http
			.authorizeRequests()
			.antMatchers("/home/**").access("hasRole('USER')")
			.antMatchers("/rest/**").access("hasRole('USER')")
			.antMatchers("/admin/**").access("hasRole('ADMIN')")
			.and()
				.formLogin().loginPage("/login")
				.usernameParameter("userid").passwordParameter("password").defaultSuccessUrl("/home")
			.and()
				.csrf().csrfTokenRepository(csrfTokenRepository())
			.and()
				.addFilterAfter(new CSRFHeaderFilter(), CsrfFilter.class)		// angularjs의 xsrf 처리를 위해서 필터를 등록한다.
				.exceptionHandling().accessDeniedPage("/Access_Denied")
//			.and().rememberMe().rememberMeParameter("remember-me").tokenRepository(persistentTokenRepository()).tokenValiditySeconds(86400)
			.and()
				.sessionManagement().invalidSessionUrl("/login").maximumSessions(1).expiredUrl("/logout");	// 동시 접속 방지
	}
	
	/*
	 * pre-flight http.OPTIONS 처리
	 */
	@Override
	public void configure(WebSecurity web) throws Exception {
		web.ignoring().antMatchers(HttpMethod.OPTIONS, "/**");
	}
	
	/**
	 * rememeber-me option을 사용하는 경우를 위한 함수.
	 * @return
	 */
	@Bean
	public PersistentTokenRepository	persistentTokenRepository() {
		JdbcTokenRepositoryImpl	tokenRepositoryImpl = new JdbcTokenRepositoryImpl();
		tokenRepositoryImpl.setDataSource(dataSource);
		return tokenRepositoryImpl;
	}
	
	private CsrfTokenRepository	csrfTokenRepository() {
		HttpSessionCsrfTokenRepository	repository = new HttpSessionCsrfTokenRepository();
		repository.setHeaderName("X-XSRF-TOKEN");
		return repository;
	}
}
