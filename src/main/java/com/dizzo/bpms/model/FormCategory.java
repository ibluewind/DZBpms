package com.dizzo.bpms.model;

import java.util.List;

public class FormCategory {

	private int categoryIdx;
	private List<FormClause>	clauses;
	
	public int getCategoryIdx() {
		return categoryIdx;
	}
	public void setCategoryIdx(int categoryIdx) {
		this.categoryIdx = categoryIdx;
	}
	public List<FormClause> getClauses() {
		return clauses;
	}
	public void setClauses(List<FormClause> clauses) {
		this.clauses = clauses;
	}
}
