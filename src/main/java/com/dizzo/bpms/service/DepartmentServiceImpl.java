package com.dizzo.bpms.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dizzo.bpms.dao.DepartmentDao;
import com.dizzo.bpms.model.Company;
import com.dizzo.bpms.model.Department;
import com.dizzo.bpms.model.DepartmentTree;
import com.dizzo.bpms.model.DocumentManager;

@Service(value="departmentService")
public class DepartmentServiceImpl implements DepartmentService {

	@Autowired
	DepartmentDao	dao;
	
	@Override
	public List<Department> list(String companyId) {
		return dao.getAll(companyId);
	}

	@Override
	public Department getDepartmentByDeptId(String deptId) {
		return dao.getByDeptId(deptId);
	}

	@Override
	public Department update(Department dept) {
		return dao.update(dept);
	}

	@Override
	public Department save(Department dept) {
		return dao.save(dept);
	}

	@Override
	public Department delete(String deptId) {
		return dao.delete(deptId);
	}

	@Override
	public List<DepartmentTree> getJsTree(String companyId) {
		return dao.getJsTree(companyId);
	}

	@Override
	public Department getRootByCompanyId(String companyId) {
		return dao.getRootByCompanyId(companyId);
	}

	@Override
	public void createRootDepartment(Company company) {
		dao.createRootDepartment(company);		
	}

	@Override
	public List<DocumentManager> getDocumentManagersByDeptId(String deptId) {
		return dao.getDocumentManagersByDeptId(deptId);
	}

	@Override
	public List<DocumentManager> saveDocumentManagers(List<DocumentManager> managers) {
		return dao.saveDocumentManagers(managers);
	}

	@Override
	public List<DocumentManager> updateDocumentManager(List<DocumentManager> managers) {
		return dao.updateDocumentManager(managers);
	}
}
