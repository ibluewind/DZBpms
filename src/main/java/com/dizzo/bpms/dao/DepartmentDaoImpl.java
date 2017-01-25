package com.dizzo.bpms.dao;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.sql.DataSource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.BatchPreparedStatementSetter;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.dizzo.bpms.model.Company;
import com.dizzo.bpms.model.Department;
import com.dizzo.bpms.model.DepartmentRowMapper;
import com.dizzo.bpms.model.DepartmentTree;
import com.dizzo.bpms.model.DocumentManager;
import com.dizzo.bpms.model.DocumentManagerRowMapper;

@Repository("departmentDao")
@Transactional
public class DepartmentDaoImpl implements DepartmentDao {
	
	private static final Logger	log = LoggerFactory.getLogger(DepartmentDaoImpl.class);
	
	@Autowired
	private DataSource		dataSource;
	
	@Override
	public List<Department> getAll(String companyId) {
		String	query = "select d.pid, d.deptid, d.name, p.name 'parentName', d.companyid, c.name 'companyName', d.useyn, d.lastmodified, d.depth"
					+ " from departments d, company c, (select deptid, name from departments) p"
					+ " where d.companyid=c.id and d.useyn='Y' and d.pid=p.deptid and c.id=?";
		return new JdbcTemplate(dataSource).query(query, new Object[] {companyId}, new DepartmentRowMapper());
	}

	@Override
	public Department getByDeptId(String deptId) {
		String	query = "select d.pid, p.name 'parentName', d.deptid, d.name, d.companyid, c.name 'companyName', d.useyn, d.lastmodified, d.depth"
				+ " from departments d, company c,"
				+ " (select deptid, name from departments) p"
				+ " where d.companyid=c.id and d.deptid=? and d.pid=p.deptid";
		Department	dept = null;
		
		JdbcTemplate	jdbcTemplate = new JdbcTemplate(dataSource);
		
		try {
			dept = jdbcTemplate.queryForObject(query, new Object[] {deptId}, new DepartmentRowMapper());
		} catch (EmptyResultDataAccessException e) {
			// 조회 결과가 없다면, 최상위 부서이거나 존재하지 않는 부서 아이디인데, 시스템 상으로 존재하지 않는 부서 아이디를 선택할 수 없으므로 최상위 부서에 대한
			// 조회 결과를 리턴한다.
			query = "SELECT '#' pid, "
					+ "c.name 'parentName', "
					+ "d.deptid, "
					+ "d.name, "
					+ "d.companyid, "
					+ "c.name 'companyName', "
					+ "d.useyn, "
					+ "d.lastmodified, "
					+ "d.depth "
					+ "FROM departments d, company c "
					+ "WHERE d.deptid = ? AND d.companyid = c.id";
			dept = jdbcTemplate.queryForObject(query, new Object[]{deptId}, new DepartmentRowMapper());
		}
		
		return dept;
	}
	
