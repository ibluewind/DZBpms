package com.dizzo.bpms.dao;

import java.util.List;
import java.util.UUID;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.dizzo.bpms.model.Authority;
import com.dizzo.bpms.model.AuthorityRowMapper;

@Repository("authorityDao")
@Transactional
public class AuthorityDaoImpl implements AuthorityDao {

	@Autowired
	DataSource		dataSource;
	
	@Override
	public Authority save(Authority authority) {
		String	query = "insert into authority (id, rolename, comment) values (?, ?, ?)";
		authority.setAuthId(UUID.randomUUID().toString());
		new JdbcTemplate(dataSource).update(query, new Object[] { authority.getAuthId(), authority.getRoleName(), authority.getComment() });
		return authority;
	}

	@Override
	public Authority getById(String id) {
		String	query = "select id, rolename, comment from authority where id=?";
		
		try {
			return new JdbcTemplate(dataSource).queryForObject(query, new Object[] { id }, new AuthorityRowMapper());
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}

	@Override
	public List<Authority> getAll() {
		String	query = "select id, rolename, comment from authority";
		
		return new JdbcTemplate(dataSource).query(query, new AuthorityRowMapper());
	}

	@Override
	public Authority update(Authority authority) {
		String	query = "update authority set rolename=?, comment=? where id=?";
		new JdbcTemplate(dataSource).update(query, new Object[] {
				authority.getRoleName(),
				authority.getComment(),
				authority.getAuthId()
		});
		
		return authority;
	}

	@Override
	public Authority delete(String id) {
		String	query = "delete from authority where id=?";
		Authority	auth = getById(id);
		new JdbcTemplate(dataSource).update(query, new Object[] {id});
		return auth; 
	}

}
