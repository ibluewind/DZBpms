package com.dizzo.bpms.service;

import java.util.List;

import com.dizzo.bpms.model.ApproveLine;

public interface ApproveLineService {

	public ApproveLine			getByLineId(String lineId);
	public List<ApproveLine>	getByAppId(String appId);
	public List<ApproveLine>	getByUserId(String userId);
	public List<ApproveLine>	getByOrganize(String userId);
	public List<ApproveLine>	getExpectedApprove(String userId);
	public List<ApproveLine>	insert(List<ApproveLine> appLines);
	public ApproveLine			update(ApproveLine appLine);
	public ApproveLine			delete(String lineId);
	public List<ApproveLine>	deleteAll(String appId);
	public ApproveLine			getNextOrder(String appId, String userId);
}
