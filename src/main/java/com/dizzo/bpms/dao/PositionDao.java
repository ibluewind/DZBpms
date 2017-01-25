package com.dizzo.bpms.dao;

import java.util.List;

import com.dizzo.bpms.model.Position;

public interface PositionDao {
	public Position	save(Position position);
	public Position	update(Position position);
	public Position	delete(String id);
	public List<Position>	getAll();
	public Position	getById(String id);
}
