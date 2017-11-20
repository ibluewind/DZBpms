package com.dizzo.bpms.message;

import javax.jms.JMSException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jms.annotation.JmsListener;
import org.springframework.messaging.Message;
import org.springframework.messaging.MessageHeaders;
import org.springframework.stereotype.Component;

import com.dizzo.bpms.message.service.WFMessageService;

@Component
public class MessageReceiver {

	static final Logger	log = LoggerFactory.getLogger(MessageReceiver.class);
	private static final String MESSAGE_QUEUE = "bpms_message_queue";
	
	/**
	 * 메시지를 AMQP에서 수신한 후, 해당 메시지를 데이터베이스에 저장한다.
	 */
	@Autowired
	WFMessageService	service;
	
	@JmsListener(destination=MESSAGE_QUEUE)
	public void receiveMessage(final Message<WFMessage> message) throws JMSException {
		log.info("====================================================");
		MessageHeaders	headers = message.getHeaders();
		log.info("Receiver : headers : {}", headers);
		WFMessage	msg = message.getPayload();
		
		log.info("Receiver : message : {}", msg);
		// 수신한 WFMessage를 데이터 베이스에 등록.
		service.insert(msg);
		log.info("====================================================");
	}
}
