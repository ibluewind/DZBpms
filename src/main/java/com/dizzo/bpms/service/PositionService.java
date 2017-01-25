package com.dizzo.bpms.service;

import java.util.List;

import com.dizzo.bpms.model.Position;

public interface PositionService {
	public Position save(Position position);
	public Position update(Position position);
	public Position delete(String id);
	public List<Position>	list();
	public Position getById(String id);
}
