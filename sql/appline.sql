  SELECT '' lineId,
         '' appId,
         dm.docmanager userId,
         concat(u.lastName, u.firstName) userName,
         p.name positionName,
         'P' status,
         now() modified,
         '' comment
    FROM (SELECT d.deptid,
                 @pv := d.pid,
                 d.name,
                 d.depth
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
           WHERE d.deptid = @pv) l,
         dept_docmanager dm,
         users u,
         user_dept_position up,
         position p
   WHERE     dm.type = 'M'
         AND dm.deptid = l.deptid
         AND u.userid = dm.docmanager
         AND up.deptid = l.deptid
         AND up.userid = u.userid
         AND p.id = up.positionid
         AND p.type = 'R'
ORDER BY l.depth DESC