-- MySQL dump 10.13  Distrib 5.7.16, for Win64 (x86_64)
--
-- Host: localhost    Database: dz_bpm
-- ------------------------------------------------------
-- Server version	5.7.16-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `approve_form_field`
--

DROP TABLE IF EXISTS `approve_form_field`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `approve_form_field` (
  `appId` varchar(128) NOT NULL,
  `formId` varchar(128) NOT NULL,
  `category` int(10) NOT NULL,
  `clause` int(10) NOT NULL,
  `name` varchar(128) NOT NULL,
  `value` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `approve_form_field`
--

LOCK TABLES `approve_form_field` WRITE;
/*!40000 ALTER TABLE `approve_form_field` DISABLE KEYS */;
INSERT INTO `approve_form_field` VALUES ('96b156a7-fc9e-443c-ae42-64468fe8a596','9a43387a-b7c4-4976-a608-a18bd8a296b1',0,0,'type','1'),('96b156a7-fc9e-443c-ae42-64468fe8a596','9a43387a-b7c4-4976-a608-a18bd8a296b1',0,0,'startDate','2017-02-22T15:00:00.000Z'),('96b156a7-fc9e-443c-ae42-64468fe8a596','9a43387a-b7c4-4976-a608-a18bd8a296b1',0,0,'endDate','2017-02-23T15:00:00.000Z'),('96b156a7-fc9e-443c-ae42-64468fe8a596','9a43387a-b7c4-4976-a608-a18bd8a296b1',0,0,'comment','개인사유'),('96b156a7-fc9e-443c-ae42-64468fe8a596','9a43387a-b7c4-4976-a608-a18bd8a296b1',0,0,'remark',''),('96b156a7-fc9e-443c-ae42-64468fe8a596','9a43387a-b7c4-4976-a608-a18bd8a296b1',1,0,'deptName','시너지개발부'),('96b156a7-fc9e-443c-ae42-64468fe8a596','9a43387a-b7c4-4976-a608-a18bd8a296b1',2,0,'positionName','부장'),('96b156a7-fc9e-443c-ae42-64468fe8a596','9a43387a-b7c4-4976-a608-a18bd8a296b1',3,0,'userName','김현곤'),('66b74e22-b74d-4abf-819e-fb7327507ab7','9a43387a-b7c4-4976-a608-a18bd8a296b1',0,0,'type','1'),('66b74e22-b74d-4abf-819e-fb7327507ab7','9a43387a-b7c4-4976-a608-a18bd8a296b1',0,0,'startDate','2017-02-22T15:00:00.000Z'),('66b74e22-b74d-4abf-819e-fb7327507ab7','9a43387a-b7c4-4976-a608-a18bd8a296b1',0,0,'endDate','2017-02-23T15:00:00.000Z'),('66b74e22-b74d-4abf-819e-fb7327507ab7','9a43387a-b7c4-4976-a608-a18bd8a296b1',0,0,'comment','개인연차'),('66b74e22-b74d-4abf-819e-fb7327507ab7','9a43387a-b7c4-4976-a608-a18bd8a296b1',0,0,'remark',''),('66b74e22-b74d-4abf-819e-fb7327507ab7','9a43387a-b7c4-4976-a608-a18bd8a296b1',1,0,'deptName','시너지개발부'),('66b74e22-b74d-4abf-819e-fb7327507ab7','9a43387a-b7c4-4976-a608-a18bd8a296b1',2,0,'positionName','부장'),('66b74e22-b74d-4abf-819e-fb7327507ab7','9a43387a-b7c4-4976-a608-a18bd8a296b1',3,0,'userName','김현곤'),('7a3ae2e9-6563-4637-a795-f162067708b0','9a43387a-b7c4-4976-a608-a18bd8a296b1',0,0,'type','1'),('7a3ae2e9-6563-4637-a795-f162067708b0','9a43387a-b7c4-4976-a608-a18bd8a296b1',0,0,'startDate','2017-02-22T15:00:00.000Z'),('7a3ae2e9-6563-4637-a795-f162067708b0','9a43387a-b7c4-4976-a608-a18bd8a296b1',0,0,'endDate','2017-02-23T15:00:00.000Z'),('7a3ae2e9-6563-4637-a795-f162067708b0','9a43387a-b7c4-4976-a608-a18bd8a296b1',0,0,'comment','개인연차'),('7a3ae2e9-6563-4637-a795-f162067708b0','9a43387a-b7c4-4976-a608-a18bd8a296b1',0,0,'remark',''),('7a3ae2e9-6563-4637-a795-f162067708b0','9a43387a-b7c4-4976-a608-a18bd8a296b1',1,0,'deptName','시너지개발부'),('7a3ae2e9-6563-4637-a795-f162067708b0','9a43387a-b7c4-4976-a608-a18bd8a296b1',2,0,'positionName','부장'),('7a3ae2e9-6563-4637-a795-f162067708b0','9a43387a-b7c4-4976-a608-a18bd8a296b1',3,0,'userName','김현곤');
/*!40000 ALTER TABLE `approve_form_field` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `approve_history`
--

DROP TABLE IF EXISTS `approve_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `approve_history` (
  `historyId` varchar(128) NOT NULL COMMENT 'UUID',
  `appId` varchar(128) NOT NULL COMMENT '결재 아이디',
  `comment` varchar(512) DEFAULT NULL COMMENT '결재 의견',
  `created` datetime NOT NULL COMMENT '이력 생성 일시',
  `userId` varchar(128) NOT NULL COMMENT '결재자 아이디',
  `status` char(1) NOT NULL COMMENT '결재 상태:\r\nF: 완료\r\nR: 반려\r\nD: 보류\r\nC: 확인\r\nS: 저장',
  PRIMARY KEY (`historyId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='결재시 사용자가 취한 행동에 대한 이력 관리 테이블\r\n결재 상태가 변경될 때 마다 내용을 기록하고, 반려, 보류 시에 의견을 저장한다.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `approve_history`
--

LOCK TABLES `approve_history` WRITE;
/*!40000 ALTER TABLE `approve_history` DISABLE KEYS */;
INSERT INTO `approve_history` VALUES ('026cd3c3-d4ab-4295-8599-a009191a97bf','96b156a7-fc9e-443c-ae42-64468fe8a596','','2017-02-14 13:31:03','bhkim@chosun.com','P'),('1666ea74-dfa3-48c1-a7af-7e658f12400a','66b74e22-b74d-4abf-819e-fb7327507ab7','','2017-02-14 18:49:02','andrew@chosun.com','S'),('205c8f3f-9261-4dc3-ac33-c738661eeff2','7a3ae2e9-6563-4637-a795-f162067708b0','','2017-02-15 15:24:27','andrew@chosun.com','P'),('22ab1813-46ab-4e5d-aac7-67650e20af79','96b156a7-fc9e-443c-ae42-64468fe8a596','','2017-02-14 13:30:20','hmokim@chosun.com','C'),('2fcd5295-d805-4c64-b5df-52fa54e1680f','7a3ae2e9-6563-4637-a795-f162067708b0','','2017-02-15 16:22:32','kds@chosun.com','P'),('354d79ba-4830-46d4-af2c-361a123bd7a0','96b156a7-fc9e-443c-ae42-64468fe8a596','','2017-02-14 14:30:21','bhkim@chosun.com','P'),('3e030cee-c2ae-40d8-88e4-8639ff0bfeed','7a3ae2e9-6563-4637-a795-f162067708b0','','2017-02-15 15:25:28','yunju@chosun.com','P'),('3eb1aaed-ee0f-4063-b1c8-835c021db57d','96b156a7-fc9e-443c-ae42-64468fe8a596','','2017-02-14 13:30:34','hmokim@chosun.com','P'),('4023c0b0-9d2b-4723-88e9-d64c9119ec0f','7a3ae2e9-6563-4637-a795-f162067708b0','','2017-02-15 15:30:58','dylee@chosun.com','C'),('40c0b56b-da23-4276-80ef-e72738371f27','96b156a7-fc9e-443c-ae42-64468fe8a596','','2017-02-14 14:30:06','bhkim@chosun.com','C'),('45c8bd2d-1e75-4223-9951-f42bbf9ea179','96b156a7-fc9e-443c-ae42-64468fe8a596','','2017-02-14 11:18:16','yunju@chosun.com','P'),('4830eb1f-5e46-44f3-be78-b5d0f9dfb042','66b74e22-b74d-4abf-819e-fb7327507ab7','','2017-02-15 16:41:59','bigfoot@chosun.com','C'),('490337e7-b445-493e-baf3-ba97cc960897','96b156a7-fc9e-443c-ae42-64468fe8a596','','2017-02-14 11:17:56','bigfoot@chosun.com','C'),('4da4a061-6a7d-4cc2-ab7a-13f9a0d0ab82','7a3ae2e9-6563-4637-a795-f162067708b0','','2017-02-15 15:41:52','dylee@chosun.com','C'),('4f4fe85b-a530-4744-8d86-31bb698606dc','96b156a7-fc9e-443c-ae42-64468fe8a596','','2017-02-14 13:34:49','bhkim@chosun.com','C'),('50e571cd-e955-442b-a07a-6d89c5838e6e','96b156a7-fc9e-443c-ae42-64468fe8a596','','2017-02-14 13:37:32','bhkim@chosun.com','P'),('5967560d-99f7-4137-8757-88557360286f','96b156a7-fc9e-443c-ae42-64468fe8a596','','2017-02-14 13:29:07','dylee@chosun.com','C'),('5e8724d7-f1a6-4fa7-b758-ceea4ec8aada','7a3ae2e9-6563-4637-a795-f162067708b0','','2017-02-15 16:23:25','bhkim@chosun.com','P'),('6426ea60-9eb8-4367-8b08-6572895ce557','66b74e22-b74d-4abf-819e-fb7327507ab7','','2017-02-14 18:49:41','andrew@chosun.com','P'),('64ead151-6373-4ef9-95f6-54f690dd8bb6','96b156a7-fc9e-443c-ae42-64468fe8a596','','2017-02-14 13:46:41','bhkim@chosun.com','P'),('75bf3fb6-ae11-42e3-bc88-e8f96686a73b','7a3ae2e9-6563-4637-a795-f162067708b0','','2017-02-15 16:22:00','dylee@chosun.com','C'),('7c032bd2-2991-4831-9fcc-5a095f5a337e','96b156a7-fc9e-443c-ae42-64468fe8a596','','2017-02-14 11:17:58','bigfoot@chosun.com','P'),('7cef94e3-fc3a-4d90-8904-a863110a8256','7a3ae2e9-6563-4637-a795-f162067708b0','','2017-02-15 15:25:07','bigfoot@chosun.com','P'),('7f2ea88a-b3c5-47d6-9b7e-1145d11a0e07','7a3ae2e9-6563-4637-a795-f162067708b0','','2017-02-15 15:25:21','yunju@chosun.com','C'),('8b8e4450-aff8-4ac5-be89-ae894e8ad6a5','7a3ae2e9-6563-4637-a795-f162067708b0','','2017-02-15 15:37:19','dylee@chosun.com','C'),('90d3cf27-6296-4d00-8a0a-be3320087a15','7a3ae2e9-6563-4637-a795-f162067708b0','','2017-02-15 15:24:16','andrew@chosun.com','S'),('934194ad-98ed-48f6-b41e-7db89df2cbb1','96b156a7-fc9e-443c-ae42-64468fe8a596','','2017-02-14 13:30:00','kds@chosun.com','P'),('9fcf2315-7034-49fb-9d0c-ca47b071f880','7a3ae2e9-6563-4637-a795-f162067708b0','','2017-02-15 16:23:01','hmokim@chosun.com','P'),('b477c4e3-2a6c-49b3-b726-0e22d64c218b','7a3ae2e9-6563-4637-a795-f162067708b0','','2017-02-15 15:31:58','dylee@chosun.com','C'),('bb10e970-2337-44f6-9bdf-c59b1139a157','7a3ae2e9-6563-4637-a795-f162067708b0','','2017-02-15 15:24:53','bigfoot@chosun.com','C'),('bb252b96-161f-4e54-a4b2-3ba4c4c92492','96b156a7-fc9e-443c-ae42-64468fe8a596','','2017-02-14 13:29:17','dylee@chosun.com','P'),('c75b993e-8e9c-4509-b92a-dca9f9094b40','96b156a7-fc9e-443c-ae42-64468fe8a596','','2017-02-14 13:31:00','bhkim@chosun.com','C'),('c779bc04-fee1-45d4-8d3b-93959fd40d0f','96b156a7-fc9e-443c-ae42-64468fe8a596','','2017-02-14 11:17:44','andrew@chosun.com','P'),('c8a1f119-106d-4562-b13e-5442492cfd78','96b156a7-fc9e-443c-ae42-64468fe8a596','','2017-02-14 13:34:55','bhkim@chosun.com','P'),('c8f1708a-213e-4923-a1ae-d152eba6c44b','7a3ae2e9-6563-4637-a795-f162067708b0','','2017-02-15 16:22:29','kds@chosun.com','C'),('d255f650-a37b-4fd2-8e8e-46b28d68966a','7a3ae2e9-6563-4637-a795-f162067708b0','','2017-02-15 15:25:57','dylee@chosun.com','C'),('d7be7113-f79f-4b2a-af07-f5147cfe9d57','7a3ae2e9-6563-4637-a795-f162067708b0','','2017-02-15 16:23:11','bhkim@chosun.com','C'),('e240a21d-6e0c-4231-877a-00a806669928','96b156a7-fc9e-443c-ae42-64468fe8a596','','2017-02-14 13:46:34','bhkim@chosun.com','C'),('e9d0389f-7305-4a2a-b039-2d0b189bc33f','7a3ae2e9-6563-4637-a795-f162067708b0','','2017-02-15 16:22:15','dylee@chosun.com','P'),('f1b0a1ea-2179-49a7-8c26-df2e4872d3d8','7a3ae2e9-6563-4637-a795-f162067708b0','','2017-02-15 16:22:44','hmokim@chosun.com','C'),('f1eb448b-4fcf-4cda-aaea-0f2d2c47b549','96b156a7-fc9e-443c-ae42-64468fe8a596','','2017-02-14 13:36:43','bhkim@chosun.com','C'),('fe2acf47-b872-4e38-a862-44c1e23f2f71','96b156a7-fc9e-443c-ae42-64468fe8a596','','2017-02-14 13:29:57','kds@chosun.com','C'),('ffe20703-6b84-4f57-9747-34b67d14de09','96b156a7-fc9e-443c-ae42-64468fe8a596','','2017-02-14 11:18:13','yunju@chosun.com','C');
/*!40000 ALTER TABLE `approve_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `approve_line`
--

DROP TABLE IF EXISTS `approve_line`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `approve_line` (
  `lineId` varchar(128) NOT NULL,
  `appId` varchar(128) NOT NULL,
  `userId` varchar(128) NOT NULL,
  `status` char(1) DEFAULT 'P',
  `modified` datetime DEFAULT NULL,
  `seq` int(10) NOT NULL DEFAULT '0',
  `type` char(1) NOT NULL DEFAULT 'R' COMMENT 'R : 의뢰부서\r\nP : 처리부서\r\n결재라인이 의뢰부서 결재인지, 처리부서 결재인지 구분'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `approve_line`
--

LOCK TABLES `approve_line` WRITE;
/*!40000 ALTER TABLE `approve_line` DISABLE KEYS */;
INSERT INTO `approve_line` VALUES ('3b8be12f-b0cc-44d3-8dfa-4955f4b94d72','96b156a7-fc9e-443c-ae42-64468fe8a596','andrew@chosun.com','F','2017-02-14 11:17:45',0,'R'),('fb172816-9b22-46ed-a46c-7443d32d913c','96b156a7-fc9e-443c-ae42-64468fe8a596','bigfoot@chosun.com','F','2017-02-14 11:17:58',1,'R'),('bb1b85e5-9506-4b66-80cd-dbabcb4b8f41','96b156a7-fc9e-443c-ae42-64468fe8a596','yunju@chosun.com','F','2017-02-14 11:18:16',2,'R'),('c455a929-92e2-4418-91cc-191c5cfc158a','96b156a7-fc9e-443c-ae42-64468fe8a596','dylee@chosun.com','F','2017-02-14 13:29:18',0,'P'),('6db265a0-21ee-43a0-91c2-27a886b58915','96b156a7-fc9e-443c-ae42-64468fe8a596','kds@chosun.com','F','2017-02-14 13:30:00',1,'P'),('cbe865cc-8409-4c23-8fdf-0185a1871c24','96b156a7-fc9e-443c-ae42-64468fe8a596','hmokim@chosun.com','F','2017-02-14 13:30:34',2,'P'),('e2f402ca-6194-4fba-8799-8a183a875683','96b156a7-fc9e-443c-ae42-64468fe8a596','bhkim@chosun.com','F','2017-02-14 14:30:21',3,'P'),('2b7c2ea9-2e58-481d-8b64-72d91b20be99','66b74e22-b74d-4abf-819e-fb7327507ab7','andrew@chosun.com','F','2017-02-14 18:49:41',0,'R'),('a32de105-fcb3-4a94-9c0e-324392e22b2d','66b74e22-b74d-4abf-819e-fb7327507ab7','bigfoot@chosun.com','P',NULL,1,'R'),('e582eb49-c3d5-4f3c-ad0f-ce02102bdd35','66b74e22-b74d-4abf-819e-fb7327507ab7','yunju@chosun.com','P',NULL,2,'R'),('d73929f5-7000-428f-b2b5-349fcfdd5c10','7a3ae2e9-6563-4637-a795-f162067708b0','andrew@chosun.com','F','2017-02-15 15:24:28',0,'R'),('1168430e-22dc-401b-823f-ffe97889c227','7a3ae2e9-6563-4637-a795-f162067708b0','bigfoot@chosun.com','F','2017-02-15 15:25:07',1,'R'),('8643a5f8-b87f-4b39-96cf-3425acd41372','7a3ae2e9-6563-4637-a795-f162067708b0','yunju@chosun.com','F','2017-02-15 15:25:28',2,'R'),('31826b84-2ed9-473f-bea9-4a1ab08065fe','7a3ae2e9-6563-4637-a795-f162067708b0','dylee@chosun.com','F','2017-02-15 16:22:16',0,'P'),('61ffa979-7ffd-443a-957e-43c02c18aece','7a3ae2e9-6563-4637-a795-f162067708b0','kds@chosun.com','F','2017-02-15 16:22:32',1,'P'),('9d6909c0-a50d-47a5-8ca7-8205abc0555e','7a3ae2e9-6563-4637-a795-f162067708b0','hmokim@chosun.com','F','2017-02-15 16:23:01',2,'P'),('befd3646-3987-4718-9d6a-98155c7078b7','7a3ae2e9-6563-4637-a795-f162067708b0','bhkim@chosun.com','F','2017-02-15 16:23:25',3,'P');
/*!40000 ALTER TABLE `approve_line` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `approve_summary`
--

DROP TABLE IF EXISTS `approve_summary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `approve_summary` (
  `appid` varchar(128) NOT NULL,
  `title` varchar(256) NOT NULL,
  `userId` varchar(128) NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime DEFAULT NULL,
  `status` char(1) DEFAULT 'P' COMMENT 'S : 저장 (Saved)\r\nP : 결재중 (Processing)\r\nR : 반려 (Reject)\r\nD : 보류 (Defer)',
  `formId` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `approve_summary`
--

LOCK TABLES `approve_summary` WRITE;
/*!40000 ALTER TABLE `approve_summary` DISABLE KEYS */;
INSERT INTO `approve_summary` VALUES ('96b156a7-fc9e-443c-ae42-64468fe8a596','휴가원','andrew@chosun.com','2017-02-14 11:17:44','2017-02-14 14:30:21','F','9a43387a-b7c4-4976-a608-a18bd8a296b1'),('66b74e22-b74d-4abf-819e-fb7327507ab7','휴가원','andrew@chosun.com','2017-02-14 18:49:02','2017-02-14 18:49:41','P','9a43387a-b7c4-4976-a608-a18bd8a296b1'),('7a3ae2e9-6563-4637-a795-f162067708b0','휴가원','andrew@chosun.com','2017-02-15 15:24:16','2017-02-15 16:23:25','F','9a43387a-b7c4-4976-a608-a18bd8a296b1');
/*!40000 ALTER TABLE `approve_summary` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `approve_tray`
--

DROP TABLE IF EXISTS `approve_tray`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `approve_tray` (
  `appId` varchar(128) NOT NULL COMMENT '결재 문서 ID',
  `userId` varchar(128) NOT NULL COMMENT '사용자 ID',
  `modified` datetime NOT NULL COMMENT '결재 문서 저장 일시',
  `type` char(1) NOT NULL DEFAULT 'U' COMMENT 'U : 미결 (Undecide)\r\nC : 기결 (Completed)\r\nR : 반려 (Reject)\r\nD : 보류 (Defer)\r\nE : 예정 (Expected)',
  PRIMARY KEY (`appId`,`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='사용자의 결재 미결함.\r\n사용자가 결재할 문서를 저장한다.\r\n사용자가 결재를 완료하면 결재함에서 삭제한다.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `approve_tray`
--

LOCK TABLES `approve_tray` WRITE;
/*!40000 ALTER TABLE `approve_tray` DISABLE KEYS */;
INSERT INTO `approve_tray` VALUES ('66b74e22-b74d-4abf-819e-fb7327507ab7','andrew@chosun.com','2017-02-14 18:49:41','F'),('66b74e22-b74d-4abf-819e-fb7327507ab7','bigfoot@chosun.com','2017-02-14 18:49:41','U'),('66b74e22-b74d-4abf-819e-fb7327507ab7','yunju@chosun.com','2017-02-14 18:49:41','E'),('7a3ae2e9-6563-4637-a795-f162067708b0','andrew@chosun.com','2017-02-15 15:24:27','F'),('7a3ae2e9-6563-4637-a795-f162067708b0','bhkim@chosun.com','2017-02-15 16:23:25','F'),('7a3ae2e9-6563-4637-a795-f162067708b0','bigfoot@chosun.com','2017-02-15 15:25:07','F'),('7a3ae2e9-6563-4637-a795-f162067708b0','dylee@chosun.com','2017-02-15 16:22:15','F'),('7a3ae2e9-6563-4637-a795-f162067708b0','hmokim@chosun.com','2017-02-15 16:23:01','F'),('7a3ae2e9-6563-4637-a795-f162067708b0','kds@chosun.com','2017-02-15 16:22:32','F'),('7a3ae2e9-6563-4637-a795-f162067708b0','yunju@chosun.com','2017-02-15 15:25:28','F'),('96b156a7-fc9e-443c-ae42-64468fe8a596','andrew@chosun.com','2017-02-14 11:17:44','F'),('96b156a7-fc9e-443c-ae42-64468fe8a596','bhkim@chosun.com','2017-02-14 14:30:21','F'),('96b156a7-fc9e-443c-ae42-64468fe8a596','bigfoot@chosun.com','2017-02-14 11:17:58','F'),('96b156a7-fc9e-443c-ae42-64468fe8a596','dylee@chosun.com','2017-02-14 13:29:17','F'),('96b156a7-fc9e-443c-ae42-64468fe8a596','hmokim@chosun.com','2017-02-14 13:30:34','F'),('96b156a7-fc9e-443c-ae42-64468fe8a596','kds@chosun.com','2017-02-14 13:30:00','F'),('96b156a7-fc9e-443c-ae42-64468fe8a596','yunju@chosun.com','2017-02-14 11:18:16','F');
/*!40000 ALTER TABLE `approve_tray` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `authority`
--

DROP TABLE IF EXISTS `authority`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `authority` (
  `id` varchar(128) DEFAULT NULL,
  `rolename` varchar(32) DEFAULT '''USER''',
  `comment` varchar(128) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authority`
--

LOCK TABLES `authority` WRITE;
/*!40000 ALTER TABLE `authority` DISABLE KEYS */;
INSERT INTO `authority` VALUES ('41d394a1-9e7a-4a9e-b20f-f59eddb4f8e9','PUSER','계약직사원'),('45338ea5-aaea-11e6-8cda-d067e51fd414','USER','일반사용자'),('45338ea5-aaea-11e6-8cda-d067e51fd415','ADMIN','관리자'),('45338ea5-aaea-11e6-8cda-d067e51fd416','DBA','DB 관리자'),('45338ea5-aaea-11e6-8cda-d067e51fd417','TL','팀장'),('45338ea5-aaea-11e6-8cda-d067e51fd418','PL','파트장'),('45338ea5-aaea-11e6-8cda-d067e51fd419','DL','부서장/부문장');
/*!40000 ALTER TABLE `authority` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `company`
--

DROP TABLE IF EXISTS `company`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `company` (
  `id` varchar(128) DEFAULT NULL,
  `name` varchar(128) DEFAULT NULL,
  `ceo` varchar(64) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `company`
--

LOCK TABLES `company` WRITE;
/*!40000 ALTER TABLE `company` DISABLE KEYS */;
INSERT INTO `company` VALUES ('d4d8448b-aaea-11e6-8cda-d067e51fd414','조선일보','방상훈'),('d4d8448b-aaea-11e6-8cda-d067e51fd415','디지틀조선일보','김찬'),('d4d8448b-aaea-11e6-8cda-d067e51fd416','TV조선','변용식');
/*!40000 ALTER TABLE `company` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `custom_approve_line`
--

DROP TABLE IF EXISTS `custom_approve_line`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `custom_approve_line` (
  `lineId` varchar(128) NOT NULL COMMENT '양식 ID',
  `approvalId` varchar(128) NOT NULL COMMENT '결재자 아이디',
  `seq` int(10) NOT NULL DEFAULT '0' COMMENT '결재 순번'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT=' 사용자 지정 결재 라인 (양식별)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `custom_approve_line`
--

LOCK TABLES `custom_approve_line` WRITE;
/*!40000 ALTER TABLE `custom_approve_line` DISABLE KEYS */;
INSERT INTO `custom_approve_line` VALUES ('9608452d-f3e5-11e6-ae1a-0a0027000015','yunju@chosun.com',2),('9608452d-f3e5-11e6-ae1a-0a0027000015','andrew@chosun.com',0),('9608452d-f3e5-11e6-ae1a-0a0027000015','bigfoot@chosun.com',1);
/*!40000 ALTER TABLE `custom_approve_line` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `custom_approve_line_summary`
--

DROP TABLE IF EXISTS `custom_approve_line_summary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `custom_approve_line_summary` (
  `lineId` varchar(128) NOT NULL COMMENT '결재라인 메인 ID',
  `formId` varchar(128) NOT NULL COMMENT '양식ID',
  `userId` varchar(128) NOT NULL COMMENT '사용자 ID',
  `title` varchar(128) NOT NULL COMMENT '결재라인 제목',
  `modified` datetime NOT NULL COMMENT '수정일자',
  PRIMARY KEY (`lineId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='사용자 정의 결재 라인 요약 정보';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `custom_approve_line_summary`
--

LOCK TABLES `custom_approve_line_summary` WRITE;
/*!40000 ALTER TABLE `custom_approve_line_summary` DISABLE KEYS */;
INSERT INTO `custom_approve_line_summary` VALUES ('9608452d-f3e5-11e6-ae1a-0a0027000015','9a43387a-b7c4-4976-a608-a18bd8a296b1','andrew@chosun.com','휴가원 결재 라인','2017-02-16 10:21:57');
/*!40000 ALTER TABLE `custom_approve_line_summary` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `departments`
--

DROP TABLE IF EXISTS `departments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `departments` (
  `pid` varchar(128) DEFAULT '''#''',
  `deptid` varchar(128) DEFAULT NULL,
  `companyid` varchar(128) DEFAULT NULL,
  `name` varchar(128) DEFAULT NULL,
  `useyn` char(1) DEFAULT 'Y',
  `lastmodified` datetime DEFAULT NULL,
  `depth` int(10) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `departments`
--

LOCK TABLES `departments` WRITE;
/*!40000 ALTER TABLE `departments` DISABLE KEYS */;
INSERT INTO `departments` VALUES ('25332011-bf0c-46f5-9e7b-4f4a1e13cdee','00c22eec-490a-4931-8cdb-4719f64250cc','d4d8448b-aaea-11e6-8cda-d067e51fd415','재경부','Y','2017-01-05 14:51:19',2),('fe0fa567-fe30-4b16-92b8-6be075982b82','06e2f9aa-d74d-4fdb-bafb-03fbf2685d25','d4d8448b-aaea-11e6-8cda-d067e51fd415','NS개발팀','Y','2017-01-05 14:53:07',4),('9c247a2d-77b1-457a-ba9b-43c972125ab6','0a3849ba-c180-47e7-8118-a037d6f3c4ba','d4d8448b-aaea-11e6-8cda-d067e51fd415','인터넷개발팀','Y','2016-11-09 20:06:55',4),('fe0fa567-fe30-4b16-92b8-6be075982b82','0f3169fb-0c16-4119-a581-9c46dbb66a27','d4d8448b-aaea-11e6-8cda-d067e51fd415','NS개발2팀','D','2016-11-16 17:20:54',0),('36000a74-9c12-4061-9cce-86642f18a09b','1939ef1e-b45b-4427-8473-602f10189344','d4d8448b-aaea-11e6-8cda-d067e51fd415','CTS기술부','Y','2016-08-26 10:39:49',3),('9c247a2d-77b1-457a-ba9b-43c972125ab6','1a772189-abbb-4f74-9f9a-430a2e1e04ab','d4d8448b-aaea-11e6-8cda-d067e51fd415','테스트1','D','2016-11-16 16:55:00',4),('digital_chosunilbo','22ba2ef1-f771-48bb-99fb-3f6df4a3691a','d4d8448b-aaea-11e6-8cda-d067e51fd415','조선닷컴편집본부','Y','2016-08-09 11:26:22',1),('digital_chosunilbo','25332011-bf0c-46f5-9e7b-4f4a1e13cdee','d4d8448b-aaea-11e6-8cda-d067e51fd415','경영전략본부','Y','2017-02-10 10:02:16',1),('fe9b93be-b688-49e3-8c36-b5b3616580f3','26a1c355-f322-4fac-875e-1f2a78b5ccda','d4d8448b-aaea-11e6-8cda-d067e51fd415','대외협력팀','Y','2017-01-05 14:52:37',3),('aaaadfdfd','26ff5f6a-eae6-44ab-af25-43a99b07ddb8','d4d8448b-aaea-11e6-8cda-d067e51fd415','CTS부문','Y','2016-10-18 15:24:06',2),('b7bceead-35f2-465c-8b0d-e3819b1d622f','29088aea-c4da-4041-a6aa-907ae12e22ab','d4d8448b-aaea-11e6-8cda-d067e51fd415','IT협력팀','Y','2016-08-05 13:52:50',4),('aaaadfdfd','36000a74-9c12-4061-9cce-86642f18a09b','d4d8448b-aaea-11e6-8cda-d067e51fd415','미디어부문','Y','2017-01-05 15:41:01',2),('d35c8fa9-7fe9-4820-accb-5dfa26b56689','361a569f-34c3-4520-baf7-f0d32abae6a0','d4d8448b-aaea-11e6-8cda-d067e51fd415','시너지개발팀','Y','2017-01-05 14:53:26',4),('1939ef1e-b45b-4427-8473-602f10189344','424cf452-4295-406d-9c0a-164d257db7a3','d4d8448b-aaea-11e6-8cda-d067e51fd415','테스트','D','2016-11-21 12:38:09',4),('fe9b93be-b688-49e3-8c36-b5b3616580f3','442fc8e1-9447-4e60-aed3-ea3eb73396c8','d4d8448b-aaea-11e6-8cda-d067e51fd415','인사기획팀','Y','2017-02-08 18:49:14',3),('22ba2ef1-f771-48bb-99fb-3f6df4a3691a','49f45cdb-17be-4bbc-97ee-4c60a653b8ab','d4d8448b-aaea-11e6-8cda-d067e51fd415','뉴스미디어부','Y','2016-08-09 11:26:56',2),('1939ef1e-b45b-4427-8473-602f10189344','4dea7638-2eae-4e6d-865c-111bd6bf6769','d4d8448b-aaea-11e6-8cda-d067e51fd415','CTS시스템팀','Y','2016-08-05 13:52:09',4),('digital_chosunilbo','6a364c59-bbad-43a4-a5f9-ffa4b6860f9d','d4d8448b-aaea-11e6-8cda-d067e51fd415','마케팅본부','Y','2017-01-04 14:30:45',1),('digital_chosunilbo','8e2c3ab9-27f1-4747-8d7f-e2f66436b9ce','d4d8448b-aaea-11e6-8cda-d067e51fd415','경영전략본부','D','2017-01-04 13:55:09',1),('d35c8fa9-7fe9-4820-accb-5dfa26b56689','97470fe7-b591-4315-8b29-1bf38d44058f','d4d8448b-aaea-11e6-8cda-d067e51fd415','개발2팀','D','2016-11-18 15:47:29',5),('00c22eec-490a-4931-8cdb-4719f64250cc','9b6859d4-70bf-42c8-850d-26c604ecbbd5','d4d8448b-aaea-11e6-8cda-d067e51fd415','회계팀','Y','2017-01-05 14:51:33',3),('36000a74-9c12-4061-9cce-86642f18a09b','9c247a2d-77b1-457a-ba9b-43c972125ab6','d4d8448b-aaea-11e6-8cda-d067e51fd415','솔루션개발부','Y','2016-11-21 09:58:03',3),('#','a11f0a80-5e09-11e6-b356-00090ffe0001','d4d8448b-aaea-11e6-8cda-d067e51fd416','TV조선','Y','2016-08-09 17:18:53',0),('chosunilbo','a5690ed4-b929-440b-a52f-b33759559df5','d4d8448b-aaea-11e6-8cda-d067e51fd414','경영기획실','Y','2016-08-09 13:20:24',0),('a11f0a80-5e09-11e6-b356-00090ffe0001','a61bda35-8e4d-4490-b0f2-d6af329ad046','d4d8448b-aaea-11e6-8cda-d067e51fd416','최상위부서','Y','2016-08-09 17:19:03',0),('digital_chosunilbo','aaaadfdfd','d4d8448b-aaea-11e6-8cda-d067e51fd415','뉴미디어연구소','Y','2017-01-05 15:40:50',1),('36000a74-9c12-4061-9cce-86642f18a09b','b7bceead-35f2-465c-8b0d-e3819b1d622f','d4d8448b-aaea-11e6-8cda-d067e51fd415','미디어기술부','Y','2016-08-26 10:39:14',3),('fe9b93be-b688-49e3-8c36-b5b3616580f3','b7d2ae01-354e-4c37-873e-81fc9a45795b','d4d8448b-aaea-11e6-8cda-d067e51fd415','총무팀','Y','2017-01-05 14:52:43',3),('424cf452-4295-406d-9c0a-164d257db7a3','ba57b8f8-ef89-4e0a-8306-0bf8600148b0','d4d8448b-aaea-11e6-8cda-d067e51fd415','테스트1','D','2016-11-21 12:39:28',0),('9c247a2d-77b1-457a-ba9b-43c972125ab6','bc5e4a80-50a8-44b1-a71b-4e5c64ce724b','d4d8448b-aaea-11e6-8cda-d067e51fd415','모바일개발팀','Y','2016-08-04 17:14:07',4),('fb263624-cf6d-46a6-9064-661e54786983','bd38a700-1c7d-4778-ad88-38627192f394','d4d8448b-aaea-11e6-8cda-d067e51fd415','미디어세일즈팀','Y','2017-01-05 14:52:53',3),('fb263624-cf6d-46a6-9064-661e54786983','c13fa29a-a148-4df0-9e02-b8be7db9bd8f','d4d8448b-aaea-11e6-8cda-d067e51fd415','애드커뮤니케이션팀','Y','2017-01-05 14:52:55',3),('b7bceead-35f2-465c-8b0d-e3819b1d622f','c6a2df5d-7ca6-4071-8428-4a7f52443700','d4d8448b-aaea-11e6-8cda-d067e51fd415','IT시스템팀','Y','2016-08-05 13:52:37',4),('#','chosunilbo','d4d8448b-aaea-11e6-8cda-d067e51fd414','조선일보','Y','2016-08-09 00:00:00',0),('36000a74-9c12-4061-9cce-86642f18a09b','d35c8fa9-7fe9-4820-accb-5dfa26b56689','d4d8448b-aaea-11e6-8cda-d067e51fd415','시너지개발부','Y','2017-01-05 15:21:41',3),('#','digital_chosunilbo','d4d8448b-aaea-11e6-8cda-d067e51fd415','디지틀조선일보','Y','2017-01-05 15:40:41',0),('6a364c59-bbad-43a4-a5f9-ffa4b6860f9d','fb263624-cf6d-46a6-9064-661e54786983','d4d8448b-aaea-11e6-8cda-d067e51fd415','마케팅부','Y','2017-01-05 14:52:50',2),('26ff5f6a-eae6-44ab-af25-43a99b07ddb8','fe0fa567-fe30-4b16-92b8-6be075982b82','d4d8448b-aaea-11e6-8cda-d067e51fd415','NS개발부','Y','2017-01-05 14:53:02',3),('25332011-bf0c-46f5-9e7b-4f4a1e13cdee','fe9b93be-b688-49e3-8c36-b5b3616580f3','d4d8448b-aaea-11e6-8cda-d067e51fd415','경영관리부','Y','2017-02-10 10:02:03',2);
/*!40000 ALTER TABLE `departments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dept_docmanager`
--

DROP TABLE IF EXISTS `dept_docmanager`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dept_docmanager` (
  `deptid` varchar(128) DEFAULT NULL,
  `docmanager` varchar(128) DEFAULT NULL,
  `type` char(1) DEFAULT 'M'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dept_docmanager`
--

LOCK TABLES `dept_docmanager` WRITE;
/*!40000 ALTER TABLE `dept_docmanager` DISABLE KEYS */;
INSERT INTO `dept_docmanager` VALUES ('361a569f-34c3-4520-baf7-f0d32abae6a0','yuzibosu@chosun.com','M'),('361a569f-34c3-4520-baf7-f0d32abae6a0','shlee@chosun.com','S'),('d35c8fa9-7fe9-4820-accb-5dfa26b56689','andrew@chosun.com','M'),('digital_chosunilbo','chan@chopsun.com','M'),('aaaadfdfd','yunju@chosun.com','M'),('36000a74-9c12-4061-9cce-86642f18a09b','bigfoot@chosun.com','M'),('442fc8e1-9447-4e60-aed3-ea3eb73396c8','dylee@chosun.com','M'),('442fc8e1-9447-4e60-aed3-ea3eb73396c8','kds@chosun.com','S'),('fe9b93be-b688-49e3-8c36-b5b3616580f3','hmokim@chosun.com','M'),('25332011-bf0c-46f5-9e7b-4f4a1e13cdee','bhkim@chosun.com','M');
/*!40000 ALTER TABLE `dept_docmanager` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `file_attach`
--

DROP TABLE IF EXISTS `file_attach`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `file_attach` (
  `attachId` varchar(128) DEFAULT NULL,
  `type` varchar(128) DEFAULT NULL,
  `path` varchar(256) DEFAULT NULL,
  `name` varchar(128) DEFAULT NULL,
  `mainId` varchar(128) DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  `originName` varchar(128) DEFAULT NULL,
  `size` int(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `file_attach`
--

LOCK TABLES `file_attach` WRITE;
/*!40000 ALTER TABLE `file_attach` DISABLE KEYS */;
INSERT INTO `file_attach` VALUES ('98d98414-7eeb-45cc-9def-0f437d5428ba','','D:/Google 드라이브/프로젝트/DZBpms/src/main/webapp/WEB-INF/views/forms/','2e79261b-0664-427d-96d6-b3b239bea57f.jsp','9a43387a-b7c4-4976-a608-a18bd8a296b1','2017-01-10 15:20:19','389730f4-723f-4fa4-bf22-34c5d88c6679.jsp',3622);
/*!40000 ALTER TABLE `file_attach` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `form`
--

DROP TABLE IF EXISTS `form`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `form` (
  `id` varchar(128) DEFAULT NULL,
  `title` varchar(256) DEFAULT NULL,
  `comment` varchar(512) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  `creator` varchar(128) DEFAULT NULL,
  `useYN` char(1) DEFAULT 'Y',
  `procDept` varchar(128) DEFAULT NULL COMMENT '처리부서 아이디'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `form`
--

LOCK TABLES `form` WRITE;
/*!40000 ALTER TABLE `form` DISABLE KEYS */;
INSERT INTO `form` VALUES ('9a43387a-b7c4-4976-a608-a18bd8a296b1','휴가원','휴가원 결재 양식','2017-01-10 15:20:19','2017-02-14 11:16:16','andrew@chosun.com','Y','442fc8e1-9447-4e60-aed3-ea3eb73396c8');
/*!40000 ALTER TABLE `form` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `form_field`
--

DROP TABLE IF EXISTS `form_field`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `form_field` (
  `formId` varchar(128) DEFAULT NULL,
  `category` int(10) DEFAULT NULL,
  `clause` int(10) DEFAULT NULL,
  `name` varchar(128) DEFAULT NULL,
  `value` varchar(128) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `form_field`
--

LOCK TABLES `form_field` WRITE;
/*!40000 ALTER TABLE `form_field` DISABLE KEYS */;
INSERT INTO `form_field` VALUES ('9a43387a-b7c4-4976-a608-a18bd8a296b1',0,0,'deptName',''),('9a43387a-b7c4-4976-a608-a18bd8a296b1',1,0,'positionName',''),('9a43387a-b7c4-4976-a608-a18bd8a296b1',2,0,'userName',''),('9a43387a-b7c4-4976-a608-a18bd8a296b1',3,0,'type',''),('9a43387a-b7c4-4976-a608-a18bd8a296b1',3,0,'startDate',''),('9a43387a-b7c4-4976-a608-a18bd8a296b1',3,0,'endDate',''),('9a43387a-b7c4-4976-a608-a18bd8a296b1',3,0,'comment',''),('9a43387a-b7c4-4976-a608-a18bd8a296b1',3,0,'remark','');
/*!40000 ALTER TABLE `form_field` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `persistent_logins`
--

DROP TABLE IF EXISTS `persistent_logins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `persistent_logins` (
  `username` varchar(64) DEFAULT NULL,
  `series` varchar(64) DEFAULT NULL,
  `token` varchar(64) DEFAULT NULL,
  `last_used` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `persistent_logins`
--

LOCK TABLES `persistent_logins` WRITE;
/*!40000 ALTER TABLE `persistent_logins` DISABLE KEYS */;
/*!40000 ALTER TABLE `persistent_logins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `position`
--

DROP TABLE IF EXISTS `position`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `position` (
  `id` varchar(128) DEFAULT NULL,
  `name` varchar(128) DEFAULT NULL,
  `type` char(1) DEFAULT NULL,
  `seq` int(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `position`
--

LOCK TABLES `position` WRITE;
/*!40000 ALTER TABLE `position` DISABLE KEYS */;
INSERT INTO `position` VALUES ('1e2032f2-deba-49ed-82de-a70fd241734b','사장','R',10000),('cb37711b-aaec-11e6-8cda-d067e51fd414','사원','P',10),('cb37711b-aaec-11e6-8cda-d067e51fd415','대리','P',20),('cb37711b-aaec-11e6-8cda-d067e51fd416','과장대우','P',30),('cb37711b-aaec-11e6-8cda-d067e51fd417','과장','P',40),('cb37711b-aaec-11e6-8cda-d067e51fd418','차장대우','P',50),('cb37711b-aaec-11e6-8cda-d067e51fd419','차장','P',60),('cb37711b-aaec-11e6-8cda-d067e51fd420','부장대우','P',70),('cb37711b-aaec-11e6-8cda-d067e51fd421','부장','P',80),('cb37711b-aaec-11e6-8cda-d067e51fd422','부국장대우','P',90),('cb37711b-aaec-11e6-8cda-d067e51fd423','부국장','P',100),('cb37711b-aaec-11e6-8cda-d067e51fd424','국장대우','P',110),('cb37711b-aaec-11e6-8cda-d067e51fd425','국장','P',120),('cb37711b-aaec-11e6-8cda-d067e51fd427','이사','P',130),('cb37711b-aaec-11e6-8cda-d067e51fd428','팀장','R',1000),('cb37711b-aaec-11e6-8cda-d067e51fd429','부장','R',2000),('cb37711b-aaec-11e6-8cda-d067e51fd430','본부장','R',4000),('cb37711b-aaec-11e6-8cda-d067e51fd431','소장','R',4000),('cb37711b-aaec-11e6-8cda-d067e51fd432','국장','R',4000),('cb37711b-aaec-11e6-8cda-d067e51fd433','실장','R',4000),('cb37711b-aaec-11e6-8cda-d067e51fd434','원장','R',4000),('cb37711b-aaec-11e6-8cda-d067e51fd435','부원장','R',3500),('cb37711b-aaec-11e6-8cda-d067e51fd436','계약직원','P',5),('3cd235ac-5390-4b6c-8db1-7299bea560d1','대표이사','P',11000),('a93e6af1-a18f-4ba8-8901-5e3f1bfd60ce','상무','P',150);
/*!40000 ALTER TABLE `position` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task`
--

DROP TABLE IF EXISTS `task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `task` (
  `taskId` varchar(128) DEFAULT NULL,
  `userId` varchar(128) DEFAULT NULL,
  `workerId` varchar(128) DEFAULT NULL,
  `endDate` datetime DEFAULT NULL,
  `status` char(1) DEFAULT 'P',
  `priority` char(1) DEFAULT 'M',
  `targetRate` int(10) DEFAULT '0',
  `currentRate` int(10) DEFAULT '0',
  `opened` char(1) DEFAULT 'N',
  `title` varchar(256) DEFAULT NULL,
  `content` varchar(2048) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task`
--

LOCK TABLES `task` WRITE;
/*!40000 ALTER TABLE `task` DISABLE KEYS */;
/*!40000 ALTER TABLE `task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task_history`
--

DROP TABLE IF EXISTS `task_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `task_history` (
  `historyId` varchar(128) DEFAULT NULL,
  `taskId` varchar(128) DEFAULT NULL,
  `comment` varchar(512) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `creator` varchar(128) DEFAULT NULL,
  `worker` varchar(128) DEFAULT NULL,
  `procRate` int(10) DEFAULT NULL,
  `action` varchar(512) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_history`
--

LOCK TABLES `task_history` WRITE;
/*!40000 ALTER TABLE `task_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `task_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_authority`
--

DROP TABLE IF EXISTS `user_authority`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_authority` (
  `userid` varchar(128) DEFAULT NULL,
  `authid` varchar(128) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_authority`
--

LOCK TABLES `user_authority` WRITE;
/*!40000 ALTER TABLE `user_authority` DISABLE KEYS */;
INSERT INTO `user_authority` VALUES ('andrew@chosun.com','45338ea5-aaea-11e6-8cda-d067e51fd414'),('andrew@chosun.com','45338ea5-aaea-11e6-8cda-d067e51fd415'),('andrew@chosun.com','45338ea5-aaea-11e6-8cda-d067e51fd416'),('andrew@chosun.com','45338ea5-aaea-11e6-8cda-d067e51fd419'),('yongkum@chosun.com','45338ea5-aaea-11e6-8cda-d067e51fd414'),('goindol@chosun.com','45338ea5-aaea-11e6-8cda-d067e51fd414'),('goindol@chosun.com','45338ea5-aaea-11e6-8cda-d067e51fd417'),('goindol@chosun.com','45338ea5-aaea-11e6-8cda-d067e51fd419'),('rainy@chosun.com','45338ea5-aaea-11e6-8cda-d067e51fd414'),('myungwons@chosun.com','45338ea5-aaea-11e6-8cda-d067e51fd414'),('yuzibosu@chosun.com','45338ea5-aaea-11e6-8cda-d067e51fd414'),('yuzibosu@chosun.com','45338ea5-aaea-11e6-8cda-d067e51fd417'),('shlee@chosun.com','45338ea5-aaea-11e6-8cda-d067e51fd414'),('yds0903@chosun.com','45338ea5-aaea-11e6-8cda-d067e51fd414'),('yunju@chosun.com','45338ea5-aaea-11e6-8cda-d067e51fd414'),('yunju@chosun.com','45338ea5-aaea-11e6-8cda-d067e51fd419'),('bigfoot@chosun.com','45338ea5-aaea-11e6-8cda-d067e51fd414'),('bigfoot@chosun.com','45338ea5-aaea-11e6-8cda-d067e51fd419'),('chan@chopsun.com','45338ea5-aaea-11e6-8cda-d067e51fd414'),('kds@chosun.com','45338ea5-aaea-11e6-8cda-d067e51fd414'),('dylee@chosun.com','45338ea5-aaea-11e6-8cda-d067e51fd414'),('hmokim@chosun.com','45338ea5-aaea-11e6-8cda-d067e51fd414'),('bhkim@chosun.com','45338ea5-aaea-11e6-8cda-d067e51fd414');
/*!40000 ALTER TABLE `user_authority` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_dept_position`
--

DROP TABLE IF EXISTS `user_dept_position`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_dept_position` (
  `userid` varchar(128) DEFAULT NULL,
  `deptid` varchar(128) DEFAULT NULL,
  `positionid` varchar(128) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_dept_position`
--

LOCK TABLES `user_dept_position` WRITE;
/*!40000 ALTER TABLE `user_dept_position` DISABLE KEYS */;
INSERT INTO `user_dept_position` VALUES ('yongkum@chosun.com','0a3849ba-c180-47e7-8118-a037d6f3c4ba','cb37711b-aaec-11e6-8cda-d067e51fd421'),('goindol@chosun.com','9c247a2d-77b1-457a-ba9b-43c972125ab6','cb37711b-aaec-11e6-8cda-d067e51fd421'),('goindol@chosun.com','0a3849ba-c180-47e7-8118-a037d6f3c4ba','cb37711b-aaec-11e6-8cda-d067e51fd428'),('rainy@chosun.com','0a3849ba-c180-47e7-8118-a037d6f3c4ba','cb37711b-aaec-11e6-8cda-d067e51fd419'),('myungwons@chosun.com','0a3849ba-c180-47e7-8118-a037d6f3c4ba','cb37711b-aaec-11e6-8cda-d067e51fd416'),('yuzibosu@chosun.com','361a569f-34c3-4520-baf7-f0d32abae6a0','cb37711b-aaec-11e6-8cda-d067e51fd428'),('shlee@chosun.com','361a569f-34c3-4520-baf7-f0d32abae6a0','cb37711b-aaec-11e6-8cda-d067e51fd419'),('yds0903@chosun.com','361a569f-34c3-4520-baf7-f0d32abae6a0','cb37711b-aaec-11e6-8cda-d067e51fd415'),('andrew@chosun.com','d35c8fa9-7fe9-4820-accb-5dfa26b56689','cb37711b-aaec-11e6-8cda-d067e51fd429'),('yunju@chosun.com','aaaadfdfd','cb37711b-aaec-11e6-8cda-d067e51fd431'),('yunju@chosun.com','aaaadfdfd','cb37711b-aaec-11e6-8cda-d067e51fd425'),('bigfoot@chosun.com','36000a74-9c12-4061-9cce-86642f18a09b','cb37711b-aaec-11e6-8cda-d067e51fd432'),('bigfoot@chosun.com','b7bceead-35f2-465c-8b0d-e3819b1d622f','cb37711b-aaec-11e6-8cda-d067e51fd429'),('bigfoot@chosun.com','36000a74-9c12-4061-9cce-86642f18a09b','cb37711b-aaec-11e6-8cda-d067e51fd425'),('chan@chopsun.com','digital_chosunilbo','1e2032f2-deba-49ed-82de-a70fd241734b'),('chan@chopsun.com','digital_chosunilbo','3cd235ac-5390-4b6c-8db1-7299bea560d1'),('kds@chosun.com','442fc8e1-9447-4e60-aed3-ea3eb73396c8','cb37711b-aaec-11e6-8cda-d067e51fd428'),('kds@chosun.com','442fc8e1-9447-4e60-aed3-ea3eb73396c8','cb37711b-aaec-11e6-8cda-d067e51fd420'),('dylee@chosun.com','442fc8e1-9447-4e60-aed3-ea3eb73396c8','cb37711b-aaec-11e6-8cda-d067e51fd418'),('hmokim@chosun.com','fe9b93be-b688-49e3-8c36-b5b3616580f3','cb37711b-aaec-11e6-8cda-d067e51fd429'),('hmokim@chosun.com','fe9b93be-b688-49e3-8c36-b5b3616580f3','cb37711b-aaec-11e6-8cda-d067e51fd424'),('bhkim@chosun.com','25332011-bf0c-46f5-9e7b-4f4a1e13cdee','cb37711b-aaec-11e6-8cda-d067e51fd430'),('bhkim@chosun.com','digital_chosunilbo','a93e6af1-a18f-4ba8-8901-5e3f1bfd60ce');
/*!40000 ALTER TABLE `user_dept_position` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `userid` varchar(100) DEFAULT NULL,
  `firstname` varchar(32) DEFAULT NULL,
  `lastname` varchar(32) DEFAULT NULL,
  `password` varchar(128) DEFAULT NULL,
  `state` char(1) DEFAULT 'Y'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('andrew@chosun.com','현곤','김','hgkim1130','Y'),('bigfoot@chosun.com','대범','편','1234','Y'),('chan@chopsun.com','찬','김','$2a$10$TFr7u1uuw3SmEyKqwWs7rOS8MRw//iV6aPPUYq0.1ZqhqgfjVElUi','Y'),('goindol@chosun.com','웅찬','길','1234','Y'),('myungwons@chosun.com','명원','이','$2a$10$hoq6AEuVdODXFHljcfGstOicD3jSY1emzi7UtJpZDxk0Z2egIlN3i','Y'),('rainy@chosun.com','은영','조','$2a$10$jmmqJopx65IGIdHaLgx9HuTeJ45/OmcpOyNB7SMnyul86asPCwQqe','Y'),('shlee@chosun.com','상혁','이','$2a$10$keiybgdrlUVcDCBDGm8U4uPC05W78mupC7E9Tyh1iawIaGH71k3RG','Y'),('yds0903@chosun.com','동식','윤','$2a$10$miAnvnA/qoICzGAkD0h2iusrxFQzeBIfHcAWDnbbYBB8a6NNZJA0u','Y'),('yongkum@chosun.com','세원','김','$2a$10$B3SVyBeEPR/aInw4BR9breCFCiixOguqEhv/NKUSwvbxM.bV/WqxS','Y'),('yunju@chosun.com','윤주','안','1234','Y'),('yuzibosu@chosun.com','원기','배','$2a$10$b5EEKD3aXa2XsF08t5hfneaJe8HLYMIr1Wb1bOuLs/oHw9ySIFSjO','Y'),('kds@chosun.com','동수','김','$2a$10$aBqG94d8tcVqBSCv/SJsCuzgtY0Qq/jx7hfKbOaHwXHxHgA52Kdxa','Y'),('dylee@chosun.com','대용','이','$2a$10$7OfmmCr6RieVNR3.o9xOf.VeMl652lVydXrvMQgnYzJYN.DOdQ8da','Y'),('hmokim@chosun.com','형모','김','$2a$10$Ao.6yGoa0NmQnnaX5RPp0exZ9QqYuPtkdRvUjyBMQJekqiDGoeCVG','Y'),('bhkim@chosun.com','봉현','김','$2a$10$GnyIW3wwBa8yRZXHytMnj.JYPa/Yq0qv4EVb3XfU31Wzcme.RGRDG','Y');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-02-16 21:20:30
