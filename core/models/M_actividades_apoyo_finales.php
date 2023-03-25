<?php
	defined('BASEPATH') OR exit('No direct script access allowed');

class M_actividades_apoyo_finales extends SME_Model {
	var
		$porcentaje_areas,
		$promocion,
		$ar_ciclos,
		$t_año_lectivo,
		$areas_pierde;
	function __construct() {
		parent::__construct();
		$this->porcentaje_areas = 0;
		$this->promocion 	= 0;
		$this->ar_ciclos	= 0;
		$this->areas_pierde	= 0;
		$this->t_año_lectivo= 0;
	}	
	public function get_acta($id_docente, $type){
		$db         = $this->get_db_name();
		$gradeId	= 5;
		$between	= " NOT BETWEEN 18 AND 23 ";
		if ($type <> 0){
			$gradeId	= 24;
			$between	= " BETWEEN 18 AND 23 ";
		}

		$queryConfig = "SELECT * FROM ".$db.".config001 AS t
					LEFT JOIN ".$db.".grados_agrupados AS t1 ON t.id_grupo_grados = t1.id
					LEFT JOIN ".$db.".aux_grados_agrupados AS t2 ON t2.id_grado_agrupado = t1.id ".
				  " WHERE t.year=".$this->get_year()." AND t2.id_grado = ".$gradeId." LIMIT 1";
		$queryConfig	= $this->db->query($queryConfig);

		$querySpecials	= "SELECT t.nro_acta FROM ".$db.".respeciales AS t 
							LEFT JOIN ".$db.".student_enrollment AS tm ON t.id_matric = tm.id 
							LEFT JOIN ".$db.".cursos AS tc ON t.id_curso = tc.id ".
							"WHERE tc.id_docente = ".$id_docente." AND tc.id_grado ".$between.
							"AND tc.year=".$this->get_year()." LIMIT 1";
		$querySpecials	= $this->db->query($querySpecials);
		if($querySpecials->num_rows() > 0){
			$nroActa	= $querySpecials->row('nro_acta');
		}else{
			$sql  = "SELECT t.nro_acta FROM ".$db.".respeciales AS t ".
				  "LEFT JOIN ".$db.".student_enrollment AS tm ON t.id_matric = tm.id 
				  LEFT JOIN ".$db.".cursos AS tc ON t.id_curso = tc.id ".
				  "WHERE tc.id_grado ".$between." AND tc.year=".$this->get_year()." LIMIT 1";
				  $sql	= $this->db->query($sql);
				  if ($sql->num_rows() > 0){
					  $nroActa		= $sql->row('nro_acta') + 1;
					}else{
						$nroActa	= 1;
					}
		}

		$queryCourses ="SELECT * FROM ".$db.".cursos WHERE estado=1 AND year=".
				$this->get_year()."	AND id_docente=".$id_docente." AND id_grado ".$between. 
				"ORDER BY id_grado,grupo";
		
		$queryCourses	= $this->db->query($queryCourses);

		if ($queryCourses->num_rows() > 0){
			foreach($queryCourses->result_array() as $row){
				$this->get_desempeños_rango($row['id_grado']);
				$this->last_periodo($row['id_grado']);
				$this->get_nota($row ,$nroActa,$row['id'], $queryConfig);
			}
			
		}
		return $this->get_request_ab();
	}
	
