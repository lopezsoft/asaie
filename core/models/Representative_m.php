<?php
defined('BASEPATH') OR exit('No direct script access allowed');
class Representative_m extends SME_Model {
	function __construct() {
		parent::__construct();
	}

	function getStudentData($enrollment_id) {
		$db		= $this->get_db_name();
		/**
		* Se obtiene la información de matricula del estudiante.
		*/

		$this->db->where('id', $enrollment_id);
		$this->db->where('year', $this->get_year());
		$query		= $this->db->get("{$db}.student_enrollment");


		$queryTable	= "SELECT a.*, b.grade_id FROM {$db}.tp_polling_stations AS a
						LEFT JOIN {$db}.tp_degrees_per_table AS b ON b.polling_station_id = a.id
						WHERE b.polling_station_id = a.id AND a.year = {$this->get_year()} 
						AND b.grade_id = {$query->row()->id_grade} AND a.state = 2 LIMIT 1";
		$queryTable	= $this->db->query($queryTable);

		return $this->get_request_select($queryTable->result_array(), count($queryTable->result_array()));
	}
	
		
	/**
	 * Guarda o cambia la imagen del candidato
	 *
	 * @param  mixed $file
	 * @param  mixed $type
	 * @param  mixed $table
	 * @param  mixed $id
	 * @return void
	 */
	public function uploadCandidatePhoto($file,$type,$table,$id){
		
		$db		= $this->get_db_name();

		$path	= SCHOOL_DIRECTORY.PATH_DELIM.$this->school_folder.PATH_DELIM.UP_FOLDER.PATH_DELIM.REPRESENTATIVE_FOLDERS.PATH_DELIM."{$id}";
        		
		$request= $this->upload_file($file, $path);

		$image	= json_decode($request);
				
		$query	= "UPDATE {$db}.{$table} SET image = '{$image->foto}' WHERE id={$id} LIMIT 1";  
		$query	= $this->db->query($query);	

		return $request;
	}
	
		
	/**
	 * Grados por mesa
	 *
	 * @param  mixed $id
	 * @return void
	 */
	public function getDegreesPerTable($id) {
		$db		= $this->get_db_name();
		$query	= "SELECT tp.*, tm.table_name, RTRIM(tg.grado) grado
				FROM {$db}.tp_degrees_per_table AS tp 
				LEFT JOIN {$db}.tp_polling_stations AS tm ON tp.polling_station_id = tm.id
				LEFT JOIN {$db}.grados AS tg ON tp.grade_id = tg.id
				WHERE tp.polling_station_id = ".$id;
		
		$request 	= $this->db->query($query);
		$request	= $this->get_request_select($request->result_array(), count($request->result_array()));
		return $request;
	}
	
		
	/**
	 * Guarda los votos
	 *
	 * @param  mixed $enrollment_id
	 * @param  mixed $id
	 * @param  mixed $candidate_id
	 * @param  mixed $polling_station_id
	 * @param  mixed $candidacy_id
	 * @param  mixed $type
	 * @return void
	 */

