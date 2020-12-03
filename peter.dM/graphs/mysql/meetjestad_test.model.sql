
CREATE DATABASE /*!32312 IF NOT EXISTS*/ `meetjestad_test` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `meetjestad_test`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;

CREATE TABLE IF NOT EXISTS `knmi_th` (
  `localtijd` datetime NOT NULL,
  `unixtime` int(12) DEFAULT NULL,
  `source` varchar(16) DEFAULT NULL,
  `temp` float DEFAULT NULL,
  `dauw` float DEFAULT NULL,
  `humi` float DEFAULT NULL,
  `regen` float DEFAULT NULL,
  `regen7d` double DEFAULT NULL,
  `straling` float DEFAULT NULL,
  PRIMARY KEY (`localtijd`),
  KEY `unixtime` (`unixtime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;

CREATE TABLE IF NOT EXISTS `sens7021` (
  `gmtijd` datetime NOT NULL,
  `unixtime` int(12) DEFAULT NULL,
  `source` varchar(16) DEFAULT NULL,
  `port` int(1) NOT NULL,
  `serial` varchar(10) DEFAULT NULL,
  `temp` float DEFAULT NULL,
  `humi` float DEFAULT NULL,
  `dewp` float DEFAULT NULL,
  `heat` int(2) DEFAULT NULL,
  `power` float DEFAULT NULL,
  `te9808` float DEFAULT NULL,
  `lux` float DEFAULT NULL,
  PRIMARY KEY (`gmtijd`,`port`),
  KEY `unixtime` (`unixtime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;

CREATE TABLE IF NOT EXISTS `sensors_th` (
  `utctime` datetime NOT NULL,
  `unixtime` int(12) DEFAULT NULL,
  `source` varchar(16) DEFAULT NULL,
  `dht11te` float DEFAULT NULL,
  `dht11hu` float DEFAULT NULL,
  `dht21te` float DEFAULT NULL,
  `dht21hu` float DEFAULT NULL,
  `dht22te` float DEFAULT NULL,
  `dht22hu` float DEFAULT NULL,
  `am2320te` float DEFAULT NULL,
  `am2320hu` float DEFAULT NULL,
  `bme280te` float DEFAULT NULL,
  `bme280hu` float DEFAULT NULL,
  `bme280pr` float DEFAULT NULL,
  `si7021te0` float DEFAULT NULL,
  `si7021hu0` float DEFAULT NULL,
  `si7021te1` float DEFAULT NULL,
  `si7021hu1` float DEFAULT NULL,
  `si7021te2` float DEFAULT NULL,
  `si7021hu2` float DEFAULT NULL,
  `si7021te3` float DEFAULT NULL,
  `si7021hu3` float DEFAULT NULL,
  `mcp9808te` float DEFAULT NULL,
  `apds9301lu` float DEFAULT NULL,
  PRIMARY KEY (`utctime`),
  KEY `unixtime` (`unixtime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;
