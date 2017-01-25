package com.dizzo.bpms.dao;

import java.util.List;

import com.dizzo.bpms.model.ApproveSummary;

public interface ApproveSummaryDao {

	public ApproveSummary		insert(ApproveSummary summary);
	public ApproveSummary		getByAppId(String appId);
	public ApproveSummary		update(ApproveSummary summary);
	public ApproveSummary		delete(String appId);
	public List<ApproveSummary>	list(String userId);
}
