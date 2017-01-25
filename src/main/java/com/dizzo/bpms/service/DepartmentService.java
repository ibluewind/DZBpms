package com.dizzo.bpms.service;

import java.util.List;

import com.dizzo.bpms.model.Company;
import com.dizzo.bpms.model.Department;
import com.dizzo.bpms.model.DepartmentTree;
import com.dizzo.bpms.model.DocumentManager;

public interface DepartmentService {
	public	List<Department>		list(String companyId);
	public 	Department				getDepartmentByDeptId(String deptId);
	public	Department				getRootByCompanyId(String companyId);
	public	Department				update(Department dept);
	public 	Department				save(Department dept);
	public	Department				delete(String deptId);
	public 	List<DepartmentTree>	getJsTree(String companyId);
	public 	void 					createRootDepartment(Company company);
	public List<DocumentManager>	getDocumentManagersByDeptId(String deptId);
	public List<DocumentManager>	saveDocumentManagers(List<DocumentManager> managers);
	public List<DocumentManager>	updateDocumentManager(List<DocumentManager> managers);
}
