SELECT d.deptid, @pv := d.pid, name, concat(u.lastName, u.firstName)
  FROM (  SELECT *
            FROM departments
        ORDER BY depth DESC) d
       JOIN (SELECT @pv := '361a569f-34c3-4520-baf7-f0d32abae6a0') tmp,
	   users u, dept_docmanager dm
 WHERE d.deptid = @pv AND d.useyn = 'Y' and dm.deptid=d.deptid and dm.docmanager=u.userid and d.depth>0