package com.dizzo.bpms.dao;

import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.dizzo.bpms.model.Task;
import com.dizzo.bpms.model.TaskRowMapper;

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
		String query = "insert into task (taskId, userId, workerId, createDate, endDate, status, priority, targetRate, currentRate, opened, title, content) "
					+ " values (?, ?, ?, now(), ?, ?, ?, ?, ?, ?, ?, ?)";
		
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
		
		return task;
	}

	@Override
	public List<Task> listByWorker(String userId) {
		String	query = "select t.taskId, t.userId, concat(u.lastName, u.firstName) 'userName', workerId, w.userName 'workerName', t.createDate, t.endDate,"
				+" t.status, t.priority, t.targetRate, t.currentRate, t.opened, t.title, t.content"
				+ " from task t, users u, (select userId, concat(lastName, firstName) 'userName' from users) w"
				+ " where t.workerId=? and t.workerId=w.userId and t.userId=u.userId";
		
		List<Task>	tasks = new JdbcTemplate(dataSource).query(query, new Object[] {userId}, new TaskRowMapper());
		return tasks;
	}

	@Override
	public List<Task> listByCreator(String userId) {
		String	query = "select t.taskId, t.userId, concat(u.lastName, u.firstName) 'userName', workerId, w.userName 'workerName', t.createDate, t.endDate,"
				+" t.status, t.priority, t.targetRate, t.currentRate, t.opened, t.title, t.content"
				+ " from task t, users u, (select userId, concat(lastName, firstName) 'userName' from users) w"
				+ " where t.userId=? and t.workerId=w.userId and t.userId=u.userId";
		
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
}
