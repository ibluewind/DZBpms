package com.dizzo.bpms.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dizzo.bpms.dao.PositionDao;
import com.dizzo.bpms.model.Position;

@Service("positionService")
public class PositionServiceImpl implements PositionService {

	@Autowired
	PositionDao		dao;
	
	@Override
	public Position save(Position position) {
		return dao.save(position);
	}

	@Override
	public Position update(Position position) {
		return dao.update(position);
	}

	@Override
	public Position delete(String id) {
		return dao.delete(id);
	}

	@Override
	public List<Position> list() {
		return dao.getAll();
	}

	@Override
	public Position getById(String id) {
		return dao.getById(id);
	}

}
