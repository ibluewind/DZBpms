package com.dizzo.bpms.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.dizzo.bpms.model.ApproveHistory;
import com.dizzo.bpms.service.ApproveHistoryService;

@CrossOrigin(origins="*", maxAge=3600)
@RestController
@Scope("session")
@RequestMapping(value="/rest/approve/history")
public class ApproveHistoryRestController {

	@Autowired
	ApproveHistoryService	historyService;
	
	@RequestMapping(method=RequestMethod.POST)
	public ApproveHistory saveHistory(@RequestBody ApproveHistory history) {
		System.out.println("Save Approve History: " + history);
		return historyService.insert(history);
	}
	
	@RequestMapping(method=RequestMethod.PUT)
	public ApproveHistory updateHistory(@RequestBody ApproveHistory history) {
		System.out.println("Updating Approve History: " + history);
		return historyService.update(history);
	}
	
	@RequestMapping(value="/{historyId}", method=RequestMethod.DELETE)
	public ApproveHistory deleteHistory(@PathVariable String historyId) {
		System.out.println("Deleting Approve History: " + historyId);
		return historyService.delete(historyId);
	}
	
	@RequestMapping(value="/{historyId}", method=RequestMethod.GET)
	public ApproveHistory getApproveHistoryById(@PathVariable String historyId) {
		return historyService.getById(historyId);
	}
	
	@RequestMapping(value="/list/{appId}", method=RequestMethod.GET)
	public List<ApproveHistory> getListByApproveId(@PathVariable String appId) {
		return historyService.getListByApproveId(appId);
	}
}
