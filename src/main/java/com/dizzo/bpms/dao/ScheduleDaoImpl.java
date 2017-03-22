package com.dizzo.bpms.dao;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.UUID;
import java.util.concurrent.TimeUnit;

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
					 + " s.refId,"
					 + " concat(u.lastName, u.firstName) 'userName'"
					 + " FROM schedule s,"
					 + " users u"
					 + " WHERE     s.userId = u.userid"
					 + " AND s.id = ?";
		return new JdbcTemplate(dataSource).queryForObject(query, new Object[]{id}, new ScheduleRowMapper()); 
	}

	@Override
	public Schedule getByRefId(String refId) {
		String query = "  SELECT s.id,"
				 + " s.userId,"
				 + " s.title,"
				 + " s.start,"
				 + " s.end,"
				 + " s.content,"
				 + " s.referUrl,"
				 + " s.type,"
				 + " s.refId,"
				 + " concat(u.lastName, u.firstName) 'userName'"
				 + " FROM schedule s,"
				 + " users u"
				 + " WHERE     s.userId = u.userid"
				 + " AND s.refId = ?";
		
		return new JdbcTemplate(dataSource).queryForObject(query, new Object[]{refId}, new ScheduleRowMapper()); 
	}

	/**
	 * 캘린더에서 필요한 일정 목록을 조회한다.
	 * 월단위 조회는 해당월을 주단위로 나누어 조회한 후, 결과를 하나로 조인한다.
	 * 주, 일 단위 조회는 한번에 조회한다.
	 * 시작일과 완료일의 차이가 한달이라면, 시작주의 월요일 날짜와 완료주의 토요일 날짜를 구해서 조회를 반복해야한다.
	 */
	@Override
	public List<Schedule> list(Date start, Date end) {
		String query = "  SELECT s.id,"
					 + " s.userId,"
					 + " s.title,"
					 + " s.start,"
					 + " s.end,"
					 + " s.content,"
					 + " s.referUrl,"
					 + " s.type,"
					 + " s.refId,"
					 + " concat(u.lastName, u.firstName) 'userName'"
					 + " FROM schedule s,"
					 + " users u"
					 + " WHERE"
					 + " (s.start BETWEEN ? AND ?"
					 + " OR ? BETWEEN s.start AND s.end)"
				     + " AND s.userId = u.userid"
					 + " ORDER BY s.start";
		Calendar	scal = Calendar.getInstance();
		Calendar	ecal = Calendar.getInstance();
		List<Schedule>	scheduleList = new ArrayList<>();
		JdbcTemplate	jdbcTemplate = new JdbcTemplate(dataSource);
		
		scal.setTime(start);
		ecal.setTime(end);
		
		System.out.println("start: " + start + ", end: " + end);
		int	dateDiff = getDateDiff(scal, ecal);
		int numOfWeeks = (int) Math.ceil(dateDiff / 7) + 1;
		
		System.out.println("numOfWeeks = " + numOfWeeks);
		for (int i = 0; i < numOfWeeks; i++) {
			ecal = (Calendar) scal.clone();
			if (dateDiff > 0) ecal.add(Calendar.DATE, 6);
			List<Schedule>	schedules = new ArrayList<>();
			
			System.out.println("start: " + scal.getTime()  + ", end = " + ecal.getTime());
			schedules = jdbcTemplate.query(query, new Object[]{
														String.format("%04d-%02d-%02d 00:00:00", scal.get(Calendar.YEAR), scal.get(Calendar.MONTH) + 1, scal.get(Calendar.DATE)),
														String.format("%04d-%02d-%02d 23:59:59", ecal.get(Calendar.YEAR), ecal.get(Calendar.MONTH) + 1, ecal.get(Calendar.DATE)),
														String.format("%04d-%02d-%02d 00:00:00", scal.get(Calendar.YEAR), scal.get(Calendar.MONTH) + 1, scal.get(Calendar.DATE))
													}, new ScheduleRowMapper());
			
			schedules = reAssignDate(schedules, scal, ecal);
			scheduleList.addAll(schedules);
			
			ecal.add(Calendar.DATE, 1);
			scal = (Calendar) ecal.clone();
		}
		
		return scheduleList;
	}

	@Override
	public Schedule save(Schedule schedule) {
		String	query = "INSERT INTO schedule (id, userId, start, end, type, content, referUrl, refId, title) "
					  + " VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
		
		schedule.setId(UUID.randomUUID().toString());
		
		System.out.println("save schedule: " + schedule);
		new JdbcTemplate(dataSource).update(query, new Object[] {
			schedule.getId(),
			schedule.getUserId(),
			schedule.getStartDate(),
			schedule.getEndDate(),
			schedule.getType(),
			schedule.getContent(),
			schedule.getRefUrl(),
			schedule.getRefId(),
			schedule.getTitle()
		});
		
		return schedule;
	}

	@Override
	public Schedule update(Schedule schedule) {
		String	query = "UPDATE schedule SET start = ?, end = ?, type = ?, content = ?, referUrl = ?, refId=?, title = ?"
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
			schedule.getRefId(),
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

	private int getDateDiff(Calendar start, Calendar end) {
		return (int) TimeUnit.DAYS.convert(end.getTimeInMillis() - start.getTimeInMillis(), TimeUnit.MILLISECONDS);
	}
	
	private List<Schedule> reAssignDate(List<Schedule> schedules, Calendar start, Calendar end) {
		List<Schedule>	list = new ArrayList<>(schedules);
		
		for (int i = 0; i < list.size(); i++) {
			Calendar s = Calendar.getInstance();
			Calendar e = Calendar.getInstance();
			
			s.setTime(list.get(i).getStartDate());
			e.setTime(list.get(i).getEndDate());
			
			// 시작일 정리
			if (s.before(start)) {
				s.set(start.get(Calendar.YEAR), start.get(Calendar.MONTH), start.get(Calendar.DAY_OF_MONTH));
				list.get(i).getStartDate().setTime(s.getTimeInMillis());
			}
			if (e.after(end)) {
				e.set(end.get(Calendar.YEAR), end.get(Calendar.MONTH), end.get(Calendar.DAY_OF_MONTH));
				list.get(i).getEndDate().setTime(e.getTimeInMillis());
			}
		}
		return list;
	}
}
