package com.dizzo.bpms.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.dizzo.bpms.message.service.WFMessageService;
import com.dizzo.bpms.model.ChartData;
import com.dizzo.bpms.model.Task;
import com.dizzo.bpms.model.TaskHistory;
import com.dizzo.bpms.model.User;
import com.dizzo.bpms.model.UserAuthority;
import com.dizzo.bpms.model.UserDepartmentPosition;
import com.dizzo.bpms.model.UserRole;
import com.dizzo.bpms.service.FileAttachService;
import com.dizzo.bpms.service.TaskHistoryService;
import com.dizzo.bpms.service.TaskService;
import com.dizzo.bpms.service.UserService;

@CrossOrigin(origins="*", maxAge=3600)
@RestController
@RequestMapping("/rest/task")
public class TaskRestController {

	@Autowired
	UserService		userService;
	
	@Autowired
	TaskService		taskService;
	
	@Autowired
	TaskHistoryService	historyService;
	
	@Autowired
	FileAttachService	fileAttachService;
	
	@Autowired
	WFMessageService	msgService;
	
	@RequestMapping(method=RequestMethod.POST)
	public Task saveTask(@RequestBody Task task) {
		task.setTaskId(UUID.randomUUID().toString());
		task.setCreateDate(new Date());
		taskService.save(task);
		
		TaskHistory	history = new TaskHistory();
		history.setComment(task.getComment());
		history.setCreator(IndexController.getPrincipal());
		history.setProcRate(task.getCurrentRate());
		history.setTaskId(task.getTaskId());
		history.setAction("신규 작업 생성");
		history.setWorker(task.getWorkerId());
		
		historyService.save(history);
		
		msgService.sendMessage("T", task.getWorkerId(), "신규 작업 " + task.getTitle() + "이(가) 생성되었습니다.");
		return task;
	}
	
	
	/**
	 * 사용자의 권한에 따라 조회하는 내용을 다르게 한다.
	 * 부문장/부서장/팀장의 경우에는 각 담당 부서와 하위 부서의 모든 작업을 조회하고,
	 * 일반 팀원의 경우에는 본인의 작업과 공개된 작업만을 조회한다.
	 * @return
	 */
	@RequestMapping(value="/user", method=RequestMethod.GET) 
	public List<Task> listOfMyTask() {
		List<Task>		listAll = new ArrayList<Task>();
		List<Task>		tasks = new ArrayList<Task>();
		String			userId = IndexController.getPrincipal();
		
		User	user = userService.getByUserId(userId);
		if (hasLeaderAuthority(user)) {
			// 하위 부서의 모든 작업을 조회한다.
			System.out.println("has authority... list of departments");
			listAll = taskService.listByAuthority(user);
		} else {
			// 본인의 작업과 공개된 작업만을 조회한다.
			tasks = taskService.listByCreator(userId);
			if (!tasks.isEmpty())
				listAll.addAll(tasks);
			
			tasks = taskService.listByWorker(userId);
			if (!tasks.isEmpty())
				listAll.addAll(tasks);
			
			tasks =  taskService.listForOpenedTeam(userId);
			if (!tasks.isEmpty())
				listAll.addAll(tasks);
			
			tasks = taskService.listForOpenedDepartment(userId);
			if (!tasks.isEmpty())
				listAll.addAll(tasks);
		}
		
		return listAll;
	}
	
