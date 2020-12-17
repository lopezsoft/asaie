<?php 
defined('BASEPATH') OR exit('No direct script access allowed');
class Formatos_m extends SME_Model {
	function __construct() {
		parent::__construct();
	}
	
	function getformato01($grado, $grupo, $jorn, $sede){
		$docente	= $this->get_parent();
		$year		= $this->get_year();
		$db     	= $this->get_db_name();
		$query	= "INSERT INTO {$db}.mom_formato_evaluacion (enrollment_id, teacher_id, periodo) 
		SELECT a.id, {$docente}, 1 FROM {$db}.student_enrollment a 
		WHERE a.year = {$year} AND a.id_grade = {$grado} AND a.id_study_day = {$jorn} 
		AND a.id_group = '{$grupo}' AND a.id_headquarters = {$sede} AND 
		NOT EXISTS ( 
			SELECT b.id FROM {$db}.mom_formato_evaluacion b 
			WHERE b.enrollment_id AND b.teacher_id = {$docente}
		);";

		$this->db->query($query);

		$query	= "SELECT b.*, 
		CONCAT(TRIM(d.apellido1),' ',TRIM(d.apellido2),' ',TRIM(d.nombre1),' ',TRIM(d.nombre2)) AS nombres,
		c.id_headquarters, c.id_grade, c.id_group, c.id_study_day, tg.grado, tj.jornada
		FROM {$db}.mom_formato_evaluacion b 
		LEFT JOIN {$db}.student_enrollment AS c ON b.enrollment_id = c.id
		LEFT JOIN {$db}.inscripciones AS d ON c.id_student = d.id
		LEFT JOIN {$db}.grados AS tg ON c.id_grade = tg.id 
		LEFT JOIN {$db}.jornadas AS tj ON c.id_study_day = tj.cod_jorn
		WHERE c.id_headquarters = {$sede} AND c.id_study_day = {$jorn} AND c.id_grade = {$grado}
		AND c.id_group= '{$grupo}' AND c.year = {$year} AND b.enrollment_id = c.id 
		ORDER BY nombres";

		$query = $this->db->query($query);

		echo $this->getJsonResponse($query->result(), $query->num_rows());

	}
}

