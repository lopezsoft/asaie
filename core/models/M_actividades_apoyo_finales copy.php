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
	public function get_acta($id_docente,$type){
		$db         = $this->get_db_name();
		if ($type == 0){
			$get_c	= "SELECT porcentaje_areas, promocion, t_año_lectivo, areas_pierde 
						FROM ".$db.".config001 AS t
						LEFT JOIN ".$db.".grados_agrupados AS t1 ON t.id_grupo_grados = t1.id
						LEFT JOIN ".$db.".aux_grados_agrupados AS t2 ON t2.id_grado_agrupado = t1.id ".
					  " WHERE t.year=".$this->get_year()." AND t2.id_grado = 5 LIMIT 1";
			$get_c	= $this->db->query($get_c);
			if ($get_c->num_rows() > 0){
				$this->porcentaje_areas = $get_c->row('porcentaje_areas');
				$this->areas_pierde		= $get_c->row('areas_pierde');
				$this->promocion 		= $get_c->row('promocion');
				$this->t_año_lectivo	= $get_c->row('t_año_lectivo');
			}
			$sql	= "SELECT t.nro_acta FROM ".$db.".respeciales AS t 
					  LEFT JOIN ".$db.".student_enrollment AS tm ON t.id_matric = tm.id 
					  LEFT JOIN ".$db.".cursos AS tc ON t.id_curso = tc.id ".
					  "WHERE tc.id_docente = ".$id_docente." AND tc.id_grado NOT BETWEEN 18 AND 23 ".
					  "AND tc.year=".$this->get_year()." LIMIT 1";
			$sql	= $this->db->query($sql);
			if($sql->num_rows() > 0){
				$this->gen_acta($id_docente,$sql->row('nro_acta'),$type);
			}else{
				$sql  = "SELECT t.nro_acta FROM ".$db.".respeciales AS t ".
					  "LEFT JOIN ".$db.".student_enrollment AS tm ON t.id_matric = tm.id 
					   LEFT JOIN ".$db.".cursos AS tc ON t.id_curso = tc.id ".
					  "WHERE tc.id_grado NOT BETWEEN 18 AND 23 ".
					  "AND tc.year=".$this->get_year()." LIMIT 1";
				$sql	= $this->db->query($sql);
				if ($sql->num_rows() > 0){
					$nro	= $sql->row('nro_acta') + 1;
				}else{
					$nro	= 1;
				}
				$this->gen_acta($id_docente,$nro,$type);
			}
		}else{
			$get_c	= "SELECT porcentaje_areas, promocion, t_año_lectivo, areas_pierde 
						FROM ".$db.".config001 AS t
						LEFT JOIN ".$db.".grados_agrupados AS t1 ON t.id_grupo_grados = t1.id
						LEFT JOIN ".$db.".aux_grados_agrupados AS t2 ON t2.id_grado_agrupado = t1.id ".
					  " WHERE t.year=".$this->get_year()." AND t2.id_grado = 24 LIMIT 1";
			$get_c	= $this->db->query($get_c);
			if ($get_c->num_rows() > 0){
				$this->porcentaje_areas = $get_c->row('porcentaje_areas');
				$this->areas_pierde		= $get_c->row('areas_pierde');
				$this->promocion 		= $get_c->row('promocion');
				$this->t_año_lectivo	= $get_c->row('t_año_lectivo');
			}
			$sql	= "SELECT t.nro_acta FROM ".$db.".respeciales AS t 
					  LEFT JOIN ".$db.".student_enrollment AS tm ON t.id_matric = tm.id 
					  LEFT JOIN ".$db.".cursos AS tc ON t.id_curso = tc.id ".
					  "WHERE tc.id_docente = ".$id_docente." AND tc.id_grado BETWEEN 18 AND 23 ".
					  "AND tc.year=".$this->get_year()." LIMIT 1";
			$sql	= $this->db->query($sql);
			if($sql->num_rows() > 0){
				$this->gen_acta($id_docente,$sql->row('nro_acta'),$type);
			}else{
				$sql  = "SELECT t.nro_acta FROM ".$db.".respeciales AS t ".
					  "LEFT JOIN ".$db.".student_enrollment AS tm ON t.id_matric = tm.id 
					   LEFT JOIN ".$db.".cursos AS tc ON t.id_curso = tc.id ".
					  "WHERE tc.id_grado BETWEEN 18 AND 23 ".
					  "AND tc.year=".$this->get_year()." LIMIT 1";
				$sql	= $this->db->query($sql);
				if ($sql->num_rows() > 0){
					$nro	= $sql->row('nro_acta') + 1;
				}else{
					$nro	= 1;
				}
				$this->gen_acta($id_docente,$nro,$type);
			}
		}
		return $this->get_request_ab();
	}
	
	public function gen_acta($doc,$nro_acta,$type){
		$db         = $this->get_db_name();
		if ($type == 0){
			$sql ="SELECT * FROM ".$db.".cursos 
				 WHERE estado=1 AND year=".$this->get_year()."	AND id_docente=".$doc." AND id_grado NOT BETWEEN 18 AND 23 
				 ORDER BY id_grado,grupo";
		}else{
			$sql ="SELECT * FROM ".$db.".cursos 
				 WHERE estado=1 AND year=".$this->get_year()."	AND id_docente=".$doc." AND id_grado BETWEEN 18 AND 23
				 ORDER BY id_grado,grupo";
		}		
		$sql	= $this->db->query($sql);
		if ($sql->num_rows() > 0){
			foreach($sql->result_array() as $row){
				$this->get_desempeños_rango($row['id_grado']);
				$this->last_periodo($row['id_grado']);
				$this->get_nota($row['id_sede'],$row['id_grado'],$row['grupo'],$row['id_asig'],$row['id_jorn'],$doc,$nro_acta,$row['id']);
			}
			
		}
	}
	
	public function get_nota($sede,$grado,$grupo,$asig,$jorn,$doc,$nro,$curso){
		$table	= $this->tabla_notas($grado);
		$db		= $this->get_db_name();
		$sql	= "SELECT id FROM ".$db.".student_enrollment WHERE id_state = 2 AND year=".$this->get_year().
				" AND id_grade =".$grado." AND id_group='".$grupo
				  ."' AND id_study_day=".$jorn." AND id_headquarters=".$sede;
		$sql	= $this->db->query($sql);
		if ($sql->num_rows() > 0){
			foreach($sql->result_array() as $row){
				$call	= "";
				$param	= "";
				if ($this->porcentaje_areas == 1){ // Si se está trabajando el año lectivo con porcentajes en las areas
					if ($this->t_año_lectivo == 1){ // Promocion por áreas					
						switch($this->promocion){
							case 1 : // Promocion por promedios
								$call	= "sp_prom_por_area_porcentaje";
								$param	= $this->get_year().",".$row['id'].
										  ",".$curso.",".$asig.",".$nro.",'".$grado."','".
										  $this->desde."','".$this->hasta."',".$this->areas_pierde;
								break;
							case 3 : // Quinta nota, Ultimo periodo
								$call	= "sp_prom_por_area_porcentaje_quinta";
								$param	= $this->get_year().",".$row['id'].
										  ",".$curso.",".$asig.",".$nro.",'".$grado."','".
										  $this->desde."','".$this->hasta."',".$this->areas_pierde.
										  ",'".$this->last_periodo."'";
								break;
						}
					}else{ // Promoción por asignaturas
						switch($this->promocion){
							case 1 : // Promocion por promedios
								$call	= "sp_prom_por_asignaturas";
								$param	= $this->get_year().",".$row['id'].
										  ",".$curso.",".$asig.",".$nro.",'".$grado."','".
										  $this->desde."','".$this->hasta."',".$this->areas_pierde;
								break;
							case 3 : // Quinta nota, Ultimo periodo
								$call	= "sp_prom_por_asignaturas_quinta";
								$param	= $this->get_year().",".$row['id.'].
										  ",".$curso.",".$asig.",".$nro.",'".$grado."','".
										  $this->desde."','".$this->hasta."',".$this->areas_pierde.
										  ",'".$this->last_periodo."'";
								break;
						}
					}
				}else{
					if ($this->t_año_lectivo == 1){ // Promocion por áreas
						switch($this->promocion){
							case 1 : // Promocion por promedios
								$call	= "sp_prom_por_area";
								$param	= $this->get_year().",".$row['id'].
										  ",".$curso.",".$asig.",".$nro.",'".$grado."','".
										  $this->desde."','".$this->hasta."',".$this->areas_pierde;
								break;
							case 3 : // Quinta nota, Ultimo periodo
								$call	= "sp_prom_por_area_quinta";
								$param	= $this->get_year().",".$row['id'].
										  ",".$curso.",".$asig.",".$nro.",'".$grado."','".
										  $this->desde."','".$this->hasta."',".$this->areas_pierde.
										  ",'".$this->last_periodo."'";
								break;
						}
					}else{ // Promoción por asignaturas
						switch($this->promocion){
							case 1 : // Promocion por promedios
								$call	= "sp_prom_por_asignaturas";
								$param	= $this->get_year().",".$row['id'].
										  ",".$curso.",".$asig.",".$nro.",'".$grado."','".
										  $this->desde."','".$this->hasta."',".$this->areas_pierde;
								break;
							case 3 : // Quinta nota, Ultimo periodo
								$call	= "sp_prom_por_asignaturas_quinta";
								$param	= $this->get_year().",".$row['id'].
										  ",".$curso.",".$asig.",".$nro.",'".$grado."','".
										  $this->desde."','".$this->hasta."',".$this->areas_pierde.
										  ",'".$this->last_periodo."'";
								break;
						}
					}
				}
				$this->get_call_execute($call,$param);
			}		
		}
	}	
}
