package com.dizzo.bpms.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dizzo.bpms.dao.ApproveFormFieldDao;
import com.dizzo.bpms.model.FormField;

@Service("approveFormFieldService")
public class ApproveFormFieldServiceImpl implements ApproveFormFieldService {

	@Autowired
	ApproveFormFieldDao	dao;
	
	@Override
	public List<FormField> insert(String appId, String formId, List<FormField> formFields) {
		return dao.insert(appId, formId, formFields);
	}

	@Override
	public List<FormField> update(String appId, List<FormField> formFields) {
		return dao.update(appId, formFields);
	}

	@Override
	public String delete(String appId) {
		return dao.delete(appId);
	}

	@Override
	public List<FormField> getFormFields(String appId) {
		return dao.getFormFieldsByAppId(appId);
	}

}
