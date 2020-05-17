<?php
defined('BASEPATH') OR exit('No direct script access allowed');
class M_general extends SME_Model {
	function __construct() {
		parent::__construct();
	}	

	function readSchoolLogo(){
		$this->resource_folder();
		$path	= $this->getResource_folder_path();
		return $this->read_directory_files($path);
	}
	
	function uploadSchoolLogo($file){
		$this->resource_folder();
		$request  = $this->upload_file($file,$this->getResource_folder_path());
		return $request;		
	}

	function select_cons_cert($tb, $tp) {
		return $this->get_table($tb,$this->limit_max, $this->limit_min,"type=".$tp);
	}	

	function get_select_jornadas($sede){
		$db		= $this->get_db_name();
		$this->db_limit();
		if(strval($sede) > 0){
			$this->db->select('tj.cod_jorn, TRIM(tj.jornada) AS jornada, tj.estado');
			$this->db->from($db.'.jornadas AS tj');
			$this->db->join($db.'.jornadas_sedes AS t1', 't1.id_jornada = tj.cod_jorn', 'left');
			$this->db->join($db.'.sedes AS t3', 't1.id_sede = t3.ID', 'left');
			$this->db->where('t1.id_sede', $sede);
			$this->db->limit($this->limit_max, $this->limit_min);
			$qry	= $this->db->get();	
			$total	= $this->get_count_all('jornadas_sedes','id_sede ='.$sede);
			if ($qry) {
				$result		= $this->get_request_select($qry->result_array(),$total);
			} else {
				$result		= $this->getError();
			}
		}else{
			$result		= $this->getTable('jornadas',1,30,null);
		}
		return $result;				
	}
	

	function get_select_niveles_sedes($sede){
		$db		= $this->get_db_name();
		$this->db->select('t1.*, t2.nombre_nivel AS nivel, t3.NOMBRE_SEDE AS sede');
		$this->db->from($db.'.niveles_sedes AS t1');
		$this->db->join($db.'.niveles_estudio AS t2', 't1.id_nivel = t2.id', 'left');
		$this->db->join($db.'.sedes AS t3', 't1.id_sede = t3.ID', 'left');
		$this->db->where('t1.id_sede', $sede);
		$this->db->limit($this->limit_max, $this->limit_min);
		$qry	= $this->db->get();	
		$total	= $this->get_count_all('niveles_sedes','id_sede ='.$sede);
		if ($qry) {
			$result		= $this->get_request_select($qry->result_array(),$total);
		} else {
			$result		= $this->getError();
		}
		return $result;
	}
	
	function get_select_jorn_sedes($sede){
		$db		= $this->get_db_name();
		$this->db_limit();
		$this->db->select('t1.*, t2.jornada, t3.NOMBRE_SEDE AS sede');
		$this->db->from($db.'.jornadas_sedes AS t1');
		$this->db->join($db.'.jornadas AS t2', 't1.id_jornada = t2.cod_jorn', 'left');
		$this->db->join($db.'.sedes AS t3', 't1.id_sede = t3.ID', 'left');
		$this->db->where('t1.id_sede', $sede);
		$this->db->limit($this->limit_max, $this->limit_min);
		$qry	= $this->db->get();	
		$total	= $this->get_count_all('jornadas_sedes','id_sede ='.$sede);
		if ($qry) {
			$result		= $this->get_request_select($qry->result_array(),$total);
		} else {
			$result		= $this->getError();
		}
		return $result;				
	}

	function select_com_grado($grado){
		$db		= $this->get_db_name();
		$sql	= "SELECT tc.* FROM ".$db.".competencias AS tc
				LEFT JOIN ".$db.".grados_agrupados AS t1 ON tc.id_grado_agrupado = t1.id
				LEFT JOIN ".$db.".aux_grados_agrupados AS t2 ON t2.id_grado_agrupado = t1.id
				WHERE tc.year = ".$this->get_year()." AND t2.id_grado =".$grado;
		$query	= $this->db->query($sql);
		return $this->getJsonResponse($query->result(), $query->num_rows());
	}
	
	function read_images_signature(){
		$this->folders_signature();
		$path	= $this->route_signature_dir;
		return $this->read_directory_files($path);
	}

	function upload_foto_signature($file){
		$this->folders_signature();
		$request  = $this->upload_file($file,$this->route_signature_dir);
		return $request;		
	}

