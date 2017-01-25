------------------------------------------------------------------
--  TABLE approve_form_field
------------------------------------------------------------------

CREATE TABLE approve_form_field
(
   `appId`    varchar(128),
   `formId`   varchar(128),
   category   int(10),
   clause     int(10),
   name       varchar(128),
   value      varchar(128)
);


------------------------------------------------------------------
--  TABLE approve_line
------------------------------------------------------------------

CREATE TABLE approve_line
(
   `lineId`   varchar(128),
   `appId`    varchar(128),
   `formId`   varchar(128),
   `userId`   varchar(128),
   status     char(1) DEFAULT 'P',
   modified   datetime,
   comment    varchar(256)
);


------------------------------------------------------------------
--  TABLE approve_summary
------------------------------------------------------------------

CREATE TABLE approve_summary
(
   appid      varchar(128),
   title      varchar(256),
   `userId`   varchar(128),
   created    datetime,
   modified   datetime,
   status     char(1) DEFAULT 'P',
   `formId`   varchar(128)
);


------------------------------------------------------------------
--  TABLE authority
------------------------------------------------------------------

CREATE TABLE authority
(
   id         varchar(128),
   rolename   varchar(32) DEFAULT '''USER''',
   comment    varchar(128)
);


------------------------------------------------------------------
--  TABLE company
------------------------------------------------------------------

CREATE TABLE company
(
   id     varchar(128),
   name   varchar(128),
   ceo    varchar(64)
);


------------------------------------------------------------------
--  TABLE departments
------------------------------------------------------------------

CREATE TABLE departments
(
   pid            varchar(128) DEFAULT '''#''',
   deptid         varchar(128),
   companyid      varchar(128),
   name           varchar(128),
   useyn          char(1) DEFAULT 'Y',
   lastmodified   datetime,
   depth          int(10) DEFAULT 0
);


------------------------------------------------------------------
--  TABLE dept_docmanager
------------------------------------------------------------------

CREATE TABLE dept_docmanager
(
   deptid       varchar(128),
   docmanager   varchar(128),
   type         char(1) DEFAULT 'M'
);


------------------------------------------------------------------
--  TABLE file_attach
------------------------------------------------------------------

CREATE TABLE file_attach
(
   `attachId`     varchar(128),
   type           varchar(128),
   path           varchar(256),
   name           varchar(128),
   `mainId`       varchar(128),
   modified       datetime,
   `originName`   varchar(128),
   size           int(32)
);


------------------------------------------------------------------
--  TABLE form
------------------------------------------------------------------

CREATE TABLE form
(
   id         varchar(128),
   title      varchar(256),
   comment    varchar(512),
   created    datetime,
   modified   datetime,
   creator    varchar(128),
   `useYN`    char(1) DEFAULT 'Y'
);


------------------------------------------------------------------
--  TABLE form_field
------------------------------------------------------------------

CREATE TABLE form_field
(
   `formId`   varchar(128),
   category   int(10),
   clause     int(10),
   name       varchar(128),
   value      varchar(128)
);


------------------------------------------------------------------
--  TABLE persistent_logins
------------------------------------------------------------------

CREATE TABLE persistent_logins
(
   username    varchar(64),
   series      varchar(64),
   token       varchar(64),
   last_used   timestamp DEFAULT 'CURRENT_TIMESTAMP'
);


------------------------------------------------------------------
--  TABLE position
------------------------------------------------------------------

CREATE TABLE position
(
   id     varchar(128),
   name   varchar(128),
   type   char(1),
   seq    int(10)
);


------------------------------------------------------------------
--  TABLE task
------------------------------------------------------------------

CREATE TABLE task
(
   `taskId`        varchar(128),
   `userId`        varchar(128),
   `workerId`      varchar(128),
   `endDate`       datetime,
   status          char(1) DEFAULT 'P',
   priority        char(1) DEFAULT 'M',
   `targetRate`    int(10) DEFAULT 0,
   `currentRate`   int(10) DEFAULT 0,
   opened          char(1) DEFAULT 'N',
   title           varchar(256),
   content         varchar(2048),
   `createDate`    datetime
);


------------------------------------------------------------------
--  TABLE task_history
------------------------------------------------------------------

CREATE TABLE task_history
(
   `historyId`   varchar(128),
   `taskId`      varchar(128),
   comment       varchar(512),
   created       datetime,
   creator       varchar(128),
   worker        varchar(128),
   `procRate`    int(10),
   action        varchar(512)
);


------------------------------------------------------------------
--  TABLE user_authority
------------------------------------------------------------------

CREATE TABLE user_authority
(
   userid   varchar(128),
   authid   varchar(128)
);


------------------------------------------------------------------
--  TABLE user_dept_position
------------------------------------------------------------------

CREATE TABLE user_dept_position
(
   userid       varchar(128),
   deptid       varchar(128),
   positionid   varchar(128)
);


------------------------------------------------------------------
--  TABLE users
------------------------------------------------------------------

CREATE TABLE users
(
   userid      varchar(100),
   firstname   varchar(32),
   lastname    varchar(32),
   password    varchar(128),
   state       char(1) DEFAULT 'Y'
);


