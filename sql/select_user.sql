select udp.userid, d.deptid 'deptid', d.name 'deptname', p.id 'positionid', p.name 'positionname'
from users u, user_dept_position udp, departments d, position p
where udp.userid = u.userid and u.userid='goindol@chosun.com' and d.deptid=udp.deptid and p.id=udp.positionid

select ua.userid, ua.authid, a.rolename
from user_authority ua, authority a
where ua.userid='goindol@chosun.com' and ua.authid = a.id

select c.id, c.name, c.ceo
from company c, departments d, user_dept_position udp, users u
where u.userid='goindol@chosun.com' and u.userid=udp.userid and d.deptid=udp.deptid and d.companyid=c.id