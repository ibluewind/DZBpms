package com.dizzo.bpms.dao;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.BatchPreparedStatementSetter;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.dizzo.bpms.model.Company;
import com.dizzo.bpms.model.CompanyRowMapper;
import com.dizzo.bpms.model.User;
import com.dizzo.bpms.model.UserAuthority;
import com.dizzo.bpms.model.UserAuthorityRowMapper;
import com.dizzo.bpms.model.UserDepartmentPosition;
import com.dizzo.bpms.model.UserDepartmentPositionRowMapper;
import com.dizzo.bpms.model.UserRowMapper;

@Repository("userDao")
@Transactional
public class UserDaoImpl implements UserDao {

	@Autowired
	DataSource		dataSource;
	
	@Override
	public User save(User user) {
		System.out.println("save User : " + user);
		// �궗�슜�옄�쓽 湲곕낯�젙蹂댁� 遺��꽌 �젙蹂�, 沅뚰븳怨� 吏곴툒 �벑�쓣 �븳踰덉뿉 �벑濡앺빐�빞 �븳�떎.
		JdbcTemplate	jdbcTemplate = new JdbcTemplate(dataSource);
		String	query = "insert into users (userid, firstname, lastname, password, state) "
				+ "values (?, ?, ?, ?, ?)";
		
		try {
			jdbcTemplate.update(query, new Object[] {
				user.getUserId(),
				user.getFirstName(),
				user.getLastName(),
				user.getPassword(),
				user.getState()
			});
		} catch (DataAccessException ex) {
			query ="update users set state='Y' where userid=?";
			jdbcTemplate.update(query, new Object[] {user.getUserId()});
		}
		
		insertUserDepartmentPositionAuthorityInfomation(jdbcTemplate, user);
		
		return getByUserId(user.getUserId());
	}

	@Override
	public User update(User user) {
		String	query = "update users set firstname=?, lastname=?, password=?, state=? where userid=?";
		JdbcTemplate	jdbcTemplate = new JdbcTemplate(dataSource);
		
		jdbcTemplate.update(query, new Object[] {
			user.getFirstName(),
			user.getLastName(),
			user.getPassword(),
			user.getState(),
			user.getUserId()
		});
		
		// �궗�슜�옄 遺��꽌/吏곴툒 �젙蹂� �닔�젙
		query = "delete from user_dept_position where userid=?";
		jdbcTemplate.update(query, new Object[] {user.getUserId()});
		
		query = "delete from user_authority where userid=?";
		jdbcTemplate.update(query, new Object[] {user.getUserId()});
		
		insertUserDepartmentPositionAuthorityInfomation(jdbcTemplate, user);
		
		return user;
	}

	/**
	 * �궗�슜�옄 �뀒�씠釉붿쓣 �궘�젣 �몴�떆瑜� �븯怨�, �굹癒몄� 遺��꽌�젙蹂댄뀒�씠釉�(user_dept_position)怨� 沅뚰븳�젙蹂댄뀒�씠釉�(user_authority)�뿉�꽌�뒗 �궘�젣�븳�떎.
	 */
	@Override
	public User delete(String userId) {
		String	query = "update users set state='D' where userid=?";
		User	user = getByUserId(userId);
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
		Object[]	objId = new Object[] { userId };
		
		jdbcTemplate.update(query, objId);
		
		query = "delete from user_dept_position where userid=?";
		jdbcTemplate.update(query, objId);
		
		query = "delete from user_authrity where userid=?";
		jdbcTemplate.update(query, objId);
		return user;
	}

