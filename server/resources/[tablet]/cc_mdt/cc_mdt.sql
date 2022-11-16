CREATE TABLE IF NOT EXISTS `cc_perfil` (
  `user_id` int(11) NOT NULL,
  `senha` varchar(30) NOT NULL,
  `image` varchar(256) NOT NULL DEFAULT 'images/profile.png' COLLATE 'utf8mb4_unicode_ci',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=LATIN1;

CREATE TABLE IF NOT EXISTS `cc_comunicados` (
  `token` int NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `mensagem` varchar(255) NOT NULL,
  PRIMARY KEY (`token`),
  CONSTRAINT `fk_cc_perfil_comunicados` FOREIGN KEY (`user_id`) REFERENCES `cc_perfil` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=LATIN1;

CREATE TABLE IF NOT EXISTS `cc_boletim` (
  `token` int NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `nuser_id` int(11) NOT NULL,
  `image` varchar(256) NOT NULL DEFAULT 'images/profile.png' COLLATE 'utf8mb4_unicode_ci',
  `tempo` int NOT NULL,
  `multa` int NOT NULL,
  `fianca` int NOT NULL,
  `descricao` varchar(255) NULL,
  `info` JSON NOT NULL,
  `status` varchar(255) NOT NULL DEFAULT 'Aberto',
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=LATIN1;