package com.dizzo.bpms.dao;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.BatchPreparedStatementSetter;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.dizzo.bpms.model.CustomApproveLine;
import com.dizzo.bpms.model.CustomApproveLineRowMapper;

@Repository("customApproveLineDao")
@Transactional
public class CustomApproveLineDaoImpl implements CustomApproveLineDao {

	@Autowired
	DataSource		dataSource;
	
	@Override
	public List<CustomApproveLine> getApproveLines(String userId, String formId) {
		List<CustomApproveLine>	lines = null;
		String query = "SELECT c.formId,"
					 + " f.title 'formTitle',"
         			 + " c.userId,"
         			 + " concat(u.lastName, u.firstName) 'userName',"
         			 + " c.approvalId,"
         			 + " concat(au.lastName, au.firstName) 'approvalName',"
         			 + " pos.name 'approvalPosition',"
		 			 + " c.seq"
    			 + " FROM form f,"
         			 + " custom_approve_line c,"
         			 + " users u,"
         			 + " users au "
         			 + " LEFT JOIN (SELECT udp.userId, p.name"
         			 + "            FROM user_dept_position udp, position p"
         			 + "		   WHERE udp.positionId = p.id AND p.type = 'R') pos"
         			 + "	ON au.userId = pos.userId"
   			 + " WHERE     c.formId = ?"
   		 			 + " AND c.formId = f.id"
         			 + " AND c.userId = ?"
		 			 + " AND u.userid = c.userId"
         			 + " AND au.userid = c.approvalId"
         	 + " GROUP BY au.userid"
			 + " ORDER BY c.seq";
		
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
		
		try {
			lines = jdbcTemplate.query(query, new Object[] {formId, userId}, new CustomApproveLineRowMapper());
		} catch (EmptyResultDataAccessException e) {
			System.out.println("EmptyResult : " + e.getLocalizedMessage());
			return null;
		}
		
		System.out.println("cutromApproveLine: " + lines);
		return lines;
		
	}

	@Override
	public List<CustomApproveLine> saveApproveLines(List<CustomApproveLine> lines) {
		String	query = "INSERT INTO custom_approve_line (formId, userId, approvalId, seq)"
					  + " VALUES (?, ?, ?, ?)";
		
		new JdbcTemplate(dataSource).batchUpdate(query, new BatchPreparedStatementSetter() {
			
			@Override
			public void setValues(PreparedStatement ps, int idx) throws SQLException {
				System.out.println("customLine: " + lines.get(idx));
				ps.setString(1, lines.get(idx).getFormId());
				ps.setString(2, lines.get(idx).getUserId());
				ps.setString(3, lines.get(idx).getApprovalId());
				ps.setInt(4, lines.get(idx).getSeq());
			}
			
			@Override
			public int getBatchSize() {
				return lines.size();
			}
		});
		return lines;
	}

	@Override
	public List<CustomApproveLine> updateApproveLines(List<CustomApproveLine> lines) {
		// 기존의 사용자 정의 결재 라인을 모두 삭제하고, 새로 저장한다.
		String	userId = lines.get(0).getUserId();
		String	formId = lines.get(0).getFormId();
		
		deleteAll(userId, formId);
		return saveApproveLines(lines);
	}

	@Override
	public CustomApproveLine deleteOneLine(String userId, String formId, String approvalId) {
		String	query = "DELETE FROM custom_approve_line WHERE userId=? AND formId=? AND approvalId=?";
		new JdbcTemplate(dataSource).update(query, new Object[] {userId, formId, approvalId});
		return null;
	}

	@Override
	public List<CustomApproveLine> deleteAll(String userId, String formId) {
		String	query = "DELETE FROM custom_approve_line WHERE userId=? AND formId=?";
		new JdbcTemplate(dataSource).update(query, new Object[] {userId, formId});
		return null;
	}

}
