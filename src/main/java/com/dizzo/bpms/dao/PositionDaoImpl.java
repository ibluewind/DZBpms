package com.dizzo.bpms.dao;

import java.util.List;
import java.util.UUID;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.dizzo.bpms.model.Position;
import com.dizzo.bpms.model.PositionRowMapper;

@Repository("positionDao")
@Transactional
public class PositionDaoImpl implements PositionDao {

	@Autowired
	DataSource	dataSource;
	
	@Override
	public Position save(Position position) {
		String	query = "insert into position (id, name, type, seq) values (?, ?, ?, ?)";
		
		position.setId(UUID.randomUUID().toString());
		new JdbcTemplate(dataSource).update(query, new Object[] {
				position.getId(),
				position.getName(),
				position.getType(),
				position.getSeq()
		});
		
		return position;
	}

	@Override
	public Position update(Position position) {
		String	query = "update position set name=?, type=?, seq=? where id=?";
		
		new JdbcTemplate(dataSource).update(query, new Object[] {
				position.getName(),
				position.getType(),
				position.getSeq(),
				position.getId()
		});
		
		return position;
	}

	@Override
	public Position delete(String id) {
		String	query = "delete from position where id=?";
		Position	position = getById(id);
		
		new JdbcTemplate(dataSource).update(query, new Object[] {id});
		return position;
	}

	@Override
	public List<Position> getAll() {
		String	query = "select id, name, type, seq from position order by seq";
		
		return new JdbcTemplate(dataSource).query(query, new PositionRowMapper());
	}

	@Override
	public Position getById(String id) {
		String	query = "select id, name, type, seq from position where id=?";
		return new JdbcTemplate(dataSource).queryForObject(query, new Object[] {id}, new PositionRowMapper());
	}

}
