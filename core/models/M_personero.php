<?php
defined('BASEPATH') OR exit('No direct script access allowed');
class M_personero extends SME_Model {
	function __construct() {
		parent::__construct();
	}
	
	public function insert_foto_candidato($file,$type,$table,$id){
		
		$fileName = $file['name'];
        $fileTmp  = $file['tmp_name'];
        $filetype = $file['type'];		
        
        $foto	= $_SERVER["DOCUMENT_ROOT"]."/uploads/personero/".basename($fileName);
        		
		if (is_uploaded_file($fileTmp)){
			if (move_uploaded_file($fileTmp,$foto)){
				$img  = fread(fopen($foto,"r"),filesize($foto));
				$foto = base64_encode($img);
				$foto	= "/uploads/personero/".basename($fileName);
				
				$query	= "UPDATE ".$table." SET foto='".$foto.
					"',mime='".$filetype."' WHERE id=".$id;
							 
		
				$query	= $this->db->query($query);
				
				if ($query) {
					$request = json_encode(
						array(
							'success'	=> true,
							'foto'		=> $foto,
							'mime'		=> $filetype
						)
					);
				}else{
					$request = $this->M_sql->get_error();
				}
				
			}else{
				$request = $this->M_sql->get_error();
			}
			
		}else{
			$request = $this->M_sql->get_error();
		}
		
		return $request;
		
	}
	
	
	public function insert_grados_sedes_mesa($fields,$idm) {
		
		$extra	= array(
			'id_sede_mesa'	=> $idm
		);
		
		$id	=	$this->insert_primary('tp_grados_sedes_mesa',$fields,$extra,TRUE);
		
		$query	= "SELECT tp.*, rtrim(ts.nombre_sede) AS sede, tm.id_mesa, RTRIM(tg.grado) grado
				FROM tp_grados_sedes_mesa AS tp 
				LEFT JOIN tp_sedes_mesa AS tm ON tp.id_sede_mesa = tm.id
				LEFT JOIN sedes AS ts ON tm.id_headquarters = ts.ID 
				LEFT JOIN grados AS tg ON tp.cod_grado = tg.cod_grado
				WHERE tp.id = ".$id." AND ts.id_inst =".$this->get_id_school();
					
		$rquest	= $this->get_query(0,1,$query,FALSE);
		
		return	$rquest;
	}
	
	public function get_select_grados_sedes_mesa($id) {
		
		$query	 = "SELECT tp.*, rtrim(ts.nombre_sede) AS sede, tm.id_mesa, RTRIM(tg.grado) grado
				FROM tp_grados_sedes_mesa AS tp 
				LEFT JOIN tp_sedes_mesa AS tm ON tp.id_sede_mesa = tm.id
				LEFT JOIN sedes AS ts ON tm.id_headquarters = ts.ID 
				LEFT JOIN grados AS tg ON tp.cod_grado = tg.cod_grado
				WHERE tp.id_sede_mesa = ".$id." AND ts.id_inst =".$this->get_id_school();
		
		$request = $this->get_query($this->limit_min,$this->limit_max,$query,FALSE);
		
		return $request;
	}
	
