package com.dizzo.bpms.dao;

import java.util.List;

import com.dizzo.bpms.model.FileAttach;

public interface FileAttachDao {

	public List<FileAttach>	listByMainId(String mainId);
	public FileAttach		save(FileAttach attach);
	public FileAttach		getByAttachId(String attachId);
	public FileAttach		getByFilename(String fileName);
	public FileAttach		update(FileAttach attach);
	public FileAttach		deleteByAttachId(String attachId);
	public List<FileAttach>	deleteAllByMainId(String mainId);
	public FileAttach		deleteByFileName(String fileName);
}