	public function get_nota($row, $nro, $curso, $queryConfig){
		$sede 	= $row['id_sede'];
		$grado	= $row['id_grado'];
		$grupo	= $row['grupo'];
		$asigId	= $row['id_asig'];
		$jorn	= $row['id_jorn'];
		$year	= $this->get_year();
		$desde	= $this->desde;
		$hasta	= $this->hasta;
		$config	= $queryConfig->row();

		$table	= $this->tabla_notas($grado);
		$db		= $this->get_db_name();
		$sql	= "SELECT id FROM ".$db.".student_enrollment WHERE id_state = 2 AND year=".$year.
				" AND id_grade=".$grado." AND id_group='".$grupo
				  ."' AND id_study_day=".$jorn." AND id_headquarters=".$sede;
		$sql	= $this->db->query($sql);
		if ($sql->num_rows() > 0){
			$where		= " ";
			$extraName	= "";
			
			if ($queryConfig->row('promocion') == 3) {
				$where	= " AND a.periodo ='".$this->last_periodo."' ";
				$extraName	= "_periodos";
			}

			foreach($sql->result_array() as $enrollment){
				if (intval($queryConfig->row('porcentaje_areas')) == 1){ // Si se está trabajando el año lectivo con porcentajes en las areas

					$queryNotes	= "SELECT a.id_matric, a.id_area, SUM(a.final) AS final
					FROM ".$db.".".$table."_view_porcentaje_areas".$extraName." AS a
					WHERE a.id_matric = ".$enrollment['id']." AND a.id_grado = ".$grado.
					" AND a.`year` = ".$year.$where."
					GROUP BY a.id_matric, a.id_area
					HAVING final BETWEEN ".$desde." AND ".$hasta."
					ORDER BY a.id_area";
					
					$queryNotes	= $this->db->query($queryNotes);
					$totalAreas	= $queryNotes->num_rows();
					if($totalAreas > 0 && ($totalAreas < $config->areas_pierde)) {
						foreach ($queryNotes->result_array() as $area){

							$queryAsign	= "SELECT a.id_matric, a.id_asig, a.id_area, a.final ".
								"FROM ".$db.".".$table."_view_porcentaje_areas".$extraName." AS a ".
								"WHERE a.id_matric = ".$area['id_matric']." AND a.prom BETWEEN ".$desde." AND ".$hasta."
								AND a.id_area = ".$area['id_area']." AND a.id_asig = ".$asigId;
							$queryAsign	= $this->db->query($queryAsign);
							
							foreach ($queryAsign->result_object() as $asig) {
								$final = $asig->final;
								if($config->nota_redondeo > 0 && $config->aplicar_redondeo_fin_año > 0 && ( $final === $config->nota_final_redondeo) ) {
									continue;
								}
								$call	= "sp_insert_respeciales";
								$params	= $area['id_matric'].",".$nro.",".$curso.",'".$final."'";
								$this->get_call_execute($call,$params);
							}
						}
					}
				}else{
					$queryNotes	= "SELECT a.id_matric, a.id_area, AVG(a.final) AS final
					FROM ".$db.".".$table."_view_prom_por_area".$extraName." AS a
					WHERE a.id_matric = ".$enrollment['id']." AND a.id_grado = ".$grado.
					" AND a.`year` = ".$year.$where."
					GROUP BY a.id_matric, a.id_area
					HAVING final BETWEEN ".$desde." AND ".$hasta."
					ORDER BY a.id_area";
					
					$queryNotes	= $this->db->query($queryNotes);
					$totalAreas	= $queryNotes->num_rows();
					if($totalAreas > 0 && ($totalAreas < $config->areas_pierde)) {
						foreach ($queryNotes->result_array() as $area){

							$queryAsign	= "SELECT a.id_matric, a.id_asig, a.id_area, a.final ".
								"FROM ".$db.".".$table."_view_prom_por_area".$extraName." AS a ".
								"WHERE a.id_matric = ".$area['id_matric']." AND a.prom BETWEEN ".$desde." AND ".$hasta."
								AND a.id_area = ".$area['id_area']." AND a.id_asig = ".$asigId;
							$queryAsign	= $this->db->query($queryAsign);
							
							foreach ($queryAsign->result_object() as $asig) {
								$final = $asig->final;
								if($config->nota_redondeo > 0 && $config->aplicar_redondeo_fin_año > 0 && ( $final === $config->nota_final_redondeo) ) {
									continue;
								}
								$call	= "sp_insert_respeciales";
								$params	= $area['id_matric'].",".$nro.",".$curso.",'".$final."'";
								$this->get_call_execute($call,$params);
							}
						}
					}
				}
				
			}		
		}
	}	
}
