<?php
defined('BASEPATH') OR exit('No direct script access allowed');
 class M_consolidados extends SME_Model	{
 	var
 	   	$matcurso = NULL;
 	var	$aa1,$aa2,$aa3,$aa4,$aa5,$aa6,$aa7,$aa8,$aa9,$aa10,$aa11,
		$aa12,$aa13,$aa14,$aa15,$aa16,$aa17,$aa18,$aa19,$aa20,
		$aa21,$aa22,$aa23,$aa24,$aa25,$x_count_matcurso,
		$x_cant_asig_perdidas = 0;
	var
		$_n_per_div 	= 4,
		$_n_decimales	= 0,
		$_n_promocion	= 0,
		$_n_red			= 0,
		$_n_aplica		= 0,
		$_n_final_red	= 0;
 	function __construct() {
 		parent::__construct();
 		$this->load->model('M_jreport');
 	}	
 	public function generar_consolidados($per,$type,$c_gdo,$gpo,$jorn, $perAll, $groupA,$sede){
		$db		= $this->get_db_name();	
		$year	= $this->get_year();

		$this->db->select('t.Ndecimales,t.promocion,t.nota_redondeo,t.nota_final_redondeo, t.aplicar_redondeo_fin_año');
		$this->db->from($db.'.config001 AS t');
		$this->db->join($db.'.grados_agrupados AS t1', 't.id_grupo_grados = t1.id', 'left');
		$this->db->join($db.'.aux_grados_agrupados AS t2', 't2.id_grado_agrupado = t1.id', 'left');		
		$this->db->where('t.year', $year);
		$this->db->where('t2.id_grado', $c_gdo);
		$this->db->limit(1);
		$sql	= $this->db->get();

		if ($sql->num_rows() > 0){
			$this->_n_decimales	= $sql->row('Ndecimales');
			$this->_n_promocion	= $sql->row('promocion');
			$this->_n_red		= $sql->row('nota_redondeo');
			$this->_n_final_red	= $sql->row('nota_final_redondeo');
			$this->_n_aplica	= $sql->row('aplicar_redondeo_fin_año');
		}
		
		$this->db->select('id');
		$this->db->from($db.'.student_enrollment AS tm');
		$this->db->where('tm.year', $year);
		$this->db->where('tm.id_grade', $c_gdo);
		$this->db->where('tm.id_headquarters', $sede);
		$this->db->where('tm.id_state',2);
		if($groupA == 0){
			/**
			 * Agrupa por el grupo seleccionado
			 */
			$this->db->where('id_group', $gpo);
		}
		$this->db->order_by('id_grade, id_group, id_study_day');
		$query	= $this->db->get();
		
		$this->get_desempeños_rango($c_gdo);

		$this->db->from($db.'.matcurso AS tm');
		$this->db->join($db.'.asignaturas AS ta', 'tm.id_asig = ta.id_pk', 'left');
		$this->db->join($db.'.aux_asignaturas AS au', 'au.id_asign = ta.id_pk', 'left');
		$this->db->where('tm.id_grado', $c_gdo);
		$this->db->where('tm.estado', 1);
		$this->db->where('tm.year', $year);
		$this->db->where('au.year', $year);

		if($type == 2){
			$this->db->select('au.id_area AS id_asig');
			$this->db->group_by('au.id_area, tm.year, au.year');
			$this->db->order_by('au.id_area');
		}else{
			$this->db->select('tm.id_asig');
			$this->db->group_by('tm.id_asig, tm.year, au.year');
			$this->db->order_by('au.id_area, tm.id_asig');
		}
		$cur_matcurso	= $this->db->get();

		$this->matcurso	= $cur_matcurso;
		if($query AND $cur_matcurso){
			$x_count = 0;
			$val	= '';
			foreach($cur_matcurso->result() as $cur){
				++$x_count;
				switch($x_count){
					case 1: $this->aa1 = $cur->id_asig;
						break;
					case 2: $this->aa2 = $cur->id_asig;
						break;
					case 3: $this->aa3 = $cur->id_asig;
						break;
					case 4: $this->aa4 = $cur->id_asig;
						break;
					case 5: $this->aa5 = $cur->id_asig;
						break;
					case 6: $this->aa6 = $cur->id_asig;
						break;
					case 7: $this->aa7 = $cur->id_asig;
						break;
					case 8: $this->aa8 = $cur->id_asig;
						break;
					case 9: $this->aa9 = $cur->id_asig;
						break;
					case 10: $this->aa10 = $cur->id_asig;
						break;
					case 11: $this->aa11 = $cur->id_asig;
						break;
					case 12: $this->aa12 = $cur->id_asig;
						break;
					case 13: $this->aa13 = $cur->id_asig;
						break;
					case 14: $this->aa14 = $cur->id_asig;
						break;
					case 15: $this->aa15 = $cur->id_asig;
						break;
					case 16: $this->aa16 = $cur->id_asig;
						break;
					case 17: $this->aa17 = $cur->id_asig;
						break;
					case 18: $this->aa18 = $cur->id_asig;
						break;
					case 19: $this->aa19 = $cur->id_asig;
						break;
					case 20: $this->aa20 = $cur->id_asig;
						break;
					case 21: $this->aa21 = $cur->id_asig;
						break;
					case 22: $this->aa22 = $cur->id_asig;
						break;
					case 23: $this->aa23 = $cur->id_asig;
						break;
					case 24: $this->aa24 = $cur->id_asig;
						break;
					case 25: $this->aa25 = $cur->id_asig;
						break;					
					default:
						break;
				}
			}			
			foreach($query->result() as $row){
				try{
					/**
					 * Genera el consolidado de todos los periodos
					 */
					if($perAll == 1){	
						for($x = 1; $x <= strval($per); $x++){
							switch($type){
								case 1: 
									$result	= $this->consolidados($row->id,$x,$c_gdo,$gpo,$type);
									break;
								case 2: 
									$result	= $this->consolidados($row->id,$x,$c_gdo,$gpo,$type);
									break;
								default:
									$result	= $this->consolidado_docentes($row->id,$per);
									break;
							}
						}
					}else{
						switch($type){
							case 1: 
								$result	= $this->consolidados($row->id,$per,$c_gdo,$gpo,$type);
								break;
							case 2: 
								$result	= $this->consolidados($row->id,$per,$c_gdo,$gpo,$type);
								break;
							default:
								$result	= $this->consolidado_docentes($row->id,$per);
								break;
						}	
					}
					$result = $this->get_request_ab();
				} catch (Exception $e) {
					$result = 'Excepción capturada: '. $e->getMessage()."\n";	
				}
			}			
			if($groupA == 1){
				/**
				 * Genera todos los grupos
				 */
				$this->db->select('id_headquarters, id_study_day, id_group, id_grade');
				$this->db->from($db.'.student_enrollment');
				$this->db->where('id_state', 2);
				$this->db->where('year', $year);
				$this->db->where('id_headquarters', $sede);
				$this->db->group_by('id_headquarters, id_study_day, id_group, id_grade');
				$this->db->order_by('id_grade, id_group, id_study_day');
				$query	= $this->db->get();
				if($query AND $query->num_rows() > 0){
					foreach($query->result() as $row){
						try{
							if($perAll == 1){
								/**
								 * Todos los periodos
								 */
								for($x = 1; $x <= strval($per); $x++){
									$this->consolidado_totales($sede,$row->id_study_day,$row->id_group,$c_gdo,$x,$type);
								}
							}else{
								$this->consolidado_totales($sede,$row->id_study_day,$row->id_group,$c_gdo,$per,$type);
							}
							$result = $this->get_request_ab();
						} catch (Exception $e) {
							$result = 'Excepción capturada: '. $e->getMessage()."\n";	
						}	
					}
					
				}
			}else{
				try{
					if($perAll == 1){
						/**
						 * Todos los periodos
						 */
						for($x = 1; $x <= strval($per); $x++){
							$this->consolidado_totales($sede,$jorn,$gpo,$c_gdo,$x,$type);
						}
					}else{
						$this->consolidado_totales($sede,$jorn,$gpo,$c_gdo,$per,$type);
					}
					$result = $this->get_request_ab();
				} catch (Exception $e) {
					$result = 'Excepción capturada: '. $e->getMessage()."\n";	
				}	
			}		
		}else{
			$result = $this->get_error();
		}		
		return $result;
	}
	
	function consolidado_totales ($sede,$jorn,$grupo,$grado,$per,$type){
		$na1=0;$na2=0;$na3=0;$na4=0;$na5=0;$na6=0;$na7=0;$na8=0;$na9=0;$na10=0;$na11=0;
		$na12=0;$na13=0;$na14=0;$na15=0;$na16=0;$na17=0;$na18=0;$na19=0;$na20=0;
		$na21=0;$na22=0;$na23=0;$na24=0;$na25=0;
		$db	= $this->get_db_name();
		$year	= $this->get_year();
		if($type == 2){
			$tableCon	= $db.'.consolidado_areas_totales';
			$tableCon2	= $db.'.consolidado_areas';
		}else{				
			$tableCon	= $db.'.consolidado_totales';
			$tableCon2	= $db.'.consolidado';
		}
		
		$this->db->where('id_sede', $sede);
		$this->db->where('grupo', $grupo);
		$this->db->where('id_grado', $grado);
		$this->db->where('id_jorn', $jorn);
		$this->db->where('year', $year);
		$this->db->where('periodo', $per);
		$this->db->limit(1);
		$this->db->delete($tableCon);
		
		$ins	= "INSERT INTO ".$tableCon." (id_sede,id_jorn,id_grado,grupo,year,periodo) VALUES (".
					$sede.",".$jorn.",".$grado.",'".$grupo."',".$this->get_year().",'".$per."')";
		$ins	= $this->db->query($ins);
		
		$this->db->select('tm.year,tc.*,tg.cod_grado');
		$this->db->from($tableCon2." AS tc ");
		$this->db->join($db.'.student_enrollment AS tm', 'tc.id_matric = tm.id', 'left');
		$this->db->join($db.'.inscripciones AS te', 'tm.id_student = te.id ', 'left');
		$this->db->join($db.'.grados AS tg', 'tm.id_grade = tg.id', 'left');
		$this->db->join($db.'.jornadas AS tj', 'tm.id_study_day = tj.cod_jorn', 'left');
		$this->db->join($db.'.sedes AS ts', 'tm.id_headquarters = ts.ID', 'left');
		$this->db->where('tm.id_student = te.id');
		$this->db->where('tm.id_grade', $grado);
		$this->db->where('tm.id_group', $grupo);
		$this->db->where('tm.id_study_day', $jorn);
		$this->db->where('tm.id_headquarters', $sede);
		$this->db->where('tm.year', $year);
		$this->db->where('tc.periodo', $per);
		$this->db->where('tc.t > 0');
		$this->db->order_by('tc.periodo');
		$query = $this->db->get();
		
		if ($query AND $query->num_rows() > 0){
			foreach($query->result() as $row){
				$count_matcurso = 1;
				$x_count2	= 0;					
				do{
					++$x_count2;
					if($x_count2 <= 25){
						switch($x_count2){
							case 1: 
								if($row->nar1 >= $this->desde AND $row->nar1 <= $this->hasta){
									++$na1;
								}
								break;
							case 2: 
								if($row->nar2 >= $this->desde AND $row->nar2 <= $this->hasta){
									++$na2;
								}
								break;
							case 3: 
								if($row->nar3 >= $this->desde AND $row->nar3 <= $this->hasta){
									++$na3;
								}
								break;
							case 4: 
								if($row->nar4 >= $this->desde AND $row->nar4 <= $this->hasta){
									++$na4;
								}
								break;
							case 5: 
								if($row->nar5 >= $this->desde AND $row->nar5 <= $this->hasta){
									++$na5;
								}
								break;
							case 6: 
								if($row->nar6 >= $this->desde AND $row->nar6 <= $this->hasta){
									++$na6;
								}
								break;
							case 7: 
								if($row->nar7 >= $this->desde AND $row->nar7 <= $this->hasta){
									++$na7;
								}
								break;
							case 8: 
								if($row->nar8 >= $this->desde AND $row->nar8 <= $this->hasta){
									++$na8;
								}
								break;
							case 9: 
								if($row->nar9 >= $this->desde AND $row->nar9 <= $this->hasta){
									++$na9;
								}
								break;
							case 10: 
								if($row->nar10 >= $this->desde AND $row->nar10 <= $this->hasta){
									++$na10;
								}
								break;
							case 11:
								if($row->nar11 >= $this->desde AND $row->nar11 <= $this->hasta){
									++$na11;
								}
								break;
							case 12: 
								if($row->nar12 >= $this->desde AND $row->nar12 <= $this->hasta){
									++$na12;
								}
								break;
							case 13: 
								if($row->nar13 >= $this->desde AND $row->nar13 <= $this->hasta){
									++$na13;
								}
								break;
							case 14: 
								if($row->nar14 >= $this->desde AND $row->nar14 <= $this->hasta){
									++$na14;
								}
								break;
							case 15: 
								if($row->nar15 >= $this->desde AND $row->nar15 <= $this->hasta){
									++$na15;
								}
								break;
							case 16: 
								if($row->nar16 >= $this->desde AND $row->nar16 <= $this->hasta){
									++$na16;
								}
								break;
							case 17: 
								if($row->nar17 >= $this->desde AND $row->nar17 <= $this->hasta){
									++$na17;
								}
								break;
							case 18: 
								if($row->nar18 >= $this->desde AND $row->nar18 <= $this->hasta){
									++$na18;
								}
								break;
							case 19: 
								if($row->nar19 >= $this->desde AND $row->nar19 <= $this->hasta){
									++$na19;
								}
								break;
							case 20: 
								if($row->nar20 >= $this->desde AND $row->nar20 <= $this->hasta){
									++$na20;
								}
								break;
							case 21: 
								if($row->nar21 >= $this->desde AND $row->nar21 <= $this->hasta){
									++$na21;
								}
								break;
							case 22: 
								if($row->nar22 >= $this->desde AND $row->nar22 <= $this->hasta){
									++$na22;
								}
								break;
							case 23: 
								if($row->nar23 >= $this->desde AND $row->nar23 <= $this->hasta){
									++$na23;
								}
								break;
							case 24: 
								if($row->nar24 >= $this->desde AND $row->nar24 <= $this->hasta){
									++$na24;
								}
								break;
							case 25: 
								if($row->nar25 >= $this->desde AND $row->nar25 <= $this->hasta){
									++$na25;
								}
								break;					
							default: $count_matcurso	= 0;
								break;
						}
					}else{
						$count_matcurso	= 0;
					}							
				} while($count_matcurso > 0);	
				
			}	
			$sqlUpdate = "UPDATE ".$tableCon." SET ar1='".$na1."',ar2='".$na2."',ar3='".$na3."',ar4='".$na4.
			"',ar5='".$na5."',ar6='".$na6."',ar7='".$na7."',ar8='".$na8."',ar9='".$na9."',ar10='".$na10.
			"',ar11='".$na11."',ar12='".$na12."',ar13='".$na13."',ar14='".$na14."',ar15='".$na15."',ar16='".
			$na16."',ar17='".$na17."',ar18='".$na18.
			"',ar19='".$na19."',ar20='".$na20."',ar21='".$na21."',ar22='".$na22."',ar23='".$na23.
			"',ar24='".$na24."',ar25='".$na25.
			"' WHERE id_grado = ".$grado." AND id_sede= ".$sede." AND year = ".$this->get_year().
					" AND id_jorn= ".$jorn.
					" AND grupo= '".$grupo."' AND periodo='".$per."' LIMIT 1";				
			$this->db->query($sqlUpdate);
		}
	}
	
	function consolidados($idMatric, $per, $grado, $grupo, $type){	
		$db	= $this->get_db_name();	
		$table	= $db.'.'.$this->tabla_notas($grado);
		$year	= $this->get_year();	
		if($type == 2){
			$tableCon	= $db.'.consolidado_areas';
			$this->db->select('au.id_area AS id_asig, 
			ROUND(IF(tmc.porciento BETWEEN 1 AND 99,
			SUM(IF(tn.nota_habilitacion > 0,(tn.nota_habilitacion*tmc.porciento)/100,(tn.final*tmc.porciento)/100)),
			AVG(IF(tn.nota_habilitacion > 0, tn.nota_habilitacion, tn.final))),2) AS final');
			$this->db->from($table.' AS tn');
			$this->db->join($db.'.cursos AS tc', '(tn.id_curso = tc.id AND tn.`year` = tc.`year`)', 'left');
			$this->db->join($db.'.asignaturas AS tas', 'tc.id_asig = tas.id_pk', 'left');
			$this->db->join($db.'.aux_asignaturas AS au', '(au.id_asign = tas.id_pk AND au.year = tc.year)', 'left');
			$this->db->join($db.'.areas AS tar', 'au.id_area = tar.id', 'left');
			$this->db->join($db.'.student_enrollment AS tm', 'tn.id_matric = tm.id', 'left');
			$this->db->join($db.'.matcurso AS tmc', '(tmc.id_asig = tas.id_pk AND tmc.id_grado = tm.id_grade 
			AND tmc.`year` = tm.`year`)', 'left');
			$this->db->where('tn.year', $year);
			$this->db->where('tn.id_matric', $idMatric);
			$this->db->where('tn.periodo', $per);
			$this->db->where('tc.year', $year);
			$this->db->where('tc.id_grado', $grado);
		   	$this->db->where('tc.estado', 1);
			$this->db->where('au.year', $year);
			$this->db->where('tmc.year', $year);
			$this->db->where('tmc.id_grado', $grado);
			$this->db->group_by('tn.id_matric,tn.periodo,au.id_area');				
		}else{				
			$tableCon	= $db.'.consolidado';
			$this->db->select('tc.id_asig, if(tn.nota_habilitacion > 0, tn.nota_habilitacion, tn.final) AS final');
			$this->db->from($table.' AS tn');
			$this->db->join($db.'.cursos AS tc', '(tn.id_curso = tc.id AND tn.year = tc.year)', 'left');
			$this->db->join($db.'.asignaturas AS ta', 'tc.id_asig = ta.id_pk', 'left');
			$this->db->join($db.'.aux_asignaturas AS au', '(au.id_asign = ta.id_pk AND au.year = tc.year)', 'left');
			$this->db->join($db.'.student_enrollment AS tm', 'tn.id_matric = tm.id', 'left');
			$this->db->where('tn.year', $year);
			$this->db->where('tn.periodo', $per);
			$this->db->where('tn.id_matric', $idMatric);
			$this->db->where('tn.final >= 0');
			$this->db->where('tc.year', $year);
			$this->db->where('tc.id_grado', $grado);
			$this->db->where('tc.estado', 1);
			$this->db->where('au.year', $year);
			$this->db->order_by('au.id_area,au.id_asign');
		}
		$query	= $this->db->get();

		$this->db->where('id_matric', $idMatric);
		$this->db->where('periodo', $per);
		$this->db->limit(1);
		$this->db->delete($tableCon);

		if($query){
			$x_count	= 0;
			$_suma		= 0;
			$idAsig		= 0;
			$sqlUpdate	= '';
			$sqlString	= '';
			$sqlIn		= '';
			$final		= 0;
			if ($query->num_rows() > 0) {
				$sin	= '';
				for($i = 1; $i <=25 ; $i++){
					$sin = $sin."ar".$i.",";
				}
				$ins	= "INSERT INTO ".$tableCon." (".$sin."id_matric,periodo) VALUES ('"
				.$this->aa1."','".$this->aa2."','".$this->aa3."','".$this->aa4."','".$this->aa5."','".
				$this->aa6."','".$this->aa7."','".$this->aa8."','".$this->aa9."','".$this->aa10."','".
				$this->aa11."','".$this->aa12."','".$this->aa13."','".$this->aa14."','".$this->aa15."','".
				$this->aa16."','".$this->aa17."','".$this->aa18."','".$this->aa19."','".$this->aa20."','".
				$this->aa21."','".$this->aa22."','".$this->aa23."','".$this->aa24."','".$this->aa25."','"
				.$idMatric."','".$per."');";
				$ins	= $this->db->query($ins);
				$x_cant_asig_perdidas	= 0;		
				foreach($query->result() as $row){
					++$x_count;
					$count_matcurso = 1;
					$final			= $row->final;
					/**
					 * 
					 * Redondeo de notas, si aplica
					 * 
					 */
					if($this->_n_red > 0 AND $this->_n_aplica > 0){
						if($final >= $this->_n_red AND $final <= $this->hasta){
							$final = $this->_n_final_red;
						}
					}/*END*/
					$_suma			= $_suma + $final;
					$idAsig			= $row->id_asig;
					if($final >= 0 AND $final <= $this->hasta){
						++$x_cant_asig_perdidas;
					}
					$x_count2	= 0;					
					do{
						++$x_count2;
						if($x_count2 <= 25){
							switch($x_count2){
								case 1: 
									if($idAsig == $this->aa1){
										$sqlString = $sqlString.'ar'.$x_count2.'='.$this->aa1.
										',nar'.$x_count2.'='.$final.',';
										$count_matcurso	= 0;	
									}
									break;
								case 2: 
									if($idAsig == $this->aa2){
										$sqlString = $sqlString.'ar'.$x_count2.'='.$this->aa2.
										',nar'.$x_count2.'='.$final.',';
										$count_matcurso	= 0;	
									}
									break;
								case 3: 
									if($idAsig == $this->aa3){
										$sqlString = $sqlString.'ar'.$x_count2.'='.$this->aa3.
										',nar'.$x_count2.'='.$final.',';
										$count_matcurso	= 0;	
									}
									break;
								case 4: 
									if($idAsig == $this->aa4){
										$sqlString = $sqlString.'ar'.$x_count2.'='.$this->aa4.
										',nar'.$x_count2.'='.$final.',';
										$count_matcurso	= 0;	
									}
									break;
								case 5: 
									if($idAsig == $this->aa5){
										$sqlString = $sqlString.'ar'.$x_count2.'='.$this->aa5.
										',nar'.$x_count2.'='.$final.',';
										$count_matcurso	= 0;	
									}
									break;
								case 6: 
									if($idAsig == $this->aa6){
										$sqlString = $sqlString.'ar'.$x_count2.'='.$this->aa6.
										',nar'.$x_count2.'='.$final.',';
										$count_matcurso	= 0;	
									}
									break;
								case 7: 
									if($idAsig == $this->aa7){
										$sqlString = $sqlString.'ar'.$x_count2.'='.$this->aa7.
										',nar'.$x_count2.'='.$final.',';
										$count_matcurso	= 0;	
									}
									break;
								case 8: 
									if($idAsig == $this->aa8){
										$sqlString = $sqlString.'ar'.$x_count2.'='.$this->aa8.
										',nar'.$x_count2.'='.$final.',';
										$count_matcurso	= 0;	
									}
									break;
								case 9: 
									if($idAsig == $this->aa9){
										$sqlString = $sqlString.'ar'.$x_count2.'='.$this->aa9.
										',nar'.$x_count2.'='.$final.',';
										$count_matcurso	= 0;	
									}
									break;
								case 10: 
									if($idAsig == $this->aa10){
										$sqlString = $sqlString.'ar'.$x_count2.'='.$this->aa10.
										',nar'.$x_count2.'='.$final.',';
										$count_matcurso	= 0;	
									}
									break;
								case 11:
									if($idAsig == $this->aa11){
										$sqlString = $sqlString.'ar'.$x_count2.'='.$this->aa11.
										',nar'.$x_count2.'='.$final.',';
										$count_matcurso	= 0;	
									}
									break;
								case 12: 
									if($idAsig == $this->aa12){
										$sqlString = $sqlString.'ar'.$x_count2.'='.$this->aa12.
										',nar'.$x_count2.'='.$final.',';
										$count_matcurso	= 0;	
									}
									break;
								case 13: 
									if($idAsig == $this->aa13){
										$sqlString = $sqlString.'ar'.$x_count2.'='.$this->aa13.
										',nar'.$x_count2.'='.$final.',';
										$count_matcurso	= 0;	
									}
									break;
								case 14: 
									if($idAsig == $this->aa14){
										$sqlString = $sqlString.'ar'.$x_count2.'='.$this->aa14.
										',nar'.$x_count2.'='.$final.',';
										$count_matcurso	= 0;	
									}
									break;
								case 15: 
									if($idAsig == $this->aa15){
										$sqlString = $sqlString.'ar'.$x_count2.'='.$this->aa15.
										',nar'.$x_count2.'='.$final.',';
										$count_matcurso	= 0;	
									}
									break;
								case 16: 
									if($idAsig == $this->aa16){
										$sqlString = $sqlString.'ar'.$x_count2.'='.$this->aa16.
										',nar'.$x_count2.'='.$final.',';
										$count_matcurso	= 0;	
									}
									break;
								case 17: 
									if($idAsig == $this->aa17){
										$sqlString = $sqlString.'ar'.$x_count2.'='.$this->aa17.
										',nar'.$x_count2.'='.$final.',';
										$count_matcurso	= 0;	
									}
									break;
								case 18: 
									if($idAsig == $this->aa18){
										$sqlString = $sqlString.'ar'.$x_count2.'='.$this->aa18.
										',nar'.$x_count2.'='.$final.',';
										$count_matcurso	= 0;	
									}
									break;
								case 19: 
									if($idAsig == $this->aa19){
										$sqlString = $sqlString.'ar'.$x_count2.'='.$this->aa19.
										',nar'.$x_count2.'='.$final.',';
										$count_matcurso	= 0;	
									}
									break;
								case 20: 
									if($idAsig == $this->aa20){
										$sqlString = $sqlString.'ar'.$x_count2.'='.$this->aa20.
										',nar'.$x_count2.'='.$final.',';
										$count_matcurso	= 0;	
									}
									break;
								case 21: 
									if($idAsig == $this->aa21){
										$sqlString = $sqlString.'ar'.$x_count2.'='.$this->aa21.
										',nar'.$x_count2.'='.$final.',';
										$count_matcurso	= 0;	
									}
									break;
								case 22: 
									if($idAsig == $this->aa22){
										$sqlString = $sqlString.'ar'.$x_count2.'='.$this->aa22.
										',nar'.$x_count2.'='.$final.',';
										$count_matcurso	= 0;	
									}
									break;
								case 23: 
									if($idAsig == $this->aa23){
										$sqlString = $sqlString.'ar'.$x_count2.'='.$this->aa23.
										',nar'.$x_count2.'='.$final.',';
										$count_matcurso	= 0;	
									}
									break;
								case 24: 
									if($idAsig == $this->aa24){
										$sqlString = $sqlString.'ar'.$x_count2.'='.$this->aa24.
										',nar'.$x_count2.'='.$final.',';
										$count_matcurso	= 0;	
									}
									break;
								case 25: 
									if($idAsig == $this->aa25){
										$sqlString = $sqlString.'ar'.$x_count2.'='.$this->aa25.
										',nar'.$x_count2.'='.$final.',';
										$count_matcurso	= 0;	
									}
									break;					
								default: $count_matcurso	= 0;
									break;
							}
						}else{
							$count_matcurso	= 0;
						}							
					} while($count_matcurso > 0);	
					
				}	
				if($_suma > 0){
					$_suma = round($_suma/$x_count,2);
				}
				$sqlString = substr($sqlString,0,strlen($sqlString)-1);
				$sqlUpdate = 'UPDATE '.$tableCon.' SET '.$sqlString.
				",prom='".$_suma."',t=".$x_cant_asig_perdidas.
				" WHERE id_matric = ".$idMatric." AND periodo ='".$per."'";				
				$this->db->query($sqlUpdate);
				$x_cant_asig_perdidas	= 0;
			}
				
		}
	}
			
	function consolidado_docentes($idMatric, $per, $grado, $grupo){
	}
	
}