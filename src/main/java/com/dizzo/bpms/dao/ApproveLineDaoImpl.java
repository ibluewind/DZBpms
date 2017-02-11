package com.dizzo.bpms.dao;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.BatchPreparedStatementSetter;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.dizzo.bpms.model.ApproveLine;
import com.dizzo.bpms.model.ApproveLineRowMapper;
import com.dizzo.bpms.model.ApproveStatus;

@Repository("appLineDao")
public class ApproveLineDaoImpl implements ApproveLineDao {

	@Autowired
	DataSource		dataSource;
	
	@Override
	public ApproveLine getByLineId(String lineId) {
		String	query = "  SELECT a.lineId,"
					  + " a.appId,"
         			  + " a.userId,"
         			  + " a.status,"
         			  + " a.modified,"
         			  + " a.seq,"
         			  + " a.type,"
         			  + " p.name 'positionName',"
         			  + " concat(u.lastName, u.firstName) 'userName'"
    			  + " FROM approve_line a,"
         			  + " users u,"
         			  + " user_dept_position udp,"
         			  + " position p"
   			  + " WHERE     a.lineId = ?"
         			  + " AND a.userId = u.userid"
         			  + " AND udp.userid = a.userId"
         			  + " AND p.id = udp.positionid"
         			  + " AND p.type = 'R'";
		
		return new JdbcTemplate(dataSource).queryForObject(query, new Object[] {lineId}, new ApproveLineRowMapper());
	}

	@Override
	public List<ApproveLine> getByAppId(String appId) {
		String query = "  SELECT a.lineId,"
					 + " a.appId,"
         			 + " a.userId,"
         			 + " a.status,"
         			 + " a.modified,"
         			 + " a.seq,"
         			 + " a.type,"
         			 + " p.name 'positionName',"
         			 + " concat(u.lastName, u.firstName) 'userName'"
    			 + " FROM approve_line a,"
         			 + " users u,"
         			 + " user_dept_position udp,"
         			 + " position p"
   			 + " WHERE     a.appId = ?"
         			 + " AND a.userId = u.userid"
         			 + " AND udp.userid = a.userId"
         			 + " AND p.id = udp.positionid"
         			 + " AND p.type = 'R'"
			 + " GROUP BY a.userId"
			 + " ORDER BY seq";
		
		return new JdbcTemplate(dataSource).query(query, new Object[] {appId}, new ApproveLineRowMapper());
	}

	@Override
	public List<ApproveLine> insert(List<ApproveLine> appLines) {
		String query = "INSERT INTO approve_line(appId,"
  				 							 + " lineId,"
                            				 + " userId,"
                            				 + " modified,"
                            				 + " status,"
                            				 + " seq,"
                            				 + " type)"
     				 + " VALUES (?,"
                				 + " ?,"
                				 + " ?,"
                				 + " ?,"
                				 + " ?,"
                				 + " ?,"
                				 + " ?)";
		
		new JdbcTemplate(dataSource).batchUpdate(query, new BatchPreparedStatementSetter() {
			
			@Override
			public void setValues(PreparedStatement ps, int idx) throws SQLException {
				ApproveLine	line = appLines.get(idx);
				
				line.setLineId(UUID.randomUUID().toString());
				
				ps.setString(1, line.getAppId());
				ps.setString(2, line.getLineId());
				ps.setString(3, line.getApprovalId());
				ps.setTimestamp(4, line.getSeq() == 0 ? new Timestamp(new Date().getTime()): null);
				ps.setString(5, line.getStatus());
				ps.setInt(6, line.getSeq());
				ps.setString(7, line.getType());
			}
			
			@Override
			public int getBatchSize() {
				return appLines.size();
			}
		});
		
		System.out.println("Saved approve line: " + appLines);
		
		return appLines;
	}

	@Override
	public ApproveLine update(ApproveLine appLine) {
		String	query = "UPDATE approve_line"
					  + " SET status = ?, seq = ?, modified=now()"
 			  + " WHERE lineId = ?";
		new JdbcTemplate(dataSource).update(query, new Object[] {
			appLine.getStatus(),
			appLine.getSeq(),
			appLine.getLineId()
		});
		return appLine;
	}

	@Override
	public ApproveLine delete(String lineId) {
		String query = "DELETE FROM approve_line WHERE lineId=?";
		ApproveLine	appLine = getByLineId(lineId);
		
		new JdbcTemplate(dataSource).update(query, new Object[] {lineId});
		return appLine;
	}

	@Override
	public List<ApproveLine> deleteAll(String appId) {
		String query = "DELETE FROM approve_line where appId=?";
		List<ApproveLine>	appLines = getByAppId(appId);
		
		new JdbcTemplate(dataSource).update(query, new Object[] {appId});
		return appLines;
	}

