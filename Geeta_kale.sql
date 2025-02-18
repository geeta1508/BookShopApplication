-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: BookShopApplication
-- ------------------------------------------------------
-- Server version	8.0.36

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `adminuser`
--

DROP TABLE IF EXISTS `adminuser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `adminuser` (
  `username` varchar(50) NOT NULL,
  `password` varchar(50) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `adminuser`
--

LOCK TABLES `adminuser` WRITE;
/*!40000 ALTER TABLE `adminuser` DISABLE KEYS */;
INSERT INTO `adminuser` VALUES ('admin1','admin@123','admin1@gmail.com'),('admin2','admin@123','admin2@gmail.com');
/*!40000 ALTER TABLE `adminuser` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `book`
--

DROP TABLE IF EXISTS `book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `book` (
  `book_id` int NOT NULL AUTO_INCREMENT,
  `book_name` varchar(100) DEFAULT NULL,
  `price` float DEFAULT NULL,
  `description` varchar(100) DEFAULT NULL,
  `image_url` varchar(100) DEFAULT NULL,
  `cid` int DEFAULT NULL,
  PRIMARY KEY (`book_id`),
  KEY `cid` (`cid`),
  CONSTRAINT `book_ibfk_1` FOREIGN KEY (`cid`) REFERENCES `category` (`cid`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book`
--

LOCK TABLES `book` WRITE;
/*!40000 ALTER TABLE `book` DISABLE KEYS */;
INSERT INTO `book` VALUES (1,'MoralStory',300,'moral story for kids','Images/storybook1.webp',1),(2,'hdappa book',400,'Harappan Civilization','Images/historicalbook2in hindi.jpg',2),(8,'A Collection of poem',600,'XYZ','Images/poembook2.jpeg',3),(9,'A Child book of poem',400,'lot\'s of  poem for children','Images/poem book1.jpeg',3),(10,'Why study History',900,'All about history','Images/Historicalbook1.jpeg',2),(11,'Wings of fire',400,'story about Dr. APJ kalam ','Images/Wings-of-Fire-An-Autobiography-of-APJ-Abdul-Kalam2.jpg',5),(12,'Albert Einstein',800,'The Genius Who failed School','Images/Biography.jpeg',5),(13,'Akbar Birbal Goshti',200,'chhan chan goshti','Images/Akbar-Birbalachya-Goshti.jpg',1),(15,'Me before you',700,'A novel by the author Moye','Images/novel1.jpeg',4);
/*!40000 ALTER TABLE `book` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `book_cat_vw`
--

DROP TABLE IF EXISTS `book_cat_vw`;
/*!50001 DROP VIEW IF EXISTS `book_cat_vw`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `book_cat_vw` AS SELECT 
 1 AS `book_id`,
 1 AS `book_name`,
 1 AS `price`,
 1 AS `description`,
 1 AS `image_url`,
 1 AS `cname`,
 1 AS `cid`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `cart_vw`
--

DROP TABLE IF EXISTS `cart_vw`;
/*!50001 DROP VIEW IF EXISTS `cart_vw`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `cart_vw` AS SELECT 
 1 AS `book_id`,
 1 AS `book_name`,
 1 AS `price`,
 1 AS `image_url`,
 1 AS `qty`,
 1 AS `Subtotal`,
 1 AS `username`,
 1 AS `cart_id`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `cid` int NOT NULL AUTO_INCREMENT,
  `cname` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`cid`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'story book'),(2,'Historical'),(3,'Poetry'),(4,'Novels'),(5,'Biography');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mycart`
--

DROP TABLE IF EXISTS `mycart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mycart` (
  `cart_id` int NOT NULL AUTO_INCREMENT,
  `book_id` int DEFAULT NULL,
  `qty` int DEFAULT NULL,
  `status` enum('cart','order') DEFAULT NULL,
  `username` varchar(20) DEFAULT NULL,
  `order_id` int DEFAULT NULL,
  PRIMARY KEY (`cart_id`),
  KEY `book_id` (`book_id`),
  KEY `username` (`username`),
  KEY `order_id` (`order_id`),
  CONSTRAINT `mycart_ibfk_1` FOREIGN KEY (`book_id`) REFERENCES `book` (`book_id`),
  CONSTRAINT `mycart_ibfk_2` FOREIGN KEY (`username`) REFERENCES `userinfo` (`username`),
  CONSTRAINT `mycart_ibfk_3` FOREIGN KEY (`order_id`) REFERENCES `order_master` (`order_id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mycart`
--

LOCK TABLES `mycart` WRITE;
/*!40000 ALTER TABLE `mycart` DISABLE KEYS */;
INSERT INTO `mycart` VALUES (9,2,2,'order','Barsha',5),(10,11,2,'order','Barsha',5);
/*!40000 ALTER TABLE `mycart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_master`
--

DROP TABLE IF EXISTS `order_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_master` (
  `order_id` int NOT NULL AUTO_INCREMENT,
  `date_of_order` date DEFAULT NULL,
  `amount` float DEFAULT NULL,
  `username` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_master`
--

LOCK TABLES `order_master` WRITE;
/*!40000 ALTER TABLE `order_master` DISABLE KEYS */;
INSERT INTO `order_master` VALUES (5,'2024-07-03',1600,'Barsha');
/*!40000 ALTER TABLE `order_master` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `order_vw`
--

DROP TABLE IF EXISTS `order_vw`;
/*!50001 DROP VIEW IF EXISTS `order_vw`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `order_vw` AS SELECT 
 1 AS `book_id`,
 1 AS `book_name`,
 1 AS `price`,
 1 AS `image_url`,
 1 AS `qty`,
 1 AS `Subtotal`,
 1 AS `username`,
 1 AS `order_id`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment` (
  `cardno` varchar(10) NOT NULL,
  `cvv` varchar(5) DEFAULT NULL,
  `expiry` varchar(10) DEFAULT NULL,
  `balance` float DEFAULT NULL,
  PRIMARY KEY (`cardno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment`
--

LOCK TABLES `payment` WRITE;
/*!40000 ALTER TABLE `payment` DISABLE KEYS */;
INSERT INTO `payment` VALUES ('5555','5555','12/2030',14600),('6666','6666','12/2030',5400);
/*!40000 ALTER TABLE `payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userinfo`
--

DROP TABLE IF EXISTS `userinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `userinfo` (
  `username` varchar(30) NOT NULL,
  `password` varchar(20) DEFAULT NULL,
  `email` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userinfo`
--

LOCK TABLES `userinfo` WRITE;
/*!40000 ALTER TABLE `userinfo` DISABLE KEYS */;
INSERT INTO `userinfo` VALUES ('Barsha','barsha123','barsha123@gmail.com'),('Geeta','geeta@123','geeta123@gmail.com'),('Ritika','ritika@123','ritika123@gmail.com');
/*!40000 ALTER TABLE `userinfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `book_cat_vw`
--

/*!50001 DROP VIEW IF EXISTS `book_cat_vw`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `book_cat_vw` AS select `book`.`book_id` AS `book_id`,`book`.`book_name` AS `book_name`,`book`.`price` AS `price`,`book`.`description` AS `description`,`book`.`image_url` AS `image_url`,`cat`.`cname` AS `cname`,`cat`.`cid` AS `cid` from (`book` join `category` `cat` on((`book`.`cid` = `cat`.`cid`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `cart_vw`
--

/*!50001 DROP VIEW IF EXISTS `cart_vw`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `cart_vw` AS select `b`.`book_id` AS `book_id`,`b`.`book_name` AS `book_name`,`b`.`price` AS `price`,`b`.`image_url` AS `image_url`,`m`.`qty` AS `qty`,(`b`.`price` * `m`.`qty`) AS `Subtotal`,`m`.`username` AS `username`,`m`.`cart_id` AS `cart_id` from (`mycart` `m` join `book` `b` on(((`m`.`book_id` = `b`.`book_id`) and (`m`.`status` = 'cart')))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `order_vw`
--

/*!50001 DROP VIEW IF EXISTS `order_vw`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `order_vw` AS select `b`.`book_id` AS `book_id`,`b`.`book_name` AS `book_name`,`b`.`price` AS `price`,`b`.`image_url` AS `image_url`,`m`.`qty` AS `qty`,(`b`.`price` * `m`.`qty`) AS `Subtotal`,`m`.`username` AS `username`,`m`.`order_id` AS `order_id` from (`mycart` `m` join `book` `b` on(((`m`.`book_id` = `b`.`book_id`) and (`m`.`status` = 'order')))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-07-09 17:16:02
