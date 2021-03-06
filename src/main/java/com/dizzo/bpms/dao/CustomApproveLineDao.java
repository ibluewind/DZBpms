package com.dizzo.bpms.dao;

import java.util.List;

import com.dizzo.bpms.model.CustomApproveLine;

public interface CustomApproveLineDao {

	public List<CustomApproveLine>	getApproveLines(String userId, String formId);
	public List<CustomApproveLine>	saveApproveLines(List<CustomApproveLine> lines);
	public List<CustomApproveLine>	updateApproveLines(List<CustomApproveLine> lines);
	public CustomApproveLine		deleteOneLine(String userId, String formId, String approvalId);
	public List<CustomApproveLine>	deleteAll(String userId, String formId);
}
