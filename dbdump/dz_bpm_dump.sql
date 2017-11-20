-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: dz_bpm
-- ------------------------------------------------------
-- Server version	5.7.17

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
INSERT INTO `approve_form_field` VALUES ('a20af14f-04f1-4524-975c-d40410f8a48b','9a43387a-b7c4-4976-a608-a18bd8a296b1',0,0,'type','9'),('a20af14f-04f1-4524-975c-d40410f8a48b','9a43387a-b7c4-4976-a608-a18bd8a296b1',0,0,'startDate','2017-04-10'),('a20af14f-04f1-4524-975c-d40410f8a48b','9a43387a-b7c4-4976-a608-a18bd8a296b1',0,0,'endDate','2017-04-14'),('a20af14f-04f1-4524-975c-d40410f8a48b','9a43387a-b7c4-4976-a608-a18bd8a296b1',0,0,'comment','10년근속휴가'),('a20af14f-04f1-4524-975c-d40410f8a48b','9a43387a-b7c4-4976-a608-a18bd8a296b1',0,0,'remark',''),('a20af14f-04f1-4524-975c-d40410f8a48b','9a43387a-b7c4-4976-a608-a18bd8a296b1',1,0,'deptName','시너지개발부'),('a20af14f-04f1-4524-975c-d40410f8a48b','9a43387a-b7c4-4976-a608-a18bd8a296b1',2,0,'positionName','부장'),('a20af14f-04f1-4524-975c-d40410f8a48b','9a43387a-b7c4-4976-a608-a18bd8a296b1',3,0,'userName','김현곤'),('52eade14-3fd4-4724-860a-f054c88fb8ee','3ea3166c-9079-410f-afbe-3d57525cb0a3',0,0,'receiverName','이상우'),('52eade14-3fd4-4724-860a-f054c88fb8ee','3ea3166c-9079-410f-afbe-3d57525cb0a3',1,0,'receiverId',''),('52eade14-3fd4-4724-860a-f054c88fb8ee','3ea3166c-9079-410f-afbe-3d57525cb0a3',2,0,'referName','이상태'),('52eade14-3fd4-4724-860a-f054c88fb8ee','3ea3166c-9079-410f-afbe-3d57525cb0a3',3,0,'referId',''),('52eade14-3fd4-4724-860a-f054c88fb8ee','3ea3166c-9079-410f-afbe-3d57525cb0a3',4,0,'content','PC 바꿔주세요.'),('52eade14-3fd4-4724-860a-f054c88fb8ee','3ea3166c-9079-410f-afbe-3d57525cb0a3',5,0,'userName','김현곤'),('52eade14-3fd4-4724-860a-f054c88fb8ee','3ea3166c-9079-410f-afbe-3d57525cb0a3',6,0,'deptName','시너지개발부'),('52eade14-3fd4-4724-860a-f054c88fb8ee','3ea3166c-9079-410f-afbe-3d57525cb0a3',7,0,'positionName','부장'),('93df2331-67eb-4dc9-b628-9e8c08168007','3ea3166c-9079-410f-afbe-3d57525cb0a3',0,0,'receiverName','이상우'),('93df2331-67eb-4dc9-b628-9e8c08168007','3ea3166c-9079-410f-afbe-3d57525cb0a3',1,0,'receiverId',''),('93df2331-67eb-4dc9-b628-9e8c08168007','3ea3166c-9079-410f-afbe-3d57525cb0a3',2,0,'referName','이상태'),('93df2331-67eb-4dc9-b628-9e8c08168007','3ea3166c-9079-410f-afbe-3d57525cb0a3',3,0,'referId',''),('93df2331-67eb-4dc9-b628-9e8c08168007','3ea3166c-9079-410f-afbe-3d57525cb0a3',4,0,'content','모니터도 바꿔 주세요.'),('93df2331-67eb-4dc9-b628-9e8c08168007','3ea3166c-9079-410f-afbe-3d57525cb0a3',5,0,'userName','김현곤'),('93df2331-67eb-4dc9-b628-9e8c08168007','3ea3166c-9079-410f-afbe-3d57525cb0a3',6,0,'deptName','시너지개발부'),('93df2331-67eb-4dc9-b628-9e8c08168007','3ea3166c-9079-410f-afbe-3d57525cb0a3',7,0,'positionName','부장'),('2271251b-83e6-4f2f-9359-21a7c0542e8e','3ea3166c-9079-410f-afbe-3d57525cb0a3',0,0,'receiverName','이상우'),('2271251b-83e6-4f2f-9359-21a7c0542e8e','3ea3166c-9079-410f-afbe-3d57525cb0a3',1,0,'receiverId',''),('2271251b-83e6-4f2f-9359-21a7c0542e8e','3ea3166c-9079-410f-afbe-3d57525cb0a3',2,0,'referName','이상태'),('2271251b-83e6-4f2f-9359-21a7c0542e8e','3ea3166c-9079-410f-afbe-3d57525cb0a3',3,0,'referId',''),('2271251b-83e6-4f2f-9359-21a7c0542e8e','3ea3166c-9079-410f-afbe-3d57525cb0a3',4,0,'content','키보드도 어떻게....'),('2271251b-83e6-4f2f-9359-21a7c0542e8e','3ea3166c-9079-410f-afbe-3d57525cb0a3',5,0,'userName','김현곤'),('2271251b-83e6-4f2f-9359-21a7c0542e8e','3ea3166c-9079-410f-afbe-3d57525cb0a3',6,0,'deptName','시너지개발부'),('2271251b-83e6-4f2f-9359-21a7c0542e8e','3ea3166c-9079-410f-afbe-3d57525cb0a3',7,0,'positionName','부장'),('b11ceaa6-75ab-44b9-a256-2ec6dd18fc0b','3ea3166c-9079-410f-afbe-3d57525cb0a3',0,0,'receiverName','이상우'),('b11ceaa6-75ab-44b9-a256-2ec6dd18fc0b','3ea3166c-9079-410f-afbe-3d57525cb0a3',1,0,'receiverId',''),('b11ceaa6-75ab-44b9-a256-2ec6dd18fc0b','3ea3166c-9079-410f-afbe-3d57525cb0a3',2,0,'referName','이상태'),('b11ceaa6-75ab-44b9-a256-2ec6dd18fc0b','3ea3166c-9079-410f-afbe-3d57525cb0a3',3,0,'referId',''),('b11ceaa6-75ab-44b9-a256-2ec6dd18fc0b','3ea3166c-9079-410f-afbe-3d57525cb0a3',4,0,'content','기왕이면 마우스까지...'),('b11ceaa6-75ab-44b9-a256-2ec6dd18fc0b','3ea3166c-9079-410f-afbe-3d57525cb0a3',5,0,'userName','김현곤'),('b11ceaa6-75ab-44b9-a256-2ec6dd18fc0b','3ea3166c-9079-410f-afbe-3d57525cb0a3',6,0,'deptName','시너지개발부'),('b11ceaa6-75ab-44b9-a256-2ec6dd18fc0b','3ea3166c-9079-410f-afbe-3d57525cb0a3',7,0,'positionName','부장'),('c71aab47-5021-4061-b745-0f21a2798f99','ec963a7d-d120-429b-a8f9-8f63a992474c',0,0,'workCert',''),('c71aab47-5021-4061-b745-0f21a2798f99','ec963a7d-d120-429b-a8f9-8f63a992474c',0,0,'positionName',''),('c71aab47-5021-4061-b745-0f21a2798f99','ec963a7d-d120-429b-a8f9-8f63a992474c',0,0,'purpose','은행 제출용'),('c71aab47-5021-4061-b745-0f21a2798f99','ec963a7d-d120-429b-a8f9-8f63a992474c',1,0,'numWithHolding',''),('c71aab47-5021-4061-b745-0f21a2798f99','ec963a7d-d120-429b-a8f9-8f63a992474c',2,0,'numEtc',''),('c71aab47-5021-4061-b745-0f21a2798f99','ec963a7d-d120-429b-a8f9-8f63a992474c',3,0,'deptName','시너지개발부'),('c71aab47-5021-4061-b745-0f21a2798f99','ec963a7d-d120-429b-a8f9-8f63a992474c',4,0,'positionName','부장'),('c71aab47-5021-4061-b745-0f21a2798f99','ec963a7d-d120-429b-a8f9-8f63a992474c',5,0,'employeeDate','2009.06.01'),('c71aab47-5021-4061-b745-0f21a2798f99','ec963a7d-d120-429b-a8f9-8f63a992474c',6,0,'quitDate',''),('c71aab47-5021-4061-b745-0f21a2798f99','ec963a7d-d120-429b-a8f9-8f63a992474c',7,0,'purpose','은행 제출용'),('c71aab47-5021-4061-b745-0f21a2798f99','ec963a7d-d120-429b-a8f9-8f63a992474c',8,0,'present','신한은행'),('c71aab47-5021-4061-b745-0f21a2798f99','ec963a7d-d120-429b-a8f9-8f63a992474c',9,0,'userName','김현곤'),('c71aab47-5021-4061-b745-0f21a2798f99','ec963a7d-d120-429b-a8f9-8f63a992474c',10,0,'workCert','KOR'),('c71aab47-5021-4061-b745-0f21a2798f99','ec963a7d-d120-429b-a8f9-8f63a992474c',11,0,'numWorkCert','1'),('c98c2276-f0a0-4b2c-923b-7768a38904f8','ec963a7d-d120-429b-a8f9-8f63a992474c',0,0,'workCert',''),('c98c2276-f0a0-4b2c-923b-7768a38904f8','ec963a7d-d120-429b-a8f9-8f63a992474c',0,0,'positionName',''),('c98c2276-f0a0-4b2c-923b-7768a38904f8','ec963a7d-d120-429b-a8f9-8f63a992474c',3,0,'numIncomeTax',''),('c98c2276-f0a0-4b2c-923b-7768a38904f8','ec963a7d-d120-429b-a8f9-8f63a992474c',4,0,'numWithHolding',''),('c98c2276-f0a0-4b2c-923b-7768a38904f8','ec963a7d-d120-429b-a8f9-8f63a992474c',5,0,'numEtc',''),('c98c2276-f0a0-4b2c-923b-7768a38904f8','ec963a7d-d120-429b-a8f9-8f63a992474c',6,0,'deptName','시너지개발부'),('c98c2276-f0a0-4b2c-923b-7768a38904f8','ec963a7d-d120-429b-a8f9-8f63a992474c',7,0,'positionName','부장'),('c98c2276-f0a0-4b2c-923b-7768a38904f8','ec963a7d-d120-429b-a8f9-8f63a992474c',8,0,'employeeDate','2009.06.01'),('c98c2276-f0a0-4b2c-923b-7768a38904f8','ec963a7d-d120-429b-a8f9-8f63a992474c',9,0,'quitDate',''),('c98c2276-f0a0-4b2c-923b-7768a38904f8','ec963a7d-d120-429b-a8f9-8f63a992474c',10,0,'purpose','은행제출용'),('c98c2276-f0a0-4b2c-923b-7768a38904f8','ec963a7d-d120-429b-a8f9-8f63a992474c',11,0,'present','신한은행'),('c98c2276-f0a0-4b2c-923b-7768a38904f8','ec963a7d-d120-429b-a8f9-8f63a992474c',12,0,'userName','김현곤'),('c98c2276-f0a0-4b2c-923b-7768a38904f8','ec963a7d-d120-429b-a8f9-8f63a992474c',13,0,'numWorkCert','1'),('c98c2276-f0a0-4b2c-923b-7768a38904f8','ec963a7d-d120-429b-a8f9-8f63a992474c',14,0,'workCert','한글'),('5c83520a-94ef-411d-8193-2e873287ad2d','9a43387a-b7c4-4976-a608-a18bd8a296b1',0,0,'type','1'),('5c83520a-94ef-411d-8193-2e873287ad2d','9a43387a-b7c4-4976-a608-a18bd8a296b1',0,0,'startDate','2017-05-02'),('5c83520a-94ef-411d-8193-2e873287ad2d','9a43387a-b7c4-4976-a608-a18bd8a296b1',0,0,'endDate','2017-05-02'),('5c83520a-94ef-411d-8193-2e873287ad2d','9a43387a-b7c4-4976-a608-a18bd8a296b1',0,0,'comment','개인연차'),('5c83520a-94ef-411d-8193-2e873287ad2d','9a43387a-b7c4-4976-a608-a18bd8a296b1',0,0,'remark',''),('5c83520a-94ef-411d-8193-2e873287ad2d','9a43387a-b7c4-4976-a608-a18bd8a296b1',1,0,'deptName','시너지개발부'),('5c83520a-94ef-411d-8193-2e873287ad2d','9a43387a-b7c4-4976-a608-a18bd8a296b1',2,0,'positionName','부장'),('5c83520a-94ef-411d-8193-2e873287ad2d','9a43387a-b7c4-4976-a608-a18bd8a296b1',3,0,'userName','김현곤');
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
INSERT INTO `approve_history` VALUES ('0a3d1e66-9789-4c9e-a12b-96f3f0432fdc','52eade14-3fd4-4724-860a-f054c88fb8ee','','2017-04-04 17:53:18','stlee@chosun.com','P'),('0dcdfdaa-7901-427f-887a-6d933b776167','93df2331-67eb-4dc9-b628-9e8c08168007','','2017-04-04 17:54:06','cst01@chosun.com','C'),('12c2bfb6-f9e6-4edd-a3c1-ddbbe75285dc','52eade14-3fd4-4724-860a-f054c88fb8ee','','2017-04-04 17:52:33','cst01@chosun.com','P'),('1b2a3d61-08bf-4f8f-9435-69aef7aeaff5','a20af14f-04f1-4524-975c-d40410f8a48b','','2017-04-04 17:29:03','kds@chosun.com','C'),('1fd77d5e-48f8-44e3-b58f-6b6552a2757f','52eade14-3fd4-4724-860a-f054c88fb8ee','','2017-04-04 17:52:24','cst01@chosun.com','C'),('235b942f-485b-400d-a2e4-a9508b25b9de','5c83520a-94ef-411d-8193-2e873287ad2d','','2017-04-26 17:05:05','andrew@chosun.com','P'),('2bc6cdb8-8b86-4098-9910-6cbd21010244','a20af14f-04f1-4524-975c-d40410f8a48b','','2017-04-04 17:28:19','yunju@chosun.com','P'),('3387c3c1-55e8-48c6-a6af-89d3af78e046','a20af14f-04f1-4524-975c-d40410f8a48b','','2017-04-04 17:28:41','dylee@chosun.com','C'),('37427380-36b8-4ae3-916d-e159a821178a','a20af14f-04f1-4524-975c-d40410f8a48b','','2017-04-04 17:28:51','dylee@chosun.com','P'),('38f240b5-2d35-4c77-ac67-f9bf41a28a4e','a20af14f-04f1-4524-975c-d40410f8a48b','','2017-04-04 17:28:13','yunju@chosun.com','C'),('4a3edff1-20a5-47ef-9933-cddf61b714b2','c71aab47-5021-4061-b745-0f21a2798f99','','2017-04-05 18:27:01','bigfoot@chosun.com','P'),('51d47c89-20fb-4513-b1dc-1489da905730','a20af14f-04f1-4524-975c-d40410f8a48b','','2017-04-04 17:27:57','bigfoot@chosun.com','C'),('52f995e1-70d1-4138-a5fa-137bf273bd88','b11ceaa6-75ab-44b9-a256-2ec6dd18fc0b','','2017-04-04 17:59:06','cst01@chosun.com','P'),('548e06e7-2474-4d51-b996-efe57becec81','c71aab47-5021-4061-b745-0f21a2798f99','','2017-04-05 18:26:56','bigfoot@chosun.com','C'),('5a377a8c-09d0-46d7-b519-b26b5001398c','b11ceaa6-75ab-44b9-a256-2ec6dd18fc0b','','2017-04-04 17:58:52','andrew@chosun.com','P'),('5fe56e7d-d3f5-4854-990a-ebf63510baf6','2271251b-83e6-4f2f-9359-21a7c0542e8e','','2017-04-04 17:58:18','cst01@chosun.com','P'),('63b23c94-6f84-40cc-8dde-4b150d3f653f','b11ceaa6-75ab-44b9-a256-2ec6dd18fc0b','','2017-04-04 18:00:38','cst01@chosun.com','C'),('6582bdf3-0d51-4a2c-a438-2e2fbdb47386','93df2331-67eb-4dc9-b628-9e8c08168007','','2017-04-04 17:54:08','cst01@chosun.com','P'),('68190468-cb91-40a2-90cf-4d6ff3ffcbe7','52eade14-3fd4-4724-860a-f054c88fb8ee','','2017-04-04 17:45:50','andrew@chosun.com','P'),('6821514e-86db-4e38-a2be-7497d25471af','2271251b-83e6-4f2f-9359-21a7c0542e8e','','2017-04-04 17:58:11','cst01@chosun.com','C'),('7082e56a-0d68-4476-bba1-becf77ddd9a7','a20af14f-04f1-4524-975c-d40410f8a48b','','2017-04-04 17:29:27','hmokim@chosun.com','P'),('749b6102-617c-4643-9dd3-aeb9a89f5191','2271251b-83e6-4f2f-9359-21a7c0542e8e','','2017-04-04 17:55:36','andrew@chosun.com','P'),('804a967d-38c3-4e41-a018-215d81c18fa8','c98c2276-f0a0-4b2c-923b-7768a38904f8','','2017-04-05 18:27:07','bigfoot@chosun.com','C'),('82f297fd-c7bd-4a27-ac95-a45fdc693128','c98c2276-f0a0-4b2c-923b-7768a38904f8','','2017-04-05 18:27:12','bigfoot@chosun.com','P'),('89cc0882-a5c3-48cf-bf3a-80717afedab5','b11ceaa6-75ab-44b9-a256-2ec6dd18fc0b','','2017-04-04 18:00:39','cst01@chosun.com','P'),('9301afaf-0aa8-4a21-b23d-d385766af8fb','a20af14f-04f1-4524-975c-d40410f8a48b','','2017-04-04 17:28:00','bigfoot@chosun.com','P'),('99620214-7c57-42d5-8c0a-4d906275ef88','5c83520a-94ef-411d-8193-2e873287ad2d','','2017-04-26 17:34:57','bigfoot@chosun.com','C'),('99812292-4f85-432d-aa01-261c04473ca2','93df2331-67eb-4dc9-b628-9e8c08168007','','2017-04-04 17:53:54','andrew@chosun.com','P'),('a6a24e65-a42e-4c8f-90e4-0b08479cc517','2271251b-83e6-4f2f-9359-21a7c0542e8e','','2017-04-04 17:55:44','cst01@chosun.com','C'),('a71088b3-f9c5-4021-a9e8-6049dd4694e7','c98c2276-f0a0-4b2c-923b-7768a38904f8','','2017-04-05 18:26:42','andrew@chosun.com','P'),('b992886f-7a09-46f4-9b92-b1fcd55b79db','2271251b-83e6-4f2f-9359-21a7c0542e8e','','2017-04-04 17:55:49','cst01@chosun.com','P'),('bf47b88d-6299-4d71-841f-dd80167b7fc5','a20af14f-04f1-4524-975c-d40410f8a48b','','2017-04-04 17:29:06','kds@chosun.com','P'),('c051dd2c-b9cd-42de-85b3-7886a2b1a580','b11ceaa6-75ab-44b9-a256-2ec6dd18fc0b','','2017-04-04 18:00:32','cst01@chosun.com','C'),('ce46eed8-2bf6-42a7-b29e-e850a3743b60','a20af14f-04f1-4524-975c-d40410f8a48b','','2017-04-04 17:27:42','andrew@chosun.com','P'),('d58c89ee-5580-4612-b90f-3fd14f6843ad','52eade14-3fd4-4724-860a-f054c88fb8ee','','2017-04-04 17:53:18','stlee@chosun.com','P'),('e6fdbeb3-7204-4ace-908c-05741b783566','52eade14-3fd4-4724-860a-f054c88fb8ee','','2017-04-04 17:46:06','cst01@chosun.com','C'),('e70d1de9-95bb-4a94-b891-d7cfc462e7b6','a20af14f-04f1-4524-975c-d40410f8a48b','','2017-04-04 17:29:15','hmokim@chosun.com','C'),('ecb702a2-c38d-48d6-9b82-aec964dacaf0','c71aab47-5021-4061-b745-0f21a2798f99','','2017-04-05 17:01:49','andrew@chosun.com','P'),('f795928c-650f-4e33-a274-99424d124629','b11ceaa6-75ab-44b9-a256-2ec6dd18fc0b','','2017-04-04 17:59:03','cst01@chosun.com','C'),('fbac2e29-07fa-481c-81cb-a27f73ed65fc','c71aab47-5021-4061-b745-0f21a2798f99','','2017-04-05 16:19:01','andrew@chosun.com','S');
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
INSERT INTO `approve_line` VALUES ('c98461ff-b34e-4656-b39a-cd825f0f1ebc','a20af14f-04f1-4524-975c-d40410f8a48b','andrew@chosun.com','F','2017-04-04 17:27:43',0,'R'),('2f166551-87c0-46cb-99bc-a324c5a1f30f','a20af14f-04f1-4524-975c-d40410f8a48b','bigfoot@chosun.com','F','2017-04-04 17:28:00',1,'R'),('819131ac-f610-410b-a25a-83fdd8707e4e','a20af14f-04f1-4524-975c-d40410f8a48b','yunju@chosun.com','F','2017-04-04 17:28:19',2,'R'),('4d088d0a-c4e2-40c4-89ce-c40d7e982b15','a20af14f-04f1-4524-975c-d40410f8a48b','dylee@chosun.com','F','2017-04-04 17:28:52',0,'P'),('e25f7d3f-4672-44f5-9cfb-884c166d0187','a20af14f-04f1-4524-975c-d40410f8a48b','kds@chosun.com','F','2017-04-04 17:29:06',1,'P'),('9926b766-4a63-465c-9f62-ce13104af0af','a20af14f-04f1-4524-975c-d40410f8a48b','hmokim@chosun.com','F','2017-04-04 17:29:27',2,'P'),('1e11e100-1884-4358-9f28-620dec9f3356','52eade14-3fd4-4724-860a-f054c88fb8ee','andrew@chosun.com','F','2017-04-04 17:45:51',0,'R'),('ba03a6fd-fccb-4b12-a06f-01ca89dc95d8','52eade14-3fd4-4724-860a-f054c88fb8ee','cst01@chosun.com','F','2017-04-04 17:52:33',1,'P'),('da7522df-42e2-4c69-aad6-da7549d46542','52eade14-3fd4-4724-860a-f054c88fb8ee','stlee@chosun.com','F','2017-04-04 17:53:18',1,'S'),('487ba3f6-fb14-44b8-aa2b-758ec4f097f5','93df2331-67eb-4dc9-b628-9e8c08168007','andrew@chosun.com','F','2017-04-04 17:53:54',0,'R'),('f11b1fd0-94aa-42c1-898b-9be577c1fab0','93df2331-67eb-4dc9-b628-9e8c08168007','cst01@chosun.com','F','2017-04-04 17:54:08',1,'P'),('901ded30-5203-4616-bbc8-899467dfe86a','93df2331-67eb-4dc9-b628-9e8c08168007','stlee@chosun.com','P',NULL,1,'S'),('5ddc0b7f-1bf1-435b-941f-f71f98662226','2271251b-83e6-4f2f-9359-21a7c0542e8e','andrew@chosun.com','F','2017-04-04 17:55:36',0,'R'),('346b1595-f03a-4dbd-8261-fe58284ffa4e','2271251b-83e6-4f2f-9359-21a7c0542e8e','cst01@chosun.com','F','2017-04-04 17:58:18',1,'P'),('25ff8990-16c0-42ad-83aa-abe639076109','2271251b-83e6-4f2f-9359-21a7c0542e8e','stlee@chosun.com','P',NULL,1,'S'),('3d0d3fd0-59ea-4a7d-8e8d-a92996def882','b11ceaa6-75ab-44b9-a256-2ec6dd18fc0b','andrew@chosun.com','F','2017-04-04 17:58:52',0,'R'),('68bae9a2-ffa5-4c96-b0b5-0acec896d035','b11ceaa6-75ab-44b9-a256-2ec6dd18fc0b','cst01@chosun.com','F','2017-04-04 18:00:39',1,'P'),('63b441c4-0367-4219-80d5-d958565c9181','b11ceaa6-75ab-44b9-a256-2ec6dd18fc0b','stlee@chosun.com','P',NULL,1,'S'),('b0b34883-01bb-4c56-b41d-333faa4f5c0a','c71aab47-5021-4061-b745-0f21a2798f99','andrew@chosun.com','F','2017-04-05 17:01:50',0,'R'),('366c105f-9bcc-400b-8cd9-6e90e215858b','c71aab47-5021-4061-b745-0f21a2798f99','bigfoot@chosun.com','F','2017-04-05 18:27:01',1,'R'),('9668bccb-3cb4-446a-ae77-5f1fbf1d93db','c98c2276-f0a0-4b2c-923b-7768a38904f8','andrew@chosun.com','F','2017-04-05 18:26:42',0,'R'),('3653d49a-dd54-45ea-9c3e-69a4aea156f4','c98c2276-f0a0-4b2c-923b-7768a38904f8','bigfoot@chosun.com','F','2017-04-05 18:27:12',1,'R'),('430d4639-9499-4c10-804a-97147d515d77','5c83520a-94ef-411d-8193-2e873287ad2d','andrew@chosun.com','F','2017-04-26 17:05:05',0,'R'),('4bb40a27-8531-45d5-b8a7-7c58bf21b22a','5c83520a-94ef-411d-8193-2e873287ad2d','bigfoot@chosun.com','P',NULL,1,'R'),('47c5713e-f48f-462f-bb86-e79a99518c2d','5c83520a-94ef-411d-8193-2e873287ad2d','yunju@chosun.com','P',NULL,2,'R');
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
INSERT INTO `approve_summary` VALUES ('a20af14f-04f1-4524-975c-d40410f8a48b','휴가원','andrew@chosun.com','2017-04-04 17:27:42','2017-04-04 17:29:27','F','9a43387a-b7c4-4976-a608-a18bd8a296b1'),('52eade14-3fd4-4724-860a-f054c88fb8ee','업무협조','andrew@chosun.com','2017-04-04 17:45:50','2017-04-04 17:53:18','F','3ea3166c-9079-410f-afbe-3d57525cb0a3'),('93df2331-67eb-4dc9-b628-9e8c08168007','업무협조','andrew@chosun.com','2017-04-04 17:53:53','2017-04-04 17:54:08','F','3ea3166c-9079-410f-afbe-3d57525cb0a3'),('2271251b-83e6-4f2f-9359-21a7c0542e8e','업무협조','andrew@chosun.com','2017-04-04 17:55:35','2017-04-04 17:58:19','F','3ea3166c-9079-410f-afbe-3d57525cb0a3'),('b11ceaa6-75ab-44b9-a256-2ec6dd18fc0b','업무협조','andrew@chosun.com','2017-04-04 17:58:51','2017-04-04 18:00:39','F','3ea3166c-9079-410f-afbe-3d57525cb0a3'),('c71aab47-5021-4061-b745-0f21a2798f99','제증명신청서','andrew@chosun.com','2017-04-05 16:19:01','2017-04-05 18:27:02','F','ec963a7d-d120-429b-a8f9-8f63a992474c'),('c98c2276-f0a0-4b2c-923b-7768a38904f8','제증명신청서','andrew@chosun.com','2017-04-05 18:26:42','2017-04-05 18:27:12','F','ec963a7d-d120-429b-a8f9-8f63a992474c'),('5c83520a-94ef-411d-8193-2e873287ad2d','휴가원','andrew@chosun.com','2017-04-26 17:05:04','2017-04-26 17:05:04','P','9a43387a-b7c4-4976-a608-a18bd8a296b1');
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
INSERT INTO `approve_tray` VALUES ('2271251b-83e6-4f2f-9359-21a7c0542e8e','andrew@chosun.com','2017-04-04 17:55:36','F'),('2271251b-83e6-4f2f-9359-21a7c0542e8e','cst01@chosun.com','2017-04-04 17:58:19','F'),('2271251b-83e6-4f2f-9359-21a7c0542e8e','stlee@chosun.com','2017-04-04 17:55:36','S'),('52eade14-3fd4-4724-860a-f054c88fb8ee','andrew@chosun.com','2017-04-04 17:45:50','F'),('52eade14-3fd4-4724-860a-f054c88fb8ee','cst01@chosun.com','2017-04-04 17:52:33','F'),('52eade14-3fd4-4724-860a-f054c88fb8ee','stlee@chosun.com','2017-04-04 17:53:18','F'),('5c83520a-94ef-411d-8193-2e873287ad2d','andrew@chosun.com','2017-04-26 17:05:05','F'),('5c83520a-94ef-411d-8193-2e873287ad2d','bigfoot@chosun.com','2017-04-26 17:05:05','U'),('5c83520a-94ef-411d-8193-2e873287ad2d','yunju@chosun.com','2017-04-26 17:05:05','E'),('93df2331-67eb-4dc9-b628-9e8c08168007','andrew@chosun.com','2017-04-04 17:53:54','F'),('93df2331-67eb-4dc9-b628-9e8c08168007','cst01@chosun.com','2017-04-04 17:54:08','F'),('93df2331-67eb-4dc9-b628-9e8c08168007','stlee@chosun.com','2017-04-04 17:53:54','S'),('a20af14f-04f1-4524-975c-d40410f8a48b','andrew@chosun.com','2017-04-04 17:27:42','F'),('a20af14f-04f1-4524-975c-d40410f8a48b','bigfoot@chosun.com','2017-04-04 17:28:00','F'),('a20af14f-04f1-4524-975c-d40410f8a48b','dylee@chosun.com','2017-04-04 17:28:51','F'),('a20af14f-04f1-4524-975c-d40410f8a48b','hmokim@chosun.com','2017-04-04 17:29:27','F'),('a20af14f-04f1-4524-975c-d40410f8a48b','kds@chosun.com','2017-04-04 17:29:06','F'),('a20af14f-04f1-4524-975c-d40410f8a48b','yunju@chosun.com','2017-04-04 17:28:19','F'),('b11ceaa6-75ab-44b9-a256-2ec6dd18fc0b','andrew@chosun.com','2017-04-04 17:58:52','F'),('b11ceaa6-75ab-44b9-a256-2ec6dd18fc0b','cst01@chosun.com','2017-04-04 18:00:39','F'),('b11ceaa6-75ab-44b9-a256-2ec6dd18fc0b','stlee@chosun.com','2017-04-04 17:58:52','S'),('c71aab47-5021-4061-b745-0f21a2798f99','andrew@chosun.com','2017-04-05 17:01:50','F'),('c71aab47-5021-4061-b745-0f21a2798f99','bigfoot@chosun.com','2017-04-05 18:27:02','F'),('c98c2276-f0a0-4b2c-923b-7768a38904f8','andrew@chosun.com','2017-04-05 18:26:42','F'),('c98c2276-f0a0-4b2c-923b-7768a38904f8','bigfoot@chosun.com','2017-04-05 18:27:12','F');
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
INSERT INTO `custom_approve_line` VALUES ('9608452d-f3e5-11e6-ae1a-0a0027000015','yunju@chosun.com',2),('9608452d-f3e5-11e6-ae1a-0a0027000015','andrew@chosun.com',0),('9608452d-f3e5-11e6-ae1a-0a0027000015','bigfoot@chosun.com',1),('e9d27368-20fc-4cde-9c55-02359702fcce','andrew@chosun.com',0),('e9d27368-20fc-4cde-9c55-02359702fcce','yunju@chosun.com',1),('2e2891b2-8576-4990-93d0-159c61a2c505','yunju@chosun.com',0),('58f7b802-30bd-40a4-b95d-7742c1e1a546','andrew@chosun.com',0),('58f7b802-30bd-40a4-b95d-7742c1e1a546','bigfoot@chosun.com',1);
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
INSERT INTO `custom_approve_line_summary` VALUES ('2e2891b2-8576-4990-93d0-159c61a2c505','9a43387a-b7c4-4976-a608-a18bd8a296b1','yunju@chosun.com','휴가원','2017-02-21 15:07:00'),('58f7b802-30bd-40a4-b95d-7742c1e1a546','ec963a7d-d120-429b-a8f9-8f63a992474c','andrew@chosun.com','제증명신청서','2017-04-05 17:25:38'),('9608452d-f3e5-11e6-ae1a-0a0027000015','9a43387a-b7c4-4976-a608-a18bd8a296b1','andrew@chosun.com','휴가원 결재 라인','2017-02-16 10:21:57'),('e9d27368-20fc-4cde-9c55-02359702fcce','9a43387a-b7c4-4976-a608-a18bd8a296b1','andrew@chosun.com','휴가원','2017-02-21 10:12:24');
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
  `depth` int(10) DEFAULT '0',
  `seq` int(10) NOT NULL DEFAULT '0' COMMENT '부서 노출 순번\r\n같은 depth를 갖는 부서끼리 다른 순번을 부여한다.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `departments`
