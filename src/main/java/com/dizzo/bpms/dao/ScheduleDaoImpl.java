package com.dizzo.bpms.dao;

import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.dizzo.bpms.model.Schedule;
import com.dizzo.bpms.model.ScheduleRowMapper;

@Repository("scheduleDao")

public class ScheduleDaoImpl implements ScheduleDao {

	@Autowired
	DataSource		dataSource;
	
	@Override
	public Schedule get(String id) {
		String query = "  SELECT s.id,"
					 + " s.userId,"
					 + " s.title,"
					 + " s.start,"
					 + " s.end,"
					 + " s.content,"
					 + " s.referUrl,"
					 + " s.type,"
					 + " concat(u.lastName, u.firstName) 'userName',"
					 + " d.name 'deptName',"
					 + " p.name 'positionName'"
					 + " FROM schedule s,"
					 + " users u,"
					 + " user_dept_position udp,"
					 + " position p,"
					 + " departments d"
					 + " WHERE     s.userId = u.userid"
					 + " AND udp.userid = s.userid"
					 + " AND p.id = udp.positionid"
					 + " AND d.deptid = udp.deptid"
					 + " AND s.id = ?"
					 + " GROUP BY s.userId";
		return new JdbcTemplate(dataSource).queryForObject(query, new Object[]{id}, new ScheduleRowMapper()); 
	}

	@Override
	public List<Schedule> list(String userId, Date start, Date end) {
		String query = "  SELECT s.id,"
					 + " s.userId,"
					 + " s.title,"
					 + " s.start,"
					 + " s.end,"
					 + " s.content,"
					 + " s.referUrl,"
					 + " s.type,"
					 + " concat(u.lastName, u.firstName) 'userName',"
					 + " d.name 'deptName',"
					 + " p.name 'positionName'"
					 + " FROM schedule s,"
					 + " users u,"
					 + " user_dept_position udp,"
					 + " position p,"
					 + " departments d"
					 + " WHERE     s.userId = u.userid"
					 + " AND udp.userid = s.userid"
					 + " AND p.id = udp.positionid"
					 + " AND d.deptid = udp.deptid"
					 + " AND s.userId = ?"
					 + " AND s.start BETWEEN ? AND ?"
					 + " GROUP BY s.id"
					 + " ORDER BY s.start";
		Calendar	scal = Calendar.getInstance();
		Calendar	ecal = Calendar.getInstance();
		
		scal.setTime(start);
		ecal.setTime(end);
		
		return new JdbcTemplate(dataSource).query(query, new Object[]{
			userId,
			String.format("%04d-%02d-%02d 00:00:00", scal.get(Calendar.YEAR), scal.get(Calendar.MONTH) + 1, scal.get(Calendar.DATE)),
			String.format("%04d-%02d-%02d 23:59:59", ecal.get(Calendar.YEAR), ecal.get(Calendar.MONTH) + 1, ecal.get(Calendar.DATE)),
		}, new ScheduleRowMapper());
	}

	@Override
	public Schedule save(Schedule schedule) {
		String	query = "INSERT INTO schedule (id, userId, start, end, type, content, referUrl, title) "
					  + " VLAUES (?, ?, ?, ?, ?, ?, ?, ?)";
		
		schedule.setId(UUID.randomUUID().toString());
		new JdbcTemplate(dataSource).update(query, new Object[] {
			schedule.getId(),
			schedule.getUserId(),
			schedule.getStartDate(),
			schedule.getEndDate(),
			schedule.getType(),
			schedule.getContent(),
			schedule.getRefUrl(),
			schedule.getTitle()
		});
		
		return schedule;
	}

	@Override
	public Schedule update(Schedule schedule) {
		String	query = "UPDATE schedule SET start = ?, end = ?, type = ?, content = ?, referUrl = ?, title = ?"
					  + " WHERE id = ?";
		Calendar	scal = Calendar.getInstance(), ecal = Calendar.getInstance();
		scal.setTime(schedule.getStartDate());
		ecal.setTime(schedule.getEndDate());
		
		new JdbcTemplate(dataSource).update(query, new Object[] {
			String.format("%04d-%02d-%02d %02d:%02d:%02d", scal.get(Calendar.YEAR), scal.get(Calendar.MONTH) + 1, scal.get(Calendar.DATE), scal.get(Calendar.HOUR_OF_DAY), scal.get(Calendar.MINUTE), scal.get(Calendar.SECOND)),
			String.format("%04d-%02d-%02d %02d:%02d:%02d", ecal.get(Calendar.YEAR), ecal.get(Calendar.MONTH) + 1, ecal.get(Calendar.DATE), ecal.get(Calendar.HOUR_OF_DAY), ecal.get(Calendar.MINUTE), ecal.get(Calendar.SECOND)),
			schedule.getType(),
			schedule.getContent(),
			schedule.getRefUrl(),
			schedule.getTitle(),
			schedule.getId()
		});
		
		return schedule;
	}

	@Override
	public Schedule delete(String id) {
		String query = "DELETE FROM schedule WHERE id = ?";
		Schedule schedule = get(id);
		
		new JdbcTemplate(dataSource).update(query, new Object[] { id });
		return schedule;
	}

}
