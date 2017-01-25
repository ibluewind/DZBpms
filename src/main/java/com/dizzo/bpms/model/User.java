package com.dizzo.bpms.model;

import java.util.List;

public class User {
	private	String	userId;
	private	String	firstName;
	private String	lastName;
	private	String	password;
	private	String	state;
	
	private	List<Company>	companies;				// 소속회사 (겸임 가능)
	private	List<UserDepartmentPosition> deptPositions;	// 소속 부서
	private	List<UserAuthority>	userAuthorities;
	
	public User() {}
	 
	/*public User(String userId, String firstName, String lastName, String password, String state, List<Company> companies, List<UserDepartmentPosition> deptPositions, List<UserAuthority> userAuthorities) {
		this.userId = userId;
		this.firstName = firstName;
		this.lastName = lastName;
		this.password = password;
		this.state = state;
		
		this.companies = companies;
		this.deptPositions = deptPositions;
		this.userAuthorities = userAuthorities;
	}*/
	
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getFirstName() {
		return firstName;
	}
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	public String getLastName() {
		return lastName;
	}
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public List<Company> getCompanies() {
		return companies;
	}
	public void setCompanies(List<Company> companies) {
		this.companies = companies;
	}
	public List<UserDepartmentPosition> getDeptPositions() {
		return deptPositions;
	}
	public void setDeptPositions(List<UserDepartmentPosition> deptPositions) {
		this.deptPositions = deptPositions;
	}
	public List<UserAuthority> getUserAuthorities() {
		return userAuthorities;
	}
	public void setUserAuthorities(List<UserAuthority> userAuthorities) {
		this.userAuthorities = userAuthorities;
	}
	@Override
	public String toString() {
		return "User : {userId=" + userId + ", firstName=" + firstName + ", lastName=" + lastName + ", password=" + password + ", state=" + state + ","
				+ "deptPosition = [" + deptPositions + "], authorities = [" + userAuthorities +"]}";
	}
	
	
}
