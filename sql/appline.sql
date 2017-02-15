SELECT '' lineId,
					  '' appId,
         			  dm.docmanager userId,
         			  concat(u.lastName, u.firstName) userName,
         			  p.name positionName,
         			  'P' status,
         			  null modified,
         			 'R' type,
         			  l.seq
					  FROM (SELECT d.deptid,
                 			  @pv := d.pid,
                 			  d.name,
                 			  d.depth,
                 			  @rownum:=@rownum+1 'seq'
            			  FROM (  SELECT deptid,
                           			  pid,
                           			  name,
                           			  depth
                      			  FROM departments
                     			  WHERE useyn = 'Y'
                  			  ORDER BY depth DESC) d
                 			  JOIN
                 			  (  SELECT @pv := d.deptid
                      			 FROM users u, user_dept_position d
                     			  WHERE u.userid = 'andrew@chosun.com' AND d.userid = u.userid
                  			  GROUP BY u.userid) tmp
           			  WHERE d.deptid = @pv AND (@rownum:=0)=0) l,
         			  dept_docmanager dm, users u, user_dept_position up, position p
   			  WHERE dm.type = 'M' AND dm.deptid = l.deptid and u.userid=dm.docmanager and up.deptid=l.deptid and up.userid = u.userid and p.id=up.positionid and p.type='R'
   			  ORDER BY l.depth DESC