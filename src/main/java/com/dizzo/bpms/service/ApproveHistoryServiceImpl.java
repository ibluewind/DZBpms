package com.dizzo.bpms.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dizzo.bpms.dao.ApproveHistoryDao;
import com.dizzo.bpms.model.ApproveHistory;

@Service("approveHistoryService")
public class ApproveHistoryServiceImpl implements ApproveHistoryService {

	@Autowired
	ApproveHistoryDao		dao;
	
	@Override
	public ApproveHistory insert(ApproveHistory history) {
		return dao.insert(history);
	}

	@Override
	public ApproveHistory update(ApproveHistory history) {
		return dao.update(history);
	}

	@Override
	public ApproveHistory delete(String historyId) {
		return dao.delete(historyId);
	}

	@Override
	public ApproveHistory getById(String id) {
		return dao.getById(id);
	}

	@Override
	public List<ApproveHistory> getListByApproveId(String appId) {
		return dao.getListByApproveId(appId);
	}

}