--

LOCK TABLES `departments` WRITE;
/*!40000 ALTER TABLE `departments` DISABLE KEYS */;
INSERT INTO `departments` VALUES ('25332011-bf0c-46f5-9e7b-4f4a1e13cdee','00c22eec-490a-4931-8cdb-4719f64250cc','d4d8448b-aaea-11e6-8cda-d067e51fd415','재경부','Y','2017-01-05 14:51:19',2,1),('fe0fa567-fe30-4b16-92b8-6be075982b82','06e2f9aa-d74d-4fdb-bafb-03fbf2685d25','d4d8448b-aaea-11e6-8cda-d067e51fd415','NS개발팀','Y','2017-01-05 14:53:07',4,1),('9c247a2d-77b1-457a-ba9b-43c972125ab6','0a3849ba-c180-47e7-8118-a037d6f3c4ba','d4d8448b-aaea-11e6-8cda-d067e51fd415','인터넷개발팀','Y','2017-03-31 18:16:51',4,1),('36000a74-9c12-4061-9cce-86642f18a09b','1939ef1e-b45b-4427-8473-602f10189344','d4d8448b-aaea-11e6-8cda-d067e51fd415','CTS기술부','Y','2017-03-31 10:36:01',3,10),('digital_chosunilbo','22ba2ef1-f771-48bb-99fb-3f6df4a3691a','d4d8448b-aaea-11e6-8cda-d067e51fd415','조선닷컴편집본부','Y','2016-08-09 11:26:22',1,2),('digital_chosunilbo','25332011-bf0c-46f5-9e7b-4f4a1e13cdee','d4d8448b-aaea-11e6-8cda-d067e51fd415','경영전략본부','Y','2017-02-10 10:02:16',1,1),('fe9b93be-b688-49e3-8c36-b5b3616580f3','26a1c355-f322-4fac-875e-1f2a78b5ccda','d4d8448b-aaea-11e6-8cda-d067e51fd415','대외협력팀','Y','2017-01-05 14:52:37',3,1),('aaaadfdfd','26ff5f6a-eae6-44ab-af25-43a99b07ddb8','d4d8448b-aaea-11e6-8cda-d067e51fd415','CTS부문','Y','2017-03-31 10:35:48',2,10),('b7bceead-35f2-465c-8b0d-e3819b1d622f','29088aea-c4da-4041-a6aa-907ae12e22ab','d4d8448b-aaea-11e6-8cda-d067e51fd415','IT협력팀','Y','2017-03-31 10:35:32',4,1),('aaaadfdfd','36000a74-9c12-4061-9cce-86642f18a09b','d4d8448b-aaea-11e6-8cda-d067e51fd415','미디어부문','Y','2017-03-31 10:35:52',2,20),('d35c8fa9-7fe9-4820-accb-5dfa26b56689','361a569f-34c3-4520-baf7-f0d32abae6a0','d4d8448b-aaea-11e6-8cda-d067e51fd415','시너지개발팀','Y','2017-01-05 14:53:26',4,1),('fe9b93be-b688-49e3-8c36-b5b3616580f3','442fc8e1-9447-4e60-aed3-ea3eb73396c8','d4d8448b-aaea-11e6-8cda-d067e51fd415','인사기획팀','Y','2017-02-08 18:49:14',3,2),('22ba2ef1-f771-48bb-99fb-3f6df4a3691a','49f45cdb-17be-4bbc-97ee-4c60a653b8ab','d4d8448b-aaea-11e6-8cda-d067e51fd415','뉴스미디어부','Y','2016-08-09 11:26:56',2,1),('1939ef1e-b45b-4427-8473-602f10189344','4dea7638-2eae-4e6d-865c-111bd6bf6769','d4d8448b-aaea-11e6-8cda-d067e51fd415','CTS시스템팀','Y','2016-08-05 13:52:09',4,1),('digital_chosunilbo','6a364c59-bbad-43a4-a5f9-ffa4b6860f9d','d4d8448b-aaea-11e6-8cda-d067e51fd415','마케팅본부','Y','2017-01-04 14:30:45',1,4),('00c22eec-490a-4931-8cdb-4719f64250cc','9b6859d4-70bf-42c8-850d-26c604ecbbd5','d4d8448b-aaea-11e6-8cda-d067e51fd415','회계팀','Y','2017-01-05 14:51:33',3,1),('36000a74-9c12-4061-9cce-86642f18a09b','9c247a2d-77b1-457a-ba9b-43c972125ab6','d4d8448b-aaea-11e6-8cda-d067e51fd415','솔루션개발부','Y','2017-03-31 18:16:40',3,20),('#','a11f0a80-5e09-11e6-b356-00090ffe0001','d4d8448b-aaea-11e6-8cda-d067e51fd416','TV조선','Y','2016-08-09 17:18:53',0,2),('chosunilbo','a5690ed4-b929-440b-a52f-b33759559df5','d4d8448b-aaea-11e6-8cda-d067e51fd414','경영기획실','Y','2016-08-09 13:20:24',1,1),('a11f0a80-5e09-11e6-b356-00090ffe0001','a61bda35-8e4d-4490-b0f2-d6af329ad046','d4d8448b-aaea-11e6-8cda-d067e51fd416','최상위부서','Y','2016-08-09 17:19:03',1,1),('digital_chosunilbo','aaaadfdfd','d4d8448b-aaea-11e6-8cda-d067e51fd415','뉴미디어연구소','Y','2017-01-05 15:40:50',1,3),('36000a74-9c12-4061-9cce-86642f18a09b','b7bceead-35f2-465c-8b0d-e3819b1d622f','d4d8448b-aaea-11e6-8cda-d067e51fd415','미디어기술부','Y','2017-03-31 18:17:12',3,30),('fe9b93be-b688-49e3-8c36-b5b3616580f3','b7d2ae01-354e-4c37-873e-81fc9a45795b','d4d8448b-aaea-11e6-8cda-d067e51fd415','총무팀','Y','2017-01-05 14:52:43',3,3),('9c247a2d-77b1-457a-ba9b-43c972125ab6','bc5e4a80-50a8-44b1-a71b-4e5c64ce724b','d4d8448b-aaea-11e6-8cda-d067e51fd415','모바일개발팀','Y','2016-08-04 17:14:07',4,2),('fb263624-cf6d-46a6-9064-661e54786983','bd38a700-1c7d-4778-ad88-38627192f394','d4d8448b-aaea-11e6-8cda-d067e51fd415','미디어세일즈팀','Y','2017-01-05 14:52:53',3,1),('fb263624-cf6d-46a6-9064-661e54786983','c13fa29a-a148-4df0-9e02-b8be7db9bd8f','d4d8448b-aaea-11e6-8cda-d067e51fd415','애드커뮤니케이션팀','Y','2017-01-05 14:52:55',3,2),('b7bceead-35f2-465c-8b0d-e3819b1d622f','c6a2df5d-7ca6-4071-8428-4a7f52443700','d4d8448b-aaea-11e6-8cda-d067e51fd415','IT시스템팀','Y','2017-03-31 10:21:55',4,2),('#','chosunilbo','d4d8448b-aaea-11e6-8cda-d067e51fd414','조선일보','Y','2016-08-09 00:00:00',0,1),('36000a74-9c12-4061-9cce-86642f18a09b','d35c8fa9-7fe9-4820-accb-5dfa26b56689','d4d8448b-aaea-11e6-8cda-d067e51fd415','시너지개발부','Y','2017-03-31 10:36:11',3,40),('#','digital_chosunilbo','d4d8448b-aaea-11e6-8cda-d067e51fd415','디지틀조선일보','Y','2017-01-05 15:40:41',0,3),('6a364c59-bbad-43a4-a5f9-ffa4b6860f9d','fb263624-cf6d-46a6-9064-661e54786983','d4d8448b-aaea-11e6-8cda-d067e51fd415','마케팅부','Y','2017-01-05 14:52:50',2,1),('26ff5f6a-eae6-44ab-af25-43a99b07ddb8','fe0fa567-fe30-4b16-92b8-6be075982b82','d4d8448b-aaea-11e6-8cda-d067e51fd415','NS개발부','Y','2017-01-05 14:53:02',3,1),('25332011-bf0c-46f5-9e7b-4f4a1e13cdee','fe9b93be-b688-49e3-8c36-b5b3616580f3','d4d8448b-aaea-11e6-8cda-d067e51fd415','경영관리부','Y','2017-02-10 10:02:03',2,2);
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
INSERT INTO `dept_docmanager` VALUES ('361a569f-34c3-4520-baf7-f0d32abae6a0','yuzibosu@chosun.com','M'),('361a569f-34c3-4520-baf7-f0d32abae6a0','shlee@chosun.com','S'),('digital_chosunilbo','chan@chopsun.com','M'),('aaaadfdfd','yunju@chosun.com','M'),('442fc8e1-9447-4e60-aed3-ea3eb73396c8','dylee@chosun.com','M'),('442fc8e1-9447-4e60-aed3-ea3eb73396c8','kds@chosun.com','S'),('fe9b93be-b688-49e3-8c36-b5b3616580f3','hmokim@chosun.com','M'),('25332011-bf0c-46f5-9e7b-4f4a1e13cdee','bhkim@chosun.com','M'),('36000a74-9c12-4061-9cce-86642f18a09b','bigfoot@chosun.com','M'),('d35c8fa9-7fe9-4820-accb-5dfa26b56689','andrew@chosun.com','M'),('9c247a2d-77b1-457a-ba9b-43c972125ab6','goindol@chosun.com','M'),('0a3849ba-c180-47e7-8118-a037d6f3c4ba','goindol@chosun.com','M'),('b7bceead-35f2-465c-8b0d-e3819b1d622f','bigfoot@chosun.com','M');
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
INSERT INTO `file_attach` VALUES ('98d98414-7eeb-45cc-9def-0f437d5428ba','','D:/Google 드라이브/프로젝트/DZBpms/src/main/webapp/WEB-INF/views/forms/','2e79261b-0664-427d-96d6-b3b239bea57f.jsp','9a43387a-b7c4-4976-a608-a18bd8a296b1','2017-01-10 15:20:19','389730f4-723f-4fa4-bf22-34c5d88c6679.jsp',3622),('9da5b9d3-c05b-422c-a0ef-af6344dc9a64','','e:/workspace/DZBpms/src/main/webapp/WEB-INF/views/forms/','6d0c75c1-3fb3-4349-afa1-b226149a4244.jsp','3ea3166c-9079-410f-afbe-3d57525cb0a3','2017-02-22 19:10:38','업무협조.jsp',1713),('e7da84dd-952a-42ea-a4bb-90bc37ebfab6','','d:/git/DZBpms/src/main/webapp/WEB-INF/views/forms/','597516ed-b272-4ee5-bff4-7dc050730250.jsp','447c0199-f5a6-4903-9e54-d6ae1dcba699','2017-04-05 14:29:27','제증명신청서.jsp',3387),('1a296a0d-2fc0-4091-bde4-498ff94d9cdb','','d:/git/DZBpms/src/main/webapp/WEB-INF/views/forms/','597516ed-b272-4ee5-bff4-7dc050730250.jsp','ec963a7d-d120-429b-a8f9-8f63a992474c','2017-04-05 14:32:37','제증명신청서.jsp',3387);
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
  `procDept` varchar(128) DEFAULT NULL COMMENT '처리부서 아이디',
  `postProc` varchar(128) DEFAULT NULL COMMENT '후처리 프포세스의 className'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `form`
