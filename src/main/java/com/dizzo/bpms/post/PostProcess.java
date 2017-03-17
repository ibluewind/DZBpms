package com.dizzo.bpms.post;

import java.util.Map;

public interface PostProcess {

	public void setFields(Map<String, String> fields);
	public void process();
}