	public function insert_votos ($id_matric,$id_candidato,$id_mesa,$estado,$type) {
		
		/**
		* Se verifica si el votante se encuentra matriculado.
		*/
		
		$queryMat	= "SELECT id_matric FROM student_enrollment WHERE id_matric='".$id_matric.
						"' AND id_inst=".$this->get_id_school()." and año=".$this->get_year();
		$queryMat	= $this->db->query($queryMat);			
			
		if ($queryMat) {
			
			if ($queryMat->num_rows() > 0) {
				
				$queryMesa	= "SELECT * FROM tp_mesas_votacion WHERE id=".$id_mesa." AND id_inst=".$this->get_id_school();
				$queryMesa	= $this->db->query($queryMesa);
				
				if ($queryMesa) {				
					// Se verifica si la mesa está activa 
					if ($queryMesa->row()->estado == 1) {
						
						$queryVoto	= "SELECT * FROM tp_votos WHERE id_matric='".$id_matric.
						"' AND id_inst=".$this->get_id_school()." and año=".$this->get_year().
						" AND tipo=".$type;
						$queryVoto	= $this->db->query($queryVoto);
						
						/**
						* Se verifica si el votante no ha relizado el proceso del voto para evitar
						* duplicidad de votos y se realiza el proceso de insert.
						*/
						
						if($queryVoto->num_rows() == 0){
							
							$insert	= "INSERT INTO tp_votos (id_inst,id_matric,id_candidato,año,estado,
										intentos,id_mesa,tipo) 
										VALUES(".$this->get_id_school().",".$id_matric.",".$id_candidato.
										",".$this->get_year().",1,1,".$id_mesa.",".$type.")";
							$insert	= $this->db->query($insert);
							
							if($insert){
								
								$request = array(
									'success'       =>TRUE,
									'estado'		=>1 // Se realizó el proceso de voto correctamente
								);
								$request	= json_encode($request);
							}else{
								$request	= $this->get_error();
							}
							
						}else{ // Si el estudiante ya habia relizado el voto y lo intenta de nuevo
							$update	= "UPDATE tp_votos SET intentos=intentos+1, estado=1, id_mesa="
									.$id_mesa." WHERE id_matric='".$id_matric."' AND tipo=".$type.
									" AND id_inst=".$this->get_id_school();
										
							//$update = $this->db->query($update);
								
							$request = array(
								'success'       =>TRUE,
								'estado'		=>0 // Se realizó el proceso de voto correctamente
							);
							$request	= json_encode($request);
								
						}
					}else{
						$request = array(
								'success'       => TRUE,
								'estado'		=> 3 // Mesa cerrada
							);
						$request	= json_encode($request);
					}
				}else{
					$request	= $this->get_error();
				}
			}else{
								
				$request = array(
					'success'       =>TRUE,
					'estado'		=>2 // No se encuentra registros de matricula del estudiantes
				);
				
				$request	= json_encode($request);
			}
		}else{
			
			$request	= $this->get_error();
			
		}
		
		return $request;
	}
	
	public function get_update_candidatos($field) {
				
		$id	= $this->get_update_primary('tp_candidatos',$field,TRUE);
		
		$query	= "SELECT tp.*, tm.cod_grado, tm.id_group, tm.year ,
					CONCAT(rtrim(ti.apellido1),' ',rtrim(ti.apellido2),' ',rtrim(ti.nombre1),' ',
					rtrim(ti.nombre2)) AS nombres, ti.foto FROM tp_candidatos AS tp
					LEFT JOIN student_enrollment AS tm ON tp.id_matric = tm.id 
					LEFT JOIN inscripciones AS ti ON tm.id_student   = ti.id";
		
		$where	= "tp.id = ?";
		
		$param	= array(
			$id
		);
		
		$request = $this->get_query_param($this->limit_min,$this->limit_max,$query,$where,$param);
		
		return $request;
	}
	
