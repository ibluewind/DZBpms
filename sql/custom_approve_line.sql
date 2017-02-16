SELECT cs.lineId,
       cs.formId,
       cs.userId,
       cs.title,
       concat(u.lastName, u.firstName) 'userName',
       cs.modified
  FROM custom_approve_line_summay cs, users u
 WHERE cs.userId = 'andrew@chosun.com' AND cs.userId = u.userid;

SELECT c.lineId,
       c.approvalId,
       concat(u.lastName, u.firstName) 'userName',
       pos.name,
       c.seq
FROM custom_approve_line c,
     users u
     LEFT JOIN (SELECT udp.userId, p.name
                FROM user_dept_position udp, position p
                WHERE udp.positionId = p.id AND p.type = 'R') pos
     ON u.userId = pos.userId
WHERE     c.lineId = '9608452d-f3e5-11e6-ae1a-0a0027000015'
         AND c.approvalId = u.userId
GROUP BY c.approvalId
ORDER BY c.seq;