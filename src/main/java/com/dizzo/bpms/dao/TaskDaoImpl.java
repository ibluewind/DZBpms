package com.dizzo.bpms.dao;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.dizzo.bpms.model.Schedule;
import com.dizzo.bpms.model.ScheduleType;
import com.dizzo.bpms.model.Task;
import com.dizzo.bpms.model.TaskRowMapper;
import com.dizzo.bpms.model.User;
import com.dizzo.bpms.model.UserDepartmentPosition;
import com.dizzo.bpms.service.ScheduleService;

@Repository("taskDao")
@Transactional
/**
 * 새로운 Task가 생성되거나, 기존의 Task가 수정되면 항상 task_history에 내용을 같이 저장한다.
 * @author andrew
 *
 */
public class TaskDaoImpl implements TaskDao {

	@Autowired
	DataSource		dataSource;
	
	@Override
	public Task save(Task task) {
		String query = "INSERT INTO TASK (taskId, userId, workerId, createDate, endDate, status, priority, targetRate, currentRate, opened, title, content) "
					+ " VALUES (?, ?, ?, now(), ?, ?, ?, ?, ?, ?, ?, ?)";
		
		System.out.println("Insert Task: " + task);
		new JdbcTemplate(dataSource).update(query, new Object[] {
			task.getTaskId(),
			task.getUserId(),
			task.getWorkerId(),
			task.getEndDate(),
			task.getStatus(),
			task.getPriority(),
			task.getTargetRate(),
			task.getCurrentRate(),
			task.getOpened(),
			task.getTitle(),
			task.getContent()
		});
		
		// 일정에 작업 내역 등록
		saveSchedule(task);
		return task;
	}

	@Override
	public List<Task> listByWorker(String userId) {
		String	query = "SELECT t.taskId,"
					  + " t.userId,"
					  + " concat(u.lastName, u.firstName) 'userName',"
       				  + " workerId,"
       				  + " w.userName 'workerName',"
       				  + " t.createDate,"
       				  + " t.endDate,"
       				  + " t.status,"
       				  + " t.priority,"
       				  + " t.targetRate,"
       				  + " t.currentRate,"
       				  + " t.opened,"
       				  + " t.title,"
       				  + " t.content"
  				  + " FROM task t,"
       				  + " users u,"
       				  + " (SELECT userId, concat(lastName, firstName) 'userName' FROM users) w"
 				  + " WHERE     t.workerId = ?"
       				  + " AND t.workerId = w.userId"
       				  + " AND t.userId = u.userId";
				
		List<Task>	tasks = new JdbcTemplate(dataSource).query(query, new Object[] {userId}, new TaskRowMapper());
		return tasks;
	}

	@Override
	public List<Task> listByCreator(String userId) {
		String	query = "SELECT t.taskId,"
				  + " t.userId,"
				  + " concat(u.lastName, u.firstName) 'userName',"
				  + " workerId,"
				  + " w.userName 'workerName',"
				  + " t.createDate,"
				  + " t.endDate,"
				  + " t.status,"
				  + " t.priority,"
				  + " t.targetRate,"
				  + " t.currentRate,"
				  + " t.opened,"
				  + " t.title,"
				  + " t.content"
				  + " FROM task t,"
				  + " users u,"
				  +  " (SELECT userId, concat(lastName, firstName) 'userName' FROM users) w"
				  + " WHERE     t.userId = ?"
				  + " AND t.userId != t.workerId"
				  + " AND t.workerId = w.userId"
				  + " AND t.userId = u.userId";
		
		List<Task>	tasks = new JdbcTemplate(dataSource).query(query, new Object[] {userId}, new TaskRowMapper());
		return tasks;
	}

	@Override
	public List<Task> listByDept(String deptId) {
		String	query = "select t.taskId, t.userId, concat(u.lastName, u.firstName) 'userName', t.workerId, w.userName 'workerName', t.createDate, t.endDate, t.status,"
						+ " t.priority, t.targetRate, t.currentRate, t.opened, t.title, t.content"
						+ " from task t, users u, (select concat(lastName, firstName) 'userName', userId from users) w"
						+ " where t.workerId in (select userid from user_dept_position where deptid=?) and u.userId=t.userId and t.workerId=w.userId";
		List<Task> tasks = new JdbcTemplate(dataSource).query(query, new Object[] {deptId}, new TaskRowMapper());
		
		return tasks;
	}

