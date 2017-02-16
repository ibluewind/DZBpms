package com.dizzo.bpms.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dizzo.bpms.dao.CustomApproveLineDao;
import com.dizzo.bpms.model.CustomApproveLine;
import com.dizzo.bpms.model.CustomApproveLineSummary;

@Service("customApproveLineService")
public class CustomApproveLineServiceImpl implements CustomApproveLineService {

	@Autowired
	CustomApproveLineDao	dao;
	
	@Override
	public List<CustomApproveLine> getApproveLines(String userId, String formId) {
		return dao.getApproveLines(userId, formId);
	}

	@Override
	public List<CustomApproveLine> getApproveLines(String lineId) {
		return dao.getApproveLines(lineId);
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
	public CustomApproveLine deleteOneLine(String lineId, int seq) {
		return dao.deleteOneLine(lineId, seq);
	}

	@Override
	public List<CustomApproveLine> deleteAll(String lineId) {
		return dao.deleteAll(lineId);
	}

	@Override
	public List<CustomApproveLineSummary> listSummary(String userId) {
		return dao.listSummary(userId);
	}

	@Override
	public CustomApproveLineSummary getSummary(String lineId) {
		return dao.getSummary(lineId);
	}

	@Override
	public CustomApproveLineSummary deleteSummary(String lineId) {
		return dao.deleteSummary(lineId);
	}

	@Override
	public CustomApproveLineSummary updateSummary(CustomApproveLineSummary summary) {
		return dao.updateSummary(summary);
	}

}
