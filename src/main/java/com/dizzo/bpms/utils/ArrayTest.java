package com.dizzo.bpms.utils;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import com.dizzo.bpms.model.ApproveTray;
import com.dizzo.bpms.model.ApproveTrayType;

public class ArrayTest {

	public static void main(String[] args) {
		List<ApproveTray>	trays = new ArrayList<>();
		ApproveTray	tray = new ApproveTray();
		
		tray.setAppId("a");
		tray.setUserId("andrew");
		tray.setType(ApproveTrayType.COMPLETED.getType());
		
		trays.add(tray);
		
		tray = new ApproveTray();
		tray.setAppId("b");
		tray.setUserId("bigfoot");
		tray.setType(ApproveTrayType.UNDECIDE.getType());
		trays.add(tray);
		
		tray = new ApproveTray();
		tray.setAppId("b");
		tray.setUserId("bigfoot");
		tray.setType(ApproveTrayType.UNDECIDE.getType());
		
		System.out.println("trays: " + trays);
		System.out.println("tray: " + tray);

		Iterator<ApproveTray> it = trays.iterator();
		ApproveTray	t = null;
		
		while (it.hasNext()) {
			t = it.next();
			
			if (t.getUserId().equals(tray.getUserId())) {
				System.out.println(t);
				break;
			}
		}
		
		System.out.println("Found tray: " + t + ", indexOf: " + trays.indexOf(t));
	}

}