	public function insertVotes ($enrollment_id,$id, $candidate_id, $polling_station_id, $candidacy_id, $type) {
		$db		= $this->get_db_name();
		/**
		* Se verifica si el votante se encuentra matriculado.
		*/

		$this->db->where('id', $enrollment_id);
		$this->db->where('year', $this->get_year());
		$query		= $this->db->get("{$db}.student_enrollment");
			
		if ($query) {
			
			if ($query->num_rows() > 0) {
				
				$this->db->where('id', $polling_station_id);
				$this->db->where('year', $this->get_year());
				$queryMesa	= $this->db->get("{$db}.tp_polling_stations");
				
				if ($queryMesa) {				
					// Se verifica si la mesa está activa 
					if ($queryMesa->row()->state == 2) {
						
						$this->db->where('year', $this->get_year());
						$this->db->where('enrollment_id', $enrollment_id);
						$this->db->where('candidacy_id', $candidacy_id);

						$queryVoto	= $this->db->get("{$db}.tp_votes");

						
						/**
						 * Se verifica si el votante no ha relizado el proceso del voto para evitar
						 * duplicidad de votos y se realiza el proceso de insert.
						 */
						
						if($queryVoto->num_rows() == 0){
							
							if($type	== 1 ) { // White vote
								$data	= [
									"year"					=> $this->get_year(),
									"white_vote_id"			=> $candidate_id,
									"enrollment_id"			=> $enrollment_id,
									"candidacy_id"			=> $candidacy_id,
									"polling_station_id"	=> $polling_station_id,
								];
								
								$this->db->insert("{$db}.tp_aux_white_vote", $data);
							}else {
								$data	= [
									"year"					=> $this->get_year(),
									"candidate_id"			=> $candidate_id,
									"enrollment_id"			=> $enrollment_id,
									"candidacy_id"			=> $candidacy_id,
									"polling_station_id"	=> $polling_station_id,
								];
								
								$this->db->insert("{$db}.tp_aux_candidate_votes", $data);
							}

							$data	= [
								"year"					=> $this->get_year(),
								"enrollment_id"			=> $enrollment_id,
								"candidacy_id"			=> $candidacy_id,
								"attempts"				=> 1,
								"state"					=> 1,
							];
							
							$this->db->insert("{$db}.tp_votes", $data);

							$request = array(
								'success'   => TRUE,
								'state'		=> 1 // Se realizó el proceso de voto correctamente
							);
							$request	= json_encode($request);
							
						}else{ // Si el estudiante ya habia relizado el voto y lo intenta de nuevo
							
							$query	= "UPDATE {$db}.tp_votes SET attempts = attempts + 1 WHERE id = {$queryVoto->row()->id} LIMIT 1";
							$this->db->query($query);

							$request = array(
								'success'   => TRUE,
								'state'		=> 0 // Se realizó el proceso de voto correctamente
							);
							$request	= json_encode($request);
								
						}
					}else{
						$request = array(
								'success'  	=> TRUE,
								'state'		=> 3 // Mesa cerrada
							);
						$request	= json_encode($request);
					}
				}else{
					$request	= $this->get_error();
				}
			}else{
								
				$request = array(
					'success'  	=> TRUE,
					'state'		=> 2 // No se encuentra registros de matricula del estudiantes
				);
				
				$request	= json_encode($request);
			}
		}else{
			
			$request	= $this->get_error();
			
		}
		
		return $request;
	}
	
	
	public function get_select_estudiantes ($fields,$qSearch,$type) {
		$year	= $this->get_year();
		$db		= $this->get_db_name();
		$fl		= json_decode($fields);
		$extra	= '';
		$count	= 0;
		if(is_array($fl)){
			$count	= count($fl);
		}
		if ($count > 0 AND strlen($qSearch) > 0){
			$arraySearch = explode(' ',$qSearch);
			$index		 = array_search('nombres',$fl);
			unset($fl[$index]);
			array_unshift($fl,'ti.apellido1','ti.apellido2','ti.nombre1','ti.nombre2');
			$count	= count($fl);
			$index		= array_search('estado_mat',$fl);
			if ($index){
				$fl[$index] = 'tes.name_state';	
			}					
			$index		= array_search('sede',$fl);
			if ($index){
				$fl[$index] = 'ts.nombre_sede';	
			}
			$index		= array_search('grado',$fl);
			if ($index){
				$fl[$index] = 'tg.grado';	
			}
			$index		= array_search('grupo',$fl);
			if ($index){
				$fl[$index] = 'tm.id_group';	
			}
			if ($count == 1){
				$extra  = " AND ".$fl[0]." REGEXP '".$qSearch."'";
			}else{
				$count	= count($arraySearch);
				if($count > 1){
					$search1 = $arraySearch[0];
					$search2 = $arraySearch[1];
					foreach($fl as $key => $value){						
						foreach($fl as $keyUP => $valueUP){
							if ($valueUP <> $value){
								$extra  = $value." REGEXP '".$search1."' AND ".
								$valueUP." REGEXP '".$search2."'";
								$this->db->select($value);
								$this->db->from($db.'.student_enrollment AS tm');
								$this->db->join($db.'.inscripciones AS ti', 'tm.id_student = ti.id', 'left');
								$this->db->join($db.'.grados AS tg', 'tm.id_grade = tg.id ', 'left');
								$this->db->join($db.'.sedes AS ts', 'tm.id_headquarters = ts.ID ', 'left');
								$this->db->join($db.'.jornadas AS tj', 'tm.id_study_day = tj.cod_jorn', 'left');
								$this->db->join($db.'.registration_status AS tes', 'tm.id_state = tes.id', 'left');
								$this->db->where('tm.year', $year);
								$this->db->where('tm.id_state > 1');
								$this->db->where($extra);
								$this->db->limit(1);

								$query	= $this->db->get();
								if ($query->num_rows() > 0){
									break;
								}
							}
						}
						if ($query->num_rows() > 0){
							break;
						}
					}
				}else{
					foreach($fl as $key => $value){
						$extra  = $value." REGEXP '".$qSearch."'";
						$this->db->select($value);
						$this->db->from($db.'.student_enrollment AS tm');
						$this->db->join($db.'.inscripciones AS ti', 'tm.id_student = ti.id', 'left');
						$this->db->join($db.'.grados AS tg', 'tm.id_grade = tg.id ', 'left');
						$this->db->join($db.'.sedes AS ts', 'tm.id_headquarters = ts.ID ', 'left');
						$this->db->join($db.'.jornadas AS tj', 'tm.id_study_day = tj.cod_jorn', 'left');
						$this->db->join($db.'.registration_status AS tes', 'tm.id_state = tes.id', 'left');
						$this->db->where('tm.year', $year);
						$this->db->where('tm.id_state > 1');
						$this->db->where($extra);
						$this->db->limit(1);
						
						$query	= $this->db->get();
						if ($query->num_rows() > 0){
							break;
						}
					}		
				}			
			}
		}	

		
		$this->db->select("tm.*, CONCAT(rtrim(ti.apellido1),' ',rtrim(ti.apellido2),' ',
					rtrim(ti.nombre1),' ',rtrim(ti.nombre2)) AS nombres,
					rtrim(tg.grado) AS grado, rtrim(ts.nombre_sede) AS sede, ti.foto, ti.mime,
					RTRIM(tj.jornada) AS jornada, RTRIM(tes.name_state) estado_mat");
		$this->db->from($db.'.student_enrollment AS tm');
		$this->db->join($db.'.inscripciones AS ti', 'tm.id_student = ti.id', 'left');
		$this->db->join($db.'.grados AS tg', 'tm.id_grade = tg.id ', 'left');
		$this->db->join($db.'.sedes AS ts', 'tm.id_headquarters = ts.ID ', 'left');
		$this->db->join($db.'.jornadas AS tj', 'tm.id_study_day = tj.cod_jorn', 'left');
		$this->db->join($db.'.registration_status AS tes', 'tm.id_state = tes.id', 'left');
		$this->db->where('tm.year', $year);
		$this->db->where('tm.id_state > 1');
		if(!empty($extra)){
			$this->db->where($extra);
		}
		$this->db->order_by('nombres, tm.id_grade , tm.id_group');		
		$this->db->limit($this->limit_max,$this->limit_min);
		$query	= $this->db->get();	

		$this->db->select("COUNT(tm.id) total");
		$this->db->from($db.'.student_enrollment AS tm');
		$this->db->join($db.'.inscripciones AS ti', 'tm.id_student = ti.id', 'left');
		$this->db->join($db.'.grados AS tg', 'tm.id_grade = tg.id ', 'left');
		$this->db->join($db.'.sedes AS ts', 'tm.id_headquarters = ts.ID ', 'left');
		$this->db->join($db.'.jornadas AS tj', 'tm.id_study_day = tj.cod_jorn', 'left');
		$this->db->join($db.'.registration_status AS tes', 'tm.id_state = tes.id', 'left');
		$this->db->where('tm.year', $year);
		$this->db->where('tm.id_state > 1');
		if(!empty($extra)){
			$this->db->where($extra);
		}
		$tbl	= $this->db->get();	

		return $this->getJsonResponse($query->result_array(),$tbl->row('total'));
	}
	
		
	/**
	 * Retorna la información de los candidatos
	 *
	 * @param  mixed $type
	 * @param  mixed $polingStationId
	 * @return void
	 */
	public function getCandidates($type, $polingStationId) {
		$db			= $this->get_db_name();
		if($type == 2){ // Candidatos
			$query	= "SELECT tp.*, tc.candidacy_name, tm.id_grade AS grade_id, tm.id_group AS group_name,
					tm.year, RTRIM(tg.grado) AS grade,
					CONCAT(rtrim(ti.apellido1),' ',rtrim(ti.apellido2),' ',rtrim(ti.nombre1),' ',rtrim(ti.nombre2)) AS names
					FROM {$db}.tp_candidates AS tp
					LEFT JOIN {$db}.student_enrollment AS tm ON tp.enrollment_id = tm.id 
					LEFT JOIN {$db}.inscripciones AS ti ON tm.id_student   = ti.id 
					LEFT JOIN {$db}.tp_candidacies AS tc ON tp.candidacy_id = tc.id 
					LEFT JOIN {$db}.grados AS tg ON tm.id_grade   = tg.id
					WHERE tp.year ={$this->get_year()} AND tm.id_state = 2 AND tm.year ={$this->get_year()} ORDER BY candidacy_name,id";
		}else if($type == 1){ // Voto en blanco
		 	$query	= "SELECT tp.*, tc.candidacy_name
						FROM {$db}.tp_white_vote AS tp
						LEFT JOIN {$db}.tp_candidacies AS tc ON tp.candidacy_id = tc.id 
						WHERE tp.year ={$this->get_year()} ORDER BY candidacy_name,id";
		 }else{
			$query	= "(SELECT RAND() AS id, tp.id AS candidate_id, tp.enrollment_id, tp.candidacy_id, tp.number, tp.image, tp.`type`,
						tc.candidacy_name,tm.id_grade, tm.id_group AS group_name,RTRIM(tg.grado) AS grado,
						CONCAT(RTRIM(ti.apellido1),' ',RTRIM(ti.apellido2),' ',RTRIM(ti.nombre1),' ',
						RTRIM(ti.nombre2)) AS names 
						FROM ${db}.tp_candidates AS tp
						LEFT JOIN ${db}.student_enrollment AS tm ON tp.enrollment_id = tm.id 
						LEFT JOIN ${db}.inscripciones AS ti ON tm.id_student   = ti.id 
						LEFT JOIN ${db}.tp_candidacies AS tc ON tp.candidacy_id = tc.id 
						LEFT JOIN ${db}.grados AS tg ON tm.id_grade = tg.id
						WHERE tp.year = {$this->get_year()} AND  tm.id_state = 2 AND tm.year = {$this->get_year()} AND 
						EXISTS(
							SELECT aa.* FROM {$db}.tp_degrees_per_table AS aa 
							LEFT JOIN {$db}.tp_polling_stations AS bb ON aa.polling_station_id = bb.id
							WHERE aa.polling_station_id = {$polingStationId} AND aa.grade_id = tg.id AND bb.year = {$this->get_year()}
						)
					) 
					UNION 
					(SELECT RAND() AS id, tp.id AS candidate_id, 0 AS enrollment_id, tp.candidacy_id, '00' AS number, tp.image, tp.`type`,
						tc.candidacy_name, 0 AS id_grade, '00' AS group_name, '' AS grado,
						tp.names
						FROM ${db}.tp_white_vote AS tp
						LEFT JOIN ${db}.tp_candidacies AS tc ON tp.candidacy_id =tc.id 
						WHERE tp.year	= {$this->get_year()}
					) ORDER BY candidacy_id,id;";		
		}
		
		$query		= $this->db->query($query);
		$request 	= $this->get_request_select($query->result_array(), count($query->result_array()));
		
		return $request;
	}
	
	public function getJuries($id){
		$request = $this->getTable('tp_juries', 0, 30, '', ['poling_station_id'	=> $id]);		
		return	$request;		
	}
	
	public function getTableHeadquarters($id) {
		$db		= $this->get_db_name();
		$query	= "SELECT tp.*, rtrim(ts.nombre_sede) AS sede 
					FROM {$db}.tp_table_headquarters AS tp 
					LEFT JOIN {$db}.sedes AS ts ON tp.headquarter_id = ts.id 
					WHERE tp.polling_station_id = ".$id;
		
		$request 	= $this->db->query($query);
		$request	= $this->get_request_select($request->result_array(), count($request->result_array()));
		return $request;
	}
}