	function config_db($grado){
		$db		= $this->get_db_name();
		$year 	= $this->get_year();
		if($grado > 0){
			$query	= "SELECT t.* FROM ".$db.".config001 AS t 
					LEFT JOIN ".$db.".grados_agrupados AS t1 ON t.id_grupo_grados = t1.id
					LEFT JOIN ".$db.".aux_grados_agrupados AS t2 ON t2.id_grado_agrupado = t1.id
					WHERE t.year = ".$this->get_year()." AND t2.id_grado =".$grado." LIMIT 1";
			$query	= $this->db->query($query);
			return $this->getJsonResponse($query->result(), $query->num_rows());
		}else{
			$this->db->select("*");
			$this->db->from($db.".config001");
			$this->db->where("year",$year);
			$config = $this->db->get();
			
			$this->db->select("*");
			$this->db->from($db.".aux_grados_agrupados");
			$grupo_grados	= $this->db->get();

			return json_encode(array(
				'records'		=> $config->result(),
				'grupo_grados'	=> $grupo_grados->result()
			));
		}
	}	
		
	function matricular_antiguos($grado,$grupo,$jorn,$sede,$list){
		$db		= $this->get_db_name();
		$lista	= json_decode($list);
		$count	= count($lista); // Contamos la cantidad de registros a insertar.
		$this->trans_start();
		$in	= FALSE;
		foreach ($lista as $value) {	
			$sqlActa	= "SELECT estado FROM ".$db.".acta_promocion WHERE id_matric = ".$value->id." LIMIT 1";
			$sqlActa	= $this->db->query($sqlActa);
			if ($grado <= 4){
				$in = TRUE;
			}else{
				$in = $sqlActa->num_rows() > 0 ? TRUE : FALSE;
			}
			if ($in){
				$sqlMat	= "SELECT tm.*, ts.NOMBRE_SEDE AS sede, ts.DIRECCION_SEDE AS dir_sede
							FROM ".$db.".student_enrollment AS tm 
							LEFT JOIN ".$db.".sedes AS ts ON tm.id_headquarters = ts.ID 
							WHERE tm.id = ".$value->id." LIMIT 1";
				$sqlMat	= $this->db->query($sqlMat);	
				if($grado > 4){
					$estado	= $sqlActa->row('estado');	
				}else{
					$estado	= 1;
				}
				//Se actuliza la student_enrollment con los nuevos datos
				if ($sqlMat->num_rows() > 0){
					switch($estado){
						case 3 : // No Promovido
							$data	= array(
								'id_student'		=> $sqlMat->row('id_student'),
								'id_grade'			=> $grado,
								'id_group'			=> $grupo,
								'id_headquarters'	=> $sede,
								'id_study_day'		=> $jorn,
								'year'				=> $this->get_year(),
								'id_state'			=> 2,
								'inst_address'		=> $sqlMat->row('dir_sede'),
								'inst_origin'		=> $sqlMat->row('sede')
							);
							break;							
						default:// Promovido
							$ngrado	= $this->get_grado_promocion($grado);
							$data	= array(
								'id_student'		=> $sqlMat->row('id_student'),
								'id_grade'			=> $ngrado,
								'id_group'			=> $grupo,
								'id_headquarters'	=> $sede,
								'id_study_day'		=> $jorn,
								'year'				=> $this->get_year(),
								'id_state'			=> 2,
								'inst_address'		=> $sqlMat->row('dir_sede'),
								'inst_origin'		=> $sqlMat->row('sede')
							);
							break;
					}
					$this->db->insert($db.".student_enrollment", $data);
									
					$sql = "UPDATE ".$db.".student_enrollment SET promoted = 1  WHERE id=".$value->id." LIMIT 1";
					$this->db->query($sql);
				}
									
			}
		}
		$this->trans_complete();
		if ($this->trans_status()) {
			$result = $this->getJosnSuccess();
		}else{
			$result	= $this->getError();
		}
		
		return $result;
	}
	
	function select_columnas_notas_competencias($id){
		$db         = $this->get_db_name();
		$query	= "SELECT *, CONCAT('#',numero_column) name FROM ".$db.".columnas_notas_competencias WHERE id_competencia=".$id;
		return $this->get_query($this->limit_min,$this->limit_max,$query,FALSE);
	}
	
	function select_config(){
		$db         = $this->get_db_name();	
		$query	="SELECT t1.*, t2.nombre_grado_agrupado FROM ".$db.".config001 AS t1 
			LEFT JOIN ".$db.".grados_agrupados As t2 ON t1.id_grupo_grados = t2.id
			WHERE t1.year =".$this->get_year();
		return $this->get_query($this->limit_min,$this->limit_max,$query,FALSE);
	}
	
