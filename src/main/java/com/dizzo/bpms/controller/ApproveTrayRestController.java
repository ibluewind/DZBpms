package com.dizzo.bpms.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.dizzo.bpms.model.ApproveTray;
import com.dizzo.bpms.model.ApproveTrayType;
import com.dizzo.bpms.service.ApproveTrayService;

@CrossOrigin(origins="*", maxAge=3600)
@RestController
@RequestMapping("/rest/approve/tray")
public class ApproveTrayRestController {

	@Autowired
	ApproveTrayService		trayService;
	
	@RequestMapping(method=RequestMethod.POST)
	public List<ApproveTray> saveTray(@RequestBody List<ApproveTray>trays) {
		System.out.println("DEBUG: saving approve trays : " + trays);
		return trayService.insertAll(trays);
	}
	
	/**
	 * 결재함 정보를 삭제한다.
	 * 반려된 문서를 재 상신하는 경우, 작성자의 결재함 정보를 삭제할 때 사용된다.
	 * @param tray
	 * @return
	 */
	@RequestMapping(value="/{userId}/{appId}", method=RequestMethod.DELETE)
	public ApproveTray deleteTray(@PathVariable String userId, @PathVariable String appId) {
		ApproveTray	tray = trayService.getApproveTrayForUser(userId, appId);
		
		System.out.println("DELETING tray: " + tray);
		return trayService.delete(tray);
	}
	/**
	 * 사용자의 모든 결재함 정보를 반환한다.
	 * 대시보드에서 사용된다.
	 * @return
	 */
	@RequestMapping(method=RequestMethod.GET)
	public List<ApproveTray> getAllTray() {
		return trayService.listByUserId(getPrincipal());
	}
	
	/**
	 * 결재함별 결재자의 결재문서 리스트 조회
	 * @param type
	 * @return
	 */
	@RequestMapping(value="/type/{type}", method=RequestMethod.GET)
	public List<ApproveTray> getTray(@PathVariable String type) {
		
		String	userId = getPrincipal();
		List<ApproveTray>	trays = null;
		
		System.out.println("DEBUG: getTray() type = " + type + ", userId = " + userId);
		
		if (type.equals(ApproveTrayType.UNDECIDE.getType())) {
			trays = trayService.undecideTray(userId);
		} else if (type.equals(ApproveTrayType.COMPLETED.getType())) {
			trays = trayService.completedTray(userId);
		} else if (type.equals(ApproveTrayType.FINISHED.getType())) {
			trays = trayService.finishedTray(userId);
		} else if (type.equals(ApproveTrayType.DEFER.getType())) {
			trays = trayService.deferTray(userId);
		} else if (type.equals(ApproveTrayType.EXPECTED.getType())) {
			trays = trayService.expectedTray(userId);
		} else if (type.equals(ApproveTrayType.REFER.getType())) {
			trays = trayService.referTray(userId);
		} else if (type.equals(ApproveTrayType.AGREE.getType())) {
			trays = trayService.agreeTray(userId);
		}
		
		return trays;
	}
	
	/**
	 * 사용자의 해당 결재 문서에 대한 결재함 정보 조회
	 * @param appId
	 * @return
	 */
	@RequestMapping(value="/user/{appId}", method=RequestMethod.GET)
	public ApproveTray getTrayForUserByApproveId(@PathVariable String appId) {
		String		userId = getPrincipal();
		
		return trayService.getApproveTrayForUser(userId, appId);
	}
	
	/**
	 * 결재문서에 대한 결재함 정보 목록 조회
	 * @param appId
	 * @return
	 */
	@RequestMapping(value="/doc/{appId}", method=RequestMethod.GET)
	public List<ApproveTray> getTrayByApproveId(@PathVariable String appId) {
		return trayService.listByAppId(appId);
	}
	
	/**
	 * 특정 tray 정보 수정
	 * 결재자가 결재시에 반려, 보류 등의 명령을 수행할 때 호출된다.
	 * @param tray
	 * @return
	 */
	@RequestMapping(method=RequestMethod.PUT)
	public ApproveTray updateApproveTray(@RequestBody ApproveTray tray) {
		System.out.println("DEBUG: update tray: " + tray);
		return trayService.update(tray);
	}
	
	private String getPrincipal() {
		return IndexController.getPrincipal();
	}
}
