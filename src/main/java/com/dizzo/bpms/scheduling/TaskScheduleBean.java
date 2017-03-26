package com.dizzo.bpms.scheduling;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.scheduling.annotation.Scheduled;

public class TaskScheduleBean {

	@Autowired
	DataSource	dataSource;
	
	@Scheduled(cron="0 0 * * * *")
	public void checkTargetRate() {
		System.out.println("Task schedule running");
		/**
		 * 목표 완료율 = ((전체 기간 - 남은 기간) / 전체 기간) * 100 
		 */
		String query = "update task set targetRate=least(round((datediff(enddate, createDate) + 1 - datediff(enddate, now() + 1)) / (datediff(enddate, createDate) + 1) * 100, 0), 100)";
		new JdbcTemplate(dataSource).update(query);
		
		// 진행중인 작업 중에서 현재 완료율이 목표 완료율에 미치지 않는 작업들은 모두 지연으로 표시한다.
		query = "update task set status='L' where currentRate < targetRate and status in ('N', 'P')";
		new JdbcTemplate(dataSource).update(query);
	}
}
