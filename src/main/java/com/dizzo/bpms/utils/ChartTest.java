package com.dizzo.bpms.utils;

import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.stream.Collectors;

import com.dizzo.bpms.model.ChartData;

public class ChartTest {

	public static void main(String[] args) {
		List<ChartData>	list = new ArrayList<>();
		ChartData	chart = new ChartData();
		
		chart.setStatus("N");
		chart.setId("0a3849ba-c180-47e7-8118-a037d6f3c4ba");
		chart.setName("인터넷개발팀");
		chart.setCount(0);
		
		list.add(chart);
		
		chart = new ChartData();
		chart.setStatus("N");
		chart.setId("1939ef1e-b45b-4427-8473-602f10189344");
		chart.setName("CTS기술부");
		chart.setCount(0);
		list.add(chart);
		
		chart = new ChartData();
		chart.setStatus("N");
		chart.setId("361a569f-34c3-4520-baf7-f0d32abae6a0");
		chart.setName("시너지개발팀");
		chart.setCount(0);
		list.add(chart);
		
		chart = new ChartData();
		chart.setStatus("N");
		chart.setId("4dea7638-2eae-4e6d-865c-111bd6bf6769");
		chart.setName("CTS시스템팀");
		chart.setCount(0);
		list.add(chart);
		
		chart = new ChartData();
		chart.setStatus("N");
		chart.setId("9c247a2d-77b1-457a-ba9b-43c972125ab6");
		chart.setName("솔루션개발부");
		chart.setCount(0);
		list.add(chart);
		
		chart = new ChartData();
		chart.setStatus("N");
		chart.setId("b7bceead-35f2-465c-8b0d-e3819b1d622f");
		chart.setName("미디어기술부");
		chart.setCount(0);
		list.add(chart);
		
		chart = new ChartData();
		chart.setStatus("F");
		chart.setId("361a569f-34c3-4520-baf7-f0d32abae6a0");
		chart.setName("시너지개발팀");
		chart.setCount(1);
		list.add(chart);
		
		chart = new ChartData();
		chart.setStatus("F");
		chart.setId("d35c8fa9-7fe9-4820-accb-5dfa26b56689");
		chart.setName("시너지개발부");
		chart.setCount(1);
		list.add(chart);
		
		chart = new ChartData();
		chart.setStatus("L");
		chart.setId("361a569f-34c3-4520-baf7-f0d32abae6a0");
		chart.setName("시너지개발팀");
		chart.setCount(3);
		list.add(chart);
		
		System.out.println("list: " + list.stream().filter(t->t.getStatus().equals("F")).collect(Collectors.toList()));
		List<String> deptList = new ArrayList<String>();
		
		for (ChartData c: list) {
			if (!deptList.contains(c.getName()))
				deptList.add(c.getName());
		}
		
		
		List<Integer> finish = new ArrayList<Integer>();
		List<Integer> process = new ArrayList<Integer>();
		List<Integer> late = new ArrayList<Integer>();
		
		for (int i = 0; i < deptList.size(); i++) {
			finish.add(0);
			process.add(0);
			late.add(0);
		}
		
		
		// 부서 목록의 순서대로 data 값을 설정한다.
		for (int i = 0; i < deptList.size(); i++) {
			String name = deptList.get(i);
			
			// 이름으로 필터링을 하면, 3가지 상태에 대한 카운터 배열로 정리된다.
			// 배열에 있는 상태 값의 카운터를 각각의 상태값 목록에 저장한다.
			List<ChartData> data = list.stream().filter(t->t.getName().equals(name)).collect(Collectors.toList());
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
		
		System.out.println("deptList: " + deptList);
		System.out.println("finish: " + finish);
		System.out.println("process: " + process);
		System.out.println("late: " + late);
		
		List<List>	result = new ArrayList();
		List<List>	arr = new ArrayList<>();
		arr.add(process);
		arr.add(finish);
		arr.add(late);
		result.add(arr);
		result.add(deptList);
		
		System.out.println("result: " + result);
	}

}
