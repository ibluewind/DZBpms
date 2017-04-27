package com.dizzo.bpms.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.dizzo.bpms.message.WFMessage;
import com.dizzo.bpms.message.service.WFMessageService;

@CrossOrigin(maxAge=3600)
@RestController
@RequestMapping("/rest/message")
public class MessageRestController {

	@Autowired
	WFMessageService	msgService;
	
	@RequestMapping(value="/{id}", method=RequestMethod.GET)
	public WFMessage getById(@PathVariable String id) {
		return msgService.getById(id);
	}
	
	@RequestMapping(method=RequestMethod.GET)
	public List<WFMessage> getMessageList() {
		String	userId = IndexController.getPrincipal();
		return msgService.listByUserId(userId);
	}
	
	@RequestMapping(value="/{msg}", method=RequestMethod.PUT)
	public WFMessage updateMessage(@RequestBody WFMessage msg) {
		return msgService.update(msg);
	}
	
	@RequestMapping(method=RequestMethod.DELETE)
	public void deleteAll() {
		String	userId = IndexController.getPrincipal();
		msgService.deleteAll(userId);
		return;
	}
	
	@RequestMapping(value="/{id}", method=RequestMethod.DELETE)
	public WFMessage delete(@PathVariable String id) {
		return msgService.delete(id);
	}
	
	@RequestMapping(value="/unread", method=RequestMethod.GET)
	public List<WFMessage> getUnreadMessages() {
		String	userId = IndexController.getPrincipal();
		return msgService.listForUnRead(userId);
	}
	
	@RequestMapping(value="/readedAll", method=RequestMethod.GET)
	public void setReadedAll() {
		String userId = IndexController.getPrincipal();
		msgService.setReadedAll(userId);
		return;
	}
}
