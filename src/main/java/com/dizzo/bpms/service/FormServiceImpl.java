package com.dizzo.bpms.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dizzo.bpms.dao.FormDao;
import com.dizzo.bpms.model.Form;
import com.dizzo.bpms.model.FormField;

@Service("formService")
public class FormServiceImpl implements FormService {
	
	@Autowired
	FormDao		dao;

	@Override
	public Form save(Form form) {
		return dao.save(form);
	}

	@Override
	public List<Form> list() {
		return dao.list();
	}

	@Override
	public Form getById(String id) {
		return dao.getById(id);
	}

	@Override
	public Form getByAppId(String appId) {
		return dao.getByAppId(appId);
	}

	@Override
	public Form update(Form form) {
		return dao.update(form);
	}

	@Override
	public Form delete(String id) {
		return dao.delete(id);
	}

	@Override
	public void saveFormField(String formId, List<FormField> fields) {
		dao.saveFormField(formId, fields);
		return;
	}

	@Override
	public List<FormField> getFormField(String formId) {
		return dao.getFormField(formId);
	}
}
