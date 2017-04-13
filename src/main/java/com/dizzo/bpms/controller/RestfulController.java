package com.dizzo.bpms.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.dizzo.bpms.model.Authority;
import com.dizzo.bpms.model.Company;
import com.dizzo.bpms.model.Department;
import com.dizzo.bpms.model.DepartmentTree;
import com.dizzo.bpms.model.DocumentManager;
import com.dizzo.bpms.model.Position;
import com.dizzo.bpms.model.User;
import com.dizzo.bpms.service.AuthorityService;
import com.dizzo.bpms.service.CompanyService;
import com.dizzo.bpms.service.DepartmentService;
import com.dizzo.bpms.service.PositionService;
import com.dizzo.bpms.service.UserService;

@CrossOrigin(origins="*", maxAge=3600)
@RestController
@RequestMapping("/rest")
public class RestfulController {

	static final Logger	log = LoggerFactory.getLogger(RestfulController.class);
	
	@Autowired
	DepartmentService	deptService;
	
	@Autowired
	UserService			userService;
	
	@Autowired
	AuthorityService	authService;
	
	@Autowired
	PositionService		positionService;
	
	@Autowired
	CompanyService		companyService;
	
	@RequestMapping(value="/dept/tree/{companyId}", method=RequestMethod.GET)
	public List<DepartmentTree> getDeptJsonTree(@PathVariable String companyId) {
		List<DepartmentTree> tree =  deptService.getJsTree(companyId);
		
		return tree;
	}
	
	@RequestMapping(value="/dept/{deptId}", method=RequestMethod.GET)
	public Department getDepartmentByDeptId(@PathVariable String deptId) {
		return deptService.getDepartmentByDeptId(deptId);
	}
	
	@RequestMapping(value="/dept/{deptId}", method=RequestMethod.PUT)
	public Department updateDepartment(@PathVariable String deptId, @RequestBody Department dept) {
		System.out.println("Updating department " + deptId);
		return deptService.update(dept);
	}
	
	@RequestMapping(value="/dept/{deptId}", method=RequestMethod.DELETE)
	public Department deleteDepartment(@PathVariable String deptId) {
		System.out.println("Delete department " + deptId);
		return deptService.delete(deptId);
	}
	
	@RequestMapping(value="/dept", method=RequestMethod.POST)
	public Department createDepartment(@RequestBody Department dept) {
		System.out.println("Create Department " + dept.getName());
		return deptService.save(dept);
	}
	
	@RequestMapping(value="/dept/manager/{deptId}", method=RequestMethod.GET)
	public List<DocumentManager> getDocumentManagers(@PathVariable String deptId) {
		return deptService.getDocumentManagersByDeptId(deptId);
	}
	
	@RequestMapping(value="/dept/manager", method=RequestMethod.POST)
	public List<DocumentManager> saveDocumentManagers(@RequestBody List<DocumentManager> managers) {
		return deptService.saveDocumentManagers(managers);
	}
	
	@RequestMapping(value="/dept/manager", method=RequestMethod.PUT)
	public List<DocumentManager> updateDocumentManagers(@RequestBody List<DocumentManager> managers) {
		System.out.println("managers: " + managers);
		return deptService.updateDocumentManager(managers);
	}
	
	@RequestMapping(value="/user", method=RequestMethod.GET)
	public User getLoggedInUser() {
		return userService.getByUserId(getPrincipal());
	}

	@RequestMapping(value="/user/list/{deptId}", method=RequestMethod.GET)
	public List<User> getUserList(@PathVariable String deptId) {
		List<User>	userList = userService.listForDeptId(deptId);
		System.out.println("userList : " + userList);
		return userList;
	}
	
	@RequestMapping(value="/user/{userId}/", method=RequestMethod.DELETE)
	public User deleteUser(@PathVariable String userId) {
		System.out.println("Delete User : " + userId);
		return userService.delete(userId);
	}
	
	/**
	 * userId에 '.'이 포함되므로, url 마지막에 '/'를 추가한다. 호출하는 곳도 마찬가지...
	 * 이러니까, 406에러도 없어졌다. ㅡㅡ;;
	 * @param userId
	 * @return
	 */
	@RequestMapping(value="/user/{userId}/", method=RequestMethod.GET)
	public @ResponseBody User getUserByUserId(@PathVariable String userId) {
		System.out.println("Request getUserByUserId");
		User user =  userService.getByUserId(userId);
		System.out.println("getUserByUserId.user: " + user);
		return user;
	}
	
	@RequestMapping(value="/user", method=RequestMethod.POST)
	public User addUser(@RequestBody User user) {
		System.out.println("Create User " + user);
		System.out.println("DepartmentPositions : " + user.getDeptPositions());
		System.out.println("UseAuthority : " + user.getUserAuthorities());
		return userService.save(user);
	}
	@RequestMapping(value="/user/{userId}/", method=RequestMethod.PUT)
	public User updateUser(@PathVariable String userId, @RequestBody User user) {
		System.out.println("Update User " + user);
		return userService.update(user);
	}
	
	@RequestMapping(value="/auth", method=RequestMethod.GET)
	public List<Authority> getAuthorities() {
		return authService.list();
	}
	
	@RequestMapping(value="/auth/{id}", method=RequestMethod.GET)
	public Authority getAuthority(@PathVariable String id) {
		return authService.getById(id);
	}
	
	@RequestMapping(value="/auth", method=RequestMethod.POST)
	public Authority addAuthority(@RequestBody Authority auth) {
		System.out.println("Add Authority : " + auth);
		return authService.save(auth);
	}
	
	@RequestMapping(value="/auth/{id}", method=RequestMethod.DELETE)
	public Authority deleteAuthority(@PathVariable String id) {
		System.out.println("DELETING : " + id);
		return authService.delete(id);
	}
	
	@RequestMapping(value="/position", method=RequestMethod.GET)
	public List<Position> getPositions() {
		return positionService.list();
	}
	
	@RequestMapping(value="/position/{id}", method=RequestMethod.PUT)
	public Position updatePosition(@PathVariable String id, @RequestBody Position position) {
		return positionService.update(position);
	}
	
	@RequestMapping(value="/position", method=RequestMethod.POST)
	public Position addPosition(@RequestBody Position position) {
		return positionService.save(position);
	}
	
	@RequestMapping(value="/position/{id}", method=RequestMethod.DELETE)
	public Position deletePosition(@PathVariable String id) {
		return positionService.delete(id);
	}
	
	@RequestMapping(value="/company", method=RequestMethod.GET)
	public List<Company> getCompanyList() {
		return companyService.list();
	}
	
	@RequestMapping(value="/company/{id}", method=RequestMethod.PUT)
	public Company updateCompany(@PathVariable String id, @RequestBody Company company) {
		return companyService.update(company);
	}
	
	@RequestMapping(value="/company", method=RequestMethod.POST)
	public Company addCompany(@RequestBody Company company) {
		Company comp = companyService.save(company);
		deptService.createRootDepartment(company);		// 회사를 추가하면, 최상위 부서를 부서 테이블에 생성한다.
		return comp;
	}
	
	@RequestMapping(value="/company/{id}", method=RequestMethod.DELETE)
	public Company deleteCompany(@PathVariable String id) {
		return companyService.delete(id);
	}
	
	private String getPrincipal() {
		return IndexController.getPrincipal();
	}
}