	function get_select_escala_notas(){
		$db         = $this->get_db_name();
		$query = "SELECT td.*, t1.nombre_grado_agrupado, t2.nombre_escala, t2.abrev 
				FROM ".$db.".`desempeños` AS td 
				LEFT JOIN ".$db.".grados_agrupados AS t1 ON td.id_grado_agrupado = t1.id 
				LEFT JOIN ".$db.".escala_nacional AS t2 ON td.id_escala = t2.id
				WHERE td.year=".$this->get_year()." ORDER BY td.year, td.id_grado_agrupado, td.id";
				
		return $this->get_query($this->limit_min,$this->limit_max,$query,FALSE);
	}
	
	
	function get_select_aux_grados_agrupados($IdNivelAgrupado){
		$db         = $this->get_db_name();
		$query	= "SELECT t1.*, t2.nombre_grado_agrupado, t3.grado 
					FROM ".$db.".aux_grados_agrupados AS t1
					LEFT JOIN ".$db.".grados_agrupados AS t2 ON t1.id_grado_agrupado = t2.id
					LEFT JOIN ".$db.".grados AS t3 ON t1.id_grado = t3.id 
					WHERE t1.id_grado_agrupado=".$IdNivelAgrupado;
		return $this->get_query($this->limit_min,$this->limit_max,$query);
	}
	
	function select_proycupos(){
		$sql = "SELECT t.*,if(t.tipo = 1, 'Nuevos', 'Antiguos') AS tipo_proy,
			TRIM(tg.grado) grado, TRIM(ts.NOM_SEDE) sede
		 	FROM proyeccion_cupos AS t
		 	LEFT JOIN grados AS tg ON t.cod_grado = tg.cod_grado
		 	LEFT JOIN sedes AS ts ON t.id_sede=ts.ID 
		 	WHERE t.id_inst=".$this->get_id_school()." AND ts.id_inst=".$this->get_id_school();
		 	
		return $this->get_query($this->limit_min,$this->limit_max,$sql,FALSE);
	}
	
	function borrar_cerros(){	
		$db         = $this->get_db_name();
		$this->trans_start();
		$sql="DELETE FROM ".$db.".nscp001 WHERE final<=0 and year=".$this->get_year();
		$this->db->query($sql);
		$sql="DELETE FROM ".$db.".nscp002 WHERE final<=0 and year=".$this->get_year();
		$this->db->query($sql);
		$sql="DELETE FROM ".$db.".nscp003 WHERE final<=0 and year=".$this->get_year();
		$this->db->query($sql);
		$this->trans_complete();
		
		return $this->trans_status() ? $this->getJsonResponse([],0) : $this->getError();
	}
	
	function read_images(){
		$this->folders_users($this->get_user_id());
		$path	= $this->user_images_path;
		return $this->read_directory_files($path);
	}
	function upload_foto($file){
		$this->folders_users($this->get_user_id());
		$request  = $this->upload_file($file,$this->user_images_path);
		return $request;		
	}	

	function select_promovidos(){
		$db     = $this->get_db_name();	
		$query	= "SELECT tp.*,
					CONCAT(RTRIM(te.apellido1),' ',RTRIM(te.apellido2),' ',
					RTRIM(te.nombre1),' ',RTRIM(te.nombre2)) AS nombres,
					RTRIM(tg.grado) grado, RTRIM(tj.jornada) jornada, RTRIM(ts.NOMBRE_SEDE) sede
					FROM ".$db.".promoted_header AS tp 
					LEFT JOIN ".$db.".inscripciones AS te ON tp.student_id=te.id 
					LEFT JOIN ".$db.".grados AS tg ON tp.grade_id = tg.id
					LEFT JOIN ".$db.".jornadas AS tj ON tp.studyday_id = tj.cod_jorn
					LEFT JOIN ".$db.".sedes AS ts ON tp.headq_id = ts.ID
					WHERE tp.year=".$this->get_year()."
					order by tp.grade_id,nombres";
		
		$query	= $this->db->query($query);
		
		return $this->getJsonResponse($query->result(), $query->num_rows());
	}
	