	@Override
	public List<Task> listByAuthority(User user) {
		String query = "SELECT t.taskId,"
					+ "       t.userId,"
					+ "       concat(u.lastName, u.firstName) 'userName',"
					+ "       t.workerId,"
					+ "       w.userName 'workerName',"
					+ "       t.createDate,"
					+ "       t.endDate,"
					+ "       t.status,"
					+ "       t.priority,"
					+ "       t.targetRate,"
					+ "       t.currentRate,"
					+ "       t.opened,"
					+ "       t.title,"
					+ "       t.content"
					+ "  FROM task t,"
					+ "       users u,"
					+ "       (SELECT concat(lastName, firstName) 'userName', userId FROM users) w"
					+ " WHERE     t.workerId IN"
					+ "              (SELECT userid"
					+ "                 FROM user_dept_position"
					+ "                WHERE deptid IN"
					+ "                         (SELECT deptId"
					+ "                            FROM (SELECT d.deptId deptId"
					+ "                                    FROM departments d,"
					+ "                                         (SELECT ? AS deptId"
					+ "                                          UNION ALL"
					+ "                                          SELECT getChildDeptList() deptId"
					+ "                                            FROM (SELECT @start_with :="
					+ "                                                            ?,"
					+ "                                                         @deptId :="
					+ "                                                            @start_with) b,"
					+ "                                                 departments) t"
					+ "                                   WHERE d.deptid = t.deptId) tmp))"
					+ "       AND u.userId = t.userId AND t.workerId = w.userId";
		List<Task>	tasks = new ArrayList<>();
		List<UserDepartmentPosition>	udps = filteringDepartment(user.getDeptPositions());
		
		for (int i = 0; i < udps.size(); i++) {
			String	deptId = udps.get(i).getDeptId();
			
			tasks.addAll(new JdbcTemplate(dataSource).query(query, new Object[] {deptId, deptId}, new TaskRowMapper()));
		}
		return tasks;
	}

	@Override
	public Task getById(String taskId) {
		String query = "select t.taskId, t.userId, concat(u.lastName, u.firstName) 'userName', t.workerId, w.userName 'workerName',"
						+ " t.createDate, t.endDate, t.status, t.priority, t.targetRate, t.currentRate, t.opened, t.title, t.content"
						+ " from task t, users u, (select userId, concat(lastName, firstName) 'userName' from users) w"
						+ " where t.taskId=? and t.userId=u.userId and t.workerId=w.userId";
		
		return new JdbcTemplate(dataSource).queryForObject(query, new Object[] {taskId}, new TaskRowMapper());
	}

	@Override
	public Task update(Task task) {
		String	query = "update task set workerId=?, endDate=?, status=?, priority=?, targetRate=?, currentRate=?, opened=?, title=?, content=?"
				+ " where taskId=?";
		Task	orgTask = getById(task.getTaskId());
		String	action = checkChangeField(orgTask, task);
		task.setAction(action);
		
		if (task.getCurrentRate() == 100)
			task.setStatus("F");
		
		new JdbcTemplate(dataSource).update(query, new Object[] {
				task.getWorkerId(),
				task.getEndDate(),
				task.getStatus(),
				task.getPriority(),
				task.getTargetRate(),
				task.getCurrentRate(),
				task.getOpened(),
				task.getTitle(),
				task.getContent(),
				task.getTaskId()
		});
		
		updateSchedule(task);
		return task;
	}

	@Override
	public Task delete(String taskId) {
		Task task = getById(taskId);
		String	query = "delete from task where taskId=?";
		Object[]	args = new Object[] {taskId};
		
		new JdbcTemplate(dataSource).update(query, args);
		
		query = "delete from task_history where taskId=?";
		new JdbcTemplate(dataSource).update(query, args);
		
		query = "delete from task_attach where taskId=?";
		new JdbcTemplate(dataSource).update(query, args);
		
		return task;
	}
	
