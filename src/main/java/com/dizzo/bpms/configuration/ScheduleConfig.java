package com.dizzo.bpms.configuration;

import java.util.concurrent.Executor;
import java.util.concurrent.Executors;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.SchedulingConfigurer;
import org.springframework.scheduling.config.ScheduledTaskRegistrar;

import com.dizzo.bpms.scheduling.TaskScheduleBean;

@Configuration
@EnableScheduling
@ComponentScan(basePackages="com.dizzo.bpms")
public class ScheduleConfig implements SchedulingConfigurer {

	@Bean
	public TaskScheduleBean bean() {
		return new TaskScheduleBean();
	}
	
	@Override
	public void configureTasks(ScheduledTaskRegistrar taskRegistrar) {
		taskRegistrar.setScheduler(taskExecutor());
	}

	@Bean(destroyMethod="shutdown")
	public Executor taskExecutor() {
		return Executors.newScheduledThreadPool(10);
	}
}
