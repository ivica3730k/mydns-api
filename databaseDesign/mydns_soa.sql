CREATE DATABASE  IF NOT EXISTS `mydns` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `mydns`;
-- MySQL dump 10.13  Distrib 5.7.29, for linux-glibc2.12 (x86_64)
--
-- Host: docker.ivica.codes    Database: mydns
-- ------------------------------------------------------
-- Server version	5.7.29-0ubuntu0.18.04.1

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
-- Table structure for table `soa`
--

DROP TABLE IF EXISTS `soa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `soa` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `origin` char(255) NOT NULL,
  `ns` char(255) NOT NULL DEFAULT 'localhost',
  `mbox` char(255) NOT NULL,
  `serial` int(10) unsigned NOT NULL DEFAULT '1',
  `refresh` int(10) unsigned NOT NULL DEFAULT '28800',
  `retry` int(10) unsigned NOT NULL DEFAULT '7200',
  `expire` int(10) unsigned NOT NULL DEFAULT '604800',
  `minimum` int(10) unsigned NOT NULL DEFAULT '86400',
  `ttl` int(10) unsigned NOT NULL DEFAULT '86400',
  `owner` bigint(20) NOT NULL,
  `ddns` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `origin` (`origin`),
  KEY `FK_soa_to_user` (`owner`),
  CONSTRAINT `FK_soa_to_user` FOREIGN KEY (`owner`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-03-18  4:35:14
