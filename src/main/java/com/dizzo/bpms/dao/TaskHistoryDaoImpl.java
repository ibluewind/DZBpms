package com.dizzo.bpms.dao;

import java.util.List;
import java.util.UUID;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.dizzo.bpms.model.TaskHistory;
import com.dizzo.bpms.model.TaskHistoryRowMapper;

@Repository("taskHistoryDao")
@Transactional
public class TaskHistoryDaoImpl implements TaskHistoryDao {

	@Autowired
	DataSource		dataSource;
	
	@Override
	public TaskHistory save(TaskHistory taskHistory) {
		String	query = "insert into task_history (historyId, taskId, comment, created, creator, worker, action, procRate)"
						+ " values (?, ?, ?, now(), ?, ?, ?, ?)";
		
		taskHistory.setHistoryId(UUID.randomUUID().toString());
		new JdbcTemplate(dataSource).update(query, new Object[] {
			taskHistory.getHistoryId(),
			taskHistory.getTaskId(),
			taskHistory.getComment(),
			taskHistory.getCreator(),
			taskHistory.getWorker(),
			taskHistory.getAction(),
			taskHistory.getProcRate()
		});
		
		return taskHistory;
	}

	@Override
	public List<TaskHistory> listByTaskId(String taskId) {
		String	query = "select t.historyId, t.taskId, t.comment, t.created, t.creator, c.userName 'creatorName', t.worker, w.userName 'workerName', t.action, t.procRate"
					  + " from task_history t, (select userid, concat(lastName, firstName) 'userName' from users) c,"
					  + " (select userid, concat(lastName, firstName) 'userName' from users) w"
					  + " where t.taskId=? and t.creator=c.userid and w.userid=t.worker"
					  + " order by t.created";
		List<TaskHistory> tasks = new JdbcTemplate(dataSource).query(query, new Object[] {taskId}, new TaskHistoryRowMapper());
		System.out.println("TASKS: " + tasks);
		return tasks;
	}

	@Override
	public TaskHistory getByHitoryId(String historyId) {
		String	query = "select t.historyId, t.taskId, t.comment, t.created, t.creator, c.userName 'creatorName', t.worker, w.userName 'workerName', t.action, t.procRate"
				  + " from task_history t, (select userid, concat(lastName, firstName) 'userName' from users) c,"
				  + " (select userid, concat(lastName, firstName) 'userName' from users) w"
				  + " where t.historyId=? and t.creator=c.userid and w.userid=t.worker";
		
		return new JdbcTemplate(dataSource).queryForObject(query, new Object[] {historyId}, new TaskHistoryRowMapper());
	}
}