package com.dizzo.bpms.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.dizzo.bpms.model.Task;
import com.dizzo.bpms.model.TaskHistory;
import com.dizzo.bpms.service.FileAttachService;
import com.dizzo.bpms.service.TaskHistoryService;
import com.dizzo.bpms.service.TaskService;

@CrossOrigin(origins="*", maxAge=3600)
@RestController
@RequestMapping("/rest/task")
public class TaskRestController {

	@Autowired
	TaskService		taskService;
	
	@Autowired
	TaskHistoryService	historyService;
	
	@Autowired
	FileAttachService	fileAttachService;
	
	@RequestMapping(method=RequestMethod.POST)
	public Task saveTask(@RequestBody Task task) {
		task.setTaskId(UUID.randomUUID().toString());
		task.setCreateDate(new Date());
		System.out.println("create task " + task);
		taskService.save(task);
		
		TaskHistory	history = new TaskHistory();
		history.setComment(task.getComment());
		history.setCreator(getPrincipal());
		history.setProcRate(task.getCurrentRate());
		history.setTaskId(task.getTaskId());
		history.setAction("신규 작업 생성");
		history.setWorker(task.getWorkerId());
		
		historyService.save(history);
		
		return task;
	}
	
	
	@RequestMapping(value="/user", method=RequestMethod.GET) 
	public List<Task> listOfMyTask() {
		List<Task>		listAll = new ArrayList<Task>();
		List<Task>		tasks = new ArrayList<Task>();
		String			userId = getPrincipal();
		
		tasks = taskService.listByCreator(userId);
		if (!tasks.isEmpty())
			listAll.addAll(tasks);
		
		tasks = taskService.listByWorker(userId);
		if (!tasks.isEmpty())
			listAll.addAll(tasks);
		
		return listAll;
	}
	
	@RequestMapping(value="/{taskId}", method=RequestMethod.GET)
	public Task getByTaskId(@PathVariable String taskId) {
		return taskService.getById(taskId);
	}
	
	@RequestMapping(method=RequestMethod.PUT)
	public Task updateTask(@RequestBody Task task) {
		System.out.println("update task " + task);
		task = taskService.upate(task);
		
		TaskHistory	history = new TaskHistory();
		history.setTaskId(task.getTaskId());
		history.setComment(task.getComment());
		history.setCreator(getPrincipal());
		history.setProcRate(task.getCurrentRate());
		history.setWorker(task.getWorkerId());
		history.setAction(task.getAction());
		historyService.save(history);
		
		return task;
	}
	
	/**
	 * 작업 이력 목록 조회
	 * @return 작업 이력 목록 List<TaskHistory>
	 */
	@RequestMapping(value="/history/{taskId}", method=RequestMethod.GET)
	public List<TaskHistory> listTaskHistory(@PathVariable String taskId) {
		return historyService.listByTaskId(taskId);
	}
	
	@RequestMapping(value="/history/details/{historyId}", method=RequestMethod.GET)
	public TaskHistory getTaskHistoryById(@PathVariable String historyId) {
		return historyService.getByHistoryId(historyId);
	}
	
	private String getPrincipal() {
		return IndexController.getPrincipal();
	}
}