	public function insert_candidatos($field,$table,$type) {
		
		$blob = "";

		
		$extra = array(
			'id_inst'	=> $this->get_id_school()
		);
		
		
		if($type == 1){ // Voto en blanco
		
			$extra = array(
				'id_inst'	=> $this->get_id_school(),
				'año'		=> $this->get_year(),
				'nombres'	=> 'VOTO EN BLANCO',
				'foto'		=> "/resources/img/avatars/empty.png",
				'gradp'		=> '00',
				'grupo'		=> '00',
				'mime'		=> 'image/png'
			);
			
			$id	= $this->insert_primary($table,$field,$extra,TRUE);
						
			$query	= "SELECT tp.`id`, tp.`id_inst`, tp.`id_matric`, tp.`nom_candidato`, tp.`numero`, 
					 tc.candidatura AS estados, tp.estado,tp.candidatura,
					 tp.`cod_grado`, tp.`grupo`, tp.`año`,'00' AS grado, tp.`nombres`, 
					 tp.`foto`, tp.`mime`, tp.tipo FROM tp_voto_blanco AS tp
					 LEFT JOIN tp_candidaturas AS tc ON tp.candidatura=tc.id";
		
			$where	= "tc.id_inst= ? AND tp.año= ? AND tp.id = ? ";
			
			$param	= array(
				$this->get_id_school(),
				$this->get_year(),
				$id
			);
			
			$request = $this->get_query_param($this->limit_min,$this->limit_max,$query,$where,$param,"",FALSE);
			
		}else{
			
			$extra = array(
				'id_inst'	=> $this->get_id_school(),
				'foto'		=> "/resources/img/avatars/unknown.png",
				'mime'		=> 'image/png'
			);
			
			$id	= $this->insert_primary($table,$field,$extra,TRUE);
			
			$query	= "SELECT tp.id, tp.id_inst, tp.id_matric, tp.nom_candidato, tp.numero, 
					tc.candidatura AS estados, tp.estado, tp.candidatura,
					tm.cod_grado, tm.id_group, tm.year , RTRIM(tg.grado) AS grado,
					CONCAT(rtrim(ti.apellido1),' ',rtrim(ti.apellido2),' ',rtrim(ti.nombre1),' ',
					rtrim(ti.nombre2)) AS nombres, tp.foto, tp.mime, tp.tipo FROM tp_candidatos AS tp
					LEFT JOIN student_enrollment AS tm ON tp.id_matric = tm.id 
					LEFT JOIN inscripciones AS ti ON tm.id_student   = ti.id 
					LEFT JOIN tp_candidaturas AS tc ON tp.candidatura = tc.id 
					LEFT JOIN grados AS tg ON tm.cod_grado = tg.cod_grado";
		
			$where	= "tm.estado = 2 AND tm.id_inst= ? AND tm.year = ? AND tp.id_inst= ? 
						AND tc.id_inst= ? AND tp.id = ? ";
			
			$param	= array(
				$this->get_id_school(),
				$this->get_year(),
				$this->get_id_school(),
				$this->get_id_school(),
				$id
			);
			
			$request = $this->get_query_param($this->limit_min,$this->limit_max,$query,$where,$param,"",FALSE);
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

		return $this->get_request_select($query->result_array(),$tbl->row('total'));
	}
	
	public function get_select_candidatos($type) {
		
		if($type == 2){ // Candidatos
			
			$query	= "SELECT tp.id, tp.id_inst, tp.id_matric, tp.nom_candidato, tp.numero, 
					tc.candidatura AS estados, tp.estado, tp.candidatura,
					tm.id_grade   cod_grado, tm.id_group, tm.year , RTRIM(tg.grado) AS grado,
					CONCAT(rtrim(ti.apellido1),' ',rtrim(ti.apellido2),' ',rtrim(ti.nombre1),' ',
					rtrim(ti.nombre2)) AS nombres, tp.foto, tp.mime, tp.tipo FROM tp_candidatos AS tp
					LEFT JOIN student_enrollment AS tm ON tp.id_matric = tm.id 
					LEFT JOIN inscripciones AS ti ON tm.id_student   = ti.id 
					LEFT JOIN tp_candidaturas AS tc ON tp.candidatura = tc.id 
					LEFT JOIN grados AS tg ON tm.id_grade   = tg.id
					WHERE tm.id_state = 2 AND tm.id_inst=".$this->get_id_school()." AND tm.year ="
					.$this->get_year()." AND tp.id_inst=".$this->get_id_school()." AND tc.id_inst=".$this->get_id_school().
					" ORDER BY candidatura,id";
		}else if($type == 1){ // Voto en blanco
		 	$query	= "SELECT tp.`id`, tp.`id_inst`, tp.`id_matric`, tp.`nom_candidato`, tp.`numero`, 
					 tc.candidatura AS estados, tp.estado,tp.candidatura,
					 tp.`cod_grado`, tp.`grupo`, tp.`año`,'00' AS grado, tp.`nombres`, 
					 tp.`foto`, tp.`mime`, tp.tipo FROM tp_voto_blanco AS tp
					 LEFT JOIN tp_candidaturas AS tc ON tp.candidatura=tc.id 
					 WHERE tc.id_inst=".$this->get_id_school()." AND tp.año=".$this->get_year()."  
					 ORDER BY candidatura,id";
		 }else{
			$query	= "(SELECT tp.id, tp.id_inst, tp.id_matric, tp.nom_candidato, tp.numero, 
					tc.candidatura AS estados, tp.estado, tp.candidatura,
					tm.id_grade   cod_grado, tm.id_group, tm.year , RTRIM(tg.grado) AS grado,
					CONCAT(rtrim(ti.apellido1),' ',rtrim(ti.apellido2),' ',rtrim(ti.nombre1),' ',
					rtrim(ti.nombre2)) AS nombres, tp.foto, tp.mime, tp.tipo FROM tp_candidatos AS tp
					LEFT JOIN student_enrollment AS tm ON tp.id_matric = tm.id 
					LEFT JOIN inscripciones AS ti ON tm.id_student   = ti.id 
					LEFT JOIN tp_candidaturas AS tc ON tp.candidatura = tc.id 
					LEFT JOIN grados AS tg ON tm.id_grade   = tg.id
					WHERE tm.id_state = 2 AND tm.id_inst=".$this->get_id_school()." AND tm.year ="
					.$this->get_year()." AND tp.id_inst=".$this->get_id_school()." AND tc.id_inst=".$this->get_id_school()
					.") UNION ".
					"(SELECT tp.`id`, tp.`id_inst`, tp.`id_matric`, tp.`nom_candidato`, tp.`numero`, 
					 tc.candidatura AS estados, tp.estado,tp.candidatura,
					 tp.`cod_grado`, tp.`grupo`, tp.`año`,'00' AS grado, tp.`nombres`, 
					 tp.`foto`, tp.`mime`, tp.tipo FROM tp_voto_blanco AS tp
					 LEFT JOIN tp_candidaturas AS tc ON tp.candidatura=tc.id 
					 WHERE tc.id_inst=".$this->get_id_school()." AND tp.año=".$this->get_year().")  
					 ORDER BY candidatura,id";		
		}
		
				
		$request = $this->get_query($this->limit_min,$this->limit_max,$query);
		
		return $request;
	}
	
