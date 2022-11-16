-- --------------------------------------------------------
-- Servidor:                     127.0.0.1
-- Versão do servidor:           10.4.21-MariaDB - mariadb.org binary distribution
-- OS do Servidor:               Win64
-- HeidiSQL Versão:              11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Copiando estrutura do banco de dados para zirix

CREATE DATABASE IF NOT EXISTS `xamaclean` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `xamaclean`;

-- Copiando estrutura para tabela zirix.mrlt_hp_consultas
DROP TABLE IF EXISTS `mrlt_hp_consultas`;
CREATE TABLE IF NOT EXISTS `mrlt_hp_consultas` (
  `c_id` int(11) NOT NULL AUTO_INCREMENT,
  `c_user_id` int(11) NOT NULL,
  `c_esp` varchar(255) NOT NULL,
  `c_date` longtext NOT NULL,
  `c_status` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`c_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela zirix.mrlt_hp_data
DROP TABLE IF EXISTS `mrlt_hp_data`;
CREATE TABLE IF NOT EXISTS `mrlt_hp_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `author` varchar(255) NOT NULL DEFAULT '',
  `ocorrencia` text CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `datahora` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`,`user_id`) USING BTREE,
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela zirix.mrlt_hp_fotos
DROP TABLE IF EXISTS `mrlt_hp_fotos`;
CREATE TABLE IF NOT EXISTS `mrlt_hp_fotos` (
  `user_id` int(11) NOT NULL,
  `imageUrl` varchar(255) NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Exportação de dados foi desmarcado.

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
