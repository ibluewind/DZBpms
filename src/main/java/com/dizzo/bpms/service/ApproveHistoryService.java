package com.dizzo.bpms.service;

import java.util.List;

import com.dizzo.bpms.model.ApproveHistory;

public interface ApproveHistoryService {

	public ApproveHistory		insert(ApproveHistory history);
	public ApproveHistory		update(ApproveHistory history);
	public ApproveHistory		delete(String historyId);
	public ApproveHistory		getById(String id);
	public List<ApproveHistory>	getListByApproveId(String appId);
}
