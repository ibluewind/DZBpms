package com.dizzo.bpms.dao;

import java.util.List;

import com.dizzo.bpms.model.ApproveHistory;

public interface ApproveHistoryDao {

	public ApproveHistory			insert(ApproveHistory history);
	public ApproveHistory			update(ApproveHistory history);
	public ApproveHistory			delete(String historyId);
	public ApproveHistory			getById(String id);
	public List<ApproveHistory>		getListByApproveId(String appId);
}
