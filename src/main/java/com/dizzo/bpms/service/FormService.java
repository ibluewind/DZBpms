package com.dizzo.bpms.service;

import java.util.List;

import com.dizzo.bpms.model.Form;
import com.dizzo.bpms.model.FormField;

public interface FormService {

	public Form			save(Form form);
	public List<Form>	list();
	public Form			getById(String id);
	public Form			getByAppId(String appId);
	public Form			update(Form form);
	public Form			delete(String id);
	public void			saveFormField(String formId, List<FormField> fields);
	public List<FormField>	getFormField(String formId);
}
