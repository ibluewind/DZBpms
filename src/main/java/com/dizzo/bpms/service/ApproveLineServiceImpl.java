package com.dizzo.bpms.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dizzo.bpms.dao.ApproveLineDao;
import com.dizzo.bpms.model.ApproveLine;

@Service("appLineService")
public class ApproveLineServiceImpl implements ApproveLineService {

	@Autowired
	ApproveLineDao	dao;
	
	@Override
	public ApproveLine getByLineId(String lineId) {
		return dao.getByLineId(lineId);
	}

	@Override
	public List<ApproveLine> getByAppId(String appId) {
		return dao.getByAppId(appId);
	}

	@Override
	public List<ApproveLine> insert(List<ApproveLine> appLines) {
		return dao.insert(appLines);
	}

	@Override
	public ApproveLine update(ApproveLine appLine) {
		return dao.update(appLine);
	}

	@Override
	public ApproveLine delete(String lineId) {
		return dao.delete(lineId);
	}

	@Override
	public List<ApproveLine> deleteAll(String appId) {
		return dao.deleteAll(appId);
	}

	@Override
	public List<ApproveLine> getByUserId(String userId) {
		return dao.getByUserId(userId);
	}

	@Override
	public List<ApproveLine> getExpectedApprove(String userId) {
		return dao.getExpectedApprove(userId);
	}

	@Override
	public List<ApproveLine> getByOrganize(String userId) {
		return dao.getByOrganize(userId);
	}
}
