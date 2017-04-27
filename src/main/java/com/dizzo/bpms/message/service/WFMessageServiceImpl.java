package com.dizzo.bpms.message.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dizzo.bpms.message.MessageSender;
import com.dizzo.bpms.message.WFMessage;
import com.dizzo.bpms.message.dao.WFMessageDao;

@Service("messageService")
public class WFMessageServiceImpl implements WFMessageService {

	@Autowired
	WFMessageDao		dao;
	
	@Autowired
	MessageSender		msgSender;
	
	@Override
	public WFMessage insert(WFMessage msg) {
		return dao.insert(msg);
	}

	@Override
	public WFMessage getById(String id) {
		return dao.getById(id);
	}

	@Override
	public WFMessage update(WFMessage msg) {
		return dao.update(msg);
	}

	@Override
	public WFMessage delete(String id) {
		return dao.delete(id);
	}

	@Override
	public List<WFMessage> listByUserId(String userId) {
		return dao.listByUserId(userId);
	}

	@Override
	public void deleteAll(String userId) {
		dao.deleteAll(userId);
	}

	@Override
	public List<WFMessage> listForUnRead(String userId) {
		return dao.listForUnRead(userId);
	}

	@Override
	public void sendMessage(String type, String userId, String message) {
		
		WFMessage	msg = new WFMessage();
		
		msg.setType(type);
		msg.setMessage(message);
		msg.setOrigin("I");
		msg.setUserId(userId);
		
		msgSender.sendMessage(msg);
	}

	@Override
	public void setReadedAll(String userId) {
		dao.setReadedAll(userId);
		return;
	}

}