	@Override
	/**
	 * 결재 작성자가 아닌 결재자가 (즉, 사용자가 결재자로 되어 있는) 포함된 결재라인 조회
	 * 내가 결재할 예정 결재 문서나 결재한 문서를 조회할 때 사용한다.
	 */
	public List<ApproveLine> getByUserId(String userId) {
		String query = "SELECT a.lineId,"
					 + " a.appId,"
         			 + " a.userId,"
         			 + " a.status,"
         			 + " a.modified,"
         			 + " a.seq,"
         			 + " a.type,"
         			 + " p.name 'positionName',"
         			 + " concat(u.lastName, u.firstName) 'userName'"
    			 + " FROM approve_line a,"
         			 + " users u,"
         			 + " user_dept_position udp,"
         			 + " position p"
   			 + " WHERE     a.userId = ?"
         			 + " AND u.userid = a.userid"
         			 + " AND udp.userid = a.userId"
         			 + " AND p.id = udp.positionid"
			 + " GROUP BY a.userId";
		return new JdbcTemplate(dataSource).query(query, new Object[] {userId}, new ApproveLineRowMapper());
	}

	/**
	 * 결재자가 아직 결재하지 않은 결재 예정 문서를 조회할 때 사용한다.
	 */
	@Override
	public List<ApproveLine> getExpectedApprove(String userId) {
		// TODO 결재라인에 있지만, 결재가 완료되지 않은 결재건을 리스트한다.
		String query = "SELECT a.lineId,"
				 + " a.appId,"
    			 + " a.userId,"
    			 + " a.status,"
    			 + " a.modified,"
    			 + " a.seq,"
    			 + " a.type,"
    			 + " p.name 'positionName',"
    			 + " concat(u.lastName, u.firstName) 'userName'"
			 + " FROM approve_line a,"
    			 + " users u,"
    			 + " user_dept_position udp,"
    			 + " position p"
			 + " WHERE     a.userId = ?"
    			 + " AND u.userid = a.userid"
    			 + " AND udp.userid = a.userId"
    			 + " AND p.id = udp.positionid"
    			 + " AND a.status = ?"
		 + " GROUP BY a.userId";
		return new JdbcTemplate(dataSource).query(query, new Object[] {
				userId,
				ApproveStatus.PROCESSING.getStatus()},
				new ApproveLineRowMapper());
	}

	/**
	 * 사용자의 조직도를 이용한 결재라인을 조회하여 반환한다.
	 * getByOrganize()는 결재 문서를 처음 생성할 때, 사용자 정의 결재라인이 지정된 것이 없을 경우에만 호출된다.
	 * 즉, appId, lineId는 아직 결정되지 않은 상태이다.
	 * ApproveLineRowMapper()의 사용을 위해서 appId, lineId는 추가해주어야 한다.
	 */
	@Override
	public List<ApproveLine> getByOrganize(String userId) {
		String query = "SELECT '' lineId,"
					 + " '' appId,"
         			 + " dm.docmanager userId,"
         			 + " concat(u.lastName, u.firstName) userName,"
         			 + " p.name positionName,"
         			 + " 'P' status,"
         			 + " null modified,"			// 수정일자는 결재라인 생성시에 필요하지 않음.
         			 + "'R' type"
					 + " FROM (SELECT d.deptid,"
                 			 + " @pv := d.pid,"
                 			 + " d.name,"
                 			 + " d.depth"
            			 + " FROM (  SELECT deptid,"
                           			 + " pid,"
                           			 + " name,"
                           			 + " depth"
                      			 + " FROM departments"
                     			 + " WHERE useyn = 'Y'"
                  			 + " ORDER BY depth DESC) d"
                 			 + " JOIN"
                 			 + " (  SELECT @pv := d.deptid"
                      			 + " FROM users u, user_dept_position d"
                     			 + " WHERE u.userid = ? AND d.userid = u.userid"
                  			 + " GROUP BY u.userid) tmp"
           			 + " WHERE d.deptid = @pv) l,"
         			 + " dept_docmanager dm, users u, user_dept_position up, position p"
   			 + " WHERE dm.type = 'M' AND dm.deptid = l.deptid and u.userid=dm.docmanager and up.deptid=l.deptid and up.userid = u.userid and p.id=up.positionid and p.type='R'"
   			 + " ORDER BY l.depth DESC";
		return new JdbcTemplate(dataSource).query(query, new Object[] {userId}, new ApproveLineRowMapper());
	}

	@Override
	public ApproveLine getNextOrder(String appId, String userId) {
		String query = "  SELECT l.lineId,"
				     + "    l.appId,"
				     + "    l.userId,"
				     + "    l.status,"
				     + "    l.modified,"
				     + "    l.seq,"
				     + "    p.name 'positionName',"
				     + "    concat(u.lastName, u.firstName) 'userName'"
				     + " FROM approve_line l"
				     + "    JOIN"
				     + "    (SELECT @pv := seq"
				     + "       FROM approve_line"
				     + "      WHERE     appId = ?"
				     + "            AND userId = ?) t,"
				     + "    users u,"
				     + "    user_dept_position udp,"
				     + "    position p"
				   + " WHERE     l.seq = @pv + 1"
				   + "      AND u.userid = l.userId"
				   + "      AND udp.userid = u.userid"
				+ " GROUP BY u.userid";
		ApproveLine	line = null;
		
		try {
			line = new JdbcTemplate(dataSource).queryForObject(query, new Object[] {appId, userId}, new ApproveLineRowMapper());
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
		
		return line;
	}
	
	

}
