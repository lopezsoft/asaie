
/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Volcando estructura para disparador sme.acta_promocion_before_update

DROP TRIGGER IF EXISTS `acta_promocion_before_update`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `acta_promocion_before_update` BEFORE UPDATE ON `acta_promocion` FOR EACH ROW BEGIN
	DECLARE result VARCHAR(250) DEFAULT '';
	DECLARE _id_inst, _cod_grado INT(20) DEFAULT 0;
			
	IF NEW.prom_comision = 1 THEN
		SELECT id_grado, id_inst INTO _cod_grado, _id_inst 
		FROM matriculas WHERE id_matric = NEW.id_matric;
		
		SELECT estado_estudiante_normal(1, _cod_grado, _id_inst) INTO result;
		SET NEW.msg = result;
	END IF;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador sme.administrativos_before_insert
DROP TRIGGER IF EXISTS `administrativos_before_insert`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `administrativos_before_insert` BEFORE INSERT ON `administrativos` FOR EACH ROW BEGIN
	IF NEW.fecha_nacimiento = '0000-00-00' THEN 
		SET NEW.fecha_nacimiento = '1980-01-01';
	END IF;
	SET NEW.apellido1 	= UPPER(NEW.apellido1);
	SET NEW.apellido2 	= UPPER(NEW.apellido2);
	SET NEW.nombre1	  	= UPPER(NEW.nombre1);
	SET NEW.nombre2	  	= UPPER(NEW.nombre2);
	SET NEW.edad			= FLOOR(TIMESTAMPDIFF(YEAR, NEW.fecha_nacimiento, CURDATE()));
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador sme.administrativos_before_update
DROP TRIGGER IF EXISTS `administrativos_before_update`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `administrativos_before_update` BEFORE UPDATE ON `administrativos` FOR EACH ROW BEGIN
	IF NEW.fecha_nacimiento = '0000-00-00' THEN 
		SET NEW.fecha_nacimiento = '1980-01-01';
	END IF;
	SET NEW.apellido1 	= UPPER(NEW.apellido1);
	SET NEW.apellido2 	= UPPER(NEW.apellido2);
	SET NEW.nombre1	  	= UPPER(NEW.nombre1);
	SET NEW.nombre2	  	= UPPER(NEW.nombre2);
	SET NEW.edad			= FLOOR(TIMESTAMPDIFF(YEAR, NEW.fecha_nacimiento, CURDATE()));
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador sme.areas_before_insert
DROP TRIGGER IF EXISTS `areas_before_insert`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `areas_before_insert` BEFORE INSERT ON `areas` FOR EACH ROW BEGIN
	SET NEW.area = UPPER(RTRIM(NEW.area));
	SET NEW.abrev= UPPER(RTRIM(NEW.abrev));
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador sme.areas_before_update
DROP TRIGGER IF EXISTS `areas_before_update`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `areas_before_update` BEFORE UPDATE ON `areas` FOR EACH ROW BEGIN
	SET NEW.area = UPPER(RTRIM(NEW.area));
	SET NEW.abrev= UPPER(RTRIM(NEW.abrev));
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador sme.areas_promocion_AFTER_INSERT
DROP TRIGGER IF EXISTS `areas_promocion_AFTER_INSERT`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `areas_promocion_AFTER_INSERT` AFTER INSERT ON `areas_promocion` FOR EACH ROW BEGIN
 	INSERT INTO grados_areas_promocion (id_area_promocion,cod_grado) 
	VALUES(NEW.id,'03');
	INSERT INTO grados_areas_promocion (id_area_promocion,cod_grado) 
	VALUES(NEW.id,'04');
	INSERT INTO grados_areas_promocion (id_area_promocion,cod_grado) 
	VALUES(NEW.id,'05');
	INSERT INTO grados_areas_promocion (id_area_promocion,cod_grado) 
	VALUES(NEW.id,'06');
	INSERT INTO grados_areas_promocion (id_area_promocion,cod_grado) 
	VALUES(NEW.id,'07');
	INSERT INTO grados_areas_promocion (id_area_promocion,cod_grado) 
	VALUES(NEW.id,'08');
	INSERT INTO grados_areas_promocion (id_area_promocion,cod_grado) 
	VALUES(NEW.id,'09');
	INSERT INTO grados_areas_promocion (id_area_promocion,cod_grado) 
	VALUES(NEW.id,'10');
	INSERT INTO grados_areas_promocion (id_area_promocion,cod_grado) 
	VALUES(NEW.id,'11');
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador sme.areas_promocion_BEFORE_DELETE
DROP TRIGGER IF EXISTS `areas_promocion_BEFORE_DELETE`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `areas_promocion_BEFORE_DELETE` BEFORE DELETE ON `areas_promocion` FOR EACH ROW BEGIN
	DELETE FROM grados_areas_promocion WHERE id_area_promocion =  OLD.id ;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador sme.asignaturas_before_insert
DROP TRIGGER IF EXISTS `asignaturas_before_insert`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `asignaturas_before_insert` BEFORE INSERT ON `asignaturas` FOR EACH ROW BEGIN
	SET NEW.asignatura 	= UPPER(RTRIM(NEW.asignatura));
	SET NEW.abrev			= UPPER(RTRIM(NEW.abrev));
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador sme.asignaturas_before_update
DROP TRIGGER IF EXISTS `asignaturas_before_update`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `asignaturas_before_update` BEFORE UPDATE ON `asignaturas` FOR EACH ROW BEGIN
	SET NEW.asignatura 	= UPPER(RTRIM(NEW.asignatura));
	SET NEW.abrev			= UPPER(RTRIM(NEW.abrev));
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador sme.docentes_before_insert
DROP TRIGGER IF EXISTS `docentes_before_insert`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `docentes_before_insert` BEFORE INSERT ON `docentes` FOR EACH ROW BEGIN
	SET NEW.apellido1 	= UPPER(NEW.apellido1);
	SET NEW.apellido2 	= UPPER(NEW.apellido2);
	SET NEW.nombre1	  	= UPPER(NEW.nombre1);
	SET NEW.nombre2	  	= UPPER(NEW.nombre2);
	SET NEW.edad			= FLOOR(TIMESTAMPDIFF(YEAR, NEW.fec_nac, CURDATE()));
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador sme.docentes_before_update
DROP TRIGGER IF EXISTS `docentes_before_update`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `docentes_before_update` BEFORE UPDATE ON `docentes` FOR EACH ROW BEGIN
	IF NEW.fec_nac = '0000-00-00' THEN 
		SET NEW.fec_nac = '1980-01-01';
	END IF;
	SET NEW.apellido1 	= UPPER(NEW.apellido1);
	SET NEW.apellido2 	= UPPER(NEW.apellido2);
	SET NEW.nombre1	  	= UPPER(NEW.nombre1);
	SET NEW.nombre2	  	= UPPER(NEW.nombre2);
	SET NEW.edad			= FLOOR(TIMESTAMPDIFF(YEAR, NEW.fec_nac, CURDATE()));	
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador sme.familiares_before_insert
DROP TRIGGER IF EXISTS `familiares_before_insert`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `familiares_before_insert` BEFORE INSERT ON `familiares` FOR EACH ROW BEGIN
	SET NEW.apellido1 = upper(new.apellido1);
	SET NEW.apellido2 = upper(new.apellido2);
	SET NEW.nombre1 = upper(new.nombre1);
	SET NEW.nombre2 = upper(new.nombre2);
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador sme.familiares_before_update
DROP TRIGGER IF EXISTS `familiares_before_update`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `familiares_before_update` BEFORE UPDATE ON `familiares` FOR EACH ROW BEGIN
	SET NEW.apellido1 = upper(new.apellido1);
	SET NEW.apellido2 = upper(new.apellido2);
	SET NEW.nombre1 = upper(new.nombre1);
	SET NEW.nombre2 = upper(new.nombre2);
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador sme.historial_material_educ_before_insert
DROP TRIGGER IF EXISTS `historial_material_educ_before_insert`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `historial_material_educ_before_insert` BEFORE INSERT ON `historial_material_educ` FOR EACH ROW BEGIN
	SET NEW.hora_apertura = CURRENT_TIMESTAMP();
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador sme.historial_material_educ_before_update
DROP TRIGGER IF EXISTS `historial_material_educ_before_update`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `historial_material_educ_before_update` BEFORE UPDATE ON `historial_material_educ` FOR EACH ROW BEGIN
	SET NEW.hora_cierre = CURRENT_TIMESTAMP();
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador sme.inscripciones_after_insert
DROP TRIGGER IF EXISTS `inscripciones_after_insert`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `inscripciones_after_insert` AFTER INSERT ON `inscripciones` FOR EACH ROW BEGIN
	INSERT INTO usuarios_estu (id_estudiante, nombre_usuario,password_u) 
	VALUES(NEW.cod_est,NEW.nro_doc_id,sha1(NEW.nro_doc_id));
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador sme.inscripciones_before_insert
DROP TRIGGER IF EXISTS `inscripciones_before_insert`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `inscripciones_before_insert` BEFORE INSERT ON `inscripciones` FOR EACH ROW BEGIN
	SET NEW.apellido1 	= UPPER(NEW.apellido1);
	SET NEW.apellido2 	= UPPER(NEW.apellido2);
	SET NEW.nombre1	  	= UPPER(NEW.nombre1);
	SET NEW.nombre2	  	= UPPER(NEW.nombre2);	
	SET NEW.edad			= FLOOR(TIMESTAMPDIFF(YEAR, NEW.fecha_nacimiento, CURDATE()));
	SET NEW.id_año			= CONCAT(NEW.cod_est,'-',YEAR(CURRENT_DATE()));
	SET NEW.fecha_insc	= CURRENT_DATE();
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador sme.inscripciones_before_update
DROP TRIGGER IF EXISTS `inscripciones_before_update`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `inscripciones_before_update` BEFORE UPDATE ON `inscripciones` FOR EACH ROW BEGIN
	IF NEW.fecha_nacimiento = '0000-00-00' THEN 
		SET NEW.fecha_nacimiento = '2010-01-01';
	END IF;
	SET NEW.apellido1 	= UPPER(NEW.apellido1);
	SET NEW.apellido2 	= UPPER(NEW.apellido2);
	SET NEW.nombre1	  	= UPPER(NEW.nombre1);
	SET NEW.nombre2	  	= UPPER(NEW.nombre2);
	SET NEW.edad			= FLOOR(TIMESTAMPDIFF(YEAR, NEW.fecha_nacimiento, CURDATE()));
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador sme.logros_estandares_before_delete
DROP TRIGGER IF EXISTS `logros_estandares_before_delete`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `logros_estandares_before_delete` BEFORE DELETE ON `logros_estandares` FOR EACH ROW BEGIN
	DELETE FROM log_nscp00  WHERE id_logro_estandar = OLD.id;
	DELETE FROM log_nscp001  WHERE id_logro_estandar = OLD.id;
	DELETE FROM log_nscp002  WHERE id_logro_estandar = OLD.id;
	DELETE FROM log_nscp003  WHERE id_logro_estandar = OLD.id;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador sme.material_educ_after_insert
DROP TRIGGER IF EXISTS `material_educ_after_insert`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `material_educ_after_insert` AFTER INSERT ON `material_educ` FOR EACH ROW BEGIN
	CALL sp_insert_material_educ_comp(NEW.id, NEW.id_curso);
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador sme.material_educ_before_delete
DROP TRIGGER IF EXISTS `material_educ_before_delete`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `material_educ_before_delete` BEFORE DELETE ON `material_educ` FOR EACH ROW BEGIN
	DELETE FROM historial_material_educ WHERE id_material = OLD.id;
	DELETE FROM material_educ_compartido WHERE id_material = OLD.id;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador sme.material_educ_before_insert
DROP TRIGGER IF EXISTS `material_educ_before_insert`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `material_educ_before_insert` BEFORE INSERT ON `material_educ` FOR EACH ROW BEGIN
	SET NEW.fecha =  CURDATE();
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador sme.matriculas_before_insert
DROP TRIGGER IF EXISTS `matriculas_before_insert`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `matriculas_before_insert` BEFORE INSERT ON `matriculas` FOR EACH ROW BEGIN
	DECLARE  _año, 
				_cant_est_x_libro,
				_cant_mat,
				_nro_mat,
				_n_libro,
				_id_inst INT DEFAULT 0;
	
	SET _año 		= NEW.año;
	SET _id_inst 	= NEW.id_inst;	
	SELECT cant_est_x_libro INTO _cant_est_x_libro FROM config001 AS t1
	LEFT JOIN grados_agrupados AS t2 ON t1.id_grupo_grados = t2.id
	LEFT JOIN aux_grados_agrupados AS t3 ON t3.id_grado_agrupado = t2.id
	LEFT JOIN grados AS tg ON t3.id_grado = tg.id 
	WHERE año = `_año` AND id_inst = _id_inst AND tg.id = NEW.id_grado LIMIT 1;
	SELECT COUNT(id_matric) INTO _cant_mat FROM matriculas WHERE año = `_año` AND id_inst = _id_inst; 
	SELECT nro_matricula INTO _nro_mat FROM matriculas 
	WHERE año = `_año` AND id_inst = _id_inst ORDER BY nro_matricula DESC LIMIT 1;
	
	IF _cant_mat > _cant_est_x_libro THEN
		SET _n_libro = CEILING(_cant_mat/_cant_est_x_libro);
	ELSE
		SET _n_libro = 1;
	END IF;
	
	SET NEW.id_folio 			= _nro_mat + 1;
	SET NEW.nro_matricula 	= _nro_mat + 1;
	SET NEW.libro_mat			= _n_libro;	
	IF NEW.fecha = '0000-00-00' THEN 
		SET NEW.fecha = CURDATE();
	END IF;	
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador sme.matriculas_before_update
DROP TRIGGER IF EXISTS `matriculas_before_update`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `matriculas_before_update` BEFORE UPDATE ON `matriculas` FOR EACH ROW BEGIN
	IF NEW.fecha = '0000-00-00' THEN 
		SET NEW.fecha = CURDATE();
	END IF;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador sme.nscp001_after_insert
DROP TRIGGER IF EXISTS `nscp001_after_insert`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `nscp001_after_insert` AFTER INSERT ON `nscp001` FOR EACH ROW BEGIN
	INSERT IGNORE INTO nscp001_promedio_notas (id_curso,id_matric) VALUES (NEW.id_curso,NEW.id_matric);
	INSERT IGNORE INTO preinforme_nscp001(id_nota) VALUES (NEW.id);
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador sme.nscp001_after_update
DROP TRIGGER IF EXISTS `nscp001_after_update`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `nscp001_after_update` AFTER UPDATE ON `nscp001` FOR EACH ROW BEGIN	
	DECLARE 
		_id_grado,
		_decimal,
		_prom
		INT(30) DEFAULT 0;
   SELECT id_grado INTO _id_grado FROM cursos WHERE id=NEW.id_curso LIMIT 1;
	
	SELECT t.Ndecimales, t.promocion INTO _decimal, _prom FROM config001 AS t 
	LEFT JOIN grados_agrupados AS t2 ON t.id_grupo_grados = t2.id
	LEFT JOIN aux_grados_agrupados AS t3 ON t3.id_grado_agrupado = t2.id
	LEFT JOIN grados AS tg ON t3.id_grado = tg.id 
	WHERE año = NEW.año AND id_inst = NEW.id_inst AND tg.id = _id_grado LIMIT 1;
	
	IF NEW.periodo > '1' THEN 
		UPDATE nscp001_promedio_notas SET prom = 
		(SELECT ROUND(AVG(IF(tn.nota_habilitacion > 0, tn.nota_habilitacion, tn.final)),_decimal) 
		FROM nscp001 AS tn WHERE tn.id_curso = NEW.id_curso AND tn.id_matric = NEW.id_matric
		AND tn.final >= 0
		GROUP BY tn.id_curso, tn.id_matric) WHERE id_curso = NEW.id_curso AND id_matric= NEW.id_matric LIMIT 1;
	ELSE
		UPDATE nscp001_promedio_notas SET prom = NEW.final WHERE id_curso = NEW.id_curso AND id_matric= NEW.id_matric LIMIT 1;
	END IF;
	CALL sp_consolidado_areas(NEW.id_matric, NEW.periodo);
	CALL sp_consolidado_asignaturas(NEW.id_matric, NEW.periodo);	
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador sme.nscp002_after_insert
DROP TRIGGER IF EXISTS `nscp002_after_insert`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `nscp002_after_insert` AFTER INSERT ON `nscp002` FOR EACH ROW BEGIN
	INSERT IGNORE INTO nscp002_promedio_notas (id_curso,id_matric) VALUES (NEW.id_curso,NEW.id_matric);
	INSERT IGNORE INTO preinforme_nscp002(id_nota) VALUES (NEW.id);
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador sme.nscp002_after_update
DROP TRIGGER IF EXISTS `nscp002_after_update`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `nscp002_after_update` AFTER UPDATE ON `nscp002` FOR EACH ROW BEGIN
	DECLARE 
		_id_grado,
		_decimal,
		_prom
		INT(30) DEFAULT 0;
	SELECT id_grado INTO _id_grado FROM cursos WHERE id=NEW.id_curso LIMIT 1;
	
	SELECT t.Ndecimales, t.promocion INTO _decimal, _prom FROM config001 AS t 
	LEFT JOIN grados_agrupados AS t2 ON t.id_grupo_grados = t2.id
	LEFT JOIN aux_grados_agrupados AS t3 ON t3.id_grado_agrupado = t2.id
	LEFT JOIN grados AS tg ON t3.id_grado = tg.id 
	WHERE año = NEW.año AND id_inst = NEW.id_inst AND tg.id = _id_grado LIMIT 1;
	IF NEW.periodo > '1' THEN 
		UPDATE nscp002_promedio_notas SET prom = 
		(SELECT ROUND(AVG(IF(tn.nota_habilitacion > 0, tn.nota_habilitacion, tn.final)),_decimal) 
		FROM nscp002 AS tn WHERE tn.id_curso = NEW.id_curso AND tn.id_matric = NEW.id_matric
		AND tn.final >= 0
		GROUP BY tn.id_curso, tn.id_matric) WHERE id_curso = NEW.id_curso AND id_matric= NEW.id_matric LIMIT 1;
	ELSE
		UPDATE nscp002_promedio_notas SET prom = NEW.final WHERE id_curso = NEW.id_curso AND id_matric= NEW.id_matric LIMIT 1;
	END IF;
	CALL sp_consolidado_areas(NEW.id_matric, NEW.periodo);
	CALL sp_consolidado_asignaturas(NEW.id_matric, NEW.periodo);
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador sme.nscp003_after_insert
DROP TRIGGER IF EXISTS `nscp003_after_insert`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `nscp003_after_insert` AFTER INSERT ON `nscp003` FOR EACH ROW BEGIN
	INSERT IGNORE INTO nscp003_promedio_notas (id_curso,id_matric) VALUES (NEW.id_curso,NEW.id_matric);
	INSERT IGNORE INTO preinforme_nscp003(id_nota) VALUES (NEW.id);
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador sme.nscp003_after_update
DROP TRIGGER IF EXISTS `nscp003_after_update`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `nscp003_after_update` AFTER UPDATE ON `nscp003` FOR EACH ROW BEGIN
		DECLARE 
		_id_grado,
		_decimal,
		_prom
		INT(30) DEFAULT 0;
	SELECT id_grado INTO _id_grado FROM cursos WHERE id=NEW.id_curso LIMIT 1;
	
	SELECT t.Ndecimales, t.promocion INTO _decimal, _prom FROM config001 AS t 
	LEFT JOIN grados_agrupados AS t2 ON t.id_grupo_grados = t2.id
	LEFT JOIN aux_grados_agrupados AS t3 ON t3.id_grado_agrupado = t2.id
	LEFT JOIN grados AS tg ON t3.id_grado = tg.id 
	WHERE año = NEW.año AND id_inst = NEW.id_inst AND tg.id = _id_grado LIMIT 1;
	IF NEW.periodo > '1' THEN 
		UPDATE nscp003_promedio_notas SET prom = 
		(SELECT ROUND(AVG(IF(tn.nota_habilitacion > 0, tn.nota_habilitacion, tn.final)),_decimal) 
		FROM nscp003 AS tn WHERE tn.id_curso = NEW.id_curso AND tn.id_matric = NEW.id_matric
		AND tn.final >= 0
		GROUP BY tn.id_curso, tn.id_matric) WHERE id_curso = NEW.id_curso AND id_matric= NEW.id_matric LIMIT 1;
	ELSE
		UPDATE nscp003_promedio_notas SET prom = NEW.final WHERE id_curso = NEW.id_curso AND id_matric= NEW.id_matric LIMIT 1;
	END IF;
	CALL sp_consolidado_areas(NEW.id_matric, NEW.periodo);
	CALL sp_consolidado_asignaturas(NEW.id_matric, NEW.periodo);
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador sme.nscp00_after_insert
DROP TRIGGER IF EXISTS `nscp00_after_insert`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `nscp00_after_insert` AFTER INSERT ON `nscp00` FOR EACH ROW BEGIN
	INSERT IGNORE INTO preinforme_nscp00(id_nota) VALUES (NEW.id);
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador sme.nscp00_before_delete
DROP TRIGGER IF EXISTS `nscp00_before_delete`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `nscp00_before_delete` BEFORE DELETE ON `nscp00` FOR EACH ROW BEGIN
	DELETE FROM log_nscp00 WHERE id_nota = OLD.id;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador sme.promovidos_detalle_before_insert
DROP TRIGGER IF EXISTS `promovidos_detalle_before_insert`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `promovidos_detalle_before_insert` BEFORE INSERT ON `promovidos_detalle` FOR EACH ROW BEGIN
	SET NEW.titulo = CONCAT("INSTITUCIÓN EDUCATIVA\r\n\t\t\t\t\t\t\tMUNICIPIO - DPTO\r\n\t\t\t\t\t\t\tDANE: 000000000000\r\n\t\t\t\t\t\t\tNIT: 00000000");
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador sme.respeciales_before_insert
DROP TRIGGER IF EXISTS `respeciales_before_insert`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `respeciales_before_insert` BEFORE INSERT ON `respeciales` FOR EACH ROW BEGIN
	IF NEW.fecha = '0000-00-00' THEN 
		SET NEW.fecha = CURDATE();
	END IF;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador sme.respeciales_before_update
DROP TRIGGER IF EXISTS `respeciales_before_update`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `respeciales_before_update` BEFORE UPDATE ON `respeciales` FOR EACH ROW BEGIN
	IF NEW.fecha = '0000-00-00' THEN 
		SET NEW.fecha = CURDATE();
	END IF;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador sme.sugerencias_before_delete
DROP TRIGGER IF EXISTS `sugerencias_before_delete`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `sugerencias_before_delete` BEFORE DELETE ON `sugerencias` FOR EACH ROW BEGIN
	DELETE FROM sug_nscp00 WHERE id_sugerencia = OLD.id;
	DELETE FROM sug_nscp001 WHERE id_sugerencia = OLD.id;
	DELETE FROM sug_nscp002 WHERE id_sugerencia = OLD.id;
	DELETE FROM sug_nscp003 WHERE id_sugerencia = OLD.id;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador sme.te_evaluaciones_after_insert
DROP TRIGGER IF EXISTS `te_evaluaciones_after_insert`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `te_evaluaciones_after_insert` AFTER INSERT ON `te_evaluaciones` FOR EACH ROW BEGIN
	IF NEW.id_column_nota > 0 THEN 
		INSERT INTO te_conlumn_eval (id_evaluacion,columna) VALUES (NEW.id,NEW.id_column_nota);
		UPDATE configs_columns_docentes SET id_evaluacion = NEW.id WHERE id = NEW.id_column_nota; 
	END IF;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador sme.te_evaluaciones_after_update
DROP TRIGGER IF EXISTS `te_evaluaciones_after_update`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `te_evaluaciones_after_update` AFTER UPDATE ON `te_evaluaciones` FOR EACH ROW BEGIN
	IF NEW.id_column_nota > 0 AND OLD.id_column_nota = 0 THEN 
		INSERT INTO te_conlumn_eval (id_evaluacion,columna) VALUES (NEW.id,NEW.id_column_nota);
		UPDATE configs_columns_docentes SET id_evaluacion = NEW.id WHERE id = NEW.id_column_nota; 
	ELSEIF NEW.id_column_nota = 0 AND OLD.id_column_nota > 0 THEN 
		DELETE FROM te_conlumn_eval WHERE id_evaluacion = OLD.id AND columna = OLD.id_column_nota;
	ELSEIF NEW.id_column_nota <> OLD.id_column_nota THEN 
		UPDATE te_conlumn_eval SET id_evaluacion = NEW.id, columna = NEW.id_column_nota 
		WHERE id_evaluacion = OLD.id AND columna = OLD.id_column_nota; 
		UPDATE configs_columns_docentes SET id_evaluacion = NEW.id WHERE id = OLD.id_column_nota;
	END IF;
	
	IF NEW.publicada = 1 AND OLD.publicada = 0 THEN
	  	CALL sp_insert_evaluacion_compartida(NEW.id,NEW.id_curso);
	END IF;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador sme.te_evaluaciones_estudiantes_before_insert
DROP TRIGGER IF EXISTS `te_evaluaciones_estudiantes_before_insert`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `te_evaluaciones_estudiantes_before_insert` BEFORE INSERT ON `te_evaluaciones_estudiantes` FOR EACH ROW BEGIN
	SET NEW.hora_inicio	= CURRENT_TIMESTAMP();
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador sme.te_evaluaciones_estudiantes_before_update
DROP TRIGGER IF EXISTS `te_evaluaciones_estudiantes_before_update`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `te_evaluaciones_estudiantes_before_update` BEFORE UPDATE ON `te_evaluaciones_estudiantes` FOR EACH ROW BEGIN
	SET NEW.hora_final	= CURRENT_TIMESTAMP();
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador sme.te_preguntas_before_delete
DROP TRIGGER IF EXISTS `te_preguntas_before_delete`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `te_preguntas_before_delete` BEFORE DELETE ON `te_preguntas` FOR EACH ROW BEGIN
	DELETE FROM te_respuestas WHERE id_pregunta = OLD.id;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;


SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;


DELIMITER $$
DROP PROCEDURE IF EXISTS `sp_abre_areas__asig`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_abre_areas__asig` (IN `_id_inst` INT(20), IN `_año` YEAR, IN `_id_asig` INT(11), IN `_cod_grado` INT(11), IN `_type` INT(1))  BEGIN
	CASE 
		WHEN _type 	= 1 OR _type = 0 THEN /*Asignaturas Abrev*/
			SELECT RTRIM(ta.abrev) AS abrev FROM asignaturas AS ta WHERE ta.id_inst = _id_inst AND ta.id_pk = _id_asig;
		WHEN _type	= 2 THEN	/*Asignaturas Porcentaje*/
			SELECT tm.porciento FROM matcurso AS tm 
			LEFT JOIN asignaturas AS ta ON tm.id_asig = ta.id_pk 
			WHERE ta.id_inst = _id_inst AND ta.id_pk = _id_asig 
			AND tm.id_inst = _id_inst AND tm.id_asig = _id_asig AND tm.`año` = `_año`
			AND tm.id_grado = _cod_grado;
		ELSE
			SELECT RTRIM(ta.abrev) AS abrev FROM areas AS ta WHERE ta.id_inst = _id_inst AND ta.id = _id_asig;
	END CASE;
END$$

DROP PROCEDURE IF EXISTS `sp_acta_promo_estadistica`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_acta_promo_estadistica` (IN `_id_inst` INT(30), IN `_año` YEAR, IN `_type` INT)  BEGIN
	IF _type = 1 THEN /*Por grado*/
		SELECT SQL_SMALL_RESULT COUNT(ta.msg) total, ta.msg,tm.id_grado cod_grado,te.sexo,
			RTRIM(tg.grado) grado, RTRIM(ts.NOM_SEDE) sede
			FROM acta_promocion AS ta
			LEFT JOIN matriculas AS tm ON ta.id_matric = tm.id_matric 
			LEFT JOIN inscripciones AS te ON tm.cod_est = te.cod_est 
			LEFT JOIN grados tg ON tm.id_grado = tg.id 
			LEFT JOIN sedes AS ts ON tm.id_sede = ts.ID
			WHERE tm.id_estado = 2  AND tm.id_inst = _id_inst AND tm.`año`= `_año` 
			AND te.id_inst = _id_inst
			GROUP BY ta.msg,tm.id_grado,tm.id_sede,te.sexo
			ORDER BY tm.id_sede,ta.estado,tm.id_grado,te.sexo;
	ELSE /*Por grado, grupo y jornada*/
		SELECT SQL_SMALL_RESULT COUNT(ta.msg) total, ta.msg,tm.id_grado cod_grado,tm.grupo,te.sexo,
			RTRIM(tg.grado) grado, RTRIM(tj.JORNADA) jornada, RTRIM(ts.NOM_SEDE) sede
			FROM acta_promocion AS ta
			LEFT JOIN matriculas AS tm ON ta.id_matric = tm.id_matric 
			LEFT JOIN inscripciones AS te ON tm.cod_est = te.cod_est 
			LEFT JOIN grados tg ON tm.id_grado = tg.id
			LEFT JOIN jornadas AS tj ON tm.id_jorn = tj.cod_jorn 
			LEFT JOIN sedes AS ts ON tm.id_sede = ts.ID
			WHERE tm.id_estado = 2  AND tm.id_inst = _id_inst AND tm.`año`= `_año` 
			AND te.id_inst = _id_inst
			GROUP BY ta.msg,tm.id_grado,tm.grupo,tm.id_sede,tm.id_jorn,te.sexo
			ORDER BY tm.id_sede,ta.estado,tm.id_grado,te.sexo, tm.grupo;
	END IF;
END$$

DROP PROCEDURE IF EXISTS `sp_boletines_reportes`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_boletines_reportes` (IN `_id_inst` INT(20), IN `_id_sede` INT(20), IN `_cod_grado` INT(11), IN `_grupo` VARCHAR(2), IN `_id_jorn` INT(1), IN `_año` YEAR, IN `_periodo` VARCHAR(2), IN `_matric` INT(30))  BEGIN
	DECLARE cTable VARCHAR(30) DEFAULT '';
	CALL sp_puestos_generate(_cod_grado, _grupo, _id_jorn, _id_sede, _id_inst, _año, _periodo);
	SELECT fn_return_table_notas(_cod_grado) INTO cTable;	
	IF _matric > 0 THEN 
		SET  @sqlSelect = CONCAT("SELECT tn.id,tn.periodo, tn.id_curso , tn.id_inst, tn.id_matric,tn.id_escala,
				tn.nota_perdida, tn.nota_habilitacion, tn.final, tn.faltas,tn.retraso,tn.injustificadas, 
				tpr.descripcion_periodo AS periodo_des, 
				tcr.id_grado cod_grado, tcr.grupo, tcr.año, tcr.cod_jorn id_jorn, tcr.id_sede,
				tcr.id_asig, tcr.id_docente,
				CONCAT(RTRIM(te.apellido1),' ',RTRIM(te.apellido2),' ',
				RTRIM(te.nombre1),' ',RTRIM(te.nombre2)) AS estudiante , te.nro_doc_id, RTRIM(tar.area) AS area, tar.abrev AS abre_area,
				tar.ordenar AS order_ar, RTRIM(tas.asignatura) AS asignatura, tas.abrev AS abrev_asig, tas.electiva,
				tas.id_area cod_area, tas.ordenar AS order_as, CONCAT(RTRIM(td.apellido1),' ',RTRIM(td.apellido2),' ',
				RTRIM(td.nombre1),' ',RTRIM(td.nombre2)) as docente,RTRIM(ts.nom_sede) AS sede, tj.jornada, tg.grado,
				RIGHT(CONCAT('0000',tm.id_folio),4) id_folio, RIGHT(CONCAT('000000',tm.nro_matricula),6) nro_matricula, 
				tp.total, tp.puesto, tp.prom, tp.nota_max, tp.nota_min, RIGHT(CONCAT('0000',tm.libro_mat),4) libro_mat,  
				tes.estado_matricula estado_des, tm.id_estado estado, tc.ih, ABS(tc.porciento) AS porciento,
				round(if(tn.nota_habilitacion > 0, (tn.nota_habilitacion*tc.porciento)/100, (tn.final*tc.porciento)/100),2) AS 
				nota_p, tn.nivelacion, TRIM(es.nombre_escala) conceptual, tv.nombre_nivel
				FROM ",cTable," AS tn 
				LEFT JOIN cursos AS tcr ON (tn.id_curso=tcr.id AND tn.año=tcr.`año`)
				LEFT JOIN grados As tg ON tcr.id_grado = tg.id 
				LEFT JOIN periodos_academicos AS tpr ON (tn.periodo = tpr.periodo AND tn.año=tpr.`año`)
				LEFT JOIN grados_agrupados AS t1 ON tpr.id_grado_agrupado = t1.id 
				LEFT JOIN aux_grados_agrupados AS t2 ON t2.id_grado_agrupado = t1.id
				LEFT JOIN asignaturas AS tas ON tcr.id_asig = tas.id_pk
			   LEFT JOIN areas AS tar ON tas.id_area=tar.id 
				LEFT JOIN docentes AS td ON  tcr.id_docente = td.id_docente 
				LEFT JOIN sedes AS ts ON tcr.id_sede = ts.id
			   LEFT JOIN jornadas AS tj ON tcr.cod_jorn = tj.cod_jorn 
				LEFT JOIN matcurso AS tc ON (tc.id_grado = tg.id AND tc.id_asig = tas.id_pk)
			   LEFT JOIN puestos AS tp ON tp.id_matric = tn.id_matric 
			   LEFT JOIN matriculas AS tm on tn.id_matric = tm.id_matric
				LEFT JOIN inscripciones AS te ON tm.cod_est = te.cod_est
			   LEFT JOIN estado_matricula AS tes ON tm.id_estado = tes.id
			   LEFT JOIN escala_nacional AS es ON tn.id_escala=es.id
			   LEFT JOIN niveles_estudio AS tv ON tg.id_nivel = tv.id
				WHERE tm.id_estado= 2  AND tcr.cod_jorn=",_id_jorn,"  AND tcr.grupo = '",_grupo,"'  AND tcr.id_grado = '",_cod_grado,
				"' AND tcr.id_sede =", _id_sede," AND tcr.año= ",`_año`,
				" AND tm.id_inst =", _id_inst," AND te.id_inst = ",_id_inst," AND tas.id_inst = ",_id_inst,
				" AND tar.id_inst = ",_id_inst," AND td.id_inst = ",_id_inst," AND tc.id_inst = ",_id_inst,
				" AND tc.año = ",`_año`," AND  tn.final>=0 AND tn.periodo = '",_periodo,"' AND tn.id_matric=",_matric,
				" AND tp.periodo = '",_periodo,"' AND tpr.`año` =",`_año`," AND t2.id_grado = ",_cod_grado,"
				ORDER BY estudiante,tar.ordenar, tas.id_area,tas.id_pk;");
	ELSE 		
		SET  @sqlSelect = CONCAT("SELECT tn.id,tn.periodo, tn.id_curso, tn.id_inst, tn.id_matric,tn.id_escala,
				tn.nota_perdida, tn.nota_habilitacion, tn.final, tn.faltas,tn.retraso,tn.injustificadas, 
				tpr.descripcion_periodo AS periodo_des, 
				tcr.id_grado cod_grado, tcr.grupo, tcr.año, tcr.cod_jorn id_jorn, tcr.id_sede,
				tcr.id_asig, tcr.id_docente,
				CONCAT(RTRIM(te.apellido1),' ',RTRIM(te.apellido2),' ',
				RTRIM(te.nombre1),' ',RTRIM(te.nombre2)) AS estudiante , te.nro_doc_id, RTRIM(tar.area) AS area, tar.abrev AS abre_area,
				tar.ordenar AS order_ar, RTRIM(tas.asignatura) AS asignatura, tas.abrev AS abrev_asig, tas.electiva,
				tas.id_area cod_area, tas.ordenar AS order_as, CONCAT(RTRIM(td.apellido1),' ',RTRIM(td.apellido2),' ',
				RTRIM(td.nombre1),' ',RTRIM(td.nombre2)) as docente,RTRIM(ts.nom_sede) AS sede, tj.jornada, tg.grado,
				RIGHT(CONCAT('0000',tm.id_folio),4) id_folio, RIGHT(CONCAT('000000',tm.nro_matricula),6) nro_matricula, 
				tp.total, tp.puesto, tp.prom, tp.nota_max, tp.nota_min, RIGHT(CONCAT('0000',tm.libro_mat),4) libro_mat,  
				tes.estado_matricula estado_des, tm.id_estado estado, tc.ih, ABS(tc.porciento) AS porciento,
				round(if(tn.nota_habilitacion > 0, (tn.nota_habilitacion*tc.porciento)/100, (tn.final*tc.porciento)/100),2) AS 
				nota_p, tn.nivelacion, TRIM(es.nombre_escala) conceptual, tv.nombre_nivel
				FROM ",cTable," AS tn 
				LEFT JOIN cursos AS tcr ON (tn.id_curso=tcr.id AND tn.año=tcr.`año`)
				LEFT JOIN grados As tg ON tcr.id_grado = tg.id 
				LEFT JOIN periodos_academicos AS tpr ON (tn.periodo = tpr.periodo AND tn.año=tpr.`año`)
				LEFT JOIN grados_agrupados AS t1 ON tpr.id_grado_agrupado = t1.id 
				LEFT JOIN aux_grados_agrupados AS t2 ON t2.id_grado_agrupado = t1.id
				LEFT JOIN asignaturas AS tas ON tcr.id_asig = tas.id_pk
			   LEFT JOIN areas AS tar ON tas.id_area=tar.id 
				LEFT JOIN docentes AS td ON  tcr.id_docente = td.id_docente 
				LEFT JOIN sedes AS ts ON tcr.id_sede = ts.id
			   LEFT JOIN jornadas AS tj ON tcr.cod_jorn = tj.cod_jorn 
				LEFT JOIN matcurso AS tc ON (tc.id_grado = tg.id AND tc.id_asig = tas.id_pk)
			   LEFT JOIN puestos AS tp ON tp.id_matric = tn.id_matric 
			   LEFT JOIN matriculas AS tm on tn.id_matric = tm.id_matric
				LEFT JOIN inscripciones AS te ON tm.cod_est = te.cod_est
			   LEFT JOIN estado_matricula AS tes ON tm.id_estado = tes.id
			   LEFT JOIN escala_nacional AS es ON tn.id_escala=es.id
			   LEFT JOIN niveles_estudio AS tv ON tg.id_nivel = tv.id
				WHERE tm.id_estado= 2  AND tcr.cod_jorn=",_id_jorn,"  AND tcr.grupo = '",_grupo,"'  AND tcr.id_grado = '",_cod_grado,
				"' AND tcr.id_sede =", _id_sede," AND tcr.año= ",`_año`,
				" AND tm.id_inst =", _id_inst," AND te.id_inst = ",_id_inst," AND tas.id_inst = ",_id_inst,
				" AND tar.id_inst = ",_id_inst," AND td.id_inst = ",_id_inst," AND tc.id_inst = ",_id_inst,
				" AND tc.año = ",`_año`," AND  tn.final>=0 AND tn.periodo = '",_periodo,
				"' AND tp.periodo = '",_periodo,"' AND tpr.`año` =",`_año`," AND t2.id_grado = ",_cod_grado,"
				ORDER BY estudiante,tar.ordenar, tas.id_area,tas.id_pk;");
	END IF;	
	PREPARE smtp FROM @sqlSelect;
	EXECUTE smtp;
	DEALLOCATE PREPARE smtp;
END$$

DROP PROCEDURE IF EXISTS `sp_carga_curso`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_carga_curso` (IN `_id_inst` INT(30), IN `_id_curso` INT(30), IN `_año` YEAR)  BEGIN
		SELECT tc.id,tc.id_grado cod_grado, UPPER(tg.grado) grado, tc.grupo, tc.id_asig , 
		TRIM(ta.asignatura) asignatura, tc.id_sede,tc.id_inst,tc.id_docente, 
		TRIM(ts.nom_sede) AS sede , tc.cod_jorn, TRIM(tj.jornada) AS jornada, 
		tc.año, tmc.proc1, tmc.proc2, tmc.proc3, tmc.proc4, te.NOMBRE_IE, RTRIM(tar.area) area,
		CONCAT(RTRIM(td.apellido1),' ',RTRIM(td.apellido2),' ',RTRIM(td.nombre1),' ',RTRIM(td.nombre2)) docente
		FROM cursos as tc
		LEFT JOIN grados AS tg ON tc.id_grado = tg.id  
		LEFT JOIN asignaturas AS ta ON tc.id_asig = ta.id_pk  
		LEFT JOIN sedes AS ts ON tc.id_sede = ts.ID  
		LEFT JOIN jornadas AS tj ON tc.cod_jorn = tj.cod_jorn 
		LEFT JOIN matcurso AS tmc ON (tmc.id_asig = ta.id_pk AND tmc.id_grado = tg.id)
		LEFT JOIN docentes AS td ON tc.id_docente = td.id_docente
		LEFT JOIN establecimiento AS te ON tc.id_inst = te.ID 
		LEFT JOIN areas AS tar ON ta.id_area = tar.id
		WHERE tc.estado=1 AND tc.id = _id_curso AND tc.id_inst = _id_inst 
		AND ta.id_inst =_id_inst AND ts.id_inst=_id_inst AND tmc.año=_año AND tmc.id_inst=_id_inst
		AND td.id_inst = _id_inst AND td.`año` = `_año` AND tar.id_inst = _id_inst
		AND te.ID = _id_inst;
END$$

DROP PROCEDURE IF EXISTS `sp_carga_docente`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_carga_docente` (IN `_id_inst` INT(20), IN `_id_docente` INT(30), IN `_año` YEAR, IN `query` VARCHAR(50))  BEGIN
	if RTRIM(`query`) = '' then 
		SELECT tm.id,tm.id_grado, UPPER(tg.grado) AS grado, tm.grupo, tm.id_asig , 
		TRIM(ta.asignatura) as asignatura, tm.id_sede, TRIM(ts.nom_sede) AS sede , tm.cod_jorn, 
		TRIM(tj.jornada) AS jornada, tm.id_docente, tm.año,	tmc.proc1, tmc.proc2, tmc.proc3, 
		tmc.proc4, tg.id_nivel FROM cursos as tm,grados as tg, asignaturas as ta, sedes as ts, 
		jornadas as tj, matcurso AS tmc WHERE tm.id_grado=tg.id AND tmc.id_grado=tg.id AND 
		(tm.id_asig=ta.id_pk AND tmc.id_asig=ta.id_pk) 
		AND tm.id_sede=ts.id AND tm.estado=1 AND tm.cod_jorn=tj.cod_jorn AND 
		tm.id_docente=_id_docente AND tm.año=_año  AND tm.id_inst=_id_inst 
		AND ta.id_inst =_id_inst AND ts.id_inst=_id_inst AND tmc.año=_año AND tmc.id_inst=_id_inst 
      ORDER BY tm.id_grado, tm.id_asig, tm.grupo;
    else
		SELECT tm.id,tm.id_grado, UPPER(tg.grado) AS grado, tm.grupo, tm.id_asig , 
		TRIM(ta.asignatura) as asignatura, tm.id_sede, TRIM(ts.nom_sede) AS sede , tm.cod_jorn, 
		TRIM(tj.jornada) AS jornada, tm.id_docente, tm.año,	tmc.proc1, tmc.proc2, tmc.proc3, 
		tmc.proc4, tg.id_nivel FROM cursos as tm,grados as tg, asignaturas as ta, sedes as ts, 
		jornadas as tj, matcurso AS tmc 
		WHERE tm.id_grado=tg.id AND tmc.id_grado=tg.id AND 
		(tm.id_asig=ta.id_pk AND tmc.id_asig=ta.id_pk) AND	tm.id_sede=ts.id AND tm.estado=1 AND 
		tm.cod_jorn=tj.cod_jorn AND tm.id_docente=_id_docente AND ta.año=_año AND tm.año=_año  
		AND tm.id_inst=_id_inst AND ta.id_inst =_id_inst AND ts.id_inst=_id_inst AND tmc.año=_año 
		AND tmc.id_inst=_id_inst AND RTRIM(UPPER(ta.asignatura)) REGEXP UPPER(`query`) 
      ORDER BY tm.id_grado,tm.id_asig, tm.grupo;
    end if;
END$$

DROP PROCEDURE IF EXISTS `sp_carga_docente_agrupada`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_carga_docente_agrupada` (IN `_id_inst` INT(20), IN `_id_docente` INT(30), IN `_año` YEAR, IN `_type` INT(1))  BEGIN
	IF _type > 0 THEN
		SELECT tm.id_grado,tm.grupo, tm.id_docente, tm.año,tm.cod_jorn, UPPER(tg.grado) AS grado, 
		tm.id_sede, TRIM(ts.nom_sede) AS sede, RTRIM(tj.JORNADA) jornada
		FROM cursos as tm 
		LEFT JOIN grados AS tg ON tm.id_grado = tg.id
		LEFT JOIN sedes AS ts ON tm.id_sede = ts.ID
		LEFT JOIN jornadas AS tj ON tm.cod_jorn = tj.cod_jorn
		WHERE tm.estado=1 AND tm.id_docente=_id_docente AND tm.año=_año 
		AND tm.id_inst=_id_inst AND ts.id_inst=_id_inst
      GROUP BY tm.id_grado, tm.grupo, tm.cod_jorn, tm.id_sede, tm.id_docente, tm.año
      ORDER BY tm.id_grado, tm.grupo, tm.cod_jorn;
	ELSE 
		SELECT tm.id_grado, tm.id_docente, tm.año, UPPER(tg.grado) AS grado, 
		tm.id_asig , ta.asignatura, tm.id_sede, TRIM(ts.nom_sede) AS sede 
		FROM cursos as tm 
		LEFT JOIN grados AS tg ON tm.id_grado = tg.id 
		LEFT JOIN asignaturas AS ta ON tm.id_asig = ta.id_pk
		LEFT JOIN sedes AS ts ON tm.id_sede = ts.ID
		WHERE tm.estado=1 AND tm.id_docente=_id_docente 
      AND tm.año=_año AND tm.id_inst=_id_inst 
		AND ta.id_inst=_id_inst AND ts.id_inst=_id_inst
      GROUP BY tm.id_grado, tm.id_asig, tm.id_sede, tm.id_docente, tm.año
      ORDER BY tm.id_grado, tm.id_asig;
   END IF;
END$$

DROP PROCEDURE IF EXISTS `sp_carga_docente_grupo`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_carga_docente_grupo` (IN `_id_inst` INT(20), IN `_id_docente` INT(20), IN `_año` YEAR, IN `_limit` TINYINT, IN `_min` INT(6), IN `_max` INT(6))  BEGIN
	if _limit = 1 then 
		SELECT tm.cod_grado, UPPER(tg.grado) AS grado, tm.id_asig , ta.asignatura, 
		tm.id_sede, TRIM(ts.nom_sede) AS sede , tm.id_docente, tm.año FROM cursos as tm, 
		grados as tg, asignaturas as ta, sedes as ts where tm.cod_grado=tg.cod_grado AND 
        tm.id_asig=ta.id AND tm.id_sede=ts.id AND tm.estado=1 AND tm.id_docente=_id_docente 
        AND ta.año=_año AND tm.año=_año AND tm.id_inst=_id_inst AND ta.id_inst=_id_inst 
		AND ts.id_inst=_id_inst
        GROUP BY tm.cod_grado, tm.id_asig, tm.id_sede, tm.id_docente, tm.año
        ORDER BY tm.cod_grado, tm.id_asig limit _min, _max;
    else
		SELECT tm.cod_grado, UPPER(tg.grado) AS grado, tm.id_asig , ta.asignatura, 
		tm.id_sede, TRIM(ts.nom_sede) AS sede , tm.id_docente, tm.año FROM cursos as tm, 
		grados as tg, asignaturas as ta, sedes as ts where tm.cod_grado=tg.cod_grado AND 
        tm.id_asig=ta.id AND tm.id_sede=ts.id AND tm.estado=1 AND tm.id_docente=_id_docente 
        AND ta.año=_año AND tm.año=_año AND tm.id_inst=_id_inst AND ta.id_inst=_id_inst 
		AND ts.id_inst=_id_inst
        GROUP BY tm.cod_grado, tm.id_asig, tm.id_sede, tm.id_docente, tm.año
        ORDER BY tm.cod_grado, tm.id_asig;
    end if;
END$$

DROP PROCEDURE IF EXISTS `sp_cert_final`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_cert_final` (IN `_id_inst` INT(30), IN `_año` YEAR, IN `_id_matric` INT(30), IN `_type` INT)  BEGIN
	SELECT fn_cert_final_estudio(_id_inst, _año, _id_matric, _type);
END$$

DROP PROCEDURE IF EXISTS `sp_consolidado_areas`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_consolidado_areas` (IN `_id_matric` INT(30), IN `_periodo` VARCHAR(2))  BEGIN
	DECLARE 	done,
				_id_inst,
				_año,
				_cod_area,
				x_count,
				x_count_2,
				_id_area_n,
				x_id_matric,
				_ndecim,
				x_cant_asig_perdidas,
				_cod_grado INT(30) DEFAULT 0;
	DECLARE aa1,aa2,aa3,aa4,aa5,aa6,aa7,aa8,aa9,aa10,aa11,
							aa12,aa13,aa14,aa15,aa16,aa17,aa18,aa19,aa20,
							aa21,aa22,aa23,aa24,aa25,x_count_matcurso INT DEFAULT 0;
	DECLARE	_final,
				_suma,
				_desde DECIMAL(6,2) DEFAULT 0;
	DECLARE 	_grupo VARCHAR(2) DEFAULT '';
	DECLARE 	oStrimValue,
				sValue,
				yValue CHAR DEFAULT '';
	DECLARE cur_matcurso CURSOR FOR SELECT ta.id_area FROM matcurso AS tm 
				LEFT JOIN asignaturas AS ta ON tm.id_asig = ta.id_pk 
				WHERE tm.año = _año AND tm.id_grado = _cod_grado 
				AND tm.id_inst = _id_inst AND ta.id_inst = _id_inst
			   GROUP BY ta.id_area, tm.año, tm.id_grado,tm.id_inst 
			   ORDER BY ta.id_area;
	DECLARE cur1 CURSOR FOR SELECT tas.id_area, 
			ROUND(IF(tmc.porciento BETWEEN 1 AND 99,
			SUM(IF(tn.nota_habilitacion > 0,(tn.nota_habilitacion*tmc.porciento)/100,(tn.final*tmc.porciento)/100)),
			AVG(IF(tn.nota_habilitacion > 0, tn.nota_habilitacion, tn.final))),_ndecim) AS prom FROM nscp001 AS tn 
			LEFT JOIN cursos AS tc ON (tn.id_curso = tc.id AND tn.`año` = tc.`año`) 
			LEFT JOIN asignaturas AS tas ON tc.id_asig = tas.id_pk  
			LEFT JOIN areas AS tar ON tas.id_area = tar.id
			LEFT JOIN matriculas AS tm ON tn.id_matric = tm.id_matric
			LEFT JOIN matcurso AS tmc ON (tmc.id_asig = tas.id_pk AND tmc.id_grado = tm.id_grado 
			AND tmc.`año` = tm.`año`)
			WHERE tm.id_inst = _id_inst AND tn.id_matric = _id_matric
			AND tas.id_inst = _id_inst AND tar.id_inst = _id_inst 
			AND tmc.id_inst = _id_inst AND tn.periodo = _periodo
			AND tmc.id_grado = _cod_grado AND tc.id_grado = _cod_grado
			GROUP BY tn.id_matric, tas.id_area, tn.periodo;
	DECLARE cur2 CURSOR FOR SELECT tas.id_area, 
			ROUND(IF(tmc.porciento BETWEEN 1 AND 99,
			SUM(IF(tn.nota_habilitacion > 0,(tn.nota_habilitacion*tmc.porciento)/100,(tn.final*tmc.porciento)/100)),
			AVG(IF(tn.nota_habilitacion > 0, tn.nota_habilitacion, tn.final))),_ndecim) AS prom FROM nscp002 AS tn 
			LEFT JOIN cursos AS tc ON (tn.id_curso = tc.id AND tn.`año` = tc.`año`) 
			LEFT JOIN asignaturas AS tas ON tc.id_asig = tas.id_pk  
			LEFT JOIN areas AS tar ON tas.id_area = tar.id
			LEFT JOIN matriculas AS tm ON tn.id_matric = tm.id_matric
			LEFT JOIN matcurso AS tmc ON (tmc.id_asig = tas.id_pk AND tmc.id_grado = tm.id_grado 
			AND tmc.`año` = tm.`año`)
			WHERE tm.id_inst = _id_inst AND tn.id_matric = _id_matric
			AND tas.id_inst = _id_inst AND tar.id_inst = _id_inst 
			AND tmc.id_inst = _id_inst AND tn.periodo = _periodo
			AND tmc.id_grado = _cod_grado AND tc.id_grado = _cod_grado
			GROUP BY tn.id_matric, tas.id_area, tn.periodo;						
	DECLARE cur3 CURSOR FOR SELECT tas.id_area, 
			ROUND(IF(tmc.porciento BETWEEN 1 AND 99,
			SUM(IF(tn.nota_habilitacion > 0,(tn.nota_habilitacion*tmc.porciento)/100,(tn.final*tmc.porciento)/100)),
			AVG(IF(tn.nota_habilitacion > 0, tn.nota_habilitacion, tn.final))),_ndecim) AS prom FROM nscp003 AS tn 
			LEFT JOIN cursos AS tc ON (tn.id_curso = tc.id AND tn.`año` = tc.`año`) 
			LEFT JOIN asignaturas AS tas ON tc.id_asig = tas.id_pk  
			LEFT JOIN areas AS tar ON tas.id_area = tar.id
			LEFT JOIN matriculas AS tm ON tn.id_matric = tm.id_matric
			LEFT JOIN matcurso AS tmc ON (tmc.id_asig = tas.id_pk AND tmc.id_grado = tm.id_grado 
			AND tmc.`año` = tm.`año`)
			WHERE tm.id_inst = _id_inst AND tn.id_matric = _id_matric
			AND tas.id_inst = _id_inst AND tar.id_inst = _id_inst 
			AND tmc.id_inst = _id_inst AND tn.periodo = _periodo
			AND tmc.id_grado = _cod_grado AND tc.id_grado = _cod_grado
			GROUP BY tn.id_matric, tas.id_area, tn.periodo;
							
	DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done = 1;
	
	SELECT tm.id_inst,tm.id_grado,tm.grupo,tm.`año` INTO _id_inst,_cod_grado,_grupo,`_año` 
	FROM matriculas AS tm WHERE tm.id_matric = _id_matric;
	 
	SELECT td.hasta INTO _desde FROM desempeños as td 
	LEFT JOIN grados_agrupados AS t1 ON td.id_grado_agrupado = t1.id
	LEFT JOIN aux_grados_agrupados AS t2 ON t2.id_grado_agrupado = t1.id
	WHERE td.id_inst = _id_inst AND td.`año` = _año AND td.reprueba = 1 
	AND t2.id_grado = _cod_grado LIMIT 1;
	 
	SELECT tc.Ndecimales INTO _ndecim FROM config001 tc 
	LEFT JOIN grados_agrupados AS t1 ON tc.id_grupo_grados = t1.id
	LEFT JOIN aux_grados_agrupados AS t2 ON t2.id_grado_agrupado = t1.id
	WHERE tc.id_inst = _id_inst AND tc.`AÑO` = `_año` AND t2.id_grado = _cod_grado LIMIT 1;
	
	OPEN cur_matcurso; 
	REPEAT 
	FETCH cur_matcurso INTO _cod_area;
		IF NOT done THEN 
		 SET x_count = x_count + 1;
			CASE x_count
				WHEN 1 THEN 
					SET aa1 = _cod_area;
				WHEN 2 THEN 
					SET aa2 = _cod_area;
				WHEN 3 THEN 
					SET aa3 = _cod_area;
				WHEN 4 THEN 
					SET aa4 = _cod_area;
				WHEN 5 THEN 
					SET aa5 = _cod_area;
				WHEN 6 THEN 
					SET aa6 = _cod_area;
				WHEN 7 THEN 
					SET aa7 = _cod_area;
				WHEN 8 THEN 
					SET aa8 = _cod_area;
				WHEN 9 THEN 
					SET aa9 = _cod_area;
				WHEN 10 THEN 
					SET aa10 = _cod_area;
				WHEN 11 THEN 
					SET aa11 = _cod_area;
				WHEN 12 THEN 
					SET aa12 = _cod_area;
				WHEN 13 THEN 
					SET aa13 = _cod_area;
				WHEN 14 THEN 
					SET aa14 = _cod_area;
				WHEN 15 THEN 
					SET aa15 = _cod_area;
				WHEN 16 THEN 
					SET aa16 = _cod_area;
				WHEN 17 THEN 
					SET aa17 = _cod_area;
				WHEN 18 THEN 
					SET aa18 = _cod_area;
				WHEN 19 THEN 
					SET aa19 = _cod_area;
				WHEN 20 THEN 
					SET aa20 = _cod_area;
				WHEN 21 THEN 
					SET aa21 = _cod_area;
				WHEN 22 THEN 
					SET aa22 = _cod_area;
				WHEN 23 THEN 
					SET aa23 = _cod_area;
				WHEN 24 THEN 
					SET aa24 = _cod_area;
				WHEN 25 THEN 
					SET aa25 = _cod_area;
				ELSE
					SET done = 1;
			END CASE;
		END IF;
	UNTIL done END REPEAT;
	CLOSE cur_matcurso;
		
	SELECT id_matric INTO x_id_matric FROM consolidado_areas WHERE id_matric = _id_matric AND periodo = _periodo;
	
	IF NOT x_id_matric THEN 
		INSERT INTO  consolidado_areas (id_matric,periodo) VALUES (_id_matric,_periodo);
	ELSE
		UPDATE consolidado_areas SET nar1 = 0, nar2 = 0,nar3 = 0,nar4 = 0,nar5 = 0,nar6 = 0,nar7 = 0,nar8 = 0,nar9 = 0,nar10 = 0,
		nar11 = 0, nar12 = 0,nar13 = 0,nar14 = 0,nar15 = 0,nar16 = 0,nar17 = 0,nar18 = 0,nar19 = 0,nar20 = 0,
		nar21 = 0, nar22 = 0,nar23 = 0,nar24 = 0,nar25 = 0,
        ar1 = 0, ar2 = 0,ar3 = 0,ar4 = 0,ar5 = 0,ar6 = 0,ar7 = 0,ar8 = 0,ar9 = 0,ar10 = 0,
		ar11 = 0, ar12 = 0,ar13 = 0,ar14 = 0,ar15 = 0,ar16 = 0,ar17 = 0,ar18 = 0,ar19 = 0,ar20 = 0,
		ar21 = 0, ar22 = 0,ar23 = 0,ar24 = 0,ar25 = 0
		 WHERE id_matric = _id_matric  AND  periodo = _periodo ;
	END IF;
	SET done = 0;
	SET x_count = 0;
	CASE 
		WHEN _cod_grado >= 5 AND _cod_grado <= 9 THEN 
			OPEN cur1;
			REPEAT 
			FETCH cur1 INTO _id_area_n,_final;
			IF NOT done THEN 
				SET x_count = x_count + 1;
				SET x_count_matcurso = 25;
				SET _suma	= _suma + _final;
				WHILE x_count_matcurso > 0 DO
					SET x_count_matcurso = x_count_matcurso - 1;
					SET x_count_2 = x_count_2 + 1 ;
					CASE x_count_2
						WHEN 1 THEN 
							IF _id_area_n =  aa1 THEN 
								UPDATE consolidado_areas tc SET tc.ar1 = aa1 , tc.nar1 = _final 
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado_areas tc SET tc.ar1 = aa1 , tc.nar1 = 0
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 2 THEN 
							IF _id_area_n =  aa2 THEN 
								UPDATE consolidado_areas tc SET tc.ar2 = aa2 , tc.nar2 = _final 
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado_areas tc SET tc.ar2 = aa2 , tc.nar2 = 0
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 3 THEN 
							IF _id_area_n =  aa3 THEN 
								UPDATE consolidado_areas tc SET tc.ar3 = aa3 , tc.nar3 = _final 
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado_areas tc SET tc.ar3 = aa3 , tc.nar3 = 0
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 4 THEN 
							IF _id_area_n =  aa4 THEN 
								UPDATE consolidado_areas tc SET tc.ar4 = aa4 , tc.nar4 = _final 
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado_areas tc SET tc.ar4 = aa4 , tc.nar4 = 0
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 5 THEN 
							IF _id_area_n =  aa5 THEN 
								UPDATE consolidado_areas tc SET tc.ar5 = aa5 , tc.nar5 = _final 
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado_areas tc SET tc.ar5 = aa5 , tc.nar5 = 0
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 6 THEN 
							IF _id_area_n =  aa6 THEN 
								UPDATE consolidado_areas tc SET tc.ar6 = aa6 , tc.nar6 = _final 
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado_areas tc SET tc.ar6 = aa6 , tc.nar6 = 0
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 7 THEN 
							IF _id_area_n =  aa7 THEN 
								UPDATE consolidado_areas tc SET tc.ar7 = aa7 , tc.nar7 = _final 
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado_areas tc SET tc.ar7 = aa7 , tc.nar7 = 0
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 8 THEN 
							IF _id_area_n =  aa8 THEN 
								UPDATE consolidado_areas tc SET tc.ar8 = aa8 , tc.nar8 = _final 
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado_areas tc SET tc.ar8 = aa8 , tc.nar8 = 0
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 9 THEN 
							IF _id_area_n =  aa9 THEN 
								UPDATE consolidado_areas tc SET tc.ar9 = aa9 , tc.nar9 = _final 
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado_areas tc SET tc.ar9 = aa9 , tc.nar9 = 0
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 10 THEN 
							IF _id_area_n =  aa10 THEN 
								UPDATE consolidado_areas tc SET tc.ar10 = aa10 , tc.nar10 = _final 
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado_areas tc SET tc.ar10 = aa10 , tc.nar10 = 0
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 11 THEN 
							IF _id_area_n =  aa11 THEN 
								UPDATE consolidado_areas tc SET tc.ar11 = aa11 , tc.nar11 = _final 
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado_areas tc SET tc.ar11 = aa11 , tc.nar11 = 0
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 12 THEN 
							IF _id_area_n =  aa12 THEN 
								UPDATE consolidado_areas tc SET tc.ar12 = aa12 , tc.nar12 = _final 
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado_areas tc SET tc.ar12 = aa12 , tc.nar12 = 0
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 13 THEN 
							IF _id_area_n =  aa13 THEN 
								UPDATE consolidado_areas tc SET tc.ar13 = aa13 , tc.nar13 = _final 
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado_areas tc SET tc.ar13 = aa13 , tc.nar13 = 0
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 14 THEN 
							IF _id_area_n =  aa14 THEN 
								UPDATE consolidado_areas tc SET tc.ar14 = aa14 , tc.nar14 = _final 
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado_areas tc SET tc.ar14 = aa14 , tc.nar14 = 0
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 15 THEN 
							IF _id_area_n =  aa15 THEN 
								UPDATE consolidado_areas tc SET tc.ar15 = aa15 , tc.nar15 = _final 
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado_areas tc SET tc.ar15 = aa15 , tc.nar15 = 0
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 16 THEN 
							IF _id_area_n =  aa16 THEN 
								UPDATE consolidado_areas tc SET tc.ar16 = aa16 , tc.nar16 = _final 
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado_areas tc SET tc.ar16 = aa16 , tc.nar16 = 0
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 17 THEN 
							IF _id_area_n =  aa17 THEN 
								UPDATE consolidado_areas tc SET tc.ar17 = aa17 , tc.nar17 = _final 
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado_areas tc SET tc.ar17 = aa17 , tc.nar17 = 0
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 18 THEN 
							IF _id_area_n =  aa18 THEN 
								UPDATE consolidado_areas tc SET tc.ar18 = aa18 , tc.nar18 = _final 
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado_areas tc SET tc.ar18 = aa18 , tc.nar18 = 0
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 19 THEN 
							IF _id_area_n =  aa19 THEN 
								UPDATE consolidado_areas tc SET tc.ar19 = aa19 , tc.nar19 = _final 
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado_areas tc SET tc.ar19 = aa19 , tc.nar19 = 0
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 20 THEN 
							IF _id_area_n =  aa20 THEN 
								UPDATE consolidado_areas tc SET tc.ar20 = aa20 , tc.nar20 = _final 
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado_areas tc SET tc.ar20 = aa20 , tc.nar20 = 0
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 21 THEN 
							IF _id_area_n =  aa21 THEN 
								UPDATE consolidado_areas tc SET tc.ar21 = aa21 , tc.nar21 = _final 
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado_areas tc SET tc.ar21 = aa21 , tc.nar21 = 0
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 22 THEN 
							IF _id_area_n =  aa22 THEN 
								UPDATE consolidado_areas tc SET tc.ar22 = aa22 , tc.nar22 = _final 
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado_areas tc SET tc.ar22 = aa22 , tc.nar22 = 0
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 23 THEN 
							IF _id_area_n =  aa23 THEN 
								UPDATE consolidado_areas tc SET tc.ar23 = aa23 , tc.nar23 = _final 
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado_areas tc SET tc.ar23 = aa23 , tc.nar23 = 0
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 24 THEN 
							IF _id_area_n =  aa24 THEN 
								UPDATE consolidado_areas tc SET tc.ar24 = aa24 , tc.nar24 = _final 
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado_areas tc SET tc.ar24 = aa24 , tc.nar24 = 0
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 25 THEN 
							IF _id_area_n =  aa25 THEN 
								UPDATE consolidado_areas tc SET tc.ar25 = aa25 , tc.nar25 = _final 
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado_areas tc SET tc.ar25 = aa25 , tc.nar25 = 0
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
					ELSE
						SET done = 0;
					END CASE;
				END WHILE; 
			END IF;
		UNTIL done END REPEAT;
		IF _suma > 0 THEN
			SET _suma = ROUND(_suma/x_count,2);
		END IF;
		UPDATE consolidado_areas cn SET cn.prom = _suma, cn.t = x_cant_asig_perdidas 
							WHERE cn.id_matric = _id_matric AND cn.periodo = _periodo;
		CLOSE cur1;
	WHEN _cod_grado >= 10 AND _cod_grado <= 13 THEN 
			OPEN cur2;
			REPEAT 
			FETCH cur2 INTO _id_area_n,_final;
			IF NOT done THEN 
				SET x_count = x_count + 1;
				SET x_count_matcurso = 25;
				SET _suma	= _suma + _final;
				WHILE x_count_matcurso > 0 DO
					SET x_count_matcurso = x_count_matcurso - 1;
					SET x_count_2 = x_count_2 + 1 ;
					CASE x_count_2
						WHEN 1 THEN 
							IF _id_area_n =  aa1 THEN 
								UPDATE consolidado_areas tc SET tc.ar1 = aa1 , tc.nar1 = _final 
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado_areas tc SET tc.ar1 = aa1 , tc.nar1 = 0
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 2 THEN 
							IF _id_area_n =  aa2 THEN 
								UPDATE consolidado_areas tc SET tc.ar2 = aa2 , tc.nar2 = _final 
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado_areas tc SET tc.ar2 = aa2 , tc.nar2 = 0
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 3 THEN 
							IF _id_area_n =  aa3 THEN 
								UPDATE consolidado_areas tc SET tc.ar3 = aa3 , tc.nar3 = _final 
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado_areas tc SET tc.ar3 = aa3 , tc.nar3 = 0
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 4 THEN 
							IF _id_area_n =  aa4 THEN 
								UPDATE consolidado_areas tc SET tc.ar4 = aa4 , tc.nar4 = _final 
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado_areas tc SET tc.ar4 = aa4 , tc.nar4 = 0
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 5 THEN 
							IF _id_area_n =  aa5 THEN 
								UPDATE consolidado_areas tc SET tc.ar5 = aa5 , tc.nar5 = _final 
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado_areas tc SET tc.ar5 = aa5 , tc.nar5 = 0
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 6 THEN 
							IF _id_area_n =  aa6 THEN 
								UPDATE consolidado_areas tc SET tc.ar6 = aa6 , tc.nar6 = _final 
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado_areas tc SET tc.ar6 = aa6 , tc.nar6 = 0
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 7 THEN 
							IF _id_area_n =  aa7 THEN 
								UPDATE consolidado_areas tc SET tc.ar7 = aa7 , tc.nar7 = _final 
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado_areas tc SET tc.ar7 = aa7 , tc.nar7 = 0
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 8 THEN 
							IF _id_area_n =  aa8 THEN 
								UPDATE consolidado_areas tc SET tc.ar8 = aa8 , tc.nar8 = _final 
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado_areas tc SET tc.ar8 = aa8 , tc.nar8 = 0
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 9 THEN 
							IF _id_area_n =  aa9 THEN 
								UPDATE consolidado_areas tc SET tc.ar9 = aa9 , tc.nar9 = _final 
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado_areas tc SET tc.ar9 = aa9 , tc.nar9 = 0
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 10 THEN 
							IF _id_area_n =  aa10 THEN 
								UPDATE consolidado_areas tc SET tc.ar10 = aa10 , tc.nar10 = _final 
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado_areas tc SET tc.ar10 = aa10 , tc.nar10 = 0
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 11 THEN 
							IF _id_area_n =  aa11 THEN 
								UPDATE consolidado_areas tc SET tc.ar11 = aa11 , tc.nar11 = _final 
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado_areas tc SET tc.ar11 = aa11 , tc.nar11 = 0
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 12 THEN 
							IF _id_area_n =  aa12 THEN 
								UPDATE consolidado_areas tc SET tc.ar12 = aa12 , tc.nar12 = _final 
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado_areas tc SET tc.ar12 = aa12 , tc.nar12 = 0
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 13 THEN 
							IF _id_area_n =  aa13 THEN 
								UPDATE consolidado_areas tc SET tc.ar13 = aa13 , tc.nar13 = _final 
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado_areas tc SET tc.ar13 = aa13 , tc.nar13 = 0
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 14 THEN 
							IF _id_area_n =  aa14 THEN 
								UPDATE consolidado_areas tc SET tc.ar14 = aa14 , tc.nar14 = _final 
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado_areas tc SET tc.ar14 = aa14 , tc.nar14 = 0
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 15 THEN 
							IF _id_area_n =  aa15 THEN 
								UPDATE consolidado_areas tc SET tc.ar15 = aa15 , tc.nar15 = _final 
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado_areas tc SET tc.ar15 = aa15 , tc.nar15 = 0
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 16 THEN 
							IF _id_area_n =  aa16 THEN 
								UPDATE consolidado_areas tc SET tc.ar16 = aa16 , tc.nar16 = _final 
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado_areas tc SET tc.ar16 = aa16 , tc.nar16 = 0
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 17 THEN 
							IF _id_area_n =  aa17 THEN 
								UPDATE consolidado_areas tc SET tc.ar17 = aa17 , tc.nar17 = _final 
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado_areas tc SET tc.ar17 = aa17 , tc.nar17 = 0
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 18 THEN 
							IF _id_area_n =  aa18 THEN 
								UPDATE consolidado_areas tc SET tc.ar18 = aa18 , tc.nar18 = _final 
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado_areas tc SET tc.ar18 = aa18 , tc.nar18 = 0
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 19 THEN 
							IF _id_area_n =  aa19 THEN 
								UPDATE consolidado_areas tc SET tc.ar19 = aa19 , tc.nar19 = _final 
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado_areas tc SET tc.ar19 = aa19 , tc.nar19 = 0
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 20 THEN 
							IF _id_area_n =  aa20 THEN 
								UPDATE consolidado_areas tc SET tc.ar20 = aa20 , tc.nar20 = _final 
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado_areas tc SET tc.ar20 = aa20 , tc.nar20 = 0
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 21 THEN 
							IF _id_area_n =  aa21 THEN 
								UPDATE consolidado_areas tc SET tc.ar21 = aa21 , tc.nar21 = _final 
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado_areas tc SET tc.ar21 = aa21 , tc.nar21 = 0
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 22 THEN 
							IF _id_area_n =  aa22 THEN 
								UPDATE consolidado_areas tc SET tc.ar22 = aa22 , tc.nar22 = _final 
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado_areas tc SET tc.ar22 = aa22 , tc.nar22 = 0
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 23 THEN 
							IF _id_area_n =  aa23 THEN 
								UPDATE consolidado_areas tc SET tc.ar23 = aa23 , tc.nar23 = _final 
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado_areas tc SET tc.ar23 = aa23 , tc.nar23 = 0
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 24 THEN 
							IF _id_area_n =  aa24 THEN 
								UPDATE consolidado_areas tc SET tc.ar24 = aa24 , tc.nar24 = _final 
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado_areas tc SET tc.ar24 = aa24 , tc.nar24 = 0
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 25 THEN 
							IF _id_area_n =  aa25 THEN 
								UPDATE consolidado_areas tc SET tc.ar25 = aa25 , tc.nar25 = _final 
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado_areas tc SET tc.ar25 = aa25 , tc.nar25 = 0
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
					ELSE
						SET done = 0;
					END CASE;
				END WHILE; 
			END IF;
		UNTIL done END REPEAT;
		IF _suma > 0 THEN
			SET _suma = ROUND(_suma/x_count,2);
		END IF;
		UPDATE consolidado_areas cn SET cn.prom = _suma, cn.t = x_cant_asig_perdidas 
							WHERE cn.id_matric = _id_matric AND cn.periodo = _periodo;
		CLOSE cur2;
	WHEN _cod_grado >= 14 THEN 
			OPEN cur3;
			REPEAT 
			FETCH cur3 INTO _id_area_n,_final;
			IF NOT done THEN 
				SET x_count = x_count + 1;
				SET x_count_matcurso = 25;
				SET _suma	= _suma + _final;
				WHILE x_count_matcurso > 0 DO
					SET x_count_matcurso = x_count_matcurso - 1;
					SET x_count_2 = x_count_2 + 1 ;
					CASE x_count_2
						WHEN 1 THEN 
							IF _id_area_n =  aa1 THEN 
								UPDATE consolidado_areas tc SET tc.ar1 = aa1 , tc.nar1 = _final 
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado_areas tc SET tc.ar1 = aa1 , tc.nar1 = 0
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 2 THEN 
							IF _id_area_n =  aa2 THEN 
								UPDATE consolidado_areas tc SET tc.ar2 = aa2 , tc.nar2 = _final 
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado_areas tc SET tc.ar2 = aa2 , tc.nar2 = 0
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 3 THEN 
							IF _id_area_n =  aa3 THEN 
								UPDATE consolidado_areas tc SET tc.ar3 = aa3 , tc.nar3 = _final 
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado_areas tc SET tc.ar3 = aa3 , tc.nar3 = 0
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 4 THEN 
							IF _id_area_n =  aa4 THEN 
								UPDATE consolidado_areas tc SET tc.ar4 = aa4 , tc.nar4 = _final 
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado_areas tc SET tc.ar4 = aa4 , tc.nar4 = 0
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 5 THEN 
							IF _id_area_n =  aa5 THEN 
								UPDATE consolidado_areas tc SET tc.ar5 = aa5 , tc.nar5 = _final 
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado_areas tc SET tc.ar5 = aa5 , tc.nar5 = 0
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 6 THEN 
							IF _id_area_n =  aa6 THEN 
								UPDATE consolidado_areas tc SET tc.ar6 = aa6 , tc.nar6 = _final 
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado_areas tc SET tc.ar6 = aa6 , tc.nar6 = 0
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 7 THEN 
							IF _id_area_n =  aa7 THEN 
								UPDATE consolidado_areas tc SET tc.ar7 = aa7 , tc.nar7 = _final 
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado_areas tc SET tc.ar7 = aa7 , tc.nar7 = 0
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 8 THEN 
							IF _id_area_n =  aa8 THEN 
								UPDATE consolidado_areas tc SET tc.ar8 = aa8 , tc.nar8 = _final 
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado_areas tc SET tc.ar8 = aa8 , tc.nar8 = 0
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 9 THEN 
							IF _id_area_n =  aa9 THEN 
								UPDATE consolidado_areas tc SET tc.ar9 = aa9 , tc.nar9 = _final 
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado_areas tc SET tc.ar9 = aa9 , tc.nar9 = 0
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 10 THEN 
							IF _id_area_n =  aa10 THEN 
								UPDATE consolidado_areas tc SET tc.ar10 = aa10 , tc.nar10 = _final 
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado_areas tc SET tc.ar10 = aa10 , tc.nar10 = 0
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 11 THEN 
							IF _id_area_n =  aa11 THEN 
								UPDATE consolidado_areas tc SET tc.ar11 = aa11 , tc.nar11 = _final 
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado_areas tc SET tc.ar11 = aa11 , tc.nar11 = 0
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 12 THEN 
							IF _id_area_n =  aa12 THEN 
								UPDATE consolidado_areas tc SET tc.ar12 = aa12 , tc.nar12 = _final 
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado_areas tc SET tc.ar12 = aa1 , tc.nar12 = 0
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 13 THEN 
							IF _id_area_n =  aa13 THEN 
								UPDATE consolidado_areas tc SET tc.ar13 = aa13 , tc.nar13 = _final 
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado_areas tc SET tc.ar13 = aa13 , tc.nar13 = 0
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 14 THEN 
							IF _id_area_n =  aa14 THEN 
								UPDATE consolidado_areas tc SET tc.ar14 = aa14 , tc.nar14 = _final 
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado_areas tc SET tc.ar14 = aa14 , tc.nar14 = 0
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 15 THEN 
							IF _id_area_n =  aa15 THEN 
								UPDATE consolidado_areas tc SET tc.ar15 = aa15 , tc.nar15 = _final 
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado_areas tc SET tc.ar15 = aa15 , tc.nar15 = 0
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 16 THEN 
							IF _id_area_n =  aa16 THEN 
								UPDATE consolidado_areas tc SET tc.ar16 = aa16 , tc.nar16 = _final 
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado_areas tc SET tc.ar16 = aa16 , tc.nar16 = 0
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 17 THEN 
							IF _id_area_n =  aa17 THEN 
								UPDATE consolidado_areas tc SET tc.ar17 = aa17 , tc.nar17 = _final 
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado_areas tc SET tc.ar17 = aa17 , tc.nar17 = 0
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 18 THEN 
							IF _id_area_n =  aa18 THEN 
								UPDATE consolidado_areas tc SET tc.ar18 = aa18 , tc.nar18 = _final 
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado_areas tc SET tc.ar18 = aa18 , tc.nar18 = 0
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 19 THEN 
							IF _id_area_n =  aa19 THEN 
								UPDATE consolidado_areas tc SET tc.ar19 = aa19 , tc.nar19 = _final 
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado_areas tc SET tc.ar19 = aa19 , tc.nar19 = 0
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 20 THEN 
							IF _id_area_n =  aa20 THEN 
								UPDATE consolidado_areas tc SET tc.ar20 = aa20 , tc.nar20 = _final 
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado_areas tc SET tc.ar20 = aa20 , tc.nar20 = 0
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 21 THEN 
							IF _id_area_n =  aa21 THEN 
								UPDATE consolidado_areas tc SET tc.ar21 = aa21 , tc.nar21 = _final 
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado_areas tc SET tc.ar21 = aa21 , tc.nar21 = 0
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 22 THEN 
							IF _id_area_n =  aa22 THEN 
								UPDATE consolidado_areas tc SET tc.ar22 = aa22 , tc.nar22 = _final 
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado_areas tc SET tc.ar22 = aa22 , tc.nar22 = 0
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 23 THEN 
							IF _id_area_n =  aa23 THEN 
								UPDATE consolidado_areas tc SET tc.ar23 = aa23 , tc.nar23 = _final 
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado_areas tc SET tc.ar23 = aa23 , tc.nar23 = 0
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 24 THEN 
							IF _id_area_n =  aa24 THEN 
								UPDATE consolidado_areas tc SET tc.ar24 = aa24 , tc.nar24 = _final 
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado_areas tc SET tc.ar24 = aa24 , tc.nar24 = 0
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 25 THEN 
							IF _id_area_n =  aa25 THEN 
								UPDATE consolidado_areas tc SET tc.ar25 = aa25 , tc.nar25 = _final 
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado_areas tc SET tc.ar25 = aa25 , tc.nar25 = 0
								WHERE tc.id_matric = _id_matric AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
					ELSE
						SET done = 0;
					END CASE;
				END WHILE; 
			END IF;
		UNTIL done END REPEAT;
		IF _suma > 0 THEN
			SET _suma = ROUND(_suma/x_count,2);
		END IF;
		UPDATE consolidado_areas cn SET cn.prom = _suma, cn.t = x_cant_asig_perdidas 
							WHERE cn.id_matric = _id_matric AND cn.periodo = _periodo;
		CLOSE cur3;
	ELSE
		SET done = 1;
	END CASE;
END$$

DROP PROCEDURE IF EXISTS `sp_consolidado_asignaturas`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_consolidado_asignaturas` (IN `_id_matic` INT(30), IN `_periodo` VARCHAR(2))  BEGIN
	DECLARE 	done,
				_id_inst,
				_año,
				_id_asig,
				x_count,
				x_count_2,
				_id_asig_n,
				x_id_matric,
				_cod_grado INT(30) DEFAULT 0;
	DECLARE aa1,aa2,aa3,aa4,aa5,aa6,aa7,aa8,aa9,aa10,aa11,
							aa12,aa13,aa14,aa15,aa16,aa17,aa18,aa19,aa20,
							aa21,aa22,aa23,aa24,aa25,x_count_matcurso,
							x_cant_asig_perdidas INT DEFAULT 0;
	DECLARE	_final,
				_suma,
				_desde DECIMAL(6,2) DEFAULT 0;
	DECLARE 	_grupo VARCHAR(2) DEFAULT '';
	DECLARE 	oStrimValue,
				sValue,
				yValue CHAR DEFAULT '';
	DECLARE cur_matcurso CURSOR FOR SELECT tm.id_asig FROM matcurso AS tm 
				LEFT JOIN asignaturas AS ta ON tm.id_asig = ta.id_pk 
				WHERE tm.año = _año AND tm.id_grado = _cod_grado AND tm.id_inst = _id_inst
				AND ta.id_inst = _id_inst 
			   GROUP BY tm.id_asig, tm.año, tm.id_grado,tm.id_inst 
			   ORDER BY ta.id_area, tm.id_asig;
	DECLARE cur1 CURSOR FOR SELECT tc.id_asig, if(tn.nota_habilitacion > 0, tn.nota_habilitacion, tn.final) AS final
				FROM nscp001 AS tn 
				LEFT JOIN cursos AS tc ON (tn.id_curso = tc.id AND tn.`año` = tc.`año`)
				LEFT JOIN asignaturas AS ta ON tc.id_asig = ta.id_pk 
				LEFT JOIN matriculas AS tm ON tn.id_matric = tm.id_matric
				WHERE tn.periodo = _periodo AND tm.id_estado= 2 AND tm.id_matric = _id_matic 
				AND ta.id_inst = _id_inst AND tn.`año` = _año
				ORDER BY ta.id_area,tc.id_asig;
	DECLARE cur2 CURSOR FOR SELECT tc.id_asig, if(tn.nota_habilitacion > 0, tn.nota_habilitacion, tn.final) AS final
				FROM nscp002 AS tn 
				LEFT JOIN cursos AS tc ON (tn.id_curso = tc.id AND tn.`año` = tc.`año`)
				LEFT JOIN asignaturas AS ta ON tc.id_asig = ta.id_pk 
				LEFT JOIN matriculas AS tm ON tn.id_matric = tm.id_matric
				WHERE tn.periodo = _periodo AND tm.id_estado= 2 AND tm.id_matric = _id_matic 
				AND ta.id_inst = _id_inst AND tn.`año` = _año
				ORDER BY ta.id_area,tc.id_asig;						
	DECLARE cur3 CURSOR FOR SELECT tc.id_asig, if(tn.nota_habilitacion > 0, tn.nota_habilitacion, tn.final) AS final
				FROM nscp003 AS tn 
				LEFT JOIN cursos AS tc ON (tn.id_curso = tc.id AND tn.`año` = tc.`año`)
				LEFT JOIN asignaturas AS ta ON tc.id_asig = ta.id_pk 
				LEFT JOIN matriculas AS tm ON tn.id_matric = tm.id_matric
				WHERE tn.periodo = _periodo AND tm.id_estado= 2 AND tm.id_matric = _id_matic 
				AND ta.id_inst = _id_inst AND tn.`año` = _año
				ORDER BY ta.id_area,tc.id_asig;
							
	DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done = 1;
	
	SELECT tm.id_inst,tm.id_grado,tm.grupo,tm.`año` INTO _id_inst,_cod_grado,_grupo,`_año` 
	FROM matriculas AS tm WHERE tm.id_matric = _id_matic LIMIT 1;
	OPEN cur_matcurso; 
	
	SELECT td.hasta INTO _desde FROM desempeños as td 
	LEFT JOIN grados_agrupados AS t1 ON td.id_grado_agrupado = t1.id
	LEFT JOIN aux_grados_agrupados AS t2 ON t2.id_grado_agrupado = t1.id
	WHERE td.id_inst = _id_inst AND td.`año` = _año AND td.reprueba = 1
	AND t2.id_grado = _cod_grado LIMIT 1;
	
	REPEAT 
	FETCH cur_matcurso INTO _id_asig;
		IF NOT done THEN 
		 SET x_count = x_count + 1;
			CASE x_count
				WHEN 1 THEN 
					SET aa1 = _id_asig;
				WHEN 2 THEN 
					SET aa2 = _id_asig;
				WHEN 3 THEN 
					SET aa3 = _id_asig;
				WHEN 4 THEN 
					SET aa4 = _id_asig;
				WHEN 5 THEN 
					SET aa5 = _id_asig;
				WHEN 6 THEN 
					SET aa6 = _id_asig;
				WHEN 7 THEN 
					SET aa7 = _id_asig;
				WHEN 8 THEN 
					SET aa8 = _id_asig;
				WHEN 9 THEN 
					SET aa9 = _id_asig;
				WHEN 10 THEN 
					SET aa10 = _id_asig;
				WHEN 11 THEN 
					SET aa11 = _id_asig;
				WHEN 12 THEN 
					SET aa12 = _id_asig;
				WHEN 13 THEN 
					SET aa13 = _id_asig;
				WHEN 14 THEN 
					SET aa14 = _id_asig;
				WHEN 15 THEN 
					SET aa15 = _id_asig;
				WHEN 16 THEN 
					SET aa16 = _id_asig;
				WHEN 17 THEN 
					SET aa17 = _id_asig;
				WHEN 18 THEN 
					SET aa18 = _id_asig;
				WHEN 19 THEN 
					SET aa19 = _id_asig;
				WHEN 20 THEN 
					SET aa20 = _id_asig;
				WHEN 21 THEN 
					SET aa21 = _id_asig;
				WHEN 22 THEN 
					SET aa22 = _id_asig;
				WHEN 23 THEN 
					SET aa23 = _id_asig;
				WHEN 24 THEN 
					SET aa24 = _id_asig;
				WHEN 25 THEN 
					SET aa25 = _id_asig;
				ELSE
					SET done = 1;
			END CASE;
		END IF;
	UNTIL done END REPEAT;
	CLOSE cur_matcurso;
		
	SELECT id_matric INTO x_id_matric FROM consolidado WHERE id_matric = _id_matic AND periodo = _periodo;
	
	IF NOT x_id_matric THEN 
		INSERT INTO  consolidado (id_matric,periodo) VALUES (_id_matic,_periodo);
	ELSE
		UPDATE consolidado SET nar1 = 0, nar2 = 0,nar3 = 0,nar4 = 0,nar5 = 0,nar6 = 0,nar7 = 0,nar8 = 0,nar9 = 0,nar10 = 0,
		nar11 = 0, nar12 = 0,nar13 = 0,nar14 = 0,nar15 = 0,nar16 = 0,nar17 = 0,nar18 = 0,nar19 = 0,nar20 = 0,
		nar21 = 0, nar22 = 0,nar23 = 0,nar24 = 0,nar25 = 0,
        ar1 = 0, ar2 = 0,ar3 = 0,ar4 = 0,ar5 = 0,ar6 = 0,ar7 = 0,ar8 = 0,ar9 = 0,ar10 = 0,
		ar11 = 0, ar12 = 0,ar13 = 0,ar14 = 0,ar15 = 0,ar16 = 0,ar17 = 0,ar18 = 0,ar19 = 0,ar20 = 0,
		ar21 = 0, ar22 = 0,ar23 = 0,ar24 = 0,ar25 = 0
		 WHERE id_matric = _id_matic  AND  periodo = _periodo ;
	END IF;
	SET done = 0;
	SET x_count = 0;
	CASE 
		WHEN _cod_grado >= 5 AND _cod_grado <= 9 THEN 
			OPEN cur1;
			REPEAT 
			FETCH cur1 INTO _id_asig_n,_final;
			IF NOT done THEN 
				SET x_count = x_count + 1;
				SET x_count_matcurso = 25;
				SET _suma	= _suma + _final;
				WHILE x_count_matcurso > 0 DO
					SET x_count_matcurso = x_count_matcurso - 1;
					SET x_count_2 = x_count_2 + 1 ;
					CASE x_count_2
						WHEN 1 THEN 
							IF _id_asig_n =  aa1 THEN 
								UPDATE consolidado tc SET tc.ar1 = aa1 , tc.nar1 = _final 
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado tc SET tc.ar1 = aa1 , tc.nar1 = 0
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 2 THEN 
							IF _id_asig_n =  aa2 THEN 
								UPDATE consolidado tc SET tc.ar2 = aa2 , tc.nar2 = _final 
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado tc SET tc.ar2 = aa2 , tc.nar2 = 0
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 3 THEN 
							IF _id_asig_n =  aa3 THEN 
								UPDATE consolidado tc SET tc.ar3 = aa3 , tc.nar3 = _final 
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado tc SET tc.ar3 = aa3 , tc.nar3 = 0
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 4 THEN 
							IF _id_asig_n =  aa4 THEN 
								UPDATE consolidado tc SET tc.ar4 = aa4 , tc.nar4 = _final 
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado tc SET tc.ar4 = aa4 , tc.nar4 = 0
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 5 THEN 
							IF _id_asig_n =  aa5 THEN 
								UPDATE consolidado tc SET tc.ar5 = aa5 , tc.nar5 = _final 
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado tc SET tc.ar5 = aa5 , tc.nar5 = 0
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 6 THEN 
							IF _id_asig_n =  aa6 THEN 
								UPDATE consolidado tc SET tc.ar6 = aa6 , tc.nar6 = _final 
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado tc SET tc.ar6 = aa6 , tc.nar6 = 0
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 7 THEN 
							IF _id_asig_n =  aa7 THEN 
								UPDATE consolidado tc SET tc.ar7 = aa7 , tc.nar7 = _final 
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado tc SET tc.ar7 = aa7 , tc.nar7 = 0
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 8 THEN 
							IF _id_asig_n =  aa8 THEN 
								UPDATE consolidado tc SET tc.ar8 = aa8 , tc.nar8 = _final 
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado tc SET tc.ar8 = aa8 , tc.nar8 = 0
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 9 THEN 
							IF _id_asig_n =  aa9 THEN 
								UPDATE consolidado tc SET tc.ar9 = aa9 , tc.nar9 = _final 
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado tc SET tc.ar9 = aa9 , tc.nar9 = 0
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 10 THEN 
							IF _id_asig_n =  aa10 THEN 
								UPDATE consolidado tc SET tc.ar10 = aa10 , tc.nar10 = _final 
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado tc SET tc.ar10 = aa10 , tc.nar10 = 0
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 11 THEN 
							IF _id_asig_n =  aa11 THEN 
								UPDATE consolidado tc SET tc.ar11 = aa11 , tc.nar11 = _final 
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado tc SET tc.ar11 = aa11 , tc.nar11 = 0
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 12 THEN 
							IF _id_asig_n =  aa12 THEN 
								UPDATE consolidado tc SET tc.ar12 = aa12 , tc.nar12 = _final 
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado tc SET tc.ar12 = aa12 , tc.nar12 = 0
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 13 THEN 
							IF _id_asig_n =  aa13 THEN 
								UPDATE consolidado tc SET tc.ar13 = aa13 , tc.nar13 = _final 
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado tc SET tc.ar13 = aa13 , tc.nar13 = 0
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 14 THEN 
							IF _id_asig_n =  aa14 THEN 
								UPDATE consolidado tc SET tc.ar14 = aa14 , tc.nar14 = _final 
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado tc SET tc.ar14 = aa14 , tc.nar14 = 0
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 15 THEN 
							IF _id_asig_n =  aa15 THEN 
								UPDATE consolidado tc SET tc.ar15 = aa15 , tc.nar15 = _final 
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado tc SET tc.ar15 = aa15 , tc.nar15 = 0
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 16 THEN 
							IF _id_asig_n =  aa16 THEN 
								UPDATE consolidado tc SET tc.ar16 = aa16 , tc.nar16 = _final 
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado tc SET tc.ar16 = aa16 , tc.nar16 = 0
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 17 THEN 
							IF _id_asig_n =  aa17 THEN 
								UPDATE consolidado tc SET tc.ar17 = aa17 , tc.nar17 = _final 
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado tc SET tc.ar17 = aa17 , tc.nar17 = 0
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 18 THEN 
							IF _id_asig_n =  aa18 THEN 
								UPDATE consolidado tc SET tc.ar18 = aa18 , tc.nar18 = _final 
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado tc SET tc.ar18 = aa18 , tc.nar18 = 0
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 19 THEN 
							IF _id_asig_n =  aa19 THEN 
								UPDATE consolidado tc SET tc.ar19 = aa19 , tc.nar19 = _final 
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado tc SET tc.ar19 = aa19 , tc.nar19 = 0
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 20 THEN 
							IF _id_asig_n =  aa20 THEN 
								UPDATE consolidado tc SET tc.ar20 = aa20 , tc.nar20 = _final 
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado tc SET tc.ar20 = aa20 , tc.nar20 = 0
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 21 THEN 
							IF _id_asig_n =  aa21 THEN 
								UPDATE consolidado tc SET tc.ar21 = aa21 , tc.nar21 = _final 
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado tc SET tc.ar21 = aa21 , tc.nar21 = 0
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 22 THEN 
							IF _id_asig_n =  aa22 THEN 
								UPDATE consolidado tc SET tc.ar22 = aa22 , tc.nar22 = _final 
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado tc SET tc.ar22 = aa22 , tc.nar22 = 0
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 23 THEN 
							IF _id_asig_n =  aa23 THEN 
								UPDATE consolidado tc SET tc.ar23 = aa23 , tc.nar23 = _final 
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado tc SET tc.ar23 = aa23 , tc.nar23 = 0
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 24 THEN 
							IF _id_asig_n =  aa24 THEN 
								UPDATE consolidado tc SET tc.ar24 = aa24 , tc.nar24 = _final 
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado tc SET tc.ar24 = aa24 , tc.nar24 = 0
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 25 THEN 
							IF _id_asig_n =  aa25 THEN 
								UPDATE consolidado tc SET tc.ar25 = aa25 , tc.nar25 = _final 
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado tc SET tc.ar25 = aa25 , tc.nar25 = 0
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
					ELSE
						SET done = 0;
					END CASE;
				END WHILE; 
			END IF;
		UNTIL done END REPEAT;
		IF _suma > 0 THEN
			SET _suma = ROUND(_suma/x_count,2);
		END IF;
		UPDATE consolidado cn SET cn.prom = _suma, cn.t = x_cant_asig_perdidas 
							WHERE cn.id_matric = _id_matic AND cn.periodo = _periodo;
		CLOSE cur1;
	WHEN _cod_grado >= 10 AND _cod_grado <= 13 THEN 
			OPEN cur2;
			REPEAT 
			FETCH cur2 INTO _id_asig_n,_final;
			IF NOT done THEN 
				SET x_count = x_count + 1;
				SET x_count_matcurso = 25;
				SET _suma	= _suma + _final;
				WHILE x_count_matcurso > 0 DO
					SET x_count_matcurso = x_count_matcurso - 1;
					SET x_count_2 = x_count_2 + 1 ;
					CASE x_count_2
						WHEN 1 THEN 
							IF _id_asig_n =  aa1 THEN 
								UPDATE consolidado tc SET tc.ar1 = aa1 , tc.nar1 = _final 
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado tc SET tc.ar1 = aa1 , tc.nar1 = 0
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
							END IF;
							SET done = 0;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
						WHEN 2 THEN 
							IF _id_asig_n =  aa2 THEN 
								UPDATE consolidado tc SET tc.ar2 = aa2 , tc.nar2 = _final 
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado tc SET tc.ar2 = aa2 , tc.nar2 = 0
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 3 THEN 
							IF _id_asig_n =  aa3 THEN 
								UPDATE consolidado tc SET tc.ar3 = aa3 , tc.nar3 = _final 
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado tc SET tc.ar3 = aa3 , tc.nar3 = 0
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 4 THEN 
							IF _id_asig_n =  aa4 THEN 
								UPDATE consolidado tc SET tc.ar4 = aa4 , tc.nar4 = _final 
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado tc SET tc.ar4 = aa4 , tc.nar4 = 0
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 5 THEN 
							IF _id_asig_n =  aa5 THEN 
								UPDATE consolidado tc SET tc.ar5 = aa5 , tc.nar5 = _final 
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado tc SET tc.ar5 = aa5 , tc.nar5 = 0
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 6 THEN 
							IF _id_asig_n =  aa6 THEN 
								UPDATE consolidado tc SET tc.ar6 = aa6 , tc.nar6 = _final 
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado tc SET tc.ar6 = aa6 , tc.nar6 = 0
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 7 THEN 
							IF _id_asig_n =  aa7 THEN 
								UPDATE consolidado tc SET tc.ar7 = aa7 , tc.nar7 = _final 
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado tc SET tc.ar7 = aa7 , tc.nar7 = 0
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 8 THEN 
							IF _id_asig_n =  aa8 THEN 
								UPDATE consolidado tc SET tc.ar8 = aa8 , tc.nar8 = _final 
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado tc SET tc.ar8 = aa8 , tc.nar8 = 0
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 9 THEN 
							IF _id_asig_n =  aa9 THEN 
								UPDATE consolidado tc SET tc.ar9 = aa9 , tc.nar9 = _final 
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado tc SET tc.ar9 = aa9 , tc.nar9 = 0
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 10 THEN 
							IF _id_asig_n =  aa10 THEN 
								UPDATE consolidado tc SET tc.ar10 = aa10 , tc.nar10 = _final 
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado tc SET tc.ar10 = aa10 , tc.nar10 = 0
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 11 THEN 
							IF _id_asig_n =  aa11 THEN 
								UPDATE consolidado tc SET tc.ar11 = aa11 , tc.nar11 = _final 
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado tc SET tc.ar11 = aa11 , tc.nar11 = 0
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 12 THEN 
							IF _id_asig_n =  aa12 THEN 
								UPDATE consolidado tc SET tc.ar12 = aa12 , tc.nar12 = _final 
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado tc SET tc.ar12 = aa12 , tc.nar12 = 0
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 13 THEN 
							IF _id_asig_n =  aa13 THEN 
								UPDATE consolidado tc SET tc.ar13 = aa13 , tc.nar13 = _final 
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado tc SET tc.ar13 = aa13 , tc.nar13 = 0
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 14 THEN 
							IF _id_asig_n =  aa14 THEN 
								UPDATE consolidado tc SET tc.ar14 = aa14 , tc.nar14 = _final 
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado tc SET tc.ar14 = aa14 , tc.nar14 = 0
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 15 THEN 
							IF _id_asig_n =  aa15 THEN 
								UPDATE consolidado tc SET tc.ar15 = aa15 , tc.nar15 = _final 
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado tc SET tc.ar15 = aa15 , tc.nar15 = 0
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 16 THEN 
							IF _id_asig_n =  aa16 THEN 
								UPDATE consolidado tc SET tc.ar16 = aa16 , tc.nar16 = _final 
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado tc SET tc.ar16 = aa16 , tc.nar16 = 0
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 17 THEN 
							IF _id_asig_n =  aa17 THEN 
								UPDATE consolidado tc SET tc.ar17 = aa17 , tc.nar17 = _final 
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado tc SET tc.ar17 = aa17 , tc.nar17 = 0
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 18 THEN 
							IF _id_asig_n =  aa18 THEN 
								UPDATE consolidado tc SET tc.ar18 = aa18 , tc.nar18 = _final 
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado tc SET tc.ar18 = aa18 , tc.nar18 = 0
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 19 THEN 
							IF _id_asig_n =  aa19 THEN 
								UPDATE consolidado tc SET tc.ar19 = aa19 , tc.nar19 = _final 
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado tc SET tc.ar19 = aa19 , tc.nar19 = 0
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 20 THEN 
							IF _id_asig_n =  aa20 THEN 
								UPDATE consolidado tc SET tc.ar20 = aa20 , tc.nar20 = _final 
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado tc SET tc.ar20 = aa20 , tc.nar20 = 0
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 21 THEN 
							IF _id_asig_n =  aa21 THEN 
								UPDATE consolidado tc SET tc.ar21 = aa21 , tc.nar21 = _final 
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado tc SET tc.ar21 = aa21 , tc.nar21 = 0
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 22 THEN 
							IF _id_asig_n =  aa22 THEN 
								UPDATE consolidado tc SET tc.ar22 = aa22 , tc.nar22 = _final 
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado tc SET tc.ar22 = aa22 , tc.nar22 = 0
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 23 THEN 
							IF _id_asig_n =  aa23 THEN 
								UPDATE consolidado tc SET tc.ar23 = aa23 , tc.nar23 = _final 
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado tc SET tc.ar23 = aa23 , tc.nar23 = 0
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 24 THEN 
							IF _id_asig_n =  aa24 THEN 
								UPDATE consolidado tc SET tc.ar24 = aa24 , tc.nar24 = _final 
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado tc SET tc.ar24 = aa24 , tc.nar24 = 0
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 25 THEN 
							IF _id_asig_n =  aa25 THEN 
								UPDATE consolidado tc SET tc.ar25 = aa25 , tc.nar25 = _final 
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado tc SET tc.ar25 = aa25 , tc.nar25 = 0
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
					ELSE
						SET done = 0;
					END CASE;
				END WHILE; 
			END IF;
		UNTIL done END REPEAT;
		IF _suma > 0 THEN
			SET _suma = ROUND(_suma/x_count,2);
		END IF;
		UPDATE consolidado cn SET cn.prom = _suma, cn.t = x_cant_asig_perdidas 
							WHERE cn.id_matric = _id_matic AND cn.periodo = _periodo;
		CLOSE cur2;
	WHEN _cod_grado >= 14 THEN 
			OPEN cur3;
			REPEAT 
			FETCH cur3 INTO _id_asig_n,_final;
			IF NOT done THEN 
				SET x_count = x_count + 1;
				SET x_count_matcurso = 25;
				SET _suma	= _suma + _final;
				WHILE x_count_matcurso > 0 DO
					SET x_count_matcurso = x_count_matcurso - 1;
					SET x_count_2 = x_count_2 + 1 ;
					CASE x_count_2
						WHEN 1 THEN 
							IF _id_asig_n =  aa1 THEN 
								UPDATE consolidado tc SET tc.ar1 = aa1 , tc.nar1 = _final 
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado tc SET tc.ar1 = aa1 , tc.nar1 = 0
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 2 THEN 
							IF _id_asig_n =  aa2 THEN 
								UPDATE consolidado tc SET tc.ar2 = aa2 , tc.nar2 = _final 
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado tc SET tc.ar2 = aa2 , tc.nar2 = 0
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 3 THEN 
							IF _id_asig_n =  aa3 THEN 
								UPDATE consolidado tc SET tc.ar3 = aa3 , tc.nar3 = _final 
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado tc SET tc.ar3 = aa3 , tc.nar3 = 0
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 4 THEN 
							IF _id_asig_n =  aa4 THEN 
								UPDATE consolidado tc SET tc.ar4 = aa4 , tc.nar4 = _final 
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado tc SET tc.ar4 = aa4 , tc.nar4 = 0
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 5 THEN 
							IF _id_asig_n =  aa5 THEN 
								UPDATE consolidado tc SET tc.ar5 = aa5 , tc.nar5 = _final 
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado tc SET tc.ar5 = aa5 , tc.nar5 = 0
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 6 THEN 
							IF _id_asig_n =  aa6 THEN 
								UPDATE consolidado tc SET tc.ar6 = aa6 , tc.nar6 = _final 
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado tc SET tc.ar6 = aa6 , tc.nar6 = 0
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 7 THEN 
							IF _id_asig_n =  aa7 THEN 
								UPDATE consolidado tc SET tc.ar7 = aa7 , tc.nar7 = _final 
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado tc SET tc.ar7 = aa7 , tc.nar7 = 0
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 8 THEN 
							IF _id_asig_n =  aa8 THEN 
								UPDATE consolidado tc SET tc.ar8 = aa8 , tc.nar8 = _final 
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado tc SET tc.ar8 = aa8 , tc.nar8 = 0
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 9 THEN 
							IF _id_asig_n =  aa9 THEN 
								UPDATE consolidado tc SET tc.ar9 = aa9 , tc.nar9 = _final 
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado tc SET tc.ar9 = aa9 , tc.nar9 = 0
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 10 THEN 
							IF _id_asig_n =  aa10 THEN 
								UPDATE consolidado tc SET tc.ar10 = aa10 , tc.nar10 = _final 
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado tc SET tc.ar10 = aa10 , tc.nar10 = 0
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 11 THEN 
							IF _id_asig_n =  aa11 THEN 
								UPDATE consolidado tc SET tc.ar11 = aa11 , tc.nar11 = _final 
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado tc SET tc.ar11 = aa11 , tc.nar11 = 0
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 12 THEN 
							IF _id_asig_n =  aa12 THEN 
								UPDATE consolidado tc SET tc.ar12 = aa12 , tc.nar12 = _final 
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado tc SET tc.ar12 = aa12 , tc.nar12 = 0
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 13 THEN 
							IF _id_asig_n =  aa13 THEN 
								UPDATE consolidado tc SET tc.ar13 = aa13 , tc.nar13 = _final 
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado tc SET tc.ar13 = aa13 , tc.nar13 = 0
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 14 THEN 
							IF _id_asig_n =  aa14 THEN 
								UPDATE consolidado tc SET tc.ar14 = aa14 , tc.nar14 = _final 
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado tc SET tc.ar14 = aa14 , tc.nar14 = 0
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 15 THEN 
							IF _id_asig_n =  aa15 THEN 
								UPDATE consolidado tc SET tc.ar15 = aa15 , tc.nar15 = _final 
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado tc SET tc.ar15 = aa15 , tc.nar15 = 0
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 16 THEN 
							IF _id_asig_n =  aa16 THEN 
								UPDATE consolidado tc SET tc.ar16 = aa16 , tc.nar16 = _final 
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado tc SET tc.ar16 = aa16 , tc.nar16 = 0
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 17 THEN 
							IF _id_asig_n =  aa17 THEN 
								UPDATE consolidado tc SET tc.ar17 = aa17 , tc.nar17 = _final 
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado tc SET tc.ar17 = aa17 , tc.nar17 = 0
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 18 THEN 
							IF _id_asig_n =  aa18 THEN 
								UPDATE consolidado tc SET tc.ar18 = aa18 , tc.nar18 = _final 
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado tc SET tc.ar18 = aa18 , tc.nar18 = 0
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 19 THEN 
							IF _id_asig_n =  aa19 THEN 
								UPDATE consolidado tc SET tc.ar19 = aa19 , tc.nar19 = _final 
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado tc SET tc.ar19 = aa19 , tc.nar19 = 0
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 20 THEN 
							IF _id_asig_n =  aa20 THEN 
								UPDATE consolidado tc SET tc.ar20 = aa20 , tc.nar20 = _final 
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado tc SET tc.ar20 = aa20 , tc.nar20 = 0
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 21 THEN 
							IF _id_asig_n =  aa21 THEN 
								UPDATE consolidado tc SET tc.ar21 = aa21 , tc.nar21 = _final 
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado tc SET tc.ar21 = aa21 , tc.nar21 = 0
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 22 THEN 
							IF _id_asig_n =  aa22 THEN 
								UPDATE consolidado tc SET tc.ar22 = aa22 , tc.nar22 = _final 
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado tc SET tc.ar22 = aa22 , tc.nar22 = 0
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 23 THEN 
							IF _id_asig_n =  aa23 THEN 
								UPDATE consolidado tc SET tc.ar23 = aa23 , tc.nar23 = _final 
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado tc SET tc.ar23 = aa23 , tc.nar23 = 0
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 24 THEN 
							IF _id_asig_n =  aa24 THEN 
								UPDATE consolidado tc SET tc.ar24 = aa24 , tc.nar24 = _final 
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado tc SET tc.ar24 = aa24 , tc.nar24 = 0
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
						WHEN 25 THEN 
							IF _id_asig_n =  aa25 THEN 
								UPDATE consolidado tc SET tc.ar25 = aa25 , tc.nar25 = _final 
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE consolidado tc SET tc.ar25 = aa25 , tc.nar25 = 0
								WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo;
							END IF;
							IF _final >0 AND _final <= _desde THEN 
								SET x_cant_asig_perdidas = x_cant_asig_perdidas + 1;
							END IF;
							SET done = 0;
					ELSE
						SET done = 0;
					END CASE;
				END WHILE; 
			END IF;
		UNTIL done END REPEAT;
		IF _suma > 0 THEN
			SET _suma = ROUND(_suma/x_count,2);
		END IF;
		UPDATE consolidado cn SET cn.prom = _suma, cn.t = x_cant_asig_perdidas 
							WHERE cn.id_matric = _id_matic AND cn.periodo = _periodo;
		CLOSE cur3;
	ELSE
		SET done = 1;
	END CASE;	
END$$

DROP PROCEDURE IF EXISTS `sp_consolidado_docentes`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_consolidado_docentes` (IN `_id_matic` INT(20), IN `_periodo` VARCHAR(1), IN `_id_docente` INT(20))  BEGIN
	DECLARE 	done,
				_id_inst,
				_año,
				_id_asig,
				x_count,
				x_count_2,
				_id_asig_n,
				x_id_matric,
				x_count_all INT DEFAULT 0;
	DECLARE aa1,aa2,aa3,aa4,aa5,aa6,aa7,aa8,aa9,aa10,aa11,
							aa12,aa13,aa14,aa15,aa16,aa17,aa18,aa19,aa20,
							aa21,aa22,aa23,aa24,aa25,x_count_matcurso INT DEFAULT 0;
	DECLARE	_final,
				_suma DECIMAL(6,2) DEFAULT 0;
	DECLARE 	_cod_grado,
				_grupo VARCHAR(2) DEFAULT '';
	DECLARE 	oStrimValue,
				sValue,
				yValue CHAR DEFAULT '';
	DECLARE cur_matcurso CURSOR FOR SELECT tm.id_asig FROM matcurso AS tm 
				LEFT JOIN asignaturas AS ta ON tm.id_asig = ta.id 
				WHERE tm.año = _año AND tm.cod_grado = _cod_grado AND tm.id_inst = _id_inst
				AND ta.año = _año AND ta.id_inst = _id_inst 
			   GROUP BY tm.id_asig, tm.año, tm.cod_grado,tm.id_inst 
			   ORDER BY ta.cod_area,tm.id_asig;
	DECLARE cur1 CURSOR FOR SELECT tn.id_asig, if(tn.nota_habilitacion > 0, tn.nota_habilitacion, tn.final) AS final
				FROM nscp001 AS tn 
				LEFT JOIN matriculas AS tm ON tn.id_matric = tm.id_matric
				LEFT JOIN asignaturas AS ta ON tn.id_asig = ta.id 
				WHERE tn.periodo = _periodo AND tm.estado='2' AND tm.id_matric = _id_matic 
				AND ta.`año` = `_año`  AND ta.id_inst = _id_inst AND tn.id_docente = _id_docente
				ORDER BY ta.cod_area,tn.id_asig;
	DECLARE cur2 CURSOR FOR SELECT tn.id_asig, if(tn.nota_habilitacion > 0, tn.nota_habilitacion, tn.final) AS final
				FROM nscp002 AS tn 
				LEFT JOIN matriculas AS tm ON tn.id_matric = tm.id_matric
				LEFT JOIN asignaturas AS ta ON tn.id_asig = ta.id 
				WHERE tn.periodo = _periodo AND tm.estado='2' AND tm.id_matric = _id_matic 
				AND ta.`año` = `_año`  AND ta.id_inst = _id_inst AND tn.id_docente = _id_docente
				ORDER BY ta.cod_area,tn.id_asig;						
	DECLARE cur3 CURSOR FOR SELECT tn.id_asig, if(tn.nota_habilitacion > 0, tn.nota_habilitacion, tn.final) AS final
				FROM nscp003 AS tn 
				LEFT JOIN matriculas AS tm ON tn.id_matric = tm.id_matric
				LEFT JOIN asignaturas AS ta ON tn.id_asig = ta.id 
				WHERE tn.periodo = _periodo AND tm.estado='2' AND tm.id_matric = _id_matic 
				AND ta.`año` = `_año`  AND ta.id_inst = _id_inst  AND tn.id_docente = _id_docente
				ORDER BY ta.cod_area,tn.id_asig;
							
	DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done = 1;
	
	SELECT tm.id_inst,tm.cod_grado,tm.grupo,tm.`año` INTO _id_inst,_cod_grado,_grupo,`_año` 
	 FROM matriculas AS tm WHERE tm.id_matric = _id_matic;
	OPEN cur_matcurso; 
	
	REPEAT 
	FETCH cur_matcurso INTO _id_asig;
		IF NOT done THEN 
		 SET x_count = x_count + 1;
			CASE x_count
				WHEN 1 THEN 
					SET aa1 = _id_asig;
				WHEN 2 THEN 
					SET aa2 = _id_asig;
				WHEN 3 THEN 
					SET aa3 = _id_asig;
				WHEN 4 THEN 
					SET aa4 = _id_asig;
				WHEN 5 THEN 
					SET aa5 = _id_asig;
				WHEN 6 THEN 
					SET aa6 = _id_asig;
				WHEN 7 THEN 
					SET aa7 = _id_asig;
				WHEN 8 THEN 
					SET aa8 = _id_asig;
				WHEN 9 THEN 
					SET aa9 = _id_asig;
				WHEN 10 THEN 
					SET aa10 = _id_asig;
				WHEN 11 THEN 
					SET aa11 = _id_asig;
				WHEN 12 THEN 
					SET aa12 = _id_asig;
				WHEN 13 THEN 
					SET aa13 = _id_asig;
				WHEN 14 THEN 
					SET aa14 = _id_asig;
				WHEN 15 THEN 
					SET aa15 = _id_asig;
				WHEN 16 THEN 
					SET aa16 = _id_asig;
				WHEN 17 THEN 
					SET aa17 = _id_asig;
				WHEN 18 THEN 
					SET aa18 = _id_asig;
				WHEN 19 THEN 
					SET aa19 = _id_asig;
				WHEN 20 THEN 
					SET aa20 = _id_asig;
				WHEN 21 THEN 
					SET aa21 = _id_asig;
				WHEN 22 THEN 
					SET aa22 = _id_asig;
				WHEN 23 THEN 
					SET aa23 = _id_asig;
				WHEN 24 THEN 
					SET aa24 = _id_asig;
				WHEN 25 THEN 
					SET aa25 = _id_asig;
				ELSE
					SET done = 1;
			END CASE;
		END IF;
	UNTIL done END REPEAT;
	CLOSE cur_matcurso;
	
	SELECT COUNT(*) INTO x_count_all FROM cursos tc WHERE tc.id_docente = _id_docente AND tc.cod_grado = _cod_grado;
	
	IF x_count_all >0 THEN 
		SELECT id_matric INTO x_id_matric FROM consolidado_docentes 
			WHERE id_matric = _id_matic AND periodo = _periodo AND id_docente = _id_docente;
		
		IF NOT x_id_matric THEN 
			INSERT INTO  consolidado_docentes (id_matric,periodo,id_docente) VALUES (_id_matic,_periodo,_id_docente);
		ELSE
			UPDATE consolidado_docentes SET nar1 = 0, nar2 = 0,nar3 = 0,nar4 = 0,nar5 = 0,nar6 = 0,nar7 = 0,nar8 = 0,nar9 = 0,nar10 = 0,
			nar11 = 0, nar12 = 0,nar13 = 0,nar14 = 0,nar15 = 0,nar16 = 0,nar17 = 0,nar18 = 0,nar19 = 0,nar20 = 0,
			nar21 = 0, nar22 = 0,nar23 = 0,nar24 = 0,nar25 = 0,
			ar1 = 0, ar2 = 0,ar3 = 0,ar4 = 0,ar5 = 0,ar6 = 0,ar7 = 0,ar8 = 0,ar9 = 0,ar10 = 0,
			ar11 = 0, ar12 = 0,ar13 = 0,ar14 = 0,ar15 = 0,ar16 = 0,ar17 = 0,ar18 = 0,ar19 = 0,ar20 = 0,
			ar21 = 0, ar22 = 0,ar23 = 0,ar24 = 0,ar25 = 0
			 WHERE id_matric = _id_matic  AND  periodo = _periodo AND id_docente = _id_docente ;
		END IF;
		SET done = 0;
		SET x_count = 0;
		CASE 
			WHEN _cod_grado >= '01' AND _cod_grado <= '05' THEN 
				OPEN cur1;
				REPEAT 
				FETCH cur1 INTO _id_asig_n,_final;
				IF NOT done THEN 
					SET x_count = x_count + 1;
					SET x_count_matcurso = 25;
					SET _suma	= _suma + _final;
					WHILE x_count_matcurso > 0 DO
						SET x_count_matcurso = x_count_matcurso - 1;
						SET x_count_2 = x_count_2 + 1 ;
						CASE x_count_2
							WHEN 1 THEN 
								IF _id_asig_n =  aa1 THEN 
									UPDATE consolidado_docentes tc SET tc.ar1 = aa1 , tc.nar1 = _final 
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
									SET x_count_matcurso = -1;
								ELSE
									UPDATE consolidado_docentes tc SET tc.ar1 = aa1 , tc.nar1 = 0
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
								END IF;
								SET done = 0;
							WHEN 2 THEN 
								IF _id_asig_n =  aa2 THEN 
									UPDATE consolidado_docentes tc SET tc.ar2 = aa2 , tc.nar2 = _final 
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
									SET x_count_matcurso = -1;
								ELSE
									UPDATE consolidado_docentes tc SET tc.ar2 = aa2 , tc.nar2 = 0
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
								END IF;
								SET done = 0;
							WHEN 3 THEN 
								IF _id_asig_n =  aa3 THEN 
									UPDATE consolidado_docentes tc SET tc.ar3 = aa3 , tc.nar3 = _final 
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
									SET x_count_matcurso = -1;
								ELSE
									UPDATE consolidado_docentes tc SET tc.ar3 = aa3 , tc.nar3 = 0
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
								END IF;
								SET done = 0;
							WHEN 4 THEN 
								IF _id_asig_n =  aa4 THEN 
									UPDATE consolidado_docentes tc SET tc.ar4 = aa4 , tc.nar4 = _final 
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
									SET x_count_matcurso = -1;
								ELSE
									UPDATE consolidado_docentes tc SET tc.ar4 = aa4 , tc.nar4 = 0
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
								END IF;
								SET done = 0;
							WHEN 5 THEN 
								IF _id_asig_n =  aa5 THEN 
									UPDATE consolidado_docentes tc SET tc.ar5 = aa5 , tc.nar5 = _final 
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
									SET x_count_matcurso = -1;
								ELSE
									UPDATE consolidado_docentes tc SET tc.ar5 = aa5 , tc.nar5 = 0
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
								END IF;
								SET done = 0;
							WHEN 6 THEN 
								IF _id_asig_n =  aa6 THEN 
									UPDATE consolidado_docentes tc SET tc.ar6 = aa6 , tc.nar6 = _final 
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
									SET x_count_matcurso = -1;
								ELSE
									UPDATE consolidado_docentes tc SET tc.ar6 = aa6 , tc.nar6 = 0
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
								END IF;
								SET done = 0;
							WHEN 7 THEN 
								IF _id_asig_n =  aa7 THEN 
									UPDATE consolidado_docentes tc SET tc.ar7 = aa7 , tc.nar7 = _final 
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
									SET x_count_matcurso = -1;
								ELSE
									UPDATE consolidado_docentes tc SET tc.ar7 = aa7 , tc.nar7 = 0
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
								END IF;
								SET done = 0;
							WHEN 8 THEN 
								IF _id_asig_n =  aa8 THEN 
									UPDATE consolidado_docentes tc SET tc.ar8 = aa8 , tc.nar8 = _final 
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
									SET x_count_matcurso = -1;
								ELSE
									UPDATE consolidado_docentes tc SET tc.ar8 = aa8 , tc.nar8 = 0
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
								END IF;
								SET done = 0;
							WHEN 9 THEN 
								IF _id_asig_n =  aa9 THEN 
									UPDATE consolidado_docentes tc SET tc.ar9 = aa9 , tc.nar9 = _final 
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
									SET x_count_matcurso = -1;
								ELSE
									UPDATE consolidado_docentes tc SET tc.ar9 = aa9 , tc.nar9 = 0
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
								END IF;
								SET done = 0;
							WHEN 10 THEN 
								IF _id_asig_n =  aa10 THEN 
									UPDATE consolidado_docentes tc SET tc.ar10 = aa10 , tc.nar10 = _final 
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
									SET x_count_matcurso = -1;
								ELSE
									UPDATE consolidado_docentes tc SET tc.ar10 = aa10 , tc.nar10 = 0
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
								END IF;
								SET done = 0;
							WHEN 11 THEN 
								IF _id_asig_n =  aa11 THEN 
									UPDATE consolidado_docentes tc SET tc.ar11 = aa11 , tc.nar11 = _final 
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
									SET x_count_matcurso = -1;
								ELSE
									UPDATE consolidado_docentes tc SET tc.ar11 = aa11 , tc.nar11 = 0
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
								END IF;
								SET done = 0;
							WHEN 12 THEN 
								IF _id_asig_n =  aa12 THEN 
									UPDATE consolidado_docentes tc SET tc.ar12 = aa12 , tc.nar12 = _final 
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
									SET x_count_matcurso = -1;
								ELSE
									UPDATE consolidado_docentes tc SET tc.ar12 = aa12 , tc.nar12 = 0
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
								END IF;
								SET done = 0;
							WHEN 13 THEN 
								IF _id_asig_n =  aa13 THEN 
									UPDATE consolidado_docentes tc SET tc.ar13 = aa13 , tc.nar13 = _final 
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
									SET x_count_matcurso = -1;
								ELSE
									UPDATE consolidado_docentes tc SET tc.ar13 = aa13 , tc.nar13 = 0
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
								END IF;
								SET done = 0;
							WHEN 14 THEN 
								IF _id_asig_n =  aa14 THEN 
									UPDATE consolidado_docentes tc SET tc.ar14 = aa14 , tc.nar14 = _final 
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
									SET x_count_matcurso = -1;
								ELSE
									UPDATE consolidado_docentes tc SET tc.ar14 = aa14 , tc.nar14 = 0
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
								END IF;
								SET done = 0;
							WHEN 15 THEN 
								IF _id_asig_n =  aa15 THEN 
									UPDATE consolidado_docentes tc SET tc.ar15 = aa15 , tc.nar15 = _final 
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
									SET x_count_matcurso = -1;
								ELSE
									UPDATE consolidado_docentes tc SET tc.ar15 = aa15 , tc.nar15 = 0
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
								END IF;
								SET done = 0;
							WHEN 16 THEN 
								IF _id_asig_n =  aa16 THEN 
									UPDATE consolidado_docentes tc SET tc.ar16 = aa16 , tc.nar16 = _final 
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
									SET x_count_matcurso = -1;
								ELSE
									UPDATE consolidado_docentes tc SET tc.ar16 = aa16 , tc.nar16 = 0
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
								END IF;
								SET done = 0;
							WHEN 17 THEN 
								IF _id_asig_n =  aa17 THEN 
									UPDATE consolidado_docentes tc SET tc.ar17 = aa17 , tc.nar17 = _final 
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
									SET x_count_matcurso = -1;
								ELSE
									UPDATE consolidado_docentes tc SET tc.ar17 = aa17 , tc.nar17 = 0
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
								END IF;
								SET done = 0;
							WHEN 18 THEN 
								IF _id_asig_n =  aa18 THEN 
									UPDATE consolidado_docentes tc SET tc.ar18 = aa18 , tc.nar18 = _final 
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
									SET x_count_matcurso = -1;
								ELSE
									UPDATE consolidado_docentes tc SET tc.ar18 = aa18 , tc.nar18 = 0
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
								END IF;
								SET done = 0;
							WHEN 19 THEN 
								IF _id_asig_n =  aa19 THEN 
									UPDATE consolidado_docentes tc SET tc.ar19 = aa19 , tc.nar19 = _final 
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
									SET x_count_matcurso = -1;
								ELSE
									UPDATE consolidado_docentes tc SET tc.ar19 = aa19 , tc.nar19 = 0
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
								END IF;
								SET done = 0;
							WHEN 20 THEN 
								IF _id_asig_n =  aa20 THEN 
									UPDATE consolidado_docentes tc SET tc.ar20 = aa20 , tc.nar20 = _final 
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
									SET x_count_matcurso = -1;
								ELSE
									UPDATE consolidado_docentes tc SET tc.ar20 = aa20 , tc.nar20 = 0
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
								END IF;
								SET done = 0;
							WHEN 21 THEN 
								IF _id_asig_n =  aa21 THEN 
									UPDATE consolidado_docentes tc SET tc.ar21 = aa21 , tc.nar21 = _final 
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
									SET x_count_matcurso = -1;
								ELSE
									UPDATE consolidado_docentes tc SET tc.ar21 = aa21 , tc.nar21 = 0
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
								END IF;
								SET done = 0;
							WHEN 22 THEN 
								IF _id_asig_n =  aa22 THEN 
									UPDATE consolidado_docentes tc SET tc.ar22 = aa22 , tc.nar22 = _final 
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
									SET x_count_matcurso = -1;
								ELSE
									UPDATE consolidado_docentes tc SET tc.ar22 = aa22 , tc.nar22 = 0
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
								END IF;
								SET done = 0;
							WHEN 23 THEN 
								IF _id_asig_n =  aa23 THEN 
									UPDATE consolidado_docentes tc SET tc.ar23 = aa23 , tc.nar23 = _final 
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
									SET x_count_matcurso = -1;
								ELSE
									UPDATE consolidado_docentes tc SET tc.ar23 = aa23 , tc.nar23 = 0
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
								END IF;
								SET done = 0;
							WHEN 24 THEN 
								IF _id_asig_n =  aa24 THEN 
									UPDATE consolidado_docentes tc SET tc.ar24 = aa24 , tc.nar24 = _final 
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
									SET x_count_matcurso = -1;
								ELSE
									UPDATE consolidado_docentes tc SET tc.ar24 = aa24 , tc.nar24 = 0
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
								END IF;
								SET done = 0;
							WHEN 25 THEN 
								IF _id_asig_n =  aa25 THEN 
									UPDATE consolidado_docentes tc SET tc.ar25 = aa25 , tc.nar25 = _final 
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
									SET x_count_matcurso = -1;
								ELSE
									UPDATE consolidado_docentes tc SET tc.ar25 = aa25 , tc.nar25 = 0
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
								END IF;
								SET done = 0;
						ELSE
							SET done = 0;
						END CASE;
					END WHILE; 
				END IF;
			UNTIL done END REPEAT;
			IF _suma > 0 THEN
				SET _suma = ROUND(_suma/x_count,2);
			END IF;
			UPDATE consolidado_docentes cn SET cn.prom = _suma
								WHERE cn.id_matric = _id_matic AND cn.periodo = _periodo;
			CLOSE cur1;
		WHEN _cod_grado >= '06' AND _cod_grado <= '09' THEN 
				OPEN cur2;
				REPEAT 
				FETCH cur2 INTO _id_asig_n,_final;
				IF NOT done THEN 
					SET x_count = x_count + 1;
					SET x_count_matcurso = 25;
					SET _suma	= _suma + _final;
					WHILE x_count_matcurso > 0 DO
						SET x_count_matcurso = x_count_matcurso - 1;
						SET x_count_2 = x_count_2 + 1 ;
						CASE x_count_2
							WHEN 1 THEN 
								IF _id_asig_n =  aa1 THEN 
									UPDATE consolidado_docentes tc SET tc.ar1 = aa1 , tc.nar1 = _final 
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
									SET x_count_matcurso = -1;
								ELSE
									UPDATE consolidado_docentes tc SET tc.ar1 = aa1 , tc.nar1 = 0
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
								END IF;
								SET done = 0;
							WHEN 2 THEN 
								IF _id_asig_n =  aa2 THEN 
									UPDATE consolidado_docentes tc SET tc.ar2 = aa2 , tc.nar2 = _final 
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
									SET x_count_matcurso = -1;
								ELSE
									UPDATE consolidado_docentes tc SET tc.ar2 = aa2 , tc.nar2 = 0
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
								END IF;
								SET done = 0;
							WHEN 3 THEN 
								IF _id_asig_n =  aa3 THEN 
									UPDATE consolidado_docentes tc SET tc.ar3 = aa3 , tc.nar3 = _final 
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
									SET x_count_matcurso = -1;
								ELSE
									UPDATE consolidado_docentes tc SET tc.ar3 = aa3 , tc.nar3 = 0
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
								END IF;
								SET done = 0;
							WHEN 4 THEN 
								IF _id_asig_n =  aa4 THEN 
									UPDATE consolidado_docentes tc SET tc.ar4 = aa4 , tc.nar4 = _final 
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
									SET x_count_matcurso = -1;
								ELSE
									UPDATE consolidado_docentes tc SET tc.ar4 = aa4 , tc.nar4 = 0
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
								END IF;
								SET done = 0;
							WHEN 5 THEN 
								IF _id_asig_n =  aa5 THEN 
									UPDATE consolidado_docentes tc SET tc.ar5 = aa5 , tc.nar5 = _final 
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
									SET x_count_matcurso = -1;
								ELSE
									UPDATE consolidado_docentes tc SET tc.ar5 = aa5 , tc.nar5 = 0
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
								END IF;
								SET done = 0;
							WHEN 6 THEN 
								IF _id_asig_n =  aa6 THEN 
									UPDATE consolidado_docentes tc SET tc.ar6 = aa6 , tc.nar6 = _final 
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
									SET x_count_matcurso = -1;
								ELSE
									UPDATE consolidado_docentes tc SET tc.ar6 = aa6 , tc.nar6 = 0
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
								END IF;
								SET done = 0;
							WHEN 7 THEN 
								IF _id_asig_n =  aa7 THEN 
									UPDATE consolidado_docentes tc SET tc.ar7 = aa7 , tc.nar7 = _final 
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
									SET x_count_matcurso = -1;
								ELSE
									UPDATE consolidado_docentes tc SET tc.ar7 = aa7 , tc.nar7 = 0
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
								END IF;
								SET done = 0;
							WHEN 8 THEN 
								IF _id_asig_n =  aa8 THEN 
									UPDATE consolidado_docentes tc SET tc.ar8 = aa8 , tc.nar8 = _final 
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
									SET x_count_matcurso = -1;
								ELSE
									UPDATE consolidado_docentes tc SET tc.ar8 = aa8 , tc.nar8 = 0
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
								END IF;
								SET done = 0;
							WHEN 9 THEN 
								IF _id_asig_n =  aa9 THEN 
									UPDATE consolidado_docentes tc SET tc.ar9 = aa9 , tc.nar9 = _final 
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
									SET x_count_matcurso = -1;
								ELSE
									UPDATE consolidado_docentes tc SET tc.ar9 = aa9 , tc.nar9 = 0
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
								END IF;
								SET done = 0;
							WHEN 10 THEN 
								IF _id_asig_n =  aa10 THEN 
									UPDATE consolidado_docentes tc SET tc.ar10 = aa10 , tc.nar10 = _final 
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
									SET x_count_matcurso = -1;
								ELSE
									UPDATE consolidado_docentes tc SET tc.ar10 = aa10 , tc.nar10 = 0
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
								END IF;
								SET done = 0;
							WHEN 11 THEN 
								IF _id_asig_n =  aa11 THEN 
									UPDATE consolidado_docentes tc SET tc.ar11 = aa11 , tc.nar11 = _final 
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
									SET x_count_matcurso = -1;
								ELSE
									UPDATE consolidado_docentes tc SET tc.ar11 = aa11 , tc.nar11 = 0
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
								END IF;
								SET done = 0;
							WHEN 12 THEN 
								IF _id_asig_n =  aa12 THEN 
									UPDATE consolidado_docentes tc SET tc.ar12 = aa12 , tc.nar12 = _final 
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
									SET x_count_matcurso = -1;
								ELSE
									UPDATE consolidado_docentes tc SET tc.ar12 = aa12 , tc.nar12 = 0
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
								END IF;
								SET done = 0;
							WHEN 13 THEN 
								IF _id_asig_n =  aa13 THEN 
									UPDATE consolidado_docentes tc SET tc.ar13 = aa13 , tc.nar13 = _final 
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
									SET x_count_matcurso = -1;
								ELSE
									UPDATE consolidado_docentes tc SET tc.ar13 = aa13 , tc.nar13 = 0
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
								END IF;
								SET done = 0;
							WHEN 14 THEN 
								IF _id_asig_n =  aa14 THEN 
									UPDATE consolidado_docentes tc SET tc.ar14 = aa14 , tc.nar14 = _final 
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
									SET x_count_matcurso = -1;
								ELSE
									UPDATE consolidado_docentes tc SET tc.ar14 = aa14 , tc.nar14 = 0
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
								END IF;
								SET done = 0;
							WHEN 15 THEN 
								IF _id_asig_n =  aa15 THEN 
									UPDATE consolidado_docentes tc SET tc.ar15 = aa15 , tc.nar15 = _final 
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
									SET x_count_matcurso = -1;
								ELSE
									UPDATE consolidado_docentes tc SET tc.ar15 = aa15 , tc.nar15 = 0
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
								END IF;
								SET done = 0;
							WHEN 16 THEN 
								IF _id_asig_n =  aa16 THEN 
									UPDATE consolidado_docentes tc SET tc.ar16 = aa16 , tc.nar16 = _final 
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
									SET x_count_matcurso = -1;
								ELSE
									UPDATE consolidado_docentes tc SET tc.ar16 = aa16 , tc.nar16 = 0
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
								END IF;
								SET done = 0;
							WHEN 17 THEN 
								IF _id_asig_n =  aa17 THEN 
									UPDATE consolidado_docentes tc SET tc.ar17 = aa17 , tc.nar17 = _final 
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
									SET x_count_matcurso = -1;
								ELSE
									UPDATE consolidado_docentes tc SET tc.ar17 = aa17 , tc.nar17 = 0
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
								END IF;
								SET done = 0;
							WHEN 18 THEN 
								IF _id_asig_n =  aa18 THEN 
									UPDATE consolidado_docentes tc SET tc.ar18 = aa18 , tc.nar18 = _final 
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
									SET x_count_matcurso = -1;
								ELSE
									UPDATE consolidado_docentes tc SET tc.ar18 = aa18 , tc.nar18 = 0
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
								END IF;
								SET done = 0;
							WHEN 19 THEN 
								IF _id_asig_n =  aa19 THEN 
									UPDATE consolidado_docentes tc SET tc.ar19 = aa19 , tc.nar19 = _final 
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
									SET x_count_matcurso = -1;
								ELSE
									UPDATE consolidado_docentes tc SET tc.ar19 = aa19 , tc.nar19 = 0
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
								END IF;
								SET done = 0;
							WHEN 20 THEN 
								IF _id_asig_n =  aa20 THEN 
									UPDATE consolidado_docentes tc SET tc.ar20 = aa20 , tc.nar20 = _final 
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
									SET x_count_matcurso = -1;
								ELSE
									UPDATE consolidado_docentes tc SET tc.ar20 = aa20 , tc.nar20 = 0
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
								END IF;
								SET done = 0;
							WHEN 21 THEN 
								IF _id_asig_n =  aa21 THEN 
									UPDATE consolidado_docentes tc SET tc.ar21 = aa21 , tc.nar21 = _final 
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
									SET x_count_matcurso = -1;
								ELSE
									UPDATE consolidado_docentes tc SET tc.ar21 = aa21 , tc.nar21 = 0
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
								END IF;
								SET done = 0;
							WHEN 22 THEN 
								IF _id_asig_n =  aa22 THEN 
									UPDATE consolidado_docentes tc SET tc.ar22 = aa22 , tc.nar22 = _final 
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
									SET x_count_matcurso = -1;
								ELSE
									UPDATE consolidado_docentes tc SET tc.ar22 = aa22 , tc.nar22 = 0
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
								END IF;
								SET done = 0;
							WHEN 23 THEN 
								IF _id_asig_n =  aa23 THEN 
									UPDATE consolidado_docentes tc SET tc.ar23 = aa23 , tc.nar23 = _final 
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
									SET x_count_matcurso = -1;
								ELSE
									UPDATE consolidado_docentes tc SET tc.ar23 = aa23 , tc.nar23 = 0
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
								END IF;
								SET done = 0;
							WHEN 24 THEN 
								IF _id_asig_n =  aa24 THEN 
									UPDATE consolidado_docentes tc SET tc.ar24 = aa24 , tc.nar24 = _final 
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
									SET x_count_matcurso = -1;
								ELSE
									UPDATE consolidado_docentes tc SET tc.ar24 = aa24 , tc.nar24 = 0
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
								END IF;
								SET done = 0;
							WHEN 25 THEN 
								IF _id_asig_n =  aa25 THEN 
									UPDATE consolidado_docentes tc SET tc.ar25 = aa25 , tc.nar25 = _final 
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
									SET x_count_matcurso = -1;
								ELSE
									UPDATE consolidado_docentes tc SET tc.ar25 = aa25 , tc.nar25 = 0
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
								END IF;
								SET done = 0;
						ELSE
							SET done = 0;
						END CASE;
					END WHILE; 
				END IF;
			UNTIL done END REPEAT;
			IF _suma > 0 THEN
				SET _suma = ROUND(_suma/x_count,2);
			END IF;
			UPDATE consolidado_docentes cn SET cn.prom = _suma
								WHERE cn.id_matric = _id_matic AND cn.periodo = _periodo;
			CLOSE cur2;
		WHEN _cod_grado >= '10' AND _cod_grado <= '99' THEN 
				OPEN cur3;
				REPEAT 
				FETCH cur3 INTO _id_asig_n,_final;
				IF NOT done THEN 
					SET x_count = x_count + 1;
					SET x_count_matcurso = 25;
					SET _suma	= _suma + _final;
					WHILE x_count_matcurso > 0 DO
						SET x_count_matcurso = x_count_matcurso - 1;
						SET x_count_2 = x_count_2 + 1 ;
						CASE x_count_2
							WHEN 1 THEN 
								IF _id_asig_n =  aa1 THEN 
									UPDATE consolidado_docentes tc SET tc.ar1 = aa1 , tc.nar1 = _final 
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
									SET x_count_matcurso = -1;
								ELSE
									UPDATE consolidado_docentes tc SET tc.ar1 = aa1 , tc.nar1 = 0
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
								END IF;
								SET done = 0;
							WHEN 2 THEN 
								IF _id_asig_n =  aa2 THEN 
									UPDATE consolidado_docentes tc SET tc.ar2 = aa2 , tc.nar2 = _final 
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
									SET x_count_matcurso = -1;
								ELSE
									UPDATE consolidado_docentes tc SET tc.ar2 = aa2 , tc.nar2 = 0
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
								END IF;
								SET done = 0;
							WHEN 3 THEN 
								IF _id_asig_n =  aa3 THEN 
									UPDATE consolidado_docentes tc SET tc.ar3 = aa3 , tc.nar3 = _final 
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
									SET x_count_matcurso = -1;
								ELSE
									UPDATE consolidado_docentes tc SET tc.ar3 = aa3 , tc.nar3 = 0
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
								END IF;
								SET done = 0;
							WHEN 4 THEN 
								IF _id_asig_n =  aa4 THEN 
									UPDATE consolidado_docentes tc SET tc.ar4 = aa4 , tc.nar4 = _final 
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
									SET x_count_matcurso = -1;
								ELSE
									UPDATE consolidado_docentes tc SET tc.ar4 = aa4 , tc.nar4 = 0
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
								END IF;
								SET done = 0;
							WHEN 5 THEN 
								IF _id_asig_n =  aa5 THEN 
									UPDATE consolidado_docentes tc SET tc.ar5 = aa5 , tc.nar5 = _final 
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
									SET x_count_matcurso = -1;
								ELSE
									UPDATE consolidado_docentes tc SET tc.ar5 = aa5 , tc.nar5 = 0
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
								END IF;
								SET done = 0;
							WHEN 6 THEN 
								IF _id_asig_n =  aa6 THEN 
									UPDATE consolidado_docentes tc SET tc.ar6 = aa6 , tc.nar6 = _final 
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
									SET x_count_matcurso = -1;
								ELSE
									UPDATE consolidado_docentes tc SET tc.ar6 = aa6 , tc.nar6 = 0
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
								END IF;
								SET done = 0;
							WHEN 7 THEN 
								IF _id_asig_n =  aa7 THEN 
									UPDATE consolidado_docentes tc SET tc.ar7 = aa7 , tc.nar7 = _final 
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
									SET x_count_matcurso = -1;
								ELSE
									UPDATE consolidado_docentes tc SET tc.ar7 = aa7 , tc.nar7 = 0
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
								END IF;
								SET done = 0;
							WHEN 8 THEN 
								IF _id_asig_n =  aa8 THEN 
									UPDATE consolidado_docentes tc SET tc.ar8 = aa8 , tc.nar8 = _final 
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
									SET x_count_matcurso = -1;
								ELSE
									UPDATE consolidado_docentes tc SET tc.ar8 = aa8 , tc.nar8 = 0
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
								END IF;
								SET done = 0;
							WHEN 9 THEN 
								IF _id_asig_n =  aa9 THEN 
									UPDATE consolidado_docentes tc SET tc.ar9 = aa9 , tc.nar9 = _final 
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
									SET x_count_matcurso = -1;
								ELSE
									UPDATE consolidado_docentes tc SET tc.ar9 = aa9 , tc.nar9 = 0
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
								END IF;
								SET done = 0;
							WHEN 10 THEN 
								IF _id_asig_n =  aa10 THEN 
									UPDATE consolidado_docentes tc SET tc.ar10 = aa10 , tc.nar10 = _final 
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
									SET x_count_matcurso = -1;
								ELSE
									UPDATE consolidado_docentes tc SET tc.ar10 = aa10 , tc.nar10 = 0
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
								END IF;
								SET done = 0;
							WHEN 11 THEN 
								IF _id_asig_n =  aa11 THEN 
									UPDATE consolidado_docentes tc SET tc.ar11 = aa11 , tc.nar11 = _final 
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
									SET x_count_matcurso = -1;
								ELSE
									UPDATE consolidado_docentes tc SET tc.ar11 = aa11 , tc.nar11 = 0
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
								END IF;
								SET done = 0;
							WHEN 12 THEN 
								IF _id_asig_n =  aa12 THEN 
									UPDATE consolidado_docentes tc SET tc.ar12 = aa12 , tc.nar12 = _final 
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
									SET x_count_matcurso = -1;
								ELSE
									UPDATE consolidado_docentes tc SET tc.ar12 = aa12 , tc.nar12 = 0
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
								END IF;
								SET done = 0;
							WHEN 13 THEN 
								IF _id_asig_n =  aa13 THEN 
									UPDATE consolidado_docentes tc SET tc.ar13 = aa13 , tc.nar13 = _final 
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
									SET x_count_matcurso = -1;
								ELSE
									UPDATE consolidado_docentes tc SET tc.ar13 = aa13 , tc.nar13 = 0
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
								END IF;
								SET done = 0;
							WHEN 14 THEN 
								IF _id_asig_n =  aa14 THEN 
									UPDATE consolidado_docentes tc SET tc.ar14 = aa14 , tc.nar14 = _final 
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
									SET x_count_matcurso = -1;
								ELSE
									UPDATE consolidado_docentes tc SET tc.ar14 = aa14 , tc.nar14 = 0
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
								END IF;
								SET done = 0;
							WHEN 15 THEN 
								IF _id_asig_n =  aa15 THEN 
									UPDATE consolidado_docentes tc SET tc.ar15 = aa15 , tc.nar15 = _final 
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
									SET x_count_matcurso = -1;
								ELSE
									UPDATE consolidado_docentes tc SET tc.ar15 = aa15 , tc.nar15 = 0
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
								END IF;
								SET done = 0;
							WHEN 16 THEN 
								IF _id_asig_n =  aa16 THEN 
									UPDATE consolidado_docentes tc SET tc.ar16 = aa16 , tc.nar16 = _final 
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
									SET x_count_matcurso = -1;
								ELSE
									UPDATE consolidado_docentes tc SET tc.ar16 = aa16 , tc.nar16 = 0
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
								END IF;
								SET done = 0;
							WHEN 17 THEN 
								IF _id_asig_n =  aa17 THEN 
									UPDATE consolidado_docentes tc SET tc.ar17 = aa17 , tc.nar17 = _final 
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
									SET x_count_matcurso = -1;
								ELSE
									UPDATE consolidado_docentes tc SET tc.ar17 = aa17 , tc.nar17 = 0
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
								END IF;
								SET done = 0;
							WHEN 18 THEN 
								IF _id_asig_n =  aa18 THEN 
									UPDATE consolidado_docentes tc SET tc.ar18 = aa18 , tc.nar18 = _final 
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
									SET x_count_matcurso = -1;
								ELSE
									UPDATE consolidado_docentes tc SET tc.ar18 = aa18 , tc.nar18 = 0
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
								END IF;
								SET done = 0;
							WHEN 19 THEN 
								IF _id_asig_n =  aa19 THEN 
									UPDATE consolidado_docentes tc SET tc.ar19 = aa19 , tc.nar19 = _final 
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
									SET x_count_matcurso = -1;
								ELSE
									UPDATE consolidado_docentes tc SET tc.ar19 = aa19 , tc.nar19 = 0
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
								END IF;
								SET done = 0;
							WHEN 20 THEN 
								IF _id_asig_n =  aa20 THEN 
									UPDATE consolidado_docentes tc SET tc.ar20 = aa20 , tc.nar20 = _final 
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
									SET x_count_matcurso = -1;
								ELSE
									UPDATE consolidado_docentes tc SET tc.ar20 = aa20 , tc.nar20 = 0
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
								END IF;
								SET done = 0;
							WHEN 21 THEN 
								IF _id_asig_n =  aa21 THEN 
									UPDATE consolidado_docentes tc SET tc.ar21 = aa21 , tc.nar21 = _final 
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
									SET x_count_matcurso = -1;
								ELSE
									UPDATE consolidado_docentes tc SET tc.ar21 = aa21 , tc.nar21 = 0
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
								END IF;
								SET done = 0;
							WHEN 22 THEN 
								IF _id_asig_n =  aa22 THEN 
									UPDATE consolidado_docentes tc SET tc.ar22 = aa22 , tc.nar22 = _final 
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
									SET x_count_matcurso = -1;
								ELSE
									UPDATE consolidado_docentes tc SET tc.ar22 = aa22 , tc.nar22 = 0
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
								END IF;
								SET done = 0;
							WHEN 23 THEN 
								IF _id_asig_n =  aa23 THEN 
									UPDATE consolidado_docentes tc SET tc.ar23 = aa23 , tc.nar23 = _final 
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
									SET x_count_matcurso = -1;
								ELSE
									UPDATE consolidado_docentes tc SET tc.ar23 = aa23 , tc.nar23 = 0
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
								END IF;
								SET done = 0;
							WHEN 24 THEN 
								IF _id_asig_n =  aa24 THEN 
									UPDATE consolidado_docentes tc SET tc.ar24 = aa24 , tc.nar24 = _final 
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
									SET x_count_matcurso = -1;
								ELSE
									UPDATE consolidado_docentes tc SET tc.ar24 = aa24 , tc.nar24 = 0
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
								END IF;
								SET done = 0;
							WHEN 25 THEN 
								IF _id_asig_n =  aa25 THEN 
									UPDATE consolidado_docentes tc SET tc.ar25 = aa25 , tc.nar25 = _final 
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
									SET x_count_matcurso = -1;
								ELSE
									UPDATE consolidado_docentes tc SET tc.ar25 = aa25 , tc.nar25 = 0
									WHERE tc.id_matric = _id_matic AND tc.periodo = _periodo AND tc.id_docente = _id_docente;
								END IF;
								SET done = 0;
						ELSE
							SET done = 0;
						END CASE;
					END WHILE; 
				END IF;
			UNTIL done END REPEAT;
			IF _suma > 0 THEN
				SET _suma = ROUND(_suma/x_count,2);
			END IF;
			UPDATE consolidado_docentes cn SET cn.prom = _suma
								WHERE cn.id_matric = _id_matic AND cn.periodo = _periodo;
			CLOSE cur3;
		ELSE
			SET done = 1;
		END CASE;	
	END IF;
END$$

DROP PROCEDURE IF EXISTS `sp_cons_estudio`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_cons_estudio` (IN `_id_inst` INT(30), IN `_año` YEAR, IN `_id_matric` INT(30), IN `_type` INT(1))  BEGIN
	SELECT fn_cons_estudio(_id_inst, _año, _id_matric, _type);
END$$

DROP PROCEDURE IF EXISTS `sp_conv_select_acciones_est`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_conv_select_acciones_est` (IN `_id_inst` INT(20), IN `_año` YEAR, IN `_id` INT(30))  BEGIN
	SELECT tm.id_inst,tm.grupo,tm.id_jorn,tm.cod_grado,t1.personas_involucradas,t1.testigos,t1.personas_afectadas,t1.compromiso,
		t1.tratamiento_peg,t1.firma_ivolucrados,t1.obs_accion,t1.fecha_registro,t1.`año`,t2.observacion, 
		t2.fecha_registro AS fecha_situacion, t3.descripcion AS situacion, t4.descripcion AS tipo_situacion,
		CONCAT(RTRIM(ti.apellido1),' ',RTRIM(ti.apellido2),' ',RTRIM(ti.nombre1),' ',RTRIM(ti.nombre2))  AS estudiante,
		CONCAT(RTRIM(td.apellido1),' ',RTRIM(td.apellido2),' ',RTRIM(td.nombre1),' ',RTRIM(td.nombre2))  AS docente,
		CONCAT(RTRIM(ta.apellido1),' ',RTRIM(ta.apellido2),' ',RTRIM(ta.nombre1),' ',RTRIM(ta.nombre2))  AS admin,
		CONCAT(RTRIM(ta.apellido1),' ',RTRIM(ta.apellido2),' ',RTRIM(ta.nombre1),' ',RTRIM(ta.nombre2))  AS psicoorientador,
		RTRIM(tg.grado) AS grado, RTRIM(tj.JORNADA) AS jornada, RTRIM(ts.NOM_SEDE) AS sede,
		RTRIM(tac.nombre) AS accion 
 		FROM conv_reg_acciones_est t1 
		LEFT JOIN conv_reg_situaciones_est t2 ON t1.id_res_sit_est = t2.id 
		LEFT JOIN conv_situaciones t3 ON t2.id_situacion = t3.id
		LEFT JOIN conv_tipo_situaciones t4 ON t3.id_tipo = t4.id 
		LEFT JOIN administrativos ta ON (t2.id_admin = ta.id AND t1.id_admin = ta.id) 
		LEFT JOIN docentes td ON t2.id_docente = td.id_docente
		LEFT JOIN matriculas tm ON t2.id_matric = tm.id_matric
		LEFT JOIN inscripciones ti ON tm.cod_est = ti.cod_est
		LEFT JOIN grados tg ON tm.cod_grado = tg.COD_GRADO 
		LEFT JOIN jornadas tj ON tm.id_jorn = tj.COD_JORN
		LEFT JOIN sedes ts ON tm.id_sede = ts.ID
		LEFT JOIN conv_acciones tac ON t1.id_accion = tac.id
		WHERE t1.id = _id AND t1.`año` = `_año` AND t2.`año` = `_año` AND t4.id_inst = _id_inst 
		AND t3.id_inst = _id_inst AND t3.`año` = `_año` AND ta.id_inst = _id_inst AND td.`año` = `_año` 
		AND td.id_inst = _id_inst AND tm.id_inst = _id_inst AND tm.`año` = `_año` AND ts.ID_INST = _id_inst
		AND tac.id_inst = _id_inst;
END$$

DROP PROCEDURE IF EXISTS `sp_conv_select_control_seguimiento_est_situacion`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_conv_select_control_seguimiento_est_situacion` (IN `_id_matric` INT(30), IN `_id_situacion` INT(30), IN `_id_inst` INT(30), IN `_año` YEAR)  BEGIN
	SELECT t1.id, CONCAT(RTRIM(ti.apellido1),' ',RTRIM(ti.apellido2),' ',RTRIM(ti.nombre1),' ',RTRIM(ti.nombre2)) estudiante,
	RTRIM(tg.grado) grado, tm.grupo, RTRIM(tj.JORNADA) jornada, RTRIM(ts.NOM_SEDE) sede, 
	CONCAT(RTRIM(td.apellido1),' ',RTRIM(td.apellido2),' ',RTRIM(td.nombre1),' ',RTRIM(td.nombre2)) docente, 
	CONCAT(RTRIM(tad.apellido1),' ',RTRIM(tad.apellido2),' ',RTRIM(tad.nombre1),' ',RTRIM(tad.nombre2)) coordinador,
	t1.observacion, t1.fecha_registro,t1.`año`, t2.descripcion situacion, t3.descripcion tipo 
	FROM inscripciones AS ti 
	LEFT JOIN matriculas AS tm ON tm.cod_est = ti.cod_est
	LEFT JOIN conv_reg_situaciones_est AS t1 ON t1.id_matric = tm.id_matric 
	LEFT JOIN grados AS tg ON tm.cod_grado =  tg.COD_GRADO 
	LEFT JOIN sedes AS ts ON tm.id_sede = ts.ID 
	LEFT JOIN jornadas AS tj ON tm.id_jorn = tj.COD_JORN 
	LEFT JOIN docentes AS td ON t1.id_docente = td.id_docente
	LEFT JOIN administrativos AS tad ON t1.id_admin = tad.id 
	LEFT JOIN conv_situaciones AS t2 ON t1.id_situacion = t2.id 
	LEFT JOIN conv_tipo_situaciones AS t3 ON t2.id_tipo = t3.id 
	WHERE ti.id_inst = _id_inst AND tm.id_matric = _id_matric AND ts.ID_INST = _id_inst 
	AND td.id_inst = _id_inst AND td.`año` = `_año` AND tad.id_inst = _id_inst AND t1.id_matric = _id_matric 
	AND t1.id = _id_situacion AND t2.id_inst = _id_inst AND t2.`año` = `_año` AND t3.id_inst = _id_inst; 
END$$

DROP PROCEDURE IF EXISTS `sp_criterios_obs_m3`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_criterios_obs_m3` (IN `_id_inst` INT(20), IN `_id_observador` INT(20), IN `_id_docente` INT(20), IN `_año` YEAR)  BEGIN
	DECLARE done, _count, _id INT DEFAULT 0;
	DECLARE cur1 CURSOR FOR SELECT tc.id FROM obs_criterios tc WHERE 
								tc.id_inst = _id_inst AND tc.estado = 1 ORDER BY tc.id;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done = 1;
	
	SELECT COUNT(id) INTO _count FROM obs_items_modelo_3 ti WHERE ti.id_observador = _id_observador;
	
	IF NOT _count THEN 
		OPEN cur1;
		REPEAT 
			FETCH cur1 INTO _id;
			IF NOT done THEN
				INSERT INTO obs_items_modelo_3 (id_observador,id_docente,id_item_criterio) VALUES (_id_observador,_id_docente,_id); 
			END IF;
		UNTIL done END REPEAT;
	END IF;
	
	SELECT ti.*, tc.descripcion AS criterio, tp.descripcion AS aspecto FROM obs_items_modelo_3 ti LEFT JOIN obs_criterios tc 
	ON ti.id_item_criterio = tc.id LEFT JOIN obs_items_modelos tp 
	ON tc.id_item_modelo = tp.id WHERE ti.id_observador = _id_observador AND 
	tc.id_inst = _id_inst AND tc.estado = 1 AND tp.id_inst = _id_inst AND tp.`año` = `_año` AND tp.estado = 1 
	ORDER BY tp.descripcion, tc.descripcion;
	
END$$

DROP PROCEDURE IF EXISTS `sp_desempeño`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_desempeño` (IN `_id_inst` INT(30), IN `_año` YEAR, IN `_nota` DECIMAL(6,2), IN `_grado` VARCHAR(2))  BEGIN
	IF _grado BETWEEN '21' AND '26' THEN
		SELECT RTRIM(t.`desempeño`) AS desempeño FROM `cdesempeños` t
		WHERE _nota BETWEEN t.desde AND t.hasta AND t.`año` = _año AND t.id_inst = _id_inst; 
	ELSE
		SELECT RTRIM(t.`desempeño`) AS desempeño FROM `desempeños` t
		WHERE _nota BETWEEN t.desde AND t.hasta AND t.`año` = _año AND t.id_inst = _id_inst;
	END IF;
END$$

DROP PROCEDURE IF EXISTS `sp_desempeños`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_desempeños` (IN `_id_inst` INT(20), IN `_año` INT(4))  BEGIN
	select * from desempeños where año=_año and id_inst=_id_inst;
END$$

DROP PROCEDURE IF EXISTS `sp_estadistica_grupo`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_estadistica_grupo` (IN `_id_inst` INT(20), IN `_año` YEAR, IN `_type` INT(1), IN `_periodo` VARCHAR(1))  BEGIN
	IF _periodo <> '0' THEN 		
		CASE 
			WHEN _type = 2 THEN /*BÁSICA PRIMARIA*/
				DELETE FROM estadistica_grupo  WHERE cod_grado BETWEEN 5 AND 9 AND id_inst = _id_inst 
				AND `año` = `_año` AND periodo = _periodo ;			
				INSERT INTO estadistica_grupo(id_inst,id_sede,cod_grado,grupo,total,id_desempeño,periodo,año,id_matric) 
				(SELECT tm.id_inst,tm.id_sede,tg.id,tm.grupo, COUNT(tc.id_asig) AS tas, 
					te.id, tn.periodo,tm.año, tm.id_matric 
					FROM nscp001 AS tn
					LEFT JOIN cursos AS tc ON (tn.id_curso = tc.id AND tn.`año` = tc.`año`)
					LEFT JOIN matriculas AS tm ON tn.id_matric = tm.id_matric
					LEFT JOIN escala_nacional AS te ON tn.id_escala = te.id	
					LEFT JOIN grados AS tg ON tm.id_grado = tg.id
					WHERE tn.id_matric = tm.id_matric AND tn.id_curso = tc.id
					AND tn.final > 0   AND tn.periodo = _periodo
					AND tn.`año` = `_año` AND tc.`año` = `_año` AND tm.año= `_año`
					AND tm.id_estado = 2 AND tm.id_grado = tg.id AND tn.id_escala = te.id
					AND tg.id_nivel = _type
					GROUP BY tm.id_inst,tm.id_sede,tn.id_matric,tm.id_grado,tm.grupo, tn.periodo, tn.id_escala
					ORDER BY tm.año,tm.id_sede,tg.cod_grado,tm.grupo,tn.periodo,tn.id_escala,tas);
			WHEN _type = 3 THEN /*BÁSICA SECUNDARIA*/
				DELETE FROM estadistica_grupo  WHERE cod_grado BETWEEN 10 AND 13 AND id_inst = _id_inst 
				AND `año` = `_año` AND periodo = _periodo ;
				
				INSERT INTO estadistica_grupo(id_inst,id_sede,cod_grado,grupo,total,id_desempeño,periodo,año,id_matric) 
				(SELECT tm.id_inst,tm.id_sede,tg.id,tm.grupo, COUNT(tc.id_asig) AS tas, 
					te.id, tn.periodo,tm.año, tm.id_matric 
					FROM nscp002 AS tn
					LEFT JOIN cursos AS tc ON (tn.id_curso = tc.id AND tn.`año` = tc.`año`)
					LEFT JOIN matriculas AS tm ON tn.id_matric = tm.id_matric
					LEFT JOIN escala_nacional AS te ON tn.id_escala = te.id	
					LEFT JOIN grados AS tg ON tm.id_grado = tg.id
					WHERE tn.id_matric = tm.id_matric AND tn.id_curso = tc.id
					AND tn.final > 0   AND tn.periodo = _periodo
					AND tn.`año` = `_año` AND tc.`año` = `_año` AND tm.año= `_año`
					AND tm.id_estado = 2 AND tm.id_grado = tg.id AND tn.id_escala = te.id
					AND tg.id_nivel = _type
					GROUP BY tm.id_inst,tm.id_sede,tn.id_matric,tm.id_grado,tm.grupo, tn.periodo, tn.id_escala
					ORDER BY tm.año,tm.id_sede,tg.cod_grado,tm.grupo,tn.periodo,tn.id_escala,tas);
			ELSE	/* MEDIA y más */
				DELETE FROM estadistica_grupo  WHERE cod_grado > 13 AND id_inst = _id_inst 
				AND `año` = `_año` AND periodo = _periodo ;
				
				INSERT INTO estadistica_grupo(id_inst,id_sede,cod_grado,grupo,total,id_desempeño,periodo,año,id_matric) 
				(SELECT tm.id_inst,tm.id_sede,tg.id,tm.grupo, COUNT(tc.id_asig) AS tas, 
					te.id, tn.periodo,tm.año, tm.id_matric 
					FROM nscp003 AS tn
					LEFT JOIN cursos AS tc ON (tn.id_curso = tc.id AND tn.`año` = tc.`año`)
					LEFT JOIN matriculas AS tm ON tn.id_matric = tm.id_matric
					LEFT JOIN escala_nacional AS te ON tn.id_escala = te.id	
					LEFT JOIN grados AS tg ON tm.id_grado = tg.id
					WHERE tn.id_matric = tm.id_matric AND tn.id_curso = tc.id
					AND tn.final > 0   AND tn.periodo = _periodo
					AND tn.`año` = `_año` AND tc.`año` = `_año` AND tm.año= `_año`
					AND tm.id_estado = 2 AND tm.id_grado = tg.id AND tn.id_escala = te.id
					AND tg.id_nivel = _type
					GROUP BY tm.id_inst,tm.id_sede,tn.id_matric,tm.id_grado,tm.grupo, tn.periodo, tn.id_escala
					ORDER BY tm.año,tm.id_sede,tg.cod_grado,tm.grupo,tn.periodo,tn.id_escala,tas);
			END CASE;
	ELSE
		CASE 
			WHEN _type = 2 THEN /*BÁSICA PRIMARIA*/
				DELETE FROM estadistica_grupo  WHERE cod_grado BETWEEN 5 AND 9 AND id_inst = _id_inst 
				AND `año` = `_año` AND periodo = _periodo ;			
				INSERT INTO estadistica_grupo(id_inst,id_sede,cod_grado,grupo,total,id_desempeño,periodo,año,id_matric) 
				(SELECT tm.id_inst,tm.id_sede,tg.id,tm.grupo, COUNT(tc.id_asig) AS tas, 
					te.id, tn.periodo,tm.año, tm.id_matric 
					FROM nscp001 AS tn
					LEFT JOIN cursos AS tc ON (tn.id_curso = tc.id AND tn.`año` = tc.`año`)
					LEFT JOIN matriculas AS tm ON tn.id_matric = tm.id_matric
					LEFT JOIN escala_nacional AS te ON tn.id_escala = te.id	
					LEFT JOIN grados AS tg ON tm.id_grado = tg.id
					WHERE tn.id_matric = tm.id_matric AND tn.id_curso = tc.id
					AND tn.final > 0 AND tn.`año` = `_año` AND tc.`año` = `_año` AND tm.año= `_año`
					AND tm.id_estado = 2 AND tm.id_grado = tg.id AND tn.id_escala = te.id
					AND tg.id_nivel = _type
					GROUP BY tm.id_inst,tm.id_sede,tn.id_matric,tm.id_grado,tm.grupo, tn.periodo, tn.id_escala
					ORDER BY tm.año,tm.id_sede,tg.cod_grado,tm.grupo,tn.periodo,tn.id_escala,tas);
			WHEN _type = 3 THEN /*BÁSICA SECUNDARIA*/
				DELETE FROM estadistica_grupo  WHERE cod_grado BETWEEN 10 AND 13 AND id_inst = _id_inst 
				AND `año` = `_año` AND periodo = _periodo ;
				
				INSERT INTO estadistica_grupo(id_inst,id_sede,cod_grado,grupo,total,id_desempeño,periodo,año,id_matric) 
				(SELECT tm.id_inst,tm.id_sede,tg.id,tm.grupo, COUNT(tc.id_asig) AS tas, 
					te.id, tn.periodo,tm.año, tm.id_matric 
					FROM nscp002 AS tn
					LEFT JOIN cursos AS tc ON (tn.id_curso = tc.id AND tn.`año` = tc.`año`)
					LEFT JOIN matriculas AS tm ON tn.id_matric = tm.id_matric
					LEFT JOIN escala_nacional AS te ON tn.id_escala = te.id	
					LEFT JOIN grados AS tg ON tm.id_grado = tg.id
					WHERE tn.id_matric = tm.id_matric AND tn.id_curso = tc.id
					AND tn.final > 0 AND tn.`año` = `_año` AND tc.`año` = `_año` AND tm.año= `_año`
					AND tm.id_estado = 2 AND tm.id_grado = tg.id AND tn.id_escala = te.id
					AND tg.id_nivel = _type
					GROUP BY tm.id_inst,tm.id_sede,tn.id_matric,tm.id_grado,tm.grupo, tn.periodo, tn.id_escala
					ORDER BY tm.año,tm.id_sede,tg.cod_grado,tm.grupo,tn.periodo,tn.id_escala,tas);
			ELSE	/* MEDIA y más */
				DELETE FROM estadistica_grupo  WHERE cod_grado > 13 AND id_inst = _id_inst 
				AND `año` = `_año` AND periodo = _periodo ;
				
				INSERT INTO estadistica_grupo(id_inst,id_sede,cod_grado,grupo,total,id_desempeño,periodo,año,id_matric) 
				(SELECT tm.id_inst,tm.id_sede,tg.id,tm.grupo, COUNT(tc.id_asig) AS tas, 
					te.id, tn.periodo,tm.año, tm.id_matric 
					FROM nscp003 AS tn
					LEFT JOIN cursos AS tc ON (tn.id_curso = tc.id AND tn.`año` = tc.`año`)
					LEFT JOIN matriculas AS tm ON tn.id_matric = tm.id_matric
					LEFT JOIN escala_nacional AS te ON tn.id_escala = te.id	
					LEFT JOIN grados AS tg ON tm.id_grado = tg.id
					WHERE tn.id_matric = tm.id_matric AND tn.id_curso = tc.id
					AND tn.final > 0  AND tn.`año` = `_año` AND tc.`año` = `_año` AND tm.año= `_año`
					AND tm.id_estado = 2 AND tm.id_grado = tg.id AND tn.id_escala = te.id
					AND tg.id_nivel = _type
					GROUP BY tm.id_inst,tm.id_sede,tn.id_matric,tm.id_grado,tm.grupo, tn.periodo, tn.id_escala
					ORDER BY tm.año,tm.id_sede,tg.cod_grado,tm.grupo,tn.periodo,tn.id_escala,tas);
			END CASE;
	END IF;	
END$$

DROP PROCEDURE IF EXISTS `sp_estadistica_select_grado`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_estadistica_select_grado` (IN `_id_inst` INT(20), IN `_año` YEAR, IN `_type` INT(1), IN `_periodo` VARCHAR(1), IN `_report` INT(1))  BEGIN
	IF _report = 1 THEN 
		CASE	
			WHEN _type = 2 THEN   
				IF  _periodo = '0' THEN
					SELECT te.id_inst,te.cod_grado,te.total, COUNT(te.total) AS totals,
					te.`id_desempeño`, te.periodo, te.`año`, tg.grado, td.nombre_escala desempeño,
					(SELECT COUNT(tm.id_matric) FROM matriculas AS tm, inscripciones AS ti  WHERE tm.id_estado=2 AND tm.`año` = `_año` AND 
					tm.id_inst = _id_inst AND tm.cod_est = ti.cod_est AND tm.id_grado = te.cod_grado 
					GROUP BY tm.id_inst, tm.`año`,tm.id_grado) AS total_niños,
					ROUND((COUNT(te.total)*100)/(SELECT COUNT(tm.id_matric) FROM matriculas AS tm, inscripciones AS ti  WHERE tm.id_estado=2 AND tm.`año` = `_año` AND 
					tm.id_inst = _id_inst AND tm.cod_est = ti.cod_est AND tm.id_grado = te.cod_grado  
					GROUP BY tm.id_inst, tm.`año`,tm.id_grado),2) AS porciento 
					FROM estadistica_grupo te 
					LEFT JOIN grados AS tg ON te.cod_grado = tg.cod_grado 
					LEFT JOIN escala_nacional  AS td ON te.id_desempeño = td.id 
					LEFT JOIN sedes AS ts ON te.id_sede = ts.id 
					WHERE te.id_inst= _id_inst AND te.año = `_año` AND 
					 te.cod_grado BETWEEN 5 AND 9  AND ts.id_inst = _id_inst 
					GROUP BY te.id_inst,te.cod_grado,te.total, te.id_desempeño, te.periodo, te.`año` 
					ORDER BY te.id_inst,te.periodo,te.cod_grado,te.id_desempeño,te.total;
				ELSE
					SELECT te.id_inst,te.cod_grado,te.total, COUNT(te.total) AS totals,
					te.`id_desempeño`, te.periodo, te.`año`, tg.grado, td.nombre_escala desempeño,
					(SELECT COUNT(tm.id_matric) FROM matriculas AS tm, inscripciones AS ti  WHERE tm.id_estado=2 AND tm.`año` = `_año` AND 
					tm.id_inst = _id_inst AND tm.cod_est = ti.cod_est AND tm.id_grado = te.cod_grado 
					GROUP BY tm.id_inst, tm.`año`,tm.id_grado) AS total_niños,
					ROUND((COUNT(te.total)*100)/(SELECT COUNT(tm.id_matric) FROM matriculas AS tm, inscripciones AS ti  WHERE tm.id_estado=2 AND tm.`año` = `_año` AND 
					tm.id_inst = _id_inst AND tm.cod_est = ti.cod_est AND tm.id_grado = te.cod_grado  
					GROUP BY tm.id_inst, tm.`año`,tm.id_grado),2) AS porciento 
					FROM estadistica_grupo te 
					LEFT JOIN grados AS tg ON te.cod_grado = tg.cod_grado 
					LEFT JOIN escala_nacional  AS td ON te.id_desempeño = td.id 
					LEFT JOIN sedes AS ts ON te.id_sede = ts.id 
					WHERE te.id_inst= _id_inst AND te.año = `_año` AND te.periodo = _periodo AND 
					 te.cod_grado BETWEEN 5 AND 9 AND ts.id_inst = _id_inst 
					GROUP BY te.id_inst,te.cod_grado,te.total, te.id_desempeño, te.periodo, te.`año` 
					ORDER BY te.id_inst,te.periodo,te.cod_grado,te.id_desempeño,te.total;
				END IF;
			WHEN _type = 3 THEN
				IF  _periodo = '0' THEN
					SELECT te.id_inst,te.cod_grado,te.total, COUNT(te.total) AS totals,
					te.`id_desempeño`, te.periodo, te.`año`, tg.grado, td.nombre_escala desempeño,
					(SELECT COUNT(tm.id_matric) FROM matriculas AS tm, inscripciones AS ti  WHERE tm.id_estado=2 AND tm.`año` = `_año` AND 
					tm.id_inst = _id_inst AND tm.cod_est = ti.cod_est AND tm.id_grado = te.cod_grado 
					GROUP BY tm.id_inst, tm.`año`,tm.id_grado) AS total_niños,
					ROUND((COUNT(te.total)*100)/(SELECT COUNT(tm.id_matric) FROM matriculas AS tm, inscripciones AS ti  WHERE tm.id_estado=2 AND tm.`año` = `_año` AND 
					tm.id_inst = _id_inst AND tm.cod_est = ti.cod_est AND tm.id_grado = te.cod_grado  
					GROUP BY tm.id_inst, tm.`año`,tm.id_grado),2) AS porciento 
					FROM estadistica_grupo te 
					LEFT JOIN grados AS tg ON te.cod_grado = tg.cod_grado 
					LEFT JOIN escala_nacional  AS td ON te.id_desempeño = td.id 
					LEFT JOIN sedes AS ts ON te.id_sede = ts.id 
					WHERE te.id_inst= _id_inst AND te.año = `_año` AND 
					 te.cod_grado BETWEEN 10 AND 13  AND ts.id_inst = _id_inst 
					GROUP BY te.id_inst,te.cod_grado,te.total, te.id_desempeño, te.periodo, te.`año` 
					ORDER BY te.id_inst,te.periodo,te.cod_grado,te.id_desempeño,te.total;
				ELSE
					SELECT te.id_inst,te.cod_grado,te.total, COUNT(te.total) AS totals,
					te.`id_desempeño`, te.periodo, te.`año`, tg.grado, td.nombre_escala desempeño,
					(SELECT COUNT(tm.id_matric) FROM matriculas AS tm, inscripciones AS ti  WHERE tm.id_estado=2 AND tm.`año` = `_año` AND 
					tm.id_inst = _id_inst AND tm.cod_est = ti.cod_est AND tm.id_grado = te.cod_grado 
					GROUP BY tm.id_inst, tm.`año`,tm.id_grado) AS total_niños,
					ROUND((COUNT(te.total)*100)/(SELECT COUNT(tm.id_matric) FROM matriculas AS tm, inscripciones AS ti  WHERE tm.id_estado=2 AND tm.`año` = `_año` AND 
					tm.id_inst = _id_inst AND tm.cod_est = ti.cod_est AND tm.id_grado = te.cod_grado  
					GROUP BY tm.id_inst, tm.`año`,tm.id_grado),2) AS porciento 
					FROM estadistica_grupo te 
					LEFT JOIN grados AS tg ON te.cod_grado = tg.cod_grado 
					LEFT JOIN escala_nacional  AS td ON te.id_desempeño = td.id 
					LEFT JOIN sedes AS ts ON te.id_sede = ts.id 
					WHERE te.id_inst= _id_inst AND te.año = `_año` AND te.periodo = _periodo AND 
					 te.cod_grado BETWEEN 10 AND 13 AND ts.id_inst = _id_inst 
					GROUP BY te.id_inst,te.cod_grado,te.total, te.id_desempeño, te.periodo, te.`año` 
					ORDER BY te.id_inst,te.periodo,te.cod_grado,te.id_desempeño,te.total;
				END IF;
			ELSE
				IF  _periodo = '0' THEN
					SELECT te.id_inst,te.cod_grado,te.total, COUNT(te.total) AS totals,
					te.`id_desempeño`, te.periodo, te.`año`, tg.grado, td.nombre_escala desempeño,
					(SELECT COUNT(tm.id_matric) FROM matriculas AS tm, inscripciones AS ti  WHERE tm.id_estado=2 AND tm.`año` = `_año` AND 
					tm.id_inst = _id_inst AND tm.cod_est = ti.cod_est AND tm.id_grado = te.cod_grado 
					GROUP BY tm.id_inst, tm.`año`,tm.id_grado) AS total_niños,
					ROUND((COUNT(te.total)*100)/(SELECT COUNT(tm.id_matric) FROM matriculas AS tm, inscripciones AS ti  WHERE tm.id_estado=2 AND tm.`año` = `_año` AND 
					tm.id_inst = _id_inst AND tm.cod_est = ti.cod_est AND tm.id_grado = te.cod_grado  
					GROUP BY tm.id_inst, tm.`año`,tm.id_grado),2) AS porciento 
					FROM estadistica_grupo te 
					LEFT JOIN grados AS tg ON te.cod_grado = tg.cod_grado 
					LEFT JOIN escala_nacional  AS td ON te.id_desempeño = td.id 
					LEFT JOIN sedes AS ts ON te.id_sede = ts.id 
					WHERE te.id_inst= _id_inst AND te.año = `_año` AND 
					 te.cod_grado BETWEEN 14 AND 24  AND ts.id_inst = _id_inst 
					GROUP BY te.id_inst,te.cod_grado,te.total, te.id_desempeño, te.periodo, te.`año` 
					ORDER BY te.id_inst,te.periodo,te.cod_grado,te.id_desempeño,te.total;
				ELSE
					SELECT te.id_inst,te.cod_grado,te.total, COUNT(te.total) AS totals,
					te.`id_desempeño`, te.periodo, te.`año`, tg.grado, td.nombre_escala desempeño,
					(SELECT COUNT(tm.id_matric) FROM matriculas AS tm, inscripciones AS ti  WHERE tm.id_estado=2 AND tm.`año` = `_año` AND 
					tm.id_inst = _id_inst AND tm.cod_est = ti.cod_est AND tm.id_grado = te.cod_grado 
					GROUP BY tm.id_inst, tm.`año`,tm.id_grado) AS total_niños,
					ROUND((COUNT(te.total)*100)/(SELECT COUNT(tm.id_matric) FROM matriculas AS tm, inscripciones AS ti  WHERE tm.id_estado=2 AND tm.`año` = `_año` AND 
					tm.id_inst = _id_inst AND tm.cod_est = ti.cod_est AND tm.id_grado = te.cod_grado  
					GROUP BY tm.id_inst, tm.`año`,tm.id_grado),2) AS porciento 
					FROM estadistica_grupo te 
					LEFT JOIN grados AS tg ON te.cod_grado = tg.cod_grado 
					LEFT JOIN escala_nacional  AS td ON te.id_desempeño = td.id 
					LEFT JOIN sedes AS ts ON te.id_sede = ts.id 
					WHERE te.id_inst= _id_inst AND te.año = `_año` AND te.periodo = _periodo AND 
					 te.cod_grado BETWEEN 14 AND 24 AND ts.id_inst = _id_inst 
					GROUP BY te.id_inst,te.cod_grado,te.total, te.id_desempeño, te.periodo, te.`año` 
					ORDER BY te.id_inst,te.periodo,te.cod_grado,te.id_desempeño,te.total;
				END IF;
		END CASE;
	ELSE
		CASE	
			WHEN _type = 2 THEN   
				IF  _periodo = '0' THEN
					SELECT te.id_inst,te.cod_grado,te.total, COUNT(te.total) AS totals,
					te.`id_desempeño`, te.periodo, te.`año`, tg.grado, td.nombre_escala desempeño,
					(SELECT COUNT(tm.id_matric) FROM matriculas AS tm, inscripciones AS ti  WHERE tm.id_estado=2 AND tm.`año` = `_año` AND 
					tm.id_inst = _id_inst AND tm.cod_est = ti.cod_est AND tm.id_grado = te.cod_grado 
					GROUP BY tm.id_inst, tm.`año`,tm.id_grado) AS total_niños,
					ROUND((COUNT(te.total)*100)/(SELECT COUNT(tm.id_matric) FROM matriculas AS tm, inscripciones AS ti  WHERE tm.id_estado=2 AND tm.`año` = `_año` AND 
					tm.id_inst = _id_inst AND tm.cod_est = ti.cod_est AND tm.id_grado = te.cod_grado  
					GROUP BY tm.id_inst, tm.`año`,tm.id_grado),2) AS porciento
					FROM estadistica_grupo te 
					LEFT JOIN grados AS tg ON te.cod_grado = tg.cod_grado 
					LEFT JOIN escala_nacional  AS td ON te.id_desempeño = td.id 
					LEFT JOIN sedes AS ts ON te.id_sede = ts.id 
					WHERE te.id_inst= _id_inst AND te.año = `_año` AND 
					 te.cod_grado BETWEEN 5 AND 9  AND ts.id_inst = _id_inst 
					AND td.id = 1 
					GROUP BY te.id_inst,te.cod_grado,te.total, te.id_desempeño, te.periodo, te.`año` 
					ORDER BY te.id_inst,te.periodo,te.cod_grado,te.id_desempeño,te.total;
				ELSE
					SELECT te.id_inst,te.cod_grado,te.total, COUNT(te.total) AS totals,
					te.`id_desempeño`, te.periodo, te.`año`, tg.grado, td.nombre_escala desempeño,
					(SELECT COUNT(tm.id_matric) FROM matriculas AS tm, inscripciones AS ti  WHERE tm.id_estado=2 AND tm.`año` = `_año` AND 
					tm.id_inst = _id_inst AND tm.cod_est = ti.cod_est AND tm.id_grado = te.cod_grado 
					GROUP BY tm.id_inst, tm.`año`,tm.id_grado) AS total_niños,
					ROUND((COUNT(te.total)*100)/(SELECT COUNT(tm.id_matric) FROM matriculas AS tm, inscripciones AS ti  WHERE tm.id_estado=2 AND tm.`año` = `_año` AND 
					tm.id_inst = _id_inst AND tm.cod_est = ti.cod_est AND tm.id_grado = te.cod_grado  
					GROUP BY tm.id_inst, tm.`año`,tm.id_grado),2) AS porciento
					FROM estadistica_grupo te 
					LEFT JOIN grados AS tg ON te.cod_grado = tg.cod_grado 
					LEFT JOIN escala_nacional  AS td ON te.id_desempeño = td.id 
					LEFT JOIN sedes AS ts ON te.id_sede = ts.id 
					WHERE te.id_inst= _id_inst AND te.año = `_año` AND te.periodo = _periodo AND 
					 te.cod_grado BETWEEN 5 AND 9 AND ts.id_inst = _id_inst 
					AND td.id = 1 
					GROUP BY te.id_inst,te.cod_grado,te.total, te.id_desempeño, te.periodo, te.`año` 
					ORDER BY te.id_inst,te.periodo,te.cod_grado,te.id_desempeño,te.total;
				END IF;
			WHEN _type = 3 THEN
				IF  _periodo = '0' THEN
					SELECT te.id_inst,te.cod_grado,te.total, COUNT(te.total) AS totals,
					te.`id_desempeño`, te.periodo, te.`año`, tg.grado, td.nombre_escala desempeño,
					(SELECT COUNT(tm.id_matric) FROM matriculas AS tm, inscripciones AS ti  WHERE tm.id_estado=2 AND tm.`año` = `_año` AND 
					tm.id_inst = _id_inst AND tm.cod_est = ti.cod_est AND tm.id_grado = te.cod_grado 
					GROUP BY tm.id_inst, tm.`año`,tm.id_grado) AS total_niños,
					ROUND((COUNT(te.total)*100)/(SELECT COUNT(tm.id_matric) FROM matriculas AS tm, inscripciones AS ti  WHERE tm.id_estado=2 AND tm.`año` = `_año` AND 
					tm.id_inst = _id_inst AND tm.cod_est = ti.cod_est AND tm.id_grado = te.cod_grado  
					GROUP BY tm.id_inst, tm.`año`,tm.id_grado),2) AS porciento
					FROM estadistica_grupo te 
					LEFT JOIN grados AS tg ON te.cod_grado = tg.cod_grado 
					LEFT JOIN escala_nacional  AS td ON te.id_desempeño = td.id 
					LEFT JOIN sedes AS ts ON te.id_sede = ts.id 
					WHERE te.id_inst= _id_inst AND te.año = `_año` AND 
					 te.cod_grado BETWEEN 10 AND 13  AND ts.id_inst = _id_inst 
					AND td.id = 1 
					GROUP BY te.id_inst,te.cod_grado,te.total, te.id_desempeño, te.periodo, te.`año` 
					ORDER BY te.id_inst,te.periodo,te.cod_grado,te.id_desempeño,te.total;
				ELSE
					SELECT te.id_inst,te.cod_grado,te.total, COUNT(te.total) AS totals,
					te.`id_desempeño`, te.periodo, te.`año`, tg.grado, td.nombre_escala desempeño,
					(SELECT COUNT(tm.id_matric) FROM matriculas AS tm, inscripciones AS ti  WHERE tm.id_estado=2 AND tm.`año` = `_año` AND 
					tm.id_inst = _id_inst AND tm.cod_est = ti.cod_est AND tm.id_grado = te.cod_grado 
					GROUP BY tm.id_inst, tm.`año`,tm.id_grado) AS total_niños,
					ROUND((COUNT(te.total)*100)/(SELECT COUNT(tm.id_matric) FROM matriculas AS tm, inscripciones AS ti  WHERE tm.id_estado=2 AND tm.`año` = `_año` AND 
					tm.id_inst = _id_inst AND tm.cod_est = ti.cod_est AND tm.id_grado = te.cod_grado  
					GROUP BY tm.id_inst, tm.`año`,tm.id_grado),2) AS porciento
					FROM estadistica_grupo te 
					LEFT JOIN grados AS tg ON te.cod_grado = tg.cod_grado 
					LEFT JOIN escala_nacional  AS td ON te.id_desempeño = td.id 
					LEFT JOIN sedes AS ts ON te.id_sede = ts.id 
					WHERE te.id_inst= _id_inst AND te.año = `_año` AND te.periodo = _periodo AND 
					 te.cod_grado BETWEEN 10 AND 13 AND ts.id_inst = _id_inst 
					AND td.id = 1 
					GROUP BY te.id_inst,te.cod_grado,te.total, te.id_desempeño, te.periodo, te.`año` 
					ORDER BY te.id_inst,te.periodo,te.cod_grado,te.id_desempeño,te.total;
				END IF;
			ELSE
				IF  _periodo = '0' THEN
					SELECT te.id_inst,te.cod_grado,te.total, COUNT(te.total) AS totals,
					te.`id_desempeño`, te.periodo, te.`año`, tg.grado, td.nombre_escala desempeño,
					(SELECT COUNT(tm.id_matric) FROM matriculas AS tm, inscripciones AS ti  WHERE tm.id_estado=2 AND tm.`año` = `_año` AND 
					tm.id_inst = _id_inst AND tm.cod_est = ti.cod_est AND tm.id_grado = te.cod_grado 
					GROUP BY tm.id_inst, tm.`año`,tm.id_grado) AS total_niños,
					ROUND((COUNT(te.total)*100)/(SELECT COUNT(tm.id_matric) FROM matriculas AS tm, inscripciones AS ti  WHERE tm.id_estado=2 AND tm.`año` = `_año` AND 
					tm.id_inst = _id_inst AND tm.cod_est = ti.cod_est AND tm.id_grado = te.cod_grado  
					GROUP BY tm.id_inst, tm.`año`,tm.id_grado),2) AS porciento 
					FROM estadistica_grupo te 
					LEFT JOIN grados AS tg ON te.cod_grado = tg.cod_grado 
					LEFT JOIN escala_nacional  AS td ON te.id_desempeño = td.id 
					LEFT JOIN sedes AS ts ON te.id_sede = ts.id 
					WHERE te.id_inst= _id_inst AND te.año = `_año` AND 
					 te.cod_grado BETWEEN 14 AND 24  AND ts.id_inst = _id_inst 
					AND td.id = 1 
					GROUP BY te.id_inst,te.cod_grado,te.total, te.id_desempeño, te.periodo, te.`año` 
					ORDER BY te.id_inst,te.periodo,te.cod_grado,te.id_desempeño,te.total;
				ELSE
					SELECT te.id_inst,te.cod_grado,te.total, COUNT(te.total) AS totals,
					te.`id_desempeño`, te.periodo, te.`año`, tg.grado, td.nombre_escala desempeño,
					(SELECT COUNT(tm.id_matric) FROM matriculas AS tm, inscripciones AS ti  WHERE tm.id_estado=2 AND tm.`año` = `_año` AND 
					tm.id_inst = _id_inst AND tm.cod_est = ti.cod_est AND tm.id_grado = te.cod_grado 
					GROUP BY tm.id_inst, tm.`año`,tm.id_grado) AS total_niños,
					ROUND((COUNT(te.total)*100)/(SELECT COUNT(tm.id_matric) FROM matriculas AS tm, inscripciones AS ti  WHERE tm.id_estado=2 AND tm.`año` = `_año` AND 
					tm.id_inst = _id_inst AND tm.cod_est = ti.cod_est AND tm.id_grado = te.cod_grado  
					GROUP BY tm.id_inst, tm.`año`,tm.id_grado),2) AS porciento 
					FROM estadistica_grupo te 
					LEFT JOIN grados AS tg ON te.cod_grado = tg.cod_grado 
					LEFT JOIN escala_nacional  AS td ON te.id_desempeño = td.id 
					LEFT JOIN sedes AS ts ON te.id_sede = ts.id 
					WHERE te.id_inst= _id_inst AND te.año = `_año` AND te.periodo = _periodo AND 
					 te.cod_grado BETWEEN 14 AND 24 AND ts.id_inst = _id_inst 
					AND td.id = 1 
					GROUP BY te.id_inst,te.cod_grado,te.total, te.id_desempeño, te.periodo, te.`año` 
					ORDER BY te.id_inst,te.periodo,te.cod_grado,te.id_desempeño,te.total;
				END IF;
		END CASE;	
	END IF;
END$$

DROP PROCEDURE IF EXISTS `sp_estadistica_select_grado_grupo`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_estadistica_select_grado_grupo` (IN `_id_inst` INT(20), IN `_año` YEAR, IN `_type` INT(1), IN `_periodo` VARCHAR(1))  BEGIN
	CASE	
		WHEN _type = 2 THEN   
			IF  _periodo = '0' THEN
				SELECT te.id_inst,te.cod_grado,te.grupo, COUNT(te.total) AS totals,
				te.`id_desempeño`, te.periodo, te.`año`, td.nombre_escala desempeño,
				(SELECT COUNT(tm.id_matric) FROM matriculas AS tm, inscripciones AS ti  WHERE tm.id_estado=2 AND tm.`año` = `_año` AND 
				tm.id_inst = _id_inst AND tm.cod_est = ti.cod_est AND tm.id_grado = te.cod_grado  AND tm.grupo = te.grupo 
				GROUP BY tm.id_inst, tm.`año`,tm.id_grado,tm.grupo) AS total_niños,
				ROUND((COUNT(te.total)*100)/(SELECT COUNT(tm.id_matric) FROM matriculas AS tm, inscripciones AS ti  WHERE tm.id_estado=2 AND tm.`año` = `_año` AND 
				tm.id_inst = _id_inst AND tm.cod_est = ti.cod_est AND tm.id_grado = te.cod_grado  AND tm.grupo = te.grupo 
				GROUP BY tm.id_inst, tm.`año`,tm.id_grado,tm.grupo),2) AS porciento 
				FROM estadistica_grupo te 
				LEFT JOIN grados AS tg ON te.cod_grado = tg.id 
				LEFT JOIN escala_nacional AS td ON te.id_desempeño = td.id 
				LEFT JOIN sedes AS ts ON te.id_sede = ts.id 
				WHERE te.id_inst= _id_inst AND te.año = `_año` AND 
				 te.cod_grado BETWEEN 5 AND 9  AND ts.id_inst = _id_inst 
				AND td.id = 1 
				GROUP BY te.id_inst,te.cod_grado,te.grupo,te.id_desempeño, te.periodo, te.`año` 
				ORDER BY te.id_inst,te.periodo,te.cod_grado,te.grupo,te.id_desempeño,te.total;
			ELSE
				SELECT te.id_inst,te.cod_grado,te.grupo, COUNT(te.total) AS totals,
				te.`id_desempeño`, te.periodo, te.`año`, td.nombre_escala desempeño,
				(SELECT COUNT(tm.id_matric) FROM matriculas AS tm, inscripciones AS ti  WHERE tm.id_estado=2 AND tm.`año` = `_año` AND 
				tm.id_inst = _id_inst AND tm.cod_est = ti.cod_est AND tm.id_grado = te.cod_grado AND tm.grupo = te.grupo 
				GROUP BY tm.id_inst, tm.`año`,tm.id_grado,tm.grupo) AS total_niños,
				ROUND((COUNT(te.total)*100)/(SELECT COUNT(tm.id_matric) FROM matriculas AS tm, inscripciones AS ti  WHERE tm.id_estado=2 AND tm.`año` = `_año` AND 
				tm.id_inst = _id_inst AND tm.cod_est = ti.cod_est AND tm.id_grado = te.cod_grado AND tm.grupo = te.grupo  
				GROUP BY tm.id_inst, tm.`año`,tm.id_grado,tm.grupo),2) AS porciento 
				FROM estadistica_grupo te 
				LEFT JOIN grados AS tg ON te.cod_grado = tg.id 
				LEFT JOIN escala_nacional AS td ON te.id_desempeño = td.id 
				LEFT JOIN sedes AS ts ON te.id_sede = ts.id 
				WHERE te.id_inst= _id_inst AND te.año = `_año` AND te.periodo = _periodo AND 
				 te.cod_grado BETWEEN 5 AND 9 AND ts.id_inst = _id_inst 
				AND td.id = 1 
				GROUP BY te.id_inst,te.cod_grado,te.grupo,te.id_desempeño, te.periodo, te.`año` 
				ORDER BY te.id_inst,te.periodo,te.cod_grado,te.grupo,te.id_desempeño,te.total;
			END IF;
		WHEN _type = 3 THEN
			IF  _periodo = '0' THEN
				SELECT te.id_inst,te.cod_grado,te.grupo, COUNT(te.total) AS totals,
				te.`id_desempeño`, te.periodo, te.`año`, td.nombre_escala desempeño,
				(SELECT COUNT(tm.id_matric) FROM matriculas AS tm, inscripciones AS ti  WHERE tm.id_estado=2 AND tm.`año` = `_año` AND 
				tm.id_inst = _id_inst AND tm.cod_est = ti.cod_est AND tm.id_grado = te.cod_grado  AND tm.grupo = te.grupo 
				GROUP BY tm.id_inst, tm.`año`,tm.id_grado,tm.grupo) AS total_niños,
				ROUND((COUNT(te.total)*100)/(SELECT COUNT(tm.id_matric) FROM matriculas AS tm, inscripciones AS ti  WHERE tm.id_estado=2 AND tm.`año` = `_año` AND 
				tm.id_inst = _id_inst AND tm.cod_est = ti.cod_est AND tm.id_grado = te.cod_grado  AND tm.grupo = te.grupo 
				GROUP BY tm.id_inst, tm.`año`,tm.id_grado,tm.grupo),2) AS porciento 
				FROM estadistica_grupo te 
				LEFT JOIN grados AS tg ON te.cod_grado = tg.id 
				LEFT JOIN escala_nacional AS td ON te.id_desempeño = td.id 
				LEFT JOIN sedes AS ts ON te.id_sede = ts.id 
				WHERE te.id_inst= _id_inst AND te.año = `_año` AND 
				 te.cod_grado BETWEEN 10 AND 13  AND ts.id_inst = _id_inst 
				AND td.id = 1 
				GROUP BY te.id_inst,te.cod_grado,te.grupo,te.id_desempeño, te.periodo, te.`año` 
				ORDER BY te.id_inst,te.periodo,te.cod_grado,te.grupo,te.id_desempeño,te.total;
			ELSE
				SELECT te.id_inst,te.cod_grado,te.grupo, COUNT(te.total) AS totals,
				te.`id_desempeño`, te.periodo, te.`año`, td.nombre_escala desempeño,
				(SELECT COUNT(tm.id_matric) FROM matriculas AS tm, inscripciones AS ti  WHERE tm.id_estado=2 AND tm.`año` = `_año` AND 
				tm.id_inst = _id_inst AND tm.cod_est = ti.cod_est AND tm.id_grado = te.cod_grado AND tm.grupo = te.grupo 
				GROUP BY tm.id_inst, tm.`año`,tm.id_grado,tm.grupo) AS total_niños,
				ROUND((COUNT(te.total)*100)/(SELECT COUNT(tm.id_matric) FROM matriculas AS tm, inscripciones AS ti  WHERE tm.id_estado=2 AND tm.`año` = `_año` AND 
				tm.id_inst = _id_inst AND tm.cod_est = ti.cod_est AND tm.id_grado = te.cod_grado AND tm.grupo = te.grupo  
				GROUP BY tm.id_inst, tm.`año`,tm.id_grado,tm.grupo),2) AS porciento 
				FROM estadistica_grupo te 
				LEFT JOIN grados AS tg ON te.cod_grado = tg.id 
				LEFT JOIN escala_nacional AS td ON te.id_desempeño = td.id 
				LEFT JOIN sedes AS ts ON te.id_sede = ts.id 
				WHERE te.id_inst= _id_inst AND te.año = `_año` AND te.periodo = _periodo AND 
				 te.cod_grado BETWEEN 10 AND 13 AND ts.id_inst = _id_inst 
				AND td.id = 1 
				GROUP BY te.id_inst,te.cod_grado,te.grupo,te.id_desempeño, te.periodo, te.`año` 
				ORDER BY te.id_inst,te.periodo,te.cod_grado,te.grupo,te.id_desempeño,te.total;
			END IF;
		ELSE
			IF  _periodo = '0' THEN
				SELECT te.id_inst,te.cod_grado,te.grupo, COUNT(te.total) AS totals,
				te.`id_desempeño`, te.periodo, te.`año`, td.nombre_escala desempeño,
				(SELECT COUNT(tm.id_matric) FROM matriculas AS tm, inscripciones AS ti  WHERE tm.id_estado=2 AND tm.`año` = `_año` AND 
				tm.id_inst = _id_inst AND tm.cod_est = ti.cod_est AND tm.id_grado = te.cod_grado  AND tm.grupo = te.grupo 
				GROUP BY tm.id_inst, tm.`año`,tm.id_grado,tm.grupo) AS total_niños,
				ROUND((COUNT(te.total)*100)/(SELECT COUNT(tm.id_matric) FROM matriculas AS tm, inscripciones AS ti  WHERE tm.id_estado=2 AND tm.`año` = `_año` AND 
				tm.id_inst = _id_inst AND tm.cod_est = ti.cod_est AND tm.id_grado = te.cod_grado  AND tm.grupo = te.grupo 
				GROUP BY tm.id_inst, tm.`año`,tm.id_grado,tm.grupo),2) AS porciento 
				FROM estadistica_grupo te 
				LEFT JOIN grados AS tg ON te.cod_grado = tg.id 
				LEFT JOIN escala_nacional AS td ON te.id_desempeño = td.id 
				LEFT JOIN sedes AS ts ON te.id_sede = ts.id 
				WHERE te.id_inst= _id_inst AND te.año = `_año` AND 
				 te.cod_grado BETWEEN 14 AND 24  AND ts.id_inst = _id_inst 
				AND td.id = 1 
				GROUP BY te.id_inst,te.cod_grado,te.grupo,te.id_desempeño, te.periodo, te.`año` 
				ORDER BY te.id_inst,te.periodo,te.cod_grado,te.grupo,te.id_desempeño,te.total;
			ELSE
				SELECT te.id_inst,te.cod_grado,te.grupo, COUNT(te.total) AS totals,
				te.`id_desempeño`, te.periodo, te.`año`, td.nombre_escala desempeño,
				(SELECT COUNT(tm.id_matric) FROM matriculas AS tm, inscripciones AS ti  WHERE tm.id_estado=2 AND tm.`año` = `_año` AND 
				tm.id_inst = _id_inst AND tm.cod_est = ti.cod_est AND tm.id_grado = te.cod_grado AND tm.grupo = te.grupo 
				GROUP BY tm.id_inst, tm.`año`,tm.id_grado,tm.grupo) AS total_niños,
				ROUND((COUNT(te.total)*100)/(SELECT COUNT(tm.id_matric) FROM matriculas AS tm, inscripciones AS ti  WHERE tm.id_estado=2 AND tm.`año` = `_año` AND 
				tm.id_inst = _id_inst AND tm.cod_est = ti.cod_est AND tm.id_grado = te.cod_grado AND tm.grupo = te.grupo  
				GROUP BY tm.id_inst, tm.`año`,tm.id_grado,tm.grupo),2) AS porciento 
				FROM estadistica_grupo te 
				LEFT JOIN grados AS tg ON te.cod_grado = tg.id 
				LEFT JOIN escala_nacional AS td ON te.id_desempeño = td.id 
				LEFT JOIN sedes AS ts ON te.id_sede = ts.id 
				WHERE te.id_inst= _id_inst AND te.año = `_año` AND te.periodo = _periodo AND 
				 te.cod_grado BETWEEN 14 AND 24 AND ts.id_inst = _id_inst 
				AND td.id = 1 
				GROUP BY te.id_inst,te.cod_grado,te.grupo,te.id_desempeño, te.periodo, te.`año` 
				ORDER BY te.id_inst,te.periodo,te.cod_grado,te.grupo,te.id_desempeño,te.total;
			END IF;
	END CASE;
END$$

DROP PROCEDURE IF EXISTS `sp_estadistica_select_nivel_agrupado`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_estadistica_select_nivel_agrupado` (IN `_id_inst` INT(20), IN `_año` YEAR, IN `_type` INT(1), IN `_periodo` VARCHAR(1))  BEGIN
	CASE	
		WHEN _type = 2 THEN   
			IF  _periodo = '0' THEN
				SELECT te.id_inst, COUNT(te.total) AS totals,
				te.`id_desempeño`, te.periodo, te.`año`, td.nombre_escala desempeño,
				(SELECT COUNT(tm.id_matric) FROM matriculas AS tm, inscripciones AS te  WHERE tm.id_estado=2 AND tm.`año` = `_año` AND 
				tm.id_inst = _id_inst AND tm.cod_est = te.cod_est AND tm.id_grado BETWEEN 5 AND 9 
				GROUP BY tm.id_inst, tm.`año`) AS total_niños,
				ROUND((COUNT(te.total)*100)/(SELECT COUNT(tm.id_matric) FROM matriculas AS tm, inscripciones AS te  WHERE tm.id_estado=2 AND tm.`año` = `_año` AND 
				tm.id_inst = _id_inst AND tm.cod_est = te.cod_est AND tm.id_grado BETWEEN 5 AND 9 
				GROUP BY tm.id_inst, tm.`año`),2) AS porciento 
				FROM estadistica_grupo te 
				LEFT JOIN grados AS tg ON te.cod_grado = tg.id 
				LEFT JOIN escala_nacional AS td ON te.id_desempeño = td.id 
				LEFT JOIN sedes AS ts ON te.id_sede = ts.id 
				WHERE te.id_inst= _id_inst AND te.año = `_año` AND 
				 te.cod_grado BETWEEN 5 AND 9  AND ts.id_inst = _id_inst 
				GROUP BY te.id_inst, te.id_desempeño, te.periodo, te.`año` 
				ORDER BY te.id_inst,te.periodo,te.id_desempeño,te.total;
			ELSE
				SELECT te.id_inst, COUNT(te.total) AS totals,
				te.`id_desempeño`, te.periodo, te.`año`, td.nombre_escala desempeño,
				(SELECT COUNT(tm.id_matric) FROM matriculas AS tm, inscripciones AS te  WHERE tm.id_estado=2 AND tm.`año` = `_año` AND 
				tm.id_inst = _id_inst AND tm.cod_est = te.cod_est AND tm.id_grado BETWEEN 5 AND 9 
				GROUP BY tm.id_inst, tm.`año`) AS total_niños,
				ROUND((COUNT(te.total)*100)/(SELECT COUNT(tm.id_matric) FROM matriculas AS tm, inscripciones AS te  WHERE tm.id_estado=2 AND tm.`año` = `_año` AND 
				tm.id_inst = _id_inst AND tm.cod_est = te.cod_est AND tm.id_grado BETWEEN 5 AND 9 
				GROUP BY tm.id_inst, tm.`año`),2) AS porciento 
				FROM estadistica_grupo te 
				LEFT JOIN grados AS tg ON te.cod_grado = tg.id 
				LEFT JOIN escala_nacional AS td ON te.id_desempeño = td.id 
				LEFT JOIN sedes AS ts ON te.id_sede = ts.id 
				WHERE te.id_inst= _id_inst AND te.año = `_año` AND te.periodo = _periodo AND 
				 te.cod_grado BETWEEN 5 AND 9 AND ts.id_inst = _id_inst 
				GROUP BY te.id_inst,te.id_desempeño, te.periodo, te.`año` 
				ORDER BY te.id_inst,te.periodo,te.id_desempeño,te.total;
			END IF;
		WHEN _type = 3 THEN
			IF  _periodo = '0' THEN
				SELECT te.id_inst, COUNT(te.total) AS totals,
				te.`id_desempeño`, te.periodo, te.`año`, td.nombre_escala desempeño,
				(SELECT COUNT(tm.id_matric) FROM matriculas AS tm, inscripciones AS te  WHERE tm.id_estado=2 AND tm.`año` = `_año` AND 
				tm.id_inst = _id_inst AND tm.cod_est = te.cod_est AND tm.id_grado BETWEEN 10 AND 13 
				GROUP BY tm.id_inst, tm.`año`) AS total_niños,
				ROUND((COUNT(te.total)*100)/(SELECT COUNT(tm.id_matric) FROM matriculas AS tm, inscripciones AS te  WHERE tm.id_estado=2 AND tm.`año` = `_año` AND 
				tm.id_inst = _id_inst AND tm.cod_est = te.cod_est AND tm.id_grado BETWEEN 10 AND 13 
				GROUP BY tm.id_inst, tm.`año`),2) AS porciento 
				FROM estadistica_grupo te 
				LEFT JOIN grados AS tg ON te.cod_grado = tg.id 
				LEFT JOIN escala_nacional AS td ON te.id_desempeño = td.id 
				LEFT JOIN sedes AS ts ON te.id_sede = ts.id 
				WHERE te.id_inst= _id_inst AND te.año = `_año` AND 
				 te.cod_grado BETWEEN 10 AND 13  AND ts.id_inst = _id_inst 
				GROUP BY te.id_inst, te.id_desempeño, te.periodo, te.`año` 
				ORDER BY te.id_inst,te.periodo,te.id_desempeño,te.total;
			ELSE
				SELECT te.id_inst, COUNT(te.total) AS totals,
				te.`id_desempeño`, te.periodo, te.`año`, td.nombre_escala desempeño,
				(SELECT COUNT(tm.id_matric) FROM matriculas AS tm, inscripciones AS te  WHERE tm.id_estado=2 AND tm.`año` = `_año` AND 
				tm.id_inst = _id_inst AND tm.cod_est = te.cod_est AND tm.id_grado BETWEEN 10 AND 13 
				GROUP BY tm.id_inst, tm.`año`) AS total_niños,
				ROUND((COUNT(te.total)*100)/(SELECT COUNT(tm.id_matric) FROM matriculas AS tm, inscripciones AS te  WHERE tm.id_estado=2 AND tm.`año` = `_año` AND 
				tm.id_inst = _id_inst AND tm.cod_est = te.cod_est AND tm.id_grado BETWEEN 10 AND 13 
				GROUP BY tm.id_inst, tm.`año`),2) AS porciento 
				FROM estadistica_grupo te 
				LEFT JOIN grados AS tg ON te.cod_grado = tg.id 
				LEFT JOIN escala_nacional AS td ON te.id_desempeño = td.id 
				LEFT JOIN sedes AS ts ON te.id_sede = ts.id 
				WHERE te.id_inst= _id_inst AND te.año = `_año` AND te.periodo = _periodo AND 
				 te.cod_grado BETWEEN 10 AND 13 AND ts.id_inst = _id_inst 
				GROUP BY te.id_inst,te.id_desempeño, te.periodo, te.`año` 
				ORDER BY te.id_inst,te.periodo,te.id_desempeño,te.total;
			END IF;
		ELSE
			IF  _periodo = '0' THEN
				SELECT te.id_inst, COUNT(te.total) AS totals,
				te.`id_desempeño`, te.periodo, te.`año`, td.nombre_escala desempeño,
				(SELECT COUNT(tm.id_matric) FROM matriculas AS tm, inscripciones AS te  WHERE tm.id_estado=2 AND tm.`año` = `_año` AND 
				tm.id_inst = _id_inst AND tm.cod_est = te.cod_est AND tm.id_grado BETWEEN 14 AND 24 
				GROUP BY tm.id_inst, tm.`año`) AS total_niños,
				ROUND((COUNT(te.total)*100)/(SELECT COUNT(tm.id_matric) FROM matriculas AS tm, inscripciones AS te  WHERE tm.id_estado=2 AND tm.`año` = `_año` AND 
				tm.id_inst = _id_inst AND tm.cod_est = te.cod_est AND tm.id_grado BETWEEN 14 AND 24 
				GROUP BY tm.id_inst, tm.`año`),2) AS porciento 
				FROM estadistica_grupo te 
				LEFT JOIN grados AS tg ON te.cod_grado = tg.id 
				LEFT JOIN escala_nacional AS td ON te.id_desempeño = td.id 
				LEFT JOIN sedes AS ts ON te.id_sede = ts.id 
				WHERE te.id_inst= _id_inst AND te.año = `_año` AND 
				 te.cod_grado BETWEEN 14 AND 24  AND ts.id_inst = _id_inst 
				GROUP BY te.id_inst, te.id_desempeño, te.periodo, te.`año` 
				ORDER BY te.id_inst,te.periodo,te.id_desempeño,te.total;
			ELSE
				SELECT te.id_inst, COUNT(te.total) AS totals,
				te.`id_desempeño`, te.periodo, te.`año`, td.nombre_escala desempeño,
				(SELECT COUNT(tm.id_matric) FROM matriculas AS tm, inscripciones AS te  WHERE tm.id_estado=2 AND tm.`año` = `_año` AND 
				tm.id_inst = _id_inst AND tm.cod_est = te.cod_est AND tm.id_grado BETWEEN 14 AND 24 
				GROUP BY tm.id_inst, tm.`año`) AS total_niños,
				ROUND((COUNT(te.total)*100)/(SELECT COUNT(tm.id_matric) FROM matriculas AS tm, inscripciones AS te  WHERE tm.id_estado=2 AND tm.`año` = `_año` AND 
				tm.id_inst = _id_inst AND tm.cod_est = te.cod_est AND tm.id_grado BETWEEN 14 AND 24 
				GROUP BY tm.id_inst, tm.`año`),2) AS porciento 
				FROM estadistica_grupo te 
				LEFT JOIN grados AS tg ON te.cod_grado = tg.id 
				LEFT JOIN escala_nacional AS td ON te.id_desempeño = td.id 
				LEFT JOIN sedes AS ts ON te.id_sede = ts.id 
				WHERE te.id_inst= _id_inst AND te.año = `_año` AND te.periodo = _periodo AND 
				 te.cod_grado BETWEEN 14 AND 24 AND ts.id_inst = _id_inst 
				GROUP BY te.id_inst,te.id_desempeño, te.periodo, te.`año` 
				ORDER BY te.id_inst,te.periodo,te.id_desempeño,te.total;
			END IF;
	END CASE;
END$$

DROP PROCEDURE IF EXISTS `sp_estadistica_select_nivel_agrupado_perdidos`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_estadistica_select_nivel_agrupado_perdidos` (IN `_id_inst` INT(20), IN `_año` YEAR, IN `_type` INT(1), IN `_periodo` VARCHAR(2))  BEGIN
	CASE	
		WHEN _type = 2 THEN   
			IF  _periodo = '0' THEN
				SELECT te.id_inst,te.cod_grado, COUNT(te.total) AS totals,
				te.`id_desempeño`, te.periodo, te.`año`, td.nombre_escala desempeño,
				(SELECT COUNT(tm.id_matric) FROM matriculas AS tm, inscripciones AS ti  WHERE tm.id_estado=2 AND tm.`año` = `_año` AND 
				tm.id_inst = _id_inst AND tm.cod_est = ti.cod_est AND tm.id_grado = te.cod_grado 
				GROUP BY tm.id_inst, tm.`año`,tm.id_grado) AS total_niños,
				ROUND((COUNT(te.total)*100)/(SELECT COUNT(tm.id_matric) FROM matriculas AS tm, inscripciones AS ti  WHERE tm.id_estado=2 AND tm.`año` = `_año` AND 
				tm.id_inst = _id_inst AND tm.cod_est = ti.cod_est AND tm.id_grado = te.cod_grado  
				GROUP BY tm.id_inst, tm.`año`,tm.id_grado),2) AS porciento 
				FROM estadistica_grupo te 
				LEFT JOIN grados AS tg ON te.cod_grado = tg.id 
				LEFT JOIN escala_nacional AS td ON te.id_desempeño = td.id 
				LEFT JOIN sedes AS ts ON te.id_sede = ts.id 
				WHERE te.id_inst= _id_inst AND te.año = `_año` AND 
				 te.cod_grado BETWEEN 5 AND 9  AND ts.id_inst = _id_inst 
				AND td.id = 1 
				GROUP BY te.id_inst,te.cod_grado,te.id_desempeño, te.periodo, te.`año` 
				ORDER BY te.id_inst,te.periodo,te.cod_grado,te.id_desempeño,te.total;
			ELSE
				SELECT te.id_inst,te.cod_grado, COUNT(te.total) AS totals,
				te.`id_desempeño`, te.periodo, te.`año`, td.nombre_escala desempeño,
				(SELECT COUNT(tm.id_matric) FROM matriculas AS tm, inscripciones AS ti  WHERE tm.id_estado=2 AND tm.`año` = `_año` AND 
				tm.id_inst = _id_inst AND tm.cod_est = ti.cod_est AND tm.id_grado = te.cod_grado 
				GROUP BY tm.id_inst, tm.`año`,tm.id_grado) AS total_niños,
				ROUND((COUNT(te.total)*100)/(SELECT COUNT(tm.id_matric) FROM matriculas AS tm, inscripciones AS ti  WHERE tm.id_estado=2 AND tm.`año` = `_año` AND 
				tm.id_inst = _id_inst AND tm.cod_est = ti.cod_est AND tm.id_grado = te.cod_grado  
				GROUP BY tm.id_inst, tm.`año`),2) AS porciento 
				FROM estadistica_grupo te 
				LEFT JOIN grados AS tg ON te.cod_grado = tg.id 
				LEFT JOIN escala_nacional AS td ON te.id_desempeño = td.id 
				LEFT JOIN sedes AS ts ON te.id_sede = ts.id 
				WHERE te.id_inst= _id_inst AND te.año = `_año` AND te.periodo = _periodo AND 
				 te.cod_grado BETWEEN 5 AND 9 AND ts.id_inst = _id_inst 
				AND td.id = 1 
				GROUP BY te.id_inst,te.cod_grado,te.id_desempeño, te.periodo, te.`año` 
				ORDER BY te.id_inst,te.cod_grado,te.periodo,te.id_desempeño,te.total;
			END IF;
		WHEN _type = 3 THEN
			IF  _periodo = '0' THEN
				SELECT te.id_inst,te.cod_grado, COUNT(te.total) AS totals,
				te.`id_desempeño`, te.periodo, te.`año`, td.nombre_escala desempeño,
				(SELECT COUNT(tm.id_matric) FROM matriculas AS tm, inscripciones AS ti  WHERE tm.id_estado=2 AND tm.`año` = `_año` AND 
				tm.id_inst = _id_inst AND tm.cod_est = ti.cod_est AND tm.id_grado = te.cod_grado 
				GROUP BY tm.id_inst, tm.`año`,tm.id_grado) AS total_niños,
				ROUND((COUNT(te.total)*100)/(SELECT COUNT(tm.id_matric) FROM matriculas AS tm, inscripciones AS ti  WHERE tm.id_estado=2 AND tm.`año` = `_año` AND 
				tm.id_inst = _id_inst AND tm.cod_est = ti.cod_est AND tm.id_grado = te.cod_grado  
				GROUP BY tm.id_inst, tm.`año`,tm.id_grado),2) AS porciento 
				FROM estadistica_grupo te 
				LEFT JOIN grados AS tg ON te.cod_grado = tg.id 
				LEFT JOIN escala_nacional AS td ON te.id_desempeño = td.id 
				LEFT JOIN sedes AS ts ON te.id_sede = ts.id 
				WHERE te.id_inst= _id_inst AND te.año = `_año` AND 
				 te.cod_grado BETWEEN 10 AND 13  AND ts.id_inst = _id_inst 
				AND td.id = 1 
				GROUP BY te.id_inst,te.cod_grado,te.id_desempeño, te.periodo, te.`año` 
				ORDER BY te.id_inst,te.periodo,te.cod_grado,te.id_desempeño,te.total;
			ELSE
				SELECT te.id_inst,te.cod_grado, COUNT(te.total) AS totals,
				te.`id_desempeño`, te.periodo, te.`año`, td.nombre_escala desempeño,
				(SELECT COUNT(tm.id_matric) FROM matriculas AS tm, inscripciones AS ti  WHERE tm.id_estado=2 AND tm.`año` = `_año` AND 
				tm.id_inst = _id_inst AND tm.cod_est = ti.cod_est AND tm.id_grado = te.cod_grado 
				GROUP BY tm.id_inst, tm.`año`,tm.id_grado) AS total_niños,
				ROUND((COUNT(te.total)*100)/(SELECT COUNT(tm.id_matric) FROM matriculas AS tm, inscripciones AS ti  WHERE tm.id_estado=2 AND tm.`año` = `_año` AND 
				tm.id_inst = _id_inst AND tm.cod_est = ti.cod_est AND tm.id_grado = te.cod_grado  
				GROUP BY tm.id_inst, tm.`año`,tm.id_grado),2) AS porciento 
				FROM estadistica_grupo te 
				LEFT JOIN grados AS tg ON te.cod_grado = tg.id 
				LEFT JOIN escala_nacional AS td ON te.id_desempeño = td.id 
				LEFT JOIN sedes AS ts ON te.id_sede = ts.id 
				WHERE te.id_inst= _id_inst AND te.año = `_año` AND te.periodo = _periodo AND 
				 te.cod_grado BETWEEN 10 AND 13 AND ts.id_inst = _id_inst 
				AND td.id = 1 
				GROUP BY te.id_inst,te.cod_grado,te.id_desempeño, te.periodo, te.`año` 
				ORDER BY te.id_inst,te.cod_grado,te.periodo,te.id_desempeño,te.total;
			END IF;
		ELSE
			IF  _periodo = '0' THEN
				SELECT te.id_inst,te.cod_grado, COUNT(te.total) AS totals,
				te.`id_desempeño`, te.periodo, te.`año`, td.nombre_escala desempeño,
				(SELECT COUNT(tm.id_matric) FROM matriculas AS tm, inscripciones AS ti  WHERE tm.id_estado=2 AND tm.`año` = `_año` AND 
				tm.id_inst = _id_inst AND tm.cod_est = ti.cod_est AND tm.id_grado = te.cod_grado 
				GROUP BY tm.id_inst, tm.`año`,tm.id_grado) AS total_niños,
				ROUND((COUNT(te.total)*100)/(SELECT COUNT(tm.id_matric) FROM matriculas AS tm, inscripciones AS ti  WHERE tm.id_estado=2 AND tm.`año` = `_año` AND 
				tm.id_inst = _id_inst AND tm.cod_est = ti.cod_est AND tm.id_grado = te.cod_grado  
				GROUP BY tm.id_inst, tm.`año`,tm.id_grado),2) AS porciento 
				FROM estadistica_grupo te 
				LEFT JOIN grados AS tg ON te.cod_grado = tg.id 
				LEFT JOIN escala_nacional AS td ON te.id_desempeño = td.id 
				LEFT JOIN sedes AS ts ON te.id_sede = ts.id 
				WHERE te.id_inst= _id_inst AND te.año = `_año` AND 
				 te.cod_grado BETWEEN 14 AND 24  AND ts.id_inst = _id_inst 
				AND td.id = 1 
				GROUP BY te.id_inst,te.cod_grado,te.id_desempeño, te.periodo, te.`año` 
				ORDER BY te.id_inst,te.periodo,te.cod_grado,te.id_desempeño,te.total;
			ELSE
				SELECT te.id_inst,te.cod_grado, COUNT(te.total) AS totals,
				te.`id_desempeño`, te.periodo, te.`año`, td.nombre_escala desempeño,
				(SELECT COUNT(tm.id_matric) FROM matriculas AS tm, inscripciones AS ti  WHERE tm.id_estado=2 AND tm.`año` = `_año` AND 
				tm.id_inst = _id_inst AND tm.cod_est = ti.cod_est AND tm.id_grado = te.cod_grado 
				GROUP BY tm.id_inst, tm.`año`,tm.id_grado) AS total_niños,
				ROUND((COUNT(te.total)*100)/(SELECT COUNT(tm.id_matric) FROM matriculas AS tm, inscripciones AS ti  WHERE tm.id_estado=2 AND tm.`año` = `_año` AND 
				tm.id_inst = _id_inst AND tm.cod_est = ti.cod_est AND tm.id_grado = te.cod_grado  
				GROUP BY tm.id_inst, tm.`año`,tm.id_grado),2) AS porciento 
				FROM estadistica_grupo te 
				LEFT JOIN grados AS tg ON te.cod_grado = tg.id 
				LEFT JOIN escala_nacional AS td ON te.id_desempeño = td.id 
				LEFT JOIN sedes AS ts ON te.id_sede = ts.id 
				WHERE te.id_inst= _id_inst AND te.año = `_año` AND te.periodo = _periodo AND 
				 te.cod_grado BETWEEN 14 AND 24 AND ts.id_inst = _id_inst 
				AND td.id = 1 
				GROUP BY te.id_inst,te.cod_grado,te.id_desempeño, te.periodo, te.`año` 
				ORDER BY te.id_inst,te.cod_grado,te.periodo,te.id_desempeño,te.total;
			END IF;
	END CASE;
END$$

DROP PROCEDURE IF EXISTS `sp_estadistica_select_total_grados`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_estadistica_select_total_grados` (IN `_id_inst` INT(20), IN `_año` YEAR, IN `_cod_grado` VARCHAR(2), IN `_periodo` VARCHAR(1))  BEGIN
		SELECT te.id_inst,te.cod_grado, COUNT(te.total) AS totals,
		te.`id_desempeño`, te.periodo, te.`año`, tg.grado, td.nombre_escala desempeño,
		(SELECT COUNT(tm.id_matric) FROM matriculas AS tm, inscripciones AS te  WHERE tm.id_estado=2 AND tm.`año` = `_año` AND 
		tm.id_inst = _id_inst AND tm.cod_est = te.cod_est AND tm.id_grado = _cod_grado 
		GROUP BY tm.id_inst, tm.`año`,tm.id_grado) AS total_niños,
		ROUND((COUNT(te.total)*100)/(SELECT COUNT(tm.id_matric) FROM matriculas AS tm, inscripciones AS te  WHERE tm.id_estado=2 AND tm.`año` = `_año` AND 
		tm.id_inst = _id_inst AND tm.cod_est = te.cod_est AND tm.id_grado = _cod_grado
		GROUP BY tm.id_inst, tm.`año`,tm.id_grado),2) AS porciento
		FROM estadistica_grupo te 
		LEFT JOIN grados AS tg ON te.cod_grado = tg.id 
		LEFT JOIN escala_nacional AS td ON te.id_desempeño = td.id 
		LEFT JOIN sedes AS ts ON te.id_sede = ts.id 
		WHERE te.id_inst= _id_inst AND te.año = `_año` AND te.periodo = _periodo AND  
		 te.cod_grado = _cod_grado  AND ts.id_inst = _id_inst 
		GROUP BY te.id_inst,te.cod_grado, te.id_desempeño, te.periodo, te.`año` 
		ORDER BY te.id_inst,te.periodo,te.cod_grado,te.id_desempeño,te.total;
END$$

DROP PROCEDURE IF EXISTS `sp_evaluacion_estudiantes_update_nota`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_evaluacion_estudiantes_update_nota` (IN `_id_eval_comp` INT(30))  BEGIN
	DECLARE _id_curso,_auto_calificar,_id_column_nota,_id_matric,_id_asig,_id_docente INT(30) DEFAULT 0;
	DECLARE _suma, _max DECIMAL(6,2) DEFAULT 0;
	DECLARE _column_nota VARCHAR(6) DEFAULT '';
	DECLARE _cod_grado,_periodo VARCHAR(2) DEFAULT '';
	SELECT t.id_curso,t.auto_calificar,RTRIM(SUBSTR(t.column_nota,2)),t.id_column_nota,te.id_matric,t.periodo INTO 
		_id_curso,_auto_calificar,_column_nota,_id_column_nota,_id_matric,_periodo FROM te_evaluaciones t 
		LEFT JOIN te_evaluacion_compartida AS te ON te.id_evaluacion = t.id 
		WHERE te.id = _id_eval_comp;
	IF _auto_calificar = 1 THEN 
		SELECT AVG(t.punataje), MAX(t.punataje) INTO _suma,_max FROM te_evaluaciones_estudiantes t 
			WHERE t.id_evaluacion_compartida = _id_eval_comp;
		SELECT t.cod_grado,t.id_asig,t.id_docente INTO _cod_grado,_id_asig,_id_docente FROM cursos t WHERE t.id = _id_curso;
		SET @_column_nota = _column_nota;
		SET @_id_column_nota	= _id_column_nota;
		IF _suma > _max THEN 
			SET _suma	= _suma;
		ELSE 
			SET _suma	= _max;
		END IF;
		CASE 
			WHEN _cod_grado >= '01' AND _cod_grado <= '05' THEN 
				SET @sqlUpdate	= CONCAT('UPDATE nscp001 SET ',_column_nota,' = ',_suma,
				' WHERE id_asig = ',_id_asig,' AND id_matric = ',_id_matric,' AND periodo = ',_periodo,' AND id_docente = ',_id_docente);
			WHEN _cod_grado >= '06' AND _cod_grado <= '09' THEN 
				SET @sqlUpdate	= CONCAT('UPDATE nscp002 SET ',_column_nota,' = ',_suma,
				' WHERE id_asig = ',_id_asig,' AND id_matric = ',_id_matric,' AND periodo = ',_periodo,' AND id_docente = ',_id_docente);
			WHEN _cod_grado >= '10' AND _cod_grado <= '99' THEN 
				SET @sqlUpdate	= CONCAT('UPDATE nscp003 SET ',_column_nota,' = ',_suma,
				' WHERE id_asig = ',_id_asig,' AND id_matric = ',_id_matric,' AND periodo = ',_periodo,' AND id_docente = ',_id_docente);
			ELSE
				SET @sqlUpdate	= CONCAT('UPDATE nscp001 SET ',_column_nota,' = ',_suma,
				' WHERE id_asig = ',_id_asig,' AND id_matric = ',_id_matric,' AND periodo = ',_periodo,' AND id_docente = ',_id_docente);
		END CASE;
		PREPARE stmt FROM @sqlUpdate;
		EXECUTE stmt;
		DEALLOCATE PREPARE stmt;
	END IF;
END$$

DROP PROCEDURE IF EXISTS `sp_familiares`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_familiares` (IN `_id_inst` INT(30), IN `_año` YEAR, IN `_grado` INT(11), IN `_id_sede` INT(30))  BEGIN
	SELECT te.nro_doc_id,
	CONCAT(RTRIM(te.apellido1),' ',RTRIM(te.apellido2),' ',RTRIM(te.nombre1),' ',RTRIM(te.nombre2)) AS estudiante,
	tg.cod_grado,tm.grupo, te.direccion ,tf.nro_documento nro_docum,
	CONCAT(RTRIM(tf.apellido1),' ',RTRIM(tf.apellido2),' ',RTRIM(tf.nombre1),' ',RTRIM(tf.nombre2)) AS acudiente,
	tf.direccion AS dir_acudiente, tf.celular cel, RTRIM(tg.grado) grado, RTRIM(ts.NOM_SEDE) sede
	FROM inscripciones AS te
	LEFT JOIN matriculas AS tm ON tm.cod_est = te.cod_est 
	LEFT JOIN aux_familiares_estudiantes AS ta ON ta.cod_est = te.cod_est
	LEFT JOIN familiares AS tf ON ta.id_familiar = tf.id 
	LEFT JOIN grados AS tg ON tm.id_grado = tg.id
	LEFT JOIN sedes AS ts ON tm.id_sede = ts.ID
	WHERE tm.id_grado= _grado AND tm.id_sede= _id_sede
	AND tm.año= `_año` AND ta.tipo_famil='Acudiente'
	GROUP BY ta.cod_est, ta.tipo_famil, tf.id_inst 
	ORDER BY tm.id_grado,tm.grupo,acudiente,estudiante;
END$$

DROP PROCEDURE IF EXISTS `sp_firma_dir_grupo`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_firma_dir_grupo` (IN `_id_inst` INT(20), IN `_id_sede` INT(20), IN `_cod_grado` INT(11), IN `_grupo` VARCHAR(2), IN `_id_jorn` INT(1), IN `_año` YEAR)  BEGIN
	DECLARE _ndoc INT DEFAULT 0;
	DECLARE _firm TEXT DEFAULT '';
	
	SELECT td.id_docente INTO _ndoc FROM docentes AS td
	LEFT JOIN dir_grupo AS tdr ON tdr.id_docente = td.id_docente 
	WHERE tdr.id_inst = _id_inst  AND tdr.id_grado = _cod_grado  AND tdr.grupo = _grupo AND tdr.id_sede=_id_sede 
	AND tdr.id_jorn = _id_jorn AND tdr.`año` = `_año` AND td.id_inst = _id_inst AND td.`año` = `_año`
	LIMIT 1;
	
	IF NOT _ndoc THEN	
		SELECT tc.firma4 AS firma FROM firmas AS tc WHERE tc.id_inst = _id_inst LIMIT 1;
	ELSE
		SELECT CONCAT("______________________________",'\n ',RTRIM(td.nombre1),' ',RTRIM(td.nombre2),' ',
		RTRIM(td.apellido1),' ',RTRIM(td.apellido2),'\n ','DIRECTOR(A) DE GRUPO') AS firma FROM docentes AS td
		LEFT JOIN dir_grupo AS tdr ON tdr.id_docente = td.id_docente 
		WHERE tdr.id_inst = _id_inst  AND tdr.id_grado = _cod_grado  AND tdr.grupo = _grupo AND tdr.id_sede=_id_sede
		AND tdr.id_jorn = _id_jorn AND tdr.`año` = `_año` AND td.id_inst = _id_inst AND td.`año` = `_año` LIMIT 1;
	END IF;
END$$

DROP PROCEDURE IF EXISTS `sp_fn_asignaturas_perdidas`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_fn_asignaturas_perdidas` (IN `_id_matric` INT(30), IN `_year` YEAR, IN `_id_grado` INT(11))  READS SQL DATA
BEGIN
	/*DROP TABLE IF EXISTS tmpTableAreasf;*/
	CREATE TEMPORARY TABLE IF NOT EXISTS tmpTableAreasf (
			cod_area	INT(30) NOT NULL,
			final	DECIMAL(6,2)
		);	
		
	INSERT INTO tmpTableAreasf(cod_area,final) 
	SELECT ta.id_area, 
	ROUND(IF(tmc.porciento BETWEEN 1 AND 99,SUM((t.final*tmc.porciento)/100),AVG(t.final)),2)  
	FROM areasf AS t 
	LEFT JOIN cursos AS tc ON t.id_curso = tc.id
	LEFT JOIN asignaturas AS ta ON tc.id_asig = ta.id_pk 
	LEFT JOIN matcurso AS tmc ON (tmc.id_asig = ta.id_pk AND tmc.id_grado = tc.id_grado
	AND tmc.`año` = tc.`año`)
	WHERE t.id_matric = _id_matric AND tc.`año` = _year AND tc.id_grado = _id_grado
	AND tmc.`año` = _year AND tmc.id_grado = _id_grado
	AND tmc.estado = 1 AND ta.estado = 1 AND t.id_curso = tc.id
	GROUP BY ta.id_area, t.id_matric, tc.`año`;	
	SELECT fn_asignaturas_perdidas(_id_matric, _year,_id_grado);
	DELETE FROM tmpTableAreasf;
END$$

DROP PROCEDURE IF EXISTS `sp_generar_consolidados`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_generar_consolidados` (IN `_id_inst` INT(20), IN `_año` YEAR, IN `_periodo` VARCHAR(1), IN `_cod_grado` INT(11), IN `_grupo` VARCHAR(2), IN `_type` INT(20))  BEGIN
	DECLARE 	done,
				_id_matric INT DEFAULT 0;
	DECLARE curm CURSOR FOR SELECT tm.id_matric FROM matriculas AS tm WHERE tm.id_inst = _id_inst AND tm.`año` = `_año` 
						AND tm.id_grado = _cod_grado AND tm.id_estado = 2 ORDER BY tm.id_grado, tm.grupo, tm.id_jorn;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done = 1;
	OPEN curm;
	REPEAT 
		FETCH curm INTO _id_matric;
		IF NOT done THEN 
			CASE _type
				WHEN 1 THEN
					CALL sp_consolidado_asignaturas(_id_matric, _periodo);
				WHEN 2 THEN
					CALL sp_consolidado_areas(_id_matric, _periodo);
				ELSE
					CALL sp_consolidado_docentes(_id_matic, _periodo, _type);
			END CASE;
		END IF;
	UNTIL done END REPEAT;
	CLOSE curm;
END$$

DROP PROCEDURE IF EXISTS `sp_generate_sabanas`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_generate_sabanas` (IN `_id_inst` INT, IN `_año` INT, IN `_id_matric` INT(30), IN `_grado` INT(11))  BEGIN
	DECLARE 	done,
				_cod_area,
				x_count,
				x_count_2,
				_id_area_n,
				x_id_matric,
				_ndecim,
				x_cant_asig_perdidas INT(11) DEFAULT 0;
	DECLARE aa1,aa2,aa3,aa4,aa5,aa6,aa7,aa8,aa9,aa10,aa11,
							aa12,aa13,aa14,aa15,aa16,aa17,aa18,aa19,aa20,
							aa21,aa22,aa23,aa24,aa25,x_count_matcurso INT(11) DEFAULT 0;
	DECLARE	_final,
				_suma,
				_desde DECIMAL(6,2) DEFAULT 0;
	DECLARE 	_cod_grado,
				_grupo VARCHAR(2) DEFAULT '';
	DECLARE 	oStrimValue,
				sValue,
				yValue CHAR DEFAULT '';
	DECLARE sf VARCHAR(20) DEFAULT '';
	DECLARE cur_matcurso CURSOR FOR SELECT ta.id_area FROM matcurso AS tm 
				LEFT JOIN asignaturas AS ta ON tm.id_asig = ta.id_pk 
				WHERE tm.año = _año AND tm.id_grado = _grado 
				AND tm.id_inst = _id_inst
				AND ta.id_inst = _id_inst 
			   GROUP BY ta.id_area, tm.año, tm.id_grado,tm.id_inst 
			   ORDER BY ta.id_area;
	DECLARE cur1 CURSOR FOR SELECT tas.id_area, 
			ROUND(IF(tmc.porciento BETWEEN 1 AND 99,
			SUM(IF(tn.recuperacion > 0,(tn.recuperacion*tmc.porciento)/100,(tn.final*tmc.porciento)/100)),
			AVG(IF(tn.recuperacion > 0, tn.recuperacion, tn.final))),_ndecim) AS prom
			FROM areasf AS tn 
			LEFT JOIN cursos AS tc ON tn.id_curso = tc.id
			LEFT JOIN matriculas AS tm ON tn.id_matric = tm.id_matric
			LEFT JOIN asignaturas AS tas ON tc.id_asig = tas.id_pk 
			LEFT JOIN matcurso AS tmc ON (tmc.id_asig = tas.id_pk AND tmc.id_grado = tc.id_grado) 
			LEFT JOIN areas AS tar ON tas.id_area = tar.id
			WHERE tm.id_inst = _id_inst AND tn.id_matric = _id_matric
			AND tc.`año` = _año AND tc.id_grado = _grado
			AND tas.id_inst = _id_inst AND tar.id_inst = _id_inst 
			AND tmc.id_inst = _id_inst AND tmc.`año` = `_año` 
			AND tmc.id_grado = _grado
			GROUP BY tn.id_matric, tas.id_area;
							
	DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done = 1;
	
	SELECT td.hasta INTO _desde FROM `desempeños` as td 
	LEFT JOIN grados_agrupados AS t1 ON td.id_grado_agrupado = t1.id
	LEFT JOIN aux_grados_agrupados AS t2 ON t2.id_grado_agrupado = t1.id
	WHERE td.id_inst = _id_inst AND td.`año` = _año AND td.reprueba = 1 
	AND t2.id_grado = _grado LIMIT 1;

	 
	SELECT tc.Ndecimales INTO _ndecim FROM config001 tc
	LEFT JOIN grados_agrupados AS t1 ON tc.id_grupo_grados = t1.id
	LEFT JOIN aux_grados_agrupados AS t2 ON t2.id_grado_agrupado = t1.id
	WHERE tc.id_inst = _id_inst AND tc.`AÑO` = `_año` AND t2.id_grado = _grado LIMIT 1;
	
	OPEN cur_matcurso; 
	REPEAT 
	FETCH cur_matcurso INTO _cod_area;
		IF NOT done THEN 
		 SET x_count = x_count + 1;
			CASE x_count
				WHEN 1 THEN 
					SET aa1 = _cod_area;
				WHEN 2 THEN 
					SET aa2 = _cod_area;
				WHEN 3 THEN 
					SET aa3 = _cod_area;
				WHEN 4 THEN 
					SET aa4 = _cod_area;
				WHEN 5 THEN 
					SET aa5 = _cod_area;
				WHEN 6 THEN 
					SET aa6 = _cod_area;
				WHEN 7 THEN 
					SET aa7 = _cod_area;
				WHEN 8 THEN 
					SET aa8 = _cod_area;
				WHEN 9 THEN 
					SET aa9 = _cod_area;
				WHEN 10 THEN 
					SET aa10 = _cod_area;
				WHEN 11 THEN 
					SET aa11 = _cod_area;
				WHEN 12 THEN 
					SET aa12 = _cod_area;
				WHEN 13 THEN 
					SET aa13 = _cod_area;
				WHEN 14 THEN 
					SET aa14 = _cod_area;
				WHEN 15 THEN 
					SET aa15 = _cod_area;
				WHEN 16 THEN 
					SET aa16 = _cod_area;
				WHEN 17 THEN 
					SET aa17 = _cod_area;
				WHEN 18 THEN 
					SET aa18 = _cod_area;
				WHEN 19 THEN 
					SET aa19 = _cod_area;
				WHEN 20 THEN 
					SET aa20 = _cod_area;
				WHEN 21 THEN 
					SET aa21 = _cod_area;
				WHEN 22 THEN 
					SET aa22 = _cod_area;
				WHEN 23 THEN 
					SET aa23 = _cod_area;
				WHEN 24 THEN 
					SET aa24 = _cod_area;
				WHEN 25 THEN 
					SET aa25 = _cod_area;
				ELSE
					SET done = 1;
			END CASE;
		END IF;
	UNTIL done END REPEAT;
	CLOSE cur_matcurso;
		
	SELECT id_matric INTO x_id_matric FROM sabanas WHERE id_matric = _id_matric;
	
	IF NOT x_id_matric THEN 
		INSERT INTO  sabanas (id_matric) VALUES (_id_matric);
	ELSE
		UPDATE sabanas SET nar1 = '', nar2 = '',nar3 = '',nar4 = '',nar5 = '',nar6 = '',nar7 = '',nar8 = '',nar9 = '',nar10 = '',
		nar11 = '', nar12 = '',nar13 = '',nar14 = '',nar15 = '',nar16 = '',nar17 = '',nar18 = '',nar19 = '',nar20 = '',
		nar21 = '', nar22 = '',nar23 = '',nar24 = '',nar25 = '',
        ar1 = 0, ar2 = 0,ar3 = 0,ar4 = 0,ar5 = 0,ar6 = 0,ar7 = 0,ar8 = 0,ar9 = 0,ar10 = 0,
		ar11 = 0, ar12 = 0,ar13 = 0,ar14 = 0,ar15 = 0,ar16 = 0,ar17 = 0,ar18 = 0,ar19 = 0,ar20 = 0,
		ar21 = 0, ar22 = 0,ar23 = 0,ar24 = 0,ar25 = 0
		 WHERE id_matric = _id_matric;
	END IF;
	SET done = 0;
	SET x_count = 0;
			OPEN cur1;
			REPEAT 
			FETCH cur1 INTO _id_area_n,_final;
			IF NOT done THEN 
				SET x_count = x_count + 1;
				SET x_count_matcurso = 25;
				SET _suma	= _suma + _final;
				SELECT es.abrev INTO sf FROM `desempeños` as td 
				LEFT JOIN escala_nacional AS es ON td.id_escala = es.id
				LEFT JOIN grados_agrupados AS t1 ON td.id_grado_agrupado = t1.id
				LEFT JOIN aux_grados_agrupados AS t2 ON t2.id_grado_agrupado = t1.id
				WHERE td.id_inst = _id_inst AND td.`año` = _año 
				AND _final BETWEEN td.desde AND td.hasta
				AND t2.id_grado = _grado LIMIT 1;
				SET done = 0;
				WHILE x_count_matcurso > 0 DO
					SET x_count_matcurso = x_count_matcurso - 1;
					SET x_count_2 = x_count_2 + 1 ;
					CASE x_count_2
						WHEN 1 THEN 
							IF _id_area_n =  aa1 THEN 
								UPDATE sabanas tc SET tc.ar1 = aa1 , tc.nar1 = sf
								WHERE tc.id_matric = _id_matric;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE sabanas tc SET tc.ar1 = aa1 , tc.nar1 = ''
								WHERE tc.id_matric = _id_matric;
							END IF;
							SET done = 0;
						WHEN 2 THEN 
							IF _id_area_n =  aa2 THEN 
								UPDATE sabanas tc SET tc.ar2 = aa2 , tc.nar2 = sf 
								WHERE tc.id_matric = _id_matric;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE sabanas tc SET tc.ar2 = aa2 , tc.nar2 = ''
								WHERE tc.id_matric = _id_matric;
							END IF;
							SET done = 0;
						WHEN 3 THEN 
							IF _id_area_n =  aa3 THEN 
								UPDATE sabanas tc SET tc.ar3 = aa3 , tc.nar3 = sf 
								WHERE tc.id_matric = _id_matric;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE sabanas tc SET tc.ar3 = aa3 , tc.nar3 = ''
								WHERE tc.id_matric = _id_matric;
							END IF;
							SET done = 0;
						WHEN 4 THEN 
							IF _id_area_n =  aa4 THEN 
								UPDATE sabanas tc SET tc.ar4 = aa4 , tc.nar4 = sf 
								WHERE tc.id_matric = _id_matric;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE sabanas tc SET tc.ar4 = aa4 , tc.nar4 = ''
								WHERE tc.id_matric = _id_matric;
							END IF;
							SET done = 0;
						WHEN 5 THEN 
							IF _id_area_n =  aa5 THEN 
								UPDATE sabanas tc SET tc.ar5 = aa5 , tc.nar5 = sf 
								WHERE tc.id_matric = _id_matric;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE sabanas tc SET tc.ar5 = aa5 , tc.nar5 = ''
								WHERE tc.id_matric = _id_matric;
							END IF;
							SET done = 0;
						WHEN 6 THEN 
							IF _id_area_n =  aa6 THEN 
								UPDATE sabanas tc SET tc.ar6 = aa6 , tc.nar6 = sf 
								WHERE tc.id_matric = _id_matric;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE sabanas tc SET tc.ar6 = aa6 , tc.nar6 = ''
								WHERE tc.id_matric = _id_matric;
							END IF;
							SET done = 0;
						WHEN 7 THEN 
							IF _id_area_n =  aa7 THEN 
								UPDATE sabanas tc SET tc.ar7 = aa7 , tc.nar7 = sf 
								WHERE tc.id_matric = _id_matric;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE sabanas tc SET tc.ar7 = aa7 , tc.nar7 = ''
								WHERE tc.id_matric = _id_matric;
							END IF;
							SET done = 0;
						WHEN 8 THEN 
							IF _id_area_n =  aa8 THEN 
								UPDATE sabanas tc SET tc.ar8 = aa8 , tc.nar8 = sf 
								WHERE tc.id_matric = _id_matric;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE sabanas tc SET tc.ar8 = aa8 , tc.nar8 = ''
								WHERE tc.id_matric = _id_matric;
							END IF;
							SET done = 0;
						WHEN 9 THEN 
							IF _id_area_n =  aa9 THEN 
								UPDATE sabanas tc SET tc.ar9 = aa9 , tc.nar9 = sf 
								WHERE tc.id_matric = _id_matric;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE sabanas tc SET tc.ar9 = aa9 , tc.nar9 = ''
								WHERE tc.id_matric = _id_matric;
							END IF;
							SET done = 0;
						WHEN 10 THEN 
							IF _id_area_n =  aa10 THEN 
								UPDATE sabanas tc SET tc.ar10 = aa10 , tc.nar10 = sf 
								WHERE tc.id_matric = _id_matric;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE sabanas tc SET tc.ar10 = aa10 , tc.nar10 = ''
								WHERE tc.id_matric = _id_matric;
							END IF;
							SET done = 0;
						WHEN 11 THEN 
							IF _id_area_n =  aa11 THEN 
								UPDATE sabanas tc SET tc.ar11 = aa11 , tc.nar11 = sf 
								WHERE tc.id_matric = _id_matric;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE sabanas tc SET tc.ar11 = aa11 , tc.nar11 = ''
								WHERE tc.id_matric = _id_matric;
							END IF;
							SET done = 0;
						WHEN 12 THEN 
							IF _id_area_n =  aa12 THEN 
								UPDATE sabanas tc SET tc.ar12 = aa12 , tc.nar12 = sf 
								WHERE tc.id_matric = _id_matric;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE sabanas tc SET tc.ar12 = aa12 , tc.nar12 = ''
								WHERE tc.id_matric = _id_matric;
							END IF;
							SET done = 0;
						WHEN 13 THEN 
							IF _id_area_n =  aa13 THEN 
								UPDATE sabanas tc SET tc.ar13 = aa13 , tc.nar13 = sf 
								WHERE tc.id_matric = _id_matric;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE sabanas tc SET tc.ar13 = aa13 , tc.nar13 = ''
								WHERE tc.id_matric = _id_matric;
							END IF;
							SET done = 0;
						WHEN 14 THEN 
							IF _id_area_n =  aa14 THEN 
								UPDATE sabanas tc SET tc.ar14 = aa14 , tc.nar14 = sf 
								WHERE tc.id_matric = _id_matric;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE sabanas tc SET tc.ar14 = aa14 , tc.nar14 = ''
								WHERE tc.id_matric = _id_matric;
							END IF;
							SET done = 0;
						WHEN 15 THEN 
							IF _id_area_n =  aa15 THEN 
								UPDATE sabanas tc SET tc.ar15 = aa15 , tc.nar15 = sf 
								WHERE tc.id_matric = _id_matric;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE sabanas tc SET tc.ar15 = aa15 , tc.nar15 = ''
								WHERE tc.id_matric = _id_matric;
							END IF;
							SET done = 0;
						WHEN 16 THEN 
							IF _id_area_n =  aa16 THEN 
								UPDATE sabanas tc SET tc.ar16 = aa16 , tc.nar16 = sf 
								WHERE tc.id_matric = _id_matric;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE sabanas tc SET tc.ar16 = aa16 , tc.nar16 = ''
								WHERE tc.id_matric = _id_matric;
							END IF;
							SET done = 0;
						WHEN 17 THEN 
							IF _id_area_n =  aa17 THEN 
								UPDATE sabanas tc SET tc.ar17 = aa17 , tc.nar17 = sf 
								WHERE tc.id_matric = _id_matric;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE sabanas tc SET tc.ar17 = aa17 , tc.nar17 = ''
								WHERE tc.id_matric = _id_matric;
							END IF;
							SET done = 0;
						WHEN 18 THEN 
							IF _id_area_n =  aa18 THEN 
								UPDATE sabanas tc SET tc.ar18 = aa18 , tc.nar18 = sf 
								WHERE tc.id_matric = _id_matric;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE sabanas tc SET tc.ar18 = aa18 , tc.nar18 = ''
								WHERE tc.id_matric = _id_matric;
							END IF;
							SET done = 0;
						WHEN 19 THEN 
							IF _id_area_n =  aa19 THEN 
								UPDATE sabanas tc SET tc.ar19 = aa19 , tc.nar19 = sf 
								WHERE tc.id_matric = _id_matric;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE sabanas tc SET tc.ar19 = aa19 , tc.nar19 = ''
								WHERE tc.id_matric = _id_matric;
							END IF;
							SET done = 0;
						WHEN 20 THEN 
							IF _id_area_n =  aa20 THEN 
								UPDATE sabanas tc SET tc.ar20 = aa20 , tc.nar20 = sf 
								WHERE tc.id_matric = _id_matric;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE sabanas tc SET tc.ar20 = aa20 , tc.nar20 = ''
								WHERE tc.id_matric = _id_matric;
							END IF;
							SET done = 0;
						WHEN 21 THEN 
							IF _id_area_n =  aa21 THEN 
								UPDATE sabanas tc SET tc.ar21 = aa21 , tc.nar21 = sf 
								WHERE tc.id_matric = _id_matric;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE sabanas tc SET tc.ar21 = aa21 , tc.nar21 = ''
								WHERE tc.id_matric = _id_matric;
							END IF;
							SET done = 0;
						WHEN 22 THEN 
							IF _id_area_n =  aa22 THEN 
								UPDATE sabanas tc SET tc.ar22 = aa22 , tc.nar22 = sf 
								WHERE tc.id_matric = _id_matric;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE sabanas tc SET tc.ar22 = aa22 , tc.nar22 = ''
								WHERE tc.id_matric = _id_matric;
							END IF;
							SET done = 0;
						WHEN 23 THEN 
							IF _id_area_n =  aa23 THEN 
								UPDATE sabanas tc SET tc.ar23 = aa23 , tc.nar23 = sf 
								WHERE tc.id_matric = _id_matric;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE sabanas tc SET tc.ar23 = aa23 , tc.nar23 = ''
								WHERE tc.id_matric = _id_matric;
							END IF;
							SET done = 0;
						WHEN 24 THEN 
							IF _id_area_n =  aa24 THEN 
								UPDATE sabanas tc SET tc.ar24 = aa24 , tc.nar24 = sf 
								WHERE tc.id_matric = _id_matric;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE sabanas tc SET tc.ar24 = aa24 , tc.nar24 = ''
								WHERE tc.id_matric = _id_matric;
							END IF;
							SET done = 0;
						WHEN 25 THEN 
							IF _id_area_n =  aa25 THEN 
								UPDATE sabanas tc SET tc.ar25 = aa25 , tc.nar25 = sf 
								WHERE tc.id_matric = _id_matric;
								SET x_count_matcurso = -1;
							ELSE
								UPDATE sabanas tc SET tc.ar25 = aa25 , tc.nar25 = ''
								WHERE tc.id_matric = _id_matric;
							END IF;
							SET done = 0;
					ELSE
						SET done = 0;
					END CASE;
				END WHILE; 
			END IF;
		UNTIL done END REPEAT;
		IF _suma > 0 THEN 
			SET _suma = ROUND(_suma/x_count,2);
		END IF;
		UPDATE sabanas cn SET cn.prom = _suma WHERE cn.id_matric = _id_matric;
		CLOSE cur1;	
END$$

DROP PROCEDURE IF EXISTS `sp_gen_c_honor`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_gen_c_honor` (IN `_id_inst` INT(30), IN `_año` YEAR, IN `_periodo` VARCHAR(2), IN `_ck` INT(1))  BEGIN
	DECLARE 
		_type_puesto INT DEFAULT 0;
	SELECT t.prom_area_puesto INTO _type_puesto FROM config001 t WHERE t.id_inst = _id_inst AND t.`AÑO` = `_año` LIMIT 1;
	IF _ck = 1 THEN
		SET _periodo = '';
	END IF;
	DELETE FROM cuadro_honor WHERE id_inst = _id_inst AND periodo = _periodo;
	IF _type_puesto = 1 THEN /*Promedio por Áreas*/
		IF _ck = 1 THEN /*Promedio todos los periodos o fin de año*/
			DELETE FROM tb_promedios_honor;
			INSERT INTO  tb_promedios_honor (id_matric,suma,nmax,periodo,id_inst,nivel)
			(SELECT SQL_SMALL_RESULT tn.id_matric, 
			ROUND(IF(tmc.porciento BETWEEN 1 AND 99,
			SUM(IF(tn.nota_habilitacion > 0,(tn.nota_habilitacion*tmc.porciento)/100,(tn.final*tmc.porciento)/100)),
			AVG(IF(tn.nota_habilitacion > 0, tn.nota_habilitacion, tn.final))),2) AS nota, 
			MAX(if(tn.nota_habilitacion > 0,tn.nota_habilitacion, tn.final)) max, '',tm.id_inst, tv.id AS niv
			FROM nscp001 AS tn 
			LEFT JOIN matriculas AS tm ON tn.id_matric = tm.id_matric
		   LEFT JOIN grados AS tg ON tm.id_grado = tg.id 
		   LEFT JOIN cursos AS tc ON (tn.id_curso = tc.id AND tn.`año` = tc.`año` AND tc.id_grado = tg.id)
		   LEFT JOIN asignaturas AS ta ON tc.id_asig = ta.id_pk
		   LEFT JOIN niveles_estudio AS tv ON tg.id_nivel = tv.id
			LEFT JOIN matcurso AS tmc ON (tmc.id_grado = tg.id AND tmc.id_asig = ta.id_pk)
			WHERE tm.id_inst = _id_inst AND tm.`año` = `_año` AND 
			tmc.`año` = `_año` AND tmc.id_inst = _id_inst AND tmc.estado = 1
			AND ta.id_inst = _id_inst AND ta.estado = 1 AND ta.electiva = 0
			GROUP BY tn.id_matric, ta.id_area) UNION 
			(SELECT SQL_SMALL_RESULT tn.id_matric, 
			ROUND(IF(tmc.porciento BETWEEN 1 AND 99,
			SUM(IF(tn.nota_habilitacion > 0,(tn.nota_habilitacion*tmc.porciento)/100,(tn.final*tmc.porciento)/100)),
			AVG(IF(tn.nota_habilitacion > 0, tn.nota_habilitacion, tn.final))),2) AS nota, 
			MAX(if(tn.nota_habilitacion > 0,tn.nota_habilitacion, tn.final)) max, '',tm.id_inst, tv.id AS niv
			FROM nscp002 AS tn 
			LEFT JOIN matriculas AS tm ON tn.id_matric = tm.id_matric
		   LEFT JOIN grados AS tg ON tm.id_grado = tg.id 
		   LEFT JOIN cursos AS tc ON (tn.id_curso = tc.id AND tn.`año` = tc.`año` AND tc.id_grado = tg.id)
		   LEFT JOIN asignaturas AS ta ON tc.id_asig = ta.id_pk
		   LEFT JOIN niveles_estudio AS tv ON tg.id_nivel = tv.id
			LEFT JOIN matcurso AS tmc ON (tmc.id_grado = tg.id AND tmc.id_asig = ta.id_pk)
			WHERE tm.id_inst = _id_inst AND tm.`año` = `_año` AND 
			tmc.`año` = `_año` AND tmc.id_inst = _id_inst AND tmc.estado = 1
			AND ta.id_inst = _id_inst AND ta.estado = 1 AND ta.electiva = 0
			GROUP BY tn.id_matric, ta.id_area) UNION 
			(SELECT SQL_SMALL_RESULT tn.id_matric, 
			ROUND(IF(tmc.porciento BETWEEN 1 AND 99,
			SUM(IF(tn.nota_habilitacion > 0,(tn.nota_habilitacion*tmc.porciento)/100,(tn.final*tmc.porciento)/100)),
			AVG(IF(tn.nota_habilitacion > 0, tn.nota_habilitacion, tn.final))),2) AS nota, 
			MAX(if(tn.nota_habilitacion > 0,tn.nota_habilitacion, tn.final)) max, '',tm.id_inst, tv.id AS niv
			FROM nscp003 AS tn 
			LEFT JOIN matriculas AS tm ON tn.id_matric = tm.id_matric
		   LEFT JOIN grados AS tg ON tm.id_grado = tg.id 
		   LEFT JOIN cursos AS tc ON (tn.id_curso = tc.id AND tn.`año` = tc.`año` AND tc.id_grado = tg.id)
		   LEFT JOIN asignaturas AS ta ON tc.id_asig = ta.id_pk
		   LEFT JOIN niveles_estudio AS tv ON tg.id_nivel = tv.id
			LEFT JOIN matcurso AS tmc ON (tmc.id_grado = tg.id AND tmc.id_asig = ta.id_pk)
			WHERE tm.id_inst = _id_inst AND tm.`año` = `_año` AND 
			tmc.`año` = `_año` AND tmc.id_inst = _id_inst AND tmc.estado = 1
			AND ta.id_inst = _id_inst AND ta.estado = 1 AND ta.electiva = 0
			GROUP BY tn.id_matric, ta.id_area)
			ORDER BY niv, nota DESC, max DESC; 
			INSERT INTO  cuadro_honor (id_matric,suma,nmax,periodo,id_inst,nivel) 
			SELECT t.id_matric, ROUND(AVG(t.suma),2),MAX(t.nmax),t.periodo,t.id_inst,t.nivel 
			FROM tb_promedios_honor t GROUP BY t.id_matric;
		ELSE
			DELETE FROM tb_promedios_honor;
			INSERT INTO  tb_promedios_honor (id_matric,suma,nmax,periodo,id_inst,nivel) 
			(SELECT SQL_SMALL_RESULT tn.id_matric, 
			ROUND(IF(tmc.porciento BETWEEN 1 AND 99,
			SUM(IF(tn.nota_habilitacion > 0,(tn.nota_habilitacion*tmc.porciento)/100,(tn.final*tmc.porciento)/100)),
			AVG(IF(tn.nota_habilitacion > 0, tn.nota_habilitacion, tn.final))),2) AS nota, 
			MAX(if(tn.nota_habilitacion > 0,tn.nota_habilitacion, tn.final)) max, tn.periodo,tm.id_inst, tv.id AS niv
			FROM nscp001 AS tn 
			LEFT JOIN matriculas AS tm ON tn.id_matric = tm.id_matric
		   LEFT JOIN grados AS tg ON tm.id_grado = tg.id 
		   LEFT JOIN cursos AS tc ON (tn.id_curso = tc.id AND tn.`año` = tc.`año` AND tc.id_grado = tg.id)
		   LEFT JOIN asignaturas AS ta ON tc.id_asig = ta.id_pk
		   LEFT JOIN niveles_estudio AS tv ON tg.id_nivel = tv.id
			LEFT JOIN matcurso AS tmc ON (tmc.id_grado = tg.id AND tmc.id_asig = ta.id_pk)
			WHERE tn.periodo = _periodo AND tm.id_inst = _id_inst AND tm.`año` = `_año` AND 
			tmc.`año` = `_año` AND tmc.id_inst = _id_inst AND tmc.estado = 1
			AND ta.id_inst = _id_inst AND ta.estado = 1 AND ta.electiva = 0
			GROUP BY tn.id_matric,tn.periodo, ta.id_area) UNION 
			(SELECT SQL_SMALL_RESULT tn.id_matric, 
			ROUND(IF(tmc.porciento BETWEEN 1 AND 99,
			SUM(IF(tn.nota_habilitacion > 0,(tn.nota_habilitacion*tmc.porciento)/100,(tn.final*tmc.porciento)/100)),
			AVG(IF(tn.nota_habilitacion > 0, tn.nota_habilitacion, tn.final))),2) AS nota, 
			MAX(if(tn.nota_habilitacion > 0,tn.nota_habilitacion, tn.final)) max, tn.periodo,tm.id_inst, tv.id AS niv
			FROM nscp002 AS tn 
			LEFT JOIN matriculas AS tm ON tn.id_matric = tm.id_matric
		   LEFT JOIN grados AS tg ON tm.id_grado = tg.id 
		   LEFT JOIN cursos AS tc ON (tn.id_curso = tc.id AND tn.`año` = tc.`año` AND tc.id_grado = tg.id)
		   LEFT JOIN asignaturas AS ta ON tc.id_asig = ta.id_pk
		   LEFT JOIN niveles_estudio AS tv ON tg.id_nivel = tv.id
			LEFT JOIN matcurso AS tmc ON (tmc.id_grado = tg.id AND tmc.id_asig = ta.id_pk)
			WHERE tn.periodo = _periodo AND tm.id_inst = _id_inst AND tm.`año` = `_año` AND 
			tmc.`año` = `_año` AND tmc.id_inst = _id_inst AND tmc.estado = 1
			AND ta.id_inst = _id_inst AND ta.estado = 1 AND ta.electiva = 0
			GROUP BY tn.id_matric,tn.periodo, ta.id_area) UNION 
			(SELECT SQL_SMALL_RESULT tn.id_matric, 
			ROUND(IF(tmc.porciento BETWEEN 1 AND 99,
			SUM(IF(tn.nota_habilitacion > 0,(tn.nota_habilitacion*tmc.porciento)/100,(tn.final*tmc.porciento)/100)),
			AVG(IF(tn.nota_habilitacion > 0, tn.nota_habilitacion, tn.final))),2) AS nota, 
			MAX(if(tn.nota_habilitacion > 0,tn.nota_habilitacion, tn.final)) max, tn.periodo,tm.id_inst, tv.id AS niv
			FROM nscp003 AS tn 
			LEFT JOIN matriculas AS tm ON tn.id_matric = tm.id_matric
		   LEFT JOIN grados AS tg ON tm.id_grado = tg.id 
		   LEFT JOIN cursos AS tc ON (tn.id_curso = tc.id AND tn.`año` = tc.`año` AND tc.id_grado = tg.id)
		   LEFT JOIN asignaturas AS ta ON tc.id_asig = ta.id_pk
		   LEFT JOIN niveles_estudio AS tv ON tg.id_nivel = tv.id
			LEFT JOIN matcurso AS tmc ON (tmc.id_grado = tg.id AND tmc.id_asig = ta.id_pk)
			WHERE tn.periodo = _periodo AND tm.id_inst = _id_inst AND tm.`año` = `_año` AND 
			tmc.`año` = `_año` AND tmc.id_inst = _id_inst AND tmc.estado = 1
			AND ta.id_inst = _id_inst AND ta.estado = 1 AND ta.electiva = 0
			GROUP BY tn.id_matric,tn.periodo, ta.id_area)
			ORDER BY niv, nota DESC, max DESC; 
			INSERT INTO  cuadro_honor (id_matric,suma,nmax,periodo,id_inst,nivel) 
			SELECT t.id_matric, ROUND(AVG(t.suma),2),MAX(t.nmax),t.periodo,t.id_inst,t.nivel 
			FROM tb_promedios_honor t GROUP BY t.id_matric, t.periodo;
		END IF;
	ELSE
		IF _ck = 1 THEN /*Promedio todos los periodos o fin de año*/
			DELETE FROM tb_promedios_honor;
			INSERT INTO  tb_promedios_honor (id_matric,suma,nmax,periodo,id_inst,nivel)
			(SELECT SQL_SMALL_RESULT tn.id_matric, 
			ROUND(IF(tmc.porciento BETWEEN 1 AND 99,
			SUM(IF(tn.nota_habilitacion > 0,(tn.nota_habilitacion*tmc.porciento)/100,(tn.final*tmc.porciento)/100)),
			AVG(IF(tn.nota_habilitacion > 0, tn.nota_habilitacion, tn.final))),2) AS nota, 
			MAX(if(tn.nota_habilitacion > 0,tn.nota_habilitacion, tn.final)) max, '',tm.id_inst, tv.id AS niv
			FROM nscp001 AS tn 
			LEFT JOIN matriculas AS tm ON tn.id_matric = tm.id_matric
		   LEFT JOIN grados AS tg ON tm.id_grado = tg.id 
		   LEFT JOIN cursos AS tc ON (tn.id_curso = tc.id AND tn.`año` = tc.`año` AND tc.id_grado = tg.id)
		   LEFT JOIN asignaturas AS ta ON tc.id_asig = ta.id_pk
		   LEFT JOIN niveles_estudio AS tv ON tg.id_nivel = tv.id
			LEFT JOIN matcurso AS tmc ON (tmc.id_grado = tg.id AND tmc.id_asig = ta.id_pk)
			WHERE tm.id_inst = _id_inst AND tm.`año` = `_año` AND 
			tmc.`año` = `_año` AND tmc.id_inst = _id_inst AND tmc.estado = 1
			AND ta.id_inst = _id_inst AND ta.estado = 1 AND ta.electiva = 0
			GROUP BY tn.id_matric) UNION 
			(SELECT SQL_SMALL_RESULT tn.id_matric, 
			ROUND(IF(tmc.porciento BETWEEN 1 AND 99,
			SUM(IF(tn.nota_habilitacion > 0,(tn.nota_habilitacion*tmc.porciento)/100,(tn.final*tmc.porciento)/100)),
			AVG(IF(tn.nota_habilitacion > 0, tn.nota_habilitacion, tn.final))),2) AS nota, 
			MAX(if(tn.nota_habilitacion > 0,tn.nota_habilitacion, tn.final)) max, '',tm.id_inst, tv.id AS niv
			FROM nscp002 AS tn 
			LEFT JOIN matriculas AS tm ON tn.id_matric = tm.id_matric
		   LEFT JOIN grados AS tg ON tm.id_grado = tg.id 
		   LEFT JOIN cursos AS tc ON (tn.id_curso = tc.id AND tn.`año` = tc.`año` AND tc.id_grado = tg.id)
		   LEFT JOIN asignaturas AS ta ON tc.id_asig = ta.id_pk
		   LEFT JOIN niveles_estudio AS tv ON tg.id_nivel = tv.id
			LEFT JOIN matcurso AS tmc ON (tmc.id_grado = tg.id AND tmc.id_asig = ta.id_pk)
			WHERE tm.id_inst = _id_inst AND tm.`año` = `_año` AND 
			tmc.`año` = `_año` AND tmc.id_inst = _id_inst AND tmc.estado = 1
			AND ta.id_inst = _id_inst AND ta.estado = 1 AND ta.electiva = 0
			GROUP BY tn.id_matric) UNION 
			(SELECT SQL_SMALL_RESULT tn.id_matric, 
			ROUND(IF(tmc.porciento BETWEEN 1 AND 99,
			SUM(IF(tn.nota_habilitacion > 0,(tn.nota_habilitacion*tmc.porciento)/100,(tn.final*tmc.porciento)/100)),
			AVG(IF(tn.nota_habilitacion > 0, tn.nota_habilitacion, tn.final))),2) AS nota, 
			MAX(if(tn.nota_habilitacion > 0,tn.nota_habilitacion, tn.final)) max, '',tm.id_inst, tv.id AS niv
			FROM nscp003 AS tn 
			LEFT JOIN matriculas AS tm ON tn.id_matric = tm.id_matric
		   LEFT JOIN grados AS tg ON tm.id_grado = tg.id 
		   LEFT JOIN cursos AS tc ON (tn.id_curso = tc.id AND tn.`año` = tc.`año` AND tc.id_grado = tg.id)
		   LEFT JOIN asignaturas AS ta ON tc.id_asig = ta.id_pk
		   LEFT JOIN niveles_estudio AS tv ON tg.id_nivel = tv.id
			LEFT JOIN matcurso AS tmc ON (tmc.id_grado = tg.id AND tmc.id_asig = ta.id_pk)
			WHERE tm.id_inst = _id_inst AND tm.`año` = `_año` AND 
			tmc.`año` = `_año` AND tmc.id_inst = _id_inst AND tmc.estado = 1
			AND ta.id_inst = _id_inst AND ta.estado = 1 AND ta.electiva = 0
			GROUP BY tn.id_matric)
			ORDER BY niv, nota DESC, max DESC; 
			INSERT INTO  cuadro_honor (id_matric,suma,nmax,periodo,id_inst,nivel) 
			SELECT t.id_matric, ROUND(AVG(t.suma),2),MAX(t.nmax),t.periodo,t.id_inst,t.nivel 
			FROM tb_promedios_honor t GROUP BY t.id_matric;
		ELSE
			DELETE FROM tb_promedios_honor;
			INSERT INTO  tb_promedios_honor (id_matric,suma,nmax,periodo,id_inst,nivel) 
			(SELECT SQL_SMALL_RESULT tn.id_matric, 
			ROUND(IF(tmc.porciento BETWEEN 1 AND 99,
			SUM(IF(tn.nota_habilitacion > 0,(tn.nota_habilitacion*tmc.porciento)/100,(tn.final*tmc.porciento)/100)),
			AVG(IF(tn.nota_habilitacion > 0, tn.nota_habilitacion, tn.final))),2) AS nota, 
			MAX(if(tn.nota_habilitacion > 0,tn.nota_habilitacion, tn.final)) max, tn.periodo,tm.id_inst, tv.id AS niv
			FROM nscp001 AS tn 
			LEFT JOIN matriculas AS tm ON tn.id_matric = tm.id_matric
		   LEFT JOIN grados AS tg ON tm.id_grado = tg.id 
		   LEFT JOIN cursos AS tc ON (tn.id_curso = tc.id AND tn.`año` = tc.`año` AND tc.id_grado = tg.id)
		   LEFT JOIN asignaturas AS ta ON tc.id_asig = ta.id_pk
		   LEFT JOIN niveles_estudio AS tv ON tg.id_nivel = tv.id
			LEFT JOIN matcurso AS tmc ON (tmc.id_grado = tg.id AND tmc.id_asig = ta.id_pk)
			WHERE tn.periodo = _periodo AND tm.id_inst = _id_inst AND tm.`año` = `_año` AND 
			tmc.`año` = `_año` AND tmc.id_inst = _id_inst AND tmc.estado = 1
			AND ta.id_inst = _id_inst AND ta.estado = 1 AND ta.electiva = 0
			GROUP BY tn.id_matric,tn.periodo) UNION 
			(SELECT SQL_SMALL_RESULT tn.id_matric, 
			ROUND(IF(tmc.porciento BETWEEN 1 AND 99,
			SUM(IF(tn.nota_habilitacion > 0,(tn.nota_habilitacion*tmc.porciento)/100,(tn.final*tmc.porciento)/100)),
			AVG(IF(tn.nota_habilitacion > 0, tn.nota_habilitacion, tn.final))),2) AS nota, 
			MAX(if(tn.nota_habilitacion > 0,tn.nota_habilitacion, tn.final)) max, tn.periodo,tm.id_inst, tv.id AS niv
			FROM nscp002 AS tn 
			LEFT JOIN matriculas AS tm ON tn.id_matric = tm.id_matric
		   LEFT JOIN grados AS tg ON tm.id_grado = tg.id 
		   LEFT JOIN cursos AS tc ON (tn.id_curso = tc.id AND tn.`año` = tc.`año` AND tc.id_grado = tg.id)
		   LEFT JOIN asignaturas AS ta ON tc.id_asig = ta.id_pk
		   LEFT JOIN niveles_estudio AS tv ON tg.id_nivel = tv.id
			LEFT JOIN matcurso AS tmc ON (tmc.id_grado = tg.id AND tmc.id_asig = ta.id_pk)
			WHERE tn.periodo = _periodo AND tm.id_inst = _id_inst AND tm.`año` = `_año` AND 
			tmc.`año` = `_año` AND tmc.id_inst = _id_inst AND tmc.estado = 1
			AND ta.id_inst = _id_inst AND ta.estado = 1 AND ta.electiva = 0
			GROUP BY tn.id_matric,tn.periodo) UNION 
			(SELECT SQL_SMALL_RESULT tn.id_matric, 
			ROUND(IF(tmc.porciento BETWEEN 1 AND 99,
			SUM(IF(tn.nota_habilitacion > 0,(tn.nota_habilitacion*tmc.porciento)/100,(tn.final*tmc.porciento)/100)),
			AVG(IF(tn.nota_habilitacion > 0, tn.nota_habilitacion, tn.final))),2) AS nota, 
			MAX(if(tn.nota_habilitacion > 0,tn.nota_habilitacion, tn.final)) max, tn.periodo,tm.id_inst, tv.id AS niv
			FROM nscp003 AS tn 
			LEFT JOIN matriculas AS tm ON tn.id_matric = tm.id_matric
		   LEFT JOIN grados AS tg ON tm.id_grado = tg.id 
		   LEFT JOIN cursos AS tc ON (tn.id_curso = tc.id AND tn.`año` = tc.`año` AND tc.id_grado = tg.id)
		   LEFT JOIN asignaturas AS ta ON tc.id_asig = ta.id_pk
		   LEFT JOIN niveles_estudio AS tv ON tg.id_nivel = tv.id
			LEFT JOIN matcurso AS tmc ON (tmc.id_grado = tg.id AND tmc.id_asig = ta.id_pk)
			WHERE tn.periodo = _periodo AND tm.id_inst = _id_inst AND tm.`año` = `_año` AND 
			tmc.`año` = `_año` AND tmc.id_inst = _id_inst AND tmc.estado = 1
			AND ta.id_inst = _id_inst AND ta.estado = 1 AND ta.electiva = 0
			GROUP BY tn.id_matric,tn.periodo)
			ORDER BY niv, nota DESC, max DESC; 
			INSERT INTO  cuadro_honor (id_matric,suma,nmax,periodo,id_inst,nivel) 
			SELECT t.id_matric, ROUND(AVG(t.suma),2),MAX(t.nmax),t.periodo,t.id_inst,t.nivel 
			FROM tb_promedios_honor t GROUP BY t.id_matric, t.periodo;
		END IF;
	END IF;	
END$$

DROP PROCEDURE IF EXISTS `sp_gen_c_honor_est`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_gen_c_honor_est` (IN `_id_matric` INT(20), IN `_periodo` VARCHAR(1))  BEGIN
	DECLARE _año, _id_inst, _id_sede, x_niv, n_count INT DEFAULT 0;
	DECLARE _cod_grado, _grupo VARCHAR(2) DEFAULT '';
	DECLARE _suma,_max DECIMAL(6,2) DEFAULT 0;
	
	SELECT tm.año, tm.id_inst, tm.id_sede, tm.cod_grado, tm.grupo 
	INTO  _año, _id_inst, _id_sede, _cod_grado, _grupo
	FROM matriculas AS tm WHERE tm.id_matric = _id_matric;
	DELETE FROM cuadro_honor WHERE id_matric = _id_matric AND periodo = _periodo;	
	CASE 
		WHEN _cod_grado BETWEEN '01' AND '05' THEN
			INSERT INTO  cuadro_honor (id_matric,suma,nmax,periodo,id_inst,nivel) 
			SELECT SQL_SMALL_RESULT tn.id_matric, ROUND(AVG(IF(tn.nota_habilitacion > 0, tn.nota_habilitacion, tn.final)),2) nota, 
			MAX(tn.final) max, tn.periodo,tm.id_inst, 2 niv FROM nscp001 AS tn 
			LEFT JOIN matriculas AS tm ON tn.id_matric = tm.id_matric
			WHERE tn.periodo = _periodo AND tm.id_inst = _id_inst AND tm.`año` = `_año` AND tn.final > 0
			AND tm.id_matric = _id_matric
			GROUP BY tn.id_matric, tn.periodo;
		WHEN _cod_grado = '99' THEN
			INSERT INTO  cuadro_honor (id_matric,suma,nmax,periodo,id_inst,nivel) 
			SELECT SQL_SMALL_RESULT tn.id_matric, ROUND(AVG(IF(tn.nota_habilitacion > 0, tn.nota_habilitacion, tn.final)),2) nota, 
			MAX(tn.final) max, tn.periodo,tm.id_inst, 2 niv FROM nscp003 AS tn 
			LEFT JOIN matriculas AS tm ON tn.id_matric = tm.id_matric
			WHERE tn.periodo = _periodo AND tm.id_inst = _id_inst AND tm.`año` = `_año` AND tn.final > 0
			AND tm.id_matric = _id_matric
			GROUP BY tn.id_matric, tn.periodo;	
		WHEN _cod_grado BETWEEN '06' AND '09' THEN
			INSERT INTO  cuadro_honor (id_matric,suma,nmax,periodo,id_inst,nivel) 
			SELECT SQL_SMALL_RESULT tn.id_matric, ROUND(AVG(IF(tn.nota_habilitacion > 0, tn.nota_habilitacion, tn.final)),2) nota, 
			MAX(tn.final) max, tn.periodo,tm.id_inst, 3 niv FROM nscp002 AS tn 
			LEFT JOIN matriculas AS tm ON tn.id_matric = tm.id_matric
			WHERE tn.periodo = _periodo AND tm.id_inst = _id_inst AND tm.`año` = `_año` AND tn.final > 0
			AND tm.id_matric = _id_matric
			GROUP BY tn.id_matric, tn.periodo;
		WHEN _cod_grado BETWEEN '10' AND '11' THEN 
			INSERT INTO  cuadro_honor (id_matric,suma,nmax,periodo,id_inst,nivel) 
			SELECT SQL_SMALL_RESULT tn.id_matric, ROUND(AVG(IF(tn.nota_habilitacion > 0, tn.nota_habilitacion, tn.final)),2) nota, 
			MAX(tn.final) max, tn.periodo,tm.id_inst, 4 niv FROM nscp003 AS tn 
			LEFT JOIN matriculas AS tm ON tn.id_matric = tm.id_matric
			WHERE tn.periodo = _periodo AND tm.id_inst = _id_inst AND tm.`año` = `_año` AND tn.final > 0
			AND tm.id_matric = _id_matric
			GROUP BY tn.id_matric, tn.periodo;	
		WHEN _cod_grado BETWEEN '21' AND '26' THEN 
			INSERT INTO  cuadro_honor (id_matric,suma,nmax,periodo,id_inst,nivel) 
			SELECT SQL_SMALL_RESULT tn.id_matric, ROUND(AVG(IF(tn.nota_habilitacion > 0, tn.nota_habilitacion, tn.final)),2) nota, 
			MAX(tn.final) max, tn.periodo,tm.id_inst, 5 niv FROM nscp003 AS tn 
			LEFT JOIN matriculas AS tm ON tn.id_matric = tm.id_matric
			WHERE tn.periodo = _periodo AND tm.id_inst = _id_inst AND tm.`año` = `_año` AND tn.final > 0
			AND tm.id_matric = _id_matric
			GROUP BY tn.id_matric, tn.periodo;
	END CASE;	
END$$

DROP PROCEDURE IF EXISTS `sp_get_columns_notas`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_get_columns_notas` (IN `_id_grado` INT(11), IN `_año` INT)  BEGIN
	DECLARE _result TEXT DEFAULT '';
	DECLARE done, _num, _row INT DEFAULT 0;
	DECLARE _name, _tipo VARCHAR(200) DEFAULT '';
	DECLARE cur CURSOR FOR SELECT t.numero_column, CONCAT('tn.n',t.numero_column) name_column, 
		t.tipo,
		ROW_NUMBER() OVER (PARTITION BY tipo ORDER BY t.id_competencia, t.tipo, t.numero_column) AS row_num
		FROM columnas_notas_competencias t
		LEFT JOIN competencias AS tc ON t.id_competencia = tc.id_pk
		LEFT JOIN grados_agrupados AS t1 ON tc.id_grado_agrupado = t1.id
		LEFT JOIN aux_grados_agrupados AS t2 ON t2.id_grado_agrupado = t1.id
		WHERE tc.`año` = `_año` AND t2.id_grado = _id_grado
		ORDER BY t.id_competencia, t.tipo, t.numero_column;		
		DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done = 1;
	OPEN cur;
	REPEAT
		FETCH cur INTO _num, _name, _tipo, _row;
		IF NOT done THEN			
			CASE _tipo 
				WHEN 'PROM' THEN 
					SET _result = CONCAT(_result,_name,' AS ',LOWER(_tipo),_row,',');	
				WHEN 'PORC' THEN 
					SET _result = CONCAT(_result,_name,' AS ',LOWER(_tipo),_row,',');
				ELSE
					SET _result = CONCAT(_result,_name,',');		
			END CASE;
		END IF;
	UNTIL done END REPEAT;
	CLOSE cur;
	SELECT LEFT(_result,LENGTH(_result)-1) AS filas;
END$$

DROP PROCEDURE IF EXISTS `sp_ih_select`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_ih_select` (IN `_cod_grado` VARCHAR(2) CHARSET utf8, IN `_cod_dane` VARCHAR(14) CHARSET utf8, IN `_año` YEAR, IN `_cod_asig` INT(2))  BEGIN
	select ih from matcurso where cod_grado=_cod_grado and cod_dane=_cod_dane and año=_año and cod_asig=_cod_asig;
END$$

DROP PROCEDURE IF EXISTS `sp_insert_conv_situaciones_est_reincidencia`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_insert_conv_situaciones_est_reincidencia` (IN `_id_matric` INT(20))  BEGIN
	 DECLARE  done,
 			 _count,
			 _count_s,
			 _id_inst,
			 _id_situacion,
			 _x_reincidencia,
			 _año INT DEFAULT 0;

SELECT id_inst, año INTO _id_inst, _año FROM matriculas tm WHERE  tm.id_matric = _id_matric; 

SELECT c.conv_reincidencia INTO _x_reincidencia  FROM config001 c WHERE c.id_inst = _id_inst AND c.AÑO = _año;

SELECT MOD(COUNT(t1.id_matric),_x_reincidencia) INTO _count  FROM conv_reg_situaciones_est t1, 
conv_situaciones t2 WHERE t1.id_situacion = t2.id AND t2.id_tipo = 1 
GROUP BY t1.id_matric, t2.id_tipo HAVING t1.id_matric = _id_matric;

 IF _count = 0 THEN 
 	SELECT count(t1.id) INTO _count_s FROM conv_situaciones t1 
	 WHERE t1.add_auto = 1 AND t1.id_inst = _id_inst;
	
	IF _count_s THEN 
		SELECT  t1.id  FROM conv_situaciones t1 
	 	WHERE t1.add_auto = 1 AND t1.id_inst = _id_inst;
	ELSE
		SELECT t1.id  FROM conv_situaciones t1 
	 	WHERE t1.id_tipo = 2 AND t1.id_inst = _id_inst LIMIT 1;
	 			
	END IF;
 ELSE
 	SELECT 0 as id;		
 END IF;
END$$

DROP PROCEDURE IF EXISTS `sp_insert_evaluacion_compartida`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_insert_evaluacion_compartida` (IN `_id_eval` INT(30), IN `_id_curso` INT(30))  BEGIN
DECLARE _grado,_grupo VARCHAR (2);
DECLARE _jorn,_año,_sede,_inst, _id_matric INT (30) DEFAULT 0;
DECLARE done INT DEFAULT 0;
DECLARE cur CURSOR FOR SELECT tm.id_matric FROM matriculas tm WHERE tm.cod_grado = _grado AND 
	tm.grupo = _grupo AND tm.año = _año  AND tm.id_jorn = _jorn AND tm.id_sede = _sede AND tm.id_inst=_inst AND tm.estado=2;
DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done = 1;
	SELECT cod_grado,grupo,cod_jorn,año,id_sede,id_inst INTO _grado,_grupo,_jorn,_año,_sede,_inst 
	FROM cursos 
		WHERE id = _id_curso AND estado=1;
	OPEN cur;
	REPEAT 
		FETCH cur INTO _id_matric;
		IF NOT done THEN
			INSERT INTO te_evaluacion_compartida (id_evaluacion,id_matric) 
			VALUES (_id_eval,_id_matric);
		END IF;
	UNTIL done END REPEAT;
	CLOSE cur;
END$$

DROP PROCEDURE IF EXISTS `sp_insert_material_educ_comp`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_insert_material_educ_comp` (IN `_id_material` INT(30), IN `_id_curso` INT(30))  BEGIN
	DECLARE _grado,_grupo VARCHAR (2);
DECLARE _jorn,_año,_sede,_inst, _id_matric INT (30) DEFAULT 0;
DECLARE done INT DEFAULT 0;
DECLARE cur CURSOR FOR SELECT tm.id_matric FROM matriculas tm WHERE tm.cod_grado = _grado AND 
	tm.grupo = _grupo AND tm.año = _año  AND tm.id_jorn = _jorn AND tm.id_sede = _sede AND tm.id_inst=_inst AND tm.estado=2;
DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done = 1;
	SELECT cod_grado,grupo,cod_jorn,año,id_sede,id_inst INTO _grado,_grupo,_jorn,_año,_sede,_inst 
	FROM cursos 
		WHERE id = _id_curso AND estado=1;
	OPEN cur;
	REPEAT 
		FETCH cur INTO _id_matric;
		IF NOT done THEN
			INSERT INTO material_educ_compartido (id_material,id_matric) 
			VALUES (_id_material,_id_matric);
		END IF;
	UNTIL done END REPEAT;
	CLOSE cur;
END$$

DROP PROCEDURE IF EXISTS `sp_insert_observador`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_insert_observador` (IN `_cod_grado` VARCHAR(2) CHARSET utf8, IN `_grupo` VARCHAR(2) CHARSET utf8, IN `_cod_jorn` INT(1), IN `_id_sede` INT(20), IN `_cod_est` INT(20), IN `_año` YEAR, IN `_fecha` DATE, IN `_id_inst` INT(20))  BEGIN
	INSERT INTO obs_observador_mod2 (cod_grado,grupo,cod_jorn,id_sede,cod_est, año, fecha,id_inst) VALUES 
			(_cod_grado,_grupo,_cod_jorn,_id_sede,_cod_est,_año,_fecha,_id_inst);
            
	SELECT last_insert_id() AS id;
END$$

DROP PROCEDURE IF EXISTS `sp_insert_observador_items`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_insert_observador_items` (IN `_consecutivo` INT(11), IN `_id_observador` INT(20), IN `_id_docente` INT(20), IN `_cod_est` INT(20), IN `_cod_grado` VARCHAR(2) CHARSET utf8, IN `_grupo` VARCHAR(2) CHARSET utf8, IN `_cod_jorn` INT(1), IN `_id_inst` INT(20), IN `_id_sede` INT(20), IN `_observaciones` TEXT, IN `_compromisos` TEXT, IN `_tratamientos` TEXT, IN `_resultado` TEXT, IN `_fecha` DATE, IN `_estado` TINYINT(1), IN `_año` YEAR)  BEGIN
 insert into obs_items_modelo_obs2 (
	consecutivo,
    id_observador,
    id_docente,
    cod_est,
    cod_grado,
    grupo,
	cod_jorn,
    id_inst,
    id_sede,
    observaciones,
    compromisos,
    tratamientos,
    resultado,
    fecha,
    estado,
    año) values (
    _consecutivo,
    _id_observador,
    _id_docente,
    _cod_est,
    _cod_grado,
    _grupo,
	_cod_jorn,
    _id_inst,
    _id_sede,
    _observaciones,
    _compromisos,
    _tratamientos,
    _resultado,
    _fecha,
    _estado,
    _año
    );
END$$

DROP PROCEDURE IF EXISTS `sp_insert_respeciales`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_insert_respeciales` (IN `_id_matric` INT(30), IN `_x_nro_act` INT, IN `_id_curso` INT(30), IN `_final` DECIMAL(6,2))  BEGIN
	DECLARE _count INT DEFAULT 0;
	SELECT tr.id INTO _count FROM respeciales AS tr WHERE tr.id_curso = _id_curso AND tr.id_matric = _id_matric;
	IF NOT _count THEN
		INSERT INTO respeciales (id_matric,nro_acta,id_curso,notafinal) 
		VALUES (_id_matric,_x_nro_act,_id_curso,_final);
	ELSE
		UPDATE respeciales SET notafinal = _final WHERE id_matric = _id_matric AND id_curso = _id_curso; 
	END IF;
END$$

DROP PROCEDURE IF EXISTS `sp_kill_sleeping_connections`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_kill_sleeping_connections` ()  READS SQL DATA
    COMMENT 'Secuencia de comandos para matar las conexiones dormidas'
BEGIN
	DECLARE end_rows INT DEFAULT 0;
	DECLARE no_loops INT DEFAULT 0;
	DECLARE rownum INT DEFAULT 0;
	
	DECLARE ucur CURSOR FOR
	SELECT ID FROM information_schema.PROCESSLIST PL
	WHERE PL.COMMAND='Sleep' AND PL.TIME > 59;
	
	DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET end_rows = 1;
	
	OPEN ucur;
	REPEAT
		FETCH ucur INTO rownum;
		IF NOT end_rows THEN 
		 	IF rownum > 0 THEN 
			 	KILL rownum;			 
		 	END IF;
		END IF;
	UNTIL end_rows END REPEAT;
END$$

DROP PROCEDURE IF EXISTS `sp_libro_final_areas`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_libro_final_areas` (IN `_id_matric` INT(30), IN `_año` YEAR, IN `_id_inst` INT(20))  BEGIN
	DECLARE _grupo VARCHAR(2) DEFAULT '';
	DECLARE _n_mat,_id_jorn, _id_sede, _cod_area, _id_asig, _faltas, _injust, _retraso, n_año INT DEFAULT 0;
	DECLARE _final,_recuperacion DECIMAL(6,2) DEFAULT 0;
	DECLARE done, _estado INT DEFAULT 0;
	DECLARE _des,_desempeño,_msg,_msg1,_msg2,_msg3,_msg4	VARCHAR(250) DEFAULT '';
	DECLARE  _pierde_rec,
				_gana_rec,
				_areas_perdidas, 
				_areas_ganadas,
				_areas_pierde,
				_pierde_luego_rec,
				_rec_especial,
				_total_areas_recuperas,
				_areas_enrecuperacion,
				_recuperaciones_total,
				_n_decimales,
				_cont_porcentaje,
				_cont_areas,
				_total_areas_recuperadas,
				_baj, _sup,
				_promocion_a_lectivo, /*Promoción de los estudiantes, 1 = promedios, 2 = promedios - desempeño alto, 3= quinta nota
												4 = Cuarto periodo, 5 = Desempeños - Logros*/
				_pierde_año_lectivo_area, /*Al finalizar el año escolar, no será promovido el estudiante que pierda las siguientes áreas*/
				_area_next,
				_aplicar_redondeo_fin_año,
				_cod_grado,
				_cod_grado_prom,
				_curso INT DEFAULT 0;
	DECLARE  _nota_real_recuperada,
		     	_nota_real,
		     	_suma,
		     	_prom,
				_desde,
				_hasta,
				_nota_recuperacion,
				_porcentaje,
				_final_suma,
				_nota_max_rec,
				_nota_redondeo,
				_nota_final_redondeo,
				_porciento_ausencia, /*Porcentaje de inasistencia injustificada para perder un área.*/
				_prom_areas_sup, /*Si el estudiante pierde UN ÁREA y el PROMEDIO de esta es igual o superior a este valor es promovido sin hacer recuperación*/
				_w_sup DECIMAL(6,2) DEFAULT 0;
	DECLARE cur_areasf2 CURSOR FOR SELECT ta.id_matric,tm.id_sede,tm.id_grado,tm.grupo,tm.id_jorn,tm.año, 
		tas.id_area,tas.id_pk,ta.final,ta.recuperacion,
		ta.faltas,ta.injustificadas,ta.retraso,ta.id_curso,tmc.porciento
		FROM areasf AS ta 
		LEFT JOIN cursos AS tc ON ta.id_curso = tc.id
		LEFT JOIN matriculas AS tm ON ta.id_matric=tm.id_matric	
		LEFT JOIN asignaturas AS tas ON tc.id_asig=tas.id_pk  
		LEFT JOIN inscripciones AS te ON tm.cod_est=te.cod_est 
		LEFT JOIN matcurso AS tmc ON (tmc.id_asig = tas.id_pk AND tmc.id_grado = tc.id_grado 
		AND tmc.`año` = tc.`año`)
		WHERE tm.id_inst=_id_inst AND tm.año=_año AND tc.año=_año 
		AND tas.id_inst=_id_inst AND tas.id_area = _area_next 
      AND tm.id_matric = _id_matric 
		AND tas.excluir = 0 ORDER BY tas.id_area,tas.id_pk;
   /* Cursor que contiene solo el codigo de las areas */
   DECLARE cur_areasf CURSOR FOR SELECT SQL_SMALL_RESULT tas.id_area FROM areasf AS ta 
   	LEFT JOIN cursos AS tc ON ta.id_curso = tc.id
		LEFT JOIN  matriculas AS tm ON ta.id_matric=tm.id_matric	
		LEFT JOIN asignaturas AS tas ON tc.id_asig=tas.id_pk  
		LEFT JOIN inscripciones AS te ON tm.cod_est=te.cod_est 
		WHERE tm.id_inst=_id_inst AND tm.año=_año AND tc.año=_año 
		AND tas.id_inst=_id_inst  AND tm.id_matric = _id_matric 
		GROUP BY ta.id_matric,tas.id_area,tm.`año` 
		ORDER BY tas.id_area,tas.id_pk;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done = 1;	
	SELECT id_grado INTO _cod_grado_prom FROM matriculas WHERE id_matric = _id_matric;
	SELECT areas_pierde,pierde_luego_rec,ndecimales,nota_max_rec,porciento_ausencia,prom_areas,promocion,
	pierde_año_lectivo_area,nota_redondeo,nota_final_redondeo,aplicar_redondeo_fin_año INTO 
	_areas_pierde,_pierde_luego_rec,_n_decimales,_nota_max_rec,_porciento_ausencia,_prom_areas_sup,
	_promocion_a_lectivo,_pierde_año_lectivo_area,_nota_redondeo,_nota_final_redondeo,_aplicar_redondeo_fin_año
	FROM config001 AS t 
	LEFT JOIN grados_agrupados AS t1 ON t.id_grupo_grados = t1.id
	LEFT JOIN aux_grados_agrupados AS t2 ON t2.id_grado_agrupado = t1.id
	WHERE t.año = `_año` AND t.id_inst = _id_inst AND t2.id_grado = _cod_grado_prom;
		
	SELECT t.desde, t.hasta INTO _desde, _hasta 
	FROM `desempeños` AS t 
	LEFT JOIN grados_agrupados AS t1 ON t.id_grado_agrupado = t1.id
	LEFT JOIN aux_grados_agrupados AS t2 ON t2.id_grado_agrupado = t1.id
	WHERE	t.reprueba =1 AND t.id_inst=_id_inst AND t.año=`_año` 
	AND t2.id_grado = _cod_grado_prom;	
	SET _w_sup = _hasta;
	
	SELECT fn_recuperacion_total_asignaturas(_id_matric) INTO _recuperaciones_total;
	SELECT fn_recuperacion_total_areas(_id_matric) INTO _areas_enrecuperacion;
	
	/*
	 Si el usuario especifica una nota máxima para las actividades de apoyo, se establece.
	*/
	IF _nota_max_rec > 0 THEN 
		SET _desde = _nota_max_rec;
	END IF;	
	OPEN cur_areasf;
	REPEAT 	
		FETCH cur_areasf INTO _area_next;					
		IF NOT done THEN		
			SET _nota_real	= 0;
			SET _nota_real_recuperada = 0;
			SET _final_suma = 0;
			SET _cont_porcentaje = 0;
			OPEN cur_areasf2;			
			REPEAT 			
				FETCH cur_areasf2 INTO _n_mat,_id_sede,_cod_grado,_grupo,_id_jorn,n_año,_cod_area,_id_asig,
					_final,_recuperacion,_faltas,_injust,_retraso,_curso, _porcentaje;					
				IF NOT done THEN 
					/*
					  Nota de las actividades de apoyo en la asignatura, 
					  si ha realizado actividades devuelve la nota, si no, devuelve 0.
					*/
					SELECT fn_recuperacion_notas(_id_matric, _curso) INTO _nota_recuperacion;					
					SET done = 0;
					/*
					 Suma de las notas
					*/
					SET _nota_real = _nota_real + ROUND((_final*_porcentaje)/100,_n_decimales);
					SET _nota_real_recuperada = _nota_real_recuperada + ROUND((_nota_recuperacion*_porcentaje)/100,_n_decimales);				
					
					IF _nota_recuperacion > _final THEN 
						SET _final_suma = _final_suma + ROUND((_nota_recuperacion*_porcentaje)/100,_n_decimales);
					ELSE
						SET _final_suma = _final_suma + ROUND((_final*_porcentaje)/100,_n_decimales);
					END IF;					
					/*
					 Se determina el grado porcentual de la asignatura.
					*/
					IF _porcentaje = 0 OR _porcentaje = 100 THEN
						SET _cont_porcentaje = _cont_porcentaje + 1;
					ELSE
						SET _cont_porcentaje = 0;
					END IF;					
					/*
					 Se determina si el estudiante hizo actividades de apoyo de fin de año.
					*/					
					IF _nota_recuperacion > 0 THEN 
						SET _rec_especial = _rec_especial + 1;
						IF (_nota_recuperacion > _final) AND (_nota_recuperacion > _hasta) THEN 
							SET _gana_rec = _gana_rec + 1;
						ELSE
							SET _pierde_rec = _pierde_rec + 1;
						END IF;
					END IF;					
				END IF;
			UNTIL done END REPEAT;
			CLOSE cur_areasf2;			
			IF _cont_porcentaje > 0 THEN 
				SET _prom	= ROUND((_final_suma/_cont_porcentaje),_n_decimales);
			ELSE
				SET _prom	= ROUND(_final_suma,_n_decimales);
			END IF;			
			SET _cont_areas = _cont_areas + 1;
			SET _suma = _suma + _prom;			
			IF _cont_porcentaje > 0 THEN 
				SET _nota_real_recuperada	= ROUND((_nota_real_recuperada/_cont_porcentaje),_n_decimales);
				SET _nota_real	= ROUND((_nota_real/_cont_porcentaje),_n_decimales);
			ELSE
				SET _nota_real_recuperada	= ROUND(_nota_real_recuperada,_n_decimales);
				SET _nota_real	= ROUND(_nota_real,_n_decimales);
			END IF;			
			/*
			 Se determina cuantas areas han estado en actividades de apoyo.
			*/
			IF _nota_real_recuperada > _w_sup THEN
				SET _total_areas_recuperadas = _total_areas_recuperadas + 1;
			END IF;			
			/*
			 Se determina y aplica el redondeo del área.
			*/
			IF _nota_redondeo > 0 AND _aplicar_redondeo_fin_año > 0 THEN 
				IF _prom BETWEEN _nota_redondeo AND _nota_final_redondeo THEN 
					SET _prom = _nota_final_redondeo;
				END IF;
				IF _nota_real BETWEEN _nota_redondeo AND _nota_final_redondeo THEN 
					SET _nota_real = _nota_final_redondeo;
				END IF;
			END IF;
			/*
			 Se determina la cantidad de áreas perdidas y ganadas.
			*/
			IF _nota_real <= _w_sup THEN
				SET _areas_perdidas = _areas_perdidas + 1;
			ELSE 
				SET _areas_ganadas = _areas_ganadas + 1;
			END IF;			
			IF _prom <= _w_sup THEN
				SET _baj	= _baj + 1;
			ELSE 
				SET _sup	= _sup + 1;
			END IF;					
			SET done = 0;
		END IF;
	UNTIL done END REPEAT;
	CLOSE cur_areasf;	
	IF _recuperaciones_total > _rec_especial THEN
		SET _rec_especial = 0;
	END IF;	
	IF _rec_especial > 0 THEN
		CASE  _pierde_luego_rec 
			WHEN  1 THEN /*En caso de que el estudiante pierda una de las recuperaciones */
				IF _pierde_rec > 0 THEN  /*Si pierde una de las recuperaciones finales o especiales*/
					/* No promovido*/
					SET _estado = 3;
				ELSE /*Si no pierde las recuperaciones finales o especiales*/
					/*Promovido*/
					SET _estado = 1;
				END IF; 
			WHEN 2 THEN /*En caso de que el estudiante pierda todas las recuperaciones*/
				CASE  _areas_pierde
					WHEN  3 THEN /*En caso que pierdan estudiantes con tres o más áreas*/
						IF _pierde_rec = _rec_especial THEN /* Si pierde todas las recuperaciones finales o especiales*/
							/*NO promovido*/
							SET _estado = 3;
						ELSE
							IF _gana_rec  =_rec_especial THEN /* Si gana todas las recuperaciones finales o especiales*/
								/*Promovido*/
								SET _estado = 1;
							ELSE 
								/*Promovido con dificultad*/
								SET _estado = 2;
							END IF;
						END IF;
					WHEN  2 THEN /*En caso que pierdan estudiantes con 2 o más áreas*/
						IF _pierde_rec = _rec_especial THEN /*Si pierde todas las recuperaciones finales o especiales*/
							/*No promovido*/
							SET _estado = 3;
						ELSE
							IF _gana_rec = _rec_especial THEN /*Si gana todas las recuperaciones finales o especiales*/
								/*Promovido*/
								SET _estado = 1;
							ELSE 
								/*Promovido con dificultad*/
								SET _estado = 2;
							END IF;
						END IF;
				ELSE  
					SET _des = "ERROR EN EL SISTEMA, REPORTELO.";
				END CASE; 
		ELSE 		
			IF _gana_rec = _rec_especial THEN /*Si gana todas las recuperaciones finales o especiales*/
					/*Promovido*/
					SET _estado = 1; 
			ELSE 
				IF _total_areas_recuperas = _areas_enrecuperacion THEN
					/*Promovido*/
					SET _estado = 1;
				ELSE
					/*No promovido*/
					SET _estado = 3;
				END IF; 
			END IF;
		END CASE; 
	ELSE
		IF  _baj < _areas_pierde THEN 
	 		IF _baj = 0 THEN
	 			/*Promovido*/
				SET _estado = 1;			 			
	 		ELSE 
	 			/*Promovido con dificultad*/
				SET _estado = 2;
	 		END IF;
		 ELSE 
			 /*No promovido*/
			SET _estado = 3;
		 END IF; 
	END IF;	
	IF _suma > 0 THEN 
		SET _prom = ROUND(_suma/_cont_areas,_n_decimales);
	END IF;
	SELECT `estado_estudiante_normal`(_estado,_cod_grado_prom, _id_inst) INTO _des;
	SELECT `fn_Getdesempeño`(_id_inst, _año, _prom,_cod_grado_prom) INTO `_desempeño`;
	SET _msg	 = CONCAT("ÁREAS PERDIDAS: ",_areas_perdidas," - ÁREAS GANADAS: ",_areas_ganadas," - TOTAL ÁREAS: ",_cont_areas);
	SET _msg1 = CONCAT("PONDERADO GENERAL POR ÁREAS: ",_prom," - DESEMPEÑO: ",_desempeño);
	SET _msg2 = _des;	
	UPDATE acta_promocion 
	SET msg = _msg2, msg1= _msg, msg2 = _msg1, estado=_estado, areas_p = _areas_perdidas, areas_g = _areas_ganadas
	WHERE id_matric = _id_matric;	
END$$

DROP PROCEDURE IF EXISTS `sp_libro_final_asignaturas`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_libro_final_asignaturas` (IN `_id_matric` INT(30), IN `_año` YEAR, IN `_id_inst` INT(20))  BEGIN
	DECLARE  _grupo  VARCHAR(2) DEFAULT '';
	DECLARE _n_mat,_id_jorn, _id_sede, _cod_area, _id_asig, 
	_faltas, _injust, _retraso, n_año,
	_cod_grado, _cod_grado_prom,_curso INT(30) DEFAULT 0;
	DECLARE _final,_recuperacion DECIMAL(6,2) DEFAULT 0;
	DECLARE done, _estado INT DEFAULT 0;
	DECLARE _des,_desempeño,_msg,_msg1,_msg2,_msg3,_msg4	VARCHAR(250) DEFAULT '';
	DECLARE  _pierde_rec,
				_gana_rec,
				_areas_perdidas, 
				_areas_ganadas,
				_areas_pierde,
				_pierde_luego_rec,
				_rec_especial,
				_total_areas_recuperas,
				_areas_enrecuperacion,
				_recuperaciones_total,
				_n_decimales,
				_cont_porcentaje,
				_cont_areas,
				_total_areas_recuperadas,
				_baj, _sup,
				_area_next INT DEFAULT 0;
	DECLARE  _nota_real_recuperada,
		     	_nota_real,
		     	_suma,
		     	_prom,
				_desde,
				_hasta,
				_nota_recuperacion,
				_porcentaje,
				_final_suma,
				_nota_max_rec,
				_w_sup DECIMAL(6,2) DEFAULT 0;
	DECLARE cur_areasf CURSOR FOR SELECT ta.id_matric,tm.id_sede,tm.id_grado,tm.grupo,tm.id_jorn,tm.año, 
		tas.id_area,tc.id_asig,ta.final,ta.recuperacion,
		ta.faltas,ta.injustificadas,ta.retraso,ta.id_curso, tmc.porciento
		FROM areasf AS ta 
		LEFT JOIN cursos AS tc ON ta.id_curso = tc.id
		LEFT JOIN  matriculas AS tm ON ta.id_matric=tm.id_matric	
		LEFT JOIN asignaturas AS tas ON tc.id_asig=tas.id_pk  
		LEFT JOIN inscripciones AS te ON tm.cod_est=te.cod_est 
		LEFT JOIN matcurso AS tmc ON (tmc.id_asig = tas.id_pk AND tmc.id_grado = tc.id_grado) 
		WHERE tm.id_inst=_id_inst AND tm.año=_año AND tc.año=_año AND tc.id_grado = _cod_grado_prom
		AND tas.id_inst=_id_inst AND tm.id_matric = _id_matric 
		AND tmc.id_grado = _cod_grado_prom AND tmc.`año` = `_año`
		AND tas.excluir = 0 ORDER BY tas.id_pk;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done = 1;	
	SELECT id_grado INTO _cod_grado_prom FROM matriculas WHERE id_matric = _id_matric;
	SELECT areas_pierde,pierde_luego_rec,ndecimales,nota_max_rec INTO 
	_areas_pierde,_pierde_luego_rec,_n_decimales,_nota_max_rec
	FROM config001 AS t
	LEFT JOIN grados_agrupados AS t1 ON t.id_grupo_grados = t1.id
	LEFT JOIN aux_grados_agrupados AS t2 ON t2.id_grado_agrupado = t1.id
	WHERE t.año = `_año` AND t.id_inst = _id_inst AND t2.id_grado = _cod_grado_prom LIMIT 1;	
	SELECT t.desde, t.hasta INTO _desde, _hasta 
	FROM `desempeños` AS t
	LEFT JOIN grados_agrupados AS t1 ON t.id_grado_agrupado = t1.id
	LEFT JOIN aux_grados_agrupados AS t2 ON t2.id_grado_agrupado = t1.id
	WHERE	t.reprueba = 1 AND t.id_inst=_id_inst AND t.año=`_año` 
	AND t2.id_grado = _cod_grado_prom LIMIT 1;	
	SET _w_sup = _hasta; 
	SELECT fn_recuperacion_total_asignaturas(_id_matric) INTO _recuperaciones_total;
	SELECT fn_recuperacion_total_areas(_id_matric) INTO _areas_enrecuperacion;
	
	/*
	 Si el usuario especifica una nota máxima para las actividades de apoyo, se establece.
	*/
	IF _nota_max_rec > 0 THEN 
		SET _desde = _nota_max_rec;
	END IF;
	
	OPEN cur_areasf;
	REPEAT 	
		FETCH cur_areasf INTO _n_mat,_id_sede,_cod_grado,_grupo,_id_jorn,n_año,_cod_area,_id_asig,
					_final,_recuperacion,_faltas,_injust,_retraso,_curso,_porcentaje;						
		IF NOT done THEN		
			SET _nota_real	= 0;
			SET _nota_real_recuperada = 0;
			SET _final_suma = 0;
			SET _cont_porcentaje = 0;	
			/*
			  Nota de las actividades de apoyo en la asignatura, 
			  si ha realizado actividades devuelve la nota, si no, devuelve 0.
			*/
			SELECT fn_recuperacion_notas(_id_matric, _curso) INTO _nota_recuperacion;			
			SET done = 0;
			/*
			 Suma de las notas
			*/
			SET _nota_real = _nota_real + _final ;
			SET _nota_real_recuperada = _nota_real_recuperada +  _nota_recuperacion;			
			IF _nota_recuperacion > _final THEN 
				SET _final_suma = _final_suma + _nota_recuperacion;
			ELSE
				SET _final_suma = _final_suma + _final;
			END IF;					
			/*
			 Se determina si el estudiante hizo actividades de apoyo de fin de año.
			*/			
			IF _nota_recuperacion > 0 THEN 
				SET _rec_especial = _rec_especial + 1;
				IF (_nota_recuperacion > _final) AND (_nota_recuperacion > _hasta) THEN 
					SET _gana_rec = _gana_rec + 1;
				ELSE
					SET _pierde_rec = _pierde_rec + 1;
				END IF;
			END IF;
		
			SET _prom	= _final_suma;
			
			SET _cont_areas = _cont_areas + 1;
			SET _suma = _suma + _prom;					
			/*
			 Se determina cuantas areas han estado en actividades de apoyo.
			*/
			IF _nota_real_recuperada > _w_sup THEN
				SET _total_areas_recuperadas = _total_areas_recuperadas + 1;
			END IF;			
			/*
			 Se determina la cantidad de áreas perdidas y ganadas.
			*/
			IF _nota_real <=_w_sup THEN
				SET _areas_perdidas = _areas_perdidas + 1;
			ELSE 
				SET _areas_ganadas = _areas_ganadas + 1;
			END IF;			
			IF _prom <= _w_sup THEN
				SET _baj	= _baj + 1;
			ELSE 
				SET _sup	= _sup + 1;
			END IF;
		END IF;
	UNTIL done END REPEAT;
	CLOSE cur_areasf;	
	IF _recuperaciones_total > _rec_especial THEN
		SET _rec_especial = 0;
	END IF;	
	IF _rec_especial > 0 THEN
		CASE  _pierde_luego_rec 
			WHEN  1 THEN /*En caso de que el estudiante pierda una de las recuperaciones */
				IF _pierde_rec > 0 THEN  /*Si pierde una de las recuperaciones finales o especiales*/
					/* No promovido*/
					SET _estado = 3;
				ELSE /*Si no pierde las recuperaciones finales o especiales*/
						/*Promovido*/
						SET _estado = 1;
				END IF; 
			WHEN 2 THEN /*En caso de que el estudiante pierda todas las recuperaciones*/
				CASE  _areas_pierde
					WHEN  3 THEN /*En caso que pierdan estudiantes con tres o más áreas*/
						IF _pierde_rec = _rec_especial THEN /* Si pierde todas las recuperaciones finales o especiales*/
							/*NO promovido*/
							SET _estado = 3;
						ELSE
							IF _gana_rec  =_rec_especial THEN /* Si gana todas las recuperaciones finales o especiales*/
								/*Promovido*/
								SET _estado = 1;
							ELSE 
								/*Promovido con dificultad*/
								SET _estado = 2;
							END IF;
						END IF;
					WHEN  2 THEN /*En caso que pierdan estudiantes con 2 o más áreas*/
						IF _pierde_rec = _rec_especial THEN /*Si pierde todas las recuperaciones finales o especiales*/
							/*No promovido*/
							SET _estado = 3;
						ELSE
							IF _gana_rec = _rec_especial THEN /*Si gana todas las recuperaciones finales o especiales*/
								/*Promovido*/
								SET _estado = 1; 
							ELSE 
								/*Promovido con dificultad*/
								SET _estado = 2;
							END IF;
						END IF;
				ELSE  
					SET _des = "ERROR EN EL SISTEMA, REPORTELO.";
				END CASE; 
		ELSE 		
			IF _gana_rec = _rec_especial THEN /*Si gana todas las recuperaciones finales o especiales*/
				/*Promovido*/
				SET _estado = 1;
			ELSE 
				IF _total_areas_recuperas = _areas_enrecuperacion THEN
					/*Promovido*/
					SET _estado = 1;
				ELSE
					/*No promovido*/
					SET _estado = 3;
				END IF; 
			END IF;
		END CASE; 
	ELSE
		IF  _baj < _areas_pierde THEN 
	 		IF _baj = 0 THEN
	 			/*Promovido*/
				SET _estado = 1;			 			
	 		ELSE 
	 			/*Promovido con dificultad*/
				SET _estado = 2;
	 		END IF;
		 ELSE 
			/*No promovido*/
			SET _estado = 3;
		 END IF; 
	END IF;	
	IF _suma > 0 THEN
		SET _prom = ROUND(_suma/_cont_areas,_n_decimales);
	END IF;
	SELECT estado_estudiante_normal(_estado, _cod_grado_prom, _id_inst) INTO _des;
	SELECT `fn_Getdesempeño`(_id_inst, _año, _prom,_cod_grado_prom) INTO `_desempeño`;
	SET _msg	 = CONCAT("ÁREAS PERDIDAS: ",_areas_perdidas," - ÁREAS GANADAS: ",_areas_ganadas," - TOTAL ÁREAS: ",_cont_areas);
	SET _msg1 = CONCAT("PONDERADO GENERAL POR ÁREAS: ",_prom," - DESEMPEÑO: ",_desempeño);
	SET _msg2 = _des;	
	UPDATE acta_promocion 
	SET msg = _msg2, msg1= _msg, msg2 = _msg1, estado=_estado, areas_p = _areas_perdidas, areas_g = _areas_ganadas
	WHERE id_matric = _id_matric;	
END$$

DROP PROCEDURE IF EXISTS `sp_organice_ciud`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_organice_ciud` ()  BEGIN
	DECLARE result, _id INT DEFAULT 0;
  	DECLARE done INT DEFAULT 0;
  	DECLARE _dpto VARCHAR (11);
 	DECLARE cur_especiales CURSOR FOR SELECT t.id, t.dpto FROM departamentos t; 
 	DECLARE CONTINUE HANDLER FOR SQLSTATE	 '02000' SET done	= 1; 
 OPEN cur_especiales; 
 REPEAT 
 	FETCH cur_especiales INTO _id, _dpto;
 	IF NOT done THEN
 		UPDATE ciudades t SET t.dpto = _id WHERE t.dpto = _dpto; 
 	END IF;
 UNTIL done END REPEAT; 
 CLOSE cur_especiales;
END$$

DROP PROCEDURE IF EXISTS `sp_organice_dpto`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_organice_dpto` ()  BEGIN
	DECLARE result, _id INT DEFAULT 0;
  	DECLARE done INT DEFAULT 0;
  	DECLARE _dpto, _ciud VARCHAR (11);
 	DECLARE cur_especiales CURSOR FOR SELECT t.id, t.dpto FROM departamentos t; 
 	DECLARE CONTINUE HANDLER FOR SQLSTATE	 '02000' SET done	= 1; 
 OPEN cur_especiales; 
 REPEAT 
 	FETCH cur_especiales INTO _id, _dpto;
 	IF NOT done THEN
 		UPDATE inscripciones t SET t.dpto_lug_pobl = _id WHERE t.dpto_lug_pobl = _dpto; 
 		UPDATE inscripciones t SET t.dpto_lug_nac = _id WHERE t.dpto_lug_nac = _dpto; 
 		UPDATE inscripciones t SET t.dpto_lug_res = _id WHERE t.dpto_lug_res = _dpto;
 		UPDATE inscripciones t SET t.dpto_lug_exp = _id WHERE t.dpto_lug_exp = _dpto;
 		
 		UPDATE docentes t SET t.dpto_exp = _id WHERE t.dpto_exp = _dpto;
 		UPDATE docentes t SET t.dpto_nac = _id WHERE t.dpto_nac = _dpto;
 		
 		UPDATE administrativos t SET t.dep_lug_nac = _id WHERE t.dep_lug_nac = _dpto;
 		UPDATE administrativos t SET t.dep_lug_exp = _id WHERE t.dep_lug_exp = _dpto;
 		
 		UPDATE familiares t SET t.dpto_Lug_exp = _id WHERE t.dpto_Lug_exp = _dpto;
 		UPDATE familiares t SET t.dpto_Lug_resid = _id WHERE t.dpto_Lug_resid = _dpto;
 		SET done = 0;
 	END IF;
 UNTIL done END REPEAT; 
 CLOSE cur_especiales;
END$$

DROP PROCEDURE IF EXISTS `sp_organice_dpto_ciud`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_organice_dpto_ciud` ()  BEGIN
	DECLARE result, _id INT DEFAULT 0;
  	DECLARE done INT DEFAULT 0;
  	DECLARE _dpto, _ciud VARCHAR (11);
 	DECLARE cur_ciud CURSOR FOR SELECT t.id, t.mun, t.dpto FROM ciudades t;
 	DECLARE CONTINUE HANDLER FOR SQLSTATE	 '02000' SET done	= 1; 
 	
 OPEN cur_ciud; 
 REPEAT 
 	FETCH cur_ciud INTO _id, _ciud, _dpto;
 	IF NOT done THEN
 		UPDATE inscripciones t SET t.mun_lug_pobl = _id WHERE t.mun_lug_pobl = _ciud AND t.dpto_lug_pobl = _dpto; 
 		UPDATE inscripciones t SET t.mun_lug_nac = _id WHERE t.mun_lug_nac = _ciud AND t.dpto_lug_nac = _dpto; 
 		UPDATE inscripciones t SET t.mun_lug_res = _id WHERE t.mun_lug_res = _ciud AND t.dpto_lug_res = _dpto;
 		UPDATE inscripciones t SET t.mun_lug_exp = _id WHERE t.mun_lug_exp = _ciud AND t.dpto_lug_exp = _dpto;
 		
 		UPDATE docentes t SET t.mun_exp = _id WHERE t.mun_exp = _ciud AND t.dpto_exp = _dpto;
 		UPDATE docentes t SET t.mun_nac = _id WHERE t.mun_nac = _ciud AND t.dpto_nac = _dpto;
 		
 		UPDATE administrativos t SET t.mun_lug_nac = _id WHERE t.mun_lug_nac = _ciud AND t.dep_lug_nac = _dpto;
 		UPDATE administrativos t SET t.mun_lug_exp = _id WHERE t.mun_lug_exp = _ciud AND t.dep_lug_exp = _dpto;
 		
 		UPDATE familiares t SET t.mun_lug_exp = _id WHERE t.mun_lug_exp = _ciud AND t.dpto_Lug_exp = _dpto;
 		UPDATE familiares t SET t.mun_lug_resid = _id WHERE t.mun_lug_resid = _ciud AND t.dpto_Lug_resid = _dpto;
 		SET done = 0;
 	END IF;
 UNTIL done END REPEAT; 
 CLOSE cur_ciud;
END$$

DROP PROCEDURE IF EXISTS `sp_par_cont_tem`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_par_cont_tem` (IN `_id_parcelador` INT(20), IN `_type` INT(1))  BEGIN	
	SELECT tc.id, tc.id_parcelador, RTRIM(tc.descripcion) AS descripcion, rtrim(ti.descripcion) AS descripcion_item FROM 
    parcelador_con_tem AS tc LEFT JOIN parcelador_items_con_tem AS ti ON tc.tipo=ti.id   
	WHERE tc.id_parcelador=_id_parcelador AND tc.tipo=_type AND tc.estado=1;       
END$$

DROP PROCEDURE IF EXISTS `sp_periodos_promedio`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_periodos_promedio` (IN `_cod_grado` INT(11), IN `_grupo` VARCHAR(2), IN `_id_jorn` INT(2), IN `_id_inst` INT(20), IN `_año` YEAR, IN `_id_matric` INT(20), IN `_id_asig` INT(11), IN `_periodo` VARCHAR(2))  BEGIN
	DECLARE	done, _count INT DEFAULT 0;
	DECLARE	_suma,
				_prom,
				_nota DECIMAL(6,2) DEFAULT 0;	
	DECLARE _table VARCHAR(30) DEFAULT '';
	SELECT fn_return_table_notas(_cod_grado) INTO _table;
	SET @sqlQuery = CONCAT("SELECT ROUND(IF(tmc.porciento BETWEEN 1 AND 99,
			SUM(IF(tn.nota_habilitacion > 0,(tn.nota_habilitacion*tmc.porciento)/100,(tn.final*tmc.porciento)/100)),
			AVG(IF(tn.nota_habilitacion > 0, tn.nota_habilitacion, tn.final))),2) AS nota
			FROM  ",_table," AS tn 
			LEFT JOIN cursos AS tc ON (tn.id_curso=tc.id AND tn.año=tc.`año`)
			LEFT JOIN asignaturas AS tas ON tc.id_asig = tas.id_pk 
			LEFT JOIN matcurso AS tmc ON (tmc.id_asig = tas.id_pk AND tmc.id_grado = tc.id_grado)
			LEFT JOIN matriculas AS tm ON tn.id_matric = tm.id_matric 
			WHERE tn.periodo  BETWEEN 1 AND '",_periodo,"' AND tm.id_grado = ",_cod_grado," AND tm.grupo = '",_grupo,"' 
			AND tm.año = ",_año,"	AND tm.id_inst = ",_id_inst," AND tm.id_jorn = ",_id_jorn,"
			AND tm.id_matric = ",_id_matric," AND tc.`año` = ",_año," AND tc.id_asig = ",_id_asig,
			" AND tmc.id_inst = ",_id_inst," AND tmc.`año` = ",_año," AND tmc.id_grado = ",_cod_grado,
			" AND tas.id_inst = ",_id_inst,"	GROUP BY tn.id_matric, tc.id_asig;");
	PREPARE smtp FROM @sqlQuery;
	EXECUTE smtp;
	DEALLOCATE PREPARE smtp;
END$$

DROP PROCEDURE IF EXISTS `sp_periodos_select`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_periodos_select` (IN `_cod_grado` INT(11), IN `_grupo` VARCHAR(2), IN `_id_jorn` INT(1), IN `_id_inst` INT(20), IN `_año` YEAR, IN `_periodo` VARCHAR(2), IN `_id_matric` INT(30), IN `_id_asig` INT(11))  BEGIN 
	DECLARE cTable VARCHAR(30) DEFAULT '';
	SELECT fn_return_table_notas(_cod_grado) INTO  cTable;
	SET @sqlSelect = CONCAT("SELECT ROUND(AVG(IF(tn.nota_habilitacion > 0, tn.nota_habilitacion, final)),2) AS nota, 
		tn.periodo FROM ",cTable," AS tn 
		LEFT JOIN cursos AS tc ON (tn.id_curso = tc.id AND tn.`año` = tc.`año`)
      LEFT JOIN matriculas AS tm ON tn.id_matric = tm.id_matric 
		WHERE tn.id_matric = ",_id_matric," AND tn.periodo = '",_periodo,"' AND tc.id_grado = ",
		_cod_grado," AND tc.grupo = '",_grupo,"' AND tc.`año` = ",`_año`," AND tc.cod_jorn = ",
		_id_jorn," AND tc.id_asig =",_id_asig," AND tc.id_inst = ",_id_inst,"  AND tm.id_matric = ",
		_id_matric," LIMIT 1");
	PREPARE smtp FROM @sqlSelect;
	EXECUTE smtp;
	DEALLOCATE PREPARE smtp;
END$$

DROP PROCEDURE IF EXISTS `sp_prom_area`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_prom_area` (IN `_id_inst` INT(20), IN `_id_matric` INT(30), IN `_id_area` INT(11), IN `_periodo` VARCHAR(1), IN `_cod_grado` INT(11), IN `_año` YEAR)  BEGIN
	DECLARE _ndecim INT DEFAULT 0;
	DECLARE cTable	VARCHAR(30) DEFAULT '';
	SELECT tc.Ndecimales INTO _ndecim FROM config001 AS tc 
	LEFT JOIN grados_agrupados AS t1 ON tc.id_grupo_grados = t1.id
	LEFT JOIN aux_grados_agrupados AS t2 ON t2.id_grado_agrupado = t1.id
	WHERE tc.año = _año AND tc.id_inst = _id_inst AND t2.id_grado = _cod_grado LIMIT 1; 
	SELECT fn_return_table_notas(_cod_grado) INTO cTable;
SET @sqlSelect = CONCAT("SELECT tas.id_area, 
	ROUND(IF(tmc.porciento BETWEEN 1 AND 99,
	SUM(IF(tn.nota_habilitacion > 0,(tn.nota_habilitacion*tmc.porciento)/100,(tn.final*tmc.porciento)/100)),
	AVG(IF(tn.nota_habilitacion > 0, tn.nota_habilitacion, tn.final))),",_ndecim,") AS prom 
	FROM ",cTable," AS tn 
	LEFT JOIN cursos AS tc ON (tn.id_curso = tc.id AND tn.`año` = tc.`año`)
	LEFT JOIN asignaturas AS tas ON tc.id_asig = tas.id_pk 
	LEFT JOIN areas AS tar ON tas.id_area = tar.id
	LEFT JOIN matcurso AS tmc ON (tmc.id_asig = tas.id_pk AND tmc.id_grado = tc.id_grado) 
	LEFT JOIN matriculas AS tm ON tn.id_matric = tm.id_matric
	WHERE tn.periodo = '",_periodo,"' AND tn.id_matric = ",_id_matric," AND tc.`año` = ",_año,
	" AND tc.id_inst = ",_id_inst," AND tas.id_inst = ",_id_inst," AND tas.id_area = ",_id_area,
	" AND tar.id_inst = ",_id_inst," AND tmc.id_inst = ",_id_inst," AND tmc.`año` =",`_año`,"
	 AND tmc.id_grado = ",_cod_grado,"
	GROUP BY tn.id_matric, tas.id_area, tn.periodo");	
	PREPARE smtp FROM @sqlSelect;
	EXECUTE smtp;
	DEALLOCATE PREPARE smtp;
END$$

DROP PROCEDURE IF EXISTS `sp_prom_area_final`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_prom_area_final` (IN `_id_inst` INT(30), IN `_año` YEAR, IN `_id_matric` INT(30), IN `_id_area` INT(30), IN `_cod_grado` INT(11))  BEGIN
	DECLARE _ndecim,
			  _aplica,
			  _area INT(30) DEFAULT 0;
	DECLARE	_n_red,
			_n_final_red,
			_final DECIMAL(6,2) DEFAULT 0;		
	SELECT tc.Ndecimales,tc.nota_redondeo,tc.nota_final_redondeo, tc.aplicar_redondeo_fin_año
	INTO _ndecim, _n_red, _n_final_red, _aplica 
	FROM config001 AS tc 
	LEFT JOIN grados_agrupados AS t1 ON tc.id_grupo_grados = t1.id
	LEFT JOIN aux_grados_agrupados AS t2 ON t2.id_grado_agrupado = t1.id
	WHERE tc.año = _año AND tc.id_inst = _id_inst AND t2.id_grado = _cod_grado LIMIT 1;	
	SELECT tas.id_area cod_area, 
		ROUND(IF(tmc.porciento BETWEEN 1 AND 99,
		SUM((tn.final*tmc.porciento)/100),	AVG(tn.final)),_ndecim) AS prom INTO _area, _final 
		FROM areasf AS tn 
		LEFT JOIN cursos AS tc ON tn.id_curso = tc.id
		LEFT JOIN matriculas AS tm ON tn.id_matric = tm.id_matric
		LEFT JOIN asignaturas AS tas ON tc.id_asig = tas.id_pk 
		LEFT JOIN matcurso AS tmc ON (tmc.id_asig = tas.id_pk AND tmc.id_grado = tc.id_grado 
		AND tmc.`año` = tc.`año`) 
		LEFT JOIN areas AS tar ON tas.id_area = tar.id
		WHERE tc.`año` = `_año` AND tm.id_inst = _id_inst AND tm.id_inst = _id_inst 
		AND tm.id_matric = _id_matric	AND tas.id_inst = _id_inst AND tas.estado = 1 
		AND tar.id_inst = _id_inst AND tar.id_inst = _id_inst AND tar.estado = 1 
		AND tmc.id_inst = _id_inst AND tmc.`año` = `_año` AND tmc.estado = 1
		AND tar.id = _id_area
		GROUP BY tn.id_matric, tas.id_area;
  	IF _n_red > 0 AND _aplica > 0 THEN 
		IF _final BETWEEN _n_red AND _n_final_red THEN
			SELECT _area AS cod_area, _n_final_red AS prom; 
		ELSE
			SELECT _area AS cod_area, _final AS prom;	
		END IF;
	ELSE
		SELECT _area AS cod_area, _final AS prom; 	
	END IF;

END$$

DROP PROCEDURE IF EXISTS `sp_prom_por_area`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_prom_por_area` (IN `_id_inst` INT(30), IN `_año` YEAR, IN `_id_matric` INT(30), IN `_id_curso` INT(30), IN `_id_asig` INT(11), IN `_nro` INT, IN `_cod_grado` INT(11), IN `_table` VARCHAR(20), IN `_d` DECIMAL(6,2), IN `_a` DECIMAL(6,2), IN `_p` INT)  BEGIN
	DECLARE cTable VARCHAR(20) DEFAULT "";
	DECLARE nAr, 
				nAsig,
				_aplica INT DEFAULT 0;
	DECLARE	_n_red,
			_n_final_red DECIMAL(6,2) DEFAULT 0;
	DECLARE _final,_prom DECIMAL(6,2) DEFAULT 0;
	SELECT t.nota_redondeo,t.nota_final_redondeo, t.aplicar_redondeo_fin_año INTO _n_red, _n_final_red, _aplica
	FROM config001 t
	LEFT JOIN grados_agrupados AS t1 ON t.id_grupo_grados = t1.id
	LEFT JOIN aux_grados_agrupados AS t2 ON t2.id_grado_agrupado = t1.id
	WHERE t.id_inst=_id_inst AND t.año=`_año` AND t2.id_grado = _cod_grado LIMIT 1;
	SET cTable	= _table;
	IF LENGTH(cTable) = 0 THEN 
		SELECT fn_return_table_notas(_cod_grado) INTO cTable;
	END IF;
	CREATE TEMPORARY TABLE IF NOT EXISTS tmpTableNotas (
		id_matric INT(30) NOT NULL,
		id_asig	INT NOT NULL,
		cod_area	INT NOT NULL,
		final	DECIMAL(6,2),
		prom	DECIMAL(6,2),
		porciento DECIMAL(6,2)
	);	
	CREATE TEMPORARY TABLE IF NOT EXISTS tmpTableAreas (
		cod_area	INT NOT NULL,
		final	DECIMAL(6,2)
	);	
	SET @sqlSelect =CONCAT("INSERT INTO tmpTableNotas (id_matric,id_asig,cod_area,final,prom,porciento) ",
			"SELECT tn.id_matric,tc.id_asig,tas.id_area,
			IF(tn.nota_habilitacion > 0,
			ROUND(AVG(tn.nota_habilitacion),2),ROUND(AVG(tn.final),2)) AS final,
			ROUND(AVG(IF(tn.nota_habilitacion > 0,tn.nota_habilitacion ,tn.final)),2) AS prom,
			tmc.porciento FROM ",cTable," AS tn
			LEFT JOIN cursos AS tc ON (tn.id_curso = tc.id AND tn.año=tc.`año`)
			LEFT JOIN asignaturas AS tas ON tc.id_asig=tas.id_pk 
			LEFT JOIN matcurso AS tmc ON tmc.id_asig=tas.id_pk 
			WHERE tn.id_inst= ",_id_inst," AND tn.id_matric = ",_id_matric,"
			AND tc.año=",`_año`," AND tc.id_grado = ",_cod_grado," AND tas.id_inst=",_id_inst," 
			AND tmc.año=",`_año`," AND tmc.id_inst=",_id_inst," AND tmc.id_grado = ",_cod_grado,"
			GROUP BY tn.id_matric,tas.id_area,tc.id_asig 
			ORDER BY tn.id_matric,tas.id_area,tc.id_asig");	
	SET @sqlSelect2	= CONCAT("INSERT INTO tmpTableAreas (cod_area, final) ",
										"SELECT cod_area,AVG(prom) FROM tmpTableNotas GROUP BY cod_area");	
	PREPARE smtp FROM @sqlSelect;
	EXECUTE smtp;
	DEALLOCATE PREPARE smtp;	
	PREPARE smtp FROM @sqlSelect2;
	EXECUTE smtp;
	DEALLOCATE PREPARE smtp;	
	IF _n_red > 0 AND _aplica > 0 THEN 
		UPDATE tmpTableAreas SET final = _n_final_red WHERE final BETWEEN _n_red AND _n_final_red ; 
	END IF;
	SELECT COUNT(*) INTO nAr FROM tmpTableAreas  WHERE final BETWEEN _d AND _a;
	IF nAr > 0 THEN
		IF nAr < _p THEN
			SELECT id_asig, prom, cod_area INTO nAsig, _final, nAr FROM tmpTableNotas WHERE id_asig = _id_asig
			AND prom BETWEEN _d AND _a;
			SELECT final INTO _prom FROM tmpTableAreas WHERE cod_area = nAr LIMIT 1;  
			IF nAsig > 0 AND _prom BETWEEN _d AND _a THEN 
				CALL sp_insert_respeciales(_id_matric, _nro, _id_curso, _final);
			END IF;
		END IF;
	END IF;
	DELETE FROM tmpTableNotas;
	DELETE FROM tmpTableAreas;
END$$

DROP PROCEDURE IF EXISTS `sp_prom_por_area_porcentaje`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_prom_por_area_porcentaje` (IN `_id_inst` INT(30), IN `_año` YEAR, IN `_id_matric` INT(30), IN `_id_curso` INT(30), IN `_id_asig` INT(11), IN `_nro` INT, IN `_cod_grado` INT(11), IN `_table` VARCHAR(20), IN `_d` DECIMAL(6,2), IN `_a` DECIMAL(6,2), IN `_p` INT)  BEGIN
		DECLARE cTable VARCHAR(20) DEFAULT "";
	DECLARE nAr, 
				nAsig,
				_aplica INT DEFAULT 0;
	DECLARE _final, _prom, _n_red, _n_final_red DECIMAL(6,2) DEFAULT 0;
	SET cTable	= _table;
	IF LENGTH(cTable) = 0 THEN 
		SELECT fn_return_table_notas(_cod_grado) INTO cTable;
	END IF;
	SELECT t.nota_redondeo,t.nota_final_redondeo, t.aplicar_redondeo_fin_año INTO _n_red, _n_final_red, _aplica
	FROM config001 t 
	LEFT JOIN grados_agrupados AS t1 ON t.id_grupo_grados = t1.id
	LEFT JOIN aux_grados_agrupados AS t2 ON t2.id_grado_agrupado = t1.id
	WHERE t.id_inst=_id_inst AND t.año=`_año` AND t2.id_grado = _cod_grado LIMIT 1;
	CREATE TEMPORARY TABLE IF NOT EXISTS tmpTableNotas (
		id_matric INT(30) NOT NULL,
		id_asig	INT NOT NULL,
		cod_area	INT NOT NULL,
		final	DECIMAL(6,2),
		prom	DECIMAL(6,2),
		porciento DECIMAL(6,2)
	);	
	CREATE TEMPORARY TABLE IF NOT EXISTS tmpTableAreas (
		cod_area	INT NOT NULL,
		final	DECIMAL(6,2)
	);	
	SET @sqlSelect =CONCAT("INSERT INTO tmpTableNotas (id_matric,id_asig,cod_area,final,prom,porciento) ",
			"SELECT tn.id_matric,tc.id_asig,tas.id_area,
			IF(tn.nota_habilitacion > 0,
			ROUND(AVG((tn.nota_habilitacion*tmc.porciento)/100),2),
			ROUND(AVG((tn.final*tmc.porciento)/100),2)) AS final,
			ROUND(AVG(IF(tn.nota_habilitacion > 0,tn.nota_habilitacion ,tn.final)),2) AS prom,
			tmc.porciento FROM ",cTable," AS tn
			LEFT JOIN cursos AS tc ON (tn.id_curso=tc.id AND tn.año=tc.`año`)
			LEFT JOIN asignaturas AS tas ON tc.id_asig=tas.id_pk 
			LEFT JOIN matcurso AS tmc ON tmc.id_asig=tas.id_pk 
			WHERE tn.id_inst= ",_id_inst," AND tn.id_matric = ",_id_matric,"
			AND tc.año=",`_año`," AND tc.id_grado =",_cod_grado," AND tas.id_inst=",_id_inst," 
			AND tmc.año=",`_año`," AND tmc.id_inst=",_id_inst," AND tmc.id_grado = ",_cod_grado,"
			GROUP BY tn.id_matric,tas.id_area,tc.id_asig 
			ORDER BY tn.id_matric,tas.id_area,tc.id_asig");	
	SET @sqlSelect2	= CONCAT("INSERT INTO tmpTableAreas (cod_area, final) ",
										"SELECT cod_area,SUM(final) FROM tmpTableNotas GROUP BY cod_area");	
	PREPARE smtp FROM @sqlSelect;
	EXECUTE smtp;
	DEALLOCATE PREPARE smtp;	
	PREPARE smtp FROM @sqlSelect2;
	EXECUTE smtp;
	DEALLOCATE PREPARE smtp;	
	IF _n_red > 0 AND _aplica > 0 THEN 
		UPDATE tmpTableAreas SET final = _n_final_red WHERE final BETWEEN _n_red AND _n_final_red ; 
	END IF;
	SELECT COUNT(*) INTO nAr FROM tmpTableAreas  WHERE final BETWEEN _d AND _a;
	IF nAr > 0 THEN
		IF nAr < _p THEN
			SELECT id_asig, prom, cod_area INTO nAsig, _final, nAr FROM tmpTableNotas WHERE id_asig = _id_asig
			AND prom BETWEEN _d AND _a;
			SELECT final INTO _prom FROM tmpTableAreas WHERE cod_area = nAr LIMIT 1;
			IF nAsig > 0 AND _prom BETWEEN _d AND _a THEN 
				CALL sp_insert_respeciales(_id_matric, _nro, _id_curso, _final);
			END IF;
		END IF;
	END IF;
	DELETE FROM tmpTableNotas;
	DELETE FROM tmpTableAreas;
END$$

DROP PROCEDURE IF EXISTS `sp_prom_por_area_porcentaje_quinta`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_prom_por_area_porcentaje_quinta` (IN `_id_inst` INT(30), IN `_año` YEAR, IN `_id_matric` INT(30), IN `_id_curso` INT(30), IN `_id_asig` INT(11), IN `_nro` INT, IN `_cod_grado` INT(11), IN `_table` VARCHAR(20), IN `_d` DECIMAL(6,2), IN `_a` DECIMAL(6,2), IN `_p` INT, IN `_per` VARCHAR(2))  BEGIN
	DECLARE cTable VARCHAR(20) DEFAULT "";
	DECLARE nAr, 
				nAsig INT DEFAULT 0;
	DECLARE _final,_prom DECIMAL(6,2) DEFAULT 0;
	SET cTable	= _table;
	IF LENGTH(cTable) = 0 THEN 
		SELECT fn_return_table_notas(_cod_grado) INTO cTable;
	END IF;
	CREATE TEMPORARY TABLE IF NOT EXISTS tmpTableNotas (
		id_matric INT(30) NOT NULL,
		id_asig	INT NOT NULL,
		cod_area	INT NOT NULL,
		final	DECIMAL(6,2),
		prom	DECIMAL(6,2),
		porciento DECIMAL(6,2)
	);	
	CREATE TEMPORARY TABLE IF NOT EXISTS tmpTableAreas (
		cod_area	INT NOT NULL,
		final	DECIMAL(6,2)
	);	
	SET @sqlSelect =CONCAT("INSERT INTO tmpTableNotas (id_matric,id_asig,cod_area,final,prom,porciento) ",
			"SELECT tn.id_matric,tc.id_asig,tas.id_area,
			IF(tn.nota_habilitacion > 0,
			ROUND(((tn.nota_habilitacion*tmc.porciento)/100),2),
			ROUND(((tn.final*tmc.porciento)/100),2)) AS final,
			ROUND((IF(tn.nota_habilitacion > 0,tn.nota_habilitacion ,tn.final)),2) AS prom,
			tmc.porciento FROM ",cTable," AS tn
			LEFT JOIN cursos AS tc ON (tn.id_curso = tc.id AND tn.año=tc.`año`)
			LEFT JOIN asignaturas AS tas ON tc.id_asig=tas.id_pk 
			LEFT JOIN matcurso AS tmc ON tmc.id_asig=tas.id_pk 
			WHERE tn.id_inst= ",_id_inst," AND tn.id_matric = ",_id_matric,"
			AND tc.año=",`_año`," AND tc.id_grado=",_cod_grado," AND tas.id_inst=",_id_inst," AND tn.periodo ='",_per,"' 
			AND tmc.año=",`_año`," AND tmc.id_inst=",_id_inst," AND tmc.id_grado = ",_cod_grado,"
			GROUP BY tn.id_matric,tas.id_area,tc.id_asig 
			ORDER BY tn.id_matric,tas.id_area,tc.id_asig");	
	SET @sqlSelect2	= CONCAT("INSERT INTO tmpTableAreas (cod_area, final) ",
										"SELECT cod_area,SUM(final) FROM tmpTableNotas GROUP BY cod_area");	
	PREPARE smtp FROM @sqlSelect;
	EXECUTE smtp;
	DEALLOCATE PREPARE smtp;	
	PREPARE smtp FROM @sqlSelect2;
	EXECUTE smtp;
	DEALLOCATE PREPARE smtp;	
	SELECT COUNT(*) INTO nAr FROM tmpTableAreas  WHERE final BETWEEN _d AND _a;
	IF nAr > 0 THEN
		IF nAr < _p THEN
			SELECT id_asig, prom, cod_area INTO nAsig, _final, nAr FROM tmpTableNotas WHERE id_asig = _id_asig
			AND prom BETWEEN _d AND _a;
			SELECT final INTO _prom FROM tmpTableAreas WHERE cod_area = nAr LIMIT 1;
			IF nAsig > 0 AND _prom BETWEEN _d AND _a THEN 
				CALL sp_insert_respeciales(_id_matric, _nro, _id_curso, _final);
			END IF;
		END IF;
	END IF;
	DELETE FROM tmpTableNotas;
	DELETE FROM tmpTableAreas;
END$$

DROP PROCEDURE IF EXISTS `sp_prom_por_area_quinta`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_prom_por_area_quinta` (IN `_id_inst` INT(30), IN `_año` YEAR, IN `_id_matric` INT(30), IN `_id_curso` INT(30), IN `_id_asig` INT(11), IN `_nro` INT, IN `_cod_grado` INT(11), IN `_table` VARCHAR(20), IN `_d` DECIMAL(6,2), IN `_a` DECIMAL(6,2), IN `_p` INT, IN `_per` VARCHAR(2))  BEGIN
		DECLARE cTable VARCHAR(20) DEFAULT "";
	DECLARE nAr, 
				nAsig INT DEFAULT 0;
	DECLARE _final,_prom DECIMAL(6,2) DEFAULT 0;
	SET cTable	= _table;
	IF LENGTH(cTable) = 0 THEN 
		SELECT fn_return_table_notas(_cod_grado) INTO cTable;
	END IF;
	CREATE TEMPORARY TABLE IF NOT EXISTS tmpTableNotas (
		id_matric INT(30) NOT NULL,
		id_asig	INT NOT NULL,
		cod_area	INT NOT NULL,
		final	DECIMAL(6,2),
		prom	DECIMAL(6,2),
		porciento DECIMAL(6,2)
	);	
	CREATE TEMPORARY TABLE IF NOT EXISTS tmpTableAreas (
		cod_area	INT NOT NULL,
		final	DECIMAL(6,2)
	);	
	SET @sqlSelect =CONCAT("INSERT INTO tmpTableNotas (id_matric,id_asig,cod_area,final,prom,porciento) ",
			"SELECT tn.id_matric,tc.id_asig,tas.id_area,
			IF(tn.nota_habilitacion > 0,
			ROUND(AVG(tn.nota_habilitacion),2),ROUND(AVG(tn.final),2)) AS final,
			ROUND(AVG(IF(tn.nota_habilitacion > 0,tn.nota_habilitacion ,tn.final)),2) AS prom,
			tmc.porciento FROM ",cTable," AS tn
			LEFT JOIN cursos AS tc ON (tn.id_curso=tc.id AND tn.año=tc.año)
			LEFT JOIN asignaturas AS tas ON tc.id_asig=tas.id_pk
			LEFT JOIN matcurso AS tmc ON tmc.id_asig=tas.id_pk 
			WHERE tn.id_inst= ",_id_inst," AND tn.id_matric = ",_id_matric,"
			AND tc.año=",`_año`," AND tc.id_grado=",_cod_grado," AND tas.id_inst=",_id_inst," AND tn.periodo = '",_per,"' 
			AND tmc.año=",`_año`," AND tmc.id_inst=",_id_inst," AND tmc.id_grado = ",_cod_grado,"
			GROUP BY tn.id_matric,tas.id_area,tc.id_asig 
			ORDER BY tn.id_matric,tas.id_area,tc.id_asig");	
	SET @sqlSelect2	= CONCAT("INSERT INTO tmpTableAreas (cod_area, final) ",
										"SELECT cod_area,AVG(prom) FROM tmpTableNotas GROUP BY cod_area");	
	PREPARE smtp FROM @sqlSelect;
	EXECUTE smtp;
	DEALLOCATE PREPARE smtp;	
	PREPARE smtp FROM @sqlSelect2;
	EXECUTE smtp;
	DEALLOCATE PREPARE smtp;	
	SELECT COUNT(*) INTO nAr FROM tmpTableAreas  WHERE final BETWEEN _d AND _a;
	IF nAr > 0 THEN
		IF nAr < _p THEN
			SELECT id_asig, prom, cod_area INTO nAsig, _final, nAr FROM tmpTableNotas WHERE id_asig = _id_asig
			AND prom BETWEEN _d AND _a;
			SELECT final INTO _prom FROM tmpTableAreas WHERE cod_area = nAr LIMIT 1;
			IF nAsig > 0 AND _prom BETWEEN _d AND _a THEN 
				CALL sp_insert_respeciales(_id_matric, _nro, _id_curso, _final);
			END IF;
		END IF;
	END IF;
	DELETE FROM tmpTableNotas;
	DELETE FROM tmpTableAreas;
END$$

DROP PROCEDURE IF EXISTS `sp_prom_por_asignaturas`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_prom_por_asignaturas` (IN `_id_inst` INT(30), IN `_año` YEAR, IN `_id_matric` INT(30), IN `_id_curso` INT(30), IN `_id_asig` INT, IN `_nro` INT, IN `_cod_grado` INT(11), IN `_table` VARCHAR(20), IN `_d` DECIMAL(6,2), IN `_a` DECIMAL(6,2), IN `_p` INT)  BEGIN
	DECLARE cTable VARCHAR(20) DEFAULT "";
	DECLARE nAr, 
				nAsig INT DEFAULT 0;
	DECLARE _final DECIMAL(6,2) DEFAULT 0;
	SET cTable	= _table;
	IF LENGTH(cTable) = 0 THEN 
		SELECT fn_return_table_notas(_cod_grado) INTO cTable;
	END IF;
	CREATE TEMPORARY TABLE IF NOT EXISTS tmpTableNotas (
		id_matric INT(30) NOT NULL,
		id_asig	INT NOT NULL,
		cod_area	INT NOT NULL,
		final	DECIMAL(6,2),
		prom	DECIMAL(6,2),
		porciento DECIMAL(6,2)
	);	
	SET @sqlSelect =CONCAT("INSERT INTO tmpTableNotas (id_matric,id_asig,cod_area,final,prom,porciento) ",
			"SELECT tn.id_matric,tc.id_asig,tas.id_area,
			IF(tn.nota_habilitacion > 0,
			ROUND(tn.nota_habilitacion,2),ROUND(tn.final,2)) AS final,
			ROUND((IF(tn.nota_habilitacion > 0,tn.nota_habilitacion ,tn.final)),2) AS prom,
			tmc.porciento FROM ",cTable," AS tn
			LEFT JOIN cursos As tc ON (tn.id_curso = tc.id AND tn.año=tc.`año`)
			LEFT JOIN asignaturas AS tas ON tc.id_asig=tas.id_pk 
			LEFT JOIN matcurso AS tmc ON tmc.id_asig=tas.id_pk 
			WHERE tn.id_inst= ",_id_inst," AND tn.id_matric = ",_id_matric,"
			AND tc.año=",`_año`," AND tc.id_grado =",_cod_grado," AND tas.id_inst=",_id_inst,"  
			AND tmc.año=",`_año`," AND tmc.id_inst=",_id_inst," AND tmc.id_grado = ",_cod_grado,"
			GROUP BY tn.id_matric,tas.id_area,tc.id_asig 
			ORDER BY tn.id_matric,tas.id_area,tc.id_asig");	
	PREPARE smtp FROM @sqlSelect;
	EXECUTE smtp;
	DEALLOCATE PREPARE smtp;
		
	SELECT COUNT(*) INTO nAr FROM tmpTableNotas  WHERE final BETWEEN _d AND _a;
	IF nAr > 0 THEN
		IF nAr < _p THEN
			SELECT id_asig, prom INTO nAsig, _final FROM tmpTableNotas WHERE id_asig = _id_asig
			AND prom BETWEEN _d AND _a;
			IF nAsig > 0 THEN 
				CALL sp_insert_respeciales(_id_matric, _nro, _id_curso, _final);
			END IF;
		END IF;
	END IF;
	DELETE FROM tmpTableNotas;
END$$

DROP PROCEDURE IF EXISTS `sp_prom_por_asignaturas_quinta`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_prom_por_asignaturas_quinta` (IN `_id_inst` INT(30), IN `_año` YEAR, IN `_id_matric` INT(30), IN `_id_curso` INT(30), IN `_id_asig` INT(11), IN `_nro` INT, IN `_cod_grado` INT(11), IN `_table` VARCHAR(20), IN `_d` DECIMAL(6,2), IN `_a` DECIMAL(6,2), IN `_p` INT, IN `_per` VARCHAR(2))  BEGIN
	DECLARE cTable VARCHAR(20) DEFAULT "";
	DECLARE nAr, 
				nAsig INT DEFAULT 0;
	DECLARE _final DECIMAL(6,2) DEFAULT 0;
	SET cTable	= _table;
	IF LENGTH(cTable) = 0 THEN 
		SELECT fn_return_table_notas(_cod_grado) INTO cTable;
	END IF;
	CREATE TEMPORARY TABLE IF NOT EXISTS tmpTableNotas (
		id_matric INT(30) NOT NULL,
		id_asig	INT NOT NULL,
		cod_area	INT NOT NULL,
		final	DECIMAL(6,2),
		prom	DECIMAL(6,2),
		porciento DECIMAL(6,2)
	);	
	SET @sqlSelect =CONCAT("INSERT INTO tmpTableNotas (id_matric,id_asig,cod_area,final,prom,porciento) ",
			"SELECT tn.id_matric,tc.id_asig,tas.id_area,
			IF(tn.nota_habilitacion > 0,
			ROUND(tn.nota_habilitacion,2),ROUND(tn.final,2)) AS final,
			ROUND((IF(tn.nota_habilitacion > 0,tn.nota_habilitacion ,tn.final)),2) AS prom,
			tmc.porciento FROM ",cTable," AS tn
			LEFT JOIN cursos AS tc ON (tn.id_curso = tc.id AND tn.año=tc.año)
			LEFT JOIN asignaturas AS tas ON tc.id_asig=tas.id_pk 
			LEFT JOIN matcurso AS tmc ON tmc.id_asig=tas.id_pk 
			WHERE tn.id_inst= ",_id_inst," AND tn.id_matric = ",_id_matric,"
			AND tc.año=",`_año`," AND tc.id_grado=",_cod_grado," AND tas.id_inst=",_id_inst," AND tn.periodo ='",_per,"'  
			AND tmc.año=",`_año`," AND tmc.id_inst=",_id_inst," AND tmc.id_grado = ",_cod_grado,"
			GROUP BY tn.id_matric,tas.id_area,tc.id_asig 
			ORDER BY tn.id_matric,tas.id_area,tc.id_asig");	
	PREPARE smtp FROM @sqlSelect;
	EXECUTE smtp;
	DEALLOCATE PREPARE smtp;
		
	SELECT COUNT(*) INTO nAr FROM tmpTableNotas  WHERE final BETWEEN _d AND _a;
	IF nAr > 0 THEN
		IF nAr < _p THEN
			SELECT id_asig, prom INTO nAsig, _final FROM tmpTableNotas WHERE id_asig = _id_asig
			AND prom BETWEEN _d AND _a;
			IF nAsig > 0 THEN 
				CALL sp_insert_respeciales(_id_matric, _nro, _id_curso, _final);
			END IF;
		END IF;
	END IF;
	DELETE FROM tmpTableNotas;
END$$

DROP PROCEDURE IF EXISTS `sp_puestos_generate`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_puestos_generate` (IN `_cod_grado` INT(11), IN `_grupo` VARCHAR(2), IN `_id_jorn` INT(1), IN `_id_sede` INT(30), IN `_id_inst` INT(30), IN `_año` YEAR, IN `_periodo` VARCHAR(1))  BEGIN
	DECLARE 	done,
				_id_matric,
				_id_matric_n,
				_total,
				_puesto,
				_type_puesto INT DEFAULT 0;
	DECLARE 	_prom,
				_n_max,
				_n_min DECIMAL(6,2) DEFAULT 0;
	DECLARE  _SQL TEXT DEFAULT '';
	DECLARE 	_per VARCHAR(1) DEFAULT '';
	DECLARE cTable VARCHAR(30) DEFAULT '';
	DECLARE curs  CURSOR FOR SELECT t.id_matric,ROUND(AVG(t.prom),2) AS prom, t.periodo, MIN(t.nmin) min, MAX(t.nmax) max 
			FROM tb_promedios t GROUP BY id_matric,periodo
			ORDER BY prom DESC, max DESC;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done = 1;	
	SELECT t.prom_area_puesto INTO _type_puesto FROM config001 t 
	LEFT JOIN grados_agrupados AS t1 ON t.id_grupo_grados = t1.id 
	LEFT JOIN aux_grados_agrupados AS t2 ON t2.id_grado_agrupado = t1.id
	WHERE t.id_inst = _id_inst AND t.`año` = `_año` AND t2.id_grado = _cod_grado LIMIT 1;
	SELECT COUNT(*) INTO _total FROM matriculas AS tm WHERE tm.id_grado = _cod_grado 
					AND tm.grupo = _grupo AND tm.id_jorn = _id_jorn AND tm.id_sede = _id_sede 
					AND tm.`año` = `_año` AND tm.id_inst = _id_inst AND tm.id_estado = 2;
	SELECT fn_return_table_notas(_cod_grado) INTO cTable;
	DELETE FROM tb_promedios;
	IF _type_puesto = 1 THEN /* Promedio por áreas */
		SET @sqlSelect = CONCAT("INSERT INTO tb_promedios (id_matric,prom,periodo,nmin,nmax) 
			SELECT tm.id_matric, 
			ROUND(IF(tmc.porciento BETWEEN 1 AND 99,
			SUM(IF(tn.nota_habilitacion > 0,(tn.nota_habilitacion*tmc.porciento)/100,(tn.final*tmc.porciento)/100)),
			AVG(IF(tn.nota_habilitacion > 0, tn.nota_habilitacion, tn.final))),2) AS prome, 
			tn.periodo, 
			MIN(if(tn.nota_habilitacion > 0,tn.nota_habilitacion, tn.final)) AS nmin, 
			MAX(if(tn.nota_habilitacion > 0,tn.nota_habilitacion, tn.final)) AS nmax
			FROM ",cTable," AS tn 
			LEFT JOIN cursos AS tc ON tn.id_curso = tc.id
			LEFT JOIN matriculas AS tm ON tn.id_matric = tm.id_matric 
			LEFT JOIN asignaturas AS ta ON tc.id_asig = ta.id_pk
			LEFT JOIN matcurso AS tmc ON (tmc.id_grado = tc.id_grado AND tmc.id_asig = ta.id_pk)
			WHERE tm.id_estado=2 AND tm.`id_grado` = '",_cod_grado,"' AND tm.grupo='",_grupo,"' AND 
			tm.año= ",`_año`," AND tm.id_sede= ",_id_sede," AND tm.id_inst = ",_id_inst," AND 
			tn.periodo = '",_periodo,"' AND tm.id_jorn= ",_id_jorn," AND tmc.id_grado = '",_cod_grado,"'
			AND tmc.`año` = ",`_año`," AND tmc.id_inst = ",_id_inst," AND tmc.estado = 1 AND
			ta.id_inst =",_id_inst," AND ta.estado = 1 AND ta.electiva = 0
			GROUP BY tn.id_matric, tm.id_grado, tm.grupo, tn.periodo, tm.año,ta.id_area
			ORDER BY prome DESC, nmax DESC;");
		PREPARE smtp FROM @sqlSelect;
		EXECUTE smtp;
		DEALLOCATE PREPARE smtp;	
		OPEN curs;			
		REPEAT 
			FETCH curs INTO _id_matric_n,_prom,_per,_n_min,_n_max;				
			IF NOT done THEN
				SET _puesto = _puesto +1;
				SET _SQL	= CONCAT(_SQL,"('",_id_matric_n,"','",_total,"','",_puesto,"','",_prom,"','",_n_max,"','",
					_n_min,"','",_per,"'),"); 				
			END IF;				
		UNTIL done END REPEAT;
		CLOSE curs;
		DELETE FROM puestos  WHERE id_matric IN (SELECT id_matric FROM matriculas AS t2 
							WHERE t2.id_matric AND t2.id_sede = _id_sede AND t2.id_inst = _id_inst 
							AND t2.id_grado = _cod_grado AND t2.grupo = _grupo AND t2.id_jorn = _id_jorn 
							AND t2.`año` = `_año`) AND periodo = _periodo;
		SET @sqlInsert = CONCAT("INSERT INTO puestos (id_matric,total,puesto,prom,nota_max,nota_min,periodo) 
					VALUES ",LEFT(_SQL, LENGTH(_SQL)-1),";");
		PREPARE smtp FROM @sqlInsert;
		EXECUTE smtp;
		DEALLOCATE PREPARE smtp;
	ELSE	
		DELETE FROM puestos  WHERE id_matric IN (SELECT id_matric FROM matriculas AS t2 
							WHERE t2.id_matric AND t2.id_sede = _id_sede AND t2.id_inst = _id_inst 
							AND t2.id_grado = _cod_grado AND t2.grupo = _grupo AND t2.id_jorn = _id_jorn 
							AND t2.`año` = `_año`) AND periodo = _periodo;
		SET @sqlSelect = CONCAT("INSERT INTO puestos (id_matric,prom,periodo,nota_min,nota_max,puesto,total) 
			SELECT tm.id_matric, ROUND(AVG(if(nota_habilitacion > 0,nota_habilitacion, final)),2) AS prome, 
			tn.periodo, 
			MIN(if(nota_habilitacion > 0,nota_habilitacion, final)) AS nmin, 
			MAX(if(nota_habilitacion > 0,nota_habilitacion, final)) AS nmax, 
			ROW_NUMBER() OVER (PARTITION BY periodo ORDER BY prome DESC, nmax DESC) AS puesto,",
			_total," FROM ",cTable," AS tn 
			LEFT JOIN cursos AS tc ON tn.id_curso = tc.id
		   LEFT JOIN matriculas AS tm ON tn.id_matric = tm.id_matric 
		   LEFT JOIN asignaturas AS ta ON tc.id_asig = ta.id_pk
			WHERE tm.id_estado=2 AND tm.`id_grado` = ",_cod_grado," AND tm.grupo= '",_grupo,"' AND 
			tm.año= ",`_año`," AND tm.id_sede= ",_id_sede," AND tm.id_inst = ",_id_inst," AND 
			tn.periodo = '",_periodo,"' AND tm.id_jorn= ",_id_jorn," AND ta.id_inst = ",_id_inst," 
			AND ta.estado = 1 AND ta.electiva = 0
			GROUP BY tn.id_matric, tm.id_grado, tm.grupo, tn.periodo, tm.año
			ORDER BY puesto, prome DESC, nmax DESC");
		PREPARE smtp FROM @sqlSelect;
		EXECUTE smtp;
		DEALLOCATE PREPARE smtp;
	END IF;	
END$$

DROP PROCEDURE IF EXISTS `sp_puestos_select`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_puestos_select` (IN `_id_inst` INT(20), IN `_id_sede` INT(20), IN `_cod_grado` VARCHAR(2) CHARSET utf8, IN `_grupo` VARCHAR(2) CHARSET utf8, IN `_id_jorn` INT(1), IN `_año` YEAR, IN `_periodo` VARCHAR(1) CHARSET utf8)  BEGIN
	SELECT tp.*,tm.cod_grado, tm.grupo FROM puestos AS tp 
		 LEFT JOIN matriculas  AS tm ON tp.id_matric = tm.id_matric 
		 WHERE tm.cod_grado = _cod_grado AND tm.grupo = _grupo AND tm.id_jorn = _id_jorn AND 
		 tm.id_sede = _id_sede AND tm.id_inst = _id_inst AND tm.`año` = `_año` AND tp.periodo = _periodo;
END$$

DROP PROCEDURE IF EXISTS `sp_select_acta_promocion`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_select_acta_promocion` (IN `_id_inst` INT(20), IN `_cod_grado` INT(11), IN `_grupo` VARCHAR(2), IN `_id_jorn` INT(2), IN `_id_sede` INT(20), IN `_año` YEAR)  BEGIN
	IF _grupo = '' THEN 
		SELECT ta.msg,ta.promedio, ta.promedio_rec, ta.prom_comision,tm.id_grado cod_grado,tm.grupo, te.sexo,
		CONCAT(RTRIM(te.apellido1),' ',RTRIM(te.apellido2),' ',RTRIM(te.nombre1),' ',RTRIM(te.nombre2)) estudiante,
		RTRIM(tg.grado) grado, RTRIM(tj.JORNADA) jornada, RTRIM(ts.NOM_SEDE) sede, tm.`año`, tm.id_matric
		FROM acta_promocion AS ta
		LEFT JOIN matriculas AS tm ON ta.id_matric = tm.id_matric 
		LEFT JOIN inscripciones AS te ON tm.cod_est = te.cod_est 
		LEFT JOIN grados tg ON tm.id_grado = tg.id
		LEFT JOIN jornadas AS tj ON tm.id_jorn = tj.cod_jorn 
		LEFT JOIN sedes AS ts ON tm.id_sede = ts.ID
		WHERE tm.id_grado = _cod_grado AND tm.id_jorn = _id_jorn AND tm.id_estado = 2  
		AND tm.id_sede = _id_sede AND tm.id_inst = _id_inst AND tm.`año`= `_año` 
		ORDER BY tm.id_grado, tm.grupo,ta.estado,te.sexo,estudiante;
	ELSE
		SELECT ta.msg,ta.promedio, ta.promedio_rec, ta.prom_comision,tm.id_grado cod_grado,tm.grupo, te.sexo,
		CONCAT(RTRIM(te.apellido1),' ',RTRIM(te.apellido2),' ',RTRIM(te.nombre1),' ',RTRIM(te.nombre2)) estudiante,
		RTRIM(tg.grado) grado, RTRIM(tj.JORNADA) jornada, RTRIM(ts.NOM_SEDE) sede, tm.`año`, tm.id_matric
		FROM acta_promocion AS ta
		LEFT JOIN matriculas AS tm ON ta.id_matric = tm.id_matric 
		LEFT JOIN inscripciones AS te ON tm.cod_est = te.cod_est 
		LEFT JOIN grados tg ON tm.id_grado = tg.id
		LEFT JOIN jornadas AS tj ON tm.id_jorn = tj.cod_jorn 
		LEFT JOIN sedes AS ts ON tm.id_sede = ts.ID
		WHERE tm.id_grado = _cod_grado AND tm.id_jorn = _id_jorn AND tm.id_estado = 2  
		AND tm.id_sede = _id_sede AND tm.id_inst = _id_inst AND tm.`año`= `_año` 
		AND tm.grupo = _grupo
		ORDER BY tm.id_grado, tm.grupo,ta.estado,te.sexo,estudiante;
	END IF;
END$$

DROP PROCEDURE IF EXISTS `sp_select_acta_promocion_est`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_select_acta_promocion_est` (IN `_cod_grado` VARCHAR(2), IN `_grupo` VARCHAR(2), IN `_id_jorn` INT(2), IN `_id_sede` INT(20), IN `_año` YEAR, IN `_id_inst` INT(20), IN `_id_matric` INT(20))  BEGIN
	SELECT tm.cod_grado,tm.grupo,tm.id_jorn,tm.id_sede,ta.*, te.sexo,
	te.apellido1,te.apellido2,te.nombre1,te.nombre2 FROM acta_promocion AS ta
	LEFT JOIN matriculas AS tm ON ta.id_matric = tm.id_matric 
	LEFT JOIN inscripciones AS te ON tm.cod_est = te.cod_est 
	WHERE tm.cod_grado = _cod_grado AND tm.grupo = _grupo AND tm.id_jorn = _id_jorn 
	AND tm.id_sede = _id_sede AND tm.id_inst = _id_inst AND tm.`año`= `_año` 
    HAVING ta.id_matric = _id_matric 
	ORDER BY ta.estado,ta.prom_comision,te.sexo,ta.id_matric;
END$$

DROP PROCEDURE IF EXISTS `sp_select_areasf`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_select_areasf` (IN `_id_inst` INT(30), IN `_año` YEAR, IN `_id_sede` INT(30), IN `_cod_grado` INT(11), IN `_grupo` VARCHAR(2), IN `_id_jorn` INT(1), IN `_id_matic` INT(30), IN `_dist` INT(1))  BEGIN
	IF _dist > 0 THEN
		IF _id_matic > 0 THEN 
			SELECT tm.id_inst,tm.id_sede,tm.id_grado cod_grado,tm.grupo,tj.cod_jorn,tm.año, 
				tas.id_area cod_area,tc.id_asig,ta.final,ta.recuperacion,
				ta.faltas,ta.injustificadas,ta.retraso,ta.estado,RTRIM(ts.nom_sede) As sede,tg.grado,tj.jornada,
		      RTRIM(tar.area) area,RTRIM(tas.asignatura) asignatura,
			   concat(rtrim(te.apellido1),' ',rtrim(te.apellido2),' ',rtrim(te.nombre1),' ',rtrim(te.nombre2)) 
			   as estudiante,tm.id_matric,RIGHT(CONCAT('0000',tm.id_folio),4) id_folio,te.cod_doc,te.sexo,te.dpto_lug_exp,
		      te.mun_lug_exp, te.nro_doc_id,tas.excluir,tas.electiva,te.cod_est,
				RIGHT(CONCAT('0000',tm.nro_matricula),4) nro_matricula,RIGHT(CONCAT('0000',tm.libro_mat),4) libro_mat,tmc.ih,
		      tp.promedio, tp.promedio_rec,tp.prom_comision,tp.msg,tp.msg1,tp.msg2,tp.msg3, 
				RTRIM(ac.nombre) asignaturac,ac.ih ihc, es.nombre_escala
				FROM areasf AS ta 
				LEFT JOIN cursos AS tc ON ta.id_curso = tc.id
		      LEFT JOIN matriculas AS tm ON ta.id_matric=tm.id_matric
				LEFT JOIN sedes AS ts ON tm.id_sede=ts.id  
			   LEFT JOIN grados AS tg ON tm.id_grado=tg.id 
				LEFT JOIN jornadas AS tj ON tm.id_jorn=tj.cod_jorn 	
			   LEFT JOIN asignaturas AS tas ON tc.id_asig=tas.id_pk 
		      LEFT JOIN areas AS tar ON tas.id_area=tar.id 
				LEFT JOIN inscripciones AS te ON tm.cod_est=te.cod_est 
				LEFT JOIN matcurso AS tmc ON (tmc.id_asig = tas.id_pk AND tmc.id_grado = tg.id 
				AND tmc.`año` AND tc.`año`)
				LEFT JOIN acta_promocion AS tp ON tp.id_matric = ta.id_matric
				LEFT JOIN asignaturas_certificados AS ac ON ac.id_asig_padre = tas.id_pk
				LEFT JOIN `desempeños` AS td ON (ta.final BETWEEN td.desde AND td.hasta)
				LEFT JOIN escala_nacional AS es ON td.id_escala = es.id
				LEFT JOIN grados_agrupados AS t1 ON td.id_grado_agrupado = t1.id
				LEFT JOIN aux_grados_agrupados AS t2 ON t2.id_grado_agrupado = t1.id
				WHERE tc.`año` = `_año` AND tc.id_grado = _cod_grado 
				AND tm.año=_año AND tm.id_grado=_cod_grado AND tm.grupo=_grupo 
				AND tm.id_jorn=_id_jorn AND tm.id_estado = 2 AND tm.id_inst = _id_inst
				AND tm.id_sede=_id_sede AND tm.id_matric = _id_matic
				AND ts.ID_INST = _id_inst
				AND tar.id_inst = _id_inst AND tar.estado = 1
				AND tas.id_inst = _id_inst AND tas.estado = 1 
				AND tmc.id_inst = _id_inst AND tmc.`año` = `_año` AND tmc.estado = 1
				AND tmc.id_grado = _cod_grado	AND ac.estado = 1
				AND td.`año` = `_año` AND t2.id_grado = _cod_grado
		      ORDER BY estudiante,tar.ordenar,tar.id,tas.ordenar;
		ELSE
			SELECT tm.id_inst,tm.id_sede,tm.id_grado cod_grado,tm.grupo,tj.cod_jorn,tm.año, 
				tas.id_area cod_area,tc.id_asig,ta.final,ta.recuperacion,
				ta.faltas,ta.injustificadas,ta.retraso,ta.estado,RTRIM(ts.nom_sede) As sede,tg.grado,tj.jornada,
		      RTRIM(tar.area) area,RTRIM(tas.asignatura) asignatura,
			   concat(rtrim(te.apellido1),' ',rtrim(te.apellido2),' ',rtrim(te.nombre1),' ',rtrim(te.nombre2)) 
			   as estudiante,tm.id_matric,RIGHT(CONCAT('0000',tm.id_folio),4) id_folio,te.cod_doc,te.sexo,te.dpto_lug_exp,
		      te.mun_lug_exp, te.nro_doc_id,tas.excluir,tas.electiva,te.cod_est,
				RIGHT(CONCAT('0000',tm.nro_matricula),4) nro_matricula,RIGHT(CONCAT('0000',tm.libro_mat),4) libro_mat,tmc.ih,
		      tp.promedio, tp.promedio_rec,tp.prom_comision,tp.msg,tp.msg1,tp.msg2,tp.msg3, 
				RTRIM(ac.nombre) asignaturac,ac.ih ihc, es.nombre_escala
				FROM areasf AS ta 
				LEFT JOIN cursos AS tc ON ta.id_curso = tc.id
		      LEFT JOIN matriculas AS tm ON ta.id_matric=tm.id_matric
				LEFT JOIN sedes AS ts ON tm.id_sede=ts.id  
			   LEFT JOIN grados AS tg ON tm.id_grado=tg.id 
				LEFT JOIN jornadas AS tj ON tm.id_jorn=tj.cod_jorn 	
			   LEFT JOIN asignaturas AS tas ON tc.id_asig=tas.id_pk 
		      LEFT JOIN areas AS tar ON tas.id_area=tar.id 
				LEFT JOIN inscripciones AS te ON tm.cod_est=te.cod_est 
				LEFT JOIN matcurso AS tmc ON (tmc.id_asig = tas.id_pk AND tmc.id_grado = tg.id 
				AND tmc.`año` AND tc.`año`)
				LEFT JOIN acta_promocion AS tp ON tp.id_matric = ta.id_matric
				LEFT JOIN asignaturas_certificados AS ac ON ac.id_asig_padre = tas.id_pk
				LEFT JOIN `desempeños` AS td ON (ta.final BETWEEN td.desde AND td.hasta)
				LEFT JOIN escala_nacional AS es ON td.id_escala = es.id
				LEFT JOIN grados_agrupados AS t1 ON td.id_grado_agrupado = t1.id
				LEFT JOIN aux_grados_agrupados AS t2 ON t2.id_grado_agrupado = t1.id
				WHERE tc.`año` = `_año` AND tc.id_grado = _cod_grado 
				AND tm.año=_año AND tm.id_grado=_cod_grado AND tm.grupo=_grupo 
				AND tm.id_jorn=_id_jorn AND tm.id_estado = 2 AND tm.id_inst = _id_inst
				AND tm.id_sede=_id_sede
				AND ts.ID_INST = _id_inst
				AND tar.id_inst = _id_inst AND tar.estado = 1
				AND tas.id_inst = _id_inst AND tas.estado = 1 
				AND tmc.id_inst = _id_inst AND tmc.`año` = `_año` AND tmc.estado = 1
				AND tmc.id_grado = _cod_grado	AND ac.estado = 1
				AND td.`año` = `_año` AND t2.id_grado = _cod_grado
		      ORDER BY estudiante,tar.ordenar,tar.id,tas.ordenar;
		END IF;
	ELSE 
		IF _id_matic > 0 THEN 
			SELECT tm.id_inst,tm.id_sede,tm.id_grado cod_grado,tm.grupo,tj.cod_jorn,tm.año, 
				tas.id_area cod_area,tc.id_asig,ta.p1,ta.p2,ta.p3,ta.p4,ta.final,ta.recuperacion,
				ta.faltas,ta.injustificadas,ta.retraso,ta.estado,RTRIM(ts.nom_sede) As sede,tg.grado,tj.jornada,
		      RTRIM(tar.area) area,RTRIM(tas.asignatura) asignatura,
			   concat(rtrim(te.apellido1),' ',rtrim(te.apellido2),' ',rtrim(te.nombre1),' ',rtrim(te.nombre2)) 
			   as estudiante,tm.id_matric,RIGHT(CONCAT('0000',tm.id_folio),4) id_folio,te.cod_doc,te.sexo,te.dpto_lug_exp,
		      te.mun_lug_exp, te.nro_doc_id,tas.excluir,tas.electiva,te.cod_est,
				RIGHT(CONCAT('0000',tm.nro_matricula),4) nro_matricula,RIGHT(CONCAT('0000',tm.libro_mat),4) libro_mat,tmc.ih,
		      tp.promedio, tp.promedio_rec,tp.prom_comision,tp.msg,tp.msg1,tp.msg2,tp.msg3, tn.nombre_nivel, es.nombre_escala
				FROM areasf AS ta 
				LEFT JOIN cursos AS tc ON ta.id_curso = tc.id
		      LEFT JOIN  matriculas AS tm ON ta.id_matric=tm.id_matric
				LEFT JOIN sedes AS ts ON tm.id_sede=ts.id  
			   LEFT JOIN grados AS tg ON tm.id_grado=tg.id 
				LEFT JOIN jornadas AS tj ON tm.id_jorn=tj.cod_jorn 	
			   LEFT JOIN asignaturas AS tas ON tc.id_asig=tas.id_pk 
		      LEFT JOIN areas AS tar ON tas.id_area=tar.id 
				LEFT JOIN inscripciones AS te ON tm.cod_est=te.cod_est 
				LEFT JOIN matcurso AS tmc ON (tmc.id_asig = tas.id_pk AND tmc.id_grado = tc.id_grado 
				AND tmc.`año` = tc.`año`)
				LEFT JOIN acta_promocion AS tp ON tp.id_matric = ta.id_matric
				LEFT JOIN niveles_estudio AS tn ON tg.id_nivel = tn.id
				LEFT JOIN `desempeños` AS td ON (ta.final BETWEEN td.desde AND td.hasta)
				LEFT JOIN escala_nacional AS es ON td.id_escala = es.id
				LEFT JOIN grados_agrupados AS t1 ON td.id_grado_agrupado = t1.id
				LEFT JOIN aux_grados_agrupados AS t2 ON t2.id_grado_agrupado = t1.id
				WHERE tc.`año` = `_año` AND tc.id_grado = _cod_grado AND tm.año=_año 
				AND tm.id_sede=_id_sede AND tm.id_grado=_cod_grado AND tm.grupo=_grupo 
				AND tm.id_jorn=_id_jorn AND tm.id_estado = 2 AND tm.id_inst = _id_inst
				AND tm.id_matric = _id_matic
				AND ts.ID_INST = _id_inst  AND tar.id_inst = _id_inst AND tar.estado = 1
				AND tas.id_inst = _id_inst AND tas.estado = 1 
				AND tmc.id_inst = _id_inst AND tmc.`año` = `_año` AND tmc.estado = 1
				AND td.`año` = `_año` AND t2.id_grado = _cod_grado
		      ORDER BY estudiante,tar.ordenar,tar.id,tas.ordenar;
		ELSE
			SELECT tm.id_inst,tm.id_sede,tm.id_grado cod_grado,tm.grupo,tj.cod_jorn,tm.año, 
				tas.id_area cod_area,tc.id_asig,ta.p1,ta.p2,ta.p3,ta.p4,ta.final,ta.recuperacion,
				ta.faltas,ta.injustificadas,ta.retraso,ta.estado,RTRIM(ts.nom_sede) As sede,tg.grado,tj.jornada,
		      RTRIM(tar.area) area,RTRIM(tas.asignatura) asignatura,
			   concat(rtrim(te.apellido1),' ',rtrim(te.apellido2),' ',rtrim(te.nombre1),' ',rtrim(te.nombre2)) 
			   as estudiante,tm.id_matric,RIGHT(CONCAT('0000',tm.id_folio),4) id_folio,te.cod_doc,te.sexo,te.dpto_lug_exp,
		      te.mun_lug_exp, te.nro_doc_id,tas.excluir,tas.electiva,te.cod_est,
				RIGHT(CONCAT('0000',tm.nro_matricula),4) nro_matricula,RIGHT(CONCAT('0000',tm.libro_mat),4) libro_mat,tmc.ih,
		      tp.promedio, tp.promedio_rec,tp.prom_comision,tp.msg,tp.msg1,tp.msg2,tp.msg3, tn.nombre_nivel, es.nombre_escala
				FROM areasf AS ta 
				LEFT JOIN cursos AS tc ON ta.id_curso = tc.id
		      LEFT JOIN  matriculas AS tm ON ta.id_matric=tm.id_matric
				LEFT JOIN sedes AS ts ON tm.id_sede=ts.id  
			   LEFT JOIN grados AS tg ON tm.id_grado=tg.id 
				LEFT JOIN jornadas AS tj ON tm.id_jorn=tj.cod_jorn 	
			   LEFT JOIN asignaturas AS tas ON tc.id_asig=tas.id_pk 
		      LEFT JOIN areas AS tar ON tas.id_area=tar.id 
				LEFT JOIN inscripciones AS te ON tm.cod_est=te.cod_est 
				LEFT JOIN matcurso AS tmc ON (tmc.id_asig = tas.id_pk AND tmc.id_grado = tc.id_grado 
				AND tmc.`año` = tc.`año`)
				LEFT JOIN acta_promocion AS tp ON tp.id_matric = ta.id_matric
				LEFT JOIN niveles_estudio AS tn ON tg.id_nivel = tn.id
				LEFT JOIN `desempeños` AS td ON (ta.final BETWEEN td.desde AND td.hasta)
				LEFT JOIN escala_nacional AS es ON td.id_escala = es.id
				LEFT JOIN grados_agrupados AS t1 ON td.id_grado_agrupado = t1.id
				LEFT JOIN aux_grados_agrupados AS t2 ON t2.id_grado_agrupado = t1.id
				WHERE tc.`año` = `_año` AND tc.id_grado = _cod_grado AND tm.año=_año 
				AND tm.id_sede=_id_sede AND tm.id_grado=_cod_grado AND tm.grupo=_grupo 
				AND tm.id_jorn=_id_jorn AND tm.id_estado = 2 AND tm.id_inst = _id_inst
				AND ts.ID_INST = _id_inst  AND tar.id_inst = _id_inst AND tar.estado = 1
				AND tas.id_inst = _id_inst AND tas.estado = 1 
				AND tmc.id_inst = _id_inst AND tmc.`año` = `_año` AND tmc.estado = 1
				AND td.`año` = `_año` AND t2.id_grado = _cod_grado
		      ORDER BY estudiante,tar.ordenar,tar.id,tas.ordenar;
		END IF;
	END IF;
END$$

DROP PROCEDURE IF EXISTS `sp_select_areasf_agrupada`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_select_areasf_agrupada` (IN `_id_inst` INT(30), IN `_año` YEAR, IN `_id_sede` INT(30), IN `_cod_grado` INT(11), IN `_grupo` VARCHAR(2), IN `_id_jorn` INT(1), IN `_id_matic` INT(30))  BEGIN
	DECLARE _ndecim INT DEFAULT 0;
	SELECT tc.Ndecimales INTO _ndecim 
	FROM config001 AS tc 
	LEFT JOIN grados_agrupados AS t1 ON tc.id_grupo_grados = t1.id
	LEFT JOIN aux_grados_agrupados AS t2 ON t2.id_grado_agrupado = t1.id
	WHERE tc.año = _año AND tc.id_inst = _id_inst AND t2.id_grado = _cod_grado LIMIT 1; 
	IF _id_matic > 0 THEN 
		SELECT tm.id_inst,tm.id_sede,tm.id_grado cod_grado,tm.grupo,tj.cod_jorn,tm.año, 
			tas.id_area cod_area,ta.recuperacion,
			ta.faltas,ta.injustificadas,ta.retraso,ta.estado,RTRIM(ts.nom_sede) As sede,tg.grado,tj.jornada,
	      RTRIM(tar.area) area,
		   concat(rtrim(te.apellido1),' ',rtrim(te.apellido2),' ',rtrim(te.nombre1),' ',rtrim(te.nombre2)) 
		   as estudiante,tm.id_matric,RIGHT(CONCAT('0000',tm.id_folio),4) id_folio,te.cod_doc,te.sexo,te.dpto_lug_exp,
	      te.mun_lug_exp, te.nro_doc_id,tas.excluir,tas.electiva,te.cod_est,
			RIGHT(CONCAT('0000',tm.nro_matricula),4) nro_matricula,RIGHT(CONCAT('0000',tm.libro_mat),4) libro_mat,SUM(tmc.ih) ih,
	      tp.promedio, tp.promedio_rec,tp.prom_comision,tp.msg,tp.msg1,tp.msg2,tp.msg3,
	      ROUND(IF(tmc.porciento BETWEEN 1 AND 99,
			SUM(IF(ta.recuperacion > 0,(ta.recuperacion*tmc.porciento)/100,(ta.final*tmc.porciento)/100)),
			AVG(IF(ta.recuperacion > 0, ta.recuperacion, ta.final))),_ndecim) AS final,  es.nombre_escala
			FROM areasf AS ta 
			LEFT JOIN cursos AS tc ON ta.id_curso = tc.id
	      LEFT JOIN matriculas AS tm ON ta.id_matric=tm.id_matric
			LEFT JOIN sedes AS ts ON tm.id_sede=ts.id  
		   LEFT JOIN grados AS tg ON tm.id_grado=tg.id 
			LEFT JOIN jornadas AS tj ON tm.id_jorn=tj.cod_jorn 	
		   LEFT JOIN asignaturas AS tas ON tc.id_asig=tas.id_pk 
	      LEFT JOIN areas AS tar ON tas.id_area=tar.id 
			LEFT JOIN inscripciones AS te ON tm.cod_est=te.cod_est 
			LEFT JOIN matcurso AS tmc ON (tmc.id_asig = tas.id_pk AND tmc.id_grado = tg.id AND 
			tmc.`año` = tc.`año`)
			LEFT JOIN acta_promocion AS tp ON tp.id_matric = ta.id_matric
			LEFT JOIN `desempeños` AS td ON (ta.final BETWEEN td.desde AND td.hasta)
			LEFT JOIN escala_nacional AS es ON td.id_escala = es.id
			LEFT JOIN grados_agrupados AS t1 ON td.id_grado_agrupado = t1.id
			LEFT JOIN aux_grados_agrupados AS t2 ON t2.id_grado_agrupado = t1.id
			WHERE tc.`año` = `_año` AND tc.id_grado = _cod_grado AND 
			tm.año=_año AND tm.id_grado =_cod_grado AND tm.grupo=_grupo
			AND tm.id_jorn=_id_jorn AND tm.id_estado = 2 AND tm.id_inst = _id_inst
			AND tm.id_matric = _id_matic AND tm.id_sede=_id_sede AND ts.ID_INST = _id_inst
			AND tas.id_inst = _id_inst AND tas.estado = 1
			AND tar.id_inst = _id_inst AND tar.estado = 1
			AND tmc.id_inst = _id_inst AND tmc.`año` = `_año` AND tmc.estado = 1
			AND tmc.id_grado = _cod_grado AND td.`año` = `_año` AND t2.id_grado = _cod_grado
			GROUP BY ta.id_matric,tar.id
	      ORDER BY estudiante,tar.ordenar;
	ELSE
		SELECT tm.id_inst,tm.id_sede,tm.id_grado cod_grado,tm.grupo,tj.cod_jorn,tm.año, 
			tas.id_area cod_area,ta.recuperacion,
			ta.faltas,ta.injustificadas,ta.retraso,ta.estado,RTRIM(ts.nom_sede) As sede,tg.grado,tj.jornada,
	      RTRIM(tar.area) area,
		   concat(rtrim(te.apellido1),' ',rtrim(te.apellido2),' ',rtrim(te.nombre1),' ',rtrim(te.nombre2)) 
		   as estudiante,tm.id_matric,RIGHT(CONCAT('0000',tm.id_folio),4) id_folio,te.cod_doc,te.sexo,te.dpto_lug_exp,
	      te.mun_lug_exp, te.nro_doc_id,tas.excluir,tas.electiva,te.cod_est,
			RIGHT(CONCAT('0000',tm.nro_matricula),4) nro_matricula,RIGHT(CONCAT('0000',tm.libro_mat),4) libro_mat,SUM(tmc.ih) ih,
	      tp.promedio, tp.promedio_rec,tp.prom_comision,tp.msg,tp.msg1,tp.msg2,tp.msg3,
	      ROUND(IF(tmc.porciento BETWEEN 1 AND 99,
			SUM(IF(ta.recuperacion > 0,(ta.recuperacion*tmc.porciento)/100,(ta.final*tmc.porciento)/100)),
			AVG(IF(ta.recuperacion > 0, ta.recuperacion, ta.final))),_ndecim) AS final, es.nombre_escala
			FROM areasf AS ta 
			LEFT JOIN cursos AS tc ON ta.id_curso = tc.id
	      LEFT JOIN matriculas AS tm ON ta.id_matric=tm.id_matric
			LEFT JOIN sedes AS ts ON tm.id_sede=ts.id  
		   LEFT JOIN grados AS tg ON tm.id_grado=tg.id 
			LEFT JOIN jornadas AS tj ON tm.id_jorn=tj.cod_jorn 	
		   LEFT JOIN asignaturas AS tas ON tc.id_asig=tas.id_pk 
	      LEFT JOIN areas AS tar ON tas.id_area=tar.id 
			LEFT JOIN inscripciones AS te ON tm.cod_est=te.cod_est 
			LEFT JOIN matcurso AS tmc ON (tmc.id_asig = tas.id_pk AND tmc.id_grado = tg.id AND 
			tmc.`año` = tc.`año`)
			LEFT JOIN acta_promocion AS tp ON tp.id_matric = ta.id_matric
			LEFT JOIN `desempeños` AS td ON (ta.final BETWEEN td.desde AND td.hasta)
			LEFT JOIN escala_nacional AS es ON td.id_escala = es.id
			LEFT JOIN grados_agrupados AS t1 ON td.id_grado_agrupado = t1.id
			LEFT JOIN aux_grados_agrupados AS t2 ON t2.id_grado_agrupado = t1.id
			WHERE tc.`año` = `_año` AND tc.id_grado = _cod_grado AND 
			tm.año=_año AND tm.id_grado =_cod_grado AND tm.grupo=_grupo
			AND tm.id_jorn=_id_jorn AND tm.id_estado = 2 AND tm.id_inst = _id_inst
			AND tm.id_sede=_id_sede AND ts.ID_INST = _id_inst
			AND tas.id_inst = _id_inst AND tas.estado = 1
			AND tar.id_inst = _id_inst AND tar.estado = 1
			AND tmc.id_inst = _id_inst AND tmc.`año` = `_año` AND tmc.estado = 1
			AND tmc.id_grado = _cod_grado AND td.`año` = `_año` AND t2.id_grado = _cod_grado
			GROUP BY ta.id_matric,tar.id
	      ORDER BY estudiante,tar.ordenar;
	END IF;
END$$

DROP PROCEDURE IF EXISTS `sp_select_areasf_grado`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_select_areasf_grado` (IN `_cod_grado` VARCHAR(2) charset utf8, IN `_id_sede` INT(20), IN `_año` YEAR)  BEGIN
	SELECT ta.*,tm.`año`,ts.nom_sede As sede,tg.grado,tj.jornada,tar.area,tas.asignatura,tas.cod_area,tm.id_sede,tm.grupo,
	   concat(rtrim(te.apellido1),' ',rtrim(te.apellido2),' ',rtrim(te.nombre1),' ',rtrim(te.nombre2)) 
	   as estudiantes,tm.id_matric,tm.id_folio,te.cod_doc,te.sexo,te.dpto_lug_exp,tm.id_folio, tm.nro_matricula,
        te.mun_lug_exp, te.nro_doc_id,tas.excluir,tas.electiva,tm.cod_est,tm.cod_grado, tm.id_jorn AS cod_jorn 
		FROM areasf AS ta 
		LEFT JOIN  matriculas AS tm ON ta.id_matric=tm.id_matric
		LEFT JOIN sedes AS ts ON tm.id_sede=ts.id  
	   LEFT JOIN grados AS tg ON tm.cod_grado=tg.cod_grado 
		LEFT JOIN jornadas AS tj ON tm.id_jorn = tj.cod_jorn 	
		LEFT JOIN asignaturas AS tas ON ta.id_asig=tas.id 
		LEFT JOIN areas AS tar ON tas.cod_area = tar.cod_area	  
		LEFT JOIN inscripciones AS te ON tm.cod_est = te.cod_est  
		WHERE tm.id_sede= _id_sede and tm.cod_grado= _cod_grado 
	 	and tm.año=_año AND tar.año=_año AND tas.año=_año  
		ORDER BY tm.cod_grado,tm.id_jorn,tm.grupo,estudiantes,tar.cod_area,ta.id_asig;
END$$

DROP PROCEDURE IF EXISTS `sp_select_bancocli`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_select_bancocli` (IN `_id_inst` INT(20), IN `_cod_grado` VARCHAR(2) charset utf8, IN `_id_asig` INT(2), IN `_periodo` VARCHAR(2) charset utf8, IN `_tipo` INT(1), IN `_limit` TINYINT, IN `_min` INT(6), IN `_max` INT(6))  BEGIN
	if _limit = 1 then
		select tb.*, tg.grado, ta.descripcion AS asignatura from banco_cli AS tb 
		left join grados as tg on tb.cod_grado=tg.cod_grado 
		left join asignaturas_banco as ta on tb.id_asig=ta.id where 
		tb.period=_periodo and tb.cod_grado=_cod_grado and tb.id_ins=_id_inst 
		and tb.id_asig=_id_asig and tb.tipo=_tipo limit _min, _max;
	else 
		select tb.*, tg.grado, ta.descripcion AS asignatura from banco_cli AS tb 
		left join grados as tg on tb.cod_grado=tg.cod_grado 
		left join asignaturas_banco as ta on tb.id_asig=ta.id where 
		tb.period=_periodo and tb.cod_grado=_cod_grado and tb.id_ins=_id_inst 
		and tb.id_asig=_id_asig and tb.tipo=_tipo;
    end if;
END$$

DROP PROCEDURE IF EXISTS `sp_select_boletines`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_select_boletines` (IN `_cod_grado` VARCHAR(2) CHARSET utf8, IN `_grupo` VARCHAR(2) CHARSET utf8, IN `_cod_jorn` INT(1), IN `_id_sede` INT(20), IN `_año` YEAR, IN `_periodo` VARCHAR(1) CHARSET utf8, IN `_id_inst` INT(20))  BEGIN
IF _cod_grado>= '21' AND _cod_grado <='26' THEN 
	SELECT tn.id, tn.id_matric, tm.cod_est, tm.cod_grado, tm.grupo, tm.año, tn.periodo,
	tm.id_jorn, tm.id_sede, tn.id_asig, tn.id_docente,
	tn.notap1, tn.p1, tn.notap2, tn.p2, tn.notap3, tn.p3,
	tn.notap4, tn.p4, tn.nota_perdida, tn.nota_habilitacion, tn.final, tn.faltas, tn.conceptual,
	te.apellido1, te.apellido2, te.nombre1,
	te.nombre2, te.nro_doc_id, tm.estado,
	tar.area, tar.abrev AS abre_area,tar.ordenar AS order_ar, tas.asignatura,
	tas.abrev AS abrev_asig, tas.electiva, tas.cod_area, tas.ordenar AS order_as,
	CONCAT(RTRIM(td.apellido1),' ',RTRIM(td.apellido2),
	RTRIM(td.nombre1),' ',RTRIM(td.nombre2)) as docente,
	ts.nom_sede AS sede, tj.jornada, tg.grado,tm.id_folio
	FROM nscp003 AS tn 
	LEFT JOIN matriculas AS tm ON tn.id_matric=tm.id_matric 
	LEFT JOIN inscripciones AS te ON tm.cod_est=te.cod_est 
	LEFT JOIN asignaturas AS tas ON tn.id_asig=tas.id 
	LEFT JOIN areas AS tar ON tas.cod_area=tar.cod_area 
	LEFT JOIN docentes AS td ON tn.id_docente=td.id_docente 
	LEFT JOIN sedes AS ts ON tm.id_sede=ts.id 
	LEFT JOIN jornadas AS tj ON tm.id_jorn=tj.cod_jorn 
	LEFT JOIN grados As tg ON tm.cod_grado=tg.cod_grado 
	WHERE tm.estado=2 AND tm.grupo=_grupo 
	AND tm.año=_año AND tn.año=_año AND tar.año=_año and tas.año=_año 
	AND tn.id_inst=_Id_inst and te.id_inst=_Id_inst and tas.id_inst=_Id_inst 
	and tar.id_inst=_id_inst and td.id_inst=_Id_inst and tn.final>=0 
	AND tm.cod_grado=_cod_grado AND tm.id_sede=_id_sede AND tm.id_jorn=_cod_jorn 
	AND tn.periodo BETWEEN 1 AND _periodo  
	ORDER BY te.apellido1,te.apellido2,te.nombre1,te.nombre2,tas.cod_area,tn.id_asig;  
ELSEIF _cod_grado>= '01' AND _cod_grado<='05' THEN 
	SELECT tn.id, tn.id_matric, tm.cod_est, tm.cod_grado, tm.grupo, tm.año, tn.periodo,
	tm.id_jorn, tm.id_sede, tn.id_asig, tn.id_docente,
	tn.notap1, tn.p1, tn.notap2, tn.p2, tn.notap3, tn.p3,
	tn.notap4, tn.p4, tn.nota_perdida, tn.nota_habilitacion, tn.final, tn.faltas, tn.conceptual,
	te.apellido1, te.apellido2, te.nombre1,
	te.nombre2, te.nro_doc_id, tm.estado,
	tar.area, tar.abrev AS abre_area,tar.ordenar AS order_ar, tas.asignatura,
	tas.abrev AS abrev_asig, tas.electiva, tas.cod_area, tas.ordenar AS order_as,
	CONCAT(RTRIM(td.apellido1),' ',RTRIM(td.apellido2),
	RTRIM(td.nombre1),' ',RTRIM(td.nombre2)) as docente,
	ts.nom_sede AS sede, tj.jornada, tg.grado,tm.id_folio
	FROM nscp001 AS tn 
	LEFT JOIN matriculas AS tm ON tn.id_matric=tm.id_matric 
	LEFT JOIN inscripciones AS te ON tm.cod_est=te.cod_est 
	LEFT JOIN asignaturas AS tas ON tn.id_asig=tas.id 
	LEFT JOIN areas AS tar ON tas.cod_area=tar.cod_area 
	LEFT JOIN docentes AS td ON tn.id_docente=td.id_docente 
	LEFT JOIN sedes AS ts ON tm.id_sede=ts.id 
	LEFT JOIN jornadas AS tj ON tm.id_jorn=tj.cod_jorn 
	LEFT JOIN grados As tg ON tm.cod_grado=tg.cod_grado 
	WHERE tm.estado=2 AND tm.grupo=_grupo 
	AND tm.año=_año AND tn.año=_año AND tar.año=_año and tas.año=_año 
	AND tn.id_inst=_Id_inst and te.id_inst=_Id_inst and tas.id_inst=_Id_inst 
	and tar.id_inst=_id_inst and td.id_inst=_Id_inst and tn.final>=0 
	AND tm.cod_grado=_cod_grado AND tm.id_sede=_id_sede AND tm.id_jorn=_cod_jorn 
	AND tn.periodo BETWEEN 1 AND _periodo  
	ORDER BY te.apellido1,te.apellido2,te.nombre1,te.nombre2,tas.cod_area,tn.id_asig;  
ELSEIF _cod_grado>= '06' AND _cod_grado<='09' THEN 
	SELECT tn.id, tn.id_matric, tm.cod_est, tm.cod_grado, tm.grupo, tm.año, tn.periodo,
	tm.id_jorn, tm.id_sede, tn.id_asig, tn.id_docente,
	tn.notap1, tn.p1, tn.notap2, tn.p2, tn.notap3, tn.p3,
	tn.notap4, tn.p4, tn.nota_perdida, tn.nota_habilitacion, tn.final, tn.faltas, tn.conceptual,
	te.apellido1, te.apellido2, te.nombre1,
	te.nombre2, te.nro_doc_id, tm.estado,
	tar.area, tar.abrev AS abre_area,tar.ordenar AS order_ar, tas.asignatura,
	tas.abrev AS abrev_asig, tas.electiva, tas.cod_area, tas.ordenar AS order_as,
	CONCAT(RTRIM(td.apellido1),' ',RTRIM(td.apellido2),
	RTRIM(td.nombre1),' ',RTRIM(td.nombre2)) as docente,
	ts.nom_sede AS sede, tj.jornada, tg.grado,tm.id_folio
	FROM nscp002 AS tn 
	LEFT JOIN matriculas AS tm ON tn.id_matric=tm.id_matric 
	LEFT JOIN inscripciones AS te ON tm.cod_est=te.cod_est 
	LEFT JOIN asignaturas AS tas ON tn.id_asig=tas.id 
	LEFT JOIN areas AS tar ON tas.cod_area=tar.cod_area 
	LEFT JOIN docentes AS td ON tn.id_docente=td.id_docente 
	LEFT JOIN sedes AS ts ON tm.id_sede=ts.id 
	LEFT JOIN jornadas AS tj ON tm.id_jorn=tj.cod_jorn 
	LEFT JOIN grados As tg ON tm.cod_grado=tg.cod_grado 
	WHERE tm.estado=2 AND tm.grupo=_grupo 
	AND tm.año=_año AND tn.año=_año AND tar.año=_año and tas.año=_año 
	AND tn.id_inst=_Id_inst and te.id_inst=_Id_inst and tas.id_inst=_Id_inst 
	and tar.id_inst=_id_inst and td.id_inst=_Id_inst and tn.final>=0 
	AND tm.cod_grado=_cod_grado AND tm.id_sede=_id_sede AND tm.id_jorn=_cod_jorn 
	AND tn.periodo BETWEEN 1 AND _periodo  
	ORDER BY te.apellido1,te.apellido2,te.nombre1,te.nombre2,tas.cod_area,tn.id_asig; 
ELSEIF _cod_grado>= '10' AND _cod_grado<='11' THEN 
	SELECT tn.id, tn.id_matric, tm.cod_est, tm.cod_grado, tm.grupo, tm.año, tn.periodo,
	tm.id_jorn, tm.id_sede, tn.id_asig, tn.id_docente,
	tn.notap1, tn.p1, tn.notap2, tn.p2, tn.notap3, tn.p3,
	tn.notap4, tn.p4, tn.nota_perdida, tn.nota_habilitacion, tn.final, tn.faltas, tn.conceptual,
	te.apellido1, te.apellido2, te.nombre1,
	te.nombre2, te.nro_doc_id, tm.estado,
	tar.area, tar.abrev AS abre_area,tar.ordenar AS order_ar, tas.asignatura,
	tas.abrev AS abrev_asig, tas.electiva, tas.cod_area, tas.ordenar AS order_as,
	CONCAT(RTRIM(td.apellido1),' ',RTRIM(td.apellido2),
	RTRIM(td.nombre1),' ',RTRIM(td.nombre2)) as docente,
	ts.nom_sede AS sede, tj.jornada, tg.grado,tm.id_folio
	FROM nscp003 AS tn 
	LEFT JOIN matriculas AS tm ON tn.id_matric=tm.id_matric 
	LEFT JOIN inscripciones AS te ON tm.cod_est=te.cod_est 
	LEFT JOIN asignaturas AS tas ON tn.id_asig=tas.id 
	LEFT JOIN areas AS tar ON tas.cod_area=tar.cod_area 
	LEFT JOIN docentes AS td ON tn.id_docente=td.id_docente 
	LEFT JOIN sedes AS ts ON tm.id_sede=ts.id 
	LEFT JOIN jornadas AS tj ON tm.id_jorn=tj.cod_jorn 
	LEFT JOIN grados As tg ON tm.cod_grado=tg.cod_grado 
	WHERE tm.estado=2 AND tm.grupo=_grupo 
	AND tm.año=_año AND tn.año=_año AND tar.año=_año and tas.año=_año 
	AND tn.id_inst=_Id_inst and te.id_inst=_Id_inst and tas.id_inst=_Id_inst 
	and tar.id_inst=_id_inst and td.id_inst=_Id_inst and tn.final>=0 
	AND tm.cod_grado=_cod_grado AND tm.id_sede=_id_sede AND tm.id_jorn=_cod_jorn 
	AND tn.periodo BETWEEN 1 AND _periodo  
	ORDER BY te.apellido1,te.apellido2,te.nombre1,te.nombre2,tas.cod_area,tn.id_asig; 
ELSEIF _cod_grado = '99' THEN 
	SELECT tn.id, tn.id_matric, tm.cod_est, tm.cod_grado, tm.grupo, tm.año, tn.periodo,
	tm.id_jorn, tm.id_sede, tn.id_asig, tn.id_docente,
	tn.notap1, tn.p1, tn.notap2, tn.p2, tn.notap3, tn.p3,
	tn.notap4, tn.p4, tn.nota_perdida, tn.nota_habilitacion, tn.final, tn.faltas, tn.conceptual,
	te.apellido1, te.apellido2, te.nombre1,
	te.nombre2, te.nro_doc_id, tm.estado,
	tar.area, tar.abrev AS abre_area,tar.ordenar AS order_ar, tas.asignatura,
	tas.abrev AS abrev_asig, tas.electiva, tas.cod_area, tas.ordenar AS order_as,
	CONCAT(RTRIM(td.apellido1),' ',RTRIM(td.apellido2),
	RTRIM(td.nombre1),' ',RTRIM(td.nombre2)) as docente,
	ts.nom_sede AS sede, tj.jornada, tg.grado,tm.id_folio
	FROM nscp003 AS tn 
	LEFT JOIN matriculas AS tm ON tn.id_matric=tm.id_matric 
	LEFT JOIN inscripciones AS te ON tm.cod_est=te.cod_est 
	LEFT JOIN asignaturas AS tas ON tn.id_asig=tas.id 
	LEFT JOIN areas AS tar ON tas.cod_area=tar.cod_area 
	LEFT JOIN docentes AS td ON tn.id_docente=td.id_docente 
	LEFT JOIN sedes AS ts ON tm.id_sede=ts.id 
	LEFT JOIN jornadas AS tj ON tm.id_jorn=tj.cod_jorn 
	LEFT JOIN grados As tg ON tm.cod_grado=tg.cod_grado 
	WHERE tm.estado=2 AND tm.grupo=_grupo 
	AND tm.año=_año AND tn.año=_año AND tar.año=_año and tas.año=_año 
	AND tn.id_inst=_Id_inst and te.id_inst=_Id_inst and tas.id_inst=_Id_inst 
	and tar.id_inst=_id_inst and td.id_inst=_Id_inst and tn.final>=0 
	AND tm.cod_grado=_cod_grado AND tm.id_sede=_id_sede AND tm.id_jorn=_cod_jorn 
	AND tn.periodo BETWEEN 1 AND _periodo  
	ORDER BY te.apellido1,te.apellido2,te.nombre1,te.nombre2,tas.cod_area,tn.id_asig; 
ELSE 
	SELECT tn.id, tn.id_matric, tm.cod_est, tm.cod_grado, tm.grupo, tm.año, tn.periodo,
	tm.id_jorn, tm.id_sede, tn.id_asig, tn.id_docente,
	tn.notap1, tn.p1, tn.notap2, tn.p2, tn.notap3, tn.p3,
	tn.notap4, tn.p4, tn.nota_perdida, tn.nota_habilitacion, tn.final, tn.faltas, tn.conceptual,
	te.apellido1, te.apellido2, te.nombre1,
	te.nombre2, te.nro_doc_id, tm.estado,
	tar.area, tar.abrev AS abre_area,tar.ordenar AS order_ar, tas.asignatura,
	tas.abrev AS abrev_asig, tas.electiva, tas.cod_area, tas.ordenar AS order_as,
	CONCAT(RTRIM(td.apellido1),' ',RTRIM(td.apellido2),
	RTRIM(td.nombre1),' ',RTRIM(td.nombre2)) as docente,
	ts.nom_sede AS sede, tj.jornada, tg.grado,tm.id_folio
	FROM nscp00 AS tn 
	LEFT JOIN matriculas AS tm ON tn.id_matric=tm.id_matric 
	LEFT JOIN inscripciones AS te ON tm.cod_est=te.cod_est 
	LEFT JOIN asignaturas AS tas ON tn.id_asig=tas.id 
	LEFT JOIN areas AS tar ON tas.cod_area=tar.cod_area 
	LEFT JOIN docentes AS td ON tn.id_docente=td.id_docente 
	LEFT JOIN sedes AS ts ON tm.id_sede=ts.id 
	LEFT JOIN jornadas AS tj ON tm.id_jorn=tj.cod_jorn 
	LEFT JOIN grados As tg ON tm.cod_grado=tg.cod_grado 
	WHERE tm.estado=2 AND tm.grupo=_grupo 
	AND tm.año=_año AND tn.año=_año AND tar.año=_año and tas.año=_año 
	AND tn.id_inst=_Id_inst and te.id_inst=_Id_inst and tas.id_inst=_Id_inst 
	and tar.id_inst=_id_inst and td.id_inst=_Id_inst and tn.final>=0 
	AND tm.cod_grado=_cod_grado AND tm.id_sede=_id_sede AND tm.id_jorn=_cod_jorn 
	AND tn.periodo BETWEEN 1 AND _periodo  
	ORDER BY te.apellido1,te.apellido2,te.nombre1,te.nombre2,tas.cod_area,tn.id_asig; 
END IF;
END$$

DROP PROCEDURE IF EXISTS `sp_select_boletin_final`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_select_boletin_final` (IN `_cod_grado` VARCHAR(2) CHARSET utf8, IN `_grupo` VARCHAR(2) CHARSET utf8, IN `_cod_jorn` INT(1), IN `_id_sede` INT(20), IN `_año` YEAR, IN `_periodo` VARCHAR(1) CHARSET utf8, IN `_id_inst` INT(20))  BEGIN
IF _cod_grado>= '21' AND _cod_grado <='26' THEN 
	SELECT tn.id, tn.id_matric, tm.cod_est, tm.cod_grado, tm.grupo, tm.año, tn.periodo,
	tm.id_jorn, tm.id_sede, tn.id_asig, tn.id_docente,
	tn.notap1, tn.p1, tn.notap2, tn.p2, tn.notap3, tn.p3,
	tn.notap4, tn.p4, tn.nota_perdida, tn.nota_habilitacion, tn.final, tn.faltas, tn.conceptual,
	te.apellido1, te.apellido2, te.nombre1,
	te.nombre2, te.nro_doc_id, tm.estado,
	tar.area, tar.abrev AS abre_area,tar.ordenar AS order_ar, tas.asignatura,
	tas.abrev AS abrev_asig, tas.electiva, tas.cod_area, tas.ordenar AS order_as,
	CONCAT(RTRIM(td.apellido1),' ',RTRIM(td.apellido2),
	RTRIM(td.nombre1),' ',RTRIM(td.nombre2)) as docente,
	ts.nom_sede AS sede, tj.jornada, tg.grado,tm.id_folio
	FROM nscp003 AS tn 
	LEFT JOIN matriculas AS tm ON tn.id_matric=tm.id_matric 
	LEFT JOIN inscripciones AS te ON tm.cod_est=te.cod_est 
	LEFT JOIN asignaturas AS tas ON tn.id_asig=tas.id 
	LEFT JOIN areas AS tar ON tas.cod_area=tar.cod_area 
	LEFT JOIN docentes AS td ON tn.id_docente=td.id_docente 
	LEFT JOIN sedes AS ts ON tm.id_sede=ts.id 
	LEFT JOIN jornadas AS tj ON tm.id_jorn=tj.cod_jorn 
	LEFT JOIN grados As tg ON tm.cod_grado=tg.cod_grado 
	WHERE tm.estado=2 AND tm.grupo=_grupo 
	AND tm.año=_año AND tn.año=_año AND tar.año=_año and tas.año=_año 
	AND tn.id_inst=_Id_inst and te.id_inst=_Id_inst and tas.id_inst=_Id_inst 
	and tar.id_inst=_id_inst and td.id_inst=_Id_inst and tn.final>=0 
	AND tm.cod_grado=_cod_grado AND tm.id_sede=_id_sede AND tm.id_jorn=_cod_jorn 
	AND tn.periodo BETWEEN 1 AND _periodo  
	ORDER BY te.apellido1,te.apellido2,te.nombre1,te.nombre2,tas.cod_area,tn.id_asig;  
ELSEIF _cod_grado>= '01' AND _cod_grado<='05' THEN 
	SELECT tn.id, tn.id_matric, tm.cod_est, tm.cod_grado, tm.grupo, tm.año, tn.periodo,
	tm.id_jorn, tm.id_sede, tn.id_asig, tn.id_docente,
	tn.notap1, tn.p1, tn.notap2, tn.p2, tn.notap3, tn.p3,
	tn.notap4, tn.p4, tn.nota_perdida, tn.nota_habilitacion, tn.final, tn.faltas, tn.conceptual,
	te.apellido1, te.apellido2, te.nombre1,
	te.nombre2, te.nro_doc_id, tm.estado,
	tar.area, tar.abrev AS abre_area,tar.ordenar AS order_ar, tas.asignatura,
	tas.abrev AS abrev_asig, tas.electiva, tas.cod_area, tas.ordenar AS order_as,
	CONCAT(RTRIM(td.apellido1),' ',RTRIM(td.apellido2),
	RTRIM(td.nombre1),' ',RTRIM(td.nombre2)) as docente,
	ts.nom_sede AS sede, tj.jornada, tg.grado,tm.id_folio
	FROM nscp001 AS tn 
	LEFT JOIN matriculas AS tm ON tn.id_matric=tm.id_matric 
	LEFT JOIN inscripciones AS te ON tm.cod_est=te.cod_est 
	LEFT JOIN asignaturas AS tas ON tn.id_asig=tas.id 
	LEFT JOIN areas AS tar ON tas.cod_area=tar.cod_area 
	LEFT JOIN docentes AS td ON tn.id_docente=td.id_docente 
	LEFT JOIN sedes AS ts ON tm.id_sede=ts.id 
	LEFT JOIN jornadas AS tj ON tm.id_jorn=tj.cod_jorn 
	LEFT JOIN grados As tg ON tm.cod_grado=tg.cod_grado 
	WHERE tm.estado=2 AND tm.grupo=_grupo 
	AND tm.año=_año AND tn.año=_año AND tar.año=_año and tas.año=_año 
	AND tn.id_inst=_Id_inst and te.id_inst=_Id_inst and tas.id_inst=_Id_inst 
	and tar.id_inst=_id_inst and td.id_inst=_Id_inst and tn.final>=0 
	AND tm.cod_grado=_cod_grado AND tm.id_sede=_id_sede AND tm.id_jorn=_cod_jorn 
	AND tn.periodo BETWEEN 1 AND _periodo  
	ORDER BY te.apellido1,te.apellido2,te.nombre1,te.nombre2,tas.cod_area,tn.id_asig;  
ELSEIF _cod_grado>= '06' AND _cod_grado<='09' THEN 
	SELECT tn.id, tn.id_matric, tm.cod_est, tm.cod_grado, tm.grupo, tm.año, tn.periodo,
	tm.id_jorn, tm.id_sede, tn.id_asig, tn.id_docente,
	tn.notap1, tn.p1, tn.notap2, tn.p2, tn.notap3, tn.p3,
	tn.notap4, tn.p4, tn.nota_perdida, tn.nota_habilitacion, tn.final, tn.faltas, tn.conceptual,
	te.apellido1, te.apellido2, te.nombre1,
	te.nombre2, te.nro_doc_id, tm.estado,
	tar.area, tar.abrev AS abre_area,tar.ordenar AS order_ar, tas.asignatura,
	tas.abrev AS abrev_asig, tas.electiva, tas.cod_area, tas.ordenar AS order_as,
	CONCAT(RTRIM(td.apellido1),' ',RTRIM(td.apellido2),
	RTRIM(td.nombre1),' ',RTRIM(td.nombre2)) as docente,
	ts.nom_sede AS sede, tj.jornada, tg.grado,tm.id_folio
	FROM nscp002 AS tn 
	LEFT JOIN matriculas AS tm ON tn.id_matric=tm.id_matric 
	LEFT JOIN inscripciones AS te ON tm.cod_est=te.cod_est 
	LEFT JOIN asignaturas AS tas ON tn.id_asig=tas.id 
	LEFT JOIN areas AS tar ON tas.cod_area=tar.cod_area 
	LEFT JOIN docentes AS td ON tn.id_docente=td.id_docente 
	LEFT JOIN sedes AS ts ON tm.id_sede=ts.id 
	LEFT JOIN jornadas AS tj ON tm.id_jorn=tj.cod_jorn 
	LEFT JOIN grados As tg ON tm.cod_grado=tg.cod_grado 
	WHERE tm.estado=2 AND tm.grupo=_grupo 
	AND tm.año=_año AND tn.año=_año AND tar.año=_año and tas.año=_año 
	AND tn.id_inst=_Id_inst and te.id_inst=_Id_inst and tas.id_inst=_Id_inst 
	and tar.id_inst=_id_inst and td.id_inst=_Id_inst and tn.final>=0 
	AND tm.cod_grado=_cod_grado AND tm.id_sede=_id_sede AND tm.id_jorn=_cod_jorn 
	AND tn.periodo BETWEEN 1 AND _periodo  
	ORDER BY te.apellido1,te.apellido2,te.nombre1,te.nombre2,tas.cod_area,tn.id_asig; 
ELSEIF _cod_grado>= '10' AND _cod_grado<='11' THEN 
	SELECT tn.id, tn.id_matric, tm.cod_est, tm.cod_grado, tm.grupo, tm.año, tn.periodo,
	tm.id_jorn, tm.id_sede, tn.id_asig, tn.id_docente,
	tn.notap1, tn.p1, tn.notap2, tn.p2, tn.notap3, tn.p3,
	tn.notap4, tn.p4, tn.nota_perdida, tn.nota_habilitacion, tn.final, tn.faltas, tn.conceptual,
	te.apellido1, te.apellido2, te.nombre1,
	te.nombre2, te.nro_doc_id, tm.estado,
	tar.area, tar.abrev AS abre_area,tar.ordenar AS order_ar, tas.asignatura,
	tas.abrev AS abrev_asig, tas.electiva, tas.cod_area, tas.ordenar AS order_as,
	CONCAT(RTRIM(td.apellido1),' ',RTRIM(td.apellido2),
	RTRIM(td.nombre1),' ',RTRIM(td.nombre2)) as docente,
	ts.nom_sede AS sede, tj.jornada, tg.grado,tm.id_folio
	FROM nscp003 AS tn 
	LEFT JOIN matriculas AS tm ON tn.id_matric=tm.id_matric 
	LEFT JOIN inscripciones AS te ON tm.cod_est=te.cod_est 
	LEFT JOIN asignaturas AS tas ON tn.id_asig=tas.id 
	LEFT JOIN areas AS tar ON tas.cod_area=tar.cod_area 
	LEFT JOIN docentes AS td ON tn.id_docente=td.id_docente 
	LEFT JOIN sedes AS ts ON tm.id_sede=ts.id 
	LEFT JOIN jornadas AS tj ON tm.id_jorn=tj.cod_jorn 
	LEFT JOIN grados As tg ON tm.cod_grado=tg.cod_grado 
	WHERE tm.estado=2 AND tm.grupo=_grupo 
	AND tm.año=_año AND tn.año=_año AND tar.año=_año and tas.año=_año 
	AND tn.id_inst=_Id_inst and te.id_inst=_Id_inst and tas.id_inst=_Id_inst 
	and tar.id_inst=_id_inst and td.id_inst=_Id_inst and tn.final>=0 
	AND tm.cod_grado=_cod_grado AND tm.id_sede=_id_sede AND tm.id_jorn=_cod_jorn 
	AND tn.periodo BETWEEN 1 AND _periodo  
	ORDER BY te.apellido1,te.apellido2,te.nombre1,te.nombre2,tas.cod_area,tn.id_asig; 
ELSEIF _cod_grado = '99' THEN 
	SELECT tn.id, tn.id_matric, tm.cod_est, tm.cod_grado, tm.grupo, tm.año, tn.periodo,
	tm.id_jorn, tm.id_sede, tn.id_asig, tn.id_docente,
	tn.notap1, tn.p1, tn.notap2, tn.p2, tn.notap3, tn.p3,
	tn.notap4, tn.p4, tn.nota_perdida, tn.nota_habilitacion, tn.final, tn.faltas, tn.conceptual,
	te.apellido1, te.apellido2, te.nombre1,
	te.nombre2, te.nro_doc_id, tm.estado,
	tar.area, tar.abrev AS abre_area,tar.ordenar AS order_ar, tas.asignatura,
	tas.abrev AS abrev_asig, tas.electiva, tas.cod_area, tas.ordenar AS order_as,
	CONCAT(RTRIM(td.apellido1),' ',RTRIM(td.apellido2),
	RTRIM(td.nombre1),' ',RTRIM(td.nombre2)) as docente,
	ts.nom_sede AS sede, tj.jornada, tg.grado,tm.id_folio
	FROM nscp003 AS tn 
	LEFT JOIN matriculas AS tm ON tn.id_matric=tm.id_matric 
	LEFT JOIN inscripciones AS te ON tm.cod_est=te.cod_est 
	LEFT JOIN asignaturas AS tas ON tn.id_asig=tas.id 
	LEFT JOIN areas AS tar ON tas.cod_area=tar.cod_area 
	LEFT JOIN docentes AS td ON tn.id_docente=td.id_docente 
	LEFT JOIN sedes AS ts ON tm.id_sede=ts.id 
	LEFT JOIN jornadas AS tj ON tm.id_jorn=tj.cod_jorn 
	LEFT JOIN grados As tg ON tm.cod_grado=tg.cod_grado 
	WHERE tm.estado=2 AND tm.grupo=_grupo 
	AND tm.año=_año AND tn.año=_año AND tar.año=_año and tas.año=_año 
	AND tn.id_inst=_Id_inst and te.id_inst=_Id_inst and tas.id_inst=_Id_inst 
	and tar.id_inst=_id_inst and td.id_inst=_Id_inst and tn.final>=0 
	AND tm.cod_grado=_cod_grado AND tm.id_sede=_id_sede AND tm.id_jorn=_cod_jorn 
	AND tn.periodo BETWEEN 1 AND _periodo  
	ORDER BY te.apellido1,te.apellido2,te.nombre1,te.nombre2,tas.cod_area,tn.id_asig; 
ELSE 
	SELECT tn.id, tn.id_matric, tm.cod_est, tm.cod_grado, tm.grupo, tm.año, tn.periodo,
	tm.id_jorn, tm.id_sede, tn.id_asig, tn.id_docente,
	tn.notap1, tn.p1, tn.notap2, tn.p2, tn.notap3, tn.p3,
	tn.notap4, tn.p4, tn.nota_perdida, tn.nota_habilitacion, tn.final, tn.faltas, tn.conceptual,
	te.apellido1, te.apellido2, te.nombre1,
	te.nombre2, te.nro_doc_id, tm.estado,
	tar.area, tar.abrev AS abre_area,tar.ordenar AS order_ar, tas.asignatura,
	tas.abrev AS abrev_asig, tas.electiva, tas.cod_area, tas.ordenar AS order_as,
	CONCAT(RTRIM(td.apellido1),' ',RTRIM(td.apellido2),
	RTRIM(td.nombre1),' ',RTRIM(td.nombre2)) as docente,
	ts.nom_sede AS sede, tj.jornada, tg.grado,tm.id_folio
	FROM nscp00 AS tn 
	LEFT JOIN matriculas AS tm ON tn.id_matric=tm.id_matric 
	LEFT JOIN inscripciones AS te ON tm.cod_est=te.cod_est 
	LEFT JOIN asignaturas AS tas ON tn.id_asig=tas.id 
	LEFT JOIN areas AS tar ON tas.cod_area=tar.cod_area 
	LEFT JOIN docentes AS td ON tn.id_docente=td.id_docente 
	LEFT JOIN sedes AS ts ON tm.id_sede=ts.id 
	LEFT JOIN jornadas AS tj ON tm.id_jorn=tj.cod_jorn 
	LEFT JOIN grados As tg ON tm.cod_grado=tg.cod_grado 
	WHERE tm.estado=2 AND tm.grupo=_grupo 
	AND tm.año=_año AND tn.año=_año AND tar.año=_año and tas.año=_año 
	AND tn.id_inst=_Id_inst and te.id_inst=_Id_inst and tas.id_inst=_Id_inst 
	and tar.id_inst=_id_inst and td.id_inst=_Id_inst and tn.final>=0 
	AND tm.cod_grado=_cod_grado AND tm.id_sede=_id_sede AND tm.id_jorn=_cod_jorn 
	AND tn.periodo = _periodo  
	ORDER BY te.apellido1,te.apellido2,te.nombre1,te.nombre2,tas.cod_area,tn.id_asig; 
END IF;
END$$

DROP PROCEDURE IF EXISTS `sp_select_boletin_final_est`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_select_boletin_final_est` (IN `_cod_grado` VARCHAR(2) CHARSET utf8, IN `_grupo` VARCHAR(2) CHARSET utf8, IN `_cod_jorn` INT(1), IN `_id_sede` INT(20), IN `_año` YEAR, IN `_periodo` VARCHAR(1) CHARSET utf8, IN `_id_inst` INT(20), IN `_cod_est` INT(20))  BEGIN
IF _cod_grado>= '21' AND _cod_grado<='26' THEN 
	SELECT tn.cod_est,tm.id_matric, tn.cod_grado, tn.grupo, tm.año, tn.periodo,
			tn.cod_jorn, tn.id_sede, tn.id_asig, tn.id_docente,
			tn.id_logro, tn.id_logro1, tn.id_logro2, tn.id_sugerencia,
			tn.ind1, tn.ind2, tn.ind3, tn.ind4, tn.ind5, tn.ind6,
			tn.ind7, tn.ind8, tn.ind9, tn.ind10, tn.ind11, tn.ind12,
			tn.notap1, tn.p1, tn.notap2, tn.p2, tn.notap3, tn.p3,
			tn.notap4, tn.p4, tn.nota_perdida, tn.nota_habilitacion, tn.final, tn.faltas, tn.conceptual,
			te.apellido1, te.apellido2, te.nombre1,
			te.nombre2, te.nro_doc_id, tm.estado,
			tar.area, tar.abrev AS abre_area,tar.ordenar AS order_ar, tas.des_asign AS asignatura,
			tas.abrv AS abrev_asig, tas.electiva, tas.cod_area, tas.ordenar AS order_as,
			CONCAT(RTRIM(td.apellido1),' ',RTRIM(td.apellido2),
			RTRIM(td.nombre1),' ',RTRIM(td.nombre2)) as docente,
			ts.nom_sede AS sede, tj.jornada, tg.grado,tm.id_folio,
			tn.tipo_sug,tn.id_obser,
			tn.tipo_ind1, tn.tipo_ind2, tn.tipo_ind3, tn.tipo_ind4, tn.tipo_ind5, tn.tipo_ind6,
			tn.tipo_ind7, tn.tipo_ind8, tn.tipo_ind9, tn.tipo_ind10, tn.tipo_ind11, tn.tipo_ind12 
			FROM scp0011 AS tn LEFT JOIN inscripciones AS te ON te.cod_est=
			tn.cod_est LEFT JOIN matriculas AS tm on tm.cod_est=te.cod_est 
			LEFT JOIN asignaturas AS tas ON tn.id_asig=tas.cod_asign 
		    LEFT JOIN areas AS tar ON tas.cod_area=tar.cod_area LEFT JOIN docentes AS td ON 
		    td.id_docente=tn.id_docente LEFT JOIN sedes AS ts ON tn.id_sede=ts.id 
		    LEFT JOIN jornadas AS tj ON tn.cod_jorn=tj.cod_jorn 
		    LEFT JOIN grados As tg ON tn.cod_grado=tg.cod_grado 
			WHERE tm.estado=2 AND tn.grupo=_grupo 
			AND tn.cod_grado=tm.cod_grado AND tn.id_sede=tm.id_sede 
			AND tm.año=_año AND tn.año=_año AND tn.cod_jorn=tm.id_jorn 
			AND tar.año=_año and tas.año=_año AND tn.id_inst=_Id_inst 
			and te.id_inst=_Id_inst and tas.id_inst=_Id_inst 
			and tar.id_inst=_id_inst and td.id_inst=_Id_inst 
			HAVING tn.final>=0 AND tm.estado=2 AND tn.grupo=_grupo 
			AND tn.cod_grado=_cod_grado AND tn.id_sede=_id_sede 
			AND tm.año=_año AND tn.cod_jorn=_cod_jorn 
			AND tn.periodo =_periodo AND tn.cod_est=_cod_est 
			ORDER BY te.apellido1,te.apellido2,te.nombre1,te.nombre2,tas.cod_area,tn.id_asig; 
ELSE  
	CASE _cod_grado 
		WHEN '01' THEN 
			SELECT tn.cod_est,tm.id_matric, tn.cod_grado, tn.grupo, tm.año, tn.periodo,
			tn.cod_jorn, tn.id_sede, tn.id_asig, tn.id_docente,
			tn.id_logro, tn.id_logro1, tn.id_logro2, tn.id_sugerencia,
			tn.ind1, tn.ind2, tn.ind3, tn.ind4, tn.ind5, tn.ind6,
			tn.ind7, tn.ind8, tn.ind9, tn.ind10, tn.ind11, tn.ind12,
			tn.notap1, tn.p1, tn.notap2, tn.p2, tn.notap3, tn.p3,
			tn.notap4, tn.p4, tn.nota_perdida, tn.nota_habilitacion, tn.final, tn.faltas, tn.conceptual,
			te.apellido1, te.apellido2, te.nombre1,
			te.nombre2, te.nro_doc_id, tm.estado,
			tar.area, tar.abrev AS abre_area,tar.ordenar AS order_ar, tas.des_asign AS asignatura,
			tas.abrv AS abrev_asig, tas.electiva, tas.cod_area, tas.ordenar AS order_as,
			CONCAT(RTRIM(td.apellido1),' ',RTRIM(td.apellido2),
			RTRIM(td.nombre1),' ',RTRIM(td.nombre2)) as docente,
			ts.nom_sede AS sede, tj.jornada, tg.grado,tm.id_folio,
			tn.tipo_sug,tn.id_obser,
			tn.tipo_ind1, tn.tipo_ind2, tn.tipo_ind3, tn.tipo_ind4, tn.tipo_ind5, tn.tipo_ind6,
			tn.tipo_ind7, tn.tipo_ind8, tn.tipo_ind9, tn.tipo_ind10, tn.tipo_ind11, tn.tipo_ind12 
			FROM scp001 AS tn LEFT JOIN inscripciones AS te ON te.cod_est=
			tn.cod_est LEFT JOIN matriculas AS tm on tm.cod_est=te.cod_est 
			LEFT JOIN asignaturas AS tas ON tn.id_asig=tas.cod_asign 
		    LEFT JOIN areas AS tar ON tas.cod_area=tar.cod_area LEFT JOIN docentes AS td ON 
		    td.id_docente=tn.id_docente LEFT JOIN sedes AS ts ON tn.id_sede=ts.id 
		    LEFT JOIN jornadas AS tj ON tn.cod_jorn=tj.cod_jorn 
		    LEFT JOIN grados As tg ON tn.cod_grado=tg.cod_grado 
			WHERE tm.estado=2 AND tn.grupo=_grupo 
			AND tn.cod_grado=tm.cod_grado AND tn.id_sede=tm.id_sede 
			AND tm.año=_año AND tn.año=_año AND tn.cod_jorn=tm.id_jorn 
			AND tar.año=_año and tas.año=_año AND tn.id_inst=_Id_inst 
			and te.id_inst=_Id_inst and tas.id_inst=_Id_inst 
			and tar.id_inst=_id_inst and td.id_inst=_Id_inst 
			HAVING tn.final>=0 AND tm.estado=2 AND tn.grupo=_grupo 
			AND tn.cod_grado=_cod_grado AND tn.id_sede=_id_sede 
			AND tm.año=_año AND tn.cod_jorn=_cod_jorn 
			AND tn.periodo = _periodo AND tn.cod_est=_cod_est 
			ORDER BY te.apellido1,te.apellido2,te.nombre1,te.nombre2,tas.cod_area,tn.id_asig; 
		WHEN '02' THEN 
			SELECT tn.cod_est,tm.id_matric, tn.cod_grado, tn.grupo, tm.año, tn.periodo,
			tn.cod_jorn, tn.id_sede, tn.id_asig, tn.id_docente,
			tn.id_logro, tn.id_logro1, tn.id_logro2, tn.id_sugerencia,
			tn.ind1, tn.ind2, tn.ind3, tn.ind4, tn.ind5, tn.ind6,
			tn.ind7, tn.ind8, tn.ind9, tn.ind10, tn.ind11, tn.ind12,
			tn.notap1, tn.p1, tn.notap2, tn.p2, tn.notap3, tn.p3,
			tn.notap4, tn.p4, tn.nota_perdida, tn.nota_habilitacion, tn.final, tn.faltas, tn.conceptual,
			te.apellido1, te.apellido2, te.nombre1,
			te.nombre2, te.nro_doc_id, tm.estado,
			tar.area, tar.abrev AS abre_area,tar.ordenar AS order_ar, tas.des_asign AS asignatura,
			tas.abrv AS abrev_asig, tas.electiva, tas.cod_area, tas.ordenar AS order_as,
			CONCAT(RTRIM(td.apellido1),' ',RTRIM(td.apellido2),
			RTRIM(td.nombre1),' ',RTRIM(td.nombre2)) as docente,
			ts.nom_sede AS sede, tj.jornada, tg.grado,tm.id_folio,
			tn.tipo_sug,tn.id_obser,
			tn.tipo_ind1, tn.tipo_ind2, tn.tipo_ind3, tn.tipo_ind4, tn.tipo_ind5, tn.tipo_ind6,
			tn.tipo_ind7, tn.tipo_ind8, tn.tipo_ind9, tn.tipo_ind10, tn.tipo_ind11, tn.tipo_ind12 
			FROM scp002 AS tn LEFT JOIN inscripciones AS te ON te.cod_est=
			tn.cod_est LEFT JOIN matriculas AS tm on tm.cod_est=te.cod_est 
			LEFT JOIN asignaturas AS tas ON tn.id_asig=tas.cod_asign 
		    LEFT JOIN areas AS tar ON tas.cod_area=tar.cod_area LEFT JOIN docentes AS td ON 
		    td.id_docente=tn.id_docente LEFT JOIN sedes AS ts ON tn.id_sede=ts.id 
		    LEFT JOIN jornadas AS tj ON tn.cod_jorn=tj.cod_jorn 
		    LEFT JOIN grados As tg ON tn.cod_grado=tg.cod_grado 
			WHERE tm.estado=2 AND tn.grupo=_grupo 
			AND tn.cod_grado=tm.cod_grado AND tn.id_sede=tm.id_sede 
			AND tm.año=_año AND tn.año=_año AND tn.cod_jorn=tm.id_jorn 
			AND tar.año=_año and tas.año=_año AND tn.id_inst=_Id_inst 
			and te.id_inst=_Id_inst and tas.id_inst=_Id_inst 
			and tar.id_inst=_id_inst and td.id_inst=_Id_inst 
			HAVING tn.final>=0 AND tm.estado=2 AND tn.grupo=_grupo 
			AND tn.cod_grado=_cod_grado AND tn.id_sede=_id_sede 
			AND tm.año=_año AND tn.cod_jorn=_cod_jorn 
			AND tn.periodo = _periodo AND tn.cod_est=_cod_est 
			ORDER BY te.apellido1,te.apellido2,te.nombre1,te.nombre2,tas.cod_area,tn.id_asig; 
		WHEN '03' THEN 
			SELECT tn.cod_est,tm.id_matric, tn.cod_grado, tn.grupo, tm.año, tn.periodo,
			tn.cod_jorn, tn.id_sede, tn.id_asig, tn.id_docente,
			tn.id_logro, tn.id_logro1, tn.id_logro2, tn.id_sugerencia,
			tn.ind1, tn.ind2, tn.ind3, tn.ind4, tn.ind5, tn.ind6,
			tn.ind7, tn.ind8, tn.ind9, tn.ind10, tn.ind11, tn.ind12,
			tn.notap1, tn.p1, tn.notap2, tn.p2, tn.notap3, tn.p3,
			tn.notap4, tn.p4, tn.nota_perdida, tn.nota_habilitacion, tn.final, tn.faltas, tn.conceptual,
			te.apellido1, te.apellido2, te.nombre1,
			te.nombre2, te.nro_doc_id, tm.estado,
			tar.area, tar.abrev AS abre_area,tar.ordenar AS order_ar, tas.des_asign AS asignatura,
			tas.abrv AS abrev_asig, tas.electiva, tas.cod_area, tas.ordenar AS order_as,
			CONCAT(RTRIM(td.apellido1),' ',RTRIM(td.apellido2),
			RTRIM(td.nombre1),' ',RTRIM(td.nombre2)) as docente,
			ts.nom_sede AS sede, tj.jornada, tg.grado,tm.id_folio,
			tn.tipo_sug,tn.id_obser,
			tn.tipo_ind1, tn.tipo_ind2, tn.tipo_ind3, tn.tipo_ind4, tn.tipo_ind5, tn.tipo_ind6,
			tn.tipo_ind7, tn.tipo_ind8, tn.tipo_ind9, tn.tipo_ind10, tn.tipo_ind11, tn.tipo_ind12 
			FROM scp003 AS tn LEFT JOIN inscripciones AS te ON te.cod_est=
			tn.cod_est LEFT JOIN matriculas AS tm on tm.cod_est=te.cod_est 
			LEFT JOIN asignaturas AS tas ON tn.id_asig=tas.cod_asign 
		    LEFT JOIN areas AS tar ON tas.cod_area=tar.cod_area LEFT JOIN docentes AS td ON 
		    td.id_docente=tn.id_docente LEFT JOIN sedes AS ts ON tn.id_sede=ts.id 
		    LEFT JOIN jornadas AS tj ON tn.cod_jorn=tj.cod_jorn 
		    LEFT JOIN grados As tg ON tn.cod_grado=tg.cod_grado 
			WHERE tm.estado=2 AND tn.grupo=_grupo 
			AND tn.cod_grado=tm.cod_grado AND tn.id_sede=tm.id_sede 
			AND tm.año=_año AND tn.año=_año AND tn.cod_jorn=tm.id_jorn 
			AND tar.año=_año and tas.año=_año AND tn.id_inst=_Id_inst 
			and te.id_inst=_Id_inst and tas.id_inst=_Id_inst 
			and tar.id_inst=_id_inst and td.id_inst=_Id_inst 
			HAVING tn.final>=0 AND tm.estado=2 AND tn.grupo=_grupo 
			AND tn.cod_grado=_cod_grado AND tn.id_sede=_id_sede 
			AND tm.año=_año AND tn.cod_jorn=_cod_jorn 
			AND tn.periodo = _periodo AND tn.cod_est=_cod_est 
			ORDER BY te.apellido1,te.apellido2,te.nombre1,te.nombre2,tas.cod_area,tn.id_asig; 
		WHEN '04' THEN 
			SELECT tn.cod_est,tm.id_matric, tn.cod_grado, tn.grupo, tm.año, tn.periodo,
			tn.cod_jorn, tn.id_sede, tn.id_asig, tn.id_docente,
			tn.id_logro, tn.id_logro1, tn.id_logro2, tn.id_sugerencia,
			tn.ind1, tn.ind2, tn.ind3, tn.ind4, tn.ind5, tn.ind6,
			tn.ind7, tn.ind8, tn.ind9, tn.ind10, tn.ind11, tn.ind12,
			tn.notap1, tn.p1, tn.notap2, tn.p2, tn.notap3, tn.p3,
			tn.notap4, tn.p4, tn.nota_perdida, tn.nota_habilitacion, tn.final, tn.faltas, tn.conceptual,
			te.apellido1, te.apellido2, te.nombre1,
			te.nombre2, te.nro_doc_id, tm.estado,
			tar.area, tar.abrev AS abre_area,tar.ordenar AS order_ar, tas.des_asign AS asignatura,
			tas.abrv AS abrev_asig, tas.electiva, tas.cod_area, tas.ordenar AS order_as,
			CONCAT(RTRIM(td.apellido1),' ',RTRIM(td.apellido2),
			RTRIM(td.nombre1),' ',RTRIM(td.nombre2)) as docente,
			ts.nom_sede AS sede, tj.jornada, tg.grado,tm.id_folio,
			tn.tipo_sug,tn.id_obser,
			tn.tipo_ind1, tn.tipo_ind2, tn.tipo_ind3, tn.tipo_ind4, tn.tipo_ind5, tn.tipo_ind6,
			tn.tipo_ind7, tn.tipo_ind8, tn.tipo_ind9, tn.tipo_ind10, tn.tipo_ind11, tn.tipo_ind12 
			FROM scp004 AS tn LEFT JOIN inscripciones AS te ON te.cod_est=
			tn.cod_est LEFT JOIN matriculas AS tm on tm.cod_est=te.cod_est 
			LEFT JOIN asignaturas AS tas ON tn.id_asig=tas.cod_asign 
		    LEFT JOIN areas AS tar ON tas.cod_area=tar.cod_area LEFT JOIN docentes AS td ON 
		    td.id_docente=tn.id_docente LEFT JOIN sedes AS ts ON tn.id_sede=ts.id 
		    LEFT JOIN jornadas AS tj ON tn.cod_jorn=tj.cod_jorn 
		    LEFT JOIN grados As tg ON tn.cod_grado=tg.cod_grado 
			WHERE tm.estado=2 AND tn.grupo=_grupo 
			AND tn.cod_grado=tm.cod_grado AND tn.id_sede=tm.id_sede 
			AND tm.año=_año AND tn.año=_año AND tn.cod_jorn=tm.id_jorn 
			AND tar.año=_año and tas.año=_año AND tn.id_inst=_Id_inst 
			and te.id_inst=_Id_inst and tas.id_inst=_Id_inst 
			and tar.id_inst=_id_inst and td.id_inst=_Id_inst 
			HAVING tn.final>=0 AND tm.estado=2 AND tn.grupo=_grupo 
			AND tn.cod_grado=_cod_grado AND tn.id_sede=_id_sede 
			AND tm.año=_año AND tn.cod_jorn=_cod_jorn 
			AND tn.periodo = _periodo AND tn.cod_est=_cod_est 
			ORDER BY te.apellido1,te.apellido2,te.nombre1,te.nombre2,tas.cod_area,tn.id_asig; 
		WHEN '05' THEN 
			SELECT tn.cod_est,tm.id_matric, tn.cod_grado, tn.grupo, tm.año, tn.periodo,
			tn.cod_jorn, tn.id_sede, tn.id_asig, tn.id_docente,
			tn.id_logro, tn.id_logro1, tn.id_logro2, tn.id_sugerencia,
			tn.ind1, tn.ind2, tn.ind3, tn.ind4, tn.ind5, tn.ind6,
			tn.ind7, tn.ind8, tn.ind9, tn.ind10, tn.ind11, tn.ind12,
			tn.notap1, tn.p1, tn.notap2, tn.p2, tn.notap3, tn.p3,
			tn.notap4, tn.p4, tn.nota_perdida, tn.nota_habilitacion, tn.final, tn.faltas, tn.conceptual,
			te.apellido1, te.apellido2, te.nombre1,
			te.nombre2, te.nro_doc_id, tm.estado,
			tar.area, tar.abrev AS abre_area,tar.ordenar AS order_ar, tas.des_asign AS asignatura,
			tas.abrv AS abrev_asig, tas.electiva, tas.cod_area, tas.ordenar AS order_as,
			CONCAT(RTRIM(td.apellido1),' ',RTRIM(td.apellido2),
			RTRIM(td.nombre1),' ',RTRIM(td.nombre2)) as docente,
			ts.nom_sede AS sede, tj.jornada, tg.grado,tm.id_folio,
			tn.tipo_sug,tn.id_obser,
			tn.tipo_ind1, tn.tipo_ind2, tn.tipo_ind3, tn.tipo_ind4, tn.tipo_ind5, tn.tipo_ind6,
			tn.tipo_ind7, tn.tipo_ind8, tn.tipo_ind9, tn.tipo_ind10, tn.tipo_ind11, tn.tipo_ind12 
			FROM scp005 AS tn LEFT JOIN inscripciones AS te ON te.cod_est=
			tn.cod_est LEFT JOIN matriculas AS tm on tm.cod_est=te.cod_est 
			LEFT JOIN asignaturas AS tas ON tn.id_asig=tas.cod_asign 
		    LEFT JOIN areas AS tar ON tas.cod_area=tar.cod_area LEFT JOIN docentes AS td ON 
		    td.id_docente=tn.id_docente LEFT JOIN sedes AS ts ON tn.id_sede=ts.id 
		    LEFT JOIN jornadas AS tj ON tn.cod_jorn=tj.cod_jorn 
		    LEFT JOIN grados As tg ON tn.cod_grado=tg.cod_grado 
			WHERE tm.estado=2 AND tn.grupo=_grupo 
			AND tn.cod_grado=tm.cod_grado AND tn.id_sede=tm.id_sede 
			AND tm.año=_año AND tn.año=_año AND tn.cod_jorn=tm.id_jorn 
			AND tar.año=_año and tas.año=_año AND tn.id_inst=_Id_inst 
			and te.id_inst=_Id_inst and tas.id_inst=_Id_inst 
			and tar.id_inst=_id_inst and td.id_inst=_Id_inst 
			HAVING tn.final>=0 AND tm.estado=2 AND tn.grupo=_grupo 
			AND tn.cod_grado=_cod_grado AND tn.id_sede=_id_sede 
			AND tm.año=_año AND tn.cod_jorn=_cod_jorn 
			AND tn.periodo = _periodo AND tn.cod_est=_cod_est 
			ORDER BY te.apellido1,te.apellido2,te.nombre1,te.nombre2,tas.cod_area,tn.id_asig; 
		WHEN '06' THEN 
			SELECT tn.cod_est,tm.id_matric, tn.cod_grado, tn.grupo, tm.año, tn.periodo,
			tn.cod_jorn, tn.id_sede, tn.id_asig, tn.id_docente,
			tn.id_logro, tn.id_logro1, tn.id_logro2, tn.id_sugerencia,
			tn.ind1, tn.ind2, tn.ind3, tn.ind4, tn.ind5, tn.ind6,
			tn.ind7, tn.ind8, tn.ind9, tn.ind10, tn.ind11, tn.ind12,
			tn.notap1, tn.p1, tn.notap2, tn.p2, tn.notap3, tn.p3,
			tn.notap4, tn.p4, tn.nota_perdida, tn.nota_habilitacion, tn.final, tn.faltas, tn.conceptual,
			te.apellido1, te.apellido2, te.nombre1,
			te.nombre2, te.nro_doc_id, tm.estado,
			tar.area, tar.abrev AS abre_area,tar.ordenar AS order_ar, tas.des_asign AS asignatura,
			tas.abrv AS abrev_asig, tas.electiva, tas.cod_area, tas.ordenar AS order_as,
			CONCAT(RTRIM(td.apellido1),' ',RTRIM(td.apellido2),
			RTRIM(td.nombre1),' ',RTRIM(td.nombre2)) as docente,
			ts.nom_sede AS sede, tj.jornada, tg.grado,tm.id_folio,
			tn.tipo_sug,tn.id_obser,
			tn.tipo_ind1, tn.tipo_ind2, tn.tipo_ind3, tn.tipo_ind4, tn.tipo_ind5, tn.tipo_ind6,
			tn.tipo_ind7, tn.tipo_ind8, tn.tipo_ind9, tn.tipo_ind10, tn.tipo_ind11, tn.tipo_ind12 
			FROM scp006 AS tn LEFT JOIN inscripciones AS te ON te.cod_est=
			tn.cod_est LEFT JOIN matriculas AS tm on tm.cod_est=te.cod_est 
			LEFT JOIN asignaturas AS tas ON tn.id_asig=tas.cod_asign 
		    LEFT JOIN areas AS tar ON tas.cod_area=tar.cod_area LEFT JOIN docentes AS td ON 
		    td.id_docente=tn.id_docente LEFT JOIN sedes AS ts ON tn.id_sede=ts.id 
		    LEFT JOIN jornadas AS tj ON tn.cod_jorn=tj.cod_jorn 
		    LEFT JOIN grados As tg ON tn.cod_grado=tg.cod_grado 
			WHERE tm.estado=2 AND tn.grupo=_grupo 
			AND tn.cod_grado=tm.cod_grado AND tn.id_sede=tm.id_sede 
			AND tm.año=_año AND tn.año=_año AND tn.cod_jorn=tm.id_jorn 
			AND tar.año=_año and tas.año=_año AND tn.id_inst=_Id_inst 
			and te.id_inst=_Id_inst and tas.id_inst=_Id_inst 
			and tar.id_inst=_id_inst and td.id_inst=_Id_inst 
			HAVING tn.final>=0 AND tm.estado=2 AND tn.grupo=_grupo 
			AND tn.cod_grado=_cod_grado AND tn.id_sede=_id_sede 
			AND tm.año=_año AND tn.cod_jorn=_cod_jorn 
			AND tn.periodo = _periodo AND tn.cod_est=_cod_est 
			ORDER BY te.apellido1,te.apellido2,te.nombre1,te.nombre2,tas.cod_area,tn.id_asig; 
		WHEN '07' THEN 
			SELECT tn.cod_est,tm.id_matric, tn.cod_grado, tn.grupo, tm.año, tn.periodo,
			tn.cod_jorn, tn.id_sede, tn.id_asig, tn.id_docente,
			tn.id_logro, tn.id_logro1, tn.id_logro2, tn.id_sugerencia,
			tn.ind1, tn.ind2, tn.ind3, tn.ind4, tn.ind5, tn.ind6,
			tn.ind7, tn.ind8, tn.ind9, tn.ind10, tn.ind11, tn.ind12,
			tn.notap1, tn.p1, tn.notap2, tn.p2, tn.notap3, tn.p3,
			tn.notap4, tn.p4, tn.nota_perdida, tn.nota_habilitacion, tn.final, tn.faltas, tn.conceptual,
			te.apellido1, te.apellido2, te.nombre1,
			te.nombre2, te.nro_doc_id, tm.estado,
			tar.area, tar.abrev AS abre_area,tar.ordenar AS order_ar, tas.des_asign AS asignatura,
			tas.abrv AS abrev_asig, tas.electiva, tas.cod_area, tas.ordenar AS order_as,
			CONCAT(RTRIM(td.apellido1),' ',RTRIM(td.apellido2),
			RTRIM(td.nombre1),' ',RTRIM(td.nombre2)) as docente,
			ts.nom_sede AS sede, tj.jornada, tg.grado,tm.id_folio,
			tn.tipo_sug,tn.id_obser,
			tn.tipo_ind1, tn.tipo_ind2, tn.tipo_ind3, tn.tipo_ind4, tn.tipo_ind5, tn.tipo_ind6,
			tn.tipo_ind7, tn.tipo_ind8, tn.tipo_ind9, tn.tipo_ind10, tn.tipo_ind11, tn.tipo_ind12 
			FROM scp007 AS tn LEFT JOIN inscripciones AS te ON te.cod_est=
			tn.cod_est LEFT JOIN matriculas AS tm on tm.cod_est=te.cod_est 
			LEFT JOIN asignaturas AS tas ON tn.id_asig=tas.cod_asign 
		    LEFT JOIN areas AS tar ON tas.cod_area=tar.cod_area LEFT JOIN docentes AS td ON 
		    td.id_docente=tn.id_docente LEFT JOIN sedes AS ts ON tn.id_sede=ts.id 
		    LEFT JOIN jornadas AS tj ON tn.cod_jorn=tj.cod_jorn 
		    LEFT JOIN grados As tg ON tn.cod_grado=tg.cod_grado 
			WHERE tm.estado=2 AND tn.grupo=_grupo 
			AND tn.cod_grado=tm.cod_grado AND tn.id_sede=tm.id_sede 
			AND tm.año=_año AND tn.año=_año AND tn.cod_jorn=tm.id_jorn 
			AND tar.año=_año and tas.año=_año AND tn.id_inst=_Id_inst 
			and te.id_inst=_Id_inst and tas.id_inst=_Id_inst 
			and tar.id_inst=_id_inst and td.id_inst=_Id_inst 
			HAVING tn.final>=0 AND tm.estado=2 AND tn.grupo=_grupo 
			AND tn.cod_grado=_cod_grado AND tn.id_sede=_id_sede 
			AND tm.año=_año AND tn.cod_jorn=_cod_jorn 
			AND tn.periodo = _periodo AND tn.cod_est=_cod_est 
			ORDER BY te.apellido1,te.apellido2,te.nombre1,te.nombre2,tas.cod_area,tn.id_asig; 
		WHEN '08' THEN 
			SELECT tn.cod_est,tm.id_matric, tn.cod_grado, tn.grupo, tm.año, tn.periodo,
			tn.cod_jorn, tn.id_sede, tn.id_asig, tn.id_docente,
			tn.id_logro, tn.id_logro1, tn.id_logro2, tn.id_sugerencia,
			tn.ind1, tn.ind2, tn.ind3, tn.ind4, tn.ind5, tn.ind6,
			tn.ind7, tn.ind8, tn.ind9, tn.ind10, tn.ind11, tn.ind12,
			tn.notap1, tn.p1, tn.notap2, tn.p2, tn.notap3, tn.p3,
			tn.notap4, tn.p4, tn.nota_perdida, tn.nota_habilitacion, tn.final, tn.faltas, tn.conceptual,
			te.apellido1, te.apellido2, te.nombre1,
			te.nombre2, te.nro_doc_id, tm.estado,
			tar.area, tar.abrev AS abre_area,tar.ordenar AS order_ar, tas.des_asign AS asignatura,
			tas.abrv AS abrev_asig, tas.electiva, tas.cod_area, tas.ordenar AS order_as,
			CONCAT(RTRIM(td.apellido1),' ',RTRIM(td.apellido2),
			RTRIM(td.nombre1),' ',RTRIM(td.nombre2)) as docente,
			ts.nom_sede AS sede, tj.jornada, tg.grado,tm.id_folio,
			tn.tipo_sug,tn.id_obser,
			tn.tipo_ind1, tn.tipo_ind2, tn.tipo_ind3, tn.tipo_ind4, tn.tipo_ind5, tn.tipo_ind6,
			tn.tipo_ind7, tn.tipo_ind8, tn.tipo_ind9, tn.tipo_ind10, tn.tipo_ind11, tn.tipo_ind12 
			FROM scp008 AS tn LEFT JOIN inscripciones AS te ON te.cod_est=
			tn.cod_est LEFT JOIN matriculas AS tm on tm.cod_est=te.cod_est 
			LEFT JOIN asignaturas AS tas ON tn.id_asig=tas.cod_asign 
		    LEFT JOIN areas AS tar ON tas.cod_area=tar.cod_area LEFT JOIN docentes AS td ON 
		    td.id_docente=tn.id_docente LEFT JOIN sedes AS ts ON tn.id_sede=ts.id 
		    LEFT JOIN jornadas AS tj ON tn.cod_jorn=tj.cod_jorn 
		    LEFT JOIN grados As tg ON tn.cod_grado=tg.cod_grado 
			WHERE tm.estado=2 AND tn.grupo=_grupo 
			AND tn.cod_grado=tm.cod_grado AND tn.id_sede=tm.id_sede 
			AND tm.año=_año AND tn.año=_año AND tn.cod_jorn=tm.id_jorn 
			AND tar.año=_año and tas.año=_año AND tn.id_inst=_Id_inst 
			and te.id_inst=_Id_inst and tas.id_inst=_Id_inst 
			and tar.id_inst=_id_inst and td.id_inst=_Id_inst 
			HAVING tn.final>=0 AND tm.estado=2 AND tn.grupo=_grupo 
			AND tn.cod_grado=_cod_grado AND tn.id_sede=_id_sede 
			AND tm.año=_año AND tn.cod_jorn=_cod_jorn 
			AND tn.periodo = _periodo AND tn.cod_est=_cod_est 
			ORDER BY te.apellido1,te.apellido2,te.nombre1,te.nombre2,tas.cod_area,tn.id_asig; 
		WHEN '09' THEN 
			SELECT tn.cod_est,tm.id_matric, tn.cod_grado, tn.grupo, tm.año, tn.periodo,
			tn.cod_jorn, tn.id_sede, tn.id_asig, tn.id_docente,
			tn.id_logro, tn.id_logro1, tn.id_logro2, tn.id_sugerencia,
			tn.ind1, tn.ind2, tn.ind3, tn.ind4, tn.ind5, tn.ind6,
			tn.ind7, tn.ind8, tn.ind9, tn.ind10, tn.ind11, tn.ind12,
			tn.notap1, tn.p1, tn.notap2, tn.p2, tn.notap3, tn.p3,
			tn.notap4, tn.p4, tn.nota_perdida, tn.nota_habilitacion, tn.final, tn.faltas, tn.conceptual,
			te.apellido1, te.apellido2, te.nombre1,
			te.nombre2, te.nro_doc_id, tm.estado,
			tar.area, tar.abrev AS abre_area,tar.ordenar AS order_ar, tas.des_asign AS asignatura,
			tas.abrv AS abrev_asig, tas.electiva, tas.cod_area, tas.ordenar AS order_as,
			CONCAT(RTRIM(td.apellido1),' ',RTRIM(td.apellido2),
			RTRIM(td.nombre1),' ',RTRIM(td.nombre2)) as docente,
			ts.nom_sede AS sede, tj.jornada, tg.grado,tm.id_folio,
			tn.tipo_sug,tn.id_obser,
			tn.tipo_ind1, tn.tipo_ind2, tn.tipo_ind3, tn.tipo_ind4, tn.tipo_ind5, tn.tipo_ind6,
			tn.tipo_ind7, tn.tipo_ind8, tn.tipo_ind9, tn.tipo_ind10, tn.tipo_ind11, tn.tipo_ind12 
			FROM scp009 AS tn LEFT JOIN inscripciones AS te ON te.cod_est=
			tn.cod_est LEFT JOIN matriculas AS tm on tm.cod_est=te.cod_est 
			LEFT JOIN asignaturas AS tas ON tn.id_asig=tas.cod_asign 
		    LEFT JOIN areas AS tar ON tas.cod_area=tar.cod_area LEFT JOIN docentes AS td ON 
		    td.id_docente=tn.id_docente LEFT JOIN sedes AS ts ON tn.id_sede=ts.id 
		    LEFT JOIN jornadas AS tj ON tn.cod_jorn=tj.cod_jorn 
		    LEFT JOIN grados As tg ON tn.cod_grado=tg.cod_grado 
			WHERE tm.estado=2 AND tn.grupo=_grupo 
			AND tn.cod_grado=tm.cod_grado AND tn.id_sede=tm.id_sede 
			AND tm.año=_año AND tn.año=_año AND tn.cod_jorn=tm.id_jorn 
			AND tar.año=_año and tas.año=_año AND tn.id_inst=_Id_inst 
			and te.id_inst=_Id_inst and tas.id_inst=_Id_inst 
			and tar.id_inst=_id_inst and td.id_inst=_Id_inst 
			HAVING tn.final>=0 AND tm.estado=2 AND tn.grupo=_grupo 
			AND tn.cod_grado=_cod_grado AND tn.id_sede=_id_sede 
			AND tm.año=_año AND tn.cod_jorn=_cod_jorn 
			AND tn.periodo = _periodo AND tn.cod_est=_cod_est 
			ORDER BY te.apellido1,te.apellido2,te.nombre1,te.nombre2,tas.cod_area,tn.id_asig; 
		WHEN '10' THEN 
			SELECT tn.cod_est,tm.id_matric, tn.cod_grado, tn.grupo, tm.año, tn.periodo,
			tn.cod_jorn, tn.id_sede, tn.id_asig, tn.id_docente,
			tn.id_logro, tn.id_logro1, tn.id_logro2, tn.id_sugerencia,
			tn.ind1, tn.ind2, tn.ind3, tn.ind4, tn.ind5, tn.ind6,
			tn.ind7, tn.ind8, tn.ind9, tn.ind10, tn.ind11, tn.ind12,
			tn.notap1, tn.p1, tn.notap2, tn.p2, tn.notap3, tn.p3,
			tn.notap4, tn.p4, tn.nota_perdida, tn.nota_habilitacion, tn.final, tn.faltas, tn.conceptual,
			te.apellido1, te.apellido2, te.nombre1,
			te.nombre2, te.nro_doc_id, tm.estado,
			tar.area, tar.abrev AS abre_area,tar.ordenar AS order_ar, tas.des_asign AS asignatura,
			tas.abrv AS abrev_asig, tas.electiva, tas.cod_area, tas.ordenar AS order_as,
			CONCAT(RTRIM(td.apellido1),' ',RTRIM(td.apellido2),
			RTRIM(td.nombre1),' ',RTRIM(td.nombre2)) as docente,
			ts.nom_sede AS sede, tj.jornada, tg.grado,tm.id_folio,
			tn.tipo_sug,tn.id_obser,
			tn.tipo_ind1, tn.tipo_ind2, tn.tipo_ind3, tn.tipo_ind4, tn.tipo_ind5, tn.tipo_ind6,
			tn.tipo_ind7, tn.tipo_ind8, tn.tipo_ind9, tn.tipo_ind10, tn.tipo_ind11, tn.tipo_ind12 
			FROM scp0010 AS tn LEFT JOIN inscripciones AS te ON te.cod_est=
			tn.cod_est LEFT JOIN matriculas AS tm on tm.cod_est=te.cod_est 
			LEFT JOIN asignaturas AS tas ON tn.id_asig=tas.cod_asign 
		    LEFT JOIN areas AS tar ON tas.cod_area=tar.cod_area LEFT JOIN docentes AS td ON 
		    td.id_docente=tn.id_docente LEFT JOIN sedes AS ts ON tn.id_sede=ts.id 
		    LEFT JOIN jornadas AS tj ON tn.cod_jorn=tj.cod_jorn 
		    LEFT JOIN grados As tg ON tn.cod_grado=tg.cod_grado 
			WHERE tm.estado=2 AND tn.grupo=_grupo 
			AND tn.cod_grado=tm.cod_grado AND tn.id_sede=tm.id_sede 
			AND tm.año=_año AND tn.año=_año AND tn.cod_jorn=tm.id_jorn 
			AND tar.año=_año and tas.año=_año AND tn.id_inst=_Id_inst 
			and te.id_inst=_Id_inst and tas.id_inst=_Id_inst 
			and tar.id_inst=_id_inst and td.id_inst=_Id_inst 
			HAVING tn.final>=0 AND tm.estado=2 AND tn.grupo=_grupo 
			AND tn.cod_grado=_cod_grado AND tn.id_sede=_id_sede 
			AND tm.año=_año AND tn.cod_jorn=_cod_jorn 
			AND tn.periodo = _periodo AND tn.cod_est=_cod_est 
			ORDER BY te.apellido1,te.apellido2,te.nombre1,te.nombre2,tas.cod_area,tn.id_asig; 
		WHEN '11' THEN 
			SELECT tn.cod_est,tm.id_matric, tn.cod_grado, tn.grupo, tm.año, tn.periodo,
			tn.cod_jorn, tn.id_sede, tn.id_asig, tn.id_docente,
			tn.id_logro, tn.id_logro1, tn.id_logro2, tn.id_sugerencia,
			tn.ind1, tn.ind2, tn.ind3, tn.ind4, tn.ind5, tn.ind6,
			tn.ind7, tn.ind8, tn.ind9, tn.ind10, tn.ind11, tn.ind12,
			tn.notap1, tn.p1, tn.notap2, tn.p2, tn.notap3, tn.p3,
			tn.notap4, tn.p4, tn.nota_perdida, tn.nota_habilitacion, tn.final, tn.faltas, tn.conceptual,
			te.apellido1, te.apellido2, te.nombre1,
			te.nombre2, te.nro_doc_id, tm.estado,
			tar.area, tar.abrev AS abre_area,tar.ordenar AS order_ar, tas.des_asign AS asignatura,
			tas.abrv AS abrev_asig, tas.electiva, tas.cod_area, tas.ordenar AS order_as,
			CONCAT(RTRIM(td.apellido1),' ',RTRIM(td.apellido2),
			RTRIM(td.nombre1),' ',RTRIM(td.nombre2)) as docente,
			ts.nom_sede AS sede, tj.jornada, tg.grado,tm.id_folio,
			tn.tipo_sug,tn.id_obser,
			tn.tipo_ind1, tn.tipo_ind2, tn.tipo_ind3, tn.tipo_ind4, tn.tipo_ind5, tn.tipo_ind6,
			tn.tipo_ind7, tn.tipo_ind8, tn.tipo_ind9, tn.tipo_ind10, tn.tipo_ind11, tn.tipo_ind12 
			FROM scp0011 AS tn LEFT JOIN inscripciones AS te ON te.cod_est=
			tn.cod_est LEFT JOIN matriculas AS tm on tm.cod_est=te.cod_est 
			LEFT JOIN asignaturas AS tas ON tn.id_asig=tas.cod_asign 
		    LEFT JOIN areas AS tar ON tas.cod_area=tar.cod_area LEFT JOIN docentes AS td ON 
		    td.id_docente=tn.id_docente LEFT JOIN sedes AS ts ON tn.id_sede=ts.id 
		    LEFT JOIN jornadas AS tj ON tn.cod_jorn=tj.cod_jorn 
		    LEFT JOIN grados As tg ON tn.cod_grado=tg.cod_grado 
			WHERE tm.estado=2 AND tn.grupo=_grupo 
			AND tn.cod_grado=tm.cod_grado AND tn.id_sede=tm.id_sede 
			AND tm.año=_año AND tn.año=_año AND tn.cod_jorn=tm.id_jorn 
			AND tar.año=_año and tas.año=_año AND tn.id_inst=_Id_inst 
			and te.id_inst=_Id_inst and tas.id_inst=_Id_inst 
			and tar.id_inst=_id_inst and td.id_inst=_Id_inst 
			HAVING tn.final>=0 AND tm.estado=2 AND tn.grupo=_grupo 
			AND tn.cod_grado=_cod_grado AND tn.id_sede=_id_sede 
			AND tm.año=_año AND tn.cod_jorn=_cod_jorn 
			AND tn.periodo = _periodo AND tn.cod_est=_cod_est 
			ORDER BY te.apellido1,te.apellido2,te.nombre1,te.nombre2,tas.cod_area,tn.id_asig; 
		WHEN '99' THEN 
			SELECT tn.cod_est,tm.id_matric, tn.cod_grado, tn.grupo, tm.año, tn.periodo,
			tn.cod_jorn, tn.id_sede, tn.id_asig, tn.id_docente,
			tn.id_logro, tn.id_logro1, tn.id_logro2, tn.id_sugerencia,
			tn.ind1, tn.ind2, tn.ind3, tn.ind4, tn.ind5, tn.ind6,
			tn.ind7, tn.ind8, tn.ind9, tn.ind10, tn.ind11, tn.ind12,
			tn.notap1, tn.p1, tn.notap2, tn.p2, tn.notap3, tn.p3,
			tn.notap4, tn.p4, tn.nota_perdida, tn.nota_habilitacion, tn.final, tn.faltas, tn.conceptual,
			te.apellido1, te.apellido2, te.nombre1,
			te.nombre2, te.nro_doc_id, tm.estado,
			tar.area, tar.abrev AS abre_area,tar.ordenar AS order_ar, tas.des_asign AS asignatura,
			tas.abrv AS abrev_asig, tas.electiva, tas.cod_area, tas.ordenar AS order_as,
			CONCAT(RTRIM(td.apellido1),' ',RTRIM(td.apellido2),
			RTRIM(td.nombre1),' ',RTRIM(td.nombre2)) as docente,
			ts.nom_sede AS sede, tj.jornada, tg.grado,tm.id_folio,
			tn.tipo_sug,tn.id_obser,
			tn.tipo_ind1, tn.tipo_ind2, tn.tipo_ind3, tn.tipo_ind4, tn.tipo_ind5, tn.tipo_ind6,
			tn.tipo_ind7, tn.tipo_ind8, tn.tipo_ind9, tn.tipo_ind10, tn.tipo_ind11, tn.tipo_ind12 
			FROM scp0011 AS tn LEFT JOIN inscripciones AS te ON te.cod_est=
			tn.cod_est LEFT JOIN matriculas AS tm on tm.cod_est=te.cod_est 
			LEFT JOIN asignaturas AS tas ON tn.id_asig=tas.cod_asign 
		    LEFT JOIN areas AS tar ON tas.cod_area=tar.cod_area LEFT JOIN docentes AS td ON 
		    td.id_docente=tn.id_docente LEFT JOIN sedes AS ts ON tn.id_sede=ts.id 
		    LEFT JOIN jornadas AS tj ON tn.cod_jorn=tj.cod_jorn 
		    LEFT JOIN grados As tg ON tn.cod_grado=tg.cod_grado 
			WHERE tm.estado=2 AND tn.grupo=_grupo 
			AND tn.cod_grado=tm.cod_grado AND tn.id_sede=tm.id_sede 
			AND tm.año=_año AND tn.año=_año AND tn.cod_jorn=tm.id_jorn 
			AND tar.año=_año and tas.año=_año AND tn.id_inst=_Id_inst 
			and te.id_inst=_Id_inst and tas.id_inst=_Id_inst 
			and tar.id_inst=_id_inst and td.id_inst=_Id_inst 
			HAVING tn.final>=0 AND tm.estado=2 AND tn.grupo=_grupo 
			AND tn.cod_grado=_cod_grado AND tn.id_sede=_id_sede 
			AND tm.año=_año AND tn.cod_jorn=_cod_jorn 
			AND tn.periodo = _periodo AND tn.cod_est=_cod_est 
			ORDER BY te.apellido1,te.apellido2,te.nombre1,te.nombre2,tas.cod_area,tn.id_asig; 
		ELSE 
			SELECT tn.cod_est,tm.id_matric, tn.cod_grado, tn.grupo, tm.año, tn.periodo,
			tn.cod_jorn, tn.id_sede, tn.id_asig, tn.id_docente,
			tn.id_logro, tn.id_logro1, tn.id_logro2, tn.id_sugerencia,
			tn.ind1, tn.ind2, tn.ind3, tn.ind4, tn.ind5, tn.ind6,
			tn.ind7, tn.ind8, tn.ind9, tn.ind10, tn.ind11, tn.ind12,
			tn.notap1, tn.p1, tn.notap2, tn.p2, tn.notap3, tn.p3,
			tn.notap4, tn.p4, tn.nota_perdida, tn.nota_habilitacion, tn.final, tn.faltas, tn.conceptual,
			te.apellido1, te.apellido2, te.nombre1,
			te.nombre2, te.nro_doc_id, tm.estado,
			tar.area, tar.abrev AS abre_area,tar.ordenar AS order_ar, tas.des_asign AS asignatura,
			tas.abrv AS abrev_asig, tas.electiva, tas.cod_area, tas.ordenar AS order_as,
			CONCAT(RTRIM(td.apellido1),' ',RTRIM(td.apellido2),
			RTRIM(td.nombre1),' ',RTRIM(td.nombre2)) as docente,
			ts.nom_sede AS sede, tj.jornada, tg.grado,tm.id_folio,
			tn.tipo_sug,tn.id_obser,
			tn.tipo_ind1, tn.tipo_ind2, tn.tipo_ind3, tn.tipo_ind4, tn.tipo_ind5, tn.tipo_ind6,
			tn.tipo_ind7, tn.tipo_ind8, tn.tipo_ind9, tn.tipo_ind10, tn.tipo_ind11, tn.tipo_ind12 
			FROM scp00 AS tn LEFT JOIN inscripciones AS te ON te.cod_est=
			tn.cod_est LEFT JOIN matriculas AS tm on tm.cod_est=te.cod_est 
			LEFT JOIN asignaturas AS tas ON tn.id_asig=tas.cod_asign 
		    LEFT JOIN areas AS tar ON tas.cod_area=tar.cod_area LEFT JOIN docentes AS td ON 
		    td.id_docente=tn.id_docente LEFT JOIN sedes AS ts ON tn.id_sede=ts.id 
		    LEFT JOIN jornadas AS tj ON tn.cod_jorn=tj.cod_jorn 
		    LEFT JOIN grados As tg ON tn.cod_grado=tg.cod_grado 
			WHERE tm.estado=2 AND tn.grupo=_grupo 
			AND tn.cod_grado=tm.cod_grado AND tn.id_sede=tm.id_sede 
			AND tm.año=_año AND tn.año=_año AND tn.cod_jorn=tm.id_jorn 
			AND tar.año=_año and tas.año=_año AND tn.id_inst=_Id_inst 
			and te.id_inst=_Id_inst and tas.id_inst=_Id_inst 
			and tar.id_inst=_id_inst and td.id_inst=_Id_inst 
			HAVING tn.final>=0 AND tm.estado=2 AND tn.grupo=_grupo 
			AND tn.cod_grado=_cod_grado AND tn.id_sede=_id_sede 
			AND tm.año=_año AND tn.cod_jorn=_cod_jorn 
			AND tn.periodo = _periodo AND tn.cod_est=_cod_est 
			ORDER BY te.apellido1,te.apellido2,te.nombre1,te.nombre2,tas.cod_area,tn.id_asig;   
    END CASE;
END IF;
END$$

DROP PROCEDURE IF EXISTS `sp_select_canotaciones_obs_m3`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_select_canotaciones_obs_m3` (IN `_id_inst` INT(30), IN `_año` YEAR, IN `_id_matric` INT(30))  BEGIN
	SELECT ti.anotacion,ti.compromiso_est,ti.compromiso_acu,ti.compromiso_inst,ti.periodo,ti.fecha,
	CONCAT(RTRIM(td.apellido1),' ',RTRIM(td.apellido2),' ',RTRIM(td.nombre1),' ',RTRIM(td.nombre2)) docente,
	tm.`año`,tm.grupo,
	tm.id_grado cod_grado,RTRIM(tj.JORNADA) jornada, TRIM(tg.grado) grado, RTRIM(ts.NOM_SEDE) sede,
	CONCAT(RTRIM(te.apellido1),' ',RTRIM(te.apellido2),' ',RTRIM(te.nombre1),' ',RTRIM(te.nombre2)) estudiante
	, tn.nombre_nivel FROM obs_anotaciones_mod_3 ti 
	LEFT JOIN docentes td ON ti.id_docente = td.id_docente 
	LEFT JOIN obs_observador_mod_3 AS tb ON ti.id_observador = tb.id
	LEFT JOIN matriculas AS tm ON tb.id_matric = tm.id_matric
	LEFT JOIN jornadas AS tj ON tm.id_jorn = tj.COD_JORN
	LEFT JOIN grados AS tg ON tm.id_grado = tg.id
	LEFT JOIN sedes AS ts ON tm.id_sede = ts.ID
	LEFT JOIN inscripciones AS te ON tm.cod_est = te.cod_est
	LEFT JOIN niveles_estudio AS tn ON tg.id_nivel = tn.id
	WHERE ti.estado = 1 AND td.id_inst = _id_inst AND td.`año` = `_año` 
	AND td.estado = 1 AND tb.id_matric = _id_matric AND te.id_inst = _id_inst
	ORDER BY ti.periodo,ti.fecha;
END$$

DROP PROCEDURE IF EXISTS `sp_select_carga_report`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_select_carga_report` (IN `_id_inst` INT(30), IN `_año` YEAR, IN `_id_sede` INT(30), IN `_grado` INT(11), IN `_id_docente` INT(30))  BEGIN
	IF _id_docente > 0 THEN
		SELECT tc.id_grado cod_grado, tc.grupo, tc.id_docente, tc.id_asig, 
		tc.id_sede, tc.cod_jorn, tc.año, tg.grado, RTRIM(ta.asignatura) asignatura, 
		ts.nom_sede as sede,  tj.jornada, tm.ih,
		CONCAT(RTRIM(td.apellido1),' ',RTRIM(td.apellido2),' ',RTRIM(td.nombre1),' ',RTRIM(td.nombre2)) AS docente
		FROM cursos AS tc 
		LEFT JOIN grados as tg ON tc.id_grado = tg.id
		LEFT JOIN asignaturas AS ta ON tc.id_asig = ta.id_pk
		LEFT JOIN sedes AS ts ON tc.id_sede = ts.id
		LEFT JOIN jornadas AS tj ON tc.cod_jorn = tj.cod_jorn 
		LEFT JOIN matcurso AS tm ON (tm.id_grado  = tg.id
		AND tm.id_asig = ta.id_pk AND tm.año=tc.año)
		LEFT JOIN docentes AS td ON tc.id_docente = td.id_docente
		WHERE td.id_docente= _id_docente AND tc.año= `_año` AND tc.id_inst = _id_inst 
		AND ta.id_inst = _id_inst AND tm.id_inst = _id_inst AND tm.`año` = `_año`
		AND tc.estado = 1 ORDER BY tc.id_grado,tc.cod_jorn,tc.grupo,docente,tc.id_asig;
	ELSE
		SELECT tc.id_grado cod_grado, tc.grupo, tc.id_docente, tc.id_asig, 
		tc.id_sede, tc.cod_jorn, tc.año, tg.grado, RTRIM(ta.asignatura) asignatura, 
		ts.nom_sede as sede,  tj.jornada, tm.ih,  
		 CONCAT(RTRIM(td.apellido1),' ',RTRIM(td.apellido2),' ',RTRIM(td.nombre1),' ',RTRIM(td.nombre2)) AS docente
		 FROM cursos AS tc 
		 LEFT JOIN grados as tg ON tc.id_grado = tg.id
		 LEFT JOIN asignaturas AS ta ON tc.id_asig = ta.id_pk
		 LEFT JOIN sedes AS ts ON tc.id_sede = ts.id
		 LEFT JOIN jornadas AS tj ON tc.cod_jorn = tj.cod_jorn 
		 LEFT JOIN matcurso AS tm ON (tm.id_grado  = tg.id
		 AND tm.id_asig = ta.id_pk AND tm.año=tc.año)
		 LEFT JOIN docentes AS td ON td.id_docente=tc.id_docente
		 WHERE tc.id_sede= _id_sede AND tc.id_grado= _grado AND tc.año= `_año`
		 AND tc.id_inst = _id_inst AND ta.id_inst = _id_inst AND ta.estado = 1 
		 AND ts.ID_INST = _id_inst AND tc.estado = 1 AND tm.id_inst = _id_inst AND tm.`año` = `_año`
		 ORDER BY tc.id_grado,tc.cod_jorn,tc.grupo,docente,tc.id_asig;
	END IF;
END$$

DROP PROCEDURE IF EXISTS `sp_select_config_diploma`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_select_config_diploma` (IN `_id_inst` INT(20), IN `_año` YEAR)  BEGIN
	SELECT * FROM configdiplomas tc WHERE tc.id_inst = _id_inst AND tc.`año` = `_año`;
END$$

DROP PROCEDURE IF EXISTS `sp_select_consolidado_asig`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_select_consolidado_asig` (IN `_id_inst` INT(20), IN `_id_sede` INT(20), IN `_id_jorn` INT(1), IN `_cod_grado` INT(11), IN `_grupo` VARCHAR(2), IN `_año` YEAR, IN `_periodo` VARCHAR(1), IN `_type` INT(1))  BEGIN
	IF _type = 1 THEN /* Asignaturas*/
		IF _periodo = '0' THEN
			SELECT tm.id_inst,tm.año,tc.*, tm.grupo, tm.id_jorn, tm.id_sede,tm.cod_est, 
			CONCAT(RTRIM(te.apellido1),' ',RTRIM(te.apellido2),' ', 
			RTRIM(te.nombre1),' ',RTRIM(te.nombre2)) AS estudiante,tg.grado, tg.cod_grado, tj.jornada, ts.nom_sede As sede
			FROM consolidado AS tc 
			LEFT JOIN matriculas AS tm ON tc.id_matric=tm.id_matric 
			LEFT JOIN inscripciones AS te ON tm.cod_est=te.cod_est 
			LEFT JOIN grados AS tg ON tm.id_grado = tg.id
			LEFT JOIN jornadas AS tj ON tm.id_jorn = tj.cod_jorn 
			LEFT JOIN sedes AS ts ON tm.id_sede = ts.ID 
			WHERE tm.id_estado=2 AND tm.id_grado = _cod_grado  
			AND tm.id_sede= _id_sede AND tm.año = _año AND ts.ID = _id_sede
			AND tm.id_jorn= _id_jorn AND tm.grupo= _grupo  
			ORDER BY estudiante, tc.periodo;
		ELSE
			SELECT tm.id_inst,tm.año,tc.*, tm.grupo, tm.id_jorn, tm.id_sede,tm.cod_est, 
			CONCAT(RTRIM(te.apellido1),' ',RTRIM(te.apellido2),' ', 
			RTRIM(te.nombre1),' ',RTRIM(te.nombre2)) AS estudiante,tg.grado, tg.cod_grado, tj.jornada, ts.nom_sede As sede
			FROM consolidado AS tc 
			LEFT JOIN matriculas AS tm ON tc.id_matric=tm.id_matric 
			LEFT JOIN inscripciones AS te ON tm.cod_est=te.cod_est 
			LEFT JOIN grados AS tg ON tm.id_grado = tg.id
			LEFT JOIN jornadas AS tj ON tm.id_jorn = tj.cod_jorn 
			LEFT JOIN sedes AS ts ON tm.id_sede = ts.ID 
			WHERE tm.id_estado=2 AND tm.id_grado = _cod_grado  AND ts.ID = _id_sede 
			AND tm.id_sede= _id_sede AND tm.año = _año AND tc.periodo = _periodo
			AND tm.id_jorn= _id_jorn AND tm.grupo= _grupo  
			ORDER BY estudiante, tc.periodo;
		END IF;
	ELSE
		IF _periodo = '0' THEN
			SELECT tm.id_inst,tm.año,tc.*, tm.grupo, tm.id_jorn, tm.id_sede,tm.cod_est, 
			CONCAT(RTRIM(te.apellido1),' ',RTRIM(te.apellido2),' ', 
			RTRIM(te.nombre1),' ',RTRIM(te.nombre2)) AS estudiante,tg.grado, tg.cod_grado, tj.jornada, ts.nom_sede As sede
			FROM consolidado_areas AS tc 
			LEFT JOIN matriculas AS tm ON tc.id_matric=tm.id_matric 
			LEFT JOIN inscripciones AS te ON tm.cod_est=te.cod_est 
			LEFT JOIN grados AS tg ON tm.id_grado = tg.id
			LEFT JOIN jornadas AS tj ON tm.id_jorn = tj.cod_jorn 
			LEFT JOIN sedes AS ts ON tm.id_sede = ts.ID 
			WHERE tm.id_estado=2 AND tm.id_grado = _cod_grado  
			AND tm.id_sede= _id_sede AND tm.año = _año AND ts.ID = _id_sede
			AND tm.id_jorn= _id_jorn AND tm.grupo= _grupo  
			ORDER BY estudiante, tc.periodo;
		ELSE
			SELECT tm.id_inst,tm.año,tc.*, tm.grupo, tm.id_jorn, tm.id_sede,tm.cod_est, 
			CONCAT(RTRIM(te.apellido1),' ',RTRIM(te.apellido2),' ', 
			RTRIM(te.nombre1),' ',RTRIM(te.nombre2)) AS estudiante,tg.grado, tg.cod_grado, tj.jornada, ts.nom_sede As sede
			FROM consolidado_areas AS tc 
			LEFT JOIN matriculas AS tm ON tc.id_matric=tm.id_matric 
			LEFT JOIN inscripciones AS te ON tm.cod_est=te.cod_est 
			LEFT JOIN grados AS tg ON tm.id_grado = tg.id
			LEFT JOIN jornadas AS tj ON tm.id_jorn = tj.cod_jorn 
			LEFT JOIN sedes AS ts ON tm.id_sede = ts.ID 
			WHERE tm.id_estado=2 AND tm.id_grado = _cod_grado  AND ts.ID = _id_sede 
			AND tm.id_sede= _id_sede AND tm.año = _año AND tc.periodo = _periodo
			AND tm.id_jorn= _id_jorn AND tm.grupo= _grupo  
			ORDER BY estudiante, tc.periodo;
		END IF;
	END IF;
END$$

DROP PROCEDURE IF EXISTS `sp_select_consolidado_matricula`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_select_consolidado_matricula` (IN `_id_inst` INT(30), IN `_año` YEAR)  BEGIN
	SELECT tem.estado_matricula estado, te.apellido1, te.apellido2, te.nombre1, te.nombre2,
		te.sexo, te.tipo_sangre, te.fecha_nacimiento, FLOOR(TIMESTAMPDIFF(YEAR, fecha_nacimiento, CURDATE())) edad, 
		te.sisben, te.estrato, RTRIM(te.IPS) IPS, RTRIM(te.direccion) direccion, tz.tipo zona, 
		te.nro_doc_id documento, RTRIM(tdoc.tipo) tipo_documento,te.telefono,
		tg.cod_grado,RTRIM(tg.grado) grado,tm.grupo, tj.jornada, RTRIM(ts.nom_sede) sede,tm.`año`,
		tpv.nombre pob_vict_conf, te.cod_flia_accion, te.nro_sisben
		FROM inscripciones AS te
		LEFT JOIN matriculas AS tm ON tm.cod_est = te.cod_est 
		LEFT JOIN grados AS tg  ON tm.id_grado = tg.id	
		LEFT JOIN jornadas AS tj ON tm.id_jorn = tj.cod_jorn
		LEFT JOIN sedes AS ts ON tm.id_sede = ts.ID 
		LEFT JOIN documentos AS tdoc ON te.cod_doc = tdoc.id
		LEFT JOIN estado_matricula tem ON tm.id_estado = tem.id
		LEFT JOIN zona tz ON te.id_zona = tz.id_zona
		LEFT JOIN poblacion_victima_conflicto AS tpv ON te.pob_vict_conf = tpv.id
		WHERE tm.año = `_año` AND tm.id_inst = _id_inst AND te.id_inst = _id_inst AND ts.ID_INST = _id_inst 
		ORDER BY sede, tm.id_grado, tm.grupo, tm.id_jorn, te.apellido1, te.apellido2, te.nombre1, te.nombre2;
END$$

DROP PROCEDURE IF EXISTS `sp_select_criterios_obs_m3`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_select_criterios_obs_m3` (IN `_id_inst` INT(30), IN `_año` YEAR, IN `_id_matric` INT(30))  BEGIN
	SELECT ti.n1,ti.n2,ti.n3,ti.n4,ti.av1,ti.av2,ti.av3,ti.av4,ti.cs1,ti.cs2,ti.cs3,ti.cs4, 
	ti.s1,ti.s2,ti.s3,ti.s4,tc.descripcion AS criterio, tp.descripcion AS aspecto,tm.`año`,tm.grupo,
	tm.id_grado cod_grado,RTRIM(tj.JORNADA) jornada, TRIM(tg.grado) grado, RTRIM(ts.NOM_SEDE) sede,
	CONCAT(RTRIM(te.apellido1),' ',RTRIM(te.apellido2),' ',RTRIM(te.nombre1),' ',RTRIM(te.nombre2)) estudiante,
	tn.nombre_nivel FROM obs_items_modelo_3 ti 
	LEFT JOIN obs_criterios tc ON ti.id_item_criterio = tc.id 
	LEFT JOIN obs_items_modelos tp ON tc.id_item_modelo = tp.id 
	LEFT JOIN obs_observador_mod_3 AS tb ON ti.id_observador = tb.id
	LEFT JOIN matriculas AS tm ON tb.id_matric = tm.id_matric
	LEFT JOIN jornadas AS tj ON tm.id_jorn = tj.COD_JORN
	LEFT JOIN grados AS tg ON tm.id_grado = tg.id
	LEFT JOIN sedes AS ts ON tm.id_sede = ts.ID
	LEFT JOIN inscripciones AS te ON tm.cod_est = te.cod_est
	LEFT JOIN niveles_estudio AS tn ON tg.id_nivel = tn.id
	WHERE tc.id_inst = _id_inst AND tc.estado = 1 
	AND tp.id_inst = _id_inst AND tp.`año` = `_año` AND tp.estado = 1 
	AND tb.id_matric = _id_matric AND te.id_inst = _id_inst
	ORDER BY tp.descripcion, tc.descripcion;
END$$

DROP PROCEDURE IF EXISTS `sp_select_cuadro_honor`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_select_cuadro_honor` (IN `_id_inst` INT(30), IN `_año` YEAR, IN `_id_sede` INT(30), IN `_grado` INT(11), IN `_grupo` VARCHAR(2), IN `_per` VARCHAR(1), IN `_lm` INT, IN `_type` INT(1), IN `_niv` INT, IN `_ck` INT(1))  BEGIN
	IF _ck = 1 THEN
		SET _per = '';
	END IF;
	CASE _type
		WHEN 1 THEN 
			SELECT tm.grupo,th.*, CONCAT(RTRIM(te.apellido1),' ',RTRIM(te.apellido2),' ',
			RTRIM(te.nombre1),' ',RTRIM(te.nombre2)) AS estudiante, te.foto, 
			RTRIM(ts.NOM_SEDE) sede, tg.grado, tg.cod_grado
			FROM cuadro_honor AS th 
			LEFT JOIN matriculas AS tm ON th.id_matric = tm.id_matric 
			LEFT JOIN inscripciones AS te ON tm.cod_est = te.cod_est 
			LEFT JOIN sedes AS ts ON tm.id_sede = ts.ID 
			LEFT JOIN grados AS tg ON tm.id_grado = tg.id
			WHERE tm.año=`_año` AND th.periodo=_per AND te.id_inst= _id_inst
			AND tg.id =_grado AND tm.id_sede= _id_sede
			AND tm.id_inst=_id_inst AND tm.grupo= _grupo AND ts.id_inst= _id_inst
			ORDER BY th.suma DESC, th.nmax DESC, estudiante LIMIT _lm;
		WHEN 2 THEN 
			SELECT tm.grupo,th.*, CONCAT(RTRIM(te.apellido1),' ',RTRIM(te.apellido2),' ',
			RTRIM(te.nombre1),' ',RTRIM(te.nombre2)) AS estudiante, te.foto, 
			RTRIM(ts.NOM_SEDE) sede, tg.grado, tg.cod_grado
			FROM cuadro_honor AS th 
			LEFT JOIN matriculas AS tm ON th.id_matric = tm.id_matric 
			LEFT JOIN inscripciones AS te ON tm.cod_est = te.cod_est 
			LEFT JOIN sedes AS ts ON tm.id_sede = ts.ID 
			LEFT JOIN grados AS tg ON tm.id_grado = tg.id
			WHERE tm.año=`_año` AND th.periodo=_per AND te.id_inst= _id_inst
			 AND tm.id_grado=_grado AND tm.id_sede= _id_sede
			 AND tm.id_inst=_id_inst AND tm.grupo= _grupo AND ts.id_inst= _id_inst
			 ORDER BY th.suma DESC, th.nmax DESC, estudiante LIMIT _lm;
		WHEN 3 THEN /*Sede y grado*/
			SELECT tm.grupo,th.*, CONCAT(RTRIM(te.apellido1),' ',RTRIM(te.apellido2),' ',
			RTRIM(te.nombre1),' ',RTRIM(te.nombre2)) AS estudiante, te.foto, 
			RTRIM(ts.NOM_SEDE) sede, tg.grado, tg.cod_grado
			FROM cuadro_honor AS th 
			LEFT JOIN matriculas AS tm ON th.id_matric = tm.id_matric 
			LEFT JOIN inscripciones AS te ON tm.cod_est = te.cod_est 
			LEFT JOIN sedes AS ts ON tm.id_sede = ts.ID 
			LEFT JOIN grados AS tg ON tm.id_grado = tg.id
			WHERE tm.año=`_año` AND th.periodo=_per AND te.id_inst= _id_inst
			 AND tm.id_grado=_grado AND tm.id_sede= _id_sede
			 AND tm.id_inst=_id_inst AND ts.id_inst= _id_inst
			 ORDER BY th.suma DESC, th.nmax DESC, estudiante LIMIT _lm;
		WHEN 4 THEN /*Sede*/
			SELECT tm.grupo,th.*, CONCAT(RTRIM(te.apellido1),' ',RTRIM(te.apellido2),' ',
			RTRIM(te.nombre1),' ',RTRIM(te.nombre2)) AS estudiante,te.foto, 
			RTRIM(ts.NOM_SEDE) sede, tg.grado, tg.cod_grado 
			FROM cuadro_honor AS th 
			LEFT JOIN matriculas AS tm ON th.id_matric = tm.id_matric 
			LEFT JOIN inscripciones AS te ON tm.cod_est = te.cod_est 
			LEFT JOIN sedes AS ts ON tm.id_sede = ts.ID 
			LEFT JOIN grados AS tg ON tm.id_grado = tg.id
			WHERE tm.año=`_año` AND th.periodo=_per AND te.id_inst= _id_inst
			 AND tm.id_sede= _id_sede AND tm.id_inst=_id_inst AND ts.id_inst= _id_inst
			 ORDER BY th.suma DESC, th.nmax DESC, estudiante LIMIT _lm;
		WHEN 5 THEN /*Niveles*/
			SELECT tm.grupo,th.*, CONCAT(RTRIM(te.apellido1),' ',RTRIM(te.apellido2),' ',
			RTRIM(te.nombre1),' ',RTRIM(te.nombre2)) AS estudiante,te.foto,
			RTRIM(ts.NOM_SEDE) sede, tg.grado, tg.cod_grado,tv.nombre_nivel
			FROM cuadro_honor AS th 
			LEFT JOIN matriculas AS tm ON th.id_matric = tm.id_matric 
			LEFT JOIN inscripciones AS te ON tm.cod_est = te.cod_est 
			LEFT JOIN sedes AS ts ON tm.id_sede = ts.ID 
			LEFT JOIN grados AS tg ON tm.id_grado = tg.id
			LEFT JOIN niveles_estudio AS tv ON th.nivel = tv.id
			WHERE tm.año=`_año` AND th.periodo=_per AND te.id_inst= _id_inst AND th.nivel = _niv 
			 AND tm.id_sede= _id_sede AND tm.id_inst=_id_inst AND ts.id_inst= _id_inst
			 ORDER BY th.suma DESC, th.nmax DESC, estudiante LIMIT _lm;
	END CASE;
END$$

DROP PROCEDURE IF EXISTS `sp_select_cursos_grado`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_select_cursos_grado` (IN `_id_inst` INT(20), IN `_año` YEAR, IN `_cod_grado` INT(11))  BEGIN
	SELECT tc.*,CONCAT(RTRIM(td.apellido1),' ',RTRIM(td.apellido2),' ',RTRIM(td.nombre1),' ',
	RTRIM(td.nombre2)) AS docente, RTRIM(ta.asignatura) asignatura,ts.nom_sede AS sede, tj.jornada, tg.grado 
	FROM cursos AS tc 
	LEFT JOIN docentes AS td ON td.id_docente=tc.id_docente 
	LEFT JOIN asignaturas AS ta ON tc.id_asig = ta.id_pk 
	LEFT JOIN sedes AS ts ON tc.id_sede = ts.ID
	LEFT JOIN jornadas AS tj ON tc.cod_jorn=tj.cod_jorn 
	LEFT JOIN grados As tg ON tc.id_grado=tg.id 
	WHERE tc.id_grado =  _cod_grado AND tc.año= `_año` AND 
	tc.id_inst= _id_inst AND td.id_inst= _id_inst AND ta.id_inst= _id_inst
	ORDER BY tc.id_sede,tc.id_grado,tc.grupo,tc.cod_jorn,docente,ta.id_area,tc.id_asig;
END$$

DROP PROCEDURE IF EXISTS `sp_select_cursos_notas`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_select_cursos_notas` (IN `_id_inst` INT(20), IN `_id_sede` INT(20), IN `_cod_jorn` INT(11), IN `_cod_grado` INT(11), IN `_grupo` VARCHAR(2), IN `_año` YEAR)  BEGIN
	SELECT tc.*,CONCAT(RTRIM(td.apellido1),' ',RTRIM(td.apellido2),' ',RTRIM(td.nombre1),' ',
	RTRIM(td.nombre2)) AS docente, RTRIM(ta.asignatura) asignatura,ts.nom_sede AS sede, tj.jornada, tg.grado 
	FROM cursos AS tc 
	LEFT JOIN docentes AS td ON td.id_docente=tc.id_docente 
	LEFT JOIN asignaturas AS ta ON tc.id_asig = ta.id_pk
	LEFT JOIN sedes AS ts ON ts.id=tc.id_sede 
	LEFT JOIN jornadas AS tj ON tc.cod_jorn=tj.cod_jorn 
	LEFT JOIN grados As tg ON tc.id_grado=tg.id 
	WHERE tc.id_grado =  _cod_grado and tc.año= `_año`
	and tc.id_inst= _id_inst and td.id_inst= _id_inst AND tc.id_sede = _id_sede
	AND ta.id_inst= _id_inst AND tc.grupo = _grupo AND tc.cod_jorn = _cod_jorn AND tc.estado = 1
	ORDER BY tc.id_sede,tc.id_grado,tc.grupo,tc.cod_jorn,docente,ta.id_area,tc.id_asig;
END$$

DROP PROCEDURE IF EXISTS `sp_select_datos_observador`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_select_datos_observador` (IN `_id_inst` INT(30), IN `_año` YEAR, IN `_id_matric` INT(30), IN `_type` INT(1))  BEGIN
	CASE _type
		WHEN 3 THEN 
			SELECT CONCAT(RTRIM(ti.apellido1),' ',RTRIM(ti.apellido2),' ',RTRIM(ti.nombre1),' ',RTRIM(ti.nombre2)) nombres,
				ti.nro_doc_id, ti.fecha_nacimiento, RTRIM(ti.direccion) direccion, ti.telefono, ti.e_mail, ti.tipo_sangre, ti.sisben, 
				ti.nro_sisben, ti.estrato,ti.IPS ips, tm.id_grado cod_grado, RTRIM(ts.NOM_SEDE) sede,tm.año,
				te.estado_matricula estado,tm.id_jorn,tm.grupo,UPPER(td.nombre) AS dpto,upper(tde.nombre) AS dpto_e,upper(tde.nombre) AS dpto_u,
				tc.nombre_mun AS mun, tce.nombre_mun AS mun_e,tce.nombre_mun AS mun_u,tj.jornada,
				tm.fecha As fecha_m,tm.ins_proced,
				tm.dir_inst,RIGHT(CONCAT('0000',tm.id_folio),4) id_folio, RIGHT(CONCAT('0000',tm.nro_matricula),4) nro_matricula,
				RIGHT(CONCAT('0000',tm.libro_mat),4) libro_mat, 
				tz.tipo AS zona, tdoc.tipo as documento, tdoc.abrev AS abrev_doc, tg.grado,
				t.id_matric,t.peso,t.talla,t.religion,t.deporte,t.musica,t.arte,t.comida,t.prof_oficio,t.motricidad_fina,
				t.motricidad_gruesa,t.temporo_espacial,t.actitud_verval,t.artitud_numerica,t.liderazgo,t.comportamiento,
				t.dislexia,t.disortografia,t.discalculia,t.fecha, RTRIM(ep.DES_EPS) AS eps, cex.nombre AS capacidad_exp,
				dis.nombre AS discapacidad, RTRIM(et.NOM_ETNIA) etnia, RTRIM(res.NOMB_RESG) resguardo
				FROM inscripciones AS ti 
				LEFT JOIN departamentos AS td ON ti.dpto_lug_nac=td.id 
			 	LEFT JOIN ciudades AS tc  ON (ti.mun_lug_nac=tc.id AND tc.dpto=ti.dpto_lug_nac) 
			 	LEFT JOIN departamentos AS tde ON ti.dpto_lug_exp=tde.id 
			 	LEFT JOIN ciudades AS tce  ON (ti.mun_lug_exp=tce.id AND tce.dpto=ti.dpto_lug_exp) 
			 	LEFT JOIN departamentos AS tdu ON ti.dpto_lug_res=tdu.id 
			 	LEFT JOIN ciudades AS tcu  ON (ti.mun_lug_res=tcu.id AND tcu.dpto=ti.dpto_lug_res) 
				LEFT JOIN matriculas AS tm ON tm.cod_est=ti.cod_est 
				LEFT JOIN jornadas AS tj ON tm.id_jorn=tj.cod_jorn 
				LEFT JOIN sedes AS ts ON tm.id_sede=ts.id 
				LEFT JOIN estado_matricula AS te ON tm.id_estado = te.id 
				LEFT JOIN zona AS tz ON ti.id_zona = tz.id_zona 
				LEFT JOIN documentos AS tdoc ON ti.cod_doc = tdoc.id 
				LEFT JOIN grados AS tg ON tm.id_grado = tg.id 
				LEFT JOIN obs_observador_mod_3 AS t ON t.id_matric = tm.id_matric
				LEFT JOIN eps AS ep ON ti.id_eps = ep.id
				LEFT JOIN capacidades_excepcionales AS cex ON ti.cap_exc = cex.id
				LEFT JOIN tipo_discapacidad AS dis ON ti.tipo_discapacidad = dis.id
				LEFT JOIN etnias AS et ON ti.cod_etnia = et.COD_ETNIA
				LEFT JOIN resguardos AS res ON ti.cod_resgua = res.COD_RESGUA
				WHERE  tm.año= `_año` AND tm.id_estado > 1 
				AND tm.id_inst = 1 AND ti.id_inst = _id_inst AND  ts.ID_INST = _id_inst 
				AND tm.id_matric = _id_matric
				ORDER BY apellido1,apellido2,nombre1,nombre2 LIMIT 1;
	END CASE;
END$$

DROP PROCEDURE IF EXISTS `sp_select_desplazados`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_select_desplazados` (IN `_id_inst` INT(30), IN `_año` YEAR)  BEGIN
	SELECT te.nro_doc_id, 
	CONCAT(RTRIM(te.apellido1),' ',RTRIM(te.apellido2),' '+RTRIM(te.nombre1),' ',RTRIM(te.nombre2)) nombres, 
	tes.estado_matricula estado, tg.cod_grado,tm.grupo, RTRIM(te.direccion) direccion, RTRIM(ts.NOM_SEDE) sede,
	RTRIM(tg.grado) grado, RTRIM(tj.JORNADA) jornada
	FROM inscripciones AS te
	LEFT JOIN matriculas AS tm ON tm.cod_est = te.cod_est
	LEFT JOIN sedes AS ts ON tm.id_sede = ts.ID
	LEFT JOIN estado_matricula AS tes ON tm.id_estado = tes.id
	LEFT JOIN grados AS tg ON tm.id_grado = tg.id
	LEFT JOIN jornadas AS tj ON tm.id_jorn = tj.cod_jorn
	WHERE tm.año=`_año` AND te.pob_vict_conf = 1 AND tm.id_inst = _id_inst AND te.id_inst = _id_inst
	ORDER BY sede,tm.id_grado,tm.grupo,tm.id_estado,tm.id_jorn,nombres;
END$$

DROP PROCEDURE IF EXISTS `sp_select_docentes_report`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_select_docentes_report` (IN `_id_inst` INT(30), IN `_año` YEAR, IN `_id_docente` INT(30))  BEGIN
	IF _id_docente > 0 THEN 
		SELECT td.id_docente,RTRIM(td.direccion) direccion,td.tipo_sangr,td.foto,td.documento,td.fec_nac,
		CONCAT(RTRIM(td.apellido1),' ',RTRIM(td.apellido2),' ',RTRIM(td.nombre1),' ',RTRIM(td.nombre2)) nombres,
		td.sexo,td.fecha_vinc,tz.tipo zona,	FLOOR(TIMESTAMPDIFF(YEAR, td.fec_nac, CURDATE())) edad,td.movil,
		td.fijo,td.otra,td.e_mail,td.año,tdoc.documento tp_docuemento,
		ten.nivel,tv.nombre,tnv.nivel_nom,RTRIM(ts.nom_sede) sede, 
		tu.tipo ubicacion, te.tipo etnoeducador, tat.tipo area_tecnica, tdpo.nombre dpto_expedicion,
		tdpo1.nombre AS dpto_nacimiento, tm.nombre_mun AS mun_expedicion, tm1.nombre_mun AS mun_nacimiento,
		tf.tipo AS f_recursos,RTRIM(tes.tipo) AS Escalafon, tar.asignatura AS ar_enseñanza
		FROM docentes AS td 
		LEFT JOIN docdocente AS tdoc ON td.id_doc=tdoc.id_doc 
		LEFT JOIN nomcargo AS tcar ON td.n_cargo=tcar.id_nomb 
		LEFT JOIN cargo AS tc ON td.cod_car=tc.cod_car 
		LEFT JOIN enseñanza AS ten ON td.cod_ense=ten.id 
		LEFT JOIN vinculapersonal AS tv ON td.cod_vin=tv.id 
		LEFT JOIN niveles AS tnv ON td.cod_nivel=tnv.id_nivel 
		LEFT JOIN sedes AS ts ON td.id_sede=ts.id 
		LEFT JOIN ubicacion AS tu ON td.id_ubicacion=tu.id 
		LEFT JOIN etnoeduc AS te ON td.id_etno_edu=te.id 
		LEFT JOIN area_tecnica AS tat ON td.id_area_tec=tat.id 
		LEFT JOIN departamentos AS tdpo ON td.dpto_exp=tdpo.id 
		LEFT JOIN departamentos AS tdpo1 ON td.dpto_nac=tdpo1.id 
		LEFT JOIN ciudades AS tm ON td.mun_exp=tm.id AND td.dpto_exp=tm.dpto 
		LEFT JOIN ciudades AS tm1 ON td.mun_nac=tm1.id	AND td.dpto_exp=tm1.dpto 
		LEFT JOIN fuenterecursos AS tf ON td.f_recurso=tf.id 
		LEFT JOIN escalafon AS tes ON td.id_escalafon=tes.id 
		LEFT JOIN area_enseñanza AS tar ON td.arean_ens=tar.id_ar_ens 
		LEFT JOIN zona AS tz ON td.cod_zona = tz.id_zona
		WHERE td.año= `_año` AND td.id_inst=_id_inst AND td.id_docente = _id_docente 
		ORDER BY td.id_Sede, nombres;
	ELSE 
		SELECT td.id_docente,RTRIM(td.direccion) direccion,td.tipo_sangr,td.foto,td.documento,td.fec_nac,
		CONCAT(RTRIM(td.apellido1),' ',RTRIM(td.apellido2),' ',RTRIM(td.nombre1),' ',RTRIM(td.nombre2)) nombres,
		td.sexo,td.fecha_vinc,tz.tipo zona,	FLOOR(TIMESTAMPDIFF(YEAR, td.fec_nac, CURDATE())) edad,td.movil,
		td.fijo,td.otra,td.e_mail,td.año,tdoc.documento tp_docuemento,
		ten.nivel,tv.nombre,tnv.nivel_nom,RTRIM(ts.nom_sede) sede, 
		tu.tipo ubicacion, te.tipo etnoeducador, tat.tipo area_tecnica, tdpo.nombre dpto_expedicion,
		tdpo1.nombre AS dpto_nacimiento, tm.nombre_mun AS mun_expedicion, tm1.nombre_mun AS mun_nacimiento,
		tf.tipo AS f_recursos,RTRIM(tes.tipo) AS Escalafon, tar.asignatura AS ar_enseñanza
		FROM docentes AS td 
		LEFT JOIN docdocente AS tdoc ON td.id_doc=tdoc.id_doc 
		LEFT JOIN nomcargo AS tcar ON td.n_cargo=tcar.id_nomb 
		LEFT JOIN cargo AS tc ON td.cod_car=tc.cod_car 
		LEFT JOIN enseñanza AS ten ON td.cod_ense=ten.id 
		LEFT JOIN vinculapersonal AS tv ON td.cod_vin=tv.id 
		LEFT JOIN niveles AS tnv ON td.cod_nivel=tnv.id_nivel 
		LEFT JOIN sedes AS ts ON td.id_sede=ts.id 
		LEFT JOIN ubicacion AS tu ON td.id_ubicacion=tu.id 
		LEFT JOIN etnoeduc AS te ON td.id_etno_edu=te.id 
		LEFT JOIN area_tecnica AS tat ON td.id_area_tec=tat.id 
		LEFT JOIN departamentos AS tdpo ON td.dpto_exp=tdpo.id 
		LEFT JOIN departamentos AS tdpo1 ON td.dpto_nac=tdpo1.id 
		LEFT JOIN ciudades AS tm ON td.mun_exp=tm.id AND td.dpto_exp=tm.dpto 
		LEFT JOIN ciudades AS tm1 ON td.mun_nac=tm1.id	AND td.dpto_exp=tm1.dpto 
		LEFT JOIN fuenterecursos AS tf ON td.f_recurso=tf.id 
		LEFT JOIN escalafon AS tes ON td.id_escalafon=tes.id 
		LEFT JOIN area_enseñanza AS tar ON td.arean_ens=tar.id_ar_ens 
		LEFT JOIN zona AS tz ON td.cod_zona = tz.id_zona
		WHERE td.año= `_año` AND td.id_inst=_id_inst 
		ORDER BY td.id_Sede, nombres;
	END IF;
END$$

DROP PROCEDURE IF EXISTS `sp_select_doc_digitales_est`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_select_doc_digitales_est` (IN `_id_est` INT(20))  BEGIN
	SELECT * FROM doc_digitales_est td WHERE td.id_estudiante = _id_est;
END$$

DROP PROCEDURE IF EXISTS `sp_select_estadistica_edades`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_select_estadistica_edades` (IN `_id_inst` INT(30), IN `_año` YEAR)  BEGIN
	DECLARE done,
			  s0,s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12,s13,s14,s15,s16,s17,s18,s19,s20,_cant,_jorn,x_año, _edad, _total INT DEFAULT 0;
	DECLARE _sede, _grado  INT(30) DEFAULT 0;
	DECLARE _sexo,_grupo VARCHAR(2) DEFAULT '';
			  
	DECLARE cur_mat CURSOR FOR SELECT COUNT(ti.edad) AS _total, ti.edad
   FROM inscripciones AS ti
	LEFT JOIN matriculas AS tm ON tm.cod_est = ti.cod_est
	LEFT JOIN sedes AS ts ON tm.id_sede = ts.ID
	WHERE tm.año=`_año` AND tm.id_inst = _id_inst AND tm.id_estado=2 
	AND tm.id_grado = _grado AND tm.grupo = _grupo AND tm.id_jorn = _jorn AND tm.id_sede = _sede
	AND ti.sexo = _sexo
	GROUP BY tm.id_grado, tm.grupo, tm.id_jorn,ti.sexo,ti.edad, tm.id_sede 
	ORDER BY tm.id_sede,tm.id_grado, tm.grupo, tm.id_jorn,ti.sexo,ti.edad;	
	
	DECLARE cur	CURSOR FOR SELECT tm.año,tm.id_grado, tm.grupo, ti.sexo, tm.id_jorn , tm.id_sede
   FROM inscripciones AS ti
	LEFT JOIN matriculas AS tm ON tm.cod_est = ti.cod_est
	LEFT JOIN sedes AS ts ON tm.id_sede = ts.ID
	LEFT JOIN grados AS tg ON tm.id_grado = tg.id
	WHERE tm.año=`_año` AND tm.id_inst = _id_inst AND tm.id_estado=2 
	GROUP BY tm.id_grado, tm.grupo, tm.id_jorn,ti.sexo, tm.id_sede 
	ORDER BY tm.id_sede,tm.id_grado, tm.grupo, tm.id_jorn,ti.sexo;
	
	DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done = 1;
	
	UPDATE inscripciones SET edad=FLOOR(TIMESTAMPDIFF(YEAR, fecha_nacimiento, CURDATE())) WHERE 1 AND id_inst= _id_inst;
	UPDATE inscripciones SET sexo = "X" WHERE 1 AND id_inst= _id_inst AND sexo = "";
	DELETE FROM estadistica_edades WHERE id_inst = _id_inst AND año = `_año`;
	
	OPEN cur;
	REPEAT
		FETCH cur INTO x_año, _grado, _grupo, _sexo, _jorn, _sede;
		IF NOT done THEN	
			OPEN cur_mat;
			SET s0 = 0;
			SET s1 = 0;
			SET s2 = 0;
			SET s3 = 0;
			SET s4 = 0;
			SET s5 = 0;
			SET s6 = 0;
			SET s7 = 0;
			SET s8 = 0;
			SET s9 = 0; 
			SET s10 = 0; 
			SET s11 = 0;SET s12 = 0;SET s13 = 0;SET s14 = 0;
			SET s15 = 0;SET s16 = 0;SET s17 = 0;SET s18 = 0;
			SET s19 = 0;SET s20 = 0;SET _cant= 0;
			REPEAT 
				FETCH cur_mat INTO _total, _edad;
				IF NOT done THEN 
					SET _cant= _cant + _total;										
					CASE 
						WHEN _edad BETWEEN 0 AND 1 AND NOT _sexo = "" THEN
							SET s0= (_total);
						WHEN _edad = 2 AND NOT _sexo = "" THEN
							SET s1= (_total);
						WHEN  _edad = 3 AND NOT _sexo = "" THEN 
							SET s2= (_total);
						WHEN  _edad=4 AND NOT _sexo = "" THEN 
							SET s3= (_total);
						WHEN  _edad=5 AND NOT _sexo = "" THEN 
							SET s4= (_total);
						WHEN  _edad=6 AND NOT _sexo = "" THEN 
							SET s5= (_total);
						WHEN  _edad=7 AND NOT _sexo = "" THEN 
							SET s6= (_total);
						WHEN  _edad=8 AND NOT _sexo = "" THEN 
							SET s7= (_total); 
						WHEN  _edad=9 AND NOT _sexo = "" THEN 
							SET s8= (_total);	
						WHEN  _edad=10 AND NOT _sexo = "" THEN 
							SET s9= (_total);
						WHEN  _edad=11 AND NOT _sexo = "" THEN 
							SET s10= (_total);	
						WHEN  _edad=12 AND NOT _sexo = "" THEN 
							SET s11= (_total);
						WHEN  _edad=13 AND NOT _sexo = "" THEN 
							SET s12= (_total); 	
						WHEN  _edad=14 AND NOT _sexo = "" THEN 
							SET s13= (_total); 
						WHEN  _edad=15 AND NOT _sexo = "" THEN 
							SET s14= (_total); 	
						WHEN  _edad=16 AND NOT _sexo = "" THEN 
							SET s15= (_total);
						WHEN  _edad=17 AND NOT _sexo = "" THEN 
							SET s16= (_total); 	
						WHEN  _edad=18 AND NOT _sexo = "" THEN 
							SET s17= (_total); 	
						WHEN  _edad>18 AND NOT _sexo = "" THEN 
							SET s18=s18+ (_total);	
						WHEN  _edad=0 AND NOT _sexo = "" THEN 
							SET s19=s19+ (_total); 	 
						WHEN  _edad >= 0 AND _sexo = "" THEN
							SET s20=s20+ (_total);						
					END CASE;
				END IF;
			UNTIL done END REPEAT;
			CLOSE cur_mat;
			INSERT INTO estadistica_edades (id_inst,id_sede,cod_grado,grupo,id_jorn,año,sexo,e1,e2,e3,e4,e5,e6,e7,e8,e9,e10,
													  e11,e12,e13,e14,e15,e16,e17,e18,e19,sf,ss,total) VALUES 
													  (_id_inst,_sede,_grado,_grupo,_jorn,_año,_sexo,s0,s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,
													  s11,s12,s13,s14,s15,s16,s17,s18,s19,s20,_cant);
			SET done = 0;
		END IF;	
	UNTIL done END REPEAT;
	CLOSE cur;	
	
	SELECT t.*, RTRIM(tg.grado) grado, RTRIM(tj.JORNADA) jornada, RTRIM(ts.NOM_SEDE) sede
	FROM estadistica_edades AS t 
	LEFT JOIN grados AS tg ON t.cod_grado = tg.id 
	LEFT JOIN jornadas AS tj ON t.id_jorn = tj.cod_jorn
	LEFT JOIN sedes AS ts ON t.id_sede = ts.ID 
	WHERE t.id_inst = _id_inst AND t.`año` = `_año` 
	ORDER BY sede,t.cod_grado,grupo,jornada;
END$$

DROP PROCEDURE IF EXISTS `sp_select_estudiantes_jorn`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_select_estudiantes_jorn` (IN `_id_inst` INT(30), IN `_año` YEAR)  BEGIN
	SELECT  COUNT(tm.id_grado) AS Total,tg.cod_grado, tm.grupo, tm.id_jorn , tm.año,
	RTRIM(tg.grado) grado, RTRIM(tj.jornada) jornada, RTRIM(ts.NOM_SEDE) sede 
	FROM matriculas AS tm
	LEFT JOIN grados AS tg ON tm.id_grado = tg.id 
	LEFT JOIN jornadas AS tj ON tm.id_jorn = tj.cod_jorn
	LEFT JOIN sedes AS ts ON tm.id_sede = ts.ID
	WHERE tm.id_inst = _id_inst AND tm.`año` = `_año`AND tm.id_estado = 2 
	GROUP BY tm.id_inst, tm.id_sede, tm.id_grado, tm.grupo, tm.id_jorn, tm.año 
	ORDER BY sede, tm.id_grado,tm.id_jorn,tm.grupo;
END$$

DROP PROCEDURE IF EXISTS `sp_select_estudiantes_sin_notas`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_select_estudiantes_sin_notas` (IN `_id_inst` INT(30), IN `_año` YEAR)  BEGIN
	(SELECT CONCAT(RTRIM(ti.apellido1),' ',RTRIM(ti.apellido2),' ',RTRIM(ti.nombre1),' ',RTRIM(ti.nombre2)) as estudiante,
		RTRIM(tg.grado) grado,tm.grupo, RTRIM(tj.JORNADA) jornada, RTRIM(ts.NOM_SEDE) sede, RTRIM(tas.asignatura) asignatura,
		RTRIM(tar.area) area, tn.final,
		CONCAT(RTRIM(td.apellido1),' ',RTRIM(td.apellido2),' ',RTRIM(td.nombre1),' ',RTRIM(td.nombre2)) as docente, tn.periodo 
		FROM inscripciones ti 
		LEFT JOIN matriculas AS tm ON tm.cod_est = ti.cod_est 
		LEFT JOIN grados AS tg ON tm.id_grado = tg.id 
		LEFT JOIN jornadas AS tj ON tm.id_jorn = tj.COD_JORN 
		LEFT JOIN sedes AS ts ON tm.id_sede = ts.ID 
		LEFT JOIN nscp001 AS tn ON tn.id_matric = tm.id_matric 
		LEFT JOIN cursos AS tc ON (tn.id_curso = tc.id AND tn.`año` = tc.`año`)
		LEFT JOIN asignaturas AS tas ON tc.id_asig = tas.id_pk 
		LEFT JOIN areas AS tar ON tas.id_area = tar.id 
		LEFT JOIN docentes AS td ON tc.id_docente = td.id_docente 
		WHERE ti.id_inst = _id_inst AND tm.id_inst = _id_inst AND tm.año = `_año` AND tm.id_estado = 2 
		AND ts.id_inst = _id_inst AND tas.id_inst = _id_inst AND tar.id_inst=_id_inst 
		AND tn.final = 0 AND tn.id_inst = _id_inst AND tc.`año` = `_año` AND tc.estado = 1
		AND td.id_inst = _id_inst AND td.`año` = `_año`) 
		UNION 
		(SELECT CONCAT(RTRIM(ti.apellido1),' ',RTRIM(ti.apellido2),' ',RTRIM(ti.nombre1),' ',RTRIM(ti.nombre2)) as estudiante,
		RTRIM(tg.grado) grado,tm.grupo, RTRIM(tj.JORNADA) jornada, RTRIM(ts.NOM_SEDE) sede, RTRIM(tas.asignatura) asignatura,
		RTRIM(tar.area) area, tn.final,
		CONCAT(RTRIM(td.apellido1),' ',RTRIM(td.apellido2),' ',RTRIM(td.nombre1),' ',RTRIM(td.nombre2)) as docente, tn.periodo 
		FROM inscripciones ti 
		LEFT JOIN matriculas AS tm ON tm.cod_est = ti.cod_est 
		LEFT JOIN grados AS tg ON tm.id_grado = tg.id 
		LEFT JOIN jornadas AS tj ON tm.id_jorn = tj.COD_JORN 
		LEFT JOIN sedes AS ts ON tm.id_sede = ts.ID 
		LEFT JOIN nscp002 AS tn ON tn.id_matric = tm.id_matric 
		LEFT JOIN cursos AS tc ON (tn.id_curso = tc.id AND tn.`año` = tc.`año`)
		LEFT JOIN asignaturas AS tas ON tc.id_asig = tas.id_pk 
		LEFT JOIN areas AS tar ON tas.id_area = tar.id 
		LEFT JOIN docentes AS td ON tc.id_docente = td.id_docente 
		WHERE ti.id_inst = _id_inst AND tm.id_inst = _id_inst AND tm.año = `_año` AND tm.id_estado = 2 
		AND ts.id_inst = _id_inst AND tas.id_inst = _id_inst AND tar.id_inst=_id_inst 
		AND tn.final = 0 AND tn.id_inst = _id_inst AND tc.`año` = `_año` AND tc.estado = 1
		AND td.id_inst = _id_inst AND td.`año` = `_año`) 
		UNION 
		(SELECT CONCAT(RTRIM(ti.apellido1),' ',RTRIM(ti.apellido2),' ',RTRIM(ti.nombre1),' ',RTRIM(ti.nombre2)) as estudiante,
		RTRIM(tg.grado) grado,tm.grupo, RTRIM(tj.JORNADA) jornada, RTRIM(ts.NOM_SEDE) sede, RTRIM(tas.asignatura) asignatura,
		RTRIM(tar.area) area, tn.final,
		CONCAT(RTRIM(td.apellido1),' ',RTRIM(td.apellido2),' ',RTRIM(td.nombre1),' ',RTRIM(td.nombre2)) as docente, tn.periodo 
		FROM inscripciones ti 
		LEFT JOIN matriculas AS tm ON tm.cod_est = ti.cod_est 
		LEFT JOIN grados AS tg ON tm.id_grado = tg.id 
		LEFT JOIN jornadas AS tj ON tm.id_jorn = tj.COD_JORN 
		LEFT JOIN sedes AS ts ON tm.id_sede = ts.ID 
		LEFT JOIN nscp003 AS tn ON tn.id_matric = tm.id_matric 
		LEFT JOIN cursos AS tc ON (tn.id_curso = tc.id AND tn.`año` = tc.`año`)
		LEFT JOIN asignaturas AS tas ON tc.id_asig = tas.id_pk 
		LEFT JOIN areas AS tar ON tas.id_area = tar.id 
		LEFT JOIN docentes AS td ON tc.id_docente = td.id_docente
		WHERE ti.id_inst = _id_inst AND tm.id_inst = _id_inst AND tm.año = `_año` AND tm.id_estado = 2 
		AND ts.id_inst = _id_inst AND tas.id_inst = _id_inst AND tar.id_inst=_id_inst 
		AND tn.final = 0 AND tn.id_inst = _id_inst AND tc.`año` = `_año` AND tc.estado = 1
		AND td.id_inst = _id_inst AND td.`año` = `_año`)
		ORDER BY sede,grado,grupo,jornada,estudiante,docente,asignatura,periodo;		
END$$

DROP PROCEDURE IF EXISTS `sp_select_evaluacion_estudiantes`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_select_evaluacion_estudiantes` (IN `_id_inst` INT(30), IN `_año` YEAR, IN `_id_matric` INT(30))  BEGIN
	SELECT tec.id,tec.id_evaluacion,tec.id_matric,tec.leida,te.nombre,te.descripcion,te.num_preguntas,
	te.esquema,te.intentos,te.tiempo,te.paginas,te.hora_apertura,te.hora_cierre,te.fecha_cierre,te.fecha,
	te.publicada,te.auto_calificar,te.column_nota,te.id_column_nota,te.periodo,RTRIM(ta.asignatura) asignatura,
	tm.cod_grado, tm.grupo, tg.grado,RTRIM(tj.JORNADA) jornada, RTRIM(ts.NOM_SEDE) sede,
	CONCAT(RTRIM(td.apellido1),' ',RTRIM(td.apellido2),' ',RTRIM(td.nombre1),' ',RTRIM(td.nombre2)) docente
	FROM te_evaluacion_compartida tec 
	LEFT JOIN te_evaluaciones AS te ON tec.id_evaluacion = te.id
	LEFT JOIN cursos AS tc ON te.id_curso=tc.id 
	LEFT JOIN asignaturas AS ta ON tc.id_asig = ta.id
	LEFT JOIN matriculas AS tm ON tec.id_matric = tm.id_matric
	LEFT JOIN docentes AS td ON tc.id_docente = td.id_docente 
	LEFT JOIN sedes AS ts ON (tc.id_sede = ts.ID AND tm.id_sede = ts.ID)
	LEFT JOIN grados AS tg ON (tc.cod_grado = tg.COD_GRADO AND tm.cod_grado = tg.COD_GRADO)
	LEFT JOIN jornadas AS tj ON (tc.cod_jorn = tj.COD_JORN AND tm.id_jorn = tj.COD_JORN)
	WHERE te.estado = 1 AND te.publicada = 1 AND tc.id_inst = _id_inst AND tc.`año` = `_año` AND tc.estado = 1 AND
	ta.id_inst = _id_inst AND ta.`año` = `_año` AND ta.estado = 1 AND 
	tm.id_inst = _id_inst AND tm.id_matric = _id_matric AND tm.estado = 2 AND td.id_inst = _id_inst 
	AND td.`año` = `_año` AND td.estado = 1 AND ts.ID_INST = _id_inst;
END$$

DROP PROCEDURE IF EXISTS `sp_select_familia_ficha`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_select_familia_ficha` ()  BEGIN

END$$

DROP PROCEDURE IF EXISTS `sp_select_fechas_nac_report`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_select_fechas_nac_report` (IN `_id_inst` INT(30), IN `_año` YEAR, IN `_id_sede` INT(30), IN `_grado` INT(11), IN `_grupo` VARCHAR(2), IN `_jorn` INT(1), IN `type` INT)  BEGIN
	IF `type` = 1 THEN /*Ordor by fecha_nacimiento*/
	 	 SELECT ti.cod_est, ti.nro_doc_id, 
		 CONCAT(RTRIM(ti.apellido1),' ',RTRIM(ti.apellido2),' ',RTRIM(ti.nombre1),' ',RTRIM(ti.nombre2)) nombres, 
		 RTRIM(tg.grado) grado, tm.grupo, RTRIM(tj.JORNADA) jornada, ti.sexo, ti.fecha_nacimiento, ti.telefono,
		 FLOOR(TIMESTAMPDIFF(YEAR,fecha_nacimiento, CURDATE())) edad , RTRIM(ts.NOM_SEDE) sede
		 FROM inscripciones AS ti 
		 LEFT JOIN matriculas AS tm ON tm.cod_est = ti.cod_est
		 LEFT JOIN grados AS tg ON tm.id_grado = tg.id
		 LEFT JOIN jornadas AS tj ON tm.id_jorn = tj.cod_jorn
		 LEFT JOIN sedes AS ts ON tm.id_sede = ts.ID
		 WHERE tm.id_grado=_grado AND tm.id_sede= _id_sede
		 AND tm.año= `_año` AND tm.id_estado=2 AND tm.id_inst = _id_inst
		 AND tm.id_jorn= _jorn AND tm.grupo= _grupo AND ti.id_inst = _id_inst
		 AND ts.ID_INST = _id_inst
		 ORDER BY ti.fecha_nacimiento;
	ELSE /*Ordor by nombres*/
		 SELECT ti.cod_est, ti.nro_doc_id, 
		 CONCAT(RTRIM(ti.apellido1),' ',RTRIM(ti.apellido2),' ',RTRIM(ti.nombre1),' ',RTRIM(ti.nombre2)) nombres, 
		 RTRIM(tg.grado) grado, tm.grupo, RTRIM(tj.JORNADA) jornada, ti.sexo, ti.fecha_nacimiento, ti.telefono,
		 FLOOR(TIMESTAMPDIFF(YEAR,fecha_nacimiento, CURDATE())) edad , RTRIM(ts.NOM_SEDE) sede
		 FROM inscripciones AS ti 
		 LEFT JOIN matriculas AS tm ON tm.cod_est = ti.cod_est
		 LEFT JOIN grados AS tg ON tm.id_grado = tg.id
		 LEFT JOIN jornadas AS tj ON tm.id_jorn = tj.cod_jorn
		 LEFT JOIN sedes AS ts ON tm.id_sede = ts.ID
		 WHERE tm.id_grado=_grado AND tm.id_sede= _id_sede
		 AND tm.año= `_año` AND tm.id_estado=2 AND tm.id_inst = _id_inst
		 AND tm.id_jorn= _jorn AND tm.grupo= _grupo AND ti.id_inst = _id_inst
		 AND ts.ID_INST = _id_inst
		 ORDER BY nombres;
	END IF;
END$$

DROP PROCEDURE IF EXISTS `sp_select_ficha_matricula`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_select_ficha_matricula` (IN `_id_inst` INT(20), IN `_año` YEAR, IN `_id_est` INT(20), IN `_grado` INT(11), IN `_grupo` VARCHAR(2), IN `_sede` INT(30), IN `_jorn` INT(1), IN `_tipo` INT(1))  BEGIN
	IF _tipo = 1 THEN
		SELECT ti.*,tg.cod_grado,ts.cons_sede, RTRIM(ts.NOM_SEDE) sede,tm.año,
		te.estado_matricula AS estado,tm.id_jorn,tm.grupo,td.nombre AS dpto,upper(tde.nombre) AS dpto_e,
		tc.nombre_mun AS mun, tce.nombre_mun AS mun_e,tj.jornada,
		tm.fecha As fecha_m,tm.ins_proced,
		tm.dir_inst,tm.id_folio, tm.nro_matricula, tm.libro_mat, 
		tz.tipo AS zona, tdoc.tipo as documento, tdoc.abrev AS abrev_doc, tg.grado 
		FROM inscripciones AS ti 
		LEFT JOIN departamentos AS td ON ti.dpto_lug_nac=td.id 
	 	LEFT JOIN ciudades AS tc  ON (ti.mun_lug_nac=tc.id AND tc.dpto=ti.dpto_lug_nac) 
	 	LEFT JOIN departamentos AS tde ON ti.dpto_lug_exp=tde.id 
	 	LEFT JOIN ciudades AS tce  ON (ti.mun_lug_exp=tce.id AND tce.dpto=ti.dpto_lug_exp) 
		LEFT JOIN matriculas AS tm ON tm.cod_est=ti.cod_est 
		LEFT JOIN jornadas AS tj ON tm.id_jorn=tj.cod_jorn 
		LEFT JOIN sedes AS ts ON tm.id_sede=ts.id 
		LEFT JOIN estado_matricula AS te ON tm.id_estado = te.id 
		LEFT JOIN zona AS tz ON ti.id_zona = tz.id_zona 
		LEFT JOIN documentos AS tdoc ON ti.cod_doc = tdoc.id 
		LEFT JOIN grados AS tg ON tm.id_grado = tg.id 
		WHERE  tm.año= `_año` AND tm.id_estado <> 1 AND ti.cod_est = _id_est 
		AND tm.id_inst = _id_inst AND ti.id_inst = _id_inst AND  ts.ID_INST = _id_inst
		ORDER BY apellido1,apellido2,nombre1,nombre2 LIMIT 1;
	ELSE
		SELECT ti.*,tg.cod_grado,ts.cons_sede,RTRIM(ts.NOM_SEDE) sede,tm.año,
		te.estado_matricula AS estado,tm.id_jorn,tm.grupo,td.nombre AS dpto,upper(tde.nombre) AS dpto_e,
		tc.nombre_mun AS mun, tce.nombre_mun AS mun_e,tj.jornada,
		tm.fecha As fecha_m,tm.ins_proced,
		tm.dir_inst,tm.id_folio, tm.nro_matricula, tm.libro_mat, 
		tz.tipo AS zona, tdoc.tipo as documento, tdoc.abrev AS abrev_doc, tg.grado 
		FROM inscripciones AS ti 
		LEFT JOIN departamentos AS td ON ti.dpto_lug_nac=td.id 
	 	LEFT JOIN ciudades AS tc  ON (ti.mun_lug_nac=tc.id AND tc.dpto=ti.dpto_lug_nac) 
	 	LEFT JOIN departamentos AS tde ON ti.dpto_lug_exp=tde.id 
	 	LEFT JOIN ciudades AS tce  ON (ti.mun_lug_exp=tce.id AND tce.dpto=ti.dpto_lug_exp)
		LEFT JOIN matriculas AS tm ON tm.cod_est=ti.cod_est 
		LEFT JOIN jornadas AS tj ON tm.id_jorn=tj.cod_jorn 
		LEFT JOIN sedes AS ts ON tm.id_sede=ts.id 
		LEFT JOIN estado_matricula AS te ON tm.id_estado = te.id 
		LEFT JOIN zona AS tz ON ti.id_zona = tz.id_zona 
		LEFT JOIN documentos AS tdoc ON ti.cod_doc = tdoc.id
		LEFT JOIN grados AS tg ON tm.id_grado = tg.id 
		WHERE  tm.año= `_año` AND tm.id_estado <> 1
		AND tm.id_inst = _id_inst AND ti.id_inst = _id_inst AND ts.ID_INST = _id_inst
		AND tm.id_grado = _grado AND tm.grupo = _grupo AND tm.id_sede = _sede AND tm.id_jorn = _jorn
		ORDER BY apellido1,apellido2,nombre1,nombre2 LIMIT 60;
	END IF;
END$$

DROP PROCEDURE IF EXISTS `sp_select_historial_matriculas`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_select_historial_matriculas` (IN `_id_inst` INT(20), IN `_cod_est` INT(20))  BEGIN
	SELECT tm.id_matric, tm.cod_est, tm.fecha, tm.id_grado, tm.grupo, tm.`año`,
	TRIM(tg.grado) AS grado, RTRIM(tj.JORNADA) AS jornada, RTRIM(ts.NOM_SEDE) AS sede, 
	te.estado_matricula AS estado, tm.id_folio, tm.libro_mat, tm.nro_matricula, ta.msg
	FROM matriculas AS tm
	LEFT JOIN grados AS tg ON tm.id_grado = tg.id
	LEFT JOIN jornadas AS tj ON tm.id_jorn = tj.cod_jorn
	LEFT JOIN sedes AS ts ON tm.id_sede = ts.ID
	LEFT JOIN estado_matricula AS te on tm.id_estado = te.id
	LEFT JOIN acta_promocion AS ta ON tm.id_matric =  ta.id_matric 
	WHERE tm.id_inst = _id_inst AND tm.cod_est = _cod_est  
	ORDER BY tm.`año`;
END$$

DROP PROCEDURE IF EXISTS `sp_select_indicadores_estudiante_boletin`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_select_indicadores_estudiante_boletin` (IN `_id_inst` INT(20), IN `_año` YEAR, IN `_cod_grado` TINYINT, IN `_periodo` VARCHAR(2), IN `_id_nota` INT(30), IN `type` INT)  BEGIN
	DECLARE cTable, cTable2	VARCHAR(30) DEFAULT '';
	SELECT fn_return_table_notas(_cod_grado) INTO cTable;
	SELECT fn_return_table_logros_indicadores(_cod_grado) INTO cTable2;
	SET @sqlSelect = CONCAT("SELECT RTRIM(tl.descripcion) AS descripcion, tl.tipo, 
		UPPER(tt.nombre_proceso) nombre_proceso
		FROM logros_estandares AS tl 
		LEFT JOIN ",cTable2," AS tg ON tg.id_logro_estandar = tl.id 
		LEFT JOIN ",cTable," AS tn ON tg.id_nota = tn.id
		LEFT JOIN tipo_procesos_educativos AS tt ON tl.tipo = tt.id
		WHERE tl.id_inst = ",_id_inst," AND tl.año = ",_año ,"
		AND tl.periodo ='",_periodo,"' AND tg.id_nota = ",_id_nota," AND tn.periodo = '",_periodo,"'
		AND tl.tipo NOT BETWEEN 1 AND 2 AND tl.id_competencia BETWEEN 0 AND 4 ORDER BY tl.tipo,tl.descripcion");
	PREPARE smtp FROM @sqlSelect;
	EXECUTE smtp;
	DEALLOCATE PREPARE smtp;
END$$

DROP PROCEDURE IF EXISTS `sp_select_indicadores_estudiante_boletin_comp`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_select_indicadores_estudiante_boletin_comp` (IN `_id_inst` INT(20), IN `_año` YEAR, IN `_cod_grado` INT(11), IN `_periodo` VARCHAR(2), IN `_id_nota` INT(30), IN `type` INT)  BEGIN
DECLARE cTable, cTable2	VARCHAR(30) DEFAULT '';
	SELECT fn_return_table_notas(_cod_grado) INTO cTable;
	SELECT fn_return_table_logros_indicadores(_cod_grado) INTO cTable2;
	SET @sqlSelect = CONCAT("SELECT RTRIM(tl.descripcion) AS descripcion, 
		RTRIM(tc.competencia) AS competencia, tl.tipo, 
		tc.id_pk,UPPER(tt.nombre_proceso) nombre_proceso,
		ROW_NUMBER() OVER (PARTITION BY tc.id ORDER BY tc.competencia DESC) AS row_num,
		(SELECT CONCAT('n',t.numero_column) FROM columnas_notas_competencias t
		WHERE t.id_competencia = tc.id_pk AND t.tipo = 'PROM' LIMIT 1) nota,
		(SELECT fn_return_table_notas(",_cod_grado,")) tabla
		FROM logros_estandares AS tl 
		LEFT JOIN competencias AS tc on tl.id_competencia = tc.id
		LEFT JOIN grados_agrupados AS t1 ON tc.id_grado_agrupado = t1.id
		LEFT JOIN aux_grados_agrupados AS t2 ON t2.id_grado_agrupado = t1.id
		LEFT JOIN ",cTable2," AS tg ON tg.id_logro_estandar = tl.id 
		LEFT JOIN ",cTable," AS tn ON tg.id_nota = tn.id
		LEFT JOIN tipo_procesos_educativos AS tt ON tl.tipo = tt.id
		WHERE tl.id_inst = ",_id_inst," AND tl.año = ",_año ,"
		AND tl.periodo ='",_periodo,"' AND tg.id_nota = ",_id_nota," AND tn.periodo = '",_periodo,"'
		AND tl.tipo > 2 AND tl.id_competencia > 0 AND tc.`año` =",`_año`," AND t2.id_grado =",_cod_grado,
		" ORDER BY tl.id_competencia, tl.tipo");
	PREPARE smtp FROM @sqlSelect;
	EXECUTE smtp;
	DEALLOCATE PREPARE smtp;
END$$

DROP PROCEDURE IF EXISTS `sp_select_indicadores_estudiante_boletin_proy`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_select_indicadores_estudiante_boletin_proy` (IN `_id_inst` INT(20), IN `_año` YEAR, IN `_cod_grado` VARCHAR(2) charset utf8, IN `_periodo` VARCHAR(1) charset utf8, IN `_id_nota` INT(30), IN `type` INT)  BEGIN
	CASE 
		WHEN _cod_grado >= '01' AND _cod_grado <= '05' THEN 
				SELECT tl.id,RTRIM(tl.descripcion) AS descripcion, RTRIM(tc.competencia) AS competencia, tl.tipo,tc.foto
				FROM logros_estandares AS tl 
				left join competencias AS tc on tl.id_competencia = tc.id 
				left join log_nscp001 AS tg ON tg.id_logro_estandar = tl.id 
				left join nscp001 AS tn ON tg.id_nota = tn.id 
				WHERE tl.id_inst = _id_inst AND tl.año  = _año and tl.cod_grado=_cod_grado
				and tc.año = _año and tc.id_inst = _id_inst and tg.id_nota = _id_nota
				AND tl.tipo > 2 AND tn.periodo = _periodo AND tl.periodo = _periodo 
				AND tl.id_competencia BETWEEN 5 AND 9 
				order by tl.tipo, tl.descripcion;
		WHEN _cod_grado >= '06' AND _cod_grado <= '09' THEN 
				SELECT tl.id,RTRIM(tl.descripcion) AS descripcion, RTRIM(tc.competencia) AS competencia, tl.tipo,tc.foto
				FROM logros_estandares AS tl 
				left join competencias AS tc on tl.id_competencia = tc.id 
				left join log_nscp002 AS tg ON tg.id_logro_estandar = tl.id 
				left join nscp002 AS tn ON tg.id_nota = tn.id 
				WHERE tl.id_inst = _id_inst AND tl.año  = _año and tl.cod_grado=_cod_grado
				and tc.año = _año and tc.id_inst = _id_inst and tg.id_nota = _id_nota
				AND tl.tipo > 2 AND tn.periodo = _periodo AND tl.periodo = _periodo
				AND tl.id_competencia BETWEEN 5 AND 9
				order by tl.tipo, tl.descripcion;
		WHEN _cod_grado >= '10' THEN
				SELECT tl.id,RTRIM(tl.descripcion) AS descripcion, RTRIM(tc.competencia) AS competencia, tl.tipo,tc.foto
				FROM logros_estandares AS tl 
				left join competencias AS tc on tl.id_competencia = tc.id 
				left join log_nscp003 AS tg ON tg.id_logro_estandar = tl.id 
				left join nscp003 AS tn ON tg.id_nota = tn.id 
				WHERE tl.id_inst = _id_inst AND tl.año  = _año and tl.cod_grado=_cod_grado
				and tc.año = _año and tc.id_inst = _id_inst and tg.id_nota = _id_nota
				AND tl.tipo > 2 AND tn.periodo = _periodo AND tl.periodo = _periodo
				AND tl.id_competencia BETWEEN 5 AND 9
				order by tl.tipo, tl.descripcion;
		ELSE
				SELECT tl.id,RTRIM(tl.descripcion) AS descripcion, RTRIM(tc.competencia) AS competencia, tl.tipo,tc.foto
				FROM logros_estandares AS tl 
				left join competencias AS tc on tl.id_competencia = tc.id 
				left join log_nscp00 AS tg ON tg.id_logro_estandar = tl.id 
				left join nscp00 AS tn ON tg.id_nota = tn.id 
				WHERE tl.id_inst = _id_inst AND tl.año  = _año and tl.cod_grado=_cod_grado
				and tc.año = _año and tc.id_inst = _id_inst and tg.id_nota = _id_nota
				AND tl.tipo > 2 AND tn.periodo = _periodo AND tl.periodo = _periodo
				AND tl.id_competencia BETWEEN 5 AND 9
				order by tl.tipo, tl.descripcion;
	END CASE;
END$$

DROP PROCEDURE IF EXISTS `sp_select_items_bol`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_select_items_bol` (IN `_id_inst` INT(20), IN `_cod_grado` VARCHAR(2) CHARSET utf8, IN `_periodo` VARCHAR(1) charset utf8, IN `_año` YEAR, IN `_type` INT(1))  BEGIN
	CASE _type 
		WHEN 1  THEN 
            if _cod_grado >= '10' then
				SELECT tl.*, tc.competencia, td.desempeño, tg.* 
                FROM logros_estandares AS tl 
				left join competencias AS tc on tl.id_competencia = tc.id 
				left join desempeños AS td ON tl.id_desempeño = td.id 
				left join log_nscp003 AS tg ON tg.id_logro_estandar = tl.id 
				where tl.id_inst=_id_inst and tl.año=_año and tl.cod_grado=_cod_grado 
				and tc.año=_año and tc.id_inst=_id_inst and td.id_inst=_id_inst and td.año=_año 
				and tl.periodo = _periodo AND tl.tipo=2  
				order by tl.tipo, tl.periodo, tl.asignacion, tl.consecutivo;
			elseif _cod_grado >= '06' AND _cod_grado <= '09' then				
				SELECT tl.*, tc.competencia, td.desempeño, tg.* 
                FROM logros_estandares AS tl 
				left join competencias AS tc on tl.id_competencia = tc.id 
				left join desempeños AS td ON tl.id_desempeño = td.id 
				left join log_nscp002 AS tg ON tg.id_logro_estandar = tl.id 
				where tl.id_inst=_id_inst and tl.año=_año and tl.cod_grado=_cod_grado 
				and tc.año=_año and tc.id_inst=_id_inst and td.id_inst=_id_inst and td.año=_año 
				and tl.periodo = _periodo AND tl.tipo=2 
				order by tl.tipo, tl.periodo, tl.asignacion, tl.consecutivo;
			elseif _cod_grado >= '01' AND _cod_grado <= '05' then
				SELECT tl.*, tc.competencia, td.desempeño, tg.* 
                FROM logros_estandares AS tl 
				left join competencias AS tc on tl.id_competencia = tc.id 
				left join desempeños AS td ON tl.id_desempeño = td.id 
				left join log_nscp001 AS tg ON tg.id_logro_estandar = tl.id 
				where tl.id_inst=_id_inst and tl.año=_año and tl.cod_grado=_cod_grado 
				and tc.año=_año and tc.id_inst=_id_inst and td.id_inst=_id_inst and td.año=_año 
				and tl.periodo = _periodo AND tl.tipo=2 
				order by tl.tipo, tl.periodo, tl.asignacion, tl.consecutivo;
			else 
				SELECT tl.*, tc.competencia, td.desempeño, tg.* 
                FROM logros_estandares AS tl 
				left join competencias AS tc on tl.id_competencia = tc.id 
				left join desempeños AS td ON tl.id_desempeño = td.id 
				left join log_nscp00 AS tg ON tg.id_logro_estandar = tl.id 
				where tl.id_inst=_id_inst and tl.año=_año and tl.cod_grado=_cod_grado 
				and tc.año=_año and tc.id_inst=_id_inst and td.id_inst=_id_inst and td.año=_año 
				and tl.periodo = _periodo AND tl.tipo=2
				order by tl.tipo, tl.periodo, tl.asignacion, tl.consecutivo;
			end if;
		WHEN 2  THEN
			if _cod_grado >= '10' then
				SELECT tl.*, tc.competencia, td.desempeño, tg.* 
                FROM logros_estandares AS tl 
				left join competencias AS tc on tl.id_competencia = tc.id 
				left join desempeños AS td ON tl.id_desempeño = td.id 
				left join log_nscp003 AS tg ON tg.id_logro_estandar = tl.id 
				where tl.id_inst=_id_inst and tl.año=_año and tl.cod_grado=_cod_grado 
				and tc.año=_año and tc.id_inst=_id_inst and td.id_inst=_id_inst and td.año=_año 
				and tl.periodo = _periodo AND tl.tipo > 2 
				order by tg.id_nota, tl.id_competencia;
			elseif _cod_grado >= '06' AND _cod_grado <= '09' then				
				SELECT tl.*, tc.competencia, td.desempeño, tg.* 
                FROM logros_estandares AS tl 
				left join competencias AS tc on tl.id_competencia = tc.id 
				left join desempeños AS td ON tl.id_desempeño = td.id 
				left join log_nscp002 AS tg ON tg.id_logro_estandar = tl.id 
				where tl.id_inst=_id_inst and tl.año=_año and tl.cod_grado=_cod_grado 
				and tc.año=_año and tc.id_inst=_id_inst and td.id_inst=_id_inst and td.año=_año 
				and tl.periodo = _periodo AND tl.tipo > 2
				order by tg.id_nota, tl.id_competencia;
			elseif _cod_grado >= '01' AND _cod_grado <= '05' then
				SELECT tl.*, tc.competencia, td.desempeño, tg.* 
                FROM logros_estandares AS tl 
				left join competencias AS tc on tl.id_competencia = tc.id 
				left join desempeños AS td ON tl.id_desempeño = td.id 
				left join log_nscp001 AS tg ON tg.id_logro_estandar = tl.id 
				where tl.id_inst=_id_inst and tl.año=_año and tl.cod_grado=_cod_grado 
				and tc.año=_año and tc.id_inst=_id_inst and td.id_inst=_id_inst and td.año=_año 
				and tl.periodo = _periodo AND tl.tipo > 2
				order by tg.id_nota, tl.id_competencia;
			else 
				SELECT tl.*, tc.competencia, td.desempeño, tg.* 
                FROM logros_estandares AS tl 
				left join competencias AS tc on tl.id_competencia = tc.id 
				left join desempeños AS td ON tl.id_desempeño = td.id 
				left join log_nscp00 AS tg ON tg.id_logro_estandar = tl.id 
				where tl.id_inst=_id_inst and tl.año=_año and tl.cod_grado=_cod_grado 
				and tc.año=_año and tc.id_inst=_id_inst and td.id_inst=_id_inst and td.año=_año 
				and tl.periodo = _periodo AND tl.tipo > 2 
				order by tg.id_nota, tl.id_competencia;
			end if;
        WHEN 3  THEN 
			if _cod_grado >= '10' then
				SELECT ts.*, tg.* FROM sugerencias AS ts 
				left join sug_nscp003 AS tg ON tg.id_sugerencia = ts.id 
				where ts.id_inst=_id_inst and ts.año=_año and ts.periodo= _periodo 
				order by ts.periodo, ts.tipo;
			elseif _cod_grado >= '06' AND _cod_grado <= '09' then				
				SELECT ts.*, tg.* FROM sugerencias AS ts 
				left join sug_nscp002 AS tg ON tg.id_sugerencia = ts.id 
				where ts.id_inst=_id_inst and ts.año=_año and ts.periodo= _periodo 
				order by ts.periodo, ts.tipo;
			elseif _cod_grado >= '01' AND _cod_grado <= '05' then
				SELECT ts.*, tg.* FROM sugerencias AS ts 
				left join sug_nscp001 AS tg ON tg.id_sugerencia = ts.id 
				where ts.id_inst=_id_inst and ts.año=_año and ts.periodo= _periodo 
				order by ts.periodo, ts.tipo;
			else 
				SELECT ts.*, tg.* FROM sugerencias AS ts 
				left join sug_nscp00 AS tg ON tg.id_sugerencia = ts.id 
				where ts.id_inst=_id_inst and ts.año=_año and ts.periodo= _periodo 
				order by ts.periodo, ts.tipo;
			end if;
        ELSE
			if _cod_grado >= '10' then
				SELECT tl.*, tc.competencia, td.desempeño, tg.* 
                FROM logros_estandares AS tl 
				left join competencias AS tc on tl.id_competencia = tc.id 
				left join desempeños AS td ON tl.id_desempeño = td.id 
				left join log_nscp003 AS tg ON tg.id_logro_estandar = tl.id 
				where tl.id_inst=_id_inst and tl.año=_año and tl.cod_grado=_cod_grado 
				and tc.año=_año and tc.id_inst=_id_inst and td.id_inst=_id_inst and td.año=_año 
				and tl.periodo = _periodo AND tl.tipo=1 
				order by tl.tipo, tl.periodo, tl.asignacion, tl.consecutivo;
			elseif _cod_grado >= '06' AND _cod_grado <= '09' then				
				SELECT tl.*, tc.competencia, td.desempeño, tg.* 
                FROM logros_estandares AS tl 
				left join competencias AS tc on tl.id_competencia = tc.id 
				left join desempeños AS td ON tl.id_desempeño = td.id 
				left join log_nscp002 AS tg ON tg.id_logro_estandar = tl.id 
				where tl.id_inst=_id_inst and tl.año=_año and tl.cod_grado=_cod_grado 
				and tc.año=_año and tc.id_inst=_id_inst and td.id_inst=_id_inst and td.año=_año 
				and tl.periodo = _periodo AND tl.tipo=1 
				order by tl.tipo, tl.periodo, tl.asignacion, tl.consecutivo;
			elseif _cod_grado >= '01' AND _cod_grado <= '05' then
				SELECT tl.*, tc.competencia, td.desempeño, tg.* 
                FROM logros_estandares AS tl 
				left join competencias AS tc on tl.id_competencia = tc.id 
				left join desempeños AS td ON tl.id_desempeño = td.id 
				left join log_nscp001 AS tg ON tg.id_logro_estandar = tl.id 
				where tl.id_inst=_id_inst and tl.año=_año and tl.cod_grado=_cod_grado 
				and tc.año=_año and tc.id_inst=_id_inst and td.id_inst=_id_inst and td.año=_año 
				and tl.periodo = _periodo AND tl.tipo=1 
				order by tl.tipo, tl.periodo, tl.asignacion, tl.consecutivo;
			else 
				SELECT tl.*, tc.competencia, td.desempeño, tg.* 
                FROM logros_estandares AS tl 
				left join competencias AS tc on tl.id_competencia = tc.id 
				left join desempeños AS td ON tl.id_desempeño = td.id 
				left join log_nscp00 AS tg ON tg.id_logro_estandar = tl.id 
				where tl.id_inst=_id_inst and tl.año=_año and tl.cod_grado=_cod_grado 
				and tc.año=_año and tc.id_inst=_id_inst and td.id_inst=_id_inst and td.año=_año 
				and tl.periodo = _periodo AND tl.tipo=1 
				order by tl.tipo, tl.periodo, tl.asignacion, tl.consecutivo;
			end if;
        END CASE;
END$$

DROP PROCEDURE IF EXISTS `sp_select_listado_diploma`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_select_listado_diploma` (IN `_id_inst` INT(20), IN `_id_sede` INT(20), IN `_cod_grado` VARCHAR(2), IN `_grupo` VARCHAR(2), IN `_id_jorn` INT(2), IN `_año` YEAR, IN `_matric` INT(30))  BEGIN
  DECLARE done, x_count, _libro INT(1) DEFAULT 0;
  DECLARE _id_mat INT(20) DEFAULT 0;
  DECLARE _nom VARCHAR(250) DEFAULT '';
  DECLARE _cur CURSOR FOR SELECT tm.id_matric,
		concat(rtrim(te.nombre1),' ',rtrim(te.nombre2),' ',rtrim(te.apellido1),' ',rtrim(te.apellido2)) 
	   as estudiantes FROM matriculas AS tm 
      LEFT JOIN acta_promocion AS tac ON tac.id_matric = tm.id_matric 
		LEFT JOIN sedes AS ts ON tm.id_sede=ts.id  
	   LEFT JOIN grados AS tg ON tm.cod_grado=tg.cod_grado 
		LEFT JOIN jornadas AS tj ON tm.id_jorn=tj.cod_jorn 
		LEFT JOIN inscripciones AS te ON tm.cod_est=te.cod_est 
		LEFT JOIN documentos AS td ON te.cod_doc = td.id  
		WHERE tm.año = _año  and tm.id_sede  =_id_sede and tm.cod_grado=_cod_grado and 
		tm.grupo=_grupo and tm.id_jorn=_id_jorn AND tm.estado = 2 AND 
		(tac.estado = 1 OR tac.estado = 4) AND tm.id_inst = _id_inst AND ts.ID_INST = _id_inst 
		ORDER BY estudiantes;
  DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done = 1;
  
  OPEN _cur;
  REPEAT
   FETCH _cur INTO _id_mat, _nom;
   IF NOT done THEN
      SET x_count = x_count + 1; 
      
	   IF _grupo = '01' OR _grupo = 'A' THEN 
	      SET _libro = 1;
	   ELSEIF _grupo = '02' OR _grupo = 'B' THEN 
	      SET _libro = 2;
	   ELSEIF _grupo = '03' OR _grupo = 'C' THEN 
	      SET _libro = 3;
	   ELSEIF _grupo = '04' OR _grupo = 'D' THEN 
	      SET _libro = 4;
	   ELSEIF _grupo = '05' OR _grupo = 'E' THEN 
	      SET _libro = 5;
	   ELSEIF _grupo = '06' OR _grupo = 'F' THEN 
	      SET _libro = 6;
	   ELSEIF _grupo = '07' OR _grupo = 'G' THEN 
	      SET _libro = 7;
	   ELSEIF _grupo = '08' OR _grupo = 'H' THEN 
	      SET _libro = 8;
	   ELSEIF _grupo = '09' OR _grupo = 'I' THEN 
	      SET _libro = 9;
	   ELSEIF _grupo = '10' OR _grupo = 'J' THEN 
	      SET _libro = 10;
	   ELSEIF _grupo = '11' OR _grupo = 'K' THEN 
	      SET _libro = 11;
	   ELSEIF _grupo = '12' OR _grupo = 'L' THEN 
	      SET _libro = 12;
	   ELSEIF _grupo = '13' OR _grupo = 'M' THEN 
	      SET _libro = 13;
	   ELSEIF _grupo = '14' OR _grupo = 'N' THEN 
	      SET _libro = 14;
	   ELSEIF _grupo = '15' OR _grupo = 'O' THEN 
	      SET _libro = 15;
	   ELSEIF _grupo = '16' OR _grupo = 'P' THEN 
	      SET _libro = 16;
	   ELSEIF _grupo = '17' OR _grupo = 'Q' THEN 
	      SET _libro = 17;
	   ELSEIF _grupo = '18' OR _grupo = 'R' THEN 
	      SET _libro = 18;
		ELSE
	      SET _libro = 1; 
	  END IF;
	  
	  UPDATE acta_promocion SET libro = _libro, folio = x_count WHERE id_matric = _id_mat; 
   END IF;
  UNTIL done END REPEAT;
  IF _matric > 0 THEN 
	SELECT tm.id_inst,tm.id_sede,tm.cod_grado,tm.grupo,tm.año,tm.id_matric,tm.id_folio,tm.nro_matricula,tm.libro_mat,
		RTRIM(ts.nom_sede) As sede,tg.grado,tj.jornada,
		concat(rtrim(te.nombre1),' ',rtrim(te.nombre2),' ',rtrim(te.apellido1),' ',rtrim(te.apellido2)) 
	   as estudiantes,te.cod_doc,td.tipo, td.abrev,te.sexo,te.nro_doc_id, tac.estado,
		tac.libro, tac.folio, UPPER(RTRIM(tdt.nombre)) dpto, UPPER(RTRIM(mun.nombre_mun)) mun
		FROM matriculas AS tm 
      LEFT JOIN acta_promocion AS tac ON tac.id_matric = tm.id_matric 
		LEFT JOIN sedes AS ts ON tm.id_sede=ts.id  
	   LEFT JOIN grados AS tg ON tm.cod_grado=tg.cod_grado 
		LEFT JOIN jornadas AS tj ON tm.id_jorn=tj.cod_jorn 
		LEFT JOIN inscripciones AS te ON tm.cod_est=te.cod_est 
		LEFT JOIN documentos AS td ON te.cod_doc = td.id  
		LEFT JOIN departamentos AS tdt ON te.dpto_lug_exp = tdt.id
		LEFT JOIN ciudades AS mun ON te.mun_lug_exp = mun.id
		WHERE tm.año = _año AND tm.id_sede  =_id_sede AND tm.cod_grado=_cod_grado AND
		tm.grupo=_grupo AND tm.id_jorn=_id_jorn AND tm.estado = 2 AND (tac.estado = 1 OR tac.estado = 4) AND 
		tm.id_inst = _id_inst AND ts.ID_INST = _id_inst AND tm.id_matric = _matric
		ORDER BY estudiantes;
	ELSE
		SELECT tm.id_inst,tm.id_sede,tm.cod_grado,tm.grupo,tm.año,tm.id_matric,tm.id_folio,tm.nro_matricula,tm.libro_mat,
		RTRIM(ts.nom_sede) As sede,tg.grado,tj.jornada,
		concat(rtrim(te.nombre1),' ',rtrim(te.nombre2),' ',rtrim(te.apellido1),' ',rtrim(te.apellido2)) 
	   as estudiantes,te.cod_doc,td.tipo, td.abrev,te.sexo,te.nro_doc_id, tac.estado,
		tac.libro, tac.folio, UPPER(RTRIM(tdt.nombre)) dpto, UPPER(RTRIM(mun.nombre_mun)) mun
		FROM matriculas AS tm 
      LEFT JOIN acta_promocion AS tac ON tac.id_matric = tm.id_matric 
		LEFT JOIN sedes AS ts ON tm.id_sede=ts.id  
	   LEFT JOIN grados AS tg ON tm.cod_grado=tg.cod_grado 
		LEFT JOIN jornadas AS tj ON tm.id_jorn=tj.cod_jorn 
		LEFT JOIN inscripciones AS te ON tm.cod_est=te.cod_est 
		LEFT JOIN documentos AS td ON te.cod_doc = td.id  
		LEFT JOIN departamentos AS tdt ON te.dpto_lug_exp = tdt.id
		LEFT JOIN ciudades AS mun ON te.mun_lug_exp = mun.id
		WHERE tm.año = _año AND tm.id_sede  =_id_sede AND tm.cod_grado=_cod_grado AND
		tm.grupo=_grupo AND tm.id_jorn=_id_jorn AND tm.estado = 2 AND (tac.estado = 1 OR tac.estado = 4) AND 
		tm.id_inst = _id_inst AND ts.ID_INST = _id_inst 
		ORDER BY estudiantes;
	END IF;
END$$

DROP PROCEDURE IF EXISTS `sp_select_listas`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_select_listas` (IN `_id_inst` INT(30), IN `_año` YEAR, IN `_id_sede` INT(30), IN `_grado` INT(11), IN `_grupo` VARCHAR(2), IN `_jorn` INT(1))  BEGIN
	SELECT tm.id_inst,tm.`año`,tm.id_sede,
	CONCAT(RTRIM(ti.apellido1),' ',RTRIM(ti.apellido2),' ',RTRIM(ti.nombre1),' ',RTRIM(ti.nombre2)) AS nombres,
	tg.id cod_grado, tm.grupo, tm.id_jorn, RTRIM(ts.NOM_SEDE) sede, RTRIM(tg.grado) grado, RTRIM(tj.JORNADA) jornada
	FROM inscripciones AS ti 
	LEFT JOIN matriculas AS tm ON tm.cod_est = ti.cod_est
	LEFT JOIN sedes AS ts ON tm.id_sede = ts.ID
	LEFT JOIN grados AS tg ON tm.id_grado = tg.id
	LEFT JOIN jornadas AS tj ON tm.id_jorn = tj.cod_jorn
	WHERE tm.id_grado=  _grado AND tm.id_sede= _id_sede
	AND tm.año= `_año` AND tm.id_estado= 2 AND tm.id_inst = _id_inst AND ts.ID_INST = _id_inst
	AND tm.grupo= _grupo AND tm.id_jorn= _jorn AND ti.id_inst = _id_inst
	ORDER BY nombres;
END$$

DROP PROCEDURE IF EXISTS `sp_select_listas_carga`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_select_listas_carga` (IN `_id_inst` INT(30), IN `_año` YEAR, IN `_docente` INT(30))  BEGIN
	SELECT tm.id_inst,tm.`año`,tm.id_sede,
	CONCAT(RTRIM(ti.apellido1),' ',RTRIM(ti.apellido2),' ',RTRIM(ti.nombre1),' ',RTRIM(ti.nombre2)) AS nombres,
	tg.id cod_grado, tm.grupo, tm.id_jorn, RTRIM(ts.NOM_SEDE) sede, RTRIM(tg.grado) grado, RTRIM(tj.JORNADA) jornada,
	RTRIM(tas.asignatura) asignatura, 
	CONCAT(RTRIM(td.apellido1),' ',RTRIM(td.apellido2),' ',RTRIM(td.nombre1),' ',RTRIM(td.nombre2)) AS docente
	FROM inscripciones AS ti 
	LEFT JOIN matriculas AS tm ON tm.cod_est = ti.cod_est
	LEFT JOIN sedes AS ts ON tm.id_sede = ts.ID
	LEFT JOIN grados AS tg ON tm.id_grado = tg.id
	LEFT JOIN jornadas AS tj ON tm.id_jorn = tj.cod_jorn
	LEFT JOIN cursos AS tc ON (tc.id_grado = tg.id AND tc.grupo = tm.grupo AND 
										tc.id_sede = ts.ID AND tc.cod_jorn = tj.cod_jorn) 
	LEFT JOIN asignaturas AS tas ON tc.id_asig = tas.id_pk
	LEFT JOIN docentes AS td ON tc.id_docente = td.id_docente
	WHERE tm.año= `_año` AND tm.id_estado= 2 AND tm.id_inst = _id_inst 
	AND ts.ID_INST = _id_inst 
	AND ti.id_inst = _id_inst 
	AND tas.id_inst = _id_inst AND tas.estado = 1
	AND td.id_inst = _id_inst AND td.`año` = `_año` AND td.estado = 1 AND td.id_docente = _docente  
	AND tc.id_inst = _id_inst AND tc.`año` = `_año` AND tc.estado = 1 AND tc.id_docente = _docente
	ORDER BY sede,grado,tm.grupo,tm.id_jorn,asignatura,nombres;
END$$

DROP PROCEDURE IF EXISTS `sp_select_logros_estudiante`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_select_logros_estudiante` (IN `_id_inst` INT(20), IN `_id_docente` INT(20), IN `_año` YEAR, IN `_cod_grado` VARCHAR(2) charset utf8, IN `_id_asig` INT(2), IN `_periodo` VARCHAR(1) charset utf8, IN `_id_nota` INT(30), IN `_limit` TINYINT, IN `_min` INT(6), IN `_max` INT(6))  BEGIN
if _periodo = '0' then
	if _cod_grado >= '10' then
		SELECT tl.*, tc.competencia, td.desempeño, tg.*, tn.id_matric FROM logros_estandares AS tl 
		left join competencias AS tc on tl.id_competencia = tc.id 
		left join desempeños AS td ON tl.id_desempeño = td.id 
		left join log_nscp003 AS tg ON tg.id_logro_estandar = tl.id 
		left join nscp003 AS tn ON tn.id = tg.id_nota 
		where tl.id_inst=_id_inst and tl.id_docente=_id_docente and
		tl.año=_año and tl.cod_grado=_cod_grado and tl.id_asig=_id_asig  
		and tc.año=_año and tc.id_inst=_id_inst and td.id_inst=_id_inst and td.año=_año 
		and tg.id_nota = _id_nota
		order by tl.tipo, tl.periodo, tl.asignacion, tl.consecutivo;
	elseif _cod_grado >= '06' AND _cod_grado <= '09' then				
		SELECT tl.*, tc.competencia, td.desempeño, tg.*, tn.id_matric FROM logros_estandares AS tl 
		left join competencias AS tc on tl.id_competencia = tc.id 
		left join desempeños AS td ON tl.id_desempeño = td.id 
		left join log_nscp002 AS tg ON tg.id_logro_estandar = tl.id 
		left join nscp002 AS tn ON tn.id = tg.id_nota 
		where tl.id_inst=_id_inst and tl.id_docente=_id_docente and
		tl.año=_año and tl.cod_grado=_cod_grado and tl.id_asig=_id_asig  
		and tc.año=_año and tc.id_inst=_id_inst and td.id_inst=_id_inst and td.año=_año 
		and tg.id_nota = _id_nota
		order by tl.tipo, tl.periodo, tl.asignacion, tl.consecutivo;
	elseif _cod_grado >= '01' AND _cod_grado <= '05' then
		SELECT tl.*, tc.competencia, td.desempeño, tg.*, tn.id_matric FROM logros_estandares AS tl 
		left join competencias AS tc on tl.id_competencia = tc.id 
		left join desempeños AS td ON tl.id_desempeño = td.id 
		left join log_nscp001 AS tg ON tg.id_logro_estandar = tl.id 
		left join nscp001 AS tn ON tn.id = tg.id_nota 
		where tl.id_inst=_id_inst and tl.id_docente=_id_docente and
		tl.año=_año and tl.cod_grado=_cod_grado and tl.id_asig=_id_asig  
		and tc.año=_año and tc.id_inst=_id_inst and td.id_inst=_id_inst and td.año=_año 
		and tg.id_nota = _id_nota
		order by tl.tipo, tl.periodo, tl.asignacion, tl.consecutivo;
	else 
		SELECT tl.*, tc.competencia, td.desempeño, tg.*, tn.id_matric FROM logros_estandares AS tl 
		left join competencias AS tc on tl.id_competencia = tc.id 
		left join desempeños AS td ON tl.id_desempeño = td.id 
		left join log_nscp00 AS tg ON tg.id_logro_estandar = tl.id 
		left join nscp00 AS tn ON tn.id = tg.id_nota 
		where tl.id_inst=_id_inst and tl.id_docente=_id_docente and
		tl.año=_año and tl.cod_grado=_cod_grado and tl.id_asig=_id_asig  
		and tc.año=_año and tc.id_inst=_id_inst and td.id_inst=_id_inst and td.año=_año 
		and tg.id_nota = _id_nota
		order by tl.tipo, tl.periodo, tl.asignacion, tl.consecutivo ;
	end if;
else 
	if _cod_grado >= '10' then
		SELECT tl.*, tc.competencia, td.desempeño, tg.*, tn.id_matric FROM logros_estandares AS tl 
		left join competencias AS tc on tl.id_competencia = tc.id 
		left join desempeños AS td ON tl.id_desempeño = td.id 
		left join log_nscp003 AS tg ON tg.id_logro_estandar = tl.id 
		left join nscp003 AS tn ON tn.id = tg.id_nota 
		where tl.id_inst=_id_inst and tl.id_docente=_id_docente and
		tl.año=_año and tl.cod_grado=_cod_grado and tl.id_asig=_id_asig  
		and tc.año=_año and tc.id_inst=_id_inst and td.id_inst=_id_inst and td.año=_año 
		and tl.periodo = _periodo and tg.id_nota = _id_nota
		order by tl.tipo, tl.periodo, tl.asignacion, tl.consecutivo ;
	elseif _cod_grado >= '06' AND _cod_grado <= '09' then				
		SELECT tl.*, tc.competencia, td.desempeño, tg.*, tn.id_matric FROM logros_estandares AS tl 
		left join competencias AS tc on tl.id_competencia = tc.id 
		left join desempeños AS td ON tl.id_desempeño = td.id 
		left join log_nscp002 AS tg ON tg.id_logro_estandar = tl.id 
		left join nscp002 AS tn ON tn.id = tg.id_nota 
		where tl.id_inst=_id_inst and tl.id_docente=_id_docente and
		tl.año=_año and tl.cod_grado=_cod_grado and tl.id_asig=_id_asig  
		and tc.año=_año and tc.id_inst=_id_inst and td.id_inst=_id_inst and td.año=_año 
		and tl.periodo = _periodo and tg.id_nota = _id_nota
		order by tl.tipo, tl.periodo, tl.asignacion, tl.consecutivo;
	elseif _cod_grado >= '01' AND _cod_grado <= '05' then
		SELECT tl.*, tc.competencia, td.desempeño, tg.*, tn.id_matric FROM logros_estandares AS tl 
		left join competencias AS tc on tl.id_competencia = tc.id 
		left join desempeños AS td ON tl.id_desempeño = td.id 
		left join log_nscp001 AS tg ON tg.id_logro_estandar = tl.id 
		left join nscp001 AS tn ON tn.id = tg.id_nota 
		where tl.id_inst=_id_inst and tl.id_docente=_id_docente and
		tl.año=_año and tl.cod_grado=_cod_grado and tl.id_asig=_id_asig  
		and tc.año=_año and tc.id_inst=_id_inst and td.id_inst=_id_inst and td.año=_año 
		and tl.periodo = _periodo and tg.id_nota = _id_nota
		order by tl.tipo, tl.periodo, tl.asignacion, tl.consecutivo;
	else 
		SELECT tl.*, tc.competencia, td.desempeño, tg.*, tn.id_matric FROM logros_estandares AS tl 
		left join competencias AS tc on tl.id_competencia = tc.id 
		left join desempeños AS td ON tl.id_desempeño = td.id 
		left join log_nscp00 AS tg ON tg.id_logro_estandar = tl.id 
		left join nscp00 AS tn ON tn.id = tg.id_nota 
		where tl.id_inst=_id_inst and tl.id_docente=_id_docente and
		tl.año=_año and tl.cod_grado=_cod_grado and tl.id_asig=_id_asig  
		and tc.año=_año and tc.id_inst=_id_inst and td.id_inst=_id_inst and td.año=_año 
		and tl.periodo = _periodo and tg.id_nota = _id_nota
		order by tl.tipo, tl.periodo, tl.asignacion, tl.consecutivo ;
	end if;
end if;
END$$

DROP PROCEDURE IF EXISTS `sp_select_logros_estudiante_all`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_select_logros_estudiante_all` (IN `_id_inst` INT(20), IN `_id_docente` INT(30), IN `_año` YEAR, IN `_cod_grado` INT(11), IN `_id_asig` INT(11), IN `_periodo` VARCHAR(1) charset utf8, IN `_grupo` VARCHAR(2), IN `_id_sede` INT(20), IN `_cod_jorn` INT(2))  BEGIN
	DECLARE cTable, cTable2	VARCHAR(30) DEFAULT '';
	SELECT fn_return_table_notas(_cod_grado) INTO cTable;
	SELECT fn_return_table_logros_indicadores(_cod_grado) INTO cTable2;
	SET @sqlSelect = CONCAT("SELECT tl.*, tcm.competencia, tg.*, es.nombre_escala, tp.nombre_proceso,
		tn.id_matric,
	   concat(rtrim(ti.apellido1),' ',rtrim(ti.apellido2),' ',rtrim(ti.nombre1),' ',rtrim(ti.nombre2)) 
	   AS nombres
		FROM logros_estandares AS tl 
		LEFT JOIN ",cTable2," AS tg ON tg.id_logro_estandar = tl.id 
		LEFT JOIN ",cTable," AS tn ON tg.id_nota = tn.id
		LEFT JOIN cursos AS tc ON (tn.id_curso = tc.id AND tn.año=tc.`año`)
		LEFT JOIN escala_nacional AS es ON tl.id_escala = es.id
		LEFT JOIN tipo_procesos_educativos AS tp ON tl.tipo = tp.id
		LEFT JOIN competencias AS tcm ON (tl.id_competencia = tcm.id AND tl.`año` = tcm.`año`)
		LEFT JOIN grados_agrupados AS t1 ON tcm.id_grado_agrupado = t1.id
		LEFT JOIN aux_grados_agrupados AS t2 ON (t2.id_grado_agrupado = t1.id)
   	LEFT JOIN matriculas AS tm  ON tn.id_matric = tm.id_matric 
   	LEFT JOIN inscripciones AS ti on tm.cod_est = ti.cod_est
		WHERE tl.id_inst = ",_id_inst," AND tl.año = ",_año ,"
		AND tl.periodo ='",_periodo,"' AND tn.periodo = '",_periodo,"'
		AND tc.`año` = ",`_año`," AND tc.id_docente = ",_id_docente," AND tc.id_grado = "
		,_cod_grado," AND tc.id_asig =",_id_asig," AND tcm.`año` =",`_año`," 
		AND t2.id_grado = ",_cod_grado," AND tm.id_grado = ",_cod_grado,"
		AND tm.`año` = ",`_año`," AND tm.grupo ='",_grupo,"'
		ORDER BY nombres, tl.tipo, tl.periodo, tl.asignacion, tl.consecutivo");
	PREPARE smtp FROM @sqlSelect;
	EXECUTE smtp;
	DEALLOCATE PREPARE smtp;
END$$

DROP PROCEDURE IF EXISTS `sp_select_logros_estudiante_boletin`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_select_logros_estudiante_boletin` (IN `_id_inst` INT(20), IN `_año` YEAR, IN `_cod_grado` INT(11), IN `_periodo` VARCHAR(2), IN `_id_nota` INT(30))  BEGIN
	DECLARE cTable, cTable2	VARCHAR(30) DEFAULT '';
	SELECT fn_return_table_notas(_cod_grado) INTO cTable;
	SELECT fn_return_table_logros_indicadores(_cod_grado) INTO cTable2;
	SET @sqlSelect = CONCAT("SELECT RTRIM(tl.descripcion) AS descripcion, tl.tipo
		FROM logros_estandares AS tl 
		LEFT JOIN ",cTable2," AS tg ON tg.id_logro_estandar = tl.id 
		LEFT JOIN ",cTable," AS tn ON tg.id_nota = tn.id
		WHERE tl.id_inst = ",_id_inst," AND tl.año = ",_año ,"
		AND tl.periodo ='",_periodo,"' AND tg.id_nota = ",_id_nota," AND tn.periodo = '",_periodo,"'
		AND tl.tipo = 2 ORDER BY tl.descripcion");
	PREPARE smtp FROM @sqlSelect;
	EXECUTE smtp;
	DEALLOCATE PREPARE smtp;
END$$

DROP PROCEDURE IF EXISTS `sp_select_logros_es_docente`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_select_logros_es_docente` (IN `_id_inst` INT(20), IN `_id_docente` INT(30), IN `_año` YEAR, IN `_cod_grado` INT(11), IN `_id_asig` INT(11), IN `_periodo` VARCHAR(2), IN `_limit` TINYINT, IN `_min` INT(6), IN `_max` INT(6))  BEGIN
	IF LENGTH(_periodo) = 0 THEN
		IF _limit <> 0 THEN 
			SELECT tl.*,tp.nombre_proceso, tc.competencia, es.nombre_escala
			FROM logros_estandares AS tl 
			LEFT JOIN escala_nacional AS es ON tl.id_escala = es.id
			LEFT JOIN tipo_procesos_educativos AS tp ON tl.tipo = tp.id
			LEFT JOIN competencias AS tc ON (tl.id_competencia = tc.id AND tl.`año` = tc.`año`)
			LEFT JOIN grados_agrupados AS t1 ON tc.id_grado_agrupado = t1.id
			LEFT JOIN aux_grados_agrupados AS t2 ON (t2.id_grado_agrupado = t1.id)
			WHERE t2.id_grado = tl.id_grado AND tl.`año` = tc.`año` 
			AND tl.id_docente = _id_docente AND tl.id_grado = _cod_grado 
			AND tl.id_asig = _id_asig AND tl.`año` = `_año` AND tl.id_inst = _id_inst
			AND tc.`año` = `_año` AND tc.id_inst = _id_inst AND t2.id_grado = _cod_grado
			ORDER BY tl.tipo, tl.periodo, tl.id_competencia,tl.id_escala LIMIT _min, _max;
		ELSE
			SELECT tl.*,tp.nombre_proceso, tc.competencia, es.nombre_escala
			FROM logros_estandares AS tl 
			LEFT JOIN escala_nacional AS es ON tl.id_escala = es.id
			LEFT JOIN tipo_procesos_educativos AS tp ON tl.tipo = tp.id
			LEFT JOIN competencias AS tc ON (tl.id_competencia = tc.id AND tl.`año` = tc.`año`)
			LEFT JOIN grados_agrupados AS t1 ON tc.id_grado_agrupado = t1.id
			LEFT JOIN aux_grados_agrupados AS t2 ON (t2.id_grado_agrupado = t1.id)
			WHERE t2.id_grado = tl.id_grado AND tl.`año` = tc.`año` 
			AND tl.id_docente = _id_docente AND tl.id_grado = _cod_grado 
			AND tl.id_asig = _id_asig AND tl.`año` = `_año` AND tl.id_inst = _id_inst
			AND tc.`año` = `_año` AND tc.id_inst = _id_inst AND t2.id_grado = _cod_grado
			ORDER BY tl.tipo, tl.periodo, tl.id_competencia,tl.id_escala;
		END IF;
	ELSE 
		IF _limit <> 0 THEN 
			SELECT tl.*,tp.nombre_proceso, tc.competencia, es.nombre_escala
			FROM logros_estandares AS tl 
			LEFT JOIN escala_nacional AS es ON tl.id_escala = es.id
			LEFT JOIN tipo_procesos_educativos AS tp ON tl.tipo = tp.id
			LEFT JOIN competencias AS tc ON (tl.id_competencia = tc.id AND tl.`año` = tc.`año`)
			LEFT JOIN grados_agrupados AS t1 ON tc.id_grado_agrupado = t1.id
			LEFT JOIN aux_grados_agrupados AS t2 ON (t2.id_grado_agrupado = t1.id)
			WHERE t2.id_grado = tl.id_grado AND tl.`año` = tc.`año` 
			AND tl.id_docente = _id_docente AND tl.id_grado = _cod_grado 
			AND tl.id_asig = _id_asig AND tl.`año` = `_año` AND tl.id_inst = _id_inst
			AND tl.periodo = _periodo
			AND tc.`año` = `_año` AND tc.id_inst = _id_inst AND t2.id_grado = _cod_grado
			ORDER BY tl.tipo, tl.periodo, tl.id_competencia,tl.id_escala LIMIT _min, _max;
		ELSE
			SELECT tl.*,tp.nombre_proceso, tc.competencia, es.nombre_escala
			FROM logros_estandares AS tl 
			LEFT JOIN escala_nacional AS es ON tl.id_escala = es.id
			LEFT JOIN tipo_procesos_educativos AS tp ON tl.tipo = tp.id
			LEFT JOIN competencias AS tc ON (tl.id_competencia = tc.id AND tl.`año` = tc.`año`)
			LEFT JOIN grados_agrupados AS t1 ON tc.id_grado_agrupado = t1.id
			LEFT JOIN aux_grados_agrupados AS t2 ON (t2.id_grado_agrupado = t1.id)
			WHERE t2.id_grado = tl.id_grado AND tl.`año` = tc.`año` 
			AND tl.id_docente = _id_docente AND tl.id_grado = _cod_grado 
			AND tl.id_asig = _id_asig AND tl.`año` = `_año` AND tl.id_inst = _id_inst
			AND tl.periodo = _periodo
			AND tc.`año` = `_año` AND tc.id_inst = _id_inst AND t2.id_grado = _cod_grado
			ORDER BY tl.tipo, tl.periodo, tl.id_competencia,tl.id_escala;
		END IF;
	END IF;
END$$

DROP PROCEDURE IF EXISTS `sp_select_matcurso`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_select_matcurso` (IN `_id_inst` INT(20), IN `_cod_grado` INT(11), IN `_año` YEAR)  BEGIN
	SELECT tm.*, ta.id_area, RTRIM(ta.asignatura) as asignatura, tg.grado,ta.abrev 
	FROM matcurso AS tm 
	LEFT JOIN asignaturas AS ta ON tm.id_asig=ta.id_pk
	LEFT JOIN grados AS tg ON tm.id_grado = tg.id
	WHERE tm.id_inst=_id_inst and tm.año=_año AND tg.id=_cod_grado 
	AND ta.id_inst=_id_inst ORDER BY ta.id_area, tm.id_asig;
END$$

DROP PROCEDURE IF EXISTS `sp_select_material_edu_est`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_select_material_edu_est` (IN `_id_inst` INT(30), IN `_año` YEAR, IN `_id_matric` INT(30))  BEGIN
	SELECT mc.id,mc.id_material,mc.id_matric,mc.leido,tm.nombre,tm.descripcion,tm.url_video,
	tm.url_archivo,tm.mime,tm.url_enlace, RTRIM(ta.asignatura) asignatura,tm.fecha,
	ma.cod_grado, ma.grupo, tg.grado,RTRIM(tj.JORNADA) jornada, RTRIM(ts.NOM_SEDE) sede,
	CONCAT(RTRIM(td.apellido1),' ',RTRIM(td.apellido2),' ',RTRIM(td.nombre1),' ',RTRIM(td.nombre2)) docente,
	td.foto,td.mime
	FROM material_educ_compartido mc 
	LEFT JOIN material_educ AS tm ON mc.id_material = tm.id
	LEFT JOIN cursos AS tc ON tm.id_curso=tc.id 
	LEFT JOIN asignaturas AS ta ON tc.id_asig = ta.id
	LEFT JOIN matriculas AS ma ON mc.id_matric = ma.id_matric
	LEFT JOIN docentes AS td ON tc.id_docente = td.id_docente 
	LEFT JOIN sedes AS ts ON (tc.id_sede = ts.ID AND ma.id_sede = ts.ID)
	LEFT JOIN grados AS tg ON (tc.cod_grado = tg.COD_GRADO AND ma.cod_grado = tg.COD_GRADO)
	LEFT JOIN jornadas AS tj ON (tc.cod_jorn = tj.COD_JORN AND ma.id_jorn = tj.COD_JORN)
	WHERE tm.estado = 1 AND tc.id_inst = _id_inst AND tc.`año` = `_año` AND tc.estado = 1 AND
	ta.id_inst = _id_inst AND ta.`año` = `_año` AND ta.estado = 1 AND 
	ma.id_inst = _id_inst AND ma.id_matric = _id_matric AND ma.estado = 2 AND td.id_inst = _id_inst 
	AND td.`año` = `_año` AND td.estado = 1 AND ts.ID_INST = _id_inst;
END$$

DROP PROCEDURE IF EXISTS `sp_select_matriculados`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_select_matriculados` (IN `_id_inst` INT(30), IN `_año` YEAR, IN `_id_sede` INT(30), IN `_grado` INT(11), IN `_grupo` VARCHAR(2), IN `_jorn` INT(1))  BEGIN
	SELECT ti.nro_doc_id, 
	CONCAT(RTRIM(ti.apellido1),' ',RTRIM(ti.apellido2),' ',RTRIM(ti.nombre1),' ',RTRIM(ti.nombre2)) nombres, 
	tg.cod_grado, tm.grupo, tm.id_jorn, RIGHT(CONCAT('0000',tm.nro_matricula),4) nro_matricula,
	tm.id_matric, RTRIM(tg.grado) grado, RTRIM(ts.NOM_SEDE) sede, 
	RTRIM(tj.JORNADA) jornada, td.abrev tdocumento
	FROM inscripciones AS ti 
	LEFT JOIN matriculas AS tm ON tm.cod_est = ti.cod_est
	LEFT JOIN sedes AS ts ON tm.id_sede = ts.ID
	LEFT JOIN jornadas AS tj ON tm.id_jorn = tj.cod_jorn
	LEFT JOIN grados AS tg ON tm.id_grado = tg.id
	LEFT JOIN documentos AS td ON ti.cod_doc = td.id
	WHERE tm.año=`_año` AND tm.grupo=_grupo AND tm.id_jorn = _jorn AND tm.id_sede = _id_sede
	AND tm.id_inst = _id_inst AND tm.id_estado=2 AND ti.id_inst = _id_inst AND ts.ID_INST = _id_inst
	AND tm.id_grado = _grado ORDER BY nombres;
END$$

DROP PROCEDURE IF EXISTS `sp_select_matriculas`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_select_matriculas` (IN `_id_inst` INT(20), IN `_año` YEAR, IN `_id_sede` INT(20), IN `_grado` INT(11), IN `_grupo` VARCHAR(2), IN `_jorn` INT)  BEGIN
	SELECT tm.id_matric,tm.grupo,tm.id_jorn,tm.id_sede, tm.id_grado,
		CONCAT(RTRIM(te.apellido1),' ',RTRIM(te.apellido2),' ',RTRIM(te.nombre1),' ',RTRIM(te.nombre2)) nombres,
		RTRIM(tg.grado) grado, tg.cod_grado, RTRIM(ts.NOM_SEDE) sede, RTRIM(tj.jornada) jornada, tm.año
		FROM inscripciones AS te
		LEFT JOIN matriculas AS tm ON tm.cod_est = te.cod_est 
		LEFT JOIN sedes AS ts ON tm.id_sede = ts.ID
		LEFT JOIN grados AS tg ON tm.id_grado = tg.id 
		LEFT JOIN jornadas AS tj ON tm.id_jorn = tj.cod_jorn
		WHERE tm.id_grado = _grado AND tm.id_jorn = _jorn AND tm.id_estado = 2  
		AND tm.id_sede = _id_sede AND tm.id_inst = _id_inst AND tm.`año`= `_año` 
		AND tm.grupo = _grupo ORDER BY nombres;
END$$

DROP PROCEDURE IF EXISTS `sp_select_nivel_ens`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_select_nivel_ens` (IN `_id_inst` INT(30), IN `_grado` VARCHAR(2))  BEGIN
	SELECT fn_niveles_ens(_id_inst,_grado);
END$$

DROP PROCEDURE IF EXISTS `sp_select_notas_academicas_curso`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_select_notas_academicas_curso` (IN `_id_inst` INT(20), IN `_id_curso` INT(30), IN `_periodo` VARCHAR(2), IN `_año` YEAR, IN `_id_grado` INT(11), IN `_sx` VARCHAR(4))  BEGIN
	DECLARE cTable, cTable2 VARCHAR(30) DEFAULT '';
	DECLARE _sex VARCHAR(100) DEFAULT '';
	SELECT fn_return_table_notas(_id_grado) INTO cTable;
	SELECT fn_return_table_notas_promedios(_id_grado) INTO cTable2;
	IF _sx = "MX" THEN 
		SET _sex = "";
	ELSE 
		SET _sex = CONCAT(" AND ti.sexo ='",_sx,"'");
	END IF;
	SET @sqlSelect = CONCAT("SELECT tn.*, tc.id_grado, tc.grupo, tc.cod_jorn,
			CONCAT(RTRIM(ti.apellido1),' ',RTRIM(ti.apellido2),
				' ',RTRIM(ti.nombre1),' ',RTRIM(ti.nombre2))  AS nombres, ti.sexo,
			ta.asignatura, 
			tmc.proc1, tmc.proc2, tmc.proc3, tmc.proc4, es.nombre_escala,
			tp.prom FROM ",cTable," AS tn 
			LEFT JOIN cursos AS tc ON (tn.id_curso = tc.id AND tn.`año` = tc.`año`)
			LEFT JOIN matriculas AS tm ON tn.id_matric=tm.id_matric 
			LEFT JOIN inscripciones AS ti ON tm.cod_est = ti.cod_est
			LEFT JOIN asignaturas AS ta ON tc.id_asig=ta.id_pk
			LEFT JOIN matcurso AS tmc ON tmc.id_asig = ta.id_pk 
			LEFT JOIN escala_nacional AS es ON tn.id_escala = es.id
			LEFT JOIN ",cTable2," AS tp ON (tp.id_curso = tc.id AND tp.id_matric = tn.id_matric)
			WHERE tn.id_inst = ",_id_inst," AND tn.periodo='",_periodo,"' AND tn.id_inst=",_id_inst,"
			AND tm.id_estado = 2 AND tm.`año` = ",_año,_sex," AND tmc.año=",_año," AND ta.id_inst=",_id_inst,"
			AND tc.id_inst = ",_id_inst," AND tc.`año` =",`_año`," AND tc.id_grado =",_id_grado,
			" AND tn.id_curso=",_id_curso," AND tmc.id_grado=",_id_grado,"
			ORDER BY nombres");
	PREPARE smtp FROM @sqlSelect;
	EXECUTE smtp;
	DEALLOCATE PREPARE smtp;
END$$

DROP PROCEDURE IF EXISTS `sp_select_notas_academicas_estudiante`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_select_notas_academicas_estudiante` (IN `_id_inst` INT(30), IN `_año` YEAR, IN `_id_matric` INT(30))  BEGIN
	DECLARE _cod_grado VARCHAR(2) DEFAULT '';
	SELECT cod_grado INTO _cod_grado FROM matriculas WHERE id_matric = _id_matric AND id_inst = _id_inst AND año = `_año`;
	CASE  
		WHEN _cod_grado >= '01' AND _cod_grado <= '05' THEN
			SELECT tn.*, tm.cod_grado, tm.grupo, tm.id_jorn,ta.asignatura, 
			tc.proc1, tc.proc2, tc.proc3, tc.proc4 FROM nscp001 AS tn 
			LEFT JOIN matriculas AS tm ON tn.id_matric=tm.id_matric 
			LEFT JOIN asignaturas AS ta ON tn.id_asig=ta.id 
			LEFT JOIN matcurso AS tc ON tc.id_asig = ta.id 
			WHERE tm.id_matric = _id_matric AND tm.id_inst = _id_inst AND tm.`año` = `_año`
			AND tn.id_inst=_id_inst AND ta.año=`_año` AND ta.id_inst=_id_inst
			AND tc.id_inst = _id_inst AND tc.`año` = `_año` AND tm.id_matric = _id_matric
			ORDER BY tn.periodo,ta.cod_area,ta.id;
		WHEN _cod_grado >= '06' AND _cod_grado <= '09' THEN
		SELECT tn.*, tm.cod_grado, tm.grupo, tm.id_jorn,ta.asignatura, 
			tc.proc1, tc.proc2, tc.proc3, tc.proc4 FROM nscp002 AS tn 
			LEFT JOIN matriculas AS tm ON tn.id_matric=tm.id_matric 
			LEFT JOIN asignaturas AS ta ON tn.id_asig=ta.id 
			LEFT JOIN matcurso AS tc ON tc.id_asig = ta.id 
			WHERE tm.id_matric = _id_matric AND tm.id_inst = _id_inst AND tm.`año` = `_año`
			AND tn.id_inst=_id_inst AND ta.año=`_año` AND ta.id_inst=_id_inst
			AND tc.id_inst = _id_inst AND tc.`año` = `_año` AND tm.id_matric = _id_matric
			ORDER BY tn.periodo,ta.cod_area,ta.id;
		WHEN _cod_grado >= '10' AND _cod_grado <= '99' THEN
			SELECT tn.*, tm.cod_grado, tm.grupo, tm.id_jorn,ta.asignatura, 
			tc.proc1, tc.proc2, tc.proc3, tc.proc4 FROM nscp003 AS tn 
			LEFT JOIN matriculas AS tm ON tn.id_matric=tm.id_matric 
			LEFT JOIN asignaturas AS ta ON tn.id_asig=ta.id 
			LEFT JOIN matcurso AS tc ON tc.id_asig = ta.id 
			WHERE tm.id_matric = _id_matric AND tm.id_inst = _id_inst AND tm.`año` = `_año`
			AND tn.id_inst=_id_inst AND ta.año=`_año` AND ta.id_inst=_id_inst
			AND tc.id_inst = _id_inst AND tc.`año` = `_año` AND tm.id_matric = _id_matric
			ORDER BY tn.periodo,ta.cod_area,ta.id;
	ELSE
		SELECT tn.*, tm.cod_grado, tm.grupo, tm.id_jorn,ta.asignatura, 
			tc.proc1, tc.proc2, tc.proc3, tc.proc4 FROM nscp00 AS tn 
			LEFT JOIN matriculas AS tm ON tn.id_matric=tm.id_matric 
			LEFT JOIN asignaturas AS ta ON tn.id_asig=ta.id 
			LEFT JOIN matcurso AS tc ON tc.id_asig = ta.id 
			WHERE tm.id_matric = _id_matric AND tm.id_inst = _id_inst AND tm.`año` = `_año`
			AND tn.id_inst=_id_inst AND ta.año=`_año` AND ta.id_inst=_id_inst
			AND tc.id_inst = _id_inst AND tc.`año` = `_año` AND tm.id_matric = _id_matric
			ORDER BY tn.periodo,ta.cod_area,ta.id;		
	END CASE;
	
END$$

DROP PROCEDURE IF EXISTS `sp_select_notas_academicas_periodo`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_select_notas_academicas_periodo` (IN `_id_inst` INT(20), IN `_id_matric` INT(20), IN `_periodo` VARCHAR(2), IN `_año` YEAR, IN `_id_grado` INT(11))  BEGIN
	DECLARE cTable, cTable2 VARCHAR(30) DEFAULT '';
	SELECT fn_return_table_notas(_id_grado) INTO cTable;
	SELECT fn_return_table_notas_promedios(_id_grado) INTO cTable2;
	
	SET @sqlSelect = CONCAT("SELECT tn.*, tc.id_grado, tc.grupo, tc.cod_jorn,ta.asignatura, 
			tmc.proc1, tmc.proc2, tmc.proc3, tmc.proc4, es.nombre_escala,
			tp.prom FROM ",cTable," AS tn 
			LEFT JOIN cursos AS tc ON (tn.id_curso = tc.id AND tn.`año` = tc.`año`)
			LEFT JOIN matriculas AS tm ON tn.id_matric=tm.id_matric 
			LEFT JOIN asignaturas AS ta ON tc.id_asig=ta.id_pk
			LEFT JOIN matcurso AS tmc ON tmc.id_asig = ta.id_pk 
			LEFT JOIN escala_nacional AS es ON tn.id_escala = es.id
			LEFT JOIN ",cTable2," AS tp ON (tp.id_curso = tc.id AND tp.id_matric = tn.id_matric)
			WHERE tn.id_inst = ",_id_inst," AND tn.periodo='",_periodo,"' AND tn.id_inst=",_id_inst,"
			AND tm.`año` = ",_año," AND tmc.año=",_año," AND ta.id_inst=",_id_inst,"
			AND tc.id_inst = ",_id_inst," AND tc.`año` =",`_año`," AND tc.id_grado =",_id_grado,
			" AND tm.id_matric=",_id_matric," AND tmc.id_grado=",_id_grado);
	PREPARE smtp FROM @sqlSelect;
	EXECUTE smtp;
	DEALLOCATE PREPARE smtp;
END$$

DROP PROCEDURE IF EXISTS `sp_select_notas_periodo`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_select_notas_periodo` (IN `_id_inst` INT(30), IN `_año` YEAR, IN `_cod_grado` INT(11), IN `_per` VARCHAR(2), IN `_id_matric` INT(30))  BEGIN
	DECLARE _table VARCHAR(30) DEFAULT '';
	SELECT fn_return_table_notas(_cod_grado) INTO _table;
	
	SET @sqlSelect = CONCAT("SELECT tn.id_matric,
	IF(tn.nota_habilitacion > 0, tn.nota_habilitacion, tn.final) final,
	RTRIM(ta.asignatura) asignatura, tmc.ih, tn.periodo, tc.id_asig, es.nombre_escala
	FROM ",_table," AS tn 
	LEFT JOIN cursos AS tc ON (tn.id_curso = tc.id AND tn.año=tc.`año`)
	LEFT JOIN asignaturas AS ta ON tc.id_asig = ta.id_pk
	LEFT JOIN matcurso AS tmc ON tmc.id_asig = ta.id_pk
	LEFT JOIN areas AS tar ON ta.id_area = tar.id 
	LEFT JOIN escala_nacional AS es ON tn.id_escala = es.id
	WHERE tn.periodo ='",_per,"' AND tn.año=",`_año`," AND tn.id_inst=",_id_inst,"
	AND tc.`año` =",`_año`," AND tc.id_grado=",_cod_grado," AND ta.id_inst=",_id_inst,"
	AND ta.estado = 1	AND tmc.id_inst = ",_id_inst," AND tmc.año =",`_año`,"
	AND tn.id_matric=",_id_matric," AND tmc.id_grado =",_cod_grado," AND tmc.estado = 1
	AND tar.id_inst=",_id_inst," AND tar.estado=1 ORDER BY tar.ordenar");
	PREPARE stmt FROM @sqlSelect;
	EXECUTE stmt;
	DEALLOCATE PREPARE stmt;
END$$

DROP PROCEDURE IF EXISTS `sp_select_notas_reportadas`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_select_notas_reportadas` (IN `_id_inst` INT(20), IN `_id_docente` INT(20), IN `_año` YEAR, IN `_periodo` VARCHAR(2))  BEGIN
	(SELECT tn.periodo,tn.`año`,tn.final, tc.grupo, tg.cod_grado, tg.grado, 
		RTRIM(tas.asignatura) asignatura,tas.abrev AS abrev_asig,
		RTRIM(tar.area) area, tar.abrev AS abre_area, 
		CONCAT(RTRIM(td.apellido1),' ',RTRIM(td.apellido2),' ',
		RTRIM(td.nombre1),' ',RTRIM(td.nombre2)) as docente,
		ts.nom_sede AS sede, tj.jornada
		,CONCAT(RTRIM(te.apellido1),' ',RTRIM(te.apellido2),' ',
		RTRIM(te.nombre1),' ',RTRIM(te.nombre2)) as estudiante, 
		tme.estado_matricula, es.nombre_escala	FROM nscp001 AS tn 
		LEFT JOIN cursos AS tc ON (tn.id_curso = tc.id AND tn.`año` = tc.`año`)
		LEFT JOIN asignaturas AS tas ON tc.id_asig=tas.id_pk
	   LEFT JOIN areas AS tar ON tas.id_area=tar.id 
		LEFT JOIN docentes AS td ON tc.id_docente=td.id_docente 
		LEFT JOIN sedes AS ts ON tc.id_sede=ts.id 
	   LEFT JOIN jornadas AS tj ON tc.cod_jorn=tj.cod_jorn
	   LEFT JOIN grados As tg ON tc.id_grado=tg.id
	   LEFT JOIN matriculas AS tm ON tn.id_matric=tm.id_matric
		LEFT JOIN inscripciones AS te ON tm.cod_est=te.cod_est
		LEFT JOIN estado_matricula AS tme ON tm.id_estado = tme.id
		LEFT JOIN `desempeños` AS t1 ON (tn.final BETWEEN t1.desde AND t1.hasta AND t1.`año` = tn.`año`)
		LEFT JOIN grados_agrupados AS t2 ON t1.id_grado_agrupado = t2.id 
		LEFT JOIN aux_grados_agrupados AS t3 ON t3.id_grado_agrupado = t2.id
		LEFT JOIN escala_nacional AS es ON t1.id_escala = es.id
		WHERE tn.periodo = _periodo AND tn.`año` = `_año` AND tn.id_inst = _id_inst
		AND tc.`año` = `_año` AND tc.id_inst = _id_inst AND tas.id_inst = _id_inst
		AND tar.id_inst = _id_inst AND td.`año` = `_año` AND ts.ID_INST = _id_inst
		AND tm.`año` = `_año` AND te.id_inst = _id_inst AND tc.id_docente = _id_docente 
		AND t3.id_grado = tc.id_grado) 
		UNION 
		(SELECT tn.periodo,tn.`año`,tn.final, tc.grupo, tg.cod_grado, tg.grado, 
		RTRIM(tas.asignatura) asignatura,tas.abrev AS abrev_asig,
		RTRIM(tar.area) area, tar.abrev AS abre_area, 
		CONCAT(RTRIM(td.apellido1),' ',RTRIM(td.apellido2),' ',
		RTRIM(td.nombre1),' ',RTRIM(td.nombre2)) as docente,
		ts.nom_sede AS sede, tj.jornada
		,CONCAT(RTRIM(te.apellido1),' ',RTRIM(te.apellido2),' ',
		RTRIM(te.nombre1),' ',RTRIM(te.nombre2)) as estudiante, 
		tme.estado_matricula, es.nombre_escala	FROM nscp002 AS tn 
		LEFT JOIN cursos AS tc ON (tn.id_curso = tc.id AND tn.`año` = tc.`año`)
		LEFT JOIN asignaturas AS tas ON tc.id_asig=tas.id_pk
	   LEFT JOIN areas AS tar ON tas.id_area=tar.id 
		LEFT JOIN docentes AS td ON tc.id_docente=td.id_docente 
		LEFT JOIN sedes AS ts ON tc.id_sede=ts.id 
	   LEFT JOIN jornadas AS tj ON tc.cod_jorn=tj.cod_jorn
	   LEFT JOIN grados As tg ON tc.id_grado=tg.id
	   LEFT JOIN matriculas AS tm ON tn.id_matric=tm.id_matric
		LEFT JOIN inscripciones AS te ON tm.cod_est=te.cod_est
		LEFT JOIN estado_matricula AS tme ON tm.id_estado = tme.id
		LEFT JOIN `desempeños` AS t1 ON (tn.final BETWEEN t1.desde AND t1.hasta AND t1.`año` = tn.`año`)
		LEFT JOIN grados_agrupados AS t2 ON t1.id_grado_agrupado = t2.id 
		LEFT JOIN aux_grados_agrupados AS t3 ON t3.id_grado_agrupado = t2.id
		LEFT JOIN escala_nacional AS es ON t1.id_escala = es.id
		WHERE tn.periodo = _periodo AND tn.`año` = `_año` AND tn.id_inst = _id_inst
		AND tc.`año` = `_año` AND tc.id_inst = _id_inst AND tas.id_inst = _id_inst
		AND tar.id_inst = _id_inst AND td.`año` = `_año` AND ts.ID_INST = _id_inst
		AND tm.`año` = `_año` AND te.id_inst = _id_inst AND tc.id_docente = _id_docente
		AND t3.id_grado = tc.id_grado) 
		UNION 
		(SELECT tn.periodo,tn.`año`,tn.final, tc.grupo, tg.cod_grado, tg.grado, 
		RTRIM(tas.asignatura) asignatura,tas.abrev AS abrev_asig,
		RTRIM(tar.area) area, tar.abrev AS abre_area, 
		CONCAT(RTRIM(td.apellido1),' ',RTRIM(td.apellido2),' ',
		RTRIM(td.nombre1),' ',RTRIM(td.nombre2)) as docente,
		ts.nom_sede AS sede, tj.jornada
		,CONCAT(RTRIM(te.apellido1),' ',RTRIM(te.apellido2),' ',
		RTRIM(te.nombre1),' ',RTRIM(te.nombre2)) as estudiante, 
		tme.estado_matricula, es.nombre_escala	FROM nscp003 AS tn 
		LEFT JOIN cursos AS tc ON (tn.id_curso = tc.id AND tn.`año` = tc.`año`)
		LEFT JOIN asignaturas AS tas ON tc.id_asig=tas.id_pk
	   LEFT JOIN areas AS tar ON tas.id_area=tar.id 
		LEFT JOIN docentes AS td ON tc.id_docente=td.id_docente 
		LEFT JOIN sedes AS ts ON tc.id_sede=ts.id 
	   LEFT JOIN jornadas AS tj ON tc.cod_jorn=tj.cod_jorn
	   LEFT JOIN grados As tg ON tc.id_grado=tg.id
	   LEFT JOIN matriculas AS tm ON tn.id_matric=tm.id_matric
		LEFT JOIN inscripciones AS te ON tm.cod_est=te.cod_est
		LEFT JOIN estado_matricula AS tme ON tm.id_estado = tme.id
		LEFT JOIN `desempeños` AS t1 ON (tn.final BETWEEN t1.desde AND t1.hasta AND t1.`año` = tn.`año`)
		LEFT JOIN grados_agrupados AS t2 ON t1.id_grado_agrupado = t2.id 
		LEFT JOIN aux_grados_agrupados AS t3 ON t3.id_grado_agrupado = t2.id
		LEFT JOIN escala_nacional AS es ON t1.id_escala = es.id
		WHERE tn.periodo = _periodo AND tn.`año` = `_año` AND tn.id_inst = _id_inst
		AND tc.`año` = `_año` AND tc.id_inst = _id_inst AND tas.id_inst = _id_inst
		AND tar.id_inst = _id_inst AND td.`año` = `_año` AND ts.ID_INST = _id_inst
		AND tm.`año` = `_año` AND te.id_inst = _id_inst AND tc.id_docente = _id_docente
		AND t3.id_grado = tc.id_grado) 		
		ORDER BY sede,cod_grado,grupo,jornada,estado_matricula,area,asignatura,estudiante;
END$$

DROP PROCEDURE IF EXISTS `sp_select_parcelador`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_select_parcelador` (IN `_id_inst` INT(20), IN `_id_docente` INT(30), IN `_año` YEAR)  BEGIN
SELECT tm.*, UPPER(tg.grado) AS grado, TRIM(ta.asignatura) AS asignatura  
	FROM parcelador AS tm, grados AS tg, asignaturas AS ta 	
	WHERE tm.id_grado = tg.id AND tm.id_asig=ta.id_pk 
	AND tm.estado=1 AND tm.id_docente=_id_docente
	AND tm.año=_año AND tm.id_inst=_id_inst 
	AND ta.id_inst=_id_inst 
	ORDER BY tm.id_grado,asignatura, tm.periodo;
END$$

DROP PROCEDURE IF EXISTS `sp_select_par_cl`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_select_par_cl` (IN `_id_parcelador` INT(20), IN `_type` INT(1))  BEGIN
	SELECT * FROM parcelador_cli WHERE id_parcelador=_id_parcelador AND tipo=_type;			
END$$

DROP PROCEDURE IF EXISTS `sp_select_par_cli`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_select_par_cli` (IN `_id_parcelador` INT(20), IN `_type` INT(1), IN `_año` YEAR, IN `_id_inst` INT(20), IN `_grado` INT(11))  BEGIN
	SELECT tp.*, tc.competencia , td.nombre_escala  
		FROM parcelador_cli AS tp 
		LEFT JOIN competencias AS tc ON tp.id_competencia=tc.id 
		LEFT JOIN grados_agrupados AS t1 ON tc.id_grado_agrupado= t1.id
		LEFT JOIN aux_grados_agrupados AS t2 ON t2.id_grado_agrupado = t1.id
		LEFT JOIN escala_nacional AS td ON tp.id_escala=td.id 
		WHERE tp.id_parcelador=_id_parcelador AND tp.tipo >= _type AND tc.año=_año 
		AND tc.id_inst=_id_inst AND td.id_inst=_id_inst 
		AND t2.id_grado = _grado
      ORDER BY competencia;	
END$$

DROP PROCEDURE IF EXISTS `sp_select_par_cont_tem`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_select_par_cont_tem` (IN `_id_parcelador` INT(20), IN `_type` INT(1))  BEGIN	
	SELECT tc.id, tc.id_parcelador, RTRIM(tc.descripcion) AS descripcion, rtrim(ti.descripcion) AS descripcion_item FROM 
    parcelador_con_tem AS tc LEFT JOIN parcelador_items_con_tem AS ti ON tc.tipo=ti.id   
	WHERE tc.id_parcelador=_id_parcelador AND tc.tipo=_type AND tc.estado=1;       
END$$

DROP PROCEDURE IF EXISTS `sp_select_plan_semanal_clases`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_select_plan_semanal_clases` (IN `_id_inst` INT(20), IN `_id_docente` INT(20), IN `_año` YEAR, IN `_limit` TINYINT, IN `_min` INT(6), IN `_max` INT(6))  BEGIN
	IF _limit = 1 then
		SELECT tp.*, CONCAT(rtrim(td.apellido1),' ',rtrim(td.apellido2),' ',rtrim(td.nombre1),' ',rtrim(td.nombre2)) AS docente,
		tg.grado, tas.asignatura FROM plan_semanal_clases AS tp 
		left join docentes AS td on tp.id_docente=td.id_docente 
		left join grados as tg on tp.cod_grado=tg.cod_grado 
		left join asignaturas as tas on tp.id_asig=tas.id WHERE 
		tp.id_inst=_id_inst AND tp.id_docente=_id_docente AND 
		tp.año=_año and tas.año=_año and tas.id_inst=_id_inst
		ORDER BY tp.cod_grado,tp.id_asig,tp.periodo limit _min,_max; 
	else 
		SELECT tp.*, CONCAT(rtrim(td.apellido1),' ',rtrim(td.apellido2),' ',rtrim(td.nombre1),' ',rtrim(td.nombre2)) AS docente,
		tg.grado, tas.asignatura FROM plan_semanal_clases AS tp 
		left join docentes AS td on tp.id_docente=td.id_docente  
		left join grados as tg on tp.cod_grado=tg.cod_grado 
		left join asignaturas as tas on tp.id_asig=tas.id WHERE 
		tp.id_inst=_id_inst AND tp.id_docente=_id_docente AND 
		tp.año=_año and tas.año=_año and tas.id_inst=_id_inst
		ORDER BY tp.cod_grado,tp.id_asig,tp.periodo; 
    end if;
END$$

DROP PROCEDURE IF EXISTS `sp_select_preinforme`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_select_preinforme` (IN `_id_matric` INT(30), IN `_id_curso` INT(30), IN `_per` VARCHAR(2), IN `_grado` INT(11))  BEGIN
	DECLARE 
		cTable, cTable1 VARCHAR(60) DEFAULT '';
	SELECT fn_return_table_preinforme(_grado) INTO cTable;
	SELECT fn_return_table_notas(_grado) INTO cTable1;
	SET @sqlSelect = CONCAT("SELECT tn.final, tn.periodo, t1.obs, 
	IF(ISNULL(t1.estado), 0, t1.estado) estado
	FROM ",cTable1," AS tn 
	LEFT JOIN ",cTable," AS t1 ON t1.id_nota = tn.id
	WHERE tn.periodo = '",_per,"' AND tn.id_curso = ",_id_curso," AND 
	tn.id_matric = ",_id_matric);
	PREPARE smtp FROM @sqlSelect;
	EXECUTE smtp;
	DEALLOCATE PREPARE smtp;
END$$

DROP PROCEDURE IF EXISTS `sp_select_preinforme_all`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_select_preinforme_all` (IN `_id_inst` INT(30), IN `_id_curso` INT(30), IN `_per` VARCHAR(2), IN `_grado` INT(11), IN `_grupo` VARCHAR(2), IN `_año` YEAR)  BEGIN
	DECLARE 
		cTable, cTable1 VARCHAR(60) DEFAULT '';
	SELECT fn_return_table_preinforme(_grado) INTO cTable;
	SELECT fn_return_table_notas(_grado) INTO cTable1;
	SET @sqlSelect = CONCAT("SELECT tn.final, tn.periodo, t1.id, t1.obs, 
	IF(ISNULL(t1.estado), 0, t1.estado) estado,
	CONCAT(TRIM(ti.apellido1),' ',TRIM(ti.apellido2),' ',TRIM(ti.nombre1),' ',TRIM(ti.nombre2)) AS estudiante
	FROM ",cTable1," AS tn 
	LEFT JOIN cursos AS tc ON (tn.id_curso = tc.id AND tn.`año` = tc.`año`)
	LEFT JOIN ",cTable," AS t1 ON t1.id_nota = tn.id
	LEFT JOIN matriculas AS tm ON tn.id_matric = tm.id_matric
	LEFT JOIN inscripciones AS ti ON tm.cod_est = ti.cod_est
	WHERE tn.periodo = '",_per,"' AND tn.id_curso = ",_id_curso," 
	AND tc.id = ",_id_curso," AND t1.id_nota = tn.id 
	AND tc.`año` = ",`_año`," AND tm.`año` = ",`_año`," 
	AND tm.id_grado=",_grado," ORDER BY estudiante");
	PREPARE smtp FROM @sqlSelect;
	EXECUTE smtp;
	DEALLOCATE PREPARE smtp;
END$$

DROP PROCEDURE IF EXISTS `sp_select_respeciales`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_select_respeciales` (IN `_id_sede` INT(20), IN `_año` YEAR, IN `_cod_grado` VARCHAR(2) charset utf8)  BEGIN
SELECT tr.nro_acta,tr.id_docente,tm.cod_est,tm.cod_grado,tm.grupo,
	 tm.id_sede,tm.id_jorn,tr.id_asig,tm.año,tas.cod_area,tr.notafinal,
	 tr.notarecuperada,tr.fecha,tas.abrev, tar.area,
	 CONCAT(RTRIM(ti.apellido1),' ',RTRIM(ti.apellido2),' ',RTRIM(ti.nombre1),' ',RTRIM(ti.nombre2)) AS nombres 
	 FROM respeciales AS tr 
	 LEFT JOIN asignaturas AS tas ON tr.id_asig = tas.id 
	 LEFT JOIN areas AS tar ON tas.cod_area = tar.cod_area 
	 LEFT JOIN matriculas AS tm ON tr.id_matric = tm.id_matric
	 LEFT JOIN inscripciones AS ti ON tm.cod_est = ti.cod_est 
	 WHERE tm.id_sede = _id_sede AND tm.cod_grado = _cod_grado and 
	 tm.año = _año AND tar.año = _año AND tas.año = _año AND tm.estado = 2
	 ORDER BY tr.nro_acta,tm.cod_grado,tm.grupo,nombres,tas.cod_area,tr.id_asig,tm.año;
END$$

DROP PROCEDURE IF EXISTS `sp_select_respeciales_docente`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_select_respeciales_docente` (IN `_id_inst` INT(30), IN `_año` YEAR, IN `_id_docente` INT(30), IN `_all` INT)  BEGIN
	IF _all > 0 THEN
		SELECT tr.id,tr.id_matric,RIGHT(CONCAT('000000',tr.nro_acta),6) nro_acta,tc.id_docente,tc.id_asig,
		tr.notafinal,tr.notarecuperada,tr.fecha,tr.estado,tm.año,tg.cod_grado,tm.grupo,tas.id_area cod_area,tas.abrev,
		RTRIM(tas.asignatura) asignatura, RTRIM(tar.area) area,
		 CONCAT(RTRIM(ti.apellido1),' ',RTRIM(ti.apellido2),' ',RTRIM(ti.nombre1),' ',RTRIM(ti.nombre2)) AS estudiante,
		 CONCAT(RTRIM(td.apellido1),' ',RTRIM(td.apellido2),' ',RTRIM(td.nombre1),' ',RTRIM(td.nombre2)) AS docente,
		 RTRIM(ts.NOM_SEDE) sede, RTRIM(tj.JORNADA) jornada
		 FROM respeciales AS tr 
		 LEFT JOIN cursos AS tc ON tr.id_curso = tc.id
		 LEFT JOIN matriculas AS tm ON tr.id_matric = tm.id_matric
		 LEFT JOIN grados AS tg ON (tc.id_grado = tg.id AND tm.id_grado = tg.id)
		 LEFT JOIN asignaturas AS tas ON tc.id_asig = tas.id_pk 
		 LEFT JOIN areas AS tar ON tas.id_area = tar.id 
		 LEFT JOIN inscripciones AS ti ON tm.cod_est = ti.cod_est
		 LEFT JOIN docentes AS td ON tc.id_docente = td.id_docente
		 LEFT JOIN sedes AS ts ON tm.id_sede = ts.ID 
		 LEFT JOIN jornadas AS tj ON tm.id_jorn = tj.cod_jorn
		 WHERE tc.`año` = `_año` AND tc.id_docente = _id_docente AND tm.año = _año 
		 AND tm.id_estado = 2 AND td.id_inst = _id_inst AND td.`año` = `_año`
		 ORDER BY tr.nro_acta,tm.id_grado,tm.grupo,estudiante,tas.id_area,tc.id_asig,tm.año;
	ELSE
		SELECT tr.id,tr.id_matric,RIGHT(CONCAT('000000',tr.nro_acta),6) nro_acta,td.id_docente,tc.id_asig,
		tr.notafinal,tr.notarecuperada,tr.fecha,tr.estado,tm.año,tg.cod_grado,tm.grupo,tas.id_area cod_area,tas.abrev,
		RTRIM(tas.asignatura) asignatura, RTRIM(tar.area) area,
		 CONCAT(RTRIM(ti.apellido1),' ',RTRIM(ti.apellido2),' ',RTRIM(ti.nombre1),' ',RTRIM(ti.nombre2)) AS estudiante,
		 CONCAT(RTRIM(td.apellido1),' ',RTRIM(td.apellido2),' ',RTRIM(td.nombre1),' ',RTRIM(td.nombre2)) AS docente,
		 RTRIM(ts.NOM_SEDE) sede, RTRIM(tj.JORNADA) jornada
		 FROM respeciales AS tr 
		 LEFT JOIN cursos AS tc ON tr.id_curso = tc.id
		 LEFT JOIN matriculas AS tm ON tr.id_matric = tm.id_matric
		 LEFT JOIN grados AS tg ON (tc.id_grado = tg.id AND tm.id_grado = tg.id)
		 LEFT JOIN asignaturas AS tas ON tc.id_asig = tas.id_pk 
		 LEFT JOIN areas AS tar ON tas.id_area = tar.id 
		 LEFT JOIN inscripciones AS ti ON tm.cod_est = ti.cod_est
		 LEFT JOIN docentes AS td ON tc.id_docente = td.id_docente
		 LEFT JOIN sedes AS ts ON tm.id_sede = ts.ID 
		 LEFT JOIN jornadas AS tj ON tm.id_jorn = tj.cod_jorn
		 WHERE tc.`año` = `_año` AND tc.id_docente = _id_docente AND tm.año = _año 
		 AND tm.id_estado = 2 AND td.id_inst = _id_inst AND td.`año` = `_año`
		 AND tr.estado = 1
		 ORDER BY tr.nro_acta,tm.id_grado,tm.grupo,estudiante,tas.id_area,tc.id_asig,tm.año;
	END IF;
END$$

DROP PROCEDURE IF EXISTS `sp_select_respeciales_est`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_select_respeciales_est` (IN `_id_inst` INT(30), IN `_año` YEAR, IN `_id_matric` INT(30))  BEGIN
	SELECT RIGHT(CONCAT('000000',tr.nro_acta),6) acta,tm.id_matric,tm.año,tas.id_area cod_area,tr.notafinal,
	 tr.notarecuperada,tr.fecha,tas.abrev, RTRIM(tar.area) area,
	 CONCAT(RTRIM(ti.apellido1),' ',RTRIM(ti.apellido2),' ',RTRIM(ti.nombre1),' ',RTRIM(ti.nombre2)) AS nombres 
	 FROM respeciales AS tr 
	 LEFT JOIN cursos AS tc ON tr.id_curso = tc.id
	 LEFT JOIN asignaturas AS tas ON tc.id_asig = tas.id_pk 
	 LEFT JOIN areas AS tar ON tas.id_area = tar.id 
	 LEFT JOIN matriculas AS tm ON tr.id_matric = tm.id_matric
	 LEFT JOIN inscripciones AS ti ON tm.cod_est = ti.cod_est 
	 WHERE tm.id_inst = _id_inst AND tm.`año` = `_año` AND tm.id_matric = _id_matric
	 AND tc.año = _año AND tar.id_inst = _id_inst AND tar.estado = 1 
	 AND tas.id_inst = _id_inst AND tas.estado = 1
	 ORDER BY tr.nro_acta,tm.id_grado,tm.grupo,nombres,tas.id_area,tc.id_asig,tm.año;
END$$

DROP PROCEDURE IF EXISTS `sp_select_sabanas`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_select_sabanas` (IN `_id_inst` INT(30), IN `_año` YEAR, IN `_sede` INT(30), IN `_jorn` INT(1), IN `_grado` INT(11), IN `_grupo` VARCHAR(2))  BEGIN
	SELECT ta.*,tm.id_grado cod_grado,tm.id_matric,tm.grupo,tm.año,tm.id_inst,tm.id_sede,
	RIGHT(CONCAT('0000',tm.id_folio),4) id_folio, RIGHT(CONCAT('000000',tm.nro_matricula),6) AS id_matricula,
	CONCAT(RTRIM(ti.apellido1),' ',RTRIM(ti.apellido2),' ',RTRIM(ti.nombre1),' ',RTRIM(ti.nombre2)) nombres,
	RTRIM(tg.grado) grado, RTRIM(tj.JORNADA) jornada, RTRIM(ts.NOM_SEDE) sede, tac.msg
	FROM sabanas AS ta 
	LEFT JOIN matriculas AS tm ON ta.id_matric = tm.id_matric 
	LEFT JOIN inscripciones AS ti ON tm.cod_est = ti.cod_est
	LEFT JOIN grados AS tg ON tm.id_grado = tg.id
	LEFT JOIN jornadas AS tj ON tm.id_jorn = tj.cod_jorn
	LEFT JOIN sedes AS ts ON tm.id_sede = ts.ID
	LEFT JOIN acta_promocion AS tac ON tac.id_matric = tm.id_matric
	WHERE tm.id_grado=_grado  AND tm.id_sede=_sede AND tm.año=`_año` AND 
	tm.id_jorn=_jorn AND tm.grupo= _grupo AND ti.id_inst = _id_inst AND tm.id_estado = 2
	ORDER BY nombres;
END$$

DROP PROCEDURE IF EXISTS `sp_select_sugerencias_estudiante`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_select_sugerencias_estudiante` (IN `_id_inst` INT(20), IN `_año` YEAR, IN `_periodo` VARCHAR(2), IN `_id_nota` INT(30), IN `_cod_grado` INT(11))  BEGIN
	DECLARE cTable, cTable2	VARCHAR(30) DEFAULT '';
	SELECT fn_return_table_notas(_cod_grado) INTO cTable;
	SELECT fn_return_table_sug(_cod_grado) INTO cTable2;
	SET @sqlSelect = CONCAT("SELECT ts.id,RTRIM(ts.sugerencia) AS sugerencia,ts.tipo
		FROM sugerencias AS ts 
		LEFT JOIN ",cTable2," AS tg ON tg.id_sugerencia = ts.id
		LEFT JOIN ",cTable," AS tn ON tg.id_nota = tn.id 
		WHERE ts.id_inst = ",_id_inst," AND ts.año = ",_año," AND 
		ts.periodo = '",_periodo,"' AND tg.id_nota = ",_id_nota,"
		ORDER BY ts.tipo, ts.sugerencia");
	PREPARE smtp FROM @sqlSelect;
	EXECUTE smtp;
	DEALLOCATE PREPARE smtp;	
END$$

DROP PROCEDURE IF EXISTS `sp_select_sugerencias_estudiante_all`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_select_sugerencias_estudiante_all` (IN `_id_inst` INT(30), IN `_id_docente` INT(30), IN `_año` YEAR, IN `_cod_grado` INT(11), IN `_periodo` VARCHAR(2), IN `_grupo` VARCHAR(2), IN `_id_sede` INT(30), IN `_cod_jorn` INT(2), IN `_id_asig` INT(11))  BEGIN
	DECLARE cTable, cTable2 VARCHAR(30) DEFAULT '';
	SELECT fn_return_table_sug(_cod_grado) INTO cTable;
	SELECT fn_return_table_notas(_cod_grado) INTO cTable2;
	SET @sqlSelect = CONCAT("SELECT ts.*, tg.*, tn.id_matric,
		concat(rtrim(ti.apellido1),' ',rtrim(ti.apellido2),' ',rtrim(ti.nombre1),' ',rtrim(ti.nombre2)) 
		AS nombres FROM sugerencias AS ts 
		LEFT JOIN ",cTable," AS tg ON tg.id_sugerencia = ts.id 
		LEFT JOIN ",cTable2," AS tn ON tg.id_nota = tn.id 
		LEFT JOIN cursos AS tc ON (tn.id_curso = tc.id AND tn.`año` = tc.`año`)
	   LEFT JOIN matriculas AS tm ON tn.id_matric = tm.id_matric
		LEFT JOIN inscripciones AS ti on tm.cod_est = ti.cod_est
		WHERE ts.id_inst=",_id_inst," AND ts.id_docente=",_id_docente," AND 
		ts.año=",_año," AND ts.periodo = '",_periodo,"'  AND tm.id_grado = ",_cod_grado," AND
		tm.grupo = '",_grupo,"' AND tm.id_sede = ",_id_sede," AND tn.año=",_año,
		" AND tm.id_jorn = ",_cod_jorn," 
		AND tn.periodo = '",_periodo,"' AND tm.año= ",_año," AND tc.id_asig = ",_id_asig,"
		AND tc.`año` = ",`_año`," AND tc.id_grado = ",_cod_grado,
		" AND tc.id_docente = ",_id_docente," AND tc.cod_jorn = ",_cod_jorn,"
		ORDER BY nombres, ts.periodo, ts.tipo");
	PREPARE smtp FROM @sqlSelect;
	EXECUTE smtp;
	DEALLOCATE PREPARE smtp;
END$$

DROP PROCEDURE IF EXISTS `sp_select_unidades`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_select_unidades` (IN `_id_parcelador` INT(20))  BEGIN
	SELECT * FROM parcelador_unidades   
	WHERE id_parcelador=_id_parcelador AND estado=1; 
END$$

DROP PROCEDURE IF EXISTS `sp_set_folio_matriculas`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_set_folio_matriculas` (IN `_id_inst` INT(20), IN `_año` YEAR)  BEGIN
	DECLARE 	done, 
				_cant_est_x_libro,
				_count_libro,
				_count_folio,
				_cant_mat,
				_id_matric,
				_n_libro INT DEFAULT 0;
	DECLARE 	_total_libros DECIMAL (6,2) DEFAULT 0;
	DECLARE cur_mat CURSOR FOR SELECT id_matric FROM matriculas WHERE año = `_año` AND id_inst = _id_inst ORDER BY id_matric;	
	DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done = 1;
	
	SELECT cant_est_x_libro INTO _cant_est_x_libro FROM config001 WHERE año = `_año` AND id_inst = _id_inst;

	SET _n_libro = 1;
	OPEN cur_mat;
	REPEAT 
		FETCH cur_mat INTO _id_matric;
		IF NOT done THEN 
			SET _count_libro = _count_libro + 1;
			SET _count_folio = _count_folio + 1;
			UPDATE matriculas SET nro_matricula = _count_folio, id_folio = _count_folio, libro_mat = _n_libro 
			WHERE id_matric = _id_matric;
			IF _count_libro = _cant_est_x_libro THEN 
				SET _count_libro = 0;
				SET _n_libro = _n_libro +1;
			END IF;
		END IF;
	UNTIL done END REPEAT;
END$$

DROP PROCEDURE IF EXISTS `sp_set_notas_resp_normal`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_set_notas_resp_normal` (IN `_id_inst` INT(20), IN `_id_sede` INT(20), IN `_id_docente` INT(20), IN `_cod_grado` VARCHAR(2), IN `_grupo` VARCHAR(2), IN `_id_asig` INT(3), IN `_año` YEAR, IN `_x_nro_acta` INT(6))  BEGIN
	DECLARE 	done, 
				_id_matric,
				_promocion INT DEFAULT 0;
	DECLARE _c_grado VARCHAR(2) DEFAULT '';
	
	DECLARE	cur_mat CURSOR FOR SELECT tm.id_matric,tm.cod_grado FROM matriculas AS tm WHERE tm.cod_grado = _cod_grado AND
					tm.grupo = _grupo AND tm.`año` = `_año` AND tm.id_inst = _id_inst AND tm.estado = 2;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done = 1;
	
	SELECT promocion INTO _promocion FROM config001 AS cg WHERE cg.`AÑO` = `_año` AND cg.id_inst = _id_inst;
	
	OPEN cur_mat;
	REPEAT 
		FETCH cur_mat INTO _id_matric, _c_grado;
		IF NOT done THEN
			SET done = 1;
		END IF;
	UNTIL done END REPEAT;
	CLOSE cur_mat;
	
END$$

DROP PROCEDURE IF EXISTS `sp_update_areasf`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_update_areasf` (IN `_id_matric` INT(20), IN `_final` DECIMAL(6,2), IN `_recuperacion` DECIMAL(6,2), IN `_periodo` VARCHAR(1))  BEGIN
	DECLARE n_matric, _año, _id_inst INT DEFAULT 0;
	DECLARE done, _t_año_lectivo INT DEFAULT 0;
	DECLARE _cod_grado CHAR(2) DEFAULT '';
	DECLARE _prom, _prom_rec DECIMAL(6,2) DEFAULT 0;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done = 1;
	
	SELECT COUNT(*) INTO n_matric FROM acta_promocion WHERE id_matric = _id_matric;
	SELECT año, id_inst,cod_grado INTO _año, _id_inst,_cod_grado FROM matriculas WHERE id_matric = _id_matric;
	SELECT t_año_lectivo INTO _t_año_lectivo FROM config001 WHERE id_inst=_id_inst AND año=_año;
		
	IF n_matric	= 0 THEN 
		INSERT INTO acta_promocion (id_matric,promedio,promedio_rec)  
		VALUES(_id_matric,_final,IF(_final > _recuperacion,_final,_recuperacion));
	ELSE
		SELECT ROUND(AVG(final),2), ROUND(AVG(IF(final > recuperacion,final,recuperacion)),2)  INTO _prom, _prom_rec
		FROM areasf WHERE id_matric=_id_matric GROUP BY id_matric;		
		UPDATE acta_promocion SET promedio = _prom,promedio_rec = _prom_rec WHERE id_matric = _id_matric;
	END IF;		
	IF _t_año_lectivo = 1 THEN 
		/* Año lectivo por areas */
		 IF _cod_grado BETWEEN '21' AND '26' THEN
		 	CALL sp_libro_final_areas_ciclos(_id_matric, _año, _id_inst,_periodo);
		 ELSE
		 	CALL sp_libro_final_areas(_id_matric, _año, _id_inst);
		 END IF;
	ELSE 
		/* Año Lectivo por asignaturas*/
		 IF _cod_grado BETWEEN '21' AND '26' THEN
		 	CALL sp_libro_final_asignaturas_ciclos(_id_matric, _año, _id_inst,_periodo);
		 ELSE
		 	CALL sp_libro_final_asignaturas(_id_matric, _año, _id_inst);
		 END IF;
	END IF;
END$$

DROP PROCEDURE IF EXISTS `sp_update_areasf_notas`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_update_areasf_notas` (IN `_id_matric` INT(20), IN `_periodo` VARCHAR(1), IN `_id_asig` INT(3), IN `_nota_final` DECIMAL(6,2), IN `_prom` DECIMAL(6,2), IN `_faltas` INT, IN `_injustificadas` INT, IN `_retraso` INT)  BEGIN
	DECLARE 	_promocion, 
				_año, 
				_id_inst, 
				_id_sede, 
				_id_jorn,
				_count INT DEFAULT 0;
	DECLARE 	_cod_grado, 
				_grupo VARCHAR(2) DEFAULT '';
				
	SELECT cod_grado,grupo,año,id_sede,id_inst,id_jorn 
	INTO _cod_grado,_grupo,_año,_id_sede,_id_inst,_id_jorn 
	FROM matriculas WHERE id_matric = _id_matric;
	
	SELECT promocion INTO _promocion FROM config001 WHERE año=`_año` AND id_inst = `_id_inst`;
	SELECT COUNT(id_matric) INTO _count FROM areasf WHERE id_asig = _id_asig AND id_matric = _id_matric;
	
	CASE  _promocion 
		WHEN 1  THEN /*Promoción por promedios*/
			IF NOT _count THEN /*Si no existe el registro*/
				CASE _periodo
					WHEN '1' THEN 
						 INSERT INTO areasf (id_asig,id_matric,periodo,p1,final,faltas,injustificadas,retraso) 
						 VALUES (_id_asig,_id_matric,1,_nota_final,_prom,_faltas,_injustificadas,_retraso);
					WHEN '2' THEN 
						 INSERT INTO areasf (id_asig,id_matric,periodo,p2,final,faltas,injustificadas,retraso) 
						 VALUES (_id_asig,_id_matric,2,_nota_final,_prom,_faltas,_injustificadas,_retraso);
					WHEN '3' THEN 
						 INSERT INTO areasf (id_asig,id_matric,periodo,p3,final,faltas,injustificadas,retraso) 
						 VALUES (_id_asig,_id_matric,3,_nota_final,_prom,_faltas,_injustificadas,_retraso);
					WHEN '4' THEN 
						 INSERT INTO areasf (id_asig,id_matric,periodo,p4,final,faltas,injustificadas,retraso) 
						 VALUES (_id_asig,_id_matric,4,_nota_final,_prom,_faltas,_injustificadas,_retraso);
					ELSE 
						INSERT INTO areasf (id_asig,id_matric,periodo,final,faltas,injustificadas,retraso) 
						VALUES (_id_asig,_id_matric,_periodo,_prom,_faltas,_injustificadas,_retraso);
				END CASE;
			ELSE
				CASE _periodo
					WHEN '1' THEN 
						  UPDATE areasf SET periodo=1,p1=_nota_final,final=_prom,faltas=_faltas,
						  injustificadas=_injustificadas,retraso=_retraso 
						  WHERE id_matric = _id_matric AND id_asig = _id_asig;
					WHEN '2' THEN 
						 UPDATE areasf SET periodo=2,p2=_nota_final,final=_prom,faltas=_faltas,
						  injustificadas=_injustificadas,retraso=_retraso 
						  WHERE id_matric = _id_matric AND id_asig = _id_asig;
					WHEN '3' THEN 
						 UPDATE areasf SET periodo=3,p3=_nota_final,final=_prom,faltas=_faltas,
						  injustificadas=_injustificadas,retraso=_retraso 
						  WHERE id_matric = _id_matric AND id_asig = _id_asig;
					WHEN '4' THEN 
						UPDATE areasf SET periodo=4,p4=_nota_final,final=_prom,faltas=_faltas,
						  injustificadas=_injustificadas,retraso=_retraso 
						  WHERE id_matric = _id_matric AND id_asig = _id_asig;
					ELSE 
						UPDATE areasf SET periodo=_periodo,final=_prom,faltas=_faltas,
						  injustificadas=_injustificadas,retraso=_retraso 
						  WHERE id_matric = _id_matric AND id_asig = _id_asig;
				END CASE;
			END IF;			
	END CASE;
END$$

DROP PROCEDURE IF EXISTS `sp_update_id_matric_respeciales`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_update_id_matric_respeciales` ()  BEGIN
	DECLARE done,_año,_cod_est INT DEFAULT 0;	
	DECLARE cur_respeciales CURSOR FOR SELECT cod_est,año FROM respeciales GROUP BY cod_est,año ORDER BY cod_est, año;
	DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done = 1;
	
	OPEN cur_respeciales;
	
	REPEAT
		FETCH cur_respeciales INTO _cod_est, _año;
		IF NOT done THEN
			UPDATE respeciales SET id_matric = (SELECT id_matric FROM matriculas WHERE cod_est=_cod_est AND año=_año) 
			WHERE cod_est=_cod_est AND año=_año; 
		END IF;
	UNTIL done END REPEAT;
 CLOSE cur_respeciales;
END$$

DROP PROCEDURE IF EXISTS `sp_update_mayus`$$
CREATE DEFINER=CURRENT_USER() PROCEDURE `sp_update_mayus` (IN `_id_inst` INT(30), IN `_año` YEAR, IN `_per` VARCHAR(1))  BEGIN
	UPDATE logros_estandares  SET descripcion = UPPER(RTRIM(descripcion)) 
	WHERE id_inst = _id_inst AND periodo = _per AND `año` = `_año`;
END$$

DROP FUNCTION IF EXISTS `estado_estudiante_normal`$$
CREATE DEFINER=CURRENT_USER() FUNCTION `estado_estudiante_normal` (`_id` INT(2), `_cod_grado` INT(11), `_id_inst` INT(30)) RETURNS VARCHAR(250) CHARSET utf8 READS SQL DATA
BEGIN
	DECLARE result VARCHAR(250) DEFAULT '';
	DECLARE _estado,_name_grado VARCHAR(100) DEFAULT '';
	DECLARE c_grado_return, _prom, _fin INT(11) DEFAULT 0;
	
	SET c_grado_return = _cod_grado + 1;
	
	SELECT RTRIM(t.descripcion_estado), t.prom_manual, t1.fin_ciclo_escolar
	INTO _estado, _prom, _fin
	FROM estado_estudiante t
	LEFT JOIN grados_agrupados AS t1 ON t.id_grupo_grados = t1.id 
	LEFT JOIN aux_grados_agrupados AS t2 ON t2.id_grado_agrupado = t1.id
	WHERE t.id = _id AND t.id_inst = _id_inst AND t2.id_grado = _cod_grado;
	
	IF _prom = 1 THEN /* Promoción manual */
		SET result = _estado;
	ELSEIF _fin = 1 THEN /* Fin de ciclo escolar */
		SELECT RTRIM(grado) INTO _name_grado FROM grados WHERE id = _cod_grado;
		SET result = CONCAT(_estado);
	ELSE 
		SELECT RTRIM(grado) INTO _name_grado FROM grados WHERE id = c_grado_return;
		SET result = CONCAT(_estado,' ',_name_grado);
	END IF;
	
	RETURN UPPER(result);
END$$

DROP FUNCTION IF EXISTS `fn_asignaturas_perdidas`$$
CREATE DEFINER=CURRENT_USER() FUNCTION `fn_asignaturas_perdidas` (`_id_matric` INT(30), `_year` YEAR, `_id_grado` INT(11)) RETURNS TEXT CHARSET utf8 READS SQL DATA
BEGIN
 	DECLARE result, _as TEXT DEFAULT '';
	DECLARE x, x_ar, x_c INT(30) DEFAULT 0;
  	DECLARE done INT DEFAULT 0;
  	DECLARE _desde, _hasta DECIMAL(6,2) DEFAULT 0;
 	DECLARE cur_ar CURSOR FOR SELECT SQL_SMALL_RESULT tc.id_asig, TRIM(ta.asignatura), ta.id_area 
	   FROM areasf t 
	   LEFT JOIN cursos AS tc ON t.id_curso = tc.id
		LEFT JOIN asignaturas AS ta ON tc.id_asig =ta.id_pk
		LEFT JOIN matriculas AS tm ON t.id_matric = tm.id_matric
		LEFT JOIN respeciales AS tr  ON (tr.id_matric = tm.id_matric AND tr.id_curso = t.id_curso)
		WHERE t.final BETWEEN _desde AND _hasta AND
		t.id_matric = _id_matric AND tc.`año` = _year AND tc.id_grado = _id_grado
		AND tm.`año` = _year AND ta.estado = 1 AND tm.id_estado = 2
		AND IF(ISNULL(tr.notarecuperada), t.final <= _hasta, tr.notarecuperada <= _hasta);
 	DECLARE CONTINUE HANDLER FOR SQLSTATE	 '02000' SET done	= 1;
 	
 SELECT t.desde, t.hasta INTO _desde, _hasta 
 FROM `desempeños` t 
 LEFT JOIN grados_agrupados AS t1 ON t.id_grado_agrupado = t1.id 
 LEFT JOIN aux_grados_agrupados AS t2 ON t2.id_grado_agrupado = t1.id
 WHERE t.reprueba = 1 AND t.`año` = _year AND t2.id_grado = _id_grado LIMIT 1;
 
 OPEN cur_ar;
 
 REPEAT 
 	FETCH cur_ar INTO x, _as, x_ar;
 	IF NOT done THEN
 		SET x_c = 0;
 		SELECT cod_area INTO x_c FROM tmpTableAreasf WHERE cod_area = x_ar AND final BETWEEN _desde AND _hasta LIMIT 1;
 		SET done = 0;
 		IF x_c > 0 THEN 
 			SET result = CONCAT(result,_as,', ');
 		END IF;
 	END IF;
 UNTIL done END REPEAT;
 
 CLOSE cur_ar;
 
RETURN LEFT(result,LENGTH(result)-2);
END$$

DROP FUNCTION IF EXISTS `fn_cert_final_estudio`$$
CREATE DEFINER=CURRENT_USER() FUNCTION `fn_cert_final_estudio` (`_id_inst` INT(30), `_año` YEAR, `_id_matric` INT(30), `_modelo` INT) RETURNS TEXT CHARSET utf8 NO SQL
BEGIN
	DECLARE result, lEstado, _prom TEXT DEFAULT '';
	DECLARE _estudiante, _sexo, _documento, _tipo_documento, _estado_est,
		_jornada, _sede, _principal, _tipo_estab,lIdent, lLugar, _grado,
		_nivel,c_id_folio, c_libro_mat,_nivel2,c_grado VARCHAR (250) DEFAULT '';
	DECLARE _dpto_lug_exp, _mun_lug_exp, _estado,_id_folio, _libro_mat, _cod_grado, 
	_nro_matricula, _niv INT DEFAULT 0;

	IF `_año` > YEAR(CURDATE()) THEN
		SET result = 'Las fechas no coinciden, verifique por favor';
	ELSE
		SELECT CONCAT(RTRIM(ti.apellido1),' ',RTRIM(ti.apellido2),' ',RTRIM(ti.nombre1),' ',RTRIM(ti.nombre2)) estudiante, 
		ti.sexo, ti.nro_doc_id documento, RTRIM(tdoc.tipo) tipo_documento, ti.dpto_lug_exp, ti.mun_lug_exp, RTRIM(te.estado_matricula) 
		estado_est, RTRIM(tg.grado) grado, RTRIM(tj.JORNADA) jornada, RTRIM(ts.NOM_SEDE) sede, 
		IF (ts.PRINCIPAL = 'SI', 'PRINCIPAL', ts.NOM_SEDE) principal, tp.tipo tipo_estab, tm.id_estado, tm.id_grado,
		tm.id_folio, tm.libro_mat, tm.nro_matricula
		INTO _estudiante, _sexo, _documento, _tipo_documento, _dpto_lug_exp, _mun_lug_exp, _estado_est,
		_grado, _jornada, _sede, _principal, _tipo_estab, _estado, _cod_grado,_id_folio, _libro_mat, _nro_matricula
		FROM inscripciones AS ti 
		LEFT JOIN matriculas AS tm ON tm.cod_est = ti.cod_est 
		LEFT JOIN sedes AS ts ON tm.id_sede = ts.ID
		LEFT JOIN documentos AS tdoc ON ti.cod_doc = tdoc.id
		LEFT JOIN estado_matricula AS te ON tm.id_estado = te.id 
		LEFT JOIN grados AS tg ON tm.id_grado = tg.id 
		LEFT JOIN jornadas AS tj ON tm.id_jorn = tj.cod_jorn
		LEFT JOIN establecimiento AS t ON ti.id_inst = t.ID 
		LEFT JOIN tipo_establecimiento AS tp ON t.TIPO_EST = tp.id_test
		WHERE t.ID = _id_inst AND ti.id_inst = _id_inst AND tm.id_inst = _id_inst AND tm.`año` = `_año` AND
		tm.id_matric = _id_matric AND tm.id_estado > 1 AND ts.ID_INST = _id_inst LIMIT 1;
				
		IF _sexo = 'M' THEN 
			SET lIdent = 'identificado con';
			SET lEstado = 'matriculado';
		ELSE
			SET lIdent = 'identificada con';
			SET lEstado = 'matriculada';
		END IF;
		SET c_grado = _cod_grado;
		SELECT tg.id_nivel INTO _niv FROM grados AS tg WHERE tg.id = _cod_grado LIMIT 1;
		SELECT fn_lugar_exp(_id_inst, _dpto_lug_exp, _mun_lug_exp, 1) INTO lLugar; 
		SELECT fn_niveles_ens(_id_inst, _cod_grado) INTO _nivel2;
		IF _niv > 1 THEN 
			SELECT fn_GetEstadoFinalEst(_id_matric, 1) INTO _prom;
		ELSE
			SELECT estado_estudiante_normal(1, _cod_grado, _id_inst) INTO _prom;
		END IF;
		SELECT fn_GetOriginalGrado(_cod_grado) INTO _cod_grado;
		SELECT fn_niveles_ens(_id_inst, _cod_grado) INTO _nivel;
		CASE 
			WHEN _modelo = 1 THEN 	
				SET c_libro_mat = RIGHT(CONCAT('0000',_libro_mat),4);
				SET c_id_folio  = RIGHT(CONCAT('0000',_id_folio),4); 
				IF _niv > 1 THEN 				
					SET lEstado = CONCAT(', durante el año lectivo de ',`_año`,', cursó el grado ',_grado,
					' y ',_prom,' de ',_nivel);
				ELSE 
					SET lEstado = CONCAT(', durante el año lectivo de ',`_año`,', cursó y aprobó el grado ',_grado,
					' de ',_nivel2);
				END IF;
				SET result =CONCAT('Que: ',_estudiante,', ',lIdent,' ',_tipo_documento,' Nº. ',_documento,' de ',
									    lLugar,lEstado,'.',' MATRICULA Nº. ',c_id_folio,' Y FOLIO Nº. ',c_id_folio,'. ');
			WHEN _modelo = 2 THEN 
				IF _sexo = 'M' THEN 
					SET lEstado = 'registrado en el Libro de Matriculas de esta(e) ';
				ELSE
					SET lEstado = 'registrada en el Libro de Matriculas de esta(e) ';
				END IF;
				
				SET c_libro_mat = RIGHT(CONCAT('0000',_libro_mat),4);
				SET c_id_folio  = RIGHT(CONCAT('0000',_id_folio),4); 
				IF _niv > 1 THEN				
					SET lEstado = CONCAT(', durante el año lectivo de ',`_año`,' estuvo ',lEstado,_tipo_estab,
							' según registro ',c_libro_mat,' Folio ',c_id_folio,
							' cursando el Grado ',_grado,' Nivel de ',_nivel2,' y ',_prom,' de ',_nivel);
				ELSE
					SET lEstado = CONCAT(', durante el año lectivo de ',`_año`,' estuvo ',lEstado,_tipo_estab,
							' según registro ',c_libro_mat,' Folio ',c_id_folio,
							' cursando el Grado ',_grado,' Nivel de ',_nivel2,' y FUE PROMOVIDO AL SIGUIENTE GRADO');	
				END IF;
				SET result = CONCAT('Que ',_estudiante,' ',lIdent,' ',_tipo_documento,' Número ',_documento,' de ',
									    lLugar,lEstado,'. ');

			ELSE
				SET result = 'Error interno del sistema';
		END CASE;	
	END IF;
	RETURN result;
END$$

DROP FUNCTION IF EXISTS `fn_cons_estudio`$$
CREATE DEFINER=CURRENT_USER() FUNCTION `fn_cons_estudio` (`_id_inst` INT(30), `_año` YEAR, `_id_matric` INT(30), `_modelo` INT(1)) RETURNS TEXT CHARSET utf8 NO SQL
BEGIN
DECLARE result, lEstado TEXT DEFAULT '';
DECLARE _estudiante, _sexo, _documento, _tipo_documento, _estado_est,
		_grado, _jornada, _sede, _principal, _tipo_estab,lIdent, lLugar,
		_nivel,c_id_folio, c_libro_mat VARCHAR (250) DEFAULT '';
DECLARE _dpto_lug_exp, _mun_lug_exp, _estado,_id_folio, _libro_mat, _nro_matricula, _cod_grado INT(30);

	IF `_año` > YEAR(CURDATE()) THEN
		SET result = 'Las fechas no coinciden, verifique por favor';
	ELSE
		SELECT CONCAT(RTRIM(ti.apellido1),' ',RTRIM(ti.apellido2),' ',RTRIM(ti.nombre1),' ',RTRIM(ti.nombre2)) estudiante, 
		ti.sexo, ti.nro_doc_id documento, RTRIM(tdoc.tipo) tipo_documento, ti.dpto_lug_exp, ti.mun_lug_exp, RTRIM(te.estado_matricula) 
		estado_est, RTRIM(tg.grado) grado, RTRIM(tj.JORNADA) jornada, RTRIM(ts.NOM_SEDE) sede, 
		IF (ts.PRINCIPAL = 'SI', 'PRINCIPAL', ts.NOM_SEDE) principal, 
		IF (tp.id_test = 1, CONCAT('esta ',RTRIM(tp.tipo),' educativa'),CONCAT('este ',RTRIM(tp.tipo),' educativo')) tipo_estab, 
		tm.id_estado, tm.id_grado,
		tm.id_folio, tm.libro_mat, tm.nro_matricula, tn.nombre_nivel
		INTO _estudiante, _sexo, _documento, _tipo_documento, _dpto_lug_exp, _mun_lug_exp, _estado_est,
		_grado, _jornada, _sede, _principal, _tipo_estab, _estado, _cod_grado,_id_folio, _libro_mat, 
		_nro_matricula, _nivel
		FROM inscripciones AS ti 
		LEFT JOIN matriculas AS tm ON tm.cod_est = ti.cod_est 
		LEFT JOIN sedes AS ts ON tm.id_sede = ts.ID
		LEFT JOIN documentos AS tdoc ON ti.cod_doc = tdoc.id
		LEFT JOIN estado_matricula AS te ON tm.id_estado = te.id 
		LEFT JOIN grados AS tg ON tm.id_grado = tg.id 
		LEFT JOIN jornadas AS tj ON tm.id_jorn = tj.cod_jorn
		LEFT JOIN establecimiento AS t ON ti.id_inst = t.ID 
		LEFT JOIN tipo_establecimiento AS tp ON t.TIPO_EST = tp.id_test
		LEFT JOIN niveles_estudio AS tn ON tg.id_nivel = tn.id
		WHERE t.ID = _id_inst AND ti.id_inst = _id_inst AND tm.id_inst = _id_inst AND tm.`año` = `_año` AND
		tm.id_matric = _id_matric AND tm.id_estado > 1 AND ts.ID_INST = _id_inst LIMIT 1;
				
		IF _sexo = 'M' THEN 
			SET lIdent = 'identificado con';
			SET lEstado = 'matriculado';
		ELSE
			SET lIdent = 'identificada con';
			SET lEstado = 'matriculada';
		END IF;
		SELECT fn_lugar_exp(_id_inst, _dpto_lug_exp, _mun_lug_exp, 1) INTO lLugar;
		CASE 
			WHEN _modelo = 1 THEN 
				IF `_año` < YEAR(CURDATE()) THEN 
					SET lEstado = CONCAT(', estuvo ',lEstado,' en ',_tipo_estab,', cursando el grado ',
										_grado,' de ',_nivel,' jornada ',_jornada,', año lectivo ',`_año`,', en la sede ',_principal);
				ELSEIF _estado > 2 THEN 
					SET lEstado = CONCAT(', estuvo ',lEstado,' en ',_tipo_estab,', cursando el grado ',
										_grado,' de ',_nivel,', jornada ',_jornada,', año lectivo ',`_año`,', en la sede ',_principal,
										'. Su estado actual es: ',_estado_est);
				ELSE					
					SET lEstado = CONCAT(', se encuentra ',lEstado,' en ',_tipo_estab,', cursando el grado ',
										_grado,' de ',_nivel,', jornada ',_jornada,', año lectivo ',`_año`,', en la sede ',_principal);
				END IF;
				SET result = CONCAT('Que: ',_estudiante,', ',lIdent,' ',_tipo_documento,' Nº. ',_documento,' de ',
									    lLugar,lEstado,'.');
			WHEN _modelo = 2 THEN 
				IF _sexo = 'M' THEN 
					SET lEstado = 'registrado en el Libro de Matriculas de ';
				ELSE
					SET lEstado = 'registrada en el Libro de Matriculas de ';
				END IF;
				SET c_libro_mat = RIGHT(CONCAT('0000',_libro_mat),4);
				SET c_id_folio  = RIGHT(CONCAT('0000',_id_folio),4); 
				IF `_año` < YEAR(CURDATE()) THEN 
					SET lEstado = CONCAT(' Estuvo ',lEstado,_tipo_estab,' según registro ',c_libro_mat,' Folio ',c_id_folio,
										' como alumno (a) del Grado ',_grado,' Nivel de ',_nivel,' jornada ',_jornada,
										' para desarrollar todas las actividades curriculares programadas para el Año lectivo ',`_año`,
										' en la sede ',_principal);
				ELSEIF _estado > 2 THEN 
					SET lEstado = CONCAT(' Estuvo ',lEstado,_tipo_estab,' según registro ',c_libro_mat,' Folio ',c_id_folio,
										' como alumno (a) del Grado ',_grado,' Nivel de ',_nivel,' jornada ',_jornada,
										' para desarrollar todas las actividades curriculares programadas para el Año lectivo ',`_año`,
										' en la sede ',_principal,
										'. Su estado actual es: ',_estado_est);
				ELSE					
					SET lEstado = CONCAT(' Se encuentra ',lEstado,_tipo_estab,' según registro ',c_libro_mat,' Folio ',c_id_folio,
										' como alumno (a) del Grado ',_grado,' Nivel de ',_nivel,' jornada ',_jornada,
										' para desarrollar todas las actividades curriculares programadas para el Año lectivo ',`_año`,
										' en la sede ',_principal);
				END IF;
				SET result = CONCAT('Que ',_estudiante,' ',lIdent,_tipo_documento,' Número ',_documento,' de ',
									    lLugar,lEstado,'.');

			ELSE
				SET result = 'Error interno del sistema';
		END CASE;	
	END IF;
	RETURN result;
END$$

DROP FUNCTION IF EXISTS `fn_Getdesempeño`$$
CREATE DEFINER=CURRENT_USER() FUNCTION `fn_Getdesempeño` (`_id_inst` INT(20), `_año` YEAR, `_nota` DECIMAL(6,2), `_id_grado` INT(11)) RETURNS VARCHAR(50) CHARSET utf8 NO SQL
BEGIN
	DECLARE result VARCHAR(20) DEFAULT '';
	
	SELECT RTRIM(es.nombre_escala) INTO result 
	FROM `desempeños` AS t
	LEFT JOIN escala_nacional AS es ON t.id_escala = es.id
	LEFT JOIN grados_agrupados AS t1 ON t.id_grado_agrupado = t1.id 
	LEFT JOIN aux_grados_agrupados AS t2 ON t2.id_grado_agrupado = t1.id
	WHERE t.id_inst = _id_inst AND t.año = `_año` 
	AND _nota BETWEEN t.desde AND t.hasta AND t2.id_grado = _id_grado LIMIT 1;	
	RETURN result;
END$$

DROP FUNCTION IF EXISTS `fn_GetEstadoFinalEst`$$
CREATE DEFINER=CURRENT_USER() FUNCTION `fn_GetEstadoFinalEst` (`_id_matric` INT(3), `_type` INT) RETURNS TEXT CHARSET utf8 NO SQL
BEGIN
	DECLARE _result, _msg, _msg1, _msg2, _msg3 TEXT DEFAULT '';
	SELECT t.msg,t.msg1,t.msg2,t.msg3 INTO _msg, _msg1, _msg2, _msg3
	FROM acta_promocion t WHERE t.id_matric = _id_matric LIMIT 1; 
	CASE 
		WHEN _type = 1 THEN
			SET _result = _msg;
		WHEN nType = 2 THEN
			SET _result = _msg1;
		WHEN nType = 3 THEN
			SET _result = _msg2;
		WHEN nType = 4 THEN
			SET _result = _msg3;
		ELSE
			SET _result = 'ERROR.';
	END CASE;
	RETURN _result;
END$$

DROP FUNCTION IF EXISTS `fn_GetOriginalGrado`$$
CREATE DEFINER=CURRENT_USER() FUNCTION `fn_GetOriginalGrado` (`_grado` INT(11)) RETURNS INT(11) NO SQL
BEGIN
	DECLARE _result INT(11) DEFAULT 0;
	DECLARE _id_grado INT(11) DEFAULT 0;
	SELECT t2.id_grado INTO _id_grado FROM grados_agrupados AS t1 
	LEFT JOIN aux_grados_agrupados AS t2 ON t2.id_grado_agrupado = t1.id
	WHERE t2.id_grado = _grado AND t1.fin_ciclo_escolar = 1;
	IF _id_grado THEN 
		SET _result = _id_grado;
	ELSE
		SET _result = _grado + 1;
	END IF;		
	RETURN _result;
END$$

DROP FUNCTION IF EXISTS `fn_lugar_exp`$$
CREATE DEFINER=CURRENT_USER() FUNCTION `fn_lugar_exp` (`_id_inst` INT(30), `_dpto` INT, `_mun` INT, `_type` INT(1)) RETURNS VARCHAR(250) CHARSET utf8 NO SQL
BEGIN
DECLARE _result, dpto, mun VARCHAR(250) DEFAULT '';
	IF _type = 1 THEN /* Nombre completo de departamento */
		SELECT UPPER(RTRIM(t2.nombre_mun)), UPPER(RTRIM(t.nombre)) INTO mun, dpto  FROM departamentos t, ciudades t2
		WHERE t.id = _dpto AND t2.id = _mun AND t2.dpto = _dpto LIMIT 1;
	ELSE
		SELECT UPPER(RTRIM(t2.nombre_mun)), UPPER(RTRIM(t.abrev)) INTO mun, dpto  FROM departamentos t, ciudades t2
		WHERE t.id = _dpto AND t2.id = _mun AND t2.dpto = _dpto LIMIT 1;
	END IF;
	SET _result = CONCAT(mun,' ',dpto);
	RETURN _result;
END$$

DROP FUNCTION IF EXISTS `fn_niveles_ens`$$
CREATE DEFINER=CURRENT_USER() FUNCTION `fn_niveles_ens` (`_id_inst` INT(30), `_cod_grado` INT(11)) RETURNS VARCHAR(250) CHARSET utf8 NO SQL
BEGIN
DECLARE _result varchar(250) DEFAULT '';
	SELECT tn.nombre_nivel INTO _result FROM niveles_estudio AS tn 
	LEFT JOIN grados AS tg ON tg.id_nivel = tn.id 
	WHERE tg.id = _cod_grado LIMIT 1;
	RETURN CONCAT(_result);
END$$

DROP FUNCTION IF EXISTS `fn_porciento_asignatura`$$
CREATE DEFINER=CURRENT_USER() FUNCTION `fn_porciento_asignatura` (`_id_asig` INT(11), `_año` YEAR, `_cod_grado` INT(11)) RETURNS DOUBLE READS SQL DATA
BEGIN
 DECLARE result DECIMAL(6,2) DEFAULT 0;
 SELECT porciento INTO result FROM matcurso WHERE id_asig=_id_asig AND id_grado=_cod_grado AND año=_año LIMIT 1;
RETURN result;
END$$

DROP FUNCTION IF EXISTS `fn_recuperacion_notas`$$
CREATE DEFINER=CURRENT_USER() FUNCTION `fn_recuperacion_notas` (`_id_matric` INT(20), `_id_curso` INT(11)) RETURNS DOUBLE READS SQL DATA
BEGIN
	DECLARE result DECIMAL(6,2) DEFAULT 0.0;

	SELECT notarecuperada INTO result FROM respeciales 
 	WHERE id_matric=_id_matric AND id_curso= _id_curso LIMIT 1; 
 
RETURN result;
END$$

DROP FUNCTION IF EXISTS `fn_recuperacion_total_areas`$$
CREATE DEFINER=CURRENT_USER() FUNCTION `fn_recuperacion_total_areas` (`_id_matric` INT(30)) RETURNS INT(11) READS SQL DATA
BEGIN
 	DECLARE result, x INT DEFAULT 0;

	SELECT COUNT(id_matric) AS total, 
	ROW_NUMBER() OVER (PARTITION BY t.id_matric ORDER BY ta.id_pk DESC) AS row_num
	INTO x, result	FROM respeciales AS t
	LEFT JOIN cursos AS tc ON t.id_curso = tc.id 
	LEFT JOIN asignaturas AS ta ON tc.id_asig = ta.id_pk
	WHERE id_matric=_id_matric GROUP BY t.id_matric, ta.id_area  LIMIT 1;
	 
RETURN result;
END$$

DROP FUNCTION IF EXISTS `fn_recuperacion_total_asignaturas`$$
CREATE DEFINER=CURRENT_USER() FUNCTION `fn_recuperacion_total_asignaturas` (`_id_matric` INT(20)) RETURNS INT(11) READS SQL DATA
BEGIN
 DECLARE result INT DEFAULT 0;
 
 SELECT COUNT(*) INTO result FROM respeciales WHERE id_matric = _id_matric;
	
RETURN result;
END$$

DROP FUNCTION IF EXISTS `fn_return_table_logros_indicadores`$$
CREATE DEFINER=CURRENT_USER() FUNCTION `fn_return_table_logros_indicadores` (`_grado` INT(11)) RETURNS VARCHAR(30) CHARSET utf8 READS SQL DATA
BEGIN
DECLARE result VARCHAR(30) DEFAULT '';
	CASE 
		WHEN _grado BETWEEN 1 AND 4 THEN 
			SET result = 'log_nscp00';
		WHEN _grado BETWEEN 5 AND 9 THEN 
			SET result = 'log_nscp001';
		WHEN _grado BETWEEN 10 AND 13 THEN 
			SET result = 'log_nscp002';
		ELSE
			SET result = 'log_nscp003';
	END CASE;
RETURN result;
END$$

DROP FUNCTION IF EXISTS `fn_return_table_notas`$$
CREATE DEFINER=CURRENT_USER() FUNCTION `fn_return_table_notas` (`_grado` INT(11)) RETURNS VARCHAR(30) CHARSET utf8 READS SQL DATA
BEGIN
DECLARE result VARCHAR(30) DEFAULT '';
	CASE 
		WHEN _grado BETWEEN 1 AND 4 THEN 
			SET result = 'nscp00';
		WHEN _grado BETWEEN 5 AND 9 THEN 
			SET result = 'nscp001';
		WHEN _grado BETWEEN 10 AND 13 THEN 
			SET result = 'nscp002';
		ELSE
			SET result = 'nscp003';
	END CASE;
RETURN result;
END$$

DROP FUNCTION IF EXISTS `fn_return_table_notas_promedios`$$
CREATE DEFINER=CURRENT_USER() FUNCTION `fn_return_table_notas_promedios` (`_grado` INT(11)) RETURNS VARCHAR(30) CHARSET utf8 READS SQL DATA
BEGIN
DECLARE result VARCHAR(30) DEFAULT '';
	CASE 
		WHEN _grado BETWEEN 1 AND 4 THEN 
			SET result = 'nscp00_promedio_notas';
		WHEN _grado BETWEEN 5 AND 9 THEN 
			SET result = 'nscp001_promedio_notas';
		WHEN _grado BETWEEN 10 AND 13 THEN 
			SET result = 'nscp002_promedio_notas';
		ELSE
			SET result = 'nscp003_promedio_notas';
	END CASE;
RETURN result;
END$$

DROP FUNCTION IF EXISTS `fn_return_table_preinforme`$$
CREATE DEFINER=CURRENT_USER() FUNCTION `fn_return_table_preinforme` (`_grado` INT(11)) RETURNS VARCHAR(60) CHARSET utf8 READS SQL DATA
BEGIN
DECLARE result VARCHAR(60) DEFAULT '';
	CASE 
		WHEN _grado BETWEEN 1 AND 4 THEN 
			SET result = 'preinforme_nscp00';
		WHEN _grado BETWEEN 5 AND 9 THEN 
			SET result = 'preinforme_nscp001';
		WHEN _grado BETWEEN 10 AND 13 THEN 
			SET result = 'preinforme_nscp002';
		ELSE
			SET result = 'preinforme_nscp003';
	END CASE;
RETURN result;
END$$

DROP FUNCTION IF EXISTS `fn_return_table_sug`$$
CREATE DEFINER=CURRENT_USER() FUNCTION `fn_return_table_sug` (`_grado` INT(11)) RETURNS VARCHAR(30) CHARSET utf8 READS SQL DATA
BEGIN
DECLARE result VARCHAR(30) DEFAULT '';
	CASE 
		WHEN _grado BETWEEN 1 AND 4 THEN 
			SET result = 'sug_nscp00';
		WHEN _grado BETWEEN 5 AND 9 THEN 
			SET result = 'sug_nscp001';
		WHEN _grado BETWEEN 10 AND 13 THEN 
			SET result = 'sug_nscp002';
		ELSE
			SET result = 'sug_nscp003';
	END CASE;
RETURN result;
END$$

DROP FUNCTION IF EXISTS `fn_set_notas_resp_ciclos`$$
CREATE DEFINER=CURRENT_USER() FUNCTION `fn_set_notas_resp_ciclos` (`_id_inst` INT(20), `_id_sede` INT(20), `_id_docente` INT(20), `_cod_grado` VARCHAR(2), `_grupo` VARCHAR(2), `_id_asig` INT(3), `_año` YEAR, `_x_nro_acta` INT(6)) RETURNS INT(1) NO SQL
BEGIN

RETURN 1;
END$$

DELIMITER ;

DELIMITER $$
DROP EVENT IF EXISTS `ev_kill_sleep_connections`$$
CREATE DEFINER=CURRENT_USER() EVENT `ev_kill_sleep_connections` ON SCHEDULE EVERY 10 SECOND STARTS '2016-05-20 14:46:57' ENDS '2025-05-20 16:43:54' ON COMPLETION PRESERVE ENABLE DO BEGIN
	CALL sp_kill_sleeping_connections();
END$$

DELIMITER ;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

ALTER TABLE `columnas_notas_competencias`
	ADD COLUMN `modificable` INT(1) NOT NULL DEFAULT '0' AFTER `tipo`;