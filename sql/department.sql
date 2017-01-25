CREATE TABLE departments
(
   id             int(10),
   pid            int(10) DEFAULT 0,
   deptid         varchar(100),
   companyid      int(10),
   name           varchar(30),
   useyn          char(1) DEFAULT 'Y',
   lastmodified   datetime
)