--

LOCK TABLES `form` WRITE;
/*!40000 ALTER TABLE `form` DISABLE KEYS */;
INSERT INTO `form` VALUES ('9a43387a-b7c4-4976-a608-a18bd8a296b1','휴가원','휴가원 결재 양식','2017-01-10 15:20:19','2017-03-17 14:02:02','andrew@chosun.com','Y','442fc8e1-9447-4e60-aed3-ea3eb73396c8','com.dizzo.bpms.post.SchedulePostProcess'),('3ea3166c-9079-410f-afbe-3d57525cb0a3','업무협조','업무협조 양식','2017-02-22 19:10:38','2017-02-22 19:10:38','andrew@chosun.com','Y',NULL,NULL),('ec963a7d-d120-429b-a8f9-8f63a992474c','제증명신청서','제증명신청서 양식','2017-04-05 14:32:37','2017-04-05 14:32:37','andrew@chosun.com','Y','b7d2ae01-354e-4c37-873e-81fc9a45795b',NULL);
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
INSERT INTO `form_field` VALUES ('9a43387a-b7c4-4976-a608-a18bd8a296b1',0,0,'deptName',''),('9a43387a-b7c4-4976-a608-a18bd8a296b1',1,0,'positionName',''),('9a43387a-b7c4-4976-a608-a18bd8a296b1',2,0,'userName',''),('9a43387a-b7c4-4976-a608-a18bd8a296b1',3,0,'type',''),('9a43387a-b7c4-4976-a608-a18bd8a296b1',3,0,'startDate',''),('9a43387a-b7c4-4976-a608-a18bd8a296b1',3,0,'endDate',''),('9a43387a-b7c4-4976-a608-a18bd8a296b1',3,0,'comment',''),('9a43387a-b7c4-4976-a608-a18bd8a296b1',3,0,'remark',''),('3ea3166c-9079-410f-afbe-3d57525cb0a3',0,0,'receiverName',''),('3ea3166c-9079-410f-afbe-3d57525cb0a3',1,0,'receiverId',''),('3ea3166c-9079-410f-afbe-3d57525cb0a3',2,0,'referName',''),('3ea3166c-9079-410f-afbe-3d57525cb0a3',3,0,'referId',''),('3ea3166c-9079-410f-afbe-3d57525cb0a3',4,0,'content',''),('ec963a7d-d120-429b-a8f9-8f63a992474c',0,0,'workCert',''),('ec963a7d-d120-429b-a8f9-8f63a992474c',1,0,'workCert',''),('ec963a7d-d120-429b-a8f9-8f63a992474c',2,0,'numWorkCert',''),('ec963a7d-d120-429b-a8f9-8f63a992474c',3,0,'careerCert',''),('ec963a7d-d120-429b-a8f9-8f63a992474c',4,0,'careerCert',''),('ec963a7d-d120-429b-a8f9-8f63a992474c',5,0,'numCareerCert',''),('ec963a7d-d120-429b-a8f9-8f63a992474c',6,0,'numIncomeTax',''),('ec963a7d-d120-429b-a8f9-8f63a992474c',7,0,'numWithHolding',''),('ec963a7d-d120-429b-a8f9-8f63a992474c',8,0,'numEtc',''),('ec963a7d-d120-429b-a8f9-8f63a992474c',9,0,'deptName',''),('ec963a7d-d120-429b-a8f9-8f63a992474c',10,0,'positionName',''),('ec963a7d-d120-429b-a8f9-8f63a992474c',11,0,'employeeDate',''),('ec963a7d-d120-429b-a8f9-8f63a992474c',12,0,'quitDate',''),('ec963a7d-d120-429b-a8f9-8f63a992474c',13,0,'purpose',''),('ec963a7d-d120-429b-a8f9-8f63a992474c',14,0,'present','');
/*!40000 ALTER TABLE `form_field` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `message_queue`
--

DROP TABLE IF EXISTS `message_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `message_queue` (
  `id` varchar(128) NOT NULL COMMENT 'Unique ID',
  `type` char(1) NOT NULL COMMENT '메시지 구분\r\nT : 작업에 대한 메시지\r\nA : 결재에 대한 메시지',
  `origin` char(1) NOT NULL DEFAULT 'I' COMMENT '메시지 출처\r\nI : 내부 (작업, 결재 등의 내부 프로세스에 의한 메시지)\r\nO : 외부 시스템에 의해 전달된 메시지',
  `userId` varchar(128) NOT NULL COMMENT '메시지를 수신할 사용자 아이디',
  `message` varchar(2000) DEFAULT NULL COMMENT '메시지 내용',
  `readyn` char(1) NOT NULL DEFAULT 'N' COMMENT '메시지 읽음 여부',
  `created` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='AMQP를 통해 전달된 메시지를 저장하는 큐';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `message_queue`
--

LOCK TABLES `message_queue` WRITE;
/*!40000 ALTER TABLE `message_queue` DISABLE KEYS */;
INSERT INTO `message_queue` VALUES ('1210-dfasf0-dfd9-dfd','T','I','andrew@chosun.com','테스트입니다.','Y','2017-04-26 15:23:34'),('281fab16-2981-11e7-a238-d8cb8a841264','A','I','andrew@chosun.com','결재문서 완료','Y','2017-04-26 15:23:43'),('5a2ad1a8-3651-4b01-877a-0cf7b126d332','T','I','shlee@chosun.com','신규 작업 작업 등록 메시지이(가) 생성되었습니다.','N','2017-04-27 17:24:55'),('daad75d3-4452-486a-ab8d-967a07c2b288','T','I','yds0903@chosun.com','신규 작업 작업 메시지 테스트이(가) 생성되었습니다.','N','2017-04-27 18:02:29');
/*!40000 ALTER TABLE `message_queue` ENABLE KEYS */;
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
INSERT INTO `position` VALUES ('1e2032f2-deba-49ed-82de-a70fd241734b','사장','R',10000),('cb37711b-aaec-11e6-8cda-d067e51fd414','사원','P',10),('cb37711b-aaec-11e6-8cda-d067e51fd415','대리','P',20),('cb37711b-aaec-11e6-8cda-d067e51fd416','과장대우','P',30),('cb37711b-aaec-11e6-8cda-d067e51fd417','과장','P',40),('cb37711b-aaec-11e6-8cda-d067e51fd418','차장대우','P',50),('cb37711b-aaec-11e6-8cda-d067e51fd419','차장','P',60),('cb37711b-aaec-11e6-8cda-d067e51fd420','부장대우','P',70),('cb37711b-aaec-11e6-8cda-d067e51fd421','부장','P',80),('cb37711b-aaec-11e6-8cda-d067e51fd422','부국장대우','P',90),('cb37711b-aaec-11e6-8cda-d067e51fd423','부국장','P',100),('cb37711b-aaec-11e6-8cda-d067e51fd424','국장대우','P',110),('cb37711b-aaec-11e6-8cda-d067e51fd425','국장','P',120),('cb37711b-aaec-11e6-8cda-d067e51fd427','이사','P',130),('cb37711b-aaec-11e6-8cda-d067e51fd428','팀장','R',1000),('cb37711b-aaec-11e6-8cda-d067e51fd429','부장','R',2000),('cb37711b-aaec-11e6-8cda-d067e51fd430','본부장','R',4000),('cb37711b-aaec-11e6-8cda-d067e51fd431','소장','R',4000),('cb37711b-aaec-11e6-8cda-d067e51fd432','국장','R',4000),('cb37711b-aaec-11e6-8cda-d067e51fd433','실장','R',4000),('cb37711b-aaec-11e6-8cda-d067e51fd434','원장','R',4000),('cb37711b-aaec-11e6-8cda-d067e51fd435','부원장','R',3500),('cb37711b-aaec-11e6-8cda-d067e51fd436','계약직원','P',5),('3cd235ac-5390-4b6c-8db1-7299bea560d1','대표이사','P',11000),('a93e6af1-a18f-4ba8-8901-5e3f1bfd60ce','상무','P',150),('13877fb5-5c28-48bd-a1cd-68d250d6a422','??','R',5000);
/*!40000 ALTER TABLE `position` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schedule`
--

DROP TABLE IF EXISTS `schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schedule` (
  `id` varchar(128) NOT NULL COMMENT 'ID',
  `userId` varchar(128) NOT NULL COMMENT '사용자 ID',
  `start` datetime NOT NULL COMMENT '시작일자',
  `end` datetime NOT NULL COMMENT '종료일자',
  `type` char(1) NOT NULL COMMENT '일정 종류\r\nT : 작업일정 (작업 연동)\r\nV : 휴가 일정 (휴가원 연동)\r\nP : 개인 일정',
  `content` varchar(512) DEFAULT NULL COMMENT '일정 내용',
  `referUrl` varchar(256) DEFAULT NULL COMMENT '참조 URL\r\n작업 내용 보기, 휴가원 보기 등',
  `title` varchar(256) NOT NULL COMMENT '제목',
  `refId` varchar(128) DEFAULT NULL COMMENT '관련 ID\r\nTask.id, Approve.Id',
  PRIMARY KEY (`id`),
  KEY `schedule_id_userId_idx` (`id`,`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='일정 표시 테이블';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schedule`
--

LOCK TABLES `schedule` WRITE;
/*!40000 ALTER TABLE `schedule` DISABLE KEYS */;
INSERT INTO `schedule` VALUES ('22222','andrew@chosun.com','2017-03-07 00:00:00','2017-03-09 23:59:59','T','일정화면 완료',NULL,'일정화면 완료',NULL),('227a1c0f-a4a2-4d45-bac7-6dbb7b9eb00a','andrew@chosun.com','2017-03-24 14:00:00','2017-03-24 15:00:00','P','',NULL,'테스트',NULL),('3a74319e-e35f-4576-af9e-53d9bc072921','shlee@chosun.com','2017-04-27 00:00:01','2017-04-28 00:00:00','T','메시지 생성 테스트','/edit_task/947c5a5f-f1da-48b0-8d4e-062ffc2c6509','작업 등록 메시지','947c5a5f-f1da-48b0-8d4e-062ffc2c6509'),('5b9a6a62-8a97-4a49-baba-dff6708c2e9e','yds0903@chosun.com','2017-04-27 00:00:00','2017-05-06 00:00:00','T','작업 등록 메시지 확인','/edit_task/4fd4905f-4918-402c-9ad9-4ba7c8733781','작업 메시지 테스트','4fd4905f-4918-402c-9ad9-4ba7c8733781'),('a0414fa5-0146-4981-806b-bf9f6f1c91c4','andrew@chosun.com','2017-04-10 00:00:00','2017-04-14 23:59:59','V','10년근속휴가',NULL,'휴가','a20af14f-04f1-4524-975c-d40410f8a48b'),('b5696dc1-7b31-4778-ad10-5b144d2eca42','yuzibosu@chosun.com','2017-03-15 00:00:00','2017-03-24 23:59:59','T','테스트 진행','/edit_task/23288658-57f9-4ed6-b34c-97500bb6a788','bpms 테스트','23288658-57f9-4ed6-b34c-97500bb6a788'),('bd251890-9a04-49fa-964a-a6215958c473','shlee@chosun.com','2017-03-15 00:00:00','2017-03-31 23:59:59','T','결재 테스트 진행\n반려, 보류','/edit_task/599b9a05-29ce-47b6-8d7d-ba45e7daff35','bpms 결재 테스트','599b9a05-29ce-47b6-8d7d-ba45e7daff35'),('c7b06440-bd9e-4bc4-9d6b-9a50bb2ef25d','andrew@chosun.com','2017-03-24 09:00:00','2017-03-24 10:00:00','P','광화문빌딩 5F 3강의실',NULL,'주주총회',NULL),('cc927be7-498b-4ed3-bcae-817eb6b648b5','andrew@chosun.com','2017-03-24 11:00:00','2017-03-24 13:00:00','P','코리아나호텔 2F',NULL,'대표 이취임식',NULL),('d89002ac-ecad-4d94-84d0-9a6807e95383','shlee@chosun.com','2017-03-31 00:00:01','2017-04-08 00:00:00','T','테스트입니다.','/edit_task/505d41f2-0a1a-481e-89e7-78d49d918e49','작업 테스트','505d41f2-0a1a-481e-89e7-78d49d918e49'),('e31aede5-033a-448f-9582-fcb2315b71fc','yds0903@chosun.com','2017-03-15 12:00:01','2017-03-18 12:00:00','T','작업 등록, 목록, 진척률, 위임, 반려, 취소 테스트','/edit_task/337fa502-fd89-454e-bacd-0c53c694a639','작업 테스트','337fa502-fd89-454e-bacd-0c53c694a639'),('ebb97dff-63fb-4480-896b-e6b3ad7cf650','shlee@chosun.com','2017-04-27 00:00:00','2017-05-05 23:59:59','T','작업 생성 후 메시지 생성 테스트','/edit_task/e489700f-e8ba-4188-a3a4-7ace6f785967','작업 메시지 테스트','e489700f-e8ba-4188-a3a4-7ace6f785967'),('f6d450b2-cfff-497f-8a11-3c38acb00b1e','shlee@chosun.com','2017-04-27 00:00:01','2017-05-05 23:59:59','T','작업 생성 후 메시지 생성 테스트','/edit_task/c02a9d5a-846f-4975-9edb-2f65de50736b','작업 메시지 테스트','c02a9d5a-846f-4975-9edb-2f65de50736b'),('f7bb4949-c04c-4e31-a51c-e91359fb345d','andrew@chosun.com','2017-03-27 00:00:00','2017-03-27 23:59:59','T','내 작업 등록 테스트','/edit_task/6dd8c0d9-2410-4319-9096-2f1d6b091391','본인 일정 등록','6dd8c0d9-2410-4319-9096-2f1d6b091391');
/*!40000 ALTER TABLE `schedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schedule_share`
--

DROP TABLE IF EXISTS `schedule_share`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schedule_share` (
  `id` varchar(128) NOT NULL COMMENT '일정 ID',
  `userId` varchar(128) NOT NULL COMMENT '공유된 사용자 ID',
  PRIMARY KEY (`id`,`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='일정 공유 테이블';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schedule_share`
--

LOCK TABLES `schedule_share` WRITE;
/*!40000 ALTER TABLE `schedule_share` DISABLE KEYS */;
/*!40000 ALTER TABLE `schedule_share` ENABLE KEYS */;
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
  `opened` char(1) DEFAULT 'N' COMMENT 'N: 공개 안함\r\nT: 팀내 공개\r\nD: 부서 공개',
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
INSERT INTO `task` VALUES ('23288658-57f9-4ed6-b34c-97500bb6a788','andrew@chosun.com','yuzibosu@chosun.com','2017-03-24 09:00:00','F','M',100,100,'D','bpms 테스트','테스트 진행','2017-03-15 11:18:22'),('599b9a05-29ce-47b6-8d7d-ba45e7daff35','andrew@chosun.com','shlee@chosun.com','2017-03-31 09:00:00','L','M',100,60,'D','bpms 결재 테스트','결재 테스트 진행\n반려, 보류','2017-03-15 14:29:02'),('337fa502-fd89-454e-bacd-0c53c694a639','andrew@chosun.com','yds0903@chosun.com','2017-03-17 14:35:40','L','M',100,0,'D','작업 테스트','작업 등록, 목록, 진척률, 위임, 반려, 취소 테스트','2017-03-15 14:36:54'),('6dd8c0d9-2410-4319-9096-2f1d6b091391','andrew@chosun.com','andrew@chosun.com','2017-03-27 09:00:00','F','M',100,100,'N','본인 일정 등록','내 작업 등록 테스트','2017-03-27 12:27:28'),('505d41f2-0a1a-481e-89e7-78d49d918e49','yuzibosu@chosun.com','shlee@chosun.com','2017-04-07 13:42:34','L','M',100,0,'T','작업 테스트','테스트입니다.','2017-03-31 13:42:59'),('c02a9d5a-846f-4975-9edb-2f65de50736b','andrew@chosun.com','shlee@chosun.com','2017-05-05 09:00:00','C','L',22,0,'N','작업 메시지 테스트','작업 생성 후 메시지 생성 테스트','2017-04-27 16:50:15'),('e489700f-e8ba-4188-a3a4-7ace6f785967','andrew@chosun.com','shlee@chosun.com','2017-05-05 09:00:00','C','L',22,0,'N','작업 메시지 테스트','작업 생성 후 메시지 생성 테스트','2017-04-27 16:51:15'),('947c5a5f-f1da-48b0-8d4e-062ffc2c6509','andrew@chosun.com','shlee@chosun.com','2017-04-27 16:59:36','L','L',100,0,'N','작업 등록 메시지','메시지 생성 테스트','2017-04-27 17:02:47'),('4fd4905f-4918-402c-9ad9-4ba7c8733781','andrew@chosun.com','yds0903@chosun.com','2017-05-05 18:01:59','L','L',22,0,'N','작업 메시지 테스트','작업 등록 메시지 확인','2017-04-27 18:02:29');
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
INSERT INTO `task_history` VALUES ('c079fca9-e873-47df-8ca4-e766870798b5','23288658-57f9-4ed6-b34c-97500bb6a788','','2017-03-15 11:18:22','andrew@chosun.com','yuzibosu@chosun.com',0,'신규 작업 생성'),('c570b1f4-5a47-4b40-a68e-1e06937f23f4','23288658-57f9-4ed6-b34c-97500bb6a788','','2017-03-15 11:28:35','andrew@chosun.com','yuzibosu@chosun.com',0,'재전송'),('74b45e38-aefe-4a6a-ba55-bed483c6cec7','599b9a05-29ce-47b6-8d7d-ba45e7daff35','','2017-03-15 14:29:03','andrew@chosun.com','shlee@chosun.com',0,'신규 작업 생성'),('0003bba7-9c57-4c63-ad99-812c0f4958c8','337fa502-fd89-454e-bacd-0c53c694a639','','2017-03-15 14:36:54','andrew@chosun.com','yds0903@chosun.com',0,'신규 작업 생성'),('9c18eb6f-26f7-4543-aed3-1a086cfa8936','599b9a05-29ce-47b6-8d7d-ba45e7daff35','','2017-03-24 16:13:30','shlee@chosun.com','shlee@chosun.com',60,'진척율 변경, 진척율 변경 [60%]'),('cff6fe32-62d9-4c35-ba66-5ff563c83fbb','23288658-57f9-4ed6-b34c-97500bb6a788','','2017-03-24 16:20:35','yuzibosu@chosun.com','yuzibosu@chosun.com',100,'진척율 변경, 진척율 변경 [100%]'),('615028a5-fc92-40e6-b80d-02c67d099f77','6dd8c0d9-2410-4319-9096-2f1d6b091391','','2017-03-27 12:27:28','andrew@chosun.com','andrew@chosun.com',0,'신규 작업 생성'),('cf7780dd-8e9c-4ed5-a911-34e305e00bdc','6dd8c0d9-2410-4319-9096-2f1d6b091391','','2017-03-27 12:39:32','andrew@chosun.com','andrew@chosun.com',0,'재전송'),('71e091ca-8233-474d-ac81-e97ea6eed7b6','6dd8c0d9-2410-4319-9096-2f1d6b091391','','2017-03-27 13:21:39','andrew@chosun.com','andrew@chosun.com',10,'진척율 변경, 진척율 변경 [10%]'),('45265975-fdaa-405d-a79c-4013fbdebe59','6dd8c0d9-2410-4319-9096-2f1d6b091391','','2017-03-27 13:32:29','andrew@chosun.com','andrew@chosun.com',20,'진척율 변경 [20%]'),('de0ee285-3d07-4b42-8293-3133f8309501','6dd8c0d9-2410-4319-9096-2f1d6b091391','','2017-03-27 13:32:29','andrew@chosun.com','andrew@chosun.com',30,'진척율 변경 [30%]'),('924899bc-20ff-47e7-907d-11029cd83c01','6dd8c0d9-2410-4319-9096-2f1d6b091391','','2017-03-27 13:32:30','andrew@chosun.com','andrew@chosun.com',40,'진척율 변경 [40%]'),('cc137574-aa00-4823-bc5b-9e3f60b26b99','6dd8c0d9-2410-4319-9096-2f1d6b091391','','2017-03-27 13:32:30','andrew@chosun.com','andrew@chosun.com',50,'진척율 변경 [50%]'),('55cb3fa3-a320-4707-a22a-ffbfc9c620a8','6dd8c0d9-2410-4319-9096-2f1d6b091391','','2017-03-27 13:32:32','andrew@chosun.com','andrew@chosun.com',60,'진척율 변경 [60%]'),('298f7e6b-990a-4e4d-a7ba-df3463354020','6dd8c0d9-2410-4319-9096-2f1d6b091391','','2017-03-27 13:32:43','andrew@chosun.com','andrew@chosun.com',60,''),('839bb33f-b542-46f4-b156-14f9a99d4049','6dd8c0d9-2410-4319-9096-2f1d6b091391','','2017-03-31 10:51:01','andrew@chosun.com','andrew@chosun.com',90,'진척율 변경 [90%]'),('91ccc278-6268-4d0c-9dc2-403bc48b8383','6dd8c0d9-2410-4319-9096-2f1d6b091391','','2017-03-31 10:51:01','andrew@chosun.com','andrew@chosun.com',70,'진척율 변경 [70%]'),('844480b4-ba40-4f3e-a7de-be276c90b15a','6dd8c0d9-2410-4319-9096-2f1d6b091391','','2017-03-31 10:51:01','andrew@chosun.com','andrew@chosun.com',80,'진척율 변경 [80%]'),('28880d18-4ee3-442c-a3ad-d5de47aab93f','6dd8c0d9-2410-4319-9096-2f1d6b091391','','2017-03-31 10:51:01','andrew@chosun.com','andrew@chosun.com',100,'진척율 변경 [100%]'),('207b0c51-e113-4008-a50c-efeb2ab5c5b1','505d41f2-0a1a-481e-89e7-78d49d918e49','','2017-03-31 13:42:59','yuzibosu@chosun.com','shlee@chosun.com',0,'신규 작업 생성'),('ff6e226e-607f-40b7-82cb-dfc8c2c36735','c02a9d5a-846f-4975-9edb-2f65de50736b','','2017-04-27 16:50:16','andrew@chosun.com','shlee@chosun.com',0,'�떊洹� �옉�뾽 �깮�꽦'),('57365a55-fa15-44c2-8571-7c69a52b93b8','e489700f-e8ba-4188-a3a4-7ace6f785967','','2017-04-27 16:51:15','andrew@chosun.com','shlee@chosun.com',0,'�떊洹� �옉�뾽 �깮�꽦'),('0e444811-8373-4f80-81aa-e79863987a17','c02a9d5a-846f-4975-9edb-2f65de50736b','정크데이터','2017-04-27 16:57:02','andrew@chosun.com','shlee@chosun.com',0,'작업 삭제'),('9b3480bf-f990-4149-8675-38a0303f253a','e489700f-e8ba-4188-a3a4-7ace6f785967','테스트 에러','2017-04-27 16:57:18','andrew@chosun.com','shlee@chosun.com',0,'작업 삭제'),('ff466c66-b858-436c-8cfe-fd7b2e3a4515','947c5a5f-f1da-48b0-8d4e-062ffc2c6509','','2017-04-27 17:02:47','andrew@chosun.com','shlee@chosun.com',0,'신규 작업 생성'),('e1ce5c35-bba6-4282-9cc3-d34d86184efc','4fd4905f-4918-402c-9ad9-4ba7c8733781','','2017-04-27 18:02:29','andrew@chosun.com','yds0903@chosun.com',0,'신규 작업 생성');
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
INSERT INTO `user_authority` VALUES ('andrew@chosun.com','45338ea5-aaea-11e6-8cda-d067e51fd414'),('andrew@chosun.com','45338ea5-aaea-11e6-8cda-d067e51fd415'),('andrew@chosun.com','45338ea5-aaea-11e6-8cda-d067e51fd416'),('andrew@chosun.com','45338ea5-aaea-11e6-8cda-d067e51fd419'),('yongkum@chosun.com','45338ea5-aaea-11e6-8cda-d067e51fd414'),('goindol@chosun.com','45338ea5-aaea-11e6-8cda-d067e51fd414'),('goindol@chosun.com','45338ea5-aaea-11e6-8cda-d067e51fd417'),('goindol@chosun.com','45338ea5-aaea-11e6-8cda-d067e51fd419'),('rainy@chosun.com','45338ea5-aaea-11e6-8cda-d067e51fd414'),('myungwons@chosun.com','45338ea5-aaea-11e6-8cda-d067e51fd414'),('yuzibosu@chosun.com','45338ea5-aaea-11e6-8cda-d067e51fd414'),('yuzibosu@chosun.com','45338ea5-aaea-11e6-8cda-d067e51fd417'),('shlee@chosun.com','45338ea5-aaea-11e6-8cda-d067e51fd414'),('yds0903@chosun.com','45338ea5-aaea-11e6-8cda-d067e51fd414'),('yunju@chosun.com','45338ea5-aaea-11e6-8cda-d067e51fd414'),('yunju@chosun.com','45338ea5-aaea-11e6-8cda-d067e51fd419'),('bigfoot@chosun.com','45338ea5-aaea-11e6-8cda-d067e51fd414'),('bigfoot@chosun.com','45338ea5-aaea-11e6-8cda-d067e51fd419'),('chan@chosun.com','45338ea5-aaea-11e6-8cda-d067e51fd414'),('kds@chosun.com','45338ea5-aaea-11e6-8cda-d067e51fd414'),('dylee@chosun.com','45338ea5-aaea-11e6-8cda-d067e51fd414'),('hmokim@chosun.com','45338ea5-aaea-11e6-8cda-d067e51fd414'),('bhkim@chosun.com','45338ea5-aaea-11e6-8cda-d067e51fd414'),('cst01@chosun.com','45338ea5-aaea-11e6-8cda-d067e51fd414'),('stlee@chosun.com','45338ea5-aaea-11e6-8cda-d067e51fd414'),('nrson84@chosun.com','45338ea5-aaea-11e6-8cda-d067e51fd414'),('ctaey87@chosun.com','45338ea5-aaea-11e6-8cda-d067e51fd414'),('flowersun@chosun.com','45338ea5-aaea-11e6-8cda-d067e51fd414');
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
INSERT INTO `user_dept_position` VALUES ('yongkum@chosun.com','0a3849ba-c180-47e7-8118-a037d6f3c4ba','cb37711b-aaec-11e6-8cda-d067e51fd421'),('goindol@chosun.com','9c247a2d-77b1-457a-ba9b-43c972125ab6','cb37711b-aaec-11e6-8cda-d067e51fd421'),('goindol@chosun.com','0a3849ba-c180-47e7-8118-a037d6f3c4ba','cb37711b-aaec-11e6-8cda-d067e51fd428'),('rainy@chosun.com','0a3849ba-c180-47e7-8118-a037d6f3c4ba','cb37711b-aaec-11e6-8cda-d067e51fd419'),('myungwons@chosun.com','0a3849ba-c180-47e7-8118-a037d6f3c4ba','cb37711b-aaec-11e6-8cda-d067e51fd416'),('yuzibosu@chosun.com','361a569f-34c3-4520-baf7-f0d32abae6a0','cb37711b-aaec-11e6-8cda-d067e51fd428'),('shlee@chosun.com','361a569f-34c3-4520-baf7-f0d32abae6a0','cb37711b-aaec-11e6-8cda-d067e51fd419'),('yds0903@chosun.com','361a569f-34c3-4520-baf7-f0d32abae6a0','cb37711b-aaec-11e6-8cda-d067e51fd415'),('andrew@chosun.com','d35c8fa9-7fe9-4820-accb-5dfa26b56689','cb37711b-aaec-11e6-8cda-d067e51fd429'),('yunju@chosun.com','aaaadfdfd','cb37711b-aaec-11e6-8cda-d067e51fd431'),('yunju@chosun.com','aaaadfdfd','cb37711b-aaec-11e6-8cda-d067e51fd425'),('bigfoot@chosun.com','36000a74-9c12-4061-9cce-86642f18a09b','cb37711b-aaec-11e6-8cda-d067e51fd432'),('bigfoot@chosun.com','b7bceead-35f2-465c-8b0d-e3819b1d622f','cb37711b-aaec-11e6-8cda-d067e51fd429'),('bigfoot@chosun.com','36000a74-9c12-4061-9cce-86642f18a09b','cb37711b-aaec-11e6-8cda-d067e51fd425'),('chan@chosun.com','digital_chosunilbo','1e2032f2-deba-49ed-82de-a70fd241734b'),('chan@chosun.com','digital_chosunilbo','3cd235ac-5390-4b6c-8db1-7299bea560d1'),('kds@chosun.com','442fc8e1-9447-4e60-aed3-ea3eb73396c8','cb37711b-aaec-11e6-8cda-d067e51fd428'),('kds@chosun.com','442fc8e1-9447-4e60-aed3-ea3eb73396c8','cb37711b-aaec-11e6-8cda-d067e51fd420'),('dylee@chosun.com','442fc8e1-9447-4e60-aed3-ea3eb73396c8','cb37711b-aaec-11e6-8cda-d067e51fd418'),('hmokim@chosun.com','fe9b93be-b688-49e3-8c36-b5b3616580f3','cb37711b-aaec-11e6-8cda-d067e51fd429'),('hmokim@chosun.com','fe9b93be-b688-49e3-8c36-b5b3616580f3','cb37711b-aaec-11e6-8cda-d067e51fd424'),('bhkim@chosun.com','25332011-bf0c-46f5-9e7b-4f4a1e13cdee','cb37711b-aaec-11e6-8cda-d067e51fd430'),('bhkim@chosun.com','digital_chosunilbo','a93e6af1-a18f-4ba8-8901-5e3f1bfd60ce'),('cst01@chosun.com','1939ef1e-b45b-4427-8473-602f10189344','cb37711b-aaec-11e6-8cda-d067e51fd429'),('cst01@chosun.com','4dea7638-2eae-4e6d-865c-111bd6bf6769','cb37711b-aaec-11e6-8cda-d067e51fd428'),('stlee@chosun.com','4dea7638-2eae-4e6d-865c-111bd6bf6769','cb37711b-aaec-11e6-8cda-d067e51fd421'),('nrson84@chosun.com','361a569f-34c3-4520-baf7-f0d32abae6a0','cb37711b-aaec-11e6-8cda-d067e51fd415'),('ctaey87@chosun.com','361a569f-34c3-4520-baf7-f0d32abae6a0','cb37711b-aaec-11e6-8cda-d067e51fd414'),('flowersun@chosun.com','361a569f-34c3-4520-baf7-f0d32abae6a0','cb37711b-aaec-11e6-8cda-d067e51fd414');
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
INSERT INTO `users` VALUES ('andrew@chosun.com','현곤','김','$2a$10$lc0aRBOvSJaO5gNQHUfsJ.k1y983x6Mk9/hA2rh7dMJNt9KcoNKOK','Y'),('bigfoot@chosun.com','대범','편','1234','Y'),('chan@chosun.com','찬','김','$2a$10$b5EEKD3aXa2XsF08t5hfneaJe8HLYMIr1Wb1bOuLs/oHw9ySIFSjO','Y'),('goindol@chosun.com','웅찬','길','1234','Y'),('myungwons@chosun.com','명원','이','$2a$10$hoq6AEuVdODXFHljcfGstOicD3jSY1emzi7UtJpZDxk0Z2egIlN3i','Y'),('rainy@chosun.com','은영','조','$2a$10$jmmqJopx65IGIdHaLgx9HuTeJ45/OmcpOyNB7SMnyul86asPCwQqe','Y'),('shlee@chosun.com','상혁','이','$2a$10$keiybgdrlUVcDCBDGm8U4uPC05W78mupC7E9Tyh1iawIaGH71k3RG','Y'),('yds0903@chosun.com','동식','윤','$2a$10$miAnvnA/qoICzGAkD0h2iusrxFQzeBIfHcAWDnbbYBB8a6NNZJA0u','Y'),('yongkum@chosun.com','세원','김','$2a$10$B3SVyBeEPR/aInw4BR9breCFCiixOguqEhv/NKUSwvbxM.bV/WqxS','Y'),('yunju@chosun.com','윤주','안','1234','Y'),('yuzibosu@chosun.com','원기','배','$2a$10$b5EEKD3aXa2XsF08t5hfneaJe8HLYMIr1Wb1bOuLs/oHw9ySIFSjO','Y'),('kds@chosun.com','동수','김','$2a$10$aBqG94d8tcVqBSCv/SJsCuzgtY0Qq/jx7hfKbOaHwXHxHgA52Kdxa','Y'),('dylee@chosun.com','대용','이','$2a$10$7OfmmCr6RieVNR3.o9xOf.VeMl652lVydXrvMQgnYzJYN.DOdQ8da','Y'),('hmokim@chosun.com','형모','김','$2a$10$Ao.6yGoa0NmQnnaX5RPp0exZ9QqYuPtkdRvUjyBMQJekqiDGoeCVG','Y'),('bhkim@chosun.com','봉현','김','$2a$10$GnyIW3wwBa8yRZXHytMnj.JYPa/Yq0qv4EVb3XfU31Wzcme.RGRDG','Y'),('cst01@chosun.com','상우','이','1234','Y'),('stlee@chosun.com','상태','이','1234','Y'),('nrson84@chosun.com','나리','손','$2a$10$yWY6k5NlyEKGsm5HzH6wfOTgkK37v3nVjOEJPusb0hDojv.iXtlmC','Y'),('ctaey87@chosun.com','태영','최','$2a$10$HJB4pdo3DK0s9iurVbnpUOaWD57vxRJyWEuPBxLN1YWkp9Ao9d/IO','Y'),('flowersun@chosun.com','화혜','오','$2a$10$Du3rzPstlit2opczHYuaourhEybk22TCU9caF9eqhrHylMAmY0D7.','Y');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'dz_bpm'
--
/*!50003 DROP FUNCTION IF EXISTS `getChildDeptList` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`andrew`@`localhost` FUNCTION `getChildDeptList`() RETURNS varchar(128) CHARSET utf8
BEGIN
 DECLARE v_deptid varchar(128);
 DECLARE v_pid varchar(128);
 DECLARE v_seq int(10);
 DECLARE CONTINUE HANDLER FOR NOT FOUND SET @deptId = NULL;

 SET v_pid = @deptId;
 SET v_deptId = NULL;
 SET v_seq = 0;

 IF @deptId IS NULL THEN
  RETURN NULL;
 END IF;

 LOOP
  SELECT min(deptid)
 INTO @deptId
 FROM departments
 WHERE pid=v_pid AND useyn='Y'
 AND seq > v_seq;

  IF @deptId IS NOT NULL OR v_pid = @start_with THEN
   RETURN @deptId;
  END IF;

  SELECT
  deptId, pid, seq
  INTO v_deptId, v_pid, v_seq
  FROM departments
  WHERE deptId=v_pid;
 END LOOP;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `getChildList` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`andrew`@`localhost` FUNCTION `getChildList`() RETURNS varchar(128) CHARSET utf8
BEGIN
 DECLARE v_deptId varchar(128);
 DECLARE v_pid varchar(128);
 DECLARE CONTINUE HANDLER FOR NOT FOUND SET @deptId=NULL;

 SET v_pid = @deptId;
 SET v_deptId = null;

 IF @deptId IS NULL THEN
  RETURN NULL;
 END IF;

 LOOP
  SELECT min(deptId)
  INTO @deptId
  FROM departments
  WHERE pid = v_pid;

  IF @deptId IS NOT NULL OR v_pid = @start_with THEN
   RETURN @deptId;
  END IF;

  SELECT
  deptId, pid
  INTO v_deptId, v_pid
  FROM departments
  WHERE deptId=v_pid;
 END LOOP;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `getDepartmentCode` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`andrew`@`localhost` FUNCTION `getDepartmentCode`(`userId` VARCHAR(128)) RETURNS varchar(128) CHARSET utf8
BEGIN
	DECLARE v_deptId varchar(128);
	
	select
	u1.deptid
	INTO v_deptId
	from users u, user_dept_position u1
	where u.userid=userId and u.userid=u1.userid
	group by u.userid;
	
   RETURN v_deptId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `getUserName` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`andrew`@`localhost` FUNCTION `getUserName`(`userId` VARCHAR(128)) RETURNS varchar(128) CHARSET utf8
BEGIN
 DECLARE v_userName varchar(128);

 SELECT concat(u.lastName, u.firstName) 'userName'
 INTO v_userName
 FROM users u
 WHERE u.userId=userId;

   RETURN v_userName;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-04-28 14:12:09
