package com.dizzo.bpms.dao;

import com.dizzo.bpms.model.ApproveFormField;

public interface ApproveDao {

	public ApproveFormField	save(ApproveFormField form);
	public ApproveFormField submit(ApproveFormField form);
	public ApproveFormField reject(ApproveFormField form);
	public ApproveFormField expect(String userId);
}
