package com.dizzo.bpms.model;

import java.util.HashMap;
import java.util.Map;

public class DepartmentTree {
	
	private String	id;
	private String	parent;
	private String	text;
	private int		depth;
	
	public Map<String, Boolean>	state;
	
	public DepartmentTree() {
		this.state = new HashMap<String, Boolean>();
		this.state.put("opened", true);
	}
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getParent() {
		return parent;
	}

	public void setParent(String parent) {
		this.parent = parent;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}
	
	public int getDepth() {
		return depth;
	}

	public void setDepth(int depth) {
		this.depth = depth;
	}

	public String toString() {
		return "{ DepartmentTree : [id = " + id + ", parent = " + parent  + ", text = " + text + "] }"; 
	}
}