	/**
	 * 사용자 부서/직책 정보에서 직책을 가진 부서와 직책을 가진 부서 중에 최상위 부서만을 조회한다.
	 * 최상위 부서만을 필터링하는 이유는 그렇게 하지 않으면, 하위 부서의 작업 목록을 조회하게 되므로 목록이 중복되기 때문이다.
	 * @param ul
	 * @return
	 */
	private List<UserDepartmentPosition> filteringDepartment(List<UserDepartmentPosition> ul) {
		List<UserDepartmentPosition> rl = new ArrayList<>();

		// 직책만 가진 정보를 필터링 한다.
		// Java8에서만 동작한다.
		ul = ul.stream().filter(t->t.getPositionType().equals("R")).collect(Collectors.toList());
		
		for (int i = 0; i < ul.size(); i++) {
			String	pid = ul.get(i).getDeptPid();
			
			// 현재 부서 정보의 부모 코드를 가진 부서 정보가 없다면, 현재 부서가 최상위 부서이다.
			if (ul.stream().filter(t->t.getDeptId().equals(pid)).collect(Collectors.toList()).isEmpty()) {
				rl.add(ul.get(i));
			}
		}
		return rl;
	}

	private String checkChangeField(Task org, Task dest) {
		ArrayList<String>	action = new ArrayList<String>();
		
		if (!dest.getAction().equals(""))
			action.add(dest.getAction());
		if (!org.getTitle().equals(dest.getTitle()))
			action.add("작업 제목 변경");
		if (!org.getEndDate().before(dest.getEndDate()))
			action.add("작업 기한 변경");
		if (!org.getContent().equals(dest.getContent()))
			action.add("작업 내용 변경");
		if (!org.getPriority().equals(dest.getPriority()))
			action.add("중요도 변경");
		if (!org.getOpened().equals(dest.getOpened()))
			action.add("작업 공개 변경");
		if (!org.getWorkerId().equals(dest.getWorkerId()))
			action.add("담당자 변경 (" + org.getWorkerName() + " -> " + dest.getWorkerName() +")");
		if (org.getCurrentRate() != dest.getCurrentRate())
			action.add("진척율 변경 [" + dest.getCurrentRate() + "%]");

		return action.toString().substring(1, action.toString().length() - 1);
	}
	
	
	@Autowired
	ScheduleService	scheduleService;
	
	/**
	 * 신규 등록된 작업 내용을 일정에 등록한다.
	 * 등록의 기준은 작업자를 기준으로 등록한다.
	 * @param task
	 */
	private void saveSchedule(Task task) {
		Schedule	schedule = new Schedule();
		
		schedule.setId(UUID.randomUUID().toString());
		schedule.setUserId(task.getWorkerId());
		schedule.setStartDate(setTo0Hour(task.getCreateDate()));
		schedule.setEndDate(setTo23Hour(task.getEndDate()));
		schedule.setType(ScheduleType.TASK.getType());
		schedule.setTitle(task.getTitle());
		schedule.setContent(task.getContent());
		schedule.setRefId(task.getTaskId());
		schedule.setRefUrl("/edit_task/" + task.getTaskId());
		
		scheduleService.save(schedule);
	}
	
	private void updateSchedule(Task task) {
		Schedule	schedule = scheduleService.getByRefId(task.getTaskId());
		
		schedule.setContent(task.getContent());
		schedule.setTitle(task.getTitle());
		schedule.setEndDate(setTo23Hour(task.getEndDate()));
		schedule.setUserId(task.getWorkerId());
		
		scheduleService.update(schedule);
	}
	
	/**
	 * 날짜의 시간을 0:0:0으로 세팅한다.
	 * 
	 * @param date
	 * @return
	 */
	private Date setTo0Hour(Date date) {
		Calendar	c = Calendar.getInstance();
		c.setTime(date);
		
		c.set(Calendar.HOUR_OF_DAY, 0);
		c.set(Calendar.MINUTE, 0);
		c.set(Calendar.SECOND, 0);
		
		return c.getTime();
	}
	
	/**
	 * 날짜의 시간을 23:59:59로 세팅한다.
	 * @param date
	 * @return
	 */
	private Date setTo23Hour(Date date) {
		Calendar c = Calendar.getInstance();
		
		c.setTime(date);
		
		c.set(Calendar.HOUR_OF_DAY, 23);
		c.set(Calendar.MINUTE, 59);
		c.set(Calendar.SECOND, 59);
		
		return c.getTime();
		
	}
}
