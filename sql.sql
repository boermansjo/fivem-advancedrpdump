-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.1.22-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             9.4.0.5125
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Dumping database structure for gta5_script_carshop
CREATE DATABASE IF NOT EXISTS `gta5_script_carshop` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `gta5_script_carshop`;

-- Dumping structure for table gta5_script_carshop.vehicles
CREATE TABLE IF NOT EXISTS `vehicles` (
  `owner` varchar(50) DEFAULT NULL,
  `model` varchar(50) DEFAULT NULL,
  `colour` varchar(50) DEFAULT NULL,
  `scolour` varchar(50) DEFAULT NULL,
  `plate` varchar(50) DEFAULT NULL,
  `wheels` int(11) DEFAULT NULL,
  `windows` int(11) DEFAULT NULL,
  `platetype` int(11) DEFAULT NULL,
  `exhausts` int(11) DEFAULT NULL,
  `grills` int(11) DEFAULT NULL,
  `spoiler` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping database structure for gta5_script_customization
CREATE DATABASE IF NOT EXISTS `gta5_script_customization` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `gta5_script_customization`;

-- Dumping structure for table gta5_script_customization.outfits
CREATE TABLE IF NOT EXISTS `outfits` (
  `identifier` varchar(50) DEFAULT NULL,
  `hair` int(11) DEFAULT NULL,
  `haircolour` int(11) DEFAULT NULL,
  `torso` int(11) DEFAULT NULL,
  `torsotexture` int(11) DEFAULT NULL,
  `torsoextra` int(11) DEFAULT NULL,
  `torsoextratexture` int(11) DEFAULT NULL,
  `pants` int(11) DEFAULT NULL,
  `pantscolour` int(11) DEFAULT NULL,
  `shoes` int(11) DEFAULT NULL,
  `shoescolour` int(11) DEFAULT NULL,
  `bodyaccesoire` int(11) DEFAULT NULL,
  `undershirt` int(11) DEFAULT NULL,
  `armor` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping database structure for gta5_script_stats
CREATE DATABASE IF NOT EXISTS `gta5_script_stats` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `gta5_script_stats`;

-- Dumping structure for table gta5_script_stats.users
CREATE TABLE IF NOT EXISTS `users` (
  `identifier` varchar(50) DEFAULT NULL,
  `playtime` double DEFAULT NULL,
  `shotsfired` double DEFAULT NULL,
  `kmdriven` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping database structure for gta5_script_turfs
CREATE DATABASE IF NOT EXISTS `gta5_script_turfs` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `gta5_script_turfs`;

-- Dumping structure for table gta5_script_turfs.turfs
CREATE TABLE IF NOT EXISTS `turfs` (
  `identifier` varchar(50) DEFAULT NULL,
  `SANDY` tinyint(4) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping database structure for gta5_script_weaponshop
CREATE DATABASE IF NOT EXISTS `gta5_script_weaponshop` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `gta5_script_weaponshop`;

-- Dumping structure for table gta5_script_weaponshop.owned
CREATE TABLE IF NOT EXISTS `owned` (
  `identifier` varchar(50) DEFAULT NULL,
  `weapon` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
