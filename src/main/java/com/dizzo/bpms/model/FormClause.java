package com.dizzo.bpms.model;

import java.util.List;

public class FormClause {

	private int clauseIdx;
	private List<FormField>		fields;
	
	public int getClauseIdx() {
		return clauseIdx;
	}
	public void setClauseIdx(int clauseIdx) {
		this.clauseIdx = clauseIdx;
	}
	public List<FormField> getFields() {
		return fields;
	}
	public void setFields(List<FormField> fields) {
		this.fields = fields;
	}
}
