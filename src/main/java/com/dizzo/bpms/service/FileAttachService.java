package com.dizzo.bpms.service;

import java.util.List;

import com.dizzo.bpms.model.FileAttach;

public interface FileAttachService {

	public	FileAttach			save(FileAttach fileAttach);
	public	List<FileAttach>	listByMainId(String mainId);
	public	FileAttach			getByAttachId(String attachId);
	public 	FileAttach			getByFilename(String fileName);
	public	List<FileAttach>	deleteAllByMainId(String mainId);
	public	FileAttach			deleteByFileName(String fileName);
	public	FileAttach			deleteByAttachId(String attachId);
}
