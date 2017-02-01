package com.dizzo.bpms.dao;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Iterator;
import java.util.List;

import javax.sql.DataSource;

import org.apache.taglibs.standard.tag.el.sql.UpdateTag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BatchPreparedStatementSetter;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.dizzo.bpms.model.ApproveLine;
import com.dizzo.bpms.model.ApproveTray;
import com.dizzo.bpms.model.ApproveTrayRowMapper;
import com.dizzo.bpms.model.ApproveTrayType;
import com.dizzo.bpms.service.ApproveLineService;

@Repository("approveTrayDao")
public class ApproveTrayDaoImpl implements ApproveTrayDao {
	
	@Autowired
	DataSource		dataSource;
	
	@Autowired
	ApproveLineService	appLineService;

	@Override
	public ApproveTray insert(ApproveTray tray) {
		String	query = "INSERT INTO approve_tray (appId, userId, type, modified) VALUES (?, ?, now())";
		
		new JdbcTemplate(dataSource).update(query, new Object[] {tray.getAppId(), tray.getUserId(), tray.getType()});
		return tray;
	}

	@Override
	public ApproveTray delete(ApproveTray tray) {
		String	query = "DELETE FROM approve_tray WHERE userId=? AND appId=?";
		new JdbcTemplate(dataSource).update(query, new Object[] {tray.getUserId(), tray.getAppId()});
		return tray;
	}

	@Override
	public List<ApproveTray> listByUserId(String userId) {
		String query = "SELECT s.appId,"
					 + " s.title 'appTitle',"
					 + " s.userId 'creator',"
       				 + " t.userId,"
					 + " t.type,"
       				 + " concat(u.lastName, u.firstName) 'creatorName',"
					 + " s.created,"
       				 + " t.modified"
  					 + " FROM approve_summary s, approve_tray t, users u"
 					 + " WHERE     t.userId = ?"
       				 + " AND t.appId = s.appId"
       				 + " AND s.userId = u.userId";
		
		return new JdbcTemplate(dataSource).query(query, new Object[] {userId}, new ApproveTrayRowMapper());
	}

	@Override
	public List<ApproveTray> listByAppId(String appId) {
		String query = "SELECT s.appId,"
				 + " s.title 'appTitle',"
				 + " s.userId 'creator',"
  				 + " t.userId,"
				 + " t.type,"
  				 + " concat(u.lastName, u.firstName) 'creatorName',"
				 + " s.created,"
  				 + " t.modified"
					 + " FROM approve_summary s, approve_tray t, users u"
				 + " WHERE     t.appId = ?"
  				 + " AND t.appId = s.appId"
  				 + " AND s.userId = u.userId";
	
	return new JdbcTemplate(dataSource).query(query, new Object[] {appId}, new ApproveTrayRowMapper());
	}

	@Override
	public List<ApproveTray> insertAll(List<ApproveTray> trays) {
		String	query = "INSERT INTO approve_tray (appId, userId, type, modified) VALUES (?, ?, ?, now())";
		
		new JdbcTemplate(dataSource).batchUpdate(query, new BatchPreparedStatementSetter() {
			
			@Override
			public void setValues(PreparedStatement ps, int idx) throws SQLException {
				ps.setString(1, trays.get(idx).getAppId());
				ps.setString(2, trays.get(idx).getUserId());
				ps.setString(3, trays.get(idx).getType());
			}
			
			@Override
			public int getBatchSize() {
				return trays.size();
			}
		});
		return trays;
	}

	@Override
	public List<ApproveTray> deleteAll(String appId) {
		String	query = "DELETE FROM approve_tray WHERE appId=?";
		List<ApproveTray>	trays = listByAppId(appId);
		
		new JdbcTemplate(dataSource).update(query, new Object[] {appId});
		return trays;
	}

	/**
	 * 반려가 일어났을 경우에 호출되며, 결재함의 type과 modified를 초기화한다.
	 * 결재함의 type은 모두 UNDECIDE로 변경하고, modified는 현재 날짜로 초기화한다.
	 */
	@Override
	public List<ApproveTray> resetTray(String appId) {
		String	query = "UPDATE approve_tray SET type = ?, modified=now() WHERE appId = ?";
		
		new JdbcTemplate(dataSource).update(query, new Object[] {ApproveTrayType.UNDECIDE.getType(), appId});
		return listByAppId(appId);
	}