	@Override
	public Department getRootByCompanyId(String companyId) {
		String	query = "select d.pid, c.name 'parentName', d.deptid, d.name, d.companyid, c.name 'companyName', d.useyn, d.lastmodified, d.depth"
				+ " from departments d, company c"
				+ " where d.companyid=c.id and d.pid='#' and d.companyid=?";
		Department department = null;
		
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
		
		try {
			department = jdbcTemplate.queryForObject(query, new Object[] {companyId}, new DepartmentRowMapper());
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
		
		return department;
	}

	@Override
	public Department save(Department dept) {
		String	query = "insert into departments (companyid, pid, deptid, name, useyn, lastmodified, depth) values (?, ?, ?, ?, ?, now(), ?)";
		dept.setDeptId( UUID.randomUUID().toString());
		log.info("dept = {}", dept);
		new JdbcTemplate(dataSource).update(query, new Object[] {
				dept.getCompanyId(),
				dept.getpId(),
				dept.getDeptId(),
				dept.getName(),
				dept.getUseYN(),
				dept.getDepth()
		});
		
		return dept;
	}

	@Override
	public Department update(Department dept) {
		// update瑜� �뿀�슜�븯�뒗 �빆紐⑹� �긽�쐞遺��꽌, 遺��꽌紐�, 臾몄꽌愿�由ъ옄, �궗�슜�뿬遺�, �닔�젙�씪�옄 肉먯씠�떎.
		// �굹癒몄� �빆紐⑹� �닔�젙 遺덇�
		String	query = "update departments set pid=?, name=?, useyn=?, lastmodified=now(), depth=? where deptid=?";
		
		new JdbcTemplate(dataSource).update(query, new Object[] {
				dept.getpId(),
				dept.getName(),
				dept.getUseYN(),
				dept.getDepth(),
				dept.getDeptId()
		});
		
		return dept;
	}

	@Override
	public Department delete(String deptId) {
		// �떎�젣 �뀒�씠釉� row瑜� �궘�젣�븯吏� �븡怨�, �궗�슜�뿬遺�(useyn)�쓣 'D'濡� �꽭�똿�븳�떎.
		Department	dept = getByDeptId(deptId);
		String	query = "update departments set useyn='D' where deptid=?";
		
		new JdbcTemplate(dataSource).update(query, new Object[] {deptId});
		deleteDocumentManagers(deptId);
		return dept;
	}

	@Override
	public List<DepartmentTree> getJsTree(String companyId) {
		String	query = "select d.pid, d.deptid, d.name, 'parentName', d.companyid, c.name 'companyName', d.useyn, d.lastmodified, d.depth"
				+ " from departments d, company c"
				+ " where d.companyid=c.id and d.useyn='Y' and c.id=?";
		
		List<Department> deptList =new JdbcTemplate(dataSource).query(query, new Object[] {companyId}, new DepartmentRowMapper());
		List<DepartmentTree>	deptTree = new ArrayList<DepartmentTree>();
		
		for (Department dept : deptList) {
			DepartmentTree	dtree = new DepartmentTree();
			
			dtree.setId(dept.getDeptId());
			dtree.setParent(dept.getpId());
			dtree.setText(dept.getName());
			dtree.setDepth(dept.getDepth());
			
			deptTree.add(dtree);
		}
		
		return deptTree;
	}

	@Override
	public void createRootDepartment(Company company) {
		String	query = "insert into departments (pid, deptid, name, companyid, useyn, lastmodified, depth) "
				+ " values ('#', uuid(), ?, ?, 'Y', now(), 0)";
		new JdbcTemplate(dataSource).update(query, new Object[] {
				company.getName(),
				company.getId()
		});
	}

	@Override
	public List<DocumentManager> getDocumentManagersByDeptId(String deptId) {
		String	query = "select d.deptId, u.userId, concat(u.lastName, u.firstName) userName, d.type "
				+ " from dept_docmanager d, users u "
				+ " where d.deptId=? and d.docmanager=u.userId";
		
		return new JdbcTemplate(dataSource).query(query, new Object[] {deptId}, new DocumentManagerRowMapper());
	}

	@Override
	public List<DocumentManager> saveDocumentManagers(List<DocumentManager> managers) {
		String	query = "insert into dept_docmanager (deptId, docmanager, type) values (?, ?, ?)";
		
		new JdbcTemplate(dataSource).batchUpdate(query, new BatchPreparedStatementSetter() {
			
			@Override
			public void setValues(PreparedStatement ps, int idx) throws SQLException {
				ps.setString(1, managers.get(idx).getDeptId());
				ps.setString(2, managers.get(idx).getUserId());
				ps.setString(3, managers.get(idx).getType());
			}
			
			@Override
			public int getBatchSize() {
				return managers.size();
			}
		});
		return managers;
	}

	@Override
	public List<DocumentManager> updateDocumentManager(List<DocumentManager> managers) {
		String	deptId = managers.get(0).getDeptId();
		deleteDocumentManagers(deptId);
		return saveDocumentManagers(managers);
	}

	@Override
	public void deleteDocumentManagers(String deptId) {
		String	query = "delete from dept_docmanager where deptId=?";
		new JdbcTemplate(dataSource).update(query, new Object[]{deptId});
		return;
	}

}
