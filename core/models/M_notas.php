<?php
defined('BASEPATH') OR exit('No direct script access allowed');
class M_notas extends SME_Model {
	function __construct() {
		parent::__construct();
	}	

	function notas_delete($grade,$record){
		$table	= $this->tabla_notas($grade);
		return 	$this->delete_data($table,$record);
	}
	
	public function get_generate_libro_final($c_grado,$cod_asig,$cod_jorn,$id_sede,$grupo,$periodo,$all){
		$param	= 
		$this->get_id_school().",".$this->get_year().",".$id_sede.",'".$c_grado."','".$grupo."',".$cod_jorn.",".$all.",".$periodo;
		$this->get_call_execute('sp_generar_libros',$param);
	}
	
	public function get_logros_estandares_verify($periodo,$grado,$asig) {
		$db     = $this->get_db_name();
		$year	= $this->get_year();
		$query	= "SELECT tl.id_docente, tl.id_asig, tl.tipo 
						FROM ".$db.".logros_estandares tl 
						WHERE periodo=".$periodo." AND id_grado='".$grado.
						"' AND id_asig=".$asig." AND id_docente=".$this->get_parent().
						" AND tipo=2 AND tl.year = ".$year." GROUP BY id_docente,id_asig,periodo,tipo";
						
		$query2	= "SELECT tl.id_docente, tl.id_asig, tl.tipo 
						FROM ".$db.".logros_estandares tl 
						WHERE periodo=".$periodo." AND id_grado='".$grado.
						"' AND id_asig=".$asig." AND id_docente=".$this->get_parent().
						" AND tipo > 2 AND tl.year = ".$year." GROUP BY id_docente,id_asig,periodo,tipo";
	  
	  $logros		= $this->db->query($query);
	  $indicadores	= $this->db->query($query2);
	  
	  if ($query AND $query2) {
		$result	= array(
			'success'		=> true,
			'logros'		=> $logros->result(),
			'indicadores'	=> $indicadores->result()
		);
		  
	  }else{
	  	$result	= array(
			'success'	=> false
		);
	  }
	  
	  return json_encode($result);
	}
	
	/**
	* Funcion para seleccionar los datos de los estudiantes con ausencias
	* 
	* @return
	*/
	public function get_select_ausencias () {
		$query	= "SELECT tau.*, CONCAT(rtrim(ti.apellido1),' ',rtrim(ti.apellido2),' ',
					rtrim(ti.nombre1),' ',rtrim(ti.nombre2)) AS nombres, tas.asignatura, 
					ts.nom_sede AS sede, tg.grado, tm.cod_grado, tm.grupo, tm.id_sede FROM ausencias AS tau 
					LEFT JOIN student_enrollment AS tm ON tau.id_matric = tm.id_matric 
					LEFT JOIN inscripciones AS ti ON tm.cod_est = ti.cod_est 
					LEFT JOIN asignaturas AS tas ON tau.id_asig = tas.id 
					LEFT JOIN grados AS tg ON tm.cod_grado = tg.cod_grado 
					LEFT JOIN sedes AS ts ON tm.id_sede = ts.id ";
					
		$where 	=   "ti.id_inst= ? AND tas.id_inst= ? 
					AND ts.id_inst= ? AND tas.year= ? AND tm.year= ? AND tau.id_docente= ? ";
					
		$param 	= array(
			$this->get_id_school(),
			$this->get_id_school(),
			$this->get_id_school(),
			$this->get_year(),
			$this->get_year(),
			$this->get_parent()
		);
		
		$request = $this->get_query_param($this->limit_min,$this->limit_max,$query,$where,$param);
		
