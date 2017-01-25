package com.dizzo.bpms.model;

import java.util.Date;
import java.util.UUID;

public class Department {

	private String	companyId;
	private String 	pId;
	private String 	deptId;
	private String 	name;
	private String 	useYN;
	private Date	lastModified;
	private int		depth;
	
	private String	companyName;
	private String	parentName;
	
	public Department() {
		this.companyId = null;
		this.pId = null;
		this.deptId = UUID.randomUUID().toString();
		this.name = null;
		this.useYN = "Y";
		this.companyName = null;
		this.parentName = null;
	}
	
	public String getCompanyId() {
		return companyId;
	}
	public void setCompanyId(String companyId) {
		this.companyId = companyId;
	}
	public String getDeptId() {
		return deptId;
	}
	public void setDeptId(String deptId) {
		this.deptId = deptId;
	}
	public String getpId() {
		return pId;
	}
	public void setpId(String pId) {
		this.pId = pId;
	}
	public String getParentName() {
		return this.parentName;
	}
	public void setParentName(String parentName) {
		this.parentName = parentName;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getUseYN() {
		return useYN;
	}
	public void setUseYN(String useYN) {
		this.useYN = useYN;
	}
	public Date getLastModified() {
		return lastModified;
	}
	public void setLastModified(Date lastModified) {
		this.lastModified = lastModified;
	}
	public String getCompanyName() {
		return companyName;
	}
	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
	
	public int getDepth() {
		return depth;
	}

	public void setDepth(int depth) {
		this.depth = depth;
	}

	public String toString() {
		return "Department: [pid = " + pId + ", name = " + name
				+ ", company : " + companyId + ", lastModified = " + lastModified
				+ ", useYN : " + getUseYN() + ", deptId = " + deptId + ", parentName = " + parentName
				+ "]";
	}
}