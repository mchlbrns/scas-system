/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19-11.8.5-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: dcms_db
-- ------------------------------------------------------
-- Server version	11.8.5-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*M!100616 SET @OLD_NOTE_VERBOSITY=@@NOTE_VERBOSITY, NOTE_VERBOSITY=0 */;

--
-- Table structure for table `analysts_analyst`
--

DROP TABLE IF EXISTS `analysts_analyst`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `analysts_analyst` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `analyst_name` varchar(100) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `email` varchar(254) DEFAULT NULL,
  `role` varchar(20) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  UNIQUE KEY `email` (`email`),
  CONSTRAINT `analysts_analyst_user_id_91680158_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=125 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `analysts_analyst`
--

LOCK TABLES `analysts_analyst` WRITE;
/*!40000 ALTER TABLE `analysts_analyst` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `analysts_analyst` VALUES
(5,'Jay-Ar Rojas',1,'2026-01-21 01:25:25.073019',7,NULL,'TEAM_LEADER','2026-01-22 01:22:07.769965'),
(7,'Riza Mae Aquino',1,'2026-01-21 03:39:49.339207',10,NULL,'ADMIN','2026-01-21 08:06:17.490349'),
(8,'Nilvic Rase',1,'2026-01-21 07:59:03.240187',11,NULL,'ADMIN','2026-01-21 07:59:03.240202'),
(9,'Daniella Bonifacio',1,'2026-01-21 07:59:35.325820',12,NULL,'ADMIN','2026-01-21 07:59:35.325837'),
(10,'Dave Joshua Ilagan',1,'2026-01-21 08:00:09.846887',13,NULL,'ADMIN','2026-01-21 08:00:29.283722'),
(11,'John Vincent Marcelo',1,'2026-01-21 08:01:15.543624',14,NULL,'ADMIN','2026-01-21 08:01:15.543651'),
(12,'Ma. Anthonette Catapang',1,'2026-01-21 08:02:22.464651',15,NULL,'ADMIN','2026-01-21 08:02:22.464667'),
(13,'Michael Laurence Actub',1,'2026-01-21 08:05:06.879103',16,NULL,'ADMIN','2026-01-21 08:05:06.879120'),
(14,'James Camacho',1,'2026-01-21 08:07:46.199509',17,NULL,'ADMIN','2026-01-21 08:07:46.199539'),
(23,'Aileen Santos',1,'2026-01-22 01:36:05.101321',26,NULL,'ANALYST','2026-01-22 01:36:05.101337'),
(24,'Jean Baluran',1,'2026-01-22 01:36:28.343696',27,NULL,'ANALYST','2026-01-22 01:36:28.343712'),
(25,'Jerald Villacorta',1,'2026-01-22 01:37:01.759219',28,NULL,'ANALYST','2026-01-22 01:37:01.759236'),
(26,'Jordan Yaon',1,'2026-01-22 01:41:15.181310',29,NULL,'ANALYST','2026-01-22 01:41:15.181334'),
(27,'Mark Joseph Namoro',1,'2026-01-22 01:41:37.764274',30,NULL,'ANALYST','2026-01-22 01:41:37.764291'),
(28,'Rei Joshua Sese',1,'2026-01-22 01:41:58.540190',31,NULL,'ANALYST','2026-01-22 01:41:58.540207'),
(29,'Rose Ann Dayo',1,'2026-01-22 01:42:15.395942',32,NULL,'ANALYST','2026-01-22 01:42:15.395964'),
(30,'Stephanie Diongson',1,'2026-01-22 01:42:35.214204',33,NULL,'ANALYST','2026-01-22 01:42:35.214224'),
(31,'Teresita Capa',1,'2026-01-22 01:42:51.133330',34,NULL,'ANALYST','2026-01-22 01:42:51.133343'),
(32,'John Lemuel Aragones',1,'2026-01-26 04:11:42.237999',35,NULL,'ANALYST','2026-01-26 04:11:42.238013'),
(34,'Rochelle Tesalona',1,'2026-01-26 04:28:10.230236',37,NULL,'ANALYST','2026-01-26 04:28:10.230256'),
(35,'Virgilio Jr. Mata',1,'2026-01-26 04:28:25.594563',38,NULL,'ANALYST','2026-01-26 04:28:25.594585'),
(36,'Marlon Cusi',1,'2026-01-26 04:28:40.345028',39,NULL,'ANALYST','2026-01-26 04:28:40.345046'),
(37,'Joel Ansing',1,'2026-01-26 04:28:51.952689',40,NULL,'ANALYST','2026-01-26 04:28:51.952706'),
(38,'Aoshii Miharu Mogol',1,'2026-01-26 04:29:05.227961',41,NULL,'ANALYST','2026-01-26 04:29:05.227983'),
(39,'John Mark Parilla',1,'2026-01-26 04:29:19.388744',42,NULL,'ANALYST','2026-01-26 04:29:19.388758'),
(40,'Edmund Galisanao Canasa',1,'2026-01-26 04:29:31.027718',43,NULL,'ANALYST','2026-01-26 04:29:31.027735'),
(41,'Bien Jefferson Silvino',1,'2026-01-26 04:29:41.496669',44,NULL,'ANALYST','2026-01-26 04:29:41.496680'),
(42,'Jane Padura',1,'2026-01-26 04:29:51.764205',45,NULL,'ANALYST','2026-01-26 04:29:51.764219'),
(43,'Dhannah Indong',1,'2026-01-26 04:30:01.198319',46,NULL,'ANALYST','2026-01-26 04:30:01.198335'),
(44,'John Maile Mabunga',1,'2026-01-26 04:30:12.298903',47,NULL,'ANALYST','2026-01-26 04:30:12.298917'),
(45,'Villarose Dorunio',1,'2026-01-26 04:30:24.649640',48,NULL,'ANALYST','2026-01-26 04:30:24.649654'),
(46,'Rozette Reyes',1,'2026-01-26 04:37:54.065902',49,NULL,'ANALYST','2026-01-26 04:38:10.552589'),
(47,'Criselda Fontillas',1,'2026-01-26 04:38:05.788097',50,NULL,'ANALYST','2026-01-26 04:38:05.788115'),
(48,'Jonathan Surbano',1,'2026-01-26 04:38:16.995734',51,NULL,'ANALYST','2026-01-26 04:39:20.632425'),
(49,'Kianne Ernest Vinculado',1,'2026-01-26 04:38:31.617510',52,NULL,'ANALYST','2026-01-26 04:38:31.617526'),
(50,'Ian Roy Aguilar',1,'2026-01-26 05:04:16.671575',53,NULL,'ANALYST','2026-01-26 05:48:03.635902'),
(51,'John Erick Nagrana',1,'2026-01-26 05:47:59.573548',54,NULL,'ANALYST','2026-01-26 05:48:13.787184'),
(52,'Amelia Gasilon',1,'2026-01-26 05:48:20.366263',55,NULL,'ANALYST','2026-01-26 05:48:20.366281'),
(53,'Diana Mae Datuin',1,'2026-01-26 05:48:31.899256',56,NULL,'ANALYST','2026-01-26 05:48:31.899271'),
(54,'Raquel Galvez Arnedo',1,'2026-01-26 05:48:38.635768',57,NULL,'ANALYST','2026-01-26 05:48:38.635780'),
(55,'Armando Ori??????a Jr.',1,'2026-01-26 05:48:52.051140',58,NULL,'ANALYST','2026-01-26 05:48:52.051154'),
(56,'Luningning Oya',1,'2026-01-26 05:49:12.176117',59,NULL,'ANALYST','2026-01-26 05:49:12.176129'),
(57,'Jholeen April Sanchez',1,'2026-01-26 05:49:22.405377',60,NULL,'ANALYST','2026-01-26 05:49:22.405392'),
(58,'Precious Maidy Dela Cruz',1,'2026-01-26 05:49:31.583852',61,NULL,'ANALYST','2026-01-26 05:49:31.583864'),
(59,'Abegail Sambat',1,'2026-01-26 05:49:40.097696',62,NULL,'ANALYST','2026-01-26 05:49:40.097712'),
(60,'Jayson Dela Cruz',1,'2026-01-26 05:49:47.025982',63,NULL,'ANALYST','2026-01-26 05:49:47.025994'),
(61,'Oliver Cabuyao',1,'2026-01-26 05:49:59.267663',64,NULL,'ANALYST','2026-01-26 05:49:59.267677'),
(62,'Christian John Celestra',1,'2026-01-28 02:57:38.425288',65,NULL,'ANALYST','2026-01-28 02:57:38.425303'),
(63,'Rafael Magnawa',1,'2026-01-28 03:02:30.989831',66,NULL,'ANALYST','2026-01-28 03:02:30.989845'),
(64,'Reinalyn Maliglig',1,'2026-01-28 03:02:46.145885',67,NULL,'ANALYST','2026-01-28 03:02:46.145899'),
(65,'Catrina Lucero',1,'2026-01-28 03:03:03.597054',68,NULL,'ANALYST','2026-01-28 03:03:03.597070'),
(66,'Milanie Jaco',1,'2026-01-28 03:03:18.250850',69,NULL,'ANALYST','2026-01-28 03:03:18.250866'),
(67,'Ceazar Bobadilla',1,'2026-01-28 03:03:36.090899',70,NULL,'ANALYST','2026-01-28 03:03:36.090913'),
(68,'Shaneal Roi Raichandani',1,'2026-01-28 03:03:55.425401',71,NULL,'ANALYST','2026-01-28 03:03:55.425419'),
(69,'Lorna Mendoza',1,'2026-01-28 03:04:07.361421',72,NULL,'ANALYST','2026-01-28 03:04:07.361434'),
(70,'Joerena Madera Abello',1,'2026-01-28 03:05:19.808974',73,NULL,'ANALYST','2026-01-28 03:05:19.808985'),
(71,'Gerald Villacorta',1,'2026-01-28 03:05:40.406320',74,NULL,'ANALYST','2026-01-28 03:05:40.406334'),
(72,'Marisa Francisco',1,'2026-01-28 03:09:49.412396',75,NULL,'ANALYST','2026-01-28 03:09:49.412416'),
(73,'Marife Prado',1,'2026-01-28 03:10:07.027663',76,NULL,'ANALYST','2026-01-28 03:10:07.027678'),
(74,'Arturo Jr. Roy',1,'2026-01-28 03:10:24.837305',77,NULL,'ANALYST','2026-01-28 03:10:24.837322'),
(75,'Surime Quintos',1,'2026-01-28 03:10:51.605549',78,NULL,'ANALYST','2026-01-28 03:10:51.605563'),
(76,'Mary Grace Dela Pe??????a',1,'2026-01-28 03:11:59.132577',79,NULL,'ANALYST','2026-01-28 03:11:59.132590'),
(77,'Trixia Mae Delito Tadeo',1,'2026-01-28 03:12:18.385701',80,NULL,'ANALYST','2026-01-28 03:12:18.385712'),
(78,'Susan Cabudil',1,'2026-01-28 03:12:26.984631',81,NULL,'ANALYST','2026-01-28 03:12:26.984647'),
(79,'Rica Ragas Jurada',1,'2026-01-28 03:12:32.938246',82,NULL,'ANALYST','2026-01-28 03:12:32.938263'),
(80,'Jessica Allo',1,'2026-01-28 03:12:42.283089',83,NULL,'ANALYST','2026-01-28 03:12:42.283102'),
(81,'Alesandra Sopia Ragasa',1,'2026-01-28 03:12:56.024968',84,NULL,'ANALYST','2026-01-28 03:12:56.024982'),
(82,'Regiina Celebrado',1,'2026-01-28 03:13:04.385490',85,NULL,'ANALYST','2026-01-28 03:13:19.632796'),
(83,'Roxanne Morados',1,'2026-01-28 03:13:29.927037',86,NULL,'ANALYST','2026-01-28 03:13:29.927050'),
(84,'Jholeen April Sanchez',1,'2026-01-28 03:13:38.639816',87,NULL,'ANALYST','2026-01-28 03:13:38.639830'),
(85,'Rowena Marados',1,'2026-01-28 03:13:58.471791',88,NULL,'ANALYST','2026-01-28 03:13:58.471807'),
(86,'Karen Satairapan',1,'2026-01-28 03:14:52.924338',89,NULL,'ANALYST','2026-01-28 03:14:52.924350'),
(87,'Modelyn Maerina',1,'2026-01-28 03:15:17.396073',90,NULL,'ANALYST','2026-01-28 03:15:17.396090'),
(88,'Lyka Silandron',1,'2026-01-28 03:15:28.588272',91,NULL,'ANALYST','2026-01-28 03:15:28.588287'),
(89,'R-Jay Abuan',1,'2026-01-28 03:15:37.422193',92,NULL,'ANALYST','2026-01-28 03:15:37.422215'),
(90,'Trinamay Bien',1,'2026-01-28 03:15:44.480211',93,NULL,'ANALYST','2026-01-28 03:15:44.480228'),
(91,'Cazel Ann Bolivar',1,'2026-01-28 03:15:50.697248',94,NULL,'ANALYST','2026-01-28 03:15:50.697261'),
(92,'Pearl Crystalline Pablo',1,'2026-01-28 03:15:58.710259',95,NULL,'ANALYST','2026-01-28 03:15:58.710272'),
(93,'Catherine Enriquez',1,'2026-01-28 03:16:05.842644',96,NULL,'ANALYST','2026-01-28 03:16:05.842658'),
(94,'Rizalyn Yucson',1,'2026-01-28 03:18:37.090413',97,NULL,'ANALYST','2026-01-28 03:18:37.090425'),
(95,'Tom Joshua Guzman',1,'2026-01-28 03:18:46.138938',98,NULL,'ANALYST','2026-01-28 03:18:46.138951'),
(96,'Vanessa Butlig',1,'2026-01-28 03:18:52.488679',99,NULL,'ANALYST','2026-01-28 03:18:52.488693'),
(97,'Ian Frank Fontillas',1,'2026-01-28 03:18:59.024537',100,NULL,'ANALYST','2026-01-28 03:18:59.024554'),
(98,'Vangelyn  De Castro',1,'2026-01-28 03:19:05.980242',101,NULL,'ANALYST','2026-01-28 03:19:05.980257'),
(99,'Christinr Michelle Olita',1,'2026-01-28 03:19:13.360998',102,NULL,'ANALYST','2026-01-28 03:19:13.361014'),
(100,'Randy Malalad',1,'2026-01-28 03:19:20.233352',103,NULL,'ANALYST','2026-01-28 03:19:20.233365'),
(101,'Ma. Cristina Ranjo',1,'2026-01-28 03:19:26.985647',104,NULL,'ANALYST','2026-01-28 03:19:26.985659'),
(102,'Naji Nesus',1,'2026-01-28 03:19:34.477624',105,NULL,'ANALYST','2026-01-28 03:19:34.477645'),
(103,'Jan Mica Salonga',1,'2026-01-28 03:19:52.000731',106,NULL,'ANALYST','2026-01-28 03:19:52.000743'),
(104,'Ryan Bernaldez',1,'2026-01-28 03:20:01.165151',107,NULL,'ANALYST','2026-01-28 03:20:01.165164'),
(105,'Jerry Banae',1,'2026-01-28 03:20:10.835472',108,NULL,'ANALYST','2026-01-28 03:20:10.835485'),
(106,'Jovelyn Sedol',1,'2026-01-28 03:20:19.969534',109,NULL,'ANALYST','2026-01-28 03:20:19.969547'),
(107,'Mark Darwin Tanael',1,'2026-01-28 03:20:26.567206',110,NULL,'ANALYST','2026-01-28 03:20:26.567217'),
(108,'Gary Grabato',1,'2026-01-28 03:20:33.592889',111,NULL,'ANALYST','2026-01-28 03:20:33.592903'),
(109,'Mark Ryan Moreno',1,'2026-01-28 03:20:40.355277',112,NULL,'ANALYST','2026-01-28 03:20:40.355291'),
(110,'Lorence Edward San Juan',1,'2026-01-28 03:20:47.181929',113,NULL,'ANALYST','2026-01-28 03:20:47.181949'),
(111,'Alyssa Mae Mationg',1,'2026-01-28 03:20:53.696761',114,NULL,'ANALYST','2026-01-28 03:20:53.696776'),
(112,'Bryan Bonte',1,'2026-01-28 03:21:03.438524',115,NULL,'ANALYST','2026-01-28 03:21:03.438543'),
(113,'Emily Casuga',1,'2026-01-28 03:21:10.122175',116,NULL,'ANALYST','2026-01-28 03:21:10.122190'),
(114,'Ma. Angeline Sison',1,'2026-01-28 03:21:17.315335',117,NULL,'ANALYST','2026-01-28 03:21:17.315351'),
(115,'Jean Mica Baguna',1,'2026-01-28 03:21:23.752666',118,NULL,'ANALYST','2026-01-28 03:21:23.752680'),
(116,'Riza Ternida',1,'2026-01-28 03:22:00.301034',119,NULL,'TEAM_LEADER','2026-01-28 03:22:07.931793'),
(117,'Brendon Andaya',1,'2026-01-28 03:22:25.830877',120,NULL,'TEAM_LEADER','2026-01-28 03:22:25.830891'),
(119,'Richard Bartolome',1,'2026-01-28 03:23:13.192598',122,NULL,'TEAM_LEADER','2026-01-28 03:23:13.192613'),
(121,'Nelisa Dela Trinidad',1,'2026-01-28 03:24:56.140246',124,NULL,'TEAM_LEADER','2026-01-28 03:24:56.140259'),
(122,'Jomil Jaco',1,'2026-01-28 03:25:43.050003',125,NULL,'TEAM_LEADER','2026-01-28 03:25:43.050018'),
(123,'Ronie Barsaga',1,'2026-01-28 03:26:09.709507',126,NULL,'TEAM_LEADER','2026-01-28 05:18:49.208445');
/*!40000 ALTER TABLE `analysts_analyst` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `analysts_analyst_clients`
--

DROP TABLE IF EXISTS `analysts_analyst_clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `analysts_analyst_clients` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `analyst_id` bigint(20) NOT NULL,
  `client_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `analysts_analyst_clients_analyst_id_client_id_5d12fc80_uniq` (`analyst_id`,`client_id`),
  KEY `analysts_analyst_clients_client_id_063b7414_fk_clients_client_id` (`client_id`),
  CONSTRAINT `analysts_analyst_cli_analyst_id_f059c1b3_fk_analysts_` FOREIGN KEY (`analyst_id`) REFERENCES `analysts_analyst` (`id`),
  CONSTRAINT `analysts_analyst_clients_client_id_063b7414_fk_clients_client_id` FOREIGN KEY (`client_id`) REFERENCES `clients_client` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=176 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `analysts_analyst_clients`
--

LOCK TABLES `analysts_analyst_clients` WRITE;
/*!40000 ALTER TABLE `analysts_analyst_clients` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `analysts_analyst_clients` VALUES
(28,5,11),
(29,5,12),
(32,5,13),
(31,5,14),
(3,7,11),
(4,7,12),
(17,7,13),
(5,7,14),
(7,8,15),
(6,8,16),
(8,9,9),
(9,9,10),
(10,10,6),
(11,11,8),
(12,12,2),
(13,12,3),
(14,12,4),
(15,12,5),
(16,13,7),
(18,14,17),
(33,23,11),
(34,24,11),
(35,25,11),
(36,26,11),
(37,27,11),
(38,28,11),
(39,29,11),
(40,30,11),
(41,31,11),
(42,32,17),
(44,34,17),
(45,35,17),
(46,36,17),
(47,37,17),
(48,38,17),
(49,39,17),
(50,40,17),
(51,41,17),
(52,42,17),
(53,43,17),
(54,44,17),
(55,45,17),
(56,46,15),
(57,47,15),
(58,48,15),
(60,48,16),
(59,49,15),
(61,50,9),
(64,50,10),
(62,51,9),
(63,51,10),
(65,52,9),
(66,52,10),
(67,53,9),
(68,53,10),
(69,54,9),
(70,54,10),
(71,55,9),
(72,55,10),
(73,56,9),
(74,56,10),
(75,57,9),
(76,57,10),
(77,58,9),
(78,58,10),
(79,59,9),
(80,59,10),
(81,60,9),
(82,60,10),
(83,61,9),
(84,61,10),
(85,62,7),
(86,63,7),
(87,64,7),
(88,65,7),
(89,66,7),
(90,67,7),
(91,68,7),
(92,69,7),
(93,70,11),
(94,71,11),
(95,72,14),
(96,73,14),
(97,74,14),
(98,75,7),
(99,76,6),
(100,77,6),
(101,78,6),
(102,79,6),
(103,80,6),
(104,81,6),
(105,82,6),
(106,83,6),
(107,84,6),
(108,85,6),
(109,86,2),
(110,86,3),
(111,86,4),
(112,86,5),
(113,87,2),
(114,87,3),
(115,87,4),
(116,87,5),
(117,88,2),
(118,88,3),
(119,88,4),
(120,88,5),
(121,89,2),
(122,89,3),
(123,89,4),
(124,89,5),
(125,90,2),
(126,90,3),
(127,90,4),
(128,90,5),
(129,91,2),
(130,91,3),
(131,91,4),
(132,91,5),
(133,92,2),
(134,92,3),
(135,92,4),
(136,92,5),
(137,93,2),
(138,93,3),
(139,93,4),
(140,93,5),
(141,94,8),
(142,95,8),
(143,96,8),
(144,97,8),
(145,98,8),
(146,99,8),
(147,100,8),
(148,101,8),
(149,102,8),
(150,103,8),
(151,104,8),
(152,105,8),
(153,106,8),
(154,107,8),
(155,108,8),
(156,109,8),
(157,110,8),
(158,111,8),
(159,112,8),
(160,113,8),
(161,114,8),
(162,115,8),
(163,116,2),
(164,116,3),
(165,116,4),
(166,116,5),
(167,117,8),
(169,119,7),
(171,121,15),
(172,122,9),
(173,122,10),
(174,123,8);
/*!40000 ALTER TABLE `analysts_analyst_clients` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `auth_permission` VALUES
(1,'Can add log entry',1,'add_logentry'),
(2,'Can change log entry',1,'change_logentry'),
(3,'Can delete log entry',1,'delete_logentry'),
(4,'Can view log entry',1,'view_logentry'),
(5,'Can add permission',2,'add_permission'),
(6,'Can change permission',2,'change_permission'),
(7,'Can delete permission',2,'delete_permission'),
(8,'Can view permission',2,'view_permission'),
(9,'Can add group',3,'add_group'),
(10,'Can change group',3,'change_group'),
(11,'Can delete group',3,'delete_group'),
(12,'Can view group',3,'view_group'),
(13,'Can add user',4,'add_user'),
(14,'Can change user',4,'change_user'),
(15,'Can delete user',4,'delete_user'),
(16,'Can view user',4,'view_user'),
(17,'Can add content type',5,'add_contenttype'),
(18,'Can change content type',5,'change_contenttype'),
(19,'Can delete content type',5,'delete_contenttype'),
(20,'Can view content type',5,'view_contenttype'),
(21,'Can add session',6,'add_session'),
(22,'Can change session',6,'change_session'),
(23,'Can delete session',6,'delete_session'),
(24,'Can view session',6,'view_session'),
(25,'Can add client',7,'add_client'),
(26,'Can change client',7,'change_client'),
(27,'Can delete client',7,'delete_client'),
(28,'Can view client',7,'view_client'),
(29,'Can add analyst',8,'add_analyst'),
(30,'Can change analyst',8,'change_analyst'),
(31,'Can delete analyst',8,'delete_analyst'),
(32,'Can view analyst',8,'view_analyst'),
(33,'Can add receivable',9,'add_receivable'),
(34,'Can change receivable',9,'change_receivable'),
(35,'Can delete receivable',9,'delete_receivable'),
(36,'Can view receivable',9,'view_receivable'),
(37,'Can add daily payment',10,'add_dailypayment'),
(38,'Can change daily payment',10,'change_dailypayment'),
(39,'Can delete daily payment',10,'delete_dailypayment'),
(40,'Can view daily payment',10,'view_dailypayment'),
(41,'Can add daily ptp',11,'add_dailyptp'),
(42,'Can change daily ptp',11,'change_dailyptp'),
(43,'Can delete daily ptp',11,'delete_dailyptp'),
(44,'Can view daily ptp',11,'view_dailyptp'),
(45,'Can add target',12,'add_target'),
(46,'Can change target',12,'change_target'),
(47,'Can delete target',12,'delete_target'),
(48,'Can view target',12,'view_target'),
(49,'Can add team',13,'add_team'),
(50,'Can change team',13,'change_team'),
(51,'Can delete team',13,'delete_team'),
(52,'Can view team',13,'view_team'),
(53,'Can add notification preference',14,'add_notificationpreference'),
(54,'Can change notification preference',14,'change_notificationpreference'),
(55,'Can delete notification preference',14,'delete_notificationpreference'),
(56,'Can view notification preference',14,'view_notificationpreference'),
(57,'Can add password re\nset request',15,'add_passwordresetrequest'),
(58,'Can change password re\nset request',15,'change_passwordresetrequest'),
(59,'Can delete password re\nset request',15,'delete_passwordresetrequest'),
(60,'Can view password re\nset request',15,'view_passwordresetrequest'),
(61,'Can add profile',16,'add_profile'),
(62,'Can change profile',16,'change_profile'),
(63,'Can delete profile',16,'delete_profile'),
(64,'Can view profile',16,'view_profile'),
(65,'Can add audit log',17,'add_auditlog'),
(66,'Can change audit log',17,'change_auditlog'),
(67,'Can delete audit log',17,'delete_auditlog'),
(68,'Can view audit log',17,'view_auditlog');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=128 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `auth_user` VALUES
(1,'pbkdf2_sha256$600000$7IypcwlUBijVdlvfWmCKEE$GZoMDoE1ADAf25kdfFPR+hpEWloreLc0ChvwJPK85lA=','2026-01-23 08:08:32.604706',1,'admin','','','',1,1,'2026-01-20 01:56:38.802695'),
(2,'pbkdf2_sha256$600000$aHHL0swVjMzPhHEUBJWmk9$cBDckinx2W9DzVMA46W1A3mojGwx7Z+Qd1yYtxRDS3I=',NULL,1,'verify_admin','','','verify@example.com',1,1,'2026-01-20 08:46:34.189682'),
(3,'pbkdf2_sha256$600000$gP42fvNFB5LE41Ps0u89SM$+YvnNCt80EQzu9Fd4DS0m3bMmtZ1Oynj6a+m9b/vdxU=',NULL,0,'testanalyst','Test','Analyst','testanalyst@example.com',0,1,'2026-01-20 08:52:50.920455'),
(4,'pbkdf2_sha256$600000$WFG6lPFilz4VpCfBaI8awn$6rKjUsLmY0JuGXm0onRyBHxKzoDCIdMQiqf3LfdXc3w=',NULL,0,'nashrojas','nash','rojas','',0,1,'2026-01-21 00:21:12.058031'),
(5,'pbkdf2_sha256$600000$Shq0IO5wrh1EFyg0DbMsPK$ayJnJT0ZWX391lbu24bs3F8zjGRW4dXhfXUhD91YXcs=',NULL,0,'nashrojas1','Nash','Rojas','',0,1,'2026-01-21 00:58:02.173581'),
(6,'pbkdf2_sha256$600000$9YPu06zfZ4GS0lumvosiSH$E2X4AJBVaHz3w7OOlYTCJ9y8Ck2HV3kw79f2M+iLk9U=',NULL,0,'michaelbriones','Michael','Briones','',0,1,'2026-01-21 00:58:13.222971'),
(7,'pbkdf2_sha256$600000$zIsaVjnA0RUju7KGuB2299$ds/8S6OAkI+iPOydxkNs5QvcC+NJvMQk1foAMyHAKXw=',NULL,0,'jay-arrojas','Jay-Ar','Rojas','',0,1,'2026-01-21 01:25:24.768075'),
(8,'pbkdf2_sha256$600000$YRGrztz8oDDO1ZBWpGzEa6$rNr0yDCJ0dan0VwWi2W65/TNcp3eCVDvtSOGUwbp/VE=',NULL,0,'test','test','','',0,1,'2026-01-21 03:14:53.781499'),
(9,'pbkdf2_sha256$600000$F8ghiViOUssMn77FeizXZe$VjGnCnV6YAHjLKlNXNNTE9BdShcxLYUkAU1qKsB77HI=',NULL,0,'testtest','test','test','',0,1,'2026-01-21 03:17:47.626312'),
(10,'pbkdf2_sha256$600000$KIfUlSi8mn4ZNm1gAZaohV$cVNCorHe0IcjXMhNvMHHw614kr6j2zxQ3M3+cVEcCR8=',NULL,0,'rizamaeaquino','Riza','Mae Aquino','',0,1,'2026-01-21 03:39:49.056540'),
(11,'pbkdf2_sha256$600000$WaN7qZ2KTtbyCQo3L5VqW3$PUtlZxmE/GBfp2Hs22vBNkg8IkQPd1yq4aRlmo3RfzI=',NULL,0,'nilvicrase','Nilvic','Rase','',0,1,'2026-01-21 07:59:02.975683'),
(12,'pbkdf2_sha256$600000$yiSVtBj6VBaSYJyctNhBoE$hRSyue/dWKxOVxs2c0spHigP2UTlq2yUq2PYtHxQvhk=',NULL,0,'daniellabonifacio','Daniella','Bonifacio','',0,1,'2026-01-21 07:59:35.025544'),
(13,'pbkdf2_sha256$600000$g7c8As5wwgZwc5F9igVohx$vLmtVW2D9fraPb+/ooqYBTodDlIqDKJOGW7g2YfKLk8=',NULL,0,'davejoshuailagan','DAVE','JOSHUA ILAGAN','',0,1,'2026-01-21 08:00:09.582124'),
(14,'pbkdf2_sha256$600000$9c3ppt5bsgwrvnAq1caWOA$GpO+6uFcsdWekMVacIRsj1zfTRFd65knGNvD2v7tVP8=',NULL,0,'johnvincentmarcelo','John','Vincent Marcelo','',0,1,'2026-01-21 08:01:15.272101'),
(15,'pbkdf2_sha256$600000$ZXQhJ7mIhl9ex4PukSLawZ$rhSuETlNMRqNPm9LqPTjQAe6u9rsXDrgqm0Jw5rg6Mg=',NULL,0,'ma.anthonettecatapang','Ma.','Anthonette Catapang','',0,1,'2026-01-21 08:02:22.148144'),
(16,'pbkdf2_sha256$600000$YJhdnGbl71gW7XphGVQGyc$7V3v2mh/vrqHIzF2Qj8ZpV5nX5suorsVjNoS6m60AAE=',NULL,0,'michaellaurenceactub','Michael','Laurence Actub','',0,1,'2026-01-21 08:05:06.606212'),
(17,'pbkdf2_sha256$600000$jf7IoBM6Iff6oerhfPOPfh$snRsjPf5nPq5ZJleG6cK2mT0oM6Pw1hJNEMWYUVYoOs=',NULL,0,'jamescamacho','James','Camacho','',0,1,'2026-01-21 08:07:45.937388'),
(18,'pbkdf2_sha256$600000$oy0MXojqwYkYtERAIzEs17$xlhO2HTKnPHHsJM1KhaiDzKJJcwQuv/RKfpf5jp+hgs=',NULL,0,'arahbuenaventura','Arah','Buenaventura','',0,1,'2026-01-21 08:19:30.379132'),
(19,'pbkdf2_sha256$600000$eATxgTf0GzorlSLmNTCV7E$DS72ERosTLBFbqJpcKQla4wKvayxKR2vnJ3ft2F/eq0=',NULL,0,'test1','test','','',0,1,'2026-01-21 08:19:45.636785'),
(20,'pbkdf2_sha256$600000$W5Dn7eAMuSbDFXyOtwNEUM$HD23uVSiKgtwPSQZoixcQqiiXRHvKdDwydzhj4JLHMI=',NULL,0,'test2','test','','',0,1,'2026-01-21 08:27:25.620252'),
(21,'pbkdf2_sha256$600000$8hKUXJUjq7tp7MHNvVKMDh$UHbGSVN1I+VmZ+q38xDRaaFY91OWglzj0lTEXiOibiQ=',NULL,0,'arahbuenaventura1','Arah','Buenaventura','',0,1,'2026-01-21 08:28:40.111301'),
(22,'pbkdf2_sha256$600000$XLuYvwAgKhxPOQvs9byA7h$TXD1cQMLAGcY+MJ2sIRUj6L4BvgcJ/+1zzyJa3fFQ3o=',NULL,0,'test3','test','','',0,1,'2026-01-21 08:28:45.605668'),
(23,'pbkdf2_sha256$600000$HRBYlFuXbB4027mft1AdRf$vhvuWezAkKSn53JamE2ZBU351KtGbPf67GwcsbH4wTo=',NULL,0,'kelvinduya','Kelvin','Duya','',0,1,'2026-01-21 08:29:54.263332'),
(24,'pbkdf2_sha256$600000$dhpdo8AfFTZbtXMcBUThuP$pFYtX4GWCPoaRui7DlFjhnFo6DTqxBrri5NvqVvgLfc=',NULL,0,'test4','test','','',0,1,'2026-01-21 09:05:19.372413'),
(25,'pbkdf2_sha256$600000$eFywaR3SL1mcdRwScjOoqE$F3hs8jl7v6k+Uii1CQ7WJrU1BhdBXUMd5hGHXw5fH4Y=',NULL,0,'ternida','TERNIDA','','',0,1,'2026-01-21 09:06:33.645017'),
(26,'pbkdf2_sha256$600000$RGIv8RsBJ6lyF4alRFJLOZ$gyAAJmXAvJslvFc2CLcyCZCGJpOamG6tfSUXFercx54=',NULL,0,'aileensantos','Aileen','Santos','',0,1,'2026-01-22 01:36:04.822216'),
(27,'pbkdf2_sha256$600000$sODrPJ6IMXqgPeopcR8aZ3$djJ1h3NYfEOnxHadAOZ7tm4fkzaU9kZFSzN6qOMYM/8=',NULL,0,'jeanbaluran','Jean','Baluran','',0,1,'2026-01-22 01:36:28.061062'),
(28,'pbkdf2_sha256$600000$oeUbw22bGSmUSyZeX0Rtez$b4HTJL6Of8Ed2m1+3DxrMUVx4BSHa3jHCZLbJ08g9D8=',NULL,0,'jeraldvillacorta','Jerald','Villacorta','',0,1,'2026-01-22 01:37:01.477260'),
(29,'pbkdf2_sha256$600000$TZEjxIuKziiMMRhGI5eBad$1F7NA6lywHlOshkxXUdFyWWNDrTJAxzebq5NzSXUvsQ=',NULL,0,'jordanyaon','Jordan','Yaon','',0,1,'2026-01-22 01:41:14.899857'),
(30,'pbkdf2_sha256$600000$WgXXRbFF0TIeB0UDdKi2Vr$eVRnYYNIZh6l2MvY5tp6BDFwx+2NVnzDLn2U3WVfjZE=',NULL,0,'markjosephnamoro','Mark','Joseph Namoro','',0,1,'2026-01-22 01:41:37.450781'),
(31,'pbkdf2_sha256$600000$jxmd3d1s88zjd2JnCUrGx8$YuxPtdNRF/fHHvrsYaP8Pha3/TVFwlSmgdeyz+C7dxg=',NULL,0,'reijoshuasese','Rei','Joshua Sese','',0,1,'2026-01-22 01:41:58.228496'),
(32,'pbkdf2_sha256$600000$cdDL0D9HD6juMRiw322zlg$Lur6og98FyAPVYkUGUzNImD7lXOSOOiOmc+/P1I09zs=',NULL,0,'roseanndayo','Rose','Ann Dayo','',0,1,'2026-01-22 01:42:15.077090'),
(33,'pbkdf2_sha256$600000$4NTwpFJfsU7HN5SyfyA8Qw$TUM0lGYGuLUkS6FXMFL5D9DOLOCKmt6xXlSIoLnGesE=',NULL,0,'stephaniediongson','Stephanie','Diongson','',0,1,'2026-01-22 01:42:34.775768'),
(34,'pbkdf2_sha256$600000$1RgVlvJkcFWLS23wbsd1BA$/eNyI/3e7ZaZUYhBt/c6aaatUfU8caC6uzjrU2157E4=',NULL,0,'teresitacapa','Teresita','Capa','',0,1,'2026-01-22 01:42:50.845013'),
(35,'pbkdf2_sha256$600000$nBpj8GWSDn2OYobG0Bc5ti$5i/akBcMtOAdDoiRembKnT1s9yqynQ/UzjoDV9/9guU=',NULL,0,'johnlemuelaragones','John','Lemuel Aragones','',0,1,'2026-01-26 04:11:41.980527'),
(36,'pbkdf2_sha256$600000$w6mWViZSKnU9aF1KHKgY84$Os2mD3+WWzAQ/CtY1a3wMSt9h3yWSufBJK3ZRyBXw+Q=',NULL,0,'rochellesotomayortesalona','ROCHELLE','SOTOMAYOR TESALONA','',0,1,'2026-01-26 04:14:09.959577'),
(37,'pbkdf2_sha256$600000$MSFDx4trhYmTNW04XM1LE9$rR3fxjnWozjXo57GFOpRBP9C9oCGaXPGxp3OkNeR+o8=',NULL,0,'rochelletesalona','Rochelle','Tesalona','',0,1,'2026-01-26 04:28:09.831489'),
(38,'pbkdf2_sha256$600000$fIFdUU0Btj5oeOzuJUyxsP$xyCMdYmQHzeAD95udtBAx2bZLLERV1gzW3nib2KnCFE=',NULL,0,'virgiliojr.mata','Virgilio','Jr. Mata','',0,1,'2026-01-26 04:28:25.109659'),
(39,'pbkdf2_sha256$600000$hcEmtVjBZm2E6xTvywC5Mx$I/oUKCUDJrwLpTClOs1tcTgXaqGa5lVxMevlR3YgbkA=',NULL,0,'marloncusi','Marlon','Cusi','',0,1,'2026-01-26 04:28:39.869814'),
(40,'pbkdf2_sha256$600000$WL99FN3uRnrJCM1blR7ll9$hRCEK/0LPxKqlZAeTlDyLq+eCujo6LYnUXsWBzGtwsU=',NULL,0,'joelansing','Joel','Ansing','',0,1,'2026-01-26 04:28:51.511502'),
(41,'pbkdf2_sha256$600000$Wtz18Z0Gqd7mUkyWRRf3MY$wCTlhXddAvq8Vz8HD7O6fE4lyDu/dFbcSg4yws3+u1s=',NULL,0,'aoshiimiharumogol','Aoshii','Miharu Mogol','',0,1,'2026-01-26 04:29:04.749987'),
(42,'pbkdf2_sha256$600000$uVWZ3ukT7OVb8nvPddZ9tF$FjxwCXqx8iJF1t6K1z+dNGrpVqguFCd+kKT5t3/C2xk=',NULL,0,'johnmarkparilla','John','Mark Parilla','',0,1,'2026-01-26 04:29:19.124885'),
(43,'pbkdf2_sha256$600000$vgyYbT9bFcBeTBpJE7og5J$zcFiK7FdbOAp4aelIQvAWeqS34ppOV+9Q3fUgo4aLGM=',NULL,0,'edmundgalisanaocanasa','Edmund','Galisanao Canasa','',0,1,'2026-01-26 04:29:30.782991'),
(44,'pbkdf2_sha256$600000$2czqPVdqw8epoZT3f0DZFx$SjiVEi7aGYJO0n2TN/XvElNZCHboihsbIjneyfQFxNs=',NULL,0,'bienjeffersonsilvino','Bien','Jefferson Silvino','',0,1,'2026-01-26 04:29:41.254740'),
(45,'pbkdf2_sha256$600000$o47G7XExI1eGkC9b9pRCwM$bl2vuS8mja0V71sWdmXaidIzMuuWiu/e/Asb+nxUcH0=',NULL,0,'janepadura','Jane','Padura','',0,1,'2026-01-26 04:29:51.503080'),
(46,'pbkdf2_sha256$600000$COJE3WhXIKw0WpzoJ7dX8g$kdFZweJDvR6OOT8Yoq0YYpeUsvbpFF6F+v2c3dt1gfk=',NULL,0,'dhannahindong','Dhannah','Indong','',0,1,'2026-01-26 04:30:00.934896'),
(47,'pbkdf2_sha256$600000$RMsE8kyLFh4iWnOw0VntGP$nrkSH5pArlv9IOSAtwdCpy5yVGteU4KvJOKLC5203zs=',NULL,0,'johnmailemabunga','John','Maile Mabunga','',0,1,'2026-01-26 04:30:12.047597'),
(48,'pbkdf2_sha256$600000$AnFK8wdEPpIfn8jAw4hflo$OK1zdk//f931XwU2nnYwp3/jpOZvLUn1yOGfazV++80=',NULL,0,'villarosedorunio','Villarose','Dorunio','',0,1,'2026-01-26 04:30:24.375381'),
(49,'pbkdf2_sha256$600000$6gOYiPrPkkSyGXi3qAqdnp$5AKJ8WMhmQKRNgc9dEi8HajQK7pNY4WBxwaEwDSPVd0=',NULL,0,'rozetteolaesreyes','Rozette','Olaes Reyes','',0,1,'2026-01-26 04:37:53.805056'),
(50,'pbkdf2_sha256$600000$O9Nj3XM8eV0v6HQWnxrWzO$zbqib5/UC5wBhv0Yumu4ISGElLCjhuD/GS6n1EVf5Ic=',NULL,0,'criseldafontillas','Criselda','Fontillas','',0,1,'2026-01-26 04:38:05.494514'),
(51,'pbkdf2_sha256$600000$iGEn9pC5dNeMre1C3dBOhz$LLuymenvsonHxF5x/n7uA8cAuoz6UUuwypC3rt7nkN8=',NULL,0,'jonathanledonasurbano','Jonathan','Ledona Surbano','',0,1,'2026-01-26 04:38:16.715968'),
(52,'pbkdf2_sha256$600000$gRP3rLbKSlux0ve0ZnoqQH$ux+tRoVn+He/SO3GaJgE3KSYMPdrawuljGuJJ2cWmpk=',NULL,0,'kianneernestvinculado','Kianne','Ernest Vinculado','',0,1,'2026-01-26 04:38:31.324068'),
(53,'pbkdf2_sha256$600000$xHtORH5gCCZz9ep91Tk1mK$SuRnm6kf+ciPfkJtLNFEXffuzGwkJJzBTBFeow4aZKk=',NULL,0,'ianroyaguilar','Ian','Roy Aguilar','',0,1,'2026-01-26 05:04:16.393895'),
(54,'pbkdf2_sha256$600000$DF6wmgGdtrezYJfzgdmCUh$TlpSIHhAmBdCVDZDoeL48b1YK0kkJ/h4y/UOPUtmjbo=',NULL,0,'johnerickteodosionagrana','John','Erick Teodosio Nagrana','',0,1,'2026-01-26 05:47:59.315688'),
(55,'pbkdf2_sha256$600000$vYJ3MB8wUHZ3EXPvjBQtY5$rABRHycQU5iV83V1wgPv4rSscKH9lZggbsWTwSMlRQ8=',NULL,0,'ameliagasilon','Amelia','Gasilon','',0,1,'2026-01-26 05:48:20.119201'),
(56,'pbkdf2_sha256$600000$gQPboR8BeHRzP5ulE4vLja$ab3ljjxUaSNr4nN7BageKy4oMLzU0HeOERodVXRKpuk=',NULL,0,'dianamaedatuin','Diana','Mae Datuin','',0,1,'2026-01-26 05:48:31.647040'),
(57,'pbkdf2_sha256$600000$5LvW3cBovQddsBzSzUxFbH$Q0UlJljjpW4aH9IdoQIPHgMxy2gpRz4Fpgd+E+FG0vo=',NULL,0,'raquelgalvezarnedo','Raquel','Galvez Arnedo','',0,1,'2026-01-26 05:48:38.375800'),
(58,'pbkdf2_sha256$600000$bMO5nNEY1ICPGWqeBLv0gP$BeJibBbBYg9pqLlSIrmhqr+ekoCLFoXbXC9M8kNIS5w=',NULL,0,'armandoori??????ajr.','Armando','Ori??????a Jr.','',0,1,'2026-01-26 05:48:51.762428'),
(59,'pbkdf2_sha256$600000$Kj6ukOlmnPeNcob9xHSdsj$G3KwzqWmlB1uTMPr/h8kEJMvyNjjZHagTvRzJIfwGfk=',NULL,0,'luningningoya','Luningning','Oya','',0,1,'2026-01-26 05:49:11.927838'),
(60,'pbkdf2_sha256$600000$3aqrEInNMoB99Urw3QTTOb$vICQug9KpDqBuDk3bDeMlRQbmtkLQmaEc679AFmhRKE=',NULL,0,'jholeenaprilsanchez','Jholeen','April Sanchez','',0,1,'2026-01-26 05:49:22.137637'),
(61,'pbkdf2_sha256$600000$bTU0SimuSNeQvHAW9dtt0j$R+tpDIBpDZtnJVW7cV8Xg13eqyhvDRQoopzW/0wh8Uk=',NULL,0,'preciousmaidydelacruz','Precious','Maidy Dela Cruz','',0,1,'2026-01-26 05:49:31.336875'),
(62,'pbkdf2_sha256$600000$wkioHhHMhlQ4Z6rWLGwAnw$6JFpx1ttvtoXVy3J7Zr4PpGgP1kxVggXL3cM5SBNgcM=',NULL,0,'abegailsambat','Abegail','Sambat','',0,1,'2026-01-26 05:49:39.817000'),
(63,'pbkdf2_sha256$600000$O54F94sDRCQ8p9RdvhxKCp$G5pwxA8nuCptKovzdz6/2pSxUwk8D5hUJ1FXUX2ewGo=',NULL,0,'jaysondelacruz','Jayson','Dela Cruz','',0,1,'2026-01-26 05:49:46.776881'),
(64,'pbkdf2_sha256$600000$Xi19vDNmg4iQUUnvQUKg54$HmYrpdfnZ/e5Hl3yEc4w7o/duk5Gahat+6yEqp8CZaM=',NULL,0,'olivercabuyao','Oliver','Cabuyao','',0,1,'2026-01-26 05:49:59.017450'),
(65,'pbkdf2_sha256$600000$DSKzlrwPzsa9rVDdiW1Mkk$koCqzO6X3cg6CBwKu5FiMMKBW7aIFqV01xCSZQENxow=',NULL,0,'christianjohncelestra','Christian','John Celestra','',0,1,'2026-01-28 02:57:38.153890'),
(66,'pbkdf2_sha256$600000$cCZQOArJBf7fs6ZpqmjD1f$sBEmUrSEXjPjXJmlmyC0z8/U9N+QnwZ49OrwwXh6pPA=',NULL,0,'rafaelmagnawa','Rafael','Magnawa','',0,1,'2026-01-28 03:02:30.702324'),
(67,'pbkdf2_sha256$600000$GmlakcKtW4EZJBhtugjv0A$BkQXhDHKcA9rs5BO8q+qEeTCiAnp/c7YVzqwwJo37aA=',NULL,0,'reinalynmaliglig','Reinalyn','Maliglig','',0,1,'2026-01-28 03:02:45.870127'),
(68,'pbkdf2_sha256$600000$FkEOhfCYjz8OhRkwnUloeW$elvXb16m/akKkcBhfA3ASq058fBhDHa9xLywHa/WkYU=',NULL,0,'catrinalucero','Catrina','Lucero','',0,1,'2026-01-28 03:03:03.318360'),
(69,'pbkdf2_sha256$600000$kFXhDkuOmxXKMPmPdmkFNt$/epkdkAVY82D69vzhecW9HOkUOOIS5KC9fhatmS1Ma0=',NULL,0,'milaniejaco','Milanie','Jaco','',0,1,'2026-01-28 03:03:17.983732'),
(70,'pbkdf2_sha256$600000$YibWM93oyXSlZvqUKXtUTp$ODa5ggEHXRcQissL6jDLEQYm+wdn4aLDg+7QjHbvaeE=',NULL,0,'ceazarbobadilla','Ceazar','Bobadilla','',0,1,'2026-01-28 03:03:35.824745'),
(71,'pbkdf2_sha256$600000$76E0kQHFH9yAQbQnppqffd$gqOby7qucqGZkKTZLeAm32g2krpyRp02cK2Lsie3kUA=',NULL,0,'shanealroiraichandani','Shaneal','Roi Raichandani','',0,1,'2026-01-28 03:03:55.137764'),
(72,'pbkdf2_sha256$600000$h53nxK6KXO15alACLHjeHw$5ToUw1CSaCCahPXsyhPdi56vpX6GN13pa4Pf7dfEfk0=',NULL,0,'lornamendoza','Lorna','Mendoza','',0,1,'2026-01-28 03:04:07.081102'),
(73,'pbkdf2_sha256$600000$yKCrblxxFyPmMqlHkNuo8H$1X6F0MV4Q0Y+nJEEFpb8MlmVxUE5Sdr/WU4On+QVyEw=',NULL,0,'joerenamaderaabello','Joerena','Madera Abello','',0,1,'2026-01-28 03:05:19.508377'),
(74,'pbkdf2_sha256$600000$Shyw640X0nrvPo7KEahq4d$CtNCcPFr+77pmsUXEkNx8zxlu87InfVvNG1RCJ1ZFdk=',NULL,0,'geraldvillacorta','Gerald','Villacorta','',0,1,'2026-01-28 03:05:40.132360'),
(75,'pbkdf2_sha256$600000$D93f3zk7VvCgzzGztcUPIb$ZAy7Nb/3PboNnJUhRnilNZz1f9SmGFapAfjAhnygIB0=',NULL,0,'marisafrancisco','Marisa','Francisco','',0,1,'2026-01-28 03:09:49.147423'),
(76,'pbkdf2_sha256$600000$kv8wB1WBt971MnYT7Lr7iR$TEya97Y5R9wrAJAZ3nAHJhPMhOx/pHVRMw9wyIHyf1U=',NULL,0,'marifeprado','Marife','Prado','',0,1,'2026-01-28 03:10:06.769816'),
(77,'pbkdf2_sha256$600000$TLBWCbsdxZejXGSJyYLOEb$fZtZnnE4Hjs6msWOH1JNTR1O2Go2o5undRRTkNl2JKE=',NULL,0,'arturojr.roy','Arturo','Jr. Roy','',0,1,'2026-01-28 03:10:24.578027'),
(78,'pbkdf2_sha256$600000$DXXNOR3Se9HcJIgfMGESd4$Umx4hVTq5pRvrGa6a6q6K+FUy4Kk067vwAu8wm9FzKI=',NULL,0,'surimequintos','Surime','Quintos','',0,1,'2026-01-28 03:10:51.337285'),
(79,'pbkdf2_sha256$600000$3CSTvtJyjzZs53eDmriTFm$C1ArVrjxeXsi4mCU9paMtH4D13t4UW//ij6wfpzbccM=',NULL,0,'marygracedelape??????a','Mary','Grace Dela Pe??????a','',0,1,'2026-01-28 03:11:58.863486'),
(80,'pbkdf2_sha256$600000$QBytTdJwmblbt6mRI29XPA$FaH1hHSGa7+ToV24U17wltNUgmonDCMnjQW6umDAxjk=',NULL,0,'trixiamaedelitotadeo','Trixia','Mae Delito Tadeo','',0,1,'2026-01-28 03:12:18.125574'),
(81,'pbkdf2_sha256$600000$4iP35z8QnuZN4tTfcHftDX$LjYaf+WdF2tvN0KCi0sERQ0qyqIfzAvEBusmf1V1TIs=',NULL,0,'susancabudil','Susan','Cabudil','',0,1,'2026-01-28 03:12:26.725741'),
(82,'pbkdf2_sha256$600000$PwRI54B5cGvxHvazHi1oCI$GcTSOCobvCWi9q7255IDkFzIi5T/vUcgVtSJeJ5b84c=',NULL,0,'ricaragasjurada','Rica','Ragas Jurada','',0,1,'2026-01-28 03:12:32.496254'),
(83,'pbkdf2_sha256$600000$nq5exaRltQgYQTkXRuBTtM$mmzd+YNuhWtzXFWCCzAK/OuroCSuhE9dZFH5vnauU8I=',NULL,0,'jessicaallo','Jessica','Allo','',0,1,'2026-01-28 03:12:41.998008'),
(84,'pbkdf2_sha256$600000$Wxw7WP1OgDlTEOz3XJ0rki$pmJxJcP1kjW54fvp3/GzkhDZ1eDKpvFDDy4e4heNJys=',NULL,0,'alesandrasopiaragasa','Alesandra','Sopia Ragasa','',0,1,'2026-01-28 03:12:55.767006'),
(85,'pbkdf2_sha256$600000$EOxw0MMWkrbbuZW6qHKEAS$7hklsCXP89PjmOvumWLq9kezsE0vrZ8g8bMyd9/WmP0=',NULL,0,'regiinacelebrado','Regiina','Celebrado','',0,1,'2026-01-28 03:13:04.127083'),
(86,'pbkdf2_sha256$600000$ToLRDy9mgJZyFv6lzKZi9Z$mocPnmVt4iW+Kpo5gCbSTDg80XQhRjzBq1rM0ccNcrM=',NULL,0,'roxannemorados','Roxanne','Morados','',0,1,'2026-01-28 03:13:29.670865'),
(87,'pbkdf2_sha256$600000$evG7usbexT8ktNy68wCJOF$dnpj8nU9FiauIJdGX+glqRnmI/KfyqeZfagl68GVW3U=',NULL,0,'jholeenaprilsanchez1','Jholeen','April Sanchez','',0,1,'2026-01-28 03:13:38.383065'),
(88,'pbkdf2_sha256$600000$OyV1cxsEgudfMUVTSSkIMf$5JGSvY5zgOYPVHhFy4+bX4WTA1lOj6mj9ksC6RbOipc=',NULL,0,'rowenamarados','Rowena','Marados','',0,1,'2026-01-28 03:13:58.191039'),
(89,'pbkdf2_sha256$600000$Xlcy4bzcxp2XXvbS788jne$IedBN2Pj9Ylt6+DVENjCkazSba/8i0wXdzxQkmA8vHk=',NULL,0,'karensatairapan','Karen','Satairapan','',0,1,'2026-01-28 03:14:52.667596'),
(90,'pbkdf2_sha256$600000$Hbd2fAhAqzw8QjMbJRwPf7$a3h7G6WKHOkdPwVaSiPgpayyEJnuQ7IXXrOZD4ZJzLY=',NULL,0,'modelynmaerina','Modelyn','Maerina','',0,1,'2026-01-28 03:15:17.116223'),
(91,'pbkdf2_sha256$600000$oPHZsQFoyJ2lbxsjK9i0GE$7RzxdbE7dC3WF9U0CWKktCmUyhvcdspMFfRkBnbfFYs=',NULL,0,'lykasilandron','Lyka','Silandron','',0,1,'2026-01-28 03:15:28.259236'),
(92,'pbkdf2_sha256$600000$LzJSlN1OfIEzlS4r1aPn96$4Q4+rNTHY3jCRVmqb4ePSk5otigCnoAOtARLbBm9ulQ=',NULL,0,'r-jayabuan','R-Jay','Abuan','',0,1,'2026-01-28 03:15:37.163041'),
(93,'pbkdf2_sha256$600000$lkfMw6NtnOqLasZ6a9iT3W$CK9WBvBvhR1S2AtDwFUKupn+NaTrOMi2+3P28NW08sw=',NULL,0,'trinamaybien','Trinamay','Bien','',0,1,'2026-01-28 03:15:44.211857'),
(94,'pbkdf2_sha256$600000$nf91LmtY65x9v5EMGOlr0z$OfwBV1DUNK+/nH9smY10ChkjfI/j7LgeR6nARX8vTe0=',NULL,0,'cazelannbolivar','Cazel','Ann Bolivar','',0,1,'2026-01-28 03:15:50.442911'),
(95,'pbkdf2_sha256$600000$LMs5KFb1GaXbfJfWKMaYXd$XX1eY2Gm1PrjjyAYkNaAw6YtI4E9c+RLhyE5ZJbnFsw=',NULL,0,'pearlcrystallinepablo','Pearl','Crystalline Pablo','',0,1,'2026-01-28 03:15:58.459070'),
(96,'pbkdf2_sha256$600000$6TiO8EijOKRjzSlVkIEgsH$4vtarJmOkzQQzSwJz5B1FDYzoScUGcHAuWAKBczoZN8=',NULL,0,'catherineenriquez','Catherine','Enriquez','',0,1,'2026-01-28 03:16:05.587727'),
(97,'pbkdf2_sha256$600000$kuw378NibFEoxkHLDhxoGv$Mmsrr4m+Lk08BzEnPMWUGFwpsQB1bSU9b8hYy184nxM=',NULL,0,'rizalynyucson','Rizalyn','Yucson','',0,1,'2026-01-28 03:18:36.815933'),
(98,'pbkdf2_sha256$600000$KEYemjNLCYtL7rV0LBqBme$oDMzB9yRVbfI9YlaxSUO66mnvuQRhzyyO/L7WyRqvTg=',NULL,0,'tomjoshuaguzman','Tom','Joshua Guzman','',0,1,'2026-01-28 03:18:45.832261'),
(99,'pbkdf2_sha256$600000$m9SGf01tFP9ldjr1D4jMf6$3n1r8A1hiXD4wVQd9baR/CwJ9aurVjqEYZ9t1i2ehR8=',NULL,0,'vanessabutlig','Vanessa','Butlig','',0,1,'2026-01-28 03:18:52.215711'),
(100,'pbkdf2_sha256$600000$lVTPLjT2QJJ37OOfjAIVL9$NWq2wKcm/Zk6NOEgAAyZLoyeQ2Q5VorLWsfAEhp4TqY=',NULL,0,'ianfrankfontillas','Ian','Frank Fontillas','',0,1,'2026-01-28 03:18:58.751265'),
(101,'pbkdf2_sha256$600000$9IYCfWHWmtUoY1f5N5Tych$nA8xlSGfv6VyGlp04KSO1X1ja5qLP3FVoDK4d0S4P5I=',NULL,0,'vangelyndecastro','Vangelyn',' De Castro','',0,1,'2026-01-28 03:19:05.697781'),
(102,'pbkdf2_sha256$600000$aV1ylgcDQ9Gmc5tw2xg72J$MdqaQeCXUv0pX9ynAYuRAvkgmUtmfbp8aKKBtdJz6i4=',NULL,0,'christinrmichelleolita','Christinr','Michelle Olita','',0,1,'2026-01-28 03:19:13.088686'),
(103,'pbkdf2_sha256$600000$zAWe7y2mrh32C17ApMamHq$z2Gqe8cdn4NISktEIDnftIK8zna7eqCKBYhCOErWrqY=',NULL,0,'randymalalad','Randy','Malalad','',0,1,'2026-01-28 03:19:19.961573'),
(104,'pbkdf2_sha256$600000$MxroWmptIW0EI6VfoAXL6U$G7ndKlx4OyN4h7anF1ks12sEUjouShQPS0DUnCz0BYU=',NULL,0,'ma.cristinaranjo','Ma.','Cristina Ranjo','',0,1,'2026-01-28 03:19:26.713296'),
(105,'pbkdf2_sha256$600000$OqWctWp1HrW9MEjgL9EWqi$ra2dFETxILPyDYXYK6OJsrXje6ISF0hSFmYkat2qBNs=',NULL,0,'najinesus','Naji','Nesus','',0,1,'2026-01-28 03:19:34.200683'),
(106,'pbkdf2_sha256$600000$FoCML5peWKiON8wEQgS2p2$1T0JqoAemMeblxBjiDYEUUzQp7EKlCyTc/aSRWuVaAg=',NULL,0,'janmicasalonga','Jan','Mica Salonga','',0,1,'2026-01-28 03:19:51.729202'),
(107,'pbkdf2_sha256$600000$6QvWwGoD5CTfdIYc6fwMDq$tIFJ/IeQAAafEISTGJ/Z4hSJ6T3I9C9dnJ9SzKy+RoI=',NULL,0,'ryanbernaldez','Ryan','Bernaldez','',0,1,'2026-01-28 03:20:00.865792'),
(108,'pbkdf2_sha256$600000$5gMkhkA285hY5HpMhirrI1$siQePM6D+8gGlso48MSgvJq2yv7TOzHCslidNiQzEjs=',NULL,0,'jerrybanae','Jerry','Banae','',0,1,'2026-01-28 03:20:10.561441'),
(109,'pbkdf2_sha256$600000$lC3OLjIm7530VyBT9lkrLr$BIQHGbH1KZVJsL1VtKpIxtwlmHYKkiHaxq8bQbcPCcg=',NULL,0,'jovelynsedol','Jovelyn','Sedol','',0,1,'2026-01-28 03:20:19.691112'),
(110,'pbkdf2_sha256$600000$RiepNM3n87tRtTdXbHATpi$TbcgpW93+EDyShEI2rRbq3V5n5CqLhgpPkXHeikdAyo=',NULL,0,'markdarwintanael','Mark','Darwin Tanael','',0,1,'2026-01-28 03:20:26.290375'),
(111,'pbkdf2_sha256$600000$N5jQ36IPTu55bTi8mi3I0p$23V2pe0x7ZUGKizz6tOa434jy+n+Fc7Nnt5b2YsdqVg=',NULL,0,'garygrabato','Gary','Grabato','',0,1,'2026-01-28 03:20:33.315648'),
(112,'pbkdf2_sha256$600000$rDntN6qwu3pgbOHa7lzTEt$fcm+xHUDr+KqlxZqVnCrhINi1JSw9sRc+HXifmO4dFY=',NULL,0,'markryanmoreno','Mark','Ryan Moreno','',0,1,'2026-01-28 03:20:40.082658'),
(113,'pbkdf2_sha256$600000$6bwmBQiQzcuzX4qrzzsuQf$wAnPWg+MgnZ2aZ5/f1TMafW9ZjcC+bzIuE0wTlX+jG4=',NULL,0,'lorenceedwardsanjuan','Lorence','Edward San Juan','',0,1,'2026-01-28 03:20:46.900999'),
(114,'pbkdf2_sha256$600000$1a4cUMwiZ8FSgdU0diPnHt$QrEA/w714wQS2nqIdnexF3KAWrpq8r7fmzI0nB2EB7M=',NULL,0,'alyssamaemationg','Alyssa','Mae Mationg','',0,1,'2026-01-28 03:20:53.426982'),
(115,'pbkdf2_sha256$600000$u36UEZnM2lQwfzummrrVGD$w9ynr56ZJ4OHN5YAR3hVkjQFWHLZARFz1SGadbTKfDo=',NULL,0,'bryanbonte','Bryan','Bonte','',0,1,'2026-01-28 03:21:03.157432'),
(116,'pbkdf2_sha256$600000$KTduofimCtasAW02ispeuJ$2DqbHaPXPxLESfbZWeA389KqWprftEKdCQvc280Ho9s=',NULL,0,'emilycasuga','Emily','Casuga','',0,1,'2026-01-28 03:21:09.828009'),
(117,'pbkdf2_sha256$600000$HKzZOBLgjpE1Xr8s49yv3Y$pqk9rFTapD5AAepIIkbGOFuOt2PPH+4bVHOvwcZ05UU=',NULL,0,'ma.angelinesison','Ma.','Angeline Sison','',0,1,'2026-01-28 03:21:17.018971'),
(118,'pbkdf2_sha256$600000$NzdzzM5FkL5L8Fg3yoxGlL$ML7aCPUOa7UaDQ+A1tECT3nIdzomzg27lNwQnp9w8jM=',NULL,0,'jeanmicabaguna','Jean','Mica Baguna','',0,1,'2026-01-28 03:21:23.419364'),
(119,'pbkdf2_sha256$600000$2sQ0GjstNvIiYA30PPvi0Y$H7VYAyU+E5nfVfY6vgmWVKvDHJWOu6F1Z5ya0tMJ7Bo=',NULL,0,'rizagileternida','Riza','Gile Ternida','',0,1,'2026-01-28 03:22:00.019879'),
(120,'pbkdf2_sha256$600000$z9C0dlrrU1QVnUyMD5Mm0m$/gGS9MRjQd9IfBcrcRv7A6LD2v2YJCgqZRwx5WWVR2c=',NULL,0,'brendonandaya','Brendon','Andaya','',0,1,'2026-01-28 03:22:25.559531'),
(121,'pbkdf2_sha256$600000$VFHE0nrU7nR8o73Jhl2iYX$cSoJttSRJhJPiWNTjKMq4cvw1GzeU+lWSxUp9cXeKwY=',NULL,0,'richardbartolome','Richard','Bartolome','',0,1,'2026-01-28 03:22:42.773846'),
(122,'pbkdf2_sha256$600000$J20g261rQHTUcBTz7EMb7O$4oQMb1PtBx2xAJEHqce4QYV+uqEPUGtNHOAT+HTRDcU=',NULL,0,'richardbartolome1','Richard','Bartolome','',0,1,'2026-01-28 03:23:12.891888'),
(123,'pbkdf2_sha256$600000$7QE5XWbyAlJKZpQMfjHT6c$dJr2bqJAxAznpTb/RF8z54TXnoQ98udnLifmLbQD2c8=',NULL,0,'nelisadelatrinidad','Nelisa','Dela Trinidad','',0,1,'2026-01-28 03:23:27.033996'),
(124,'pbkdf2_sha256$600000$m6JaBeZgoau3WKkJLu1bQn$ZiZCVBk6hIlenBvi5zHmPktoDNpvmpvKuAqeroHz7nw=',NULL,0,'nelisadelatrinidad1','Nelisa','Dela Trinidad','',0,1,'2026-01-28 03:24:55.880266'),
(125,'pbkdf2_sha256$600000$DS3XUi5jDB87oFJrqekZp1$4xInFxrsXk5O0HZqVa8qVCvYkHWlSbJEiUWSDF1Sw4U=',NULL,0,'jomiljaco','Jomil','Jaco','',0,1,'2026-01-28 03:25:42.788199'),
(126,'pbkdf2_sha256$600000$rQCRXsr492ttncMpyHHU7j$SO2rGG0qBWEzFx1+fi+J39mfKK6QKKa9/bLsuJyecnI=',NULL,0,'roniebarsaga','Ronie','Barsaga','',0,1,'2026-01-28 03:26:09.420911'),
(127,'pbkdf2_sha256$600000$8z1y3PPgsZhlZ7KaqH50wX$6Fuea1PYz6XXPSlHnyWDQcQlon0kxmUd4Krx8eAfa1w=',NULL,0,'test5','Test','','',0,1,'2026-01-28 06:26:16.470272');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_groups` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `clients_client`
--

