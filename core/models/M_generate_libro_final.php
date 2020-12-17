<?php
	defined('BASEPATH') OR exit('No direct script access allowed');
class M_generate_libro_final extends SME_Model {
	var
		$_n_per_div 	= 4,
		$_n_decimales	= 0,
		$_n_promocion	= 0,
		$_n_red			= 0,
		$_n_aplica		= 0,
		$_n_final_red	= 0;
	function __construct() {
		parent::__construct();
	}
	
	public function generate_sabanas($Grado,$Grupo,$Jorn,$Sede,$all){
		$id		= $this->get_id_school();
		$db		= $this->get_db_name();
		$ye		= $this->get_year();		
		if($all > 0){
			$query	= "SELECT id_group grupo, tm.id id_matric FROM ".$db.".student_enrollment tm
										LEFT JOIN ".$db.".inscripciones AS ti ON tm.id_student = ti.id 
										WHERE tm.id_headquarters = ".$Sede." AND tm.`year` = ".$ye."
										AND tm.id_grade = '".$Grado."' AND tm.id_study_day = ".$Jorn."
										AND tm.id_state = 2
										ORDER BY tm.id_grade,tm.id_group,tm.id";
		}else{
			$query	= "SELECT id_group grupo, tm.id id_matric FROM ".$db.".student_enrollment tm
									LEFT JOIN ".$db.".inscripciones AS ti ON tm.id_student = ti.id 
									WHERE tm.id_headquarters = ".$Sede." AND tm.`year` = ".$ye."
									AND tm.id_grade = '".$Grado."' AND tm.id_group = '".$Grupo."' AND tm.id_study_day = ".$Jorn."
									AND tm.id_state = 2
									ORDER BY tm.id_group, tm.id";
		}		
		$query		= $this->db->query($query);
		if ($query){
			if ($query->num_rows() > 0){
				$this->trans_start();
				foreach($query->result_array() as $row){			
					$this->sp_generate_sabanas($row['id_matric'],$Grado);
				}	
				$this->trans_complete();
				if ($this->trans_status()){
					$result	=$this->getJsonResponse([],0);
				}else{
					$this->getError();
				}
			}else{
				$result	= $this->getJsonResponse([],0);
			}
		}else{
			$result = $this->getError();
		}
		return $result;
	}
	