	@Override
	public User getByUserId(String userId) {
		String	query = "select userid, firstname, lastname, password, state, 'deptid', 'deptname', 'positionid', 'positionname', 'positiontype' from users where userid=?";
		User	user = null;
		List<UserDepartmentPosition> deptPositions = null;
		List<UserAuthority>			userAuthorities = null;
		List<Company>				companies = null;
		
		try {
			user = new JdbcTemplate(dataSource).queryForObject(query, new Object[] {userId}, new UserRowMapper());
			
			query = "select udp.userid, d.deptid 'deptid', d.name 'deptname', p.id 'positionid', p.name 'positionname', p.type 'positiontype'"
					+ " from users u, user_dept_position udp, departments d, position p"
					+ " where udp.userid = u.userid and u.userid=? and d.deptid=udp.deptid and p.id=udp.positionid";
			deptPositions = new JdbcTemplate(dataSource).query(query, new Object[] {userId}, new UserDepartmentPositionRowMapper());
			
			user.setDeptPositions(deptPositions);
			
			query = "select ua.userid, ua.authid, a.rolename"
					+ " from user_authority ua, authority a"
					+ " where ua.userid=? and ua.authid = a.id";
			userAuthorities = new JdbcTemplate(dataSource).query(query, new Object[] {userId}, new UserAuthorityRowMapper());
			
			user.setUserAuthorities(userAuthorities);
			
			query = "select c.id, c.name, c.ceo"
					+ " from company c, departments d, user_dept_position udp, users u"
					+ " where u.userid=? and u.userid=udp.userid and d.deptid=udp.deptid and d.companyid=c.id";
			companies = new JdbcTemplate(dataSource).query(query, new Object[] {userId}, new CompanyRowMapper());
			
			user.setCompanies(companies);
			
			System.out.println(user);
			return user;
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}

	@Override
	public List<User> getAll() {
		String query = "select id, userid, firstname, lastname, password, state, -9999 'positionid', 'positionname', 'positiontype' from users where state='Y'";
		
		try {
			return new JdbcTemplate(dataSource).query(query, new UserRowMapper());
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}

	@Override
	/**
	 * 부서의 사용자 목록을 조회한다.
	 * 겸직 때문에 한 부서에 같은 사람이 여러번 조회될 수 있다.
	 * 모든 사람은 반드시 하나의 직급을 가지고 있으므로, 직급으로만 조회한다.
	 * 하지만, 부서에 직책만 가지고 있는 사람이 있을 수 있는데, 이러면 담당자가 조회 되지 않는다.
	 */
	public List<User> getListByDeptarment(String deptId) {
		String	query = "SELECT u.userid,"
					  + " u.firstname,"
					  + " u.lastname,"
         				  + " u.password,"
         				  + " u.state,"
         				  + " d.deptid,"
         				  + " d.name 'deptname',"
         				  + " p.id 'positionid',"
         				  + " p.name 'positionname',"
         				  + " p.type 'positiontype'"
    				  + " FROM users u,"
         				  + " user_dept_position dp,"
         				  + " position p,"
         				  + " departments d"
   				  + " WHERE     u.state = 'Y'"
         				  + " AND dp.userid = u.userid"
         				  + " AND dp.deptid = ?"
         				  + " AND dp.positionid = p.id"
         				  + " AND d.deptid = dp.deptid"
				  + " GROUP BY u.userid"
				  + " ORDER BY p.seq DESC";
		return new JdbcTemplate(dataSource).query(query, new Object[] {deptId}, new UserRowMapper());
	}

	@Override
	public List<User> getListByCompany(String companyId) {
		return null;
	}

	private void insertUserDepartmentPositionAuthorityInfomation(JdbcTemplate jdbcTemplate, User user) {
		String	query = null;
		
		// user_dept_position �벑濡�
		query = "insert into user_dept_position (userid, deptid, positionid) values (?, ?, ?)";
		
		final List<UserDepartmentPosition>	userDepartmentPositions = user.getDeptPositions();
		System.out.println("Save user_dept_position : " + userDepartmentPositions.size());
		for (int i = 0; i < userDepartmentPositions.size(); i++) {
			System.out.println("DepartPosition[" + i + "] = " + userDepartmentPositions.get(i));
		}
		jdbcTemplate.batchUpdate(query, new BatchPreparedStatementSetter() {
			
			@Override
			public void setValues(PreparedStatement ps, int i) throws SQLException {
				ps.setString(1, userDepartmentPositions.get(i).getUserId());
				ps.setString(2, userDepartmentPositions.get(i).getDeptId());
				ps.setString(3, userDepartmentPositions.get(i).getPositionId());
			}
			
			@Override
			public int getBatchSize() {
				return userDepartmentPositions.size();
			}
		});
		
		// user_authority �벑濡�
		query = "insert into user_authority(userid, authid) values (?, ?)";
		
		final List<UserAuthority>		userAuthorities = user.getUserAuthorities();
		System.out.println("Save UserAuthority : " + userAuthorities.size());
		for (int i = 0; i < userAuthorities.size(); i++) {
			System.out.println("UserAuthority[" + i + "] = " + userAuthorities.get(i));
		}
		jdbcTemplate.batchUpdate(query, new BatchPreparedStatementSetter() {
			
			@Override
			public void setValues(PreparedStatement ps, int i) throws SQLException {
				ps.setString(1, userAuthorities.get(i).getUserId());
				ps.setString(2, userAuthorities.get(i).getAuthId());
			}
			
			@Override
			public int getBatchSize() {
				return userAuthorities.size();
			}
		});
	}
}
