package com.dizzo.bpms.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dizzo.bpms.dao.ApproveSummaryDao;
import com.dizzo.bpms.model.ApproveSummary;

@Service("approveSummaryService")
public class ApproveSummaryServiceImpl implements ApproveSummaryService {

	@Autowired
	ApproveSummaryDao	dao;
	
	@Override
	public ApproveSummary insert(ApproveSummary summary) {
		return dao.insert(summary);
	}

	@Override
	public ApproveSummary getByAppId(String appId) {
		return dao.getByAppId(appId);
	}

	@Override
	public ApproveSummary update(ApproveSummary summary) {
		return dao.update(summary);
	}

	@Override
	public ApproveSummary delete(String appId) {
		return dao.delete(appId);
	}

	@Override
	public List<ApproveSummary> list(String userId) {
		return dao.list(userId);
	}

}
