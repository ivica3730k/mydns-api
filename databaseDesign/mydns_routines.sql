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
-- Dumping events for database 'mydns'
--

--
-- Dumping routines for database 'mydns'
--
/*!50003 DROP FUNCTION IF EXISTS `getUserIdFromApiKey` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dnsadmin`@`%` FUNCTION `getUserIdFromApiKey`(_key VARCHAR(64)) RETURNS bigint(20)
BEGIN
SET @userId = (SELECT userId FROM mydns.apikeys WHERE apikey = _key);
RETURN @userId ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `getZoneIdFromRecord` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dnsadmin`@`%` FUNCTION `getZoneIdFromRecord`(_record CHAR(64)) RETURNS bigint(20)
BEGIN
SET @zoneId = (SELECT zone FROM mydns.rr WHERE name = _record);
return @zoneId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `randomApiKey` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dnsadmin`@`%` FUNCTION `randomApiKey`() RETURNS varchar(64) CHARSET latin1
BEGIN

SET @chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ123456789@{};~<>!£$%^&*()_+|';
SET @charLen = length(@chars);

SET @randomPassword = '';

WHILE length(@randomPassword) < 64
    DO
    SET @randomPassword = concat(@randomPassword, substring(@chars,CEILING(RAND() * @charLen),1));
END WHILE;

RETURN @randomPassword ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `addRR` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dnsadmin`@`%` PROCEDURE `addRR`( IN _apikey VARCHAR(64),
							IN _origin CHAR(255),
							IN _name CHAR(64),
                            _type ENUM('A', 'AAAA', 'CNAME', 'HINFO', 'MX', 'NAPTR', 'NS', 'PTR', 'RP', 'SRV', 'TXT'),
                            IN _data CHAR(128))
BEGIN
	DECLARE errorFlag BOOLEAN default false;
	DECLARE response VARCHAR(20);
    DECLARE isDnsOptimizedZone boolean default false;
    DECLARE originId int;
    
	SET @userAccId = getUserIdFromApiKey(_apikey);
	SET @rootDomainOwner = (SELECT owner FROM mydns.soa WHERE owner = @userAccId  AND origin = _origin);  
	IF(@userAccId IS NULL) THEN
		SET response = "INVUSER";
		SET errorFlag = true;
	END IF;
    IF(@rootDomainOwner IS NULL) THEN
		SET response = "INVSOA";
        SET errorFlag = true;
	END IF;
    
    SET @isAlreadyPresentRr = (SELECT id FROM mydns.rr WHERE name = _name);
    IF (@isAlreadyPresentRr IS NOT NULL) THEN
		SET response = "EXISTINGRR";
        SET errorFlag = true;
    END IF;


    SELECT id,ddns FROM mydns.soa WHERE origin = _origin INTO originId,isDnsOptimizedZone;
	SELECT originId,_name,_type,_data;

    IF ( errorFlag IS FALSE) THEN
		IF (isDnsOptimizedZone = TRUE) THEN
			INSERT INTO mydns.rr (zone,name,type,data,ttl) VALUES (originId,_name,_type,_data,0);
            SET response = "OK";
		ELSE
			INSERT INTO mydns.rr (zone,name,type,data) VALUES (originId,_name,_type,_data);
            SET response = "OK";
        END IF;
    END IF;
    
    SELECT response;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `addSoa` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dnsadmin`@`%` PROCEDURE `addSoa`( IN _apikey VARCHAR(64),
							IN _origin CHAR(255),
                            IN _optimiseForDdns boolean 
							)
BEGIN
	DECLARE errorFlag BOOLEAN default false;
	DECLARE response VARCHAR(20);
	DECLARE userAccId BIGINT;
	DECLARE userEmail VARCHAR(100);

	SET userAccId = getUserIdFromApiKey(_apikey);
	IF(userAccId IS NULL) THEN
		SET response = "INVUSER";
		SET errorFlag = true;
	END IF;

	SELECT email FROM mydns.users WHERE id = userAccId INTO userEmail;
	IF (userEmail IS null AND errorFlag IS false) THEN
		SET response = "INVUSERMAIL";
		SET errorFlag = true;
	END IF;

	IF (errorFlag IS  false AND (SELECT id FROM mydns.soa WHERE origin = _origin) IS NOT NULL) THEN
		SET response = "EXISTINGSOA";
		SET errorFlag = true;
	END IF;

	IF (errorFlag IS false ) THEN
		IF (_optimiseForDdns is true) then
			INSERT INTO mydns.soa (origin,mbox,owner,ddns,minimum,ttl) VALUES (_origin,userEmail,userAccId,_optimiseForDdns,0,0);
            SET response = "OK";
        else
			INSERT INTO mydns.soa (origin,mbox,owner) VALUES (_origin,userEmail,userAccId);
			SET response = "OK";
		END IF;
	END IF;
	SELECT response;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `createApiKey` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dnsadmin`@`%` PROCEDURE `createApiKey`(IN userid bigint)
BEGIN
    INSERT INTO mydns.apikeys (userId,apikey) VALUES (userid,randomApiKey());
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `removeApiKey` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dnsadmin`@`%` PROCEDURE `removeApiKey`(IN _apikey VARCHAR(64))
BEGIN
    DELETE FROM mydns.apikeys WHERE apiKey = _apikey;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updateRr` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`dnsadmin`@`%` PROCEDURE `updateRr`(IN apikey VARCHAR(64) , 
								IN record CHAR(64), 
                                IN newData CHAR(128)
								)
BEGIN
SET @zoneId = getZoneIdFromRecord(record);
SET @rootDomainOwner = (SELECT owner FROM mydns.soa WHERE owner = getUserIdFromApiKey(apikey)
						AND id = @zoneId);                        
SET @recordId = (SELECT id FROM mydns.rr WHERE name = record);
if (@rootDomainOwner AND @recordId ) THEN
	UPDATE mydns.rr SET data = newData WHERE id = @recordId;
    SET @result = "OK";
    SELECT @result;
else
	if (@recordId IS NULL) THEN
		SET @result = "NORECORD";
        SELECT @result;
	ELSE 
		SET @result = "NOTOWNER";
        SELECT @result;
	END IF;
END IF;
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

-- Dump completed on 2020-03-18  4:35:29
