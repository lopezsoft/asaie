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

-- Volcando estructura para tabla sme.niveles_sedes
CREATE TABLE IF NOT EXISTS `niveles_sedes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_sede` int(30) NOT NULL,
  `id_nivel` int(30) NOT NULL,
  `estado` int(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_Nivel_Sede` (`id_nivel`,`id_sede`),
  KEY `K_id_sede` (`id_sede`),
  KEY `K_id_nivel` (`id_nivel`),
  CONSTRAINT `FK_niveles_sedes_niveles_estudio` FOREIGN KEY (`id_nivel`) REFERENCES `niveles_estudio` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_niveles_sedes_sedes` FOREIGN KEY (`id_sede`) REFERENCES `sedes` (`ID`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla sme.niveles_sedes: ~4 rows (aproximadamente)
/*!40000 ALTER TABLE `niveles_sedes` DISABLE KEYS */;
INSERT INTO `niveles_sedes` (`id`, `id_sede`, `id_nivel`, `estado`) VALUES
	(1, 1, 1, 1),
	(2, 1, 2, 1),
	(3, 1, 3, 1),
	(4, 1, 4, 1);
/*!40000 ALTER TABLE `niveles_sedes` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
