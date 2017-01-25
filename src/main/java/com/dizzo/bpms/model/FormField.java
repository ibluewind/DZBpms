package com.dizzo.bpms.model;

public class FormField {
	private String formId;
	private int	category;
	private int clause;
	private String name;
	private String value;
	
	public FormField() {}
	public FormField(int category, int clause, String name, String value) {
		this.category = category;
		this.clause = clause;
		this.name = name;
		this.value = value;
	}
	
	public String getFormId() {
		return formId;
	}
	public void setFormId(String formId) {
		this.formId = formId;
	}
	public int getCategory() {
		return category;
	}

	public void setCategory(int category) {
		this.category = category;
	}

	public int getClause() {
		return clause;
	}

	public void setClause(int clause) {
		this.clause = clause;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}
	
	public String toString() {
		return "FormField: {category: " + category + ", clause: " + clause + ", name: " + name + ", value: " + value + "}";
	}
}
