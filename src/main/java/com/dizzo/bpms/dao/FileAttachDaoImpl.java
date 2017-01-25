package com.dizzo.bpms.dao;

import java.io.File;
import java.util.List;
import java.util.UUID;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.dizzo.bpms.controller.FileController;
import com.dizzo.bpms.model.FileAttach;
import com.dizzo.bpms.model.FileAttachRowMapper;

@Repository("taskAttachDao")
@Transactional
public class FileAttachDaoImpl implements FileAttachDao {

	@Autowired
	DataSource	dataSource;
	
	@Override
	public List<FileAttach> listByMainId(String mainId) {
		String	query = "select attachId, type, path, name, originName, mainId, modified, size from file_attach"
				+ " where mainId=?";
		return new JdbcTemplate(dataSource).query(query, new Object[] {mainId}, new FileAttachRowMapper());
	}

	@Override
	public FileAttach save(FileAttach attach) {
		String	query = "insert into file_attach (attachId, type, path, name, originName, mainId, modified, size)"
				+ " values (?, ?, ?, ?, ?, ?, now(), ?)";
		attach.setAttachId(UUID.randomUUID().toString());		//TODO attachId는 파일을 업로드할 때, 생성될 수 있다. 확인 필요!!!
		new JdbcTemplate(dataSource).update(query, new Object[] {
			attach.getAttachId(),
			attach.getType(),
			attach.getPath(),
			attach.getName(),
			attach.getOriginName(),
			attach.getMainId(),
			attach.getSize()
		});
		return attach;
	}

	@Override
	public FileAttach getByAttachId(String attachId) {
		String	query = "select attachId, type,  path, name, originName, mainId, modified, size from file_attach"
				+ " where attachId=?";
		return new JdbcTemplate(dataSource).queryForObject(query, new Object[] {attachId}, new FileAttachRowMapper());
	}
	
	@Override
	public FileAttach getByFilename(String fileName) {
		String query = "select attachId, type,  path, name, originName, mainId, modified, size from file_attach"
				+ " where name=?";
		return new JdbcTemplate(dataSource).queryForObject(query, new Object[] {fileName}, new FileAttachRowMapper());
	}

	@Override
	public FileAttach update(FileAttach attach) {
		String query = "update file_attach set type=?, path=?, name=?, modified=now() where attachId=?";
		
		new JdbcTemplate(dataSource).update(query, new Object[] {
			attach.getType(),
			attach.getPath(),
			attach.getName(),
			attach.getAttachId()
		});
		return attach;
	}

	@Override
	public FileAttach deleteByAttachId(String attachId) {
		FileAttach	attach = getByAttachId(attachId);
		String	query = "delete from file_attach where attachId=?";
		new File(FileController.UPLOAD_LOCATION + attach.getName()).delete();
		new JdbcTemplate(dataSource).update(query, new Object[]{attachId});
		return attach;
	}

	@Override
	public List<FileAttach> deleteAllByMainId(String mainId) {
		List<FileAttach>	attaches = listByMainId(mainId);
		String	query = "delete from file_attach where mainId=?";
		
		new JdbcTemplate(dataSource).update(query, new Object[]{mainId});
		return attaches;
	}

	@Override
	public FileAttach deleteByFileName(String fileName) {
		FileAttach file = getByFilename(fileName);
		return deleteByAttachId(file.getAttachId());
	}

}
