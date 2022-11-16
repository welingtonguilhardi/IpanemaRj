-- --------------------------------------------------------
-- Servidor:                     127.0.0.1
-- Versão do servidor:           10.4.22-MariaDB - mariadb.org binary distribution
-- OS do Servidor:               Win64
-- HeidiSQL Versão:              11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Copiando estrutura do banco de dados para vrp
CREATE DATABASE IF NOT EXISTS `xamaclean` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `xamaclean`;
-- Copiando estrutura para tabela vrp.suricato_robbery_history
CREATE TABLE IF NOT EXISTS `suricato_robbery_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `winner` varchar(255) DEFAULT NULL,
  `duration` int(11) DEFAULT NULL,
  `killfeed` varchar(10000) DEFAULT NULL,
  `time` bigint(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=145 DEFAULT CHARSET=utf8mb4;

-- Copiando dados para a tabela vrp.suricato_robbery_history: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `suricato_robbery_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `suricato_robbery_history` ENABLE KEYS */;

-- Copiando estrutura para tabela vrp.suricato_robbery_presets
CREATE TABLE IF NOT EXISTS `suricato_robbery_presets` (
  `name` varchar(255) NOT NULL,
  `awarddarkmoney` tinyint(1) NOT NULL DEFAULT 0,
  `awardmin` int(11) NOT NULL DEFAULT 0,
  `awardmax` int(11) NOT NULL DEFAULT 0,
  `minigame` tinyint(11) NOT NULL DEFAULT 0,
  `animation` varchar(100) DEFAULT '',
  `animationtime` int(11) DEFAULT 0,
  `projection` longtext NOT NULL DEFAULT '[]',
  `permission` varchar(255) DEFAULT '',
  `items` longtext DEFAULT '[]',
  `iswanted` tinyint(1) DEFAULT 0,
  `cooldown` int(11) DEFAULT 0,
  PRIMARY KEY (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Copiando dados para a tabela vrp.suricato_robbery_presets: ~1 rows (aproximadamente)
/*!40000 ALTER TABLE `suricato_robbery_presets` DISABLE KEYS */;
INSERT INTO `suricato_robbery_presets` (`name`, `awarddarkmoney`, `awardmin`, `awardmax`, `minigame`, `animation`, `animationtime`, `projection`, `permission`, `items`, `iswanted`, `cooldown`) VALUES
	('Arthur Teste', 1, 100, 1000, 0, '', 0, '[{"disable":true,"hostages":1,"cops":"1"},{"disable":true,"hostages":0,"cops":1},{"disable":true,"hostages":0,"cops":1}]', '', '[{"name":"lockpick","amount":"1"}]', 0, 0);
/*!40000 ALTER TABLE `suricato_robbery_presets` ENABLE KEYS */;

-- Copiando estrutura para tabela vrp.suricato_roberry_points
CREATE TABLE IF NOT EXISTS `suricato_roberry_points` (
  `count` int(11) NOT NULL AUTO_INCREMENT,
  `preset` varchar(50) NOT NULL,
  `cds` varchar(255) NOT NULL,
  PRIMARY KEY (`count`),
  KEY `FK_suricato_roberry_points_suricato_robbery_presets` (`preset`),
  CONSTRAINT `FK_suricato_roberry_points_suricato_robbery_presets` FOREIGN KEY (`preset`) REFERENCES `suricato_robbery_presets` (`name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8mb4;

-- Copiando dados para a tabela vrp.suricato_roberry_points: ~1 rows (aproximadamente)
/*!40000 ALTER TABLE `suricato_roberry_points` DISABLE KEYS */;
INSERT INTO `suricato_roberry_points` (`count`, `preset`, `cds`) VALUES
	(57, 'Arthur Teste', '{"z":19.21559333801269,"y":-904.1905517578125,"x":-709.5292358398438}');
/*!40000 ALTER TABLE `suricato_roberry_points` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