DROP TABLE IF EXISTS `clients_client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `clients_client` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `client_name` varchar(100) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `client_code` varchar(50) DEFAULT NULL,
  `contact_person` varchar(100) DEFAULT NULL,
  `email` varchar(254) DEFAULT NULL,
  `remarks` longtext DEFAULT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `client_code` (`client_code`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clients_client`
--

LOCK TABLES `clients_client` WRITE;
/*!40000 ALTER TABLE `clients_client` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `clients_client` VALUES
(2,'PLUG-IT',1,'2026-01-20 23:56:13.095907',NULL,NULL,NULL,NULL,'2026-01-20 23:56:13.096018'),
(3,'GSM',1,'2026-01-21 02:32:21.680298',NULL,NULL,NULL,NULL,'2026-01-21 02:32:21.680319'),
(4,'SUN',1,'2026-01-21 02:32:26.853472',NULL,NULL,NULL,NULL,'2026-01-21 02:32:26.853496'),
(5,'EARLY',1,'2026-01-21 02:32:35.222867',NULL,NULL,NULL,NULL,'2026-01-21 02:32:35.222889'),
(6,'SAVII',1,'2026-01-21 02:32:39.718303',NULL,NULL,NULL,NULL,'2026-01-21 02:32:39.718325'),
(7,'ESQUIRE',1,'2026-01-21 02:32:45.990621',NULL,NULL,NULL,NULL,'2026-01-21 02:32:45.990639'),
(8,'UB',1,'2026-01-21 02:32:52.047029',NULL,NULL,NULL,NULL,'2026-01-21 02:32:52.047047'),
(9,'ACOM WRITE OFF',1,'2026-01-21 02:32:57.181690',NULL,NULL,NULL,NULL,'2026-01-21 02:32:57.181708'),
(10,'ACOM OD',1,'2026-01-21 02:33:02.854661',NULL,NULL,NULL,NULL,'2026-01-21 02:33:02.854678'),
(11,'COLLECTIUS',1,'2026-01-21 02:33:09.462047',NULL,NULL,NULL,NULL,'2026-01-21 02:33:09.462067'),
(12,'LOANSTAR',1,'2026-01-21 02:33:14.118081',NULL,NULL,NULL,NULL,'2026-01-21 02:33:14.118098'),
(13,'BRIA',1,'2026-01-21 02:33:19.646083',NULL,NULL,NULL,NULL,'2026-01-21 02:33:19.646098'),
(14,'PSMBFI',1,'2026-01-21 02:33:26.583873',NULL,NULL,NULL,NULL,'2026-01-21 02:33:26.583895'),
(15,'VISTA HOUSING',1,'2026-01-21 02:33:32.424227',NULL,NULL,NULL,NULL,'2026-01-21 02:33:32.424243'),
(16,'FLEXI',1,'2026-01-21 02:33:36.991191',NULL,NULL,NULL,NULL,'2026-01-21 02:33:36.991209'),
(17,'PAG-IBIG',1,'2026-01-21 02:33:44.903841',NULL,NULL,NULL,NULL,'2026-01-21 02:33:44.903865');
/*!40000 ALTER TABLE `clients_client` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `core_auditlog`
--

DROP TABLE IF EXISTS `core_auditlog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_auditlog` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `action` varchar(50) NOT NULL,
  `target_model` varchar(100) NOT NULL,
  `object_id` varchar(100) DEFAULT NULL,
  `details` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`details`)),
  `ip_address` char(39) DEFAULT NULL,
  `timestamp` datetime(6) NOT NULL,
  `actor_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `core_auditlog_actor_id_ab091f3c_fk_auth_user_id` (`actor_id`),
  CONSTRAINT `core_auditlog_actor_id_ab091f3c_fk_auth_user_id` FOREIGN KEY (`actor_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_auditlog`
--

LOCK TABLES `core_auditlog` WRITE;
/*!40000 ALTER TABLE `core_auditlog` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `core_auditlog` VALUES
(31,'LOGIN','User','1','{\"message\": \"User logged in successfully\"}','192.168.0.62','2026-01-28 06:48:14.734712',1),
(32,'LOGIN','User','1','{\"message\": \"User logged in successfully\"}','192.168.0.62','2026-01-28 06:48:25.471408',1),
(33,'LOGIN','User','1','{\"message\": \"User logged in successfully\"}','192.168.0.62','2026-01-28 06:48:32.646516',1),
(34,'LOGIN','User','1','{\"message\": \"User logged in successfully\"}','192.168.0.62','2026-01-28 06:48:34.034929',1),
(35,'LOGIN','User','1','{\"message\": \"User logged in successfully\"}','192.168.0.62','2026-01-28 06:48:41.873022',1),
(36,'LOGIN','User','1','{\"message\": \"User logged in successfully\"}','192.168.0.62','2026-01-28 06:48:48.458302',1),
(37,'LOGIN','User','1','{\"message\": \"User logged in successfully\"}','192.168.0.62','2026-01-28 06:48:50.482774',1),
(38,'LOGIN','User','1','{\"message\": \"User logged in successfully\"}','192.168.0.62','2026-01-28 06:48:50.955803',1),
(39,'LOGIN','User','1','{\"message\": \"User logged in successfully\"}','192.168.0.62','2026-01-28 06:50:44.058668',1),
(40,'LOGIN','User','1','{\"message\": \"User logged in successfully\"}','192.168.0.62','2026-01-28 06:52:40.765397',1),
(41,'LOGIN','User','1','{\"message\": \"User logged in successfully\"}','192.168.0.62','2026-01-28 06:52:42.588345',1),
(42,'LOGIN','User','1','{\"message\": \"User logged in successfully\"}','192.168.0.62','2026-01-28 06:53:03.998190',1),
(43,'LOGIN','User','1','{\"message\": \"User logged in successfully\"}','192.168.0.62','2026-01-28 06:53:04.897534',1),
(44,'LOGIN','User','1','{\"message\": \"User logged in successfully\"}','192.168.0.62','2026-01-28 06:53:37.787749',1),
(45,'LOGIN','User','1','{\"message\": \"User logged in successfully\"}','192.168.0.62','2026-01-28 07:01:45.972583',1),
(46,'LOGIN','User','1','{\"message\": \"User logged in successfully\"}','192.168.0.62','2026-01-28 07:01:53.867597',1),
(47,'LOGIN','User','1','{\"message\": \"User logged in successfully\"}','192.168.0.62','2026-01-28 07:01:55.987873',1),
(48,'LOGIN','User','1','{\"message\": \"User logged in successfully\"}','192.168.0.62','2026-01-28 07:05:32.455501',1),
(49,'LOGIN','User','1','{\"message\": \"User logged in successfully\"}','192.168.0.62','2026-01-28 07:11:01.491695',1),
(50,'LOGIN','User','1','{\"message\": \"User logged in successfully\"}','192.168.0.62','2026-01-28 07:11:09.019427',1),
(51,'LOGIN','User','1','{\"message\": \"User logged in successfully\"}','192.168.0.62','2026-01-28 07:11:22.182545',1),
(52,'POST','Target',NULL,'{\"body\": {\"client\": 14, \"target_month\": \"2026-01-01\", \"internal_target\": 0, \"client_target\": 0}, \"status_code\": 201, \"path\": \"/api/v1/targets/\"}','192.168.0.62','2026-01-28 08:01:38.631908',10),
(53,'PATCH','Receivable','4','{\"body\": {\"client\": 14, \"analyst\": 7, \"report_date\": \"2026-01-01\", \"pos_account_count\": 0, \"pos_amount\": 0, \"neg_account_count\": 0, \"neg_amount\": 0}, \"status_code\": 200, \"path\": \"/api/v1/receivables/4/\"}','192.168.0.62','2026-01-28 08:01:38.632732',10),
(54,'PATCH','Receivable','6','{\"body\": {\"client\": 12, \"analyst\": 7, \"report_date\": \"2026-01-01\", \"pos_account_count\": 0, \"pos_amount\": 0, \"neg_account_count\": 0, \"neg_amount\": 0}, \"status_code\": 200, \"path\": \"/api/v1/receivables/6/\"}','192.168.0.62','2026-01-28 08:01:41.961445',10),
(55,'PATCH','Target','2','{\"body\": {\"client\": 12, \"target_month\": \"2026-01-01\", \"internal_target\": 0, \"client_target\": 0}, \"status_code\": 200, \"path\": \"/api/v1/targets/2/\"}','192.168.0.62','2026-01-28 08:01:41.964308',10),
(56,'PATCH','Target','1','{\"body\": {\"client\": 11, \"target_month\": \"2026-01-01\", \"internal_target\": 2500000, \"client_target\": 1500000}, \"status_code\": 200, \"path\": \"/api/v1/targets/1/\"}','192.168.0.62','2026-01-28 08:03:08.319576',10),
(57,'PATCH','Receivable','11','{\"body\": {\"client\": 11, \"analyst\": 7, \"report_date\": \"2026-01-01\", \"pos_account_count\": 1606, \"pos_amount\": 160302870.36, \"neg_account_count\": 11613, \"neg_amount\": 1017739000.34}, \"status_code\": 200, \"path\": \"/api/v1/receivables/11/\"}','192.168.0.62','2026-01-28 08:03:08.322557',10),
(58,'UPDATED','Payment',NULL,'{\"entries_changed\": [{\"analyst\": \"Aileen Santos\", \"payment\": {\"old\": 0.0, \"new\": 192307.69}, \"ptp\": {\"old\": 0.0, \"new\": 192307.69}}], \"status_code\": 200, \"path\": \"/api/v1/payments/daily-entry/\"}','192.168.0.62','2026-01-28 08:25:56.645712',10),
(59,'UPDATED','Payment',NULL,'{\"entries_changed\": [{\"analyst\": \"Aileen Santos\", \"payment\": {\"old\": 192307.69, \"new\": 110000.69}, \"ptp\": {\"old\": 192307.69, \"new\": 110000.69}}], \"status_code\": 200, \"path\": \"/api/v1/payments/daily-entry/\"}','192.168.0.62','2026-01-28 08:26:11.785795',10),
(60,'UPDATED','Payment',NULL,'{\"entries_changed\": [{\"analyst\": \"Jerald Villacorta\", \"payment\": {\"old\": 0.0, \"new\": 1382451.31}, \"ptp\": {\"old\": 0.0, \"new\": 1382451.31}}], \"status_code\": 200, \"path\": \"/api/v1/payments/daily-entry/\"}','192.168.0.62','2026-01-28 08:27:35.647763',10),
(61,'UPDATED','Payment',NULL,'{\"entries_changed\": [{\"analyst\": \"Jordan Yaon\", \"payment\": {\"old\": 0.0, \"new\": 1382451.31}, \"ptp\": {\"old\": 0.0, \"new\": 1382451.31}}], \"status_code\": 200, \"path\": \"/api/v1/payments/daily-entry/\"}','192.168.0.62','2026-01-28 08:28:05.058031',10);
/*!40000 ALTER TABLE `core_auditlog` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `core_passwordresetrequest`
--

DROP TABLE IF EXISTS `core_passwordresetrequest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_passwordresetrequest` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `status` varchar(10) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `username` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `core_passwordresetrequest_user_id_0112a4d0_fk_auth_user_id` (`user_id`),
  CONSTRAINT `core_passwordresetrequest_user_id_0112a4d0_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_passwordresetrequest`
--

LOCK TABLES `core_passwordresetrequest` WRITE;
/*!40000 ALTER TABLE `core_passwordresetrequest` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `core_passwordresetrequest` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `core_profile`
--

DROP TABLE IF EXISTS `core_profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_profile` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `must_change_password` tinyint(1) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `core_profile_user_id_bf8ada58_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=96 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_profile`
--

LOCK TABLES `core_profile` WRITE;
/*!40000 ALTER TABLE `core_profile` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `core_profile` VALUES
(1,0,1),
(2,0,10),
(3,0,35),
(4,0,36),
(5,0,37),
(6,0,38),
(7,0,39),
(8,0,40),
(9,0,41),
(10,0,42),
(11,0,43),
(12,0,44),
(13,0,45),
(14,0,46),
(15,0,47),
(16,0,48),
(17,0,49),
(18,0,50),
(19,0,51),
(20,0,52),
(21,0,53),
(22,0,54),
(23,0,55),
(24,0,56),
(25,0,57),
(26,0,58),
(27,0,59),
(28,0,60),
(29,0,61),
(30,0,62),
(31,0,63),
(32,0,64),
(33,0,65),
(34,0,66),
(35,0,67),
(36,0,68),
(37,0,69),
(38,0,70),
(39,0,71),
(40,0,72),
(41,0,73),
(42,0,74),
(43,0,75),
(44,0,76),
(45,0,77),
(46,0,78),
(47,0,79),
(48,0,80),
(49,0,81),
(50,0,82),
(51,0,83),
(52,0,84),
(53,0,85),
(54,0,86),
(55,0,87),
(56,0,88),
(57,0,89),
(58,0,90),
(59,0,91),
(60,0,92),
(61,0,93),
(62,0,94),
(63,0,95),
(64,0,96),
(65,0,97),
(66,0,98),
(67,0,99),
(68,0,100),
(69,0,101),
(70,0,102),
(71,0,103),
(72,0,104),
(73,0,105),
(74,0,106),
(75,0,107),
(76,0,108),
(77,0,109),
(78,0,110),
(79,0,111),
(80,0,112),
(81,0,113),
(82,0,114),
(83,0,115),
(84,0,116),
(85,0,117),
(86,0,118),
(87,0,119),
(88,0,120),
(89,0,121),
(90,0,122),
(91,0,123),
(92,0,124),
(93,0,125),
(94,0,126),
(95,0,127);
/*!40000 ALTER TABLE `core_profile` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `django_content_type` VALUES
(1,'admin','logentry'),
(8,'analysts','analyst'),
(3,'auth','group'),
(2,'auth','permission'),
(4,'auth','user'),
(7,'clients','client'),
(5,'contenttypes','contenttype'),
(17,'core','auditlog'),
(14,'core','notificationpreference'),
(15,'core','passwordresetrequest'),
(16,'core','profile'),
(10,'payments','dailypayment'),
(11,'ptp','dailyptp'),
(9,'receivables','receivable'),
(6,'sessions','session'),
(12,'targets','target'),
(13,'teams','team');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `django_migrations` VALUES
(1,'contenttypes','0001_initial','2026-01-20 01:55:41.608828'),
(2,'auth','0001_initial','2026-01-20 01:55:42.175554'),
(3,'admin','0001_initial','2026-01-20 01:55:42.284000'),
(4,'admin','0002_logentry_remove_auto_add','2026-01-20 01:55:42.290996'),
(5,'admin','0003_logentry_add_action_flag_choices','2026-01-20 01:55:42.297265'),
(6,'analysts','0001_initial','2026-01-20 01:55:42.362155'),
(7,'contenttypes','0002_remove_content_type_name','2026-01-20 01:55:42.445864'),
(8,'auth','0002_alter_permission_name_max_length','2026-01-20 01:55:42.479271'),
(9,'auth','0003_alter_user_email_max_length','2026-01-20 01:55:42.513092'),
(10,'auth','0004_alter_user_username_opts','2026-01-20 01:55:42.520151'),
(11,'auth','0005_alter_user_last_login_null','2026-01-20 01:55:42.567416'),
(12,'auth','0006_require_contenttypes_0002','2026-01-20 01:55:42.570681'),
(13,'auth','0007_alter_validators_add_error_messages','2026-01-20 01:55:42.577366'),
(14,'auth','0008_alter_user_username_max_length','2026-01-20 01:55:42.611878'),
(15,'auth','0009_alter_user_last_name_max_length','2026-01-20 01:55:42.645280'),
(16,'auth','0010_alter_group_name_max_length','2026-01-20 01:55:42.680662'),
(17,'auth','0011_update_proxy_permissions','2026-01-20 01:55:42.688860'),
(18,'auth','0012_alter_user_first_name_max_length','2026-01-20 01:55:42.721532'),
(19,'clients','0001_initial','2026-01-20 01:55:42.740600'),
(20,'payments','0001_initial','2026-01-20 01:55:42.886439'),
(21,'ptp','0001_initial','2026-01-20 01:55:43.035628'),
(22,'receivables','0001_initial','2026-01-20 01:55:43.180267'),
(23,'sessions','0001_initial','2026-01-20 01:55:43.233989'),
(24,'targets','0001_initial','2026-01-20 01:55:43.334332'),
(25,'analysts','0002_analyst_email_analyst_role_analyst_updated_at','2026-01-20 07:25:13.750546'),
(26,'clients','0002_client_client_code_client_contact_person_and_more','2026-01-20 07:25:13.900172'),
(27,'teams','0001_initial','2026-01-20 07:25:14.037783'),
(28,'analysts','0003_alter_analyst_role','2026-01-21 00:09:42.951117'),
(29,'analysts','0004_analyst_clients','2026-01-21 02:41:51.434562'),
(30,'teams','0002_team_clients','2026-01-21 02:41:51.595463'),
(31,'core','0001_initial','2026-01-23 06:06:11.866129'),
(32,'core','0002_delete_notificationpreference','2026-01-23 06:27:50.412490'),
(33,'core','0003_initial','2026-01-23 07:02:08.286934'),
(34,'core','0004_remove_passwordresetrequest_email_and_more','2026-01-23 07:39:11.614097'),
(35,'core','0005_auditlog','2026-01-28 04:43:24.360100');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `django_session` VALUES
('3ndbrufk6gcwjbn91sdvrcq3khlfvz0u','.eJxVjDsOwjAQBe_iGlnxbvyjpOcM1tpr4wBypDipEHeHSCmgfTPzXiLQttaw9byEicVZKHH63SKlR2474Du12yzT3NZlinJX5EG7vM6cn5fD_Tuo1Ou3HkwCb3Up6GyOAIgJC-WM4NE7cANjhIjaFgejior9qI0GIEPA1mrx_gDJ1Dbp:1vjCDY:1aTN2hbqkin76RNDo05_oMjQuwUL_IppBDRh4b0yf5I','2026-02-06 08:08:32.610456'),
('t3buex538szwo3zr79u0d4b2ktkbqaqw','.eJxVjEsOAiEQBe_C2hAYoAGX7j0DaehGRs2QzGdlvLtOMgvdvqp6L5FwW1vaFp7TSOIstDj9bhnLg6cd0B2nW5elT-s8Zrkr8qCLvHbi5-Vw_w4aLu1bOyrZUIDBAhCDx4Ls2WvlTIQArIsyHFyw1laP0SuINkBQEWmoXL14fwDbGDds:1vi1tR:lungZ93d1E-rL4sjxxyy2rZji7M9W72QfpEXtBxb98M','2026-02-03 02:54:57.320443');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `payments_dailypayment`
--

DROP TABLE IF EXISTS `payments_dailypayment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `payments_dailypayment` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `payment_date` date NOT NULL,
  `amount` decimal(15,2) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `analyst_id` bigint(20) NOT NULL,
  `client_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `payments_dailypayment_client_id_analyst_id_pay_3dee2ad5_uniq` (`client_id`,`analyst_id`,`payment_date`),
  KEY `payments_dailypayment_analyst_id_c6b9c735_fk_analysts_analyst_id` (`analyst_id`),
  CONSTRAINT `payments_dailypayment_analyst_id_c6b9c735_fk_analysts_analyst_id` FOREIGN KEY (`analyst_id`) REFERENCES `analysts_analyst` (`id`),
  CONSTRAINT `payments_dailypayment_client_id_e02cf1a2_fk_clients_client_id` FOREIGN KEY (`client_id`) REFERENCES `clients_client` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments_dailypayment`
--

LOCK TABLES `payments_dailypayment` WRITE;
/*!40000 ALTER TABLE `payments_dailypayment` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `payments_dailypayment` VALUES
(4,'2026-01-20',123.00,'2026-01-22 02:15:24.958565',23,11),
(5,'2026-01-20',321.00,'2026-01-22 02:15:24.965433',24,11),
(6,'2026-01-20',456.00,'2026-01-22 02:15:24.971421',25,11),
(7,'2026-01-20',654.00,'2026-01-22 02:15:24.978000',26,11),
(8,'2026-01-20',234.00,'2026-01-22 02:15:24.983250',27,11),
(9,'2026-01-20',543.00,'2026-01-22 02:15:24.988949',28,11),
(10,'2026-01-20',432.00,'2026-01-22 02:15:24.994500',29,11),
(11,'2026-01-20',654.00,'2026-01-22 02:15:25.000220',30,11),
(12,'2026-01-20',456.00,'2026-01-22 02:15:25.006446',31,11),
(13,'2026-01-22',123.00,'2026-01-22 02:16:35.540666',23,11),
(14,'2026-01-22',321.00,'2026-01-22 02:16:35.546446',24,11),
(15,'2026-01-22',234.00,'2026-01-22 02:16:35.551635',25,11),
(16,'2026-01-22',432.00,'2026-01-22 02:16:35.557233',26,11),
(17,'2026-01-22',345.00,'2026-01-22 02:16:35.562907',27,11),
(18,'2026-01-22',543.00,'2026-01-22 02:16:35.567920',28,11),
(19,'2026-01-22',456.00,'2026-01-22 02:16:35.573860',29,11),
(20,'2026-01-22',654.00,'2026-01-22 02:16:35.579128',30,11),
(21,'2026-01-22',567.00,'2026-01-22 02:16:35.584201',31,11),
(22,'2026-01-28',0.00,'2026-01-28 05:39:39.591442',72,14),
(23,'2026-01-28',0.00,'2026-01-28 05:39:39.598220',73,14),
(24,'2026-01-28',0.00,'2026-01-28 05:39:39.608359',74,14),
(25,'2026-01-28',110000.69,'2026-01-28 05:52:13.945452',23,11),
(26,'2026-01-28',0.00,'2026-01-28 05:52:13.951709',24,11),
(27,'2026-01-28',1382451.31,'2026-01-28 05:52:13.958280',25,11),
(28,'2026-01-28',1382451.31,'2026-01-28 05:52:13.963881',26,11),
(29,'2026-01-28',0.00,'2026-01-28 05:52:13.969443',27,11),
(30,'2026-01-28',0.00,'2026-01-28 05:52:13.975511',28,11),
(31,'2026-01-28',0.00,'2026-01-28 05:52:13.981116',29,11),
(32,'2026-01-28',0.00,'2026-01-28 05:52:13.986866',30,11),
(33,'2026-01-28',0.00,'2026-01-28 05:52:13.993447',31,11),
(34,'2026-01-28',0.00,'2026-01-28 05:52:13.999522',70,11),
(35,'2026-01-28',0.00,'2026-01-28 05:52:14.006248',71,11);
/*!40000 ALTER TABLE `payments_dailypayment` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `ptp_dailyptp`
--

DROP TABLE IF EXISTS `ptp_dailyptp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ptp_dailyptp` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ptp_date` date NOT NULL,
  `ptp_amount` decimal(15,2) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `analyst_id` bigint(20) NOT NULL,
  `client_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ptp_dailyptp_client_id_analyst_id_ptp_date_53f01f2c_uniq` (`client_id`,`analyst_id`,`ptp_date`),
  KEY `ptp_dailyptp_analyst_id_1d804c7a_fk_analysts_analyst_id` (`analyst_id`),
  CONSTRAINT `ptp_dailyptp_analyst_id_1d804c7a_fk_analysts_analyst_id` FOREIGN KEY (`analyst_id`) REFERENCES `analysts_analyst` (`id`),
  CONSTRAINT `ptp_dailyptp_client_id_98a9b7a4_fk_clients_client_id` FOREIGN KEY (`client_id`) REFERENCES `clients_client` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ptp_dailyptp`
--

LOCK TABLES `ptp_dailyptp` WRITE;
/*!40000 ALTER TABLE `ptp_dailyptp` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `ptp_dailyptp` VALUES
(4,'2026-01-20',123.00,'2026-01-22 02:15:24.962014',23,11),
(5,'2026-01-20',321.00,'2026-01-22 02:15:24.967991',24,11),
(6,'2026-01-20',456.00,'2026-01-22 02:15:24.974474',25,11),
(7,'2026-01-20',654.00,'2026-01-22 02:15:24.980429',26,11),
(8,'2026-01-20',234.00,'2026-01-22 02:15:24.985743',27,11),
(9,'2026-01-20',543.00,'2026-01-22 02:15:24.991410',28,11),
(10,'2026-01-20',324.00,'2026-01-22 02:15:24.997102',29,11),
(11,'2026-01-20',543.00,'2026-01-22 02:15:25.002933',30,11),
(12,'2026-01-20',654.00,'2026-01-22 02:15:25.009024',31,11),
(13,'2026-01-22',123.00,'2026-01-22 02:16:35.543324',23,11),
(14,'2026-01-22',321.00,'2026-01-22 02:16:35.548960',24,11),
(15,'2026-01-22',234.00,'2026-01-22 02:16:35.554056',25,11),
(16,'2026-01-22',432.00,'2026-01-22 02:16:35.559803',26,11),
(17,'2026-01-22',345.00,'2026-01-22 02:16:35.565405',27,11),
(18,'2026-01-22',543.00,'2026-01-22 02:16:35.570779',28,11),
(19,'2026-01-22',456.00,'2026-01-22 02:16:35.576276',29,11),
(20,'2026-01-22',654.00,'2026-01-22 02:16:35.581557',30,11),
(21,'2026-01-22',567.00,'2026-01-22 02:16:35.586459',31,11),
(22,'2026-01-28',0.00,'2026-01-28 05:39:39.594559',72,14),
(23,'2026-01-28',0.00,'2026-01-28 05:39:39.601560',73,14),
(24,'2026-01-28',0.00,'2026-01-28 05:39:39.612995',74,14),
(25,'2026-01-28',110000.69,'2026-01-28 05:52:13.948350',23,11),
(26,'2026-01-28',0.00,'2026-01-28 05:52:13.954636',24,11),
(27,'2026-01-28',1382451.31,'2026-01-28 05:52:13.960804',25,11),
(28,'2026-01-28',1382451.31,'2026-01-28 05:52:13.966324',26,11),
(29,'2026-01-28',0.00,'2026-01-28 05:52:13.972172',27,11),
(30,'2026-01-28',0.00,'2026-01-28 05:52:13.978199',28,11),
(31,'2026-01-28',0.00,'2026-01-28 05:52:13.983508',29,11),
(32,'2026-01-28',0.00,'2026-01-28 05:52:13.989714',30,11),
(33,'2026-01-28',0.00,'2026-01-28 05:52:13.996318',31,11),
(34,'2026-01-28',0.00,'2026-01-28 05:52:14.002401',70,11),
(35,'2026-01-28',0.00,'2026-01-28 05:52:14.008962',71,11);
/*!40000 ALTER TABLE `ptp_dailyptp` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `receivables_receivable`
--

DROP TABLE IF EXISTS `receivables_receivable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `receivables_receivable` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `report_date` date NOT NULL,
  `pos_account_count` int(11) NOT NULL,
  `pos_amount` decimal(15,2) NOT NULL,
  `neg_account_count` int(11) NOT NULL,
  `neg_amount` decimal(15,2) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `analyst_id` bigint(20) NOT NULL,
  `client_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `receivables_receivable_client_id_analyst_id_rep_9e383df7_uniq` (`client_id`,`analyst_id`,`report_date`),
  KEY `receivables_receivab_analyst_id_ecf451c6_fk_analysts_` (`analyst_id`),
  CONSTRAINT `receivables_receivab_analyst_id_ecf451c6_fk_analysts_` FOREIGN KEY (`analyst_id`) REFERENCES `analysts_analyst` (`id`),
  CONSTRAINT `receivables_receivable_client_id_7c5598a6_fk_clients_client_id` FOREIGN KEY (`client_id`) REFERENCES `clients_client` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `receivables_receivable`
--

LOCK TABLES `receivables_receivable` WRITE;
/*!40000 ALTER TABLE `receivables_receivable` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `receivables_receivable` VALUES
(4,'2026-01-01',0,0.00,0,0.00,'2026-01-21 06:13:27.410678',7,14),
(5,'2026-02-01',321,321.00,321,321.00,'2026-01-21 06:13:37.297042',7,14),
(6,'2026-01-01',0,0.00,0,0.00,'2026-01-21 07:51:33.926980',7,12),
(7,'2026-01-01',1123,1123.00,123,123.00,'2026-01-21 09:20:50.861045',12,5),
(8,'2026-01-01',123123,6754456.00,2134,3456.00,'2026-01-21 09:33:26.190161',12,2),
(9,'2026-01-01',123123,1231235.00,213,3456.00,'2026-01-21 09:33:27.149033',12,3),
(10,'2026-01-01',323,345345.00,123,5463.00,'2026-01-21 09:33:27.493528',12,4),
(11,'2026-01-01',1606,160302870.36,11613,1017739000.34,'2026-01-22 02:15:44.251140',7,11);
/*!40000 ALTER TABLE `receivables_receivable` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `targets_target`
--

DROP TABLE IF EXISTS `targets_target`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `targets_target` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `target_month` date NOT NULL,
  `internal_target` decimal(15,2) NOT NULL,
  `client_target` decimal(15,2) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `client_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `targets_target_client_id_target_month_5b8a56d4_uniq` (`client_id`,`target_month`),
  CONSTRAINT `targets_target_client_id_d4f93306_fk_clients_client_id` FOREIGN KEY (`client_id`) REFERENCES `clients_client` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `targets_target`
--

LOCK TABLES `targets_target` WRITE;
/*!40000 ALTER TABLE `targets_target` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `targets_target` VALUES
(1,'2026-01-01',2500000.00,1500000.00,'2026-01-26 01:21:19.115774',11),
(2,'2026-01-01',0.00,0.00,'2026-01-26 01:30:01.743247',12),
(3,'2026-01-01',0.00,0.00,'2026-01-28 08:01:38.628781',14);
/*!40000 ALTER TABLE `targets_target` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `teams_team`
--

DROP TABLE IF EXISTS `teams_team`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `teams_team` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` longtext DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `team_lead_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `teams_team_team_lead_id_3681a765_fk_analysts_analyst_id` (`team_lead_id`),
  CONSTRAINT `teams_team_team_lead_id_3681a765_fk_analysts_analyst_id` FOREIGN KEY (`team_lead_id`) REFERENCES `analysts_analyst` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teams_team`
--

LOCK TABLES `teams_team` WRITE;
/*!40000 ALTER TABLE `teams_team` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `teams_team` VALUES
(5,'NASH','',1,'2026-01-22 01:22:29.647962','2026-01-22 01:43:28.809182',5),
(6,'JAMES','PAGIBIG',1,'2026-01-26 04:09:45.195800','2026-01-26 04:30:45.747803',14),
(7,'NELISSA','',1,'2026-01-26 04:40:04.235922','2026-01-26 04:40:04.235941',NULL);
/*!40000 ALTER TABLE `teams_team` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `teams_team_clients`
--

DROP TABLE IF EXISTS `teams_team_clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `teams_team_clients` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `team_id` bigint(20) NOT NULL,
  `client_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `teams_team_clients_team_id_client_id_911196d9_uniq` (`team_id`,`client_id`),
  KEY `teams_team_clients_client_id_f738b42d_fk_clients_client_id` (`client_id`),
  CONSTRAINT `teams_team_clients_client_id_f738b42d_fk_clients_client_id` FOREIGN KEY (`client_id`) REFERENCES `clients_client` (`id`),
  CONSTRAINT `teams_team_clients_team_id_2e244a08_fk_teams_team_id` FOREIGN KEY (`team_id`) REFERENCES `teams_team` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teams_team_clients`
--

LOCK TABLES `teams_team_clients` WRITE;
/*!40000 ALTER TABLE `teams_team_clients` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `teams_team_clients` VALUES
(10,5,11),
(11,5,12),
(12,5,13),
(13,5,14),
(14,6,17),
(15,7,15);
/*!40000 ALTER TABLE `teams_team_clients` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `teams_team_members`
--

DROP TABLE IF EXISTS `teams_team_members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `teams_team_members` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `team_id` bigint(20) NOT NULL,
  `analyst_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `teams_team_members_team_id_analyst_id_8bdad298_uniq` (`team_id`,`analyst_id`),
  KEY `teams_team_members_analyst_id_11498da1_fk_analysts_analyst_id` (`analyst_id`),
  CONSTRAINT `teams_team_members_analyst_id_11498da1_fk_analysts_analyst_id` FOREIGN KEY (`analyst_id`) REFERENCES `analysts_analyst` (`id`),
  CONSTRAINT `teams_team_members_team_id_ebb2d47d_fk_teams_team_id` FOREIGN KEY (`team_id`) REFERENCES `teams_team` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teams_team_members`
--

LOCK TABLES `teams_team_members` WRITE;
/*!40000 ALTER TABLE `teams_team_members` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `teams_team_members` VALUES
(4,5,23),
(5,5,24),
(6,5,25),
(7,5,26),
(8,5,27),
(9,5,28),
(10,5,29),
(11,5,30),
(12,5,31),
(13,6,32),
(14,6,34),
(15,6,35),
(16,6,36),
(17,6,37),
(18,6,38),
(19,6,39),
(20,6,40),
(21,6,41),
(22,6,42),
(23,6,43),
(24,6,44),
(25,6,45),
(28,7,46),
(29,7,47),
(26,7,48),
(27,7,49);
/*!40000 ALTER TABLE `teams_team_members` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `test_restore`
--

DROP TABLE IF EXISTS `test_restore`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `test_restore` (
  `id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `test_restore`
--

LOCK TABLES `test_restore` WRITE;
/*!40000 ALTER TABLE `test_restore` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `test_restore` VALUES
(1);
/*!40000 ALTER TABLE `test_restore` ENABLE KEYS */;
UNLOCK TABLES;
commit;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*M!100616 SET NOTE_VERBOSITY=@OLD_NOTE_VERBOSITY */;

-- Dump completed on 2026-01-28 16:59:54
