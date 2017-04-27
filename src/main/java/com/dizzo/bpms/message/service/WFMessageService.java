package com.dizzo.bpms.message.service;

import java.util.List;

import com.dizzo.bpms.message.WFMessage;

public interface WFMessageService {

	public WFMessage	insert(WFMessage msg);
	public WFMessage	getById(String id);
	public WFMessage	update(WFMessage msg);
	public WFMessage	delete(String id);
	public void			deleteAll(String userId);
	public List<WFMessage>	listForUnRead(String userId);
	public List<WFMessage>	listByUserId(String userId);
	public void			setReadedAll(String userId);
	public void			sendMessage(String type, String userId, String message);
}
