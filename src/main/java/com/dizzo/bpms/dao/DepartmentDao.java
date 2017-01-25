package com.dizzo.bpms.dao;

import java.util.List;

import com.dizzo.bpms.model.Company;
import com.dizzo.bpms.model.Department;
import com.dizzo.bpms.model.DepartmentTree;
import com.dizzo.bpms.model.DocumentManager;

public interface DepartmentDao {

	public List<Department>	getAll(String companyId);
	public Department		getByDeptId(String deptId);
	public Department		getRootByCompanyId(String companyId);
	public void				createRootDepartment(Company company);
	public Department		save(Department dept);
	public Department		update(Department dept);
	public Department		delete(String deptId);
	public List<DepartmentTree>	getJsTree(String companyId);
	public List<DocumentManager>	getDocumentManagersByDeptId(String deptId);
	public List<DocumentManager>	saveDocumentManagers(List<DocumentManager> managers);
	public void						deleteDocumentManagers(String deptId);
	public List<DocumentManager>	updateDocumentManager(List<DocumentManager> managers);
}
