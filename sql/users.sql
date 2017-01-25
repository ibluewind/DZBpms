CREATE TABLE users
(
   id          int(10),
   userid      varchar(100),
   firstname   varchar(20),
   lastname    varchar(20),
   password    varchar(128),
   state       char(1) DEFAULT 'Y'
)