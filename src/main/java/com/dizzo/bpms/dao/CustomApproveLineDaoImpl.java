package com.dizzo.bpms.dao;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;
import java.util.UUID;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.BatchPreparedStatementSetter;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.dizzo.bpms.model.CustomApproveLine;
import com.dizzo.bpms.model.CustomApproveLineRowMapper;
import com.dizzo.bpms.model.CustomApproveLineSummary;
import com.dizzo.bpms.model.CustomApproveLineSummaryRowMapper;

@Repository("customApproveLineDao")
@Transactional
public class CustomApproveLineDaoImpl implements CustomApproveLineDao {

	@Autowired
	DataSource		dataSource;
	
	@Override
	public List<CustomApproveLine> getApproveLines(String userId, String formId) {
		List<CustomApproveLine>	lines = null;
		String query = "SELECT c.lineId,"
					 + "        c.approvalId,"
					 + "        concat(u.lastName, u.firstName) 'approvalName',"
					 + "        pos.name 'approvalPosition',"
					 + "        c.seq"
					 + " FROM custom_approve_line c,"
					 + "      custom_approve_line_summary cs,"
					 + "      users u"
					 + "      LEFT JOIN (SELECT udp.userId, p.name"
					 + "                 FROM user_dept_position udp, position p"
					 + "                 WHERE udp.positionId = p.id AND p.type = 'R') pos"
					 + "      ON u.userId = pos.userId"
					 + " WHERE     c.lineId = cs.lineId"
					 + "          AND c.approvalId = u.userId"
					 + "          AND cs.userId = ?"
					 + "          AND cs.formId = ?"
					 + " GROUP BY c.approvalId"
					 + " ORDER BY c.seq";
		
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
		
		try {
			lines = jdbcTemplate.query(query, new Object[] {userId, formId}, new CustomApproveLineRowMapper());
		} catch (EmptyResultDataAccessException e) {
			System.out.println("EmptyResult : " + e.getLocalizedMessage());
			return null;
		}
		
		System.out.println("cutromApproveLine: " + lines);
		return lines;
		
	}

	@Override
	public List<CustomApproveLine> getApproveLines(String lineId) {
		String query = "SELECT c.lineId,"
					 + "        c.approvalId,"
					 + "        concat(u.lastName, u.firstName) 'approvalName',"
					 + "        pos.name 'approvalPosition',"
					 + "        c.seq"
					 + " FROM custom_approve_line c,"
					 + "      users u"
					 + "      LEFT JOIN (SELECT udp.userId, p.name"
					 + "                 FROM user_dept_position udp, position p"
					 + "                 WHERE udp.positionId = p.id AND p.type = 'R') pos"
					 + "      ON u.userId = pos.userId"
					 + " WHERE     c.lineId = ?"
					 + "          AND c.approvalId = u.userId"
					 + " GROUP BY c.approvalId"
					 + " ORDER BY c.seq";
		
		return new JdbcTemplate(dataSource).query(query, new Object[] { lineId }, new CustomApproveLineRowMapper());
	}

	@Override
	public List<CustomApproveLine> saveApproveLines(List<CustomApproveLine> lines) {
		String	query = "INSERT INTO custom_approve_line (lineId, approvalId, seq)"
					  + " VALUES (?, ?, ?)";
		
		new JdbcTemplate(dataSource).batchUpdate(query, new BatchPreparedStatementSetter() {
			
			@Override
			public void setValues(PreparedStatement ps, int idx) throws SQLException {
				System.out.println("customLine: " + lines.get(idx));
				ps.setString(1, lines.get(idx).getLineId());
				ps.setString(2, lines.get(idx).getApprovalId());
				ps.setInt(3, lines.get(idx).getSeq());
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
		String	lineId = lines.get(0).getLineId();
		
		deleteAll(lineId);
		return saveApproveLines(lines);
	}

	@Override
	public CustomApproveLine deleteOneLine(String lineId, int seq) {
		String	query = "DELETE FROM custom_approve_line WHERE lineId=? AND seq=?";
		new JdbcTemplate(dataSource).update(query, new Object[] {lineId, seq});
		return null;
	}

	@Override
	public List<CustomApproveLine> deleteAll(String lineId) {
		String	query = "DELETE FROM custom_approve_line WHERE lineId=?";
		new JdbcTemplate(dataSource).update(query, new Object[] {lineId});
		return null;
	}

	@Override
	public CustomApproveLineSummary saveSummary(CustomApproveLineSummary summary) {
		String	query = "INSERT INTO custom_approve_line_summary (lineId, formId, userId, title, modified) "
					  + "VALUES (?, ?, ?, ?, now())";
		
		summary.setLineId(UUID.randomUUID().toString());
		
		new JdbcTemplate(dataSource).update(query, new Object[] {
			summary.getLineId(),
			summary.getFormId(),
			summary.getUserId(),
			summary.getTitle()
		});
		
		return summary;
	}

	@Override
	public List<CustomApproveLineSummary> listSummary(String userId) {
		String query = "SELECT cs.lineId,"
					 + "        cs.formId,"
					 + "        f.title 'formTitle',"
					 + "        cs.userId,"
					 + "        cs.title,"
					 + "        concat(u.lastName, u.firstName) 'userName',"
					 + "        cs.modified"
					 + " FROM custom_approve_line_summary cs, users u, form f"
					 + " WHERE  cs.userId = ?"
					 + "        AND cs.userId = u.userid"
					 + "        AND cs.formId = f.id";
		
		return new JdbcTemplate(dataSource).query(query, new Object[] { userId }, new CustomApproveLineSummaryRowMapper());
	}

	@Override
	public CustomApproveLineSummary getSummary(String lineId) {
		String query = "SELECT cs.lineId,"
				 + "        cs.formId,"
				 + "        f.title 'formTitle',"
				 + "        cs.userId,"
				 + "        cs.title,"
				 + "        concat(u.lastName, u.firstName) 'userName',"
				 + "        cs.modified"
				 + " FROM custom_approve_line_summary cs, users u, form f"
				 + " WHERE  cs.lineId = ?"
				 + "        AND cs.userId = u.userid"
				 + "        AND cs.formId = f.id";
	
		return new JdbcTemplate(dataSource).queryForObject(query, new Object[] { lineId }, new CustomApproveLineSummaryRowMapper());
	}

	@Override
	public CustomApproveLineSummary deleteSummary(String lineId) {
		// custom_approve_line_summary를 삭제하면, custom_approve_line 테이블도 삭제한다.
		CustomApproveLineSummary summary = getSummary(lineId);
		String	query = "DELETE FROM custom_approve_line_summary WHERE lineId=?";
		
		new JdbcTemplate(dataSource).update(query, new Object[] {lineId});
		
		// custom_approve_line table 삭제
		query = "DELETE FROM custom_approve_line WHERE lineId=?";
		new JdbcTemplate(dataSource).update(query, new Object[] {lineId});
		
		return summary;
	}

	@Override
	public CustomApproveLineSummary updateSummary(CustomApproveLineSummary summary) {
		String query = "UPDATE custom_approve_line_summary SET formId=?, title=?, modified=now() WHERE lineId=?";
		
		new JdbcTemplate(dataSource).update(query, new Object[]{summary.getFormId(), summary.getTitle(), summary.getLineId()});
		return summary;
	}

}
