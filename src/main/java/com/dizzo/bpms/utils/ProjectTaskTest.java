package com.dizzo.bpms.utils;

import java.util.Date;
import java.util.UUID;

import com.dizzo.bpms.model.Task;

public class ProjectTaskTest {

	public static void main(String[] args) {

		ProjectTask	task = new ProjectTask();
		
		task.setTaskId(UUID.randomUUID().toString());
		task.setTitle("테스트");
		task.setContent("테스트입니다.");
		task.setCreateDate(new Date());
		task.setCurrentRate(0);
		task.setUserId("andrew@chosun.com");
		task.setUserName("김현곤");
		task.setStatus("N");
		task.setEndDate(new Date());
		task.setPrevTaskId(UUID.randomUUID().toString());
		task.setNextTaskId(null);
		task.setPeriod(10);
		
		printTask(task);
	}

	private static void printTask(Task task) {
		System.out.println("DEBUG : task=" + task);
	}
}