	public function sp_generar_libros($Grado,$Grupo,$Sede,$Jorn,$all,$per){
		$id		= $this->get_id_school();
		$db     = $this->get_db_name();
		$ye		= $this->get_year();
			
		$sql	= "SELECT t.Ndecimales,t.promocion,t.nota_redondeo,t.nota_final_redondeo, t.aplicar_redondeo_fin_año
					FROM ".$db.".config001 AS t
					LEFT JOIN ".$db.".grados_agrupados AS t1 ON t.id_grupo_grados = t1.id 
					LEFT JOIN ".$db.".aux_grados_agrupados AS t2 ON t2.id_grado_agrupado = t1.id  
					WHERE t.year = ".$this->get_year()." AND t2.id_grado = ".$Grado." LIMIT 1";
		$sql	= $this->db->query($sql);
		if ($sql->num_rows() > 0){
			$this->_n_decimales	= $sql->row('Ndecimales');
			$this->_n_promocion	= $sql->row('promocion');
			$this->_n_red		= $sql->row('nota_redondeo');
			$this->_n_final_red	= $sql->row('nota_final_redondeo');
			$this->_n_aplica	= $sql->row('aplicar_redondeo_fin_año');
		}
		
		switch($this->_n_promocion){
			case 3 : // Periodo final
				$query	= "SELECT periodo FROM ".$db.".periodos_academicos AS td
				LEFT JOIN ".$db.".grados_agrupados AS t1 ON td.id_grado_agrupado = t1.id
				LEFT JOIN ".$db.".aux_grados_agrupados AS t2 ON t2.id_grado_agrupado = t1.id
				WHERE td.`year` = ".$ye." AND t2.id_grado = ".$Grado." 
				ORDER BY td.periodo DESC LIMIT 1";
				$query	= $this->db->query($query);
				if($query->num_rows() > 0){
					$this->_n_per_div = $query->row('periodo');
				}
				break;			
			default:
				$query	= "SELECT COUNT(periodo) total FROM ".$db.".periodos_academicos AS td
				LEFT JOIN ".$db.".grados_agrupados AS t1 ON td.id_grado_agrupado = t1.id
				LEFT JOIN ".$db.".aux_grados_agrupados AS t2 ON t2.id_grado_agrupado = t1.id
				WHERE td.`year` = ".$ye." AND t2.id_grado = ".$Grado." 
				GROUP BY td.id_grado_agrupado";
				$query	= $this->db->query($query);
				if($query->num_rows() > 0){
					$this->_n_per_div = $query->row('total');
				}
				break;
		}
			
		if($all > 0){
			$query	= "SELECT id_group grupo, tm.id id_matric FROM ".$db.".student_enrollment tm
						LEFT JOIN ".$db.".inscripciones AS ti ON tm.id_student = ti.id 
						WHERE tm.id_headquarters = ".$Sede." AND tm.`year` = ".$ye."
						AND tm.id_grade = '".$Grado."' AND tm.id_study_day = ".$Jorn."
						AND tm.id_state = 2
						ORDER BY tm.id_grade,tm.id_group,tm.id";
		}else{
			$query	= "SELECT id_group grupo, tm.id id_matric FROM ".$db.".student_enrollment tm
						LEFT JOIN ".$db.".inscripciones AS ti ON tm.id_student = ti.id 
						WHERE tm.id_headquarters = ".$Sede." AND tm.`year` = ".$ye."
						AND tm.id_grade = '".$Grado."' AND tm.id_group = '".$Grupo."' AND tm.id_study_day = ".$Jorn."
						AND tm.id_state = 2
						ORDER BY id_group,tm.id";
		}
		
		$query		= $this->db->query($query);
		if ($query){
			if ($query->num_rows() > 0){
				$this->trans_start();
				foreach($query->result_array() as $row){
					$this->sp_genenerar_libro_final($id,$Sede,$Grado,$row['grupo'],$ye,$row['id_matric'],$Jorn);		
					$this->sp_update_areasf($row['id_matric'],$per,$Grado);
					$this->sp_generate_sabanas($row['id_matric'],$Grado);
				}	
				$this->trans_complete();
				if ($this->trans_status()){
					$result	=$this->getJsonResponse([],0);
				}else{
					$this->getError();
				}
			}else{
				$result	= $this->getJsonResponse([],0);
			}
		}else{
			$result = $this->getError();
		}
		return $result;
	}	
	
	public function sp_generate_sabanas($id_matric,$grado){
		$param	= array( 
			$this->get_year(),
			$id_matric,
			$grado
		);
		$this->getExecute('sp_generate_sabanas( ?, ?, ? )',$param,false, false);
	}
	