	public function get_select_jurados($id){
		
		$query	= "SELECT * FROM tp_jurados WHERE id_mesa=".$id;
		
		$request = $this->get_query($this->limit_min,$this->limit_max,$query,FALSE);		
		
		return	$request;		
	}
	
	public function insert_sedes_mesa($fields) {
		
		$id	=	$this->insert_primary('tp_sedes_mesa',$fields, NULL,TRUE);
		
		$query	= "SELECT tp.*, rtrim(ts.nombre_sede) AS sede FROM tp_sedes_mesa AS tp 
					LEFT JOIN sedes AS ts ON tp.id_sede=ts.id 
					WHERE tp.id=".$id;
					
		$rquest	= $this->get_query(0,1,$query,FALSE);
		
		return	$rquest;
	}
	
	public function get_update_sedes_mesa($fields) {
	
		$id	= $this->get_update_primary('tp_sedes_mesa',$fields,TRUE);
		
		$query	= "SELECT tp.*, rtrim(ts.nombre_sede) AS sede FROM tp_sedes_mesa AS tp 
					LEFT JOIN sedes AS ts ON tp.id_sede=ts.id 
					WHERE tp.id=".$id;
					
		$rquest	= $this->get_query(0,1,$query,FALSE);
		
		return	$rquest;
	}
	
	public function get_select_sedes_mesa($id) {
		
		$query	 = "SELECT tp.*, rtrim(ts.nombre_sede) AS sede FROM tp_sedes_mesa AS tp 
					LEFT JOIN sedes AS ts ON tp.id_sede=ts.id 
					WHERE tp.id_mesa=".$id;
		
		$request = $this->get_query($this->limit_min,$this->limit_max,$query,FALSE);
		
		return $request;
	}
}