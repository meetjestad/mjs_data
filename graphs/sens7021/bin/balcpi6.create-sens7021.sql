CREATE TABLE `sens7021` (
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
