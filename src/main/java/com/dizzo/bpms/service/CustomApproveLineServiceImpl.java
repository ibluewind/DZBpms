package com.dizzo.bpms.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dizzo.bpms.dao.CustomApproveLineDao;
import com.dizzo.bpms.model.CustomApproveLine;

@Service("customApproveLineService")
public class CustomApproveLineServiceImpl implements CustomApproveLineService {

	@Autowired
	CustomApproveLineDao	dao;
	
	@Override
	public List<CustomApproveLine> getApproveLines(String userId, String formId) {
		return dao.getApproveLines(userId, formId);
	}

	@Override
	public List<CustomApproveLine> saveApproveLines(List<CustomApproveLine> lines) {
		return dao.saveApproveLines(lines);
	}

	@Override
	public List<CustomApproveLine> updateApproveLines(List<CustomApproveLine> lines) {
		return dao.updateApproveLines(lines);
	}

	@Override
	public CustomApproveLine deleteOneLine(String userId, String formId, String approvalId) {
		return dao.deleteOneLine(userId, formId, approvalId);
	}

	@Override
	public List<CustomApproveLine> deleteAll(String userId, String formId) {
		return dao.deleteAll(userId, formId);
	}

}
