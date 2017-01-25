package com.dizzo.bpms.service;

import java.io.File;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dizzo.bpms.dao.FileAttachDao;
import com.dizzo.bpms.model.FileAttach;

@Service("fileAttachService")
public class FileAttachServiceImpl implements FileAttachService {

	@Autowired
	FileAttachDao	dao;
	
	@Override
	public FileAttach save(FileAttach taskAttach) {
		return dao.save(taskAttach);
	}

	@Override
	public List<FileAttach> listByMainId(String mainId) {
		return dao.listByMainId(mainId);
	}

	@Override
	public FileAttach getByAttachId(String attachId) {
		return dao.getByAttachId(attachId);
	}

	@Override
	public FileAttach getByFilename(String fileName) {
		return dao.getByFilename(fileName);
	}

	@Override
	public List<FileAttach> deleteAllByMainId(String mainId) {
		List<FileAttach> attaches = dao.deleteAllByMainId(mainId);
		for (FileAttach attach : attaches) {
			new File(attach.getPath() + attach.getName()).delete();
		}
		
		return attaches;
	}

	@Override
	public FileAttach deleteByFileName(String fileName) {
		FileAttach file = dao.deleteByFileName(fileName);
		new File(file.getPath() + file.getName()).delete();
		return file;
	}

	@Override
	public FileAttach deleteByAttachId(String attachId) {
		FileAttach file = dao.deleteByAttachId(attachId);
		new File(file.getPath() + file.getName()).delete();
		return file;
	}

}