	/**
	 * 변경할 수 있는 내용은 type과 modified 뿐이어야 한다.
	 */
	@Override
	public ApproveTray update(ApproveTray tray) {
		String query = "UPDATE approve_tray SET type=?, modified=now() WHERE appId=? AND userId=?";
		
		new JdbcTemplate(dataSource).update(query, new Object[] {tray.getType(), tray.getAppId(), tray.getUserId()});
		return tray;
	}

	@Override
	public ApproveTray getApproveTrayForUser(String userId, String appId) {
		String query = "SELECT s.appId,"
					 + " s.title 'appTitle',"
					 + " s.userId 'creator',"
       				 + " t.userId,"
       				 + " t.type,"
       				 + " concat(u.lastName, u.firstName) 'creatorName',"
       				 + " s.created,"
       				 + " t.modified"
  				 + " FROM approve_summary s, approve_tray t, users u"
 				 + " WHERE     t.appId = ?"
       				 + " AND t.userId = ?"
       				 + " AND t.appId = s.appId"
       				 + " AND s.userId = u.userId";
		
		return new JdbcTemplate(dataSource).queryForObject(query, new Object[] {appId,  userId}, new ApproveTrayRowMapper());
	}

	/**
	 * 미결 목록.
	 * type='U'
	 */
	@Override
	public List<ApproveTray> undecideTray(String userId) {

		return getTray(userId, ApproveTrayType.UNDECIDE.getType());
	}

	@Override
	public List<ApproveTray> completedTray(String userId) {
		return getTray(userId, ApproveTrayType.COMPLETED.getType());
	}

	@Override
	public List<ApproveTray> deferTray(String userId) {
		return getTray(userId, ApproveTrayType.DEFER.getType());
	}

	@Override
	public List<ApproveTray> expectedTray(String userId) {
		return getTray(userId, ApproveTrayType.EXPECTED.getType());
	}
	
	/**
	 * 결재 완료하면 결재자의 결재함을 완료로 변경하고 다음 결재자의 결재함을 미결로 변경한다.
	 * 최종 결재자라면 아무런 처리를 하지 않는다.
	 * 결재 완료에 대한 처리가 필요하다. 결재 완료에 대한 처리는 결재라인 처리에서 수행한다.
	 */
	@Override
	public List<ApproveTray> submitTray(String userId, String appId) {
		ApproveTray	tray = getApproveTrayForUser(userId, appId);
		List<ApproveTray> trays = listByAppId(appId);
		ApproveLine		line = appLineService.getNextOrder(appId, userId);
		
		tray.setType(ApproveTrayType.COMPLETED.getType());
		tray = update(tray); 
		
		if (line != null) {
			// 다음 결재자를 결재함 목록에서 찾는다.
			Iterator<ApproveTray>	it = trays.iterator();
			
			while (it.hasNext()) {
				tray = it.next();
				if (tray.getUserId().equals(line.getApprovalId())) {
					tray.setType(ApproveTrayType.UNDECIDE.getType());
					tray = this.update(tray);
				}
			}
		}
		return null;
	}
	
	private ApproveTray findNextApproveTray(String userId, String appId, List<ApproveTray> trays) {
		Iterator	it = null;
		ApproveTray			tray = null;
		List<ApproveLine>	appLines = appLineService.getByAppId(appId);
		ApproveLine			line = null;
		
		it = appLines.iterator();
		while (it.hasNext()) {
			line = (ApproveLine)it.next();
			
			if (userId.equals(line.getApprovalId()))	break;
		}
		// next approvalId
		int	idx = appLines.indexOf(line);
		
		if ((idx + 1) == appLines.size())	return null;
		else {
			it = trays.iterator();
			
		}
		
		return tray;
	}

	private List<ApproveTray>	getTray(String userId, String type) {
		String query = "SELECT s.appId,"
				 + " s.title 'appTitle',"
				 + " s.userId 'creator',"
				 + " t.userId,"
				 + " t.type,"
				 + " concat(u.lastName, u.firstName) 'creatorName',"
				 + " s.created,"
				 + " t.modified"
					 + " FROM approve_summary s, approve_tray t, users u"
				 + " WHERE     t.type = ?"
				 + " AND t.userId=?"
				 + " AND s.appId = t.appId"
				 + " AND s.userId = u.userId";

		return new JdbcTemplate(dataSource).query(query, new Object[] {type, userId}, new ApproveTrayRowMapper());
	}

}
