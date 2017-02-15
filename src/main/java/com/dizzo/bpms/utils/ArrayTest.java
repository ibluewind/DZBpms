package com.dizzo.bpms.utils;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import com.dizzo.bpms.model.ApproveLine;

public class ArrayTest {

	public static void main(String[] args) {
		List<ApproveLine> lines = new ArrayList<ApproveLine>();
		ApproveLine	line = new ApproveLine();
		
		line.setApprovalId("andrew");
		line.setType("R");
		
		lines.add(line);
		
		line = new ApproveLine();
		line.setApprovalId("dylee");
		line.setType("P");
		
		lines.add(line);
		
		line = new ApproveLine();
		line.setAppId("bigfoot");
		line.setType("R");
		
		lines.add(line);
		
		line = new ApproveLine();
		line.setApprovalId("kds");
		line.setType("P");
		
		lines.add(line);
		
		line = new ApproveLine();
		line.setApprovalId("yunju");
		line.setType("R");
		
		lines.add(line);
		
		System.out.println("lines: " + lines);
		
		List<ApproveLine>	pls = lines.stream().filter(t -> t.getType().equals("P")).collect(Collectors.toList());
		
		System.out.println("pls: " + pls);
	}

}
