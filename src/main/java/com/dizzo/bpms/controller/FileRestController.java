package com.dizzo.bpms.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.dizzo.bpms.model.FileAttach;
import com.dizzo.bpms.service.FileAttachService;

@CrossOrigin(origins="*", maxAge=3600)
@RestController
@RequestMapping("/rest/file")
public class FileRestController {

	@Autowired
	FileAttachService	fileAttachService;
	
	@RequestMapping(value="/{mainId}", method=RequestMethod.GET)
	public List<FileAttach> listAttachFileByMainId(@PathVariable String mainId) {
		return fileAttachService.listByMainId(mainId);
	}
	
	@RequestMapping(method=RequestMethod.POST)
	public List<FileAttach> saveAttachFile(@RequestBody List<FileAttach> files) {
		for (FileAttach file : files) {
			System.out.println("attach File : " + file);
			fileAttachService.save(file);
		}
		return files;
	}
	
	/*
	 * 파일명에 '.'이 있으므로 url value를 '/'로 닫아야 함.
	 */
	@RequestMapping(value="/{name}/", method=RequestMethod.DELETE, produces="application/json")
	public FileAttach deleteAttachFile(@PathVariable String name) {
		System.out.println("delete Attach file : " + name);
		FileAttach attach = new FileAttach();
		attach.setName(name);
		fileAttachService.deleteByFileName(name);
		
		return attach;
	}
}
