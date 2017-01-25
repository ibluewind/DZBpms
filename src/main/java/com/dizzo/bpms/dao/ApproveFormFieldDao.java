package com.dizzo.bpms.dao;

import java.util.List;

import com.dizzo.bpms.model.FormField;

public interface ApproveFormFieldDao {

	public List<FormField>	insert(String appId, String formId, List<FormField> formFields);
	public List<FormField>	update(String appId, List<FormField> formFields);
	public String 			delete(String appId);
	public List<FormField>	getFormFieldsByAppId(String appId);
}
