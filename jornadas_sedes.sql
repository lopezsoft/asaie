-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         10.2.10-MariaDB-log - mariadb.org binary distribution
-- SO del servidor:              Win64
-- HeidiSQL Versión:             9.5.0.5433
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Volcando estructura para tabla sme.jornadas_sedes
CREATE TABLE IF NOT EXISTS `jornadas_sedes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_sede` int(11) NOT NULL,
  `id_jornada` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_jornada_sede` (`id_jornada`,`id_sede`),
  KEY `id_sede` (`id_sede`),
  KEY `id_jornada` (`id_jornada`),
  CONSTRAINT `FK_jornadas_sedes_jornadas` FOREIGN KEY (`id_jornada`) REFERENCES `jornadas` (`cod_jorn`) ON UPDATE CASCADE,
  CONSTRAINT `FK_jornadas_sedes_sedes` FOREIGN KEY (`id_sede`) REFERENCES `sedes` (`ID`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla sme.jornadas_sedes: ~3 rows (aproximadamente)
/*!40000 ALTER TABLE `jornadas_sedes` DISABLE KEYS */;
INSERT INTO `jornadas_sedes` (`id`, `id_sede`, `id_jornada`) VALUES
	(1, 1, 1),
	(2, 1, 2),
	(3, 1, 3);
/*!40000 ALTER TABLE `jornadas_sedes` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;

