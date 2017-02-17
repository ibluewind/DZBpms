package com.dizzo.bpms.dao;

import java.util.List;

import com.dizzo.bpms.model.CustomApproveLine;
import com.dizzo.bpms.model.CustomApproveLineSummary;

public interface CustomApproveLineDao {

	public List<CustomApproveLine>	getApproveLines(String userId, String formId);
	public List<CustomApproveLine>	getApproveLines(String lineId);
	public List<CustomApproveLine>	saveApproveLines(List<CustomApproveLine> lines);
	public List<CustomApproveLine>	updateApproveLines(List<CustomApproveLine> lines);
	public CustomApproveLine		deleteOneLine(String lineId, int seq);
	public List<CustomApproveLine>	deleteAll(String lineId);
	
	public CustomApproveLineSummary			saveSummary(CustomApproveLineSummary summary);
	public List<CustomApproveLineSummary>	listSummary(String userId);
	public CustomApproveLineSummary			getSummary(String lineId);
	public CustomApproveLineSummary 		deleteSummary(String lineId);
	public CustomApproveLineSummary			updateSummary(CustomApproveLineSummary summary);
}
