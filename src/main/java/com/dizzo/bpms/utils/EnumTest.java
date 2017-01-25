package com.dizzo.bpms.utils;

import com.dizzo.bpms.model.ApproveStatus;
import com.dizzo.bpms.model.UserState;

public class EnumTest {

	public static void main(String[] args) {
		UserState	state = UserState.ACTIVE;
		
		System.out.println("userState: " + state.getState());
		System.out.println("RETIERED: " + UserState.RETIRED.getState());

		ApproveStatus	status = ApproveStatus.FINISH;
		System.out.println("status : " + status.getStatus());
		System.out.println("REJECT: " + ApproveStatus.REJECT.getStatus());
	}

}
