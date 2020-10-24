-- MySQL dump 10.13  Distrib 5.7.31, for Linux (x86_64)
--
-- Host: localhost    Database: test1
-- ------------------------------------------------------
-- Server version	5.7.31-0ubuntu0.18.04.1

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
-- Table structure for table `chemical_composition`
--
-- CREATE DATABASE test1;

USE test1;

DROP TABLE IF EXISTS `chemical_composition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `chemical_composition` (
  `commodity_id` int(11) NOT NULL,
  `chem_id` int(11) NOT NULL,
  `percentage` float DEFAULT NULL,
  PRIMARY KEY (`commodity_id`,`chem_id`),
  KEY `chem_id` (`chem_id`),
  CONSTRAINT `chemical_composition_ibfk_1` FOREIGN KEY (`commodity_id`) REFERENCES `commodities` (`commodity_id`),
  CONSTRAINT `chemical_composition_ibfk_2` FOREIGN KEY (`chem_id`) REFERENCES `chemicals` (`chem_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chemical_composition`
--

LOCK TABLES `chemical_composition` WRITE;
/*!40000 ALTER TABLE `chemical_composition` DISABLE KEYS */;
INSERT INTO `chemical_composition` VALUES (1,1,10.5),(1,999,89.5),(2,3,10.5),(2,2,89.5),(3,5,5),(3,9,15),(3,3,10),(3,999,70),(4,5,5),(4,9,15),(4,3,10),(4,999,70),(5,15,5),(5,19,15),(5,30,10),(5,999,70);
/*!40000 ALTER TABLE `chemical_composition` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chemicals`
--

DROP TABLE IF EXISTS `chemicals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `chemicals` (
  `chem_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`chem_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chemicals`
--

LOCK TABLES `chemicals` WRITE;
/*!40000 ALTER TABLE `chemicals` DISABLE KEYS */;
INSERT INTO `chemicals` VALUES (0,'Chem No0'),(1,'Chem No1'),(2,'Chem No2'),(3,'Chem No3'),(4,'Chem No4'),(5,'Chem No5'),(6,'Chem No6'),(7,'Chem No7'),(8,'Chem No8'),(9,'Chem No9'),(10,'Chem No10'),(11,'Chem No11'),(12,'Chem No12'),(13,'Chem No13'),(14,'Chem No14'),(15,'Chem No15'),(16,'Chem No16'),(17,'Chem No17'),(18,'Chem No18'),(19,'Chem No19'),(20,'Chem No20'),(21,'Chem No21'),(22,'Chem No22'),(23,'Chem No23'),(24,'Chem No24'),(25,'Chem No25'),(26,'Chem No26'),(27,'Chem No27'),(28,'Chem No28'),(29,'Chem No29'),(30,'Chem No30'),(31,'Chem No31'),(32,'Chem No32'),(33,'Chem No33'),(34,'Chem No34'),(35,'Chem No35'),(36,'Chem No36'),(37,'Chem No37'),(38,'Chem No38'),(39,'Chem No39'),(40,'Chem No40'),(41,'Chem No41'),(42,'Chem No42'),(43,'Chem No43'),(44,'Chem No44'),(45,'Chem No45'),(46,'Chem No46'),(47,'Chem No47'),(48,'Chem No48'),(49,'Chem No49'),(999,'Unknown Chemical');
/*!40000 ALTER TABLE `chemicals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `commodities`
--

DROP TABLE IF EXISTS `commodities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commodities` (
  `commodity_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `price` float DEFAULT NULL,
  `inventory` float DEFAULT NULL,
  PRIMARY KEY (`commodity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `commodities`
--

LOCK TABLES `commodities` WRITE;
/*!40000 ALTER TABLE `commodities` DISABLE KEYS */;
INSERT INTO `commodities` VALUES (0,'Commodity No 0',NULL,NULL),(1,'Commodity No 1',NULL,NULL),(2,'Commodity No 2',NULL,NULL),(3,'Commodity No 3',NULL,NULL),(4,'Commodity No 4',NULL,NULL),(5,'hello2',5.2,NULL),(6,'Commodity No 6',NULL,NULL),(7,'Commodity No 7',NULL,NULL),(8,'Commodity No 8',NULL,NULL),(9,'Commodity No 9',NULL,NULL),(10,'Commodity No 10',NULL,NULL),(11,'Commodity No 11',NULL,NULL),(12,'Commodity No 12',NULL,NULL),(13,'Commodity No 13',NULL,NULL),(14,'Commodity No 14',NULL,NULL),(15,'Commodity No 15',NULL,NULL),(16,'Commodity No 16',NULL,NULL),(17,'Commodity No 17',NULL,NULL),(18,'Commodity No 18',NULL,NULL),(19,'Commodity No 19',NULL,NULL),(20,'Commodity No 20',NULL,NULL),(21,'Commodity No 21',NULL,NULL),(22,'Commodity No 22',NULL,NULL),(23,'Commodity No 23',NULL,NULL),(24,'Commodity No 24',NULL,NULL),(25,'Commodity No 25',NULL,NULL),(26,'Commodity No 26',NULL,NULL),(27,'Commodity No 27',NULL,NULL),(28,'Commodity No 28',NULL,NULL),(29,'Commodity No 29',NULL,NULL),(30,'Commodity No 30',NULL,NULL),(31,'Commodity No 31',NULL,NULL),(32,'Commodity No 32',NULL,NULL),(33,'Commodity No 33',NULL,NULL),(34,'Commodity No 34',NULL,NULL),(35,'Commodity No 35',NULL,NULL),(36,'Commodity No 36',NULL,NULL),(37,'Commodity No 37',NULL,NULL),(38,'Commodity No 38',NULL,NULL),(39,'Commodity No 39',NULL,NULL),(40,'Commodity No 40',NULL,NULL),(41,'Commodity No 41',NULL,NULL),(42,'Commodity No 42',NULL,NULL),(43,'Commodity No 43',NULL,NULL),(44,'Commodity No 44',NULL,NULL),(45,'Commodity No 45',NULL,NULL),(46,'Commodity No 46',NULL,NULL),(47,'Commodity No 47',NULL,NULL),(48,'Commodity No 48',NULL,NULL),(49,'Commodity No 49',NULL,NULL);
/*!40000 ALTER TABLE `commodities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_pass`
--

DROP TABLE IF EXISTS `user_pass`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_pass` (
  `username` varchar(100) NOT NULL,
  `password` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_pass`
--

LOCK TABLES `user_pass` WRITE;
/*!40000 ALTER TABLE `user_pass` DISABLE KEYS */;
INSERT INTO `user_pass` VALUES ('ketul','$pbkdf2-sha256$29000$qZUSwliLUSrFWAshBCCEEA$8tz9CvSbdgIILUAIhFnVrE68b2pVzS8eUDsoU.qpG7E'),('user','$pbkdf2-sha256$29000$693bm1OqFSJEKIVQKuWc0w$QLT8Iebp8cGO6OrTKtwvOBYC2lpnKtWQJFwdjdd4S1s');
/*!40000 ALTER TABLE `user_pass` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-10-24 10:51:45