	function promover_estudiantes($grado,$grupo,$jorn,$sede,$gradoMove,$list){
		$db         = $this->get_db_name();
		$lista		= json_decode($list);
		$tableMove	= $db.".".$this->tabla_notas($gradoMove); // Tabla de donde se moverán los datos
		$tableDest	= $db.".".$this->tabla_notas($grado);	  // Tabla a donde se moverán los datos	
		if($this->get_year() == date('Y')){	
			$this->trans_start();
			foreach($lista as  $fields){					
				foreach ($fields as $field => $value) {					
					$sqlMove	= "SELECT * FROM ".$tableMove." WHERE id_matric = ".$value." AND year =".$this->get_year();
					$sqlIns		= "SELECT id_student FROM ".$db.".student_enrollment WHERE id =".$value;
					$sqlIns		= $this->db->query($sqlIns);
					$sqlMove	= $this->db->query($sqlMove);
					$id_matric	= 0;
					if ($sqlMove->num_rows() > 0){
						//Se actuliza la student_enrollment con los nuevos datos
						if ($sqlIns->row('id_student') > 0){
							$sql = "INSERT INTO ".$db.".student_enrollment (id_student,id_grade,id_group,id_headquarters,id_study_day,year,id_state".
									") VALUES(".$sqlIns->row('id_student').",'".$grado."','".$grupo."',".$sede.",".$jorn.",".$this->get_year().",2)";
							$sql = $this->db->query($sql);
							if ($sql){
								$id = $this->db->insert_id();
								if ($id > 0){
									$id_matric = $id;
								}
							}
							$sql = "UPDATE ".$db.".student_enrollment SET id_state = 3, promoted = 1  WHERE id=".$value;
							$this->db->query($sql);
						}else{
							$sql = "UPDATE ".$db.".student_enrollment SET id_grade='".$grado."', id_group='".$grupo."'".
							",id_headquarters=".$sede.", id_study_day=".$jorn." WHERE id=".$value;
							$this->db->query($sql);	
						}
						$insert = "INSERT INTO ".$db.".promoted_header(student_id,headq_id,grade_id,studyday_id,group_id,year)".
									" SELECT tm.id_student,id_headquarters,id_grade,id_study_day,id_group,year".
									" FROM ".$db.".student_enrollment AS tm WHERE tm.id=".$value." LIMIT 1";
						$insert	= $this->db->query($insert);
						$promoted_id	= $this->db->insert_id();

						$insert = "INSERT INTO ".$db.".detail_promoted(promoted_id,subject_id,final,faults) ".
									" SELECT ".$promoted_id.",tc.id_asig,tn.final,tn.faltas FROM ".$tableMove." AS tn ".
									"LEFT JOIN ".$db.".cursos AS tc ON (tn.id_curso=tc.id AND tn.year = tc.year)
									LEFT JOIN ".$db.".student_enrollment AS tm ON tn.id_matric = tm.id 
									WHERE tc.year =".$this->get_year()." AND tm.year = ".$this->get_year().
									" AND tm.id=".$value." AND tn.periodo=1";
						$insert	= $this->db->query($insert);
						
						foreach ($sqlMove->result() as $row)
						{
							$curso = $this->
							get_get_docente_curso($grado,$grupo,$sede,$jorn,$this->get_year(),$row->id_curso);
							if ($curso == 0 ){
								$curso = $row->id_curso;
							}
							if ($id_matric == 0){
								$id_matric	= $row->id_matric;
							}						
							$_SQL = "INSERT INTO ".$tableDest." (id_curso,id_matric,periodo,year,
									n1,n2,n3,n4,n5,n6,n7,n8,n9,n10,n11,
									n12,n13,n14,n15,n16,n17,n18,
									n19,n20,n21,n22,n23,n24,n25,
									n26,n27,n28,n29,n30,final,id_escala,faltas,
									nota_perdida,nota_habilitacion,injustificadas,retraso,nivelacion) ".
									"VALUES ('".$curso."','".$id_matric."','".
									$row->periodo."','".$this->get_year()."','".$row->n1."','".$row->n2."','".
									$row->n3."','".$row->n4."','".$row->n5."','".$row->n6."','".$row->n7."','".
									$row->n8."','".$row->n9."','".$row->n10."','".$row->n11."','".$row->n12."','".
									$row->n13."','".$row->n14."','".$row->n15."','".$row->n16."','".$row->n17."','".
									$row->n18."','".$row->n19."','".$row->n20."','".$row->n21."','".
									$row->n22."','".$row->n23."','".$row->n24."','".$row->n25."','".
									$row->n26."','".$row->n27."','".$row->n28."','".$row->n29."','".$row->n30."','".
									$row->final."','".$row->id_escala."','".
									$row->faltas."','".$row->nota_perdida."','".
									$row->nota_habilitacion."','".$row->injustificadas."','".
									$row->retraso."','".$row->nivelacion."')";
							$this->db->query($_SQL);
						}						
					}
				}
																				
			}	
			$this->trans_complete();
			if ($this->trans_status()) {
				$result = $this->getJsonResponse([],0);
			}else{
				$result	= $this->getError();
			}
		}else{
			$result	= $this->getJsonResponse([],0);
		}	
		return $result;
	}
	
	function get_select_acta_prom_est($matric){
		$query	= "SELECT * FROM acta_promocion WHERE id_matric =".$matric;
		return $this->get_query($this->limit_min,$this->limit_max,$query,'',FALSE);
	}
	
	function get_select_matriculados($cod_grado,$grupo,$sede,$jornada){
		$param	= $this->get_year().",".$sede.",'".$cod_grado."','".$grupo."',".$jornada;
		return $this->get_call('sp_select_matriculas',$param);
	}
	
	function upload_foto_proy($file){
		$this->folders_proy_trans();
		$path	= 	$this->dirPathProyTrans;
		$request = $this->upload_file($file,$path);		
		return $request;
	}
	
	function read_images_proy() {
		$this->folders_proy_trans();
		return $this->read_directory_files($this->dirPathProyTrans);
	}
	
	function get_select_criterios_aspectos_observador($type){
		$query	= "SELECT * FROM obs_criterios";
		$where	= "id_item_modelo= ?";
		$param	= array(
			$type
		);
		$query	= $this->get_query_param($this->limit_min,$this->limit_max,$query,$where,$param,'',FALSE);
		return $query;
	}
	
	
	function get_select_aspectos_observador($type){
		$query	= "SELECT * FROM obs_items_modelos";
		$where	= "id_modelo= ?";
		$param	= array(
			$type
		);
		$query	= $this->get_query_param($this->limit_min,$this->limit_max,$query,$where,$param,'',FALSE);
		return $query;
	}
	
	function get_select_cuerpo_observador($type){
		$query	= "SELECT id,id_observador,cuerpo,encabezado,firma FROM obs_modelos_observador_cuerpo";
		$where	= "id_observador= ? ";
		$param	= array(
			$type
		);
		$query	= $this->get_query_param($this->limit_min,$this->limit_max,$query,$where,$param,'',FALSE);
		return $query;
	}
	
	function get_select_competencias($type){
		$db         = $this->get_db_name();
		$query	= "SELECT td.*, t1.nombre_grado_agrupado FROM ".$db.".`competencias` AS td 
		LEFT JOIN ".$db.".grados_agrupados AS t1 ON td.id_grado_agrupado = t1.id";
		$where	= "td.year= ? ORDER BY td.year, td.id_grado_agrupado, td.id";
		$param	= array(
			$this->get_year()
		);
		$query	= $this->get_query_param($this->limit_min,$this->limit_max,$query,$where,$param,'',FALSE);
		return $query;
	}
	
	function get_select_acta_promocion($cod_grado,$grupo,$sede,$jornada,$año){
					
		$param	=$this->get_id_school().",'".$cod_grado."','".$grupo."','".$jornada."','".$sede."','".$año."'";
		
		$result = $this->get_call('sp_select_acta_promocion',$param);
		
		return $result;
	}
	
	function get_select_matricula_antiguos($grado,$grupo,$sede,$jornada,$a){
		$db		= $this->get_db_name();

		$this->db->select("tm.*, CONCAT(rtrim(ti.apellido1),' ',rtrim(ti.apellido2),' ',
					rtrim(ti.nombre1),' ',rtrim(ti.nombre2)) AS nombres,
					rtrim(tg.grado) AS grado, rtrim(ts.NOMBRE_SEDE) AS sede, tj.jornada");
		$this->db->from($db.".student_enrollment AS tm ");
		$this->db->join($db.'.inscripciones AS ti', 'tm.id_student=ti.id', 'left');
		$this->db->join($db.'.grados AS tg', 'tm.id_grade=tg.id', 'left');
		$this->db->join($db.'.sedes AS ts', 'tm.id_headquarters=ts.id', 'left');
		$this->db->join($db.'.jornadas AS tj', 'tm.id_study_day=tj.cod_jorn', 'left');
		$this->db->where('tm.id_grade', $grado);
		$this->db->where('tm.id_group', $grupo);
		$this->db->where('tm.id_study_day', $jornada);
		$this->db->where('tm.id_headquarters', $sede);
		$this->db->where('tm.promoted',0);
		$this->db->where('tm.id_state',2);
		$this->db->where('tm.year',$a);
		$this->db->order_by('nombres', 'asc');
		$query	= $this->db->get();		
		return $this->getJsonResponse($query->result(), $query->num_rows());
	}
	
	function change_year($year){
		if (strlen($year) == '4'){
			$this->session->set_userdata('user_year',$year);
			$this->year = $year;
			$result = $this->get_request_ab();			
		}else{
			$result = $this->getError();
		}		
		return $result;	
	}
	
	function get_tipo_discapacidad(){
		return $this->get_query($this->limit_min,$this->limit_max,'SELECT * FROM tipo_discapacidad');
	}
	
	
	function get_poblacion_victima_conflicto(){
		return $this->get_query($this->limit_min,$this->limit_max,'SELECT * FROM poblacion_victima_conflicto');
	}
	
	function get_Capacidades_excepcionales(){
		return $this->get_query($this->limit_min,$this->limit_max,'SELECT * FROM capacidades_excepcionales',FALSE);
	}
	
	function get_zona(){
		return $this->get_query($this->limit_min,$this->limit_max,'SELECT * FROM zona',FALSE);
	}
	
	function get_eps(){
		return $this->get_query($this->limit_min,$this->limit_max,'SELECT * FROM eps',FALSE);
	}

    function get_departamentos($q){
    	if(empty($q)){
			$query = 'SELECT * FROM departamentos ORDER BY nombre';
		}else{
			$query = "SELECT * FROM departamentos WHERE nombre REGEXP '".$q."' ORDER BY nombre";
		}
        return $this->get_query($this->limit_min,$this->limit_max,$query,FALSE);
    }

    function get_ciudades($dpto,$q)
    {
    	if(empty($q)){
    		$where = "c.id_dept = d.id";
			$param = array(0); 
		}else{
			$where = "c.id_dept = d.id AND c.name_city REGEXP ?";
			$param = array($q); 
		}
		$db	= $this->get_db_name();
		$query = "SELECT c.id, c.city_code,  c.id_dept, d.id_country, 
			CONCAT(TRIM(c.name_city),' (',TRIM(d.name_departament),' - ',TRIM(p.country_name),')') AS name_city 
			FROM ".$db.".cities AS c 
			LEFT JOIN ".$db.".departments AS d ON c.id_dept = d.id
			LEFT JOIN ".$db.".countries AS p ON d.id_country = p.id ";	
		$queryTable = "SELECT COUNT(*) total FROM ".$db.".cities";
        return $this->get_query_param($this->limit_min,$this->limit_max,$query,$where,$param,$queryTable);
    }

    function get_documentos(){
        return $this->get_query($this->limit_min,$this->limit_max,'SELECT * FROM documentos',FALSE);
    }
	
	function get_select_docentes($quer) {
		
		$querys = "SELECT *, 
		CONCAT(RTRIM(apellido1),' ',RTRIM(apellido2),' ',RTRIM(nombre1),' ',RTRIM(nombre2)) 
		as nombres	FROM docentes ";
		
		if (empty($quer)) {
			
			$where = "id_inst = ? AND año = ? ";
			
			$param = array(
				$this->get_id_school(),
				$this->get_year()
			);
			
		}else{
			
			$where = "id_inst = ? AND año = ? AND (nombre1 REGEXP ? OR apellido1 REGEXP ?)";
			
			$param = array(
				$this->get_id_school(),
				$this->get_year(),
				$quer,
				$quer
			);
			
		}
						
		$result	= $this->get_query_param($this->limit_min,$this->limit_max,$querys,$where,$param);
			
		return $result;
	}
	
	function get_select_administrativos($query) {
		
		$querys = "SELECT *, 
		CONCAT(RTRIM(apellido1),' ',RTRIM(apellido2),' ',RTRIM(nombre1),' ',RTRIM(nombre2)) 
		as nombres FROM administrativos ";
		
		if (empty($query)) {
			$WHERE = "id_inst = ? ";
			$param = array(
				$this->get_id_school()
			);
		}else{
			$WHERE = "id_inst = ? AND (nombre1 REGEXP ? OR apellido1 REGEXP ? )";
			$param = array(
				$this->get_id_school(),
				$query,
				$query
			);
		}
						
		$query	= $this->get_query_param($this->limit_min,$this->limit_max,$querys,$WHERE,$param);
		
		return $query;
	}
		
	function get_user() {			
		$where	= "id=".$this->get_user_id();
		$query	= $this->get_table('users',1,0,$where);		
		return $query;
	}
	
	function get_jornadas() {
		$sql	= "SELECT cod_jorn AS cod_jorn, jornada AS jornada FROM jornadas";
		return $this->get_query($this->limit_min,$this->limit_max,$sql,FALSE);
	}
	
	function get_grupos(){
		$db	= $this->get_db_name();	
		$query = "SELECT grupo FROM ".$db.".config001 WHERE year=".$this->get_year();
		$query = $this->db->query($query);
		$result = "";
		$value	= array();
		if ($query) {
			if ($query->num_rows() > 0) {
				if ($query->row('grupo') == 1){
					for ($i=1; $i < 16; $i++) { 
						$value[]	= array(
							'grupo'		=> str_pad($i, 2, "00", STR_PAD_LEFT)
						);
					};					
				}else{
					$value [] = array(
						'grupo' => 'A'
					);
					$value [] = array(
						'grupo' => 'B'
					);
					$value [] = array(
						'grupo' => 'C'
					);
					$value [] = array(
						'grupo' => 'D'
					);
					$value [] = array(
						'grupo' => 'E'
					);
					$value [] = array(
						'grupo' => 'F'
					);
					$value [] = array(
						'grupo' => 'G'
					);
					$value [] = array(
						'grupo' => 'H'
					);
					$value [] = array(
						'grupo' => 'I'
					);
					$value [] = array(
						'grupo' => 'J'
					);
					
					$value [] = array(
						'grupo' => 'K'
					);
					$value [] = array(
						'grupo' => 'L'
					);
					$value [] = array(
						'grupo' => 'M'
					);
					$value [] = array(
						'grupo' => 'N'
					);
					$value [] = array(
						'grupo' => 'O'
					);
				}
				$jencod = array(
						'success'       => TRUE,
						'records'	=> $value,
						'reccount' 		=> 15	
					);
				
				$result = json_encode($jencod);
			}
		}
	return $result;
	}
	
	function get_select_estudiantes ($grado,$grupo,$sede,$jorn){
		$db		= $this->get_db_name();
		$query	= "SELECT tm.*, CONCAT(rtrim(ti.apellido1),' ',rtrim(ti.apellido2),' ',
					rtrim(ti.nombre1),' ',rtrim(ti.nombre2)) AS nombres,
					rtrim(tg.grado) AS grado, rtrim(ts.NOMBRE_SEDE) AS sede, tj.jornada,
					te.name_state AS estado 
					FROM ".$db.".student_enrollment AS tm 
					LEFT JOIN ".$db.".inscripciones AS ti ON tm.id_student = ti.id
					LEFT JOIN ".$db.".grados AS tg ON tm.id_grade = tg.id 
					LEFT JOIN ".$db.".sedes AS ts ON tm.id_headquarters =ts.id 
					LEFT JOIN ".$db.".jornadas AS tj ON tm.id_study_day =tj.cod_jorn 
					LEFT JOIN ".$db.".registration_status AS te ON tm.id_state = te.id 
					WHERE tm.id_grade= ? AND tm.id_group = ? AND tm.year = ? AND tm.id_state = 2 
					AND tm.id_headquarters = ? AND tm.id_study_day = ? ORDER BY nombres";
		
		$param	= array(
			$grado,
			$grupo,
			$this->get_year(),
			$sede,
			$jorn
		);
		$request	= $this->db->query($query, $param);
		return $this->getJsonResponse($request->result(), $request->num_rows());
	}
	
	function get_select_banco_cli($cod_grado,$id_asig,$periodo,$type) {
		
		if($type == 2){
			$query	= "SELECT * FROM banco_cli WHERE cod_grado=".$cod_grado." AND 
				id_asig=".$id_asig." AND periodo = ".$periodo." AND tipo= 1 ";
			$queryTable	= "SELECT COUNT(*) total FROM banco_cli WHERE cod_grado=".$cod_grado." AND 
				id_asig=".$id_asig." AND periodo = ".$periodo." AND tipo= 1 ";
		}else{
			$query	= "SELECT * FROM banco_cli WHERE cod_grado=".$cod_grado." AND 
				id_asig=".$id_asig." AND periodo = ".$periodo." AND tipo = 2";
			$queryTable	=  "SELECT COUNT(*) total FROM banco_cli WHERE cod_grado=".$cod_grado." AND 
				id_asig=".$id_asig." AND periodo = ".$periodo." AND tipo = 2";
		}		
		
		$request = $this->get_query($this->limit_min,$this->limit_max,$query,TRUE,$queryTable) ;
		
		return $request;
	}
	
	function get_select_asignaturas_banco () {
		$query	= "SELECT * FROM ".$this->get_db_name().".asignaturas_banco ORDER BY descripcion";		
		$request = $this->get_query(0,100,$query,FALSE);		
		return $request;
	}
	
	function get_select_all_id($tb,$query) {
		$table	= $this->get_db_name().".".$tb;				
		if (empty($query)){
			$sql 	= "SELECT * FROM ".$table." WHERE id_inst=".$this->get_id_school();
		}else{
			$fiels_table = $this->db->field_data($table);
			foreach ($fiels_table AS $field_compare) {
				$name 			= $field_compare->name;				
				$primary_key 	= $field_compare->primary_key;
				if($primary_key == 0){ // Si no es una llave primaria
					$extra  = $name." REGEXP '".$query."'";
					$sql 	= "SELECT ".$name." FROM ".$table." WHERE ".$extra." AND id_inst=".$this->get_id_school()." LIMIT 1";
					$sql	= $this->db->query($sql);
					if ($sql->num_rows() > 0){
						$sql 	= "SELECT * FROM ".$table." WHERE ".$extra." AND id_inst=".$this->get_id_school();
						break;
					}else{
						$sql 	= "SELECT * FROM ".$table." WHERE id_inst=".$this->get_id_school();
					}					  		
				}
			}
		}		
		$request = $this->get_query($this->limit_min,$this->limit_max,$sql);		
		return $request;
	}
	
	function get_select_all($atable,$query) {	
		$table	= $this->get_db_name().".".$atable;
		if (empty($query)){
			$sql 	= "SELECT * FROM ".$table;
		}else{
			$fiels_table = $this->db->field_data($table);
			foreach ($fiels_table AS $field_compare) {
				$name 			= $field_compare->name;				
				$primary_key 	= $field_compare->primary_key;
				if($primary_key == 0){ // Si no es una llave primaria
					$extra  = $name." REGEXP '".$query."'";
					$sql 	= "SELECT ".$name." FROM ".$table." WHERE ".$extra." LIMIT 1";
					$sql	= $this->db->query($sql);
					if ($sql->num_rows() > 0){
						$sql 	= "SELECT * FROM ".$table." WHERE ".$extra;
						break;
					}else{
						$sql 	= "SELECT * FROM ".$table;
					}					  		
				}
			}
		}
		$request = $this->get_query($this->limit_min,$this->limit_max,$sql,FALSE);		
		return $request;
	}
	
	function get_select_id($table,$query) {		
		if (empty($query)){
			$sql 	= "SELECT * FROM ".$table." WHERE id_inst=".$this->get_id_school();
		}else{
			$fiels_table = $this->db->field_data($table);
			foreach ($fiels_table AS $field_compare) {
				$name 			= $field_compare->name;				
				$primary_key 	= $field_compare->primary_key;
				if($primary_key == 0){ // Si no es una llave primaria
					$extra  = $name." REGEXP '".$query."'";
					$sql 	= "SELECT ".$name." FROM ".$table." WHERE ".$extra." AND id_inst=".$this->get_id_school()." LIMIT 1";
					$sql	= $this->db->query($sql);
					if ($sql->num_rows() > 0){
						$sql 	= "SELECT * FROM ".$table." WHERE ".$extra." AND id_inst=".$this->get_id_school();
						break;
					}else{
						$sql 	= "SELECT * FROM ".$table." WHERE id_inst=".$this->get_id_school();
					}					  		
				}
			}
		}		
		$request = $this->get_query($this->limit_min,$this->limit_max,$sql);		
		return $request;
	}
	
	function get_select($tb,$fields,$qSearch) {
		$fl		= json_decode($fields);
		$db		= $this->get_db_name();
		$tb		= $db.'.'.$tb;
		$extra	= '';
		$count	= 0;
		if(is_array($fl)){
			$count	= count($fl);
		}
		if ($count > 0 AND strlen($qSearch) > 0){
			if ($count == 1){
				$extra  = " AND ".$fl[0]." REGEXP '".$qSearch."'";
			}else{
				foreach($fl as $key => $value){
					$extra  = " AND ".$value." REGEXP '".$qSearch."'";
					$query 	= "SELECT ".$value." FROM ".$tb.
					" WHERE id_inst=".$this->get_id_school()." AND año=".$this->get_year().$extra.
					" LIMIT 1";
					$query	= $this->db->query($query);
					if ($query->num_rows() > 0){
						break;
					}
				}				
			}
		}elseif(strlen($qSearch) > 0){
			$fiels_table = $this->db->field_data($tb);
			foreach ($fiels_table AS $field_compare) {
				$name 			= $field_compare->name;				
				$primary_key 	= $field_compare->primary_key;
				if($primary_key == 0){ // Si no es una llave primaria
					$extra  = " AND ".$name." REGEXP '".$qSearch."'";
					$sql 	= "SELECT ".$name." FROM ".$table." WHERE id_inst=".
					$this->get_id_school()." AND año=".$this->get_year().$extra." LIMIT 1";
					$sql	= $this->db->query($sql);
					if ($sql->num_rows() > 0){
						break;
					}					  		
				}
			}
		}
		$query 	= "SELECT * FROM ".$tb." WHERE id_inst=".$this->get_id_school()." AND año=".$this->get_year().$extra;
		$tbl 	= "SELECT COUNT(*) total FROM ".$tb." WHERE id_inst=".$this->get_id_school()." AND año=".$this->get_year();	
		$request = $this->get_query($this->limit_min,$this->limit_max,$query,TRUE,$tbl);
		return $request;
	}	
	
}