		return $request;
	}
	
	/**
	* Funcion que guarda los logros e indicadores de desempeñosde forma selectivas a los estudiantes
	* 
	* @return
	*/
	
	public function get_logro_estandares_save ($list,$grado) {
		$db		= $this->get_db_name();
		$table_log	= $db.".".$this->tabla_logros_estandares($grado);		
		if(is_array($list)){
			$this->trans_start();		
			foreach ($list as $value) {
				$id_nota		= $value->id_nota;
				$id_logro		= $value->id_logro_estandar;
				$estado			= $value->estado;
				$id_desempeno 	= $value->id_escala;
				$final			= $value->final;
				$id_desempeno_nota	= $this->get_desempeños_id($final,$grado);
				$query 	= "SELECT * FROM ".$table_log." WHERE id_nota=".$id_nota.
						 " AND id_logro_estandar=".$id_logro;
				
				$query	= $this->db->query($query);
				
				if ($query->num_rows() == 0){
					if($id_desempeno_nota > 0){
						switch($estado){
							case 1 : // Asignar segun desempeño
							
								if ($id_desempeno === $id_desempeno_nota) {											
									/**
									*  Se inserta el logro y/o el indicador
									*/								
									$query	= "INSERT INTO ".$table_log.
									" (id_nota,id_logro_estandar) VALUES ('".
									$id_nota."','".$id_logro."')" ;
									
									$this->db->query($query);
								}
								break;
							case 2 : // Asigntar sin tener en cuenta el desempeño
								/**
								*  Se inserta el logro y/o el indicador
								*/							
								$query	= "INSERT INTO ".$table_log.
								" (id_nota,id_logro_estandar) VALUES ('".
								$id_nota."','".$id_logro."')" ;								
								$this->db->query($query);
								
								break;
							default	: 
								/**
								*  Se inserta el logro y/o el indicador
								*/
							
								$query	= "INSERT INTO ".$table_log.
								" (id_nota,id_logro_estandar) VALUES ('".
								$id_nota."','".$id_logro."')" ;
								
								$this->db->query($query);
								
								break;
						}
					}else{						
						if($estado == 2){
							/**
							*  Se inserta el logro y/o el indicador
							*/						
							$query	= "INSERT INTO ".$table_log.
							" (id_nota,id_logro_estandar) VALUES ('".
							$id_nota."','".$id_logro."')" ;							
							$this->db->query($query);
						}elseif ($estado == 3) {
							/**
							*  Se inserta el logro y/o el indicador
							*/						
							$query	= "INSERT INTO ".$table_log.
							" (id_nota,id_logro_estandar) VALUES ('".
							$id_nota."','".$id_logro."')" ;
							
							$this->db->query($query);
						}
						
					}				
				}
			}			
			$this->trans_complete();
			
		}else{			
			$id_nota		= $list->id_nota;
			$id_logro		= $list->id_logro_estandar;
			$estado			= $list->estado;
			$id_desempeno 	= $list->id_escala;
			$final			= $list->final;
			$id_desempeno_nota	= $this->get_desempeños_id($final,$grado);			
			$query 	= "SELECT * FROM ".$table_log." WHERE id_nota=".$id_nota.
					 " AND id_logro_estandar=".$id_logro;			
			$query	= $this->db->query($query);			
			if ($query->num_rows() == 0){				
				if($id_desempeno_nota > 0){												
					switch($estado){
						case 1 : // Asignar segun desempeño						
							if ($id_desempeno === $id_desempeno_nota) {												
								/**
								*  Se inserta el logro y/o el indicador
								*/							
								$query	= "INSERT INTO ".$table_log.
								" (id_nota,id_logro_estandar) VALUES ('".
								$id_nota."','".$id_logro."')" ;
								
								$this->db->query($query);
							}
							break;
						case 2 : // Asigntar sin tener en cuenta el desempeño
							/**
							*  Se inserta el logro y/o el indicador
							*/
						
							$query	= "INSERT INTO ".$table_log.
							" (id_nota,id_logro_estandar) VALUES ('".
							$id_nota."','".$id_logro."')" ;
							
							$this->db->query($query);
							
							break;
						default : 
							/**
							*  Se inserta el logro y/o el indicador
							*/						
							$query	= "INSERT INTO ".$table_log.
							" (id_nota,id_logro_estandar) VALUES ('".
							$id_nota."','".$id_logro."')" ;
							
							$this->db->query($query);
							
							break;
					}
				}else{					
					if($estado == 2){
						/**
						*  Se inserta el logro y/o el indicador
						*/					
						$query	= "INSERT INTO ".$table_log.
						" (id_nota,id_logro_estandar) VALUES ('".
						$id_nota."','".$id_logro."')" ;
						
						$this->db->query($query);
					}elseif ($estado == 3) {
						/**
						*  Se inserta el logro y/o el indicador
						*/						
						$query	= "INSERT INTO ".$table_log.
						" (id_nota,id_logro_estandar) VALUES ('".
						$id_nota."','".$id_logro."')" ;
						
						$this->db->query($query);
					}
					
				}				
			}
		}
	}
	
	/**
	* Funcion para insertar los logros e indicadires de los estudiantes
	* @param INT $grado
	* @param INT $curso
	* @param INT $jorn
	* @param INT $sede
	* @param STRING $grupo
	* @param STRING $periodo
	* @param INT $asig
	* 
	* @return
	*/
	
	public function insert_log_notas($grado,$curso,$jorn,$sede,$grupo,$periodo,$asig) {
		if(empty($periodo)){
			return FALSE;
		}
		$db         	= $this->get_db_name();
		$table_notas 	= $db.".".$this->tabla_notas($grado);		
		$table_log		= $db.".".$this->tabla_logros_estandares($grado);		
		$proceso		= $this->proceso_educativo($grado);
		$filas			= $this->get_columns_notas($grado);
		if ($curso > 0){
			$query_notas	= "SELECT tn.id,".$filas.",tn.final,
							  tn.id_escala,tm.id id_matric FROM ".$table_notas." AS tn 
							  LEFT JOIN ".$db.".cursos AS tc ON (tn.id_curso = tc.id AND tn.year=tc.year)
							  LEFT JOIN ".$db.".student_enrollment AS tm ON tn.id_matric=tm.id 
							  WHERE tn.year=".$this->get_year()." AND tn.id_curso=".$curso." AND tn.periodo='".$periodo.
							  "' AND tc.id=".$curso." AND tc.year =".$this->get_year().
							  " AND tm.id_grade='".$grado."' AND tm.id_state=2 AND tm.year=".$this->get_year();

			$query_log		= "SELECT * FROM ".$db.".logros_estandares WHERE id_docente=".$this->get_parent().
								" AND id_asig=".$asig."  AND year=".$this->get_year()." and periodo=".$periodo.
								" AND id_grado='".$grado."' ORDER BY tipo, id_competencia, id_escala";	
			//print_r($query_log);
			$query_notas 	= $this->db->query($query_notas);			
			$query_log		= $this->db->query($query_log);
			if ($query_notas AND $query_log) {				
				if($query_notas->num_rows() > 0 AND $query_log->num_rows() > 0){									
					$this->trans_start(); // Establecemos una transacción					
					/**
					*  Se eliminan, para evitar conflictos de duplicidad, los logros e indicadores 
					* que se hallan insertado a los estudiantes.
					*/					
					foreach($query_notas->result_array() as $ckey => $cvalue){						
						$id_nota		= $cvalue['id'];						
						foreach($query_log->result_array() as $fkey => $fvalue){							
							$id_del_log	= $fvalue['id'];
							$estado_del	= $fvalue['estado'];							
							if ($estado_del == 1 OR $estado_del == 2) {
								$query_delete 	= "DELETE FROM ".$table_log.
								" WHERE id_nota=".$id_nota." AND id_logro_estandar=".$id_del_log;						
								$query_delete	= $this->db->query($query_delete);
							}							
						}						
					}					
					/**
					* Recorremos el array con los datos de la tabla con los logros e indicadores
					*/
					foreach($query_log->result_array() as $key => $value){
						$id_logro	= $value['id'];
						$estado		= $value['estado'];
						$id_desempeno	= $value['id_escala'];
						$id_competencia	= $value['id_competencia'];						
						/**
						* Recorremos el array que contiene el id de las notas insertadas a los estudiantes
						* 
						*/
						foreach($query_notas->result_array() as $nkey => $nvalue){
							$id_nota			= $nvalue['id'];
							$id_desempeno_nota	= $nvalue['id_escala'];		 											
							if ($proceso == 3) { //Valores para procesos por competencias 
								if ($id_competencia > 0 AND $estado == 1) { // Asignar por desempeño
									$x_campo				= 'prom'.strval($id_competencia);
									$nota_campo				= $nvalue[$x_campo];					
									$id_desempeno_nota		= $this->get_desempeños_id($nota_campo,$grado);
								}							
							}													
							if($id_desempeno_nota > 0){								
								switch($estado){
									case 1 : // Asignar segun desempeño									
										if ($id_desempeno === $id_desempeno_nota) {									
											$query	= "INSERT INTO ".$table_log.
											" (id_nota,id_logro_estandar) VALUES ('".
											$id_nota."','".$id_logro."')";											
											$this->db->query($query);
										}
										break;
									case 2 : // Asigntar sin tener en cuenta el desempeño
										$query	= "INSERT INTO ".$table_log.
										" (id_nota,id_logro_estandar) VALUES ('".
										$id_nota."','".$id_logro."')" ;										
										$this->db->query($query);										
									break;
								}
							}else{							
								if($estado == 2){ // Asigntar sin tener en cuenta el desempeño
									$query	= "INSERT INTO ".$table_log.
									" (id_nota,id_logro_estandar) VALUES ('".
									$id_nota."','".$id_logro."')" ;									
									$this->db->query($query);
								}								
							}
						}				
					}				
					$this->trans_complete();	// Ejecutamos la transacción			
				}			
			}
		}else{
			$get_cur = "SELECT tc.id,tc.id_jorn, tc.grupo FROM ".$db.".cursos tc WHERE 
					tc.id_docente = ".$this->get_parent()." AND tc.id_asig = ".$asig.
					" AND tc.id_sede = ".$sede." AND tc.id_grado =".$grado."
					AND tc.estado = 1 AND tc.`year` =".$this->get_year();
			$get_cur = $this->db->query($get_cur);
			$query_log = "SELECT * FROM ".$db.".logros_estandares ".
								" WHERE id_docente=".$this->get_parent().
								" AND id_asig=".$asig." AND year=".$this->get_year()." AND periodo=".$periodo.
								" AND id_grado='".$grado."' ORDER BY tipo, id_competencia, id_escala";	
			$query_log		= $this->db->query($query_log);	
			if ($get_cur->num_rows() > 0 AND $query_log->num_rows() > 0){
				foreach($get_cur->result_array() as $curkey => $curvalue){
					$curso	   = $curvalue['id'];
					$query_notas	= "SELECT tn.id,".$filas.",tn.final,
							  tn.id_escala,tm.id id_matric FROM ".$table_notas." AS tn 
							  LEFT JOIN ".$db.".cursos AS tc ON (tn.id_curso = tc.id AND tn.year=tc.year)
							  LEFT JOIN ".$db.".student_enrollment AS tm ON tn.id_matric=tm.id 
							  WHERE tn.year=".$this->get_year().
							  " AND tn.id_curso=".$curso." AND tn.periodo='".$periodo.
							  "' AND tc.id=".$curso." AND tc.year =".$this->get_year().
							  " AND tm.id_grade='".$grado."' AND tm.id_state=2 AND tm.year=".$this->get_year();						
					$query_notas 	= $this->db->query($query_notas);									
					if ($query_notas) {						
						if($query_notas->num_rows() > 0){							
							$this->trans_start(); // Establecemos una transacción							
							/**
							*  Se eliminan, para evitar conflictos de duplicidad, los logros e indicadores 
							* que se hallan insertado a los estudiantes.
							*/							
							foreach($query_notas->result_array() as $ckey => $cvalue){								
								$id_nota		= $cvalue['id'];
								reset($query_log);
								foreach($query_log->result_array() as $fkey => $fvalue){								
									$id_del_log	= $fvalue['id'];
									$estado_del	= $fvalue['estado'];									
									if ($estado_del == 1 OR $estado_del == 2) {
										$query_delete 	= "DELETE FROM ".$table_log.
										" WHERE id_nota=".$id_nota." AND id_logro_estandar=".$id_del_log ;				
										$query_delete	= $this->db->query($query_delete);
									}							
								}						
							}							
							/**
							* Recorremos el array con los datos de la tabla con los logros e indicadores
							* 
							*/
							reset($query_notas);
							foreach($query_notas->result_array() as $nkey => $nvalue){
								$id_nota			= $nvalue['id'];
								$id_desempeno_nota	= $nvalue['id_escala'];								
								/**
								* Recorremos el array que contiene el id de las notas insertadas a los estudiantes
								* 
								*/
								reset($query_log);
								foreach($query_log->result_array() as $key => $value){	
									$id_logro		= $value['id'];
									$estado			= $value['estado'];
									$id_desempeno	= $value['id_escala'];
									$id_competencia	= $value['id_competencia'];								
									if ( $proceso == 3) { //Valores para procesos por competencias 
										if ($id_competencia > 0 AND $estado == 1) {
											$x_campo				= 'prom'.strval($id_competencia);
											$nota_campo				= $nvalue[$x_campo];					
											$id_desempeno_nota		= $this->get_desempeños_id($nota_campo,$grado);
										}							
									}		
									
									//print_r($nota_campo);
									if($id_desempeno_nota > 0){										
										switch($estado){
											case 1 : // Asignar segun desempeño											
												if ($id_desempeno === $id_desempeno_nota) {
													$query	= "INSERT INTO ".$table_log.
													" (id_nota,id_logro_estandar) VALUES ('".
													$id_nota."','".$id_logro."')" ;										
													$this->db->query($query);
												}
												break;
											case 2 : // Asigntar sin tener en cuenta el desempeño
												$query	= "INSERT INTO ".$table_log.
												" (id_nota,id_logro_estandar) VALUES ('".
												$id_nota."','".$id_logro."')" ;											
												$this->db->query($query);											
											break;
										}
									}else{										
										if($estado == 2){
											$query	= "INSERT INTO ".$table_log.
											" (id_nota,id_logro_estandar) VALUES ('".
											$id_nota."','".$id_logro."')" ;											
											$this->db->query($query);
										}
										
									}
								}	
							}				
							$this->trans_complete();	// Ejecutamos la transacción		
						}			
					}
				}				
			}
		}
	}
	
	/**
	* Funcion que retorna el query de la tabla sedes
	* 
	* @return
	*/
	public function get_select_sedes() {
		$this->db_limit();	
			
		$id_inst  = $this->get_id_school();
		$param 	   = array(
			$id_inst
		);
		
		$query = "SELECT * FROM sedes ";
		
		$where = "id_inst = ? ";
		
		return $this->get_query_param($this->limit_min,$this->limit_max,$query,$where,$param,"",FALSE);
	}
	
	
	public function get_notas_save ($grado,$fieldslist,$periodo,$curso,$jorn,$sede,$grupo,$asig){
		if($this->control_date($periodo,$grado)){
			$table	= $this->tabla_notas($grado);			
			$request	= $this->updateData($table,json_decode($fieldslist));
			$this->insert_log_notas($grado,$curso,$jorn,$sede,$grupo,$periodo,$asig);
		}else{
			$request	= $this->control_date_msg();
		}
		return	$request;
	}
	
	/**
	* Funcion que retorna el query de las dimensiones o competencias
	* escolares
	* @param INT $id_grado - Codido del grado
	* 
	* @return Query
	*/
	
	public function competencias($id_grado) {
		$this->db_limit();
				
		$id 	= $this->get_id_school();
		$year	= $this->get_year();
		$db		= $this->get_db_name();		
		
		$this->db->select('t1.id_pk,t1.id,t1.competencia,t1.porcentaje,t1.year');
		$this->db->from($db.'.competencias AS t1');
		$this->db->join($db.'.grados_agrupados AS t2', 't1.id_grado_agrupado=t2.id', 'left');
		$this->db->join($db.'.aux_grados_agrupados AS t3', 't3.id_grado_agrupado=t2.id', 'left');
		$this->db->where('t1.year', $year);
		$this->db->where('t3.id_grado', $id_grado);
		$this->db->where('t1.calificable', 1);
		$this->db->where('t1.id > 0');
		$this->db->order_by('t1.id');		
		$query 	= $this->db->get();
				
		$this->db->select('t1.id, t1.id_escala, t1.desde, t1.hasta,t1.reprueba,t4.color, t4.nombre_escala, 
				  t4.mensaje, t4.abrev');
		$this->db->from($db.'.desempeños AS t1');
		$this->db->join($db.'.grados_agrupados AS t2', 't1.id_grado_agrupado=t2.id', 'left');
		$this->db->join($db.'.aux_grados_agrupados AS t3', 't3.id_grado_agrupado=t2.id', 'left');
		$this->db->join($db.'.escala_nacional AS t4', 't1.id_escala=t4.id', 'left');
		$this->db->where('t1.year', $year);
		$this->db->where('t3.id_grado', $id_grado);
		$this->db->order_by('t1.id');
		$query1	= $this->db->get();
		
		$this->db->select("t1.*, CONCAT('n',numero_column) name_column");
		$this->db->from($db.'.columnas_notas_competencias AS t1');
		$this->db->join($db.'.competencias AS tc', 't1.id_competencia = tc.id_pk', 'left');
		$this->db->join($db.'.grados_agrupados AS t2', 'tc.id_grado_agrupado=t2.id', 'left');
		$this->db->join($db.'.aux_grados_agrupados AS t3', 't3.id_grado_agrupado=t2.id', 'left');
		$this->db->where('tc.year', $year);
		$this->db->where('t3.id_grado', $id_grado);
		$this->db->order_by('t1.id_competencia, t1.tipo, t1.numero_column');		
		$query2	= $this->db->get();	
		
		$this->db->select('tc.*');
		$this->db->from($db.'.config001 AS tc');
		$this->db->join($db.'.grados_agrupados AS t2', 'tc.id_grupo_grados=t2.id', 'left');
		$this->db->join($db.'.aux_grados_agrupados AS t3', 't3.id_grado_agrupado=t2.id', 'left');
		$this->db->where('tc.year', $year);
		$this->db->where('t3.id_grado', $id_grado);				
		$query3	= $this->db->get();
		
		if ($query AND $query1 AND $query2 AND $query3) {			
			$request = array(
				'success'       	=>TRUE,
				'records_comp'		=> $query->result_array(),
				'records_des'		=> $query1->result_array(),
				'records_colum'		=> $query2->result_array(),
				'records_config' 	=> $query3->result_array()
			);			
			/**
			* Respuesta en formato Json
			*/
			$request = json_encode($request);					
		}else{			
			$request = $this->get_error();
		}		
		return $request;		
	}
	
	/**
	* Funcion que retorna el query de los logros e indicadores de desempeño
	* @param STRING $cod_grado - Código del grado
	* @param STRING $id_asig   - Código de la asginatura
	* @param STRING $periodo   - Periodo académico
	* 
	* @return
	*/
	
	public function get_logros_indicadores($cod_grado,$id_asig,$periodo){
		
		$query1 = "SELECT `id_p`, `id_inst`, `id`, `indicador`, `id_logro`, `id_docente`, 
		`cod_grado`, `id_asig`, `year`, 
		`periodo`, `tipo_desempeño`, `estado`, `asignacion`, `tipo` FROM indicadores ";
		
		$where1 = "id_inst= ? AND id_docente= ? AND cod_grado= ? AND id_asig= ? AND year= ? AND periodo= ?
			ORDER BY periodo, id";
		
		$query2 = "SELECT `id_p`, `id_inst`, `id`, `logro`, `id_docente`, `cod_grado`, `id_asig`, `year`,
		 `periodo`,`tipo_desempeño`, `estado`, `asignacion`, `tipo` FROM logros ";
		
		$where2 = "id_inst= ? AND id_docente= ? AND cod_grado= ? AND id_asig= ? AND year= ? AND periodo= ?
			ORDER BY periodo, id";
					
		$param = array(
			$this->get_id_school(),
			$this->get_parent(),
			$cod_grado,
			$id_asig,
			$this->get_year(),
			$periodo
		);
		
				
		if ($this->control_date($periodo,$cod_grado)) {
			$query  = $this->db->query($query1.' WHERE '.$where1, $param);
			
			$query1 = $this->db->query($query2.' WHERE '.$where2, $param);
		
			if ($query AND $query1){
				
				$fields_indicadores 	= NULL;
				
				$fields_logros			= NULL;
				
			 	foreach ($query->result_array() as $field)
			 	{
					$fields_indicadores [] = $field;
				}
				
				foreach ($query1->result_array() as $field)
			 	{
					$fields_logros [] = $field;
				}
				
				
				$request = array(
					'success'       => TRUE,
					'records'	=> $fields_indicadores,
					'fields_lis2'	=> $fields_logros
				);
				
				/**
				* Respuesta en formato Json
				*/
				$request = json_encode($request);
				
			}else{
				$request = $this->get_error();
			}
		}else{
			$request = $this->control_date_msg();
		}
		
		return $request;
	}
	
	
	public function get_notas($type,$grado,$curso,$jorn,$sede,$grupo,$periodo,$sexo) {
		$db    	= $this->get_db_name();
		$table 	= $db.".".$this->tabla_notas($grado);
		$year	= $this->get_year();
		$where	= '';

		if ($sexo != 'MX') {
			$where = " AND tx.abrev_sexo ='".$sexo."'";
		}					
		$query	= "INSERT INTO ".$table." (id_matric, year, periodo, id_curso)
			SELECT tm.id, tm.year, ".$periodo.", ".$curso."
			FROM ".$db.".student_enrollment AS tm 
			LEFT JOIN ".$db.".inscripciones AS te on tm.id_student = te.id
			LEFT JOIN ".$db.".sexo AS tx ON te.id_sexo = tx.id
			WHERE tm.id_headquarters = ".$sede." AND tm.id_study_day = ".$jorn." AND 
			tm.id_grade = ".$grado." AND tm.id_group = '".$grupo."' AND tm.year = ".$year." AND 
			tm.id_state = 2 ".$where." AND NOT EXISTS(
			SELECT a.id_curso, a.id_matric, a.year, a.periodo
			FROM ".$table." AS a 
			WHERE a.id_curso = ".$curso." AND a.id_matric = tm.id  AND a.periodo = ".$periodo.");";
		$this->db->query($query);
			
		$param	= array(
			$curso,
			$periodo,
			$this->get_year(),
			$grado,
			$sexo
		);
		
		$call	= "sp_select_notas_academicas_curso  (?, ?, ?, ?, ? )";
			
		echo $this->getExecute($call,$param);
	}
	
	public function get_select_desempeños() {
	
		$query 	= "SELECT id, id_inst, desempeño As desempeno,desde, hasta,abrev,year FROM desempeños ";
		$where 	= "year= ? AND id_inst= ?";
		
		$param	= array(
			$this->get_year(),
			$this->get_id_school()
		);
		
		return $this->get_query_param($this->limit_min,$this->limit_max,$query,$where,$param,"",FALSE);
	}
}