	public function sp_update_areasf($id_matric,$per,$grado){
		$db         = $this->get_db_name();
		$n_matric = 0;$_t_año_lectivo = 1;
		$sql = "SELECT id_matric FROM ".$db.".acta_promocion WHERE id_matric = ".$id_matric." limit 1";
		$sql = $this->db->query($sql);
		if ($sql->num_rows() > 0){
			$n_matric = $sql->row('id_matric');
		}
		$sql = "SELECT t_año_lectivo FROM ".$db.".config001 AS t 
			LEFT JOIN ".$db.".grados_agrupados AS t1 ON t.id_grupo_grados = t1.id 
			LEFT JOIN ".$db.".aux_grados_agrupados AS t2 ON t2.id_grado_agrupado = t1.id
			WHERE t.year=".$this->get_year()." AND t2.id_grado = ".$grado." LIMIT 1";
		$sql = $this->db->query($sql);
		if ($sql->num_rows() > 0){
			$_t_año_lectivo = $sql->row('t_año_lectivo');
		}
		$query	= "";
		if ($n_matric == 0){
			$query = "INSERT INTO ".$db.".acta_promocion (id_matric,promedio,promedio_rec) ".
					 "SELECT id_matric,ROUND(AVG(final),2), ROUND(AVG(IF(final > recuperacion,final,recuperacion)),2) ".
					 "FROM ".$db.".areasf WHERE id_matric=".$id_matric." GROUP BY id_matric";
		}else{
			$sql = "SELECT ROUND(AVG(final),2) final, ROUND(AVG(IF(final > recuperacion,final,recuperacion)),2) ".
			"final_r FROM ".$db.".areasf WHERE id_matric=".$id_matric." GROUP BY id_matric";
			$sql = $this->db->query($sql);
			if ($sql->num_rows() > 0){
				$_prom	= $sql->row('final');
				$_prom_rec = $sql->row('final_r');
				$query = "UPDATE ".$db.".acta_promocion SET promedio = ".$_prom
				.",promedio_rec = ".$_prom_rec." WHERE id_matric =".$n_matric;	
			}
		}	
		if(!empty($query)){
			$this->db->query($query);
		}		
		if ($_t_año_lectivo == 1){
			/* year lectivo por areas */
			$param	= array( 
				$id_matric,
				$this->get_year()
			);
			$this->getExecute('sp_libro_final_areas( ?, ? )',$param,false,false);
		}else{
			/* year Lectivo por asignaturas*/
			$param	= array(
				$id_matric,
				$this->get_year()
			);
			$this->getExecute('sp_libro_final_asignaturas( ?, ? )',$param,false, false);
		}
	}
	