	/**
	 * 담당자의 작업 목록을 조회한다.
	 * 해당 메소드는 부서장 또는 팀장이 차트에서 특정 작업자를 클릭한 경우에만 사용된다.
	 * @param userId
	 * @return
	 */
	@RequestMapping(value="/user/{userId}/", method=RequestMethod.GET)
	public List<Task> listOfTaskByUserId(@PathVariable String userId) {

		return taskService.listByWorker(userId);
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
		history.setCreator(IndexController.getPrincipal());
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
	
	@RequestMapping(value="/chart", method=RequestMethod.GET)
	public List<List<?>> getChartData() {
		String	userId = IndexController.getPrincipal();
		User	user = userService.getByUserId(userId);
		List<List<?>> data = null;
		String	deptId = getMainDepartmentId(user.getDeptPositions());
		
		// 사용자의 권한에 따라 조회해야할 Data가 다르다.
		// 부서장인 경우에는 부서 산하의 팀별 작업 내역
		// 팀장인 경우에는 팀원들의 작업 내역 조회
		List<UserAuthority>	auths = user.getUserAuthorities();
		List<ChartData>	chartData = null;
		
		System.out.println("getChartData: user " + user + ", deptId = " + deptId);
		for (int i = 0; i < auths.size(); i++) {
			UserAuthority	auth = auths.get(i);
			
			System.out.println("auth = " + auth.getRoleName() + ": " + UserRole.DL);
			
			if (auth.getRoleName().equals(UserRole.DL.name())) {
				// 부서별 작업 현황 조회
				System.out.println("user " + userId + " has DL");
				chartData = taskService.getTaskStatusReportForIndividualDepartment(deptId);
				break;
			} else if (auth.getRoleName().equals(UserRole.TL.name())) {
				// 팀원들의 작업 현황 조회
				System.out.println("user " + userId + " has TL");
				chartData = taskService.getTaskStatusReportForIndividualPerson(deptId);
				break;
			}
		}
		
		// View page에서 사용될 데이터 형태로 변형하여 반환한다.
		data = reArrangeChartData(chartData);
		return data;
	}
	
	/*
	 * 전달된 ID에 따라 조회해야할 내용이 달라져야 한다.
	 * 부서 ID가 전달된 경우에는 해당 부서의 사용자 작업 현황을 조회하여야 하고,
	 * 사용자 ID가 전달된 경우에는 사용자의 작업 목록을 조회하여 전달해야한다.
	 */
	@RequestMapping(value="/chart/{id}/", method=RequestMethod.GET)
	public List<List<?>> getChartDataById(@PathVariable String id) {
		User	user = userService.getByUserId(IndexController.getPrincipal());
		List<ChartData>	chartData = null;
		
		// 부서장 또는 팀장 권한이 없는 경우에는 해당 내용을 표시하지 않음.
		if (!hasLeaderAuthority(user))	return null;
		
		chartData = taskService.getTaskStatusReportForIndividualPerson(id);
		
		return reArrangeChartData(chartData);
	}
	
	private List<List<?>> reArrangeChartData(List<ChartData> chartData) {
		List<List<?>>	results = new ArrayList<List<?>>();
		List<String>	names = new ArrayList<String>();
		List<String>	ids = new ArrayList<String>();
		List<Integer>	finish = new ArrayList<Integer>();
		List<Integer>	process = new ArrayList<Integer>();
		List<Integer>	late = new ArrayList<Integer>();
		List<List<?>>	counts = new ArrayList<List<?>>();
		
		for (ChartData c: chartData) {
			if (!names.contains(c.getName())) {
				names.add(c.getName());
				ids.add(c.getId());
			}
		}
		
		for (int i = 0; i < names.size(); i++) {
			finish.add(0);
			process.add(0);
			late.add(0);
		}
		
		// 부서 목록의 순서대로 data 값을 설정한다.
		for (int i = 0; i < names.size(); i++) {
			String name = names.get(i);
			
			// 이름으로 필터링을 하면, 3가지 상태에 대한 카운터 배열로 정리된다.
			// 배열에 있는 상태 값의 카운터를 각각의 상태값 목록에 저장한다.
			List<ChartData> data = chartData.stream().filter(t->t.getName().equals(name)).collect(Collectors.toList());
			System.out.println("data: " + data);
			
			for (int j = 0; j < data.size(); j++) {
				String	status = data.get(j).getStatus();
				int		count = data.get(j).getCount();
				
				if (status.equals("P")) {
					process.set(i, count);
				} else if (status.equals("F")) {
					finish.set(i, count);
				} else if (status.equals("L")) {
					late.set(i, count);
				}
			}
		}
		
		counts.add(process);
		counts.add(finish);
		counts.add(late);
		
		results.add(counts);
		results.add(names);
		results.add(ids);
		
		System.out.println("results: " + results);
		
		return results;
	}
	
	/*
	 * 사용자의 주 부서 아이디를 조회한다.
	 * 겸직인 경우거나, 직책과 직급이 구분되어 있으므로 팀장 부서장의 부서는 직책이 표시된 부서의 아이디를 조회한다.
	 * TODO 겸직으로 두개 이상의 직책을 가진 사람의 경우에 대한 처리가 필요하다.
	 */
	private String getMainDepartmentId(List<UserDepartmentPosition> pos) {
		String	deptId = null;
		
		for (UserDepartmentPosition p: pos) {
			if (p.getPositionType().equals("R")) {
				deptId = p.getDeptId();
				break;
			}
		}
		
		return deptId;
	}
	
	private boolean hasLeaderAuthority(User user) {
		List<UserAuthority>	auths = user.getUserAuthorities();
		boolean	hasAuth = false;
		
		for (int i = 0; i < auths.size(); i++) {
			UserAuthority ua = auths.get(i);
			System.out.println("DEBUG : ua " + ua);
			if (ua.getRoleName().equals(UserRole.DL.name())) {
				System.out.println("user has DL");
				hasAuth = true;
				break;
			} else if (ua.getRoleName().equals(UserRole.TL.name())) {
				System.out.println("user has TL");
				hasAuth = true;
				break;
			}
		}
		
		return hasAuth;
	}
	
	private boolean isEmail(String id) {
		String	regEx = "^[_a-z0-9]+(.[_a-z0-9]+)*@(?:\\w+\\.)+\\w+$";
		return	Pattern.matches(regEx, id);
	}
}