	public function sp_genenerar_libro_final($_id_inst,$_id_sede,$_grado,$_grupo,$_year,$_id_matric,$_jorn){
		$db     = $this->get_db_name();
		$table	= $db.".".$this->tabla_notas($_grado);
		switch($this->_n_promocion){
			case 3 : // Quinto periodo
				$qc	= "DELETE FROM ".$db.".areasf WHERE id_matric = ".$_id_matric;
				$qc	= $this->db->query($qc);
				$query	= "SELECT tn.id_curso,
				ROUND(IF(tn.nota_habilitacion > 0,tn.nota_habilitacion,tn.final),".$this->_n_decimales.")
				AS final,tn.faltas, tn.injustificadas, tn.retraso
				FROM ".$table." as tn 
				LEFT JOIN ".$db.".cursos AS tc ON (tn.id_curso=tc.id AND tn.year=tc.year)
				LEFT JOIN ".$db.".student_enrollment AS tm ON tn.id_matric = tm.id 
				WHERE tc.estado = 1 AND tc.year=".$_year." AND tc.id_grado=".$_grado." AND tc.grupo='".$_grupo.
				"' AND tc.id_sede=".$_id_sede." AND tc.id_jorn=".$_jorn.
				" AND tn.periodo = '".$this->_n_per_div."' AND tm.year = ".$_year.
				" AND tm.id_state = 2 AND tm.id = ".$_id_matric.
				" ORDER BY tm.id_group,tn.id_matric,tc.id_asig;";
				$query	= $this->db->query($query);
				if ($query->num_rows() > 0 ){
					$cSQLInsert	= "";$cSQLUpdate = "";$SQLFaltas = "";$SQLRetraso = ""; $SQLInjus = "";
					$SQLP1	= "";$SQLP2	= "";$SQLP3	= "";$SQLP4	= "";
					$SQLInA	= ""; $SQLInM = "";$SQLFinal = "";	
					$final	= 0;
					foreach($query->result_array() as $row){
						$_p1 = 0; $_p2 = 0; $_p3 = 0; $_p4 = 0; $_count = 0;
						$inj = 0; $just = 0; $ret = 0;
						$q	= "SELECT IF(nota_habilitacion > 0, nota_habilitacion, final) nt, periodo, faltas, 
							injustificadas, retraso FROM ".$table." 
							WHERE id_curso =".$row['id_curso']." AND id_matric =".$_id_matric.
							" AND periodo BETWEEN 1 AND ".$this->_n_per_div;
						$q	= $this->db->query($q);						
						if($q->num_rows() > 0){
							foreach($q->result_array() as $key){
								$inj  = $inj  + $key['injustificadas'];
								$just = $just + $key['faltas'];
								$ret  = $ret  + $key['retraso'];
								switch($key['periodo']){
									case '1':
										$_p1 = $key['nt'];
										break;
									case '2':
										$_p2 = $key['nt'];
										break;
									case '3':
										$_p3 = $key['nt'];
										break;
									case '4':
										$_p4 = $key['nt'];
										break;									
								}
							}							
						}			
						$final	= 	$row['final'];
						if($this->_n_red > 0 AND $this->_n_aplica > 0){
							$selec	= "SELECT t.hasta FROM ".$db.".desempeños t 
									LEFT JOIN {$db}.grados_agrupados AS t1 ON t.id_grado_agrupado = t1.id
									LEFT JOIN {$db}.aux_grados_agrupados AS t2 ON t2.id_grado_agrupado = t1.id
									WHERE t.year = ".$_year." AND t.reprueba = 1 
									AND t2.id_grado = ".$_grado." LIMIT 1";
							$selec	= $this->db->query($selec);
							if ($selec->num_rows() > 0){
								if($final >= $this->_n_red AND $final<= $selec->row('hasta')){
									$final = $this->_n_final_red;
								}
							}
						}										
						$cSQLInsert = $cSQLInsert.
						"(".$_id_matric.",".$row['id_curso'].",'".$final.
						"','".$just."','".$inj."','".$ret.
						"','".$_p1."','".$_p2."','".$_p3."','".$_p4."'),";											
					}					
				}				
				if (!empty($cSQLInsert)){
					 $query = "INSERT INTO ".$db.".areasf (id_matric,id_curso,final,faltas,injustificadas,retraso,p1,p2,p3,p4)".
							" VALUES ".substr($cSQLInsert,0,strlen($cSQLInsert)-1);
					$this->db->query($query);
				}
				break;			
			case 4 : // Cuarto periodo
				
				break;
			default:
				$qc	= "DELETE FROM ".$db.".areasf WHERE id_matric = ".$_id_matric;
				$qc	= $this->db->query($qc);
				$query	= "SELECT tn.id_curso,tc.id_asig,
				ROUND(SUM(IF(tn.nota_habilitacion > 0,tn.nota_habilitacion,tn.final))/"
				.$this->_n_per_div.",".$this->_n_decimales.")
				AS final,SUM(tn.faltas) AS faltas, SUM(tn.injustificadas) AS injustificadas, SUM(tn.retraso) AS retraso
				FROM ".$table." as tn 
				LEFT JOIN ".$db.".cursos AS tc ON (tn.id_curso=tc.id AND tn.year=tc.year)
				LEFT JOIN ".$db.".student_enrollment AS tm ON tn.id_matric = tm.id 
				WHERE tc.year=".$_year." AND tc.id_grado=".$_grado." AND tc.grupo='".$_grupo.
				"' AND tc.id_sede=".$_id_sede." AND tc.id_jorn=".$_jorn.
				" AND tm.year = ".$_year." AND tm.id = ".$_id_matric."
				GROUP BY tn.id_matric,tc.id_asig,tm.id_grade,tm.id_group,tm.`year` 
				ORDER BY tm.id_group,tn.id_matric,tc.id_asig;";
				$query	= $this->db->query($query);
				if ($query->num_rows() > 0 ){
					$cSQLInsert	= "";$cSQLUpdate = "";$SQLFaltas = "";$SQLRetraso = ""; $SQLInjus = "";
					$SQLP1	= "";$SQLP2	= "";$SQLP3	= "";$SQLP4	= "";
					$SQLInA	= ""; $SQLInM = "";$SQLFinal = "";	
					$final	= 0;
					foreach($query->result_array() as $row){
						$_p1 = 0; $_p2 = 0; $_p3 = 0; $_p4 = 0; $_count = 0;
						$q	= "SELECT IF(nota_habilitacion > 0, nota_habilitacion, final) nt, periodo FROM ".$table." 
							AS tn LEFT JOIN ".$db.".cursos AS tc ON (tn.id_curso=tc.id AND tn.year=tc.year)
							WHERE tc.id_asig=".$row['id_asig']." AND id_matric =".$_id_matric.
							" AND periodo BETWEEN 1 AND ".$this->_n_per_div;
						$q	= $this->db->query($q);						
						if($q->num_rows() > 0){
							foreach($q->result_array() as $key){
								switch($key['periodo']){
									case '1':
										$_p1 = $key['nt'];
										break;
									case '2':
										$_p2 = $key['nt'];
										break;
									case '3':
										$_p3 = $key['nt'];
										break;
									case '4':
										$_p4 = $key['nt'];
										break;									
								}
							}							
						}			
						$final	= 	$row['final'];	
						$curso	= $this->curso_activo($row['id_curso']);
						if($this->_n_red > 0 AND $this->_n_aplica > 0){
							$selec	= "SELECT t.hasta FROM ".$db.".desempeños t 
									LEFT JOIN ".$db.".grados_agrupados AS t1 ON t.id_grado_agrupado = t1.id
									LEFT JOIN ".$db.".aux_grados_agrupados AS t2 ON t2.id_grado_agrupado = t1.id
									WHERE t.year = ".$_year." AND t.reprueba = 1 
									AND t2.id_grado = ".$_grado." LIMIT 1";
							$selec	= $this->db->query($selec);
							if ($selec->num_rows() > 0){
								if($final >= $this->_n_red AND $final<= $selec->row('hasra')){
									$final = $this->_n_final_red;
								}
							}
						}									
						$cSQLInsert = $cSQLInsert.
						"(".$_id_matric.",".$curso.",'".$final.
						"','".$row['faltas']."','".$row['injustificadas']."','".$row['retraso'].
						"','".$_p1."','".$_p2."','".$_p3."','".$_p4."'),";											
					}					
				}				
				if (!empty($cSQLInsert)){
					 $query = "INSERT INTO ".$db.".areasf (id_matric,id_curso,final,faltas,injustificadas,retraso,p1,p2,p3,p4)".
							" VALUES ".substr($cSQLInsert,0,strlen($cSQLInsert)-1);
					$this->db->query($query);
				}				
				break;
		}	
	}	
	
	function curso_activo($curso){
		$db         = $this->get_db_name();
		$sql = "SELECT * FROM ".$db.".cursos WHERE id =".$curso." LIMIT 1";
		$sql = $this->db->query($sql);
		$result	= $curso;
		if($sql->num_rows()>0){
			if ($sql->row('estado') == 0){
				$qry	= "SELECT id FROM {$db}.cursos WHERE id_sede=".$sql->row('id_sede')." AND id_grado=".
						  $sql->row('id_grado')." AND id_asig=".$sql->row('id_asig').
						  " AND id_jorn=".$sql->row('id_jorn')." AND grupo='".$sql->row('grupo').
						  "' AND year=".$sql->row('year')." AND estado = 1 LIMIT 1";
				$qry	= $this->db->query($qry);
				if ($qry->num_rows() > 0){
					$result	= $qry->row('id');
				}
			}
		}
		return $result;
	}
	
}
