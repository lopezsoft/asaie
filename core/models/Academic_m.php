<?php
defined('BASEPATH') OR exit('No direct script access allowed');
class Academic_m extends SME_Model {
	function __construct() {
		parent::__construct();
	}

	function insert_aux_asignaturas($id,$list){
		$lista	= json_decode($list);			
		$extra = array(
			'id_asign'	 => $id
		);		
		$request = $this->insert_data_primary('aux_asignaturas',$lista,$extra);						
		return $request;
	}

	function select_asignaturas_year($year){
		$db		= $this->get_db_name();
		$year	= $this->get_year();
		$this->db->select('t1.*, t2.area, t3.asignatura');
		$this->db->from($db.'.aux_asignaturas AS t1');		
		$this->db->join($db.'.areas AS t2 ', 't1.id_area = t2.id', 'left');
		$this->db->join($db.'.asignaturas AS t3', 't1.id_asign = t3.id_pk', 'left');
		$this->db->where('t1.year', $year);		
		$this->db->order_by('t2.area');
		$this->db->order_by('t3.asignatura');
		$query	= $this->db->get();	
		
		return $this->get_request_select($query->result_array(), $query->num_rows());
	}
	
	function select_aux_asignaturas($id){
		$db		= $this->get_db_name();
		$this->db->select('t1.*, t2.area, t3.asignatura');
		$this->db->from($db.'.aux_asignaturas AS t1');		
		$this->db->join($db.'.areas AS t2 ', 't1.id_area = t2.id', 'left');
		$this->db->join($db.'.asignaturas AS t3', 't1.id_asign = t3.id_pk', 'left');
		$this->db->where('t1.id_asign', $id);		
		$this->db->order_by('t1.year');
		$this->db->order_by('t2.area');
		$query	= $this->db->get();	
		
		return $this->get_request_select($query->result_array(), $query->num_rows());
	}
	
	
	function get_transferir_notas($id,$list){
		$lista	= json_decode($list);
		$count	= count($lista); // Contamos la cantidad de registros a insertar.
		$this->openconn();
		$this->trans_start();
		$db		= $this->get_db_name();
		$sql	= "SELECT * FROM ".$db.".student_enrollment WHERE id=".$id." LIMIT 1";
		$sql	= $this->db->query($sql);
		$table	= $db.'.'.$this->tabla_notas($sql->row('id_grade'));
		for($i = 0; $i < $count; $i++){					
			$fields = $lista[$i];	
			$grado	= $sql->row('id_grade');
			$sede	= $sql->row('id_headquarters');
			$jorn	= $sql->row('id_study_day');	
			$grupo	= $sql->row('id_group');	
			$curso = $this->get_get_docente_curso($grado,$grupo,$sede,$jorn,$this->get_year(),$fields->id_curso);
			if(($curso <> $fields->id_curso) AND ($curso > 0)){
				$sqlUp	= "UPDATE ".$table." SET id_curso=".$curso." WHERE id=".$fields->id." LIMIT 1";
				$sqlUp	= $this->db->query($sqlUp);
			}			  														  		
		}	
		$this->trans_complete();
		if ($this->trans_status()) {
			$result = $this->get_request_ab();
		}else{
			$result	= $this->getError();
		}
		
		return $result;
	}
	
	function force_delete_matricula ($list,$f){
		$this->openconn();
  		if(isset($list)){  			
  			$this->trans_start();  			
  			$fields	= json_decode($list);
			$count	= 0;
			if (is_array($fields)) {
  				$count	= count($fields);
			}  			
			$i  	= 0;  			
	  		$db_field = '';			
			$primary_key_name = 'id'; // Nombre del campo primario de la tabla				
			$table	= "";
			$db	= $this->get_db_name();
			if ($count > 1) {	
				for($i = 0; $i < $count; $i++){
					$fields_value = $fields[$i]->id;	
					if($f > 0){
						$table	= $this->tabla_notas(4);
						$this->db->where('id_matric', $fields_value);				
						$this->db->delete($table);
						$table	= $this->tabla_notas(5);
						$this->db->where('id_matric', $fields_value);				
						$this->db->delete($table);
						$table	= $this->tabla_notas(10);
						$this->db->where('id_matric', $fields_value);				
						$this->db->delete($table);
						$table	= $this->tabla_notas(14);
						$this->db->where('id_matric', $fields_value);				
						$this->db->delete($table);		
					}					
					$this->db->where('id', $fields_value);				
					$this->db->limit(1);
					$this->db->delete($db.'.student_enrollment');							
				}			
			}else{
				$fields_value = $fields->id;		
				if($f > 0){
					$table	= $this->tabla_notas(4);
					$this->db->where('id_matric', $fields_value);				
					$this->db->delete($table);
					$table	= $this->tabla_notas(5);
					$this->db->where('id_matric', $fields_value);				
					$this->db->delete($table);
					$table	= $this->tabla_notas(10);
					$this->db->where('id_matric', $fields_value);				
					$this->db->delete($table);
					$table	= $this->tabla_notas(14);
					$this->db->where('id_matric', $fields_value);				
					$this->db->delete($table);		
				}
				
				$this->db->where('id', $fields_value);				
				$this->db->limit(1);
				$this->db->delete($db.'.student_enrollment');
			}			
			$this->trans_complete();		
			if ($this->trans_status()) {
				$request = $this->get_request_ab();
			}else{
				$request = $this->getError();
			}		
		}else{
			$request	= $this->getError();
		}
		$this->closeconn();
		return $request;
	}
	
	function upload_foto_webcam($file,$id){	
		$this->student_folders($id);
		return $this->upload_webcam_file($file,$this->student_image_path);
	}
	
	function upload_foto($file,$id){	
		$this->student_folders($id);
		return $this->upload_file($file,$this->student_image_path);
	}
	
	function read_images($id){
		$this->student_folders($id);
		$dir	= $this->student_image_path;
		return	$this->read_directory_files($dir);
	}
	
	function get_pre_matricula_viejos(){
		$sql = "SELECT ti.cod_est, ti.nro_documento, 
				CONCAT(RTRIM(ti.apellido1),' ',RTRIM(ti.apellido2),' ',RTRIM(ti.nombre1),' ',RTRIM(ti.nombre2)) nombres, 
				ti.direccion, ti.telefono,tmv.id_grado, tmv.id_matric, tmv.estado, tmv.fecha, 
				tmv.`año`, tmv.id_sede, tmv.id_jorn, RTRIM(tg.grado) grado, 
				RTRIM(ts.NOM_SEDE) sede, 
				td.abrev tdocumento
				FROM inscripciones AS ti 
				LEFT JOIN student_enrollment AS tm ON tm.cod_est = ti.cod_est
				LEFT JOIN pre_matricula_viejos AS tmv ON tmv.old_matric = tm.id_matric
				LEFT JOIN sedes AS ts ON tm.id_sede = ts.ID
				LEFT JOIN grados AS tg ON tmv.id_grado = tg.id
				LEFT JOIN documentos AS td ON ti.cod_doc = td.id
				WHERE tm.id_inst = ".$this->get_id_school()." AND ti.id_inst = ".$this->get_id_school()
				." AND ts.ID_INST = ".$this->get_id_school()." 
				AND tmv.old_matric = tm.id_matric AND tmv.estado = 0
				ORDER BY tg.cod_grado, sede, nombres";
		return $this->get_query($this->limit_min,$this->limit_max,$sql,TRUE,
		'SELECT COUNT(*) total FROM pre_matricula_viejos');
	}
	
	function get_pre_matricula_nuevos(){
		$sql = "SELECT ti.cod_est, ti.nro_documento, 
				CONCAT(RTRIM(ti.apellido1),' ',RTRIM(ti.apellido2),' ',RTRIM(ti.nombre1),' ',RTRIM(ti.nombre2)) nombres, 
				ti.direccion, ti.telefono,tm.id_grado, tm.id, tm.estado,tm.ins_proced, 
				tm.fecha, tm.`año` , RTRIM(tg.grado) grado, RTRIM(ts.NOM_SEDE) sede, 
				td.abrev tdocumento, CONCAT(LEFT(tm.repite,1),LOWER(RIGHT(tm.repite,1))) repite
				FROM inscripciones AS ti 
				LEFT JOIN pre_matricula_nuevos AS tm ON tm.cod_est = ti.cod_est
				LEFT JOIN sedes AS ts ON tm.id_sede = ts.ID
				LEFT JOIN grados AS tg ON tm.id_grado = tg.id
				LEFT JOIN documentos AS td ON ti.cod_doc = td.id
				WHERE tm.estado = 2 AND tm.id_inst = ".$this->get_id_school().
				" AND ti.id_inst = ".$this->get_id_school()." AND ts.ID_INST = ".$this->get_id_school()
				." ORDER BY tm.id_grado, sede, nombres";
		return $this->get_query($this->limit_min,$this->limit_max,$sql,TRUE,
		'SELECT COUNT(*) total FROM pre_matricula_nuevos');
	}
	
	function insert_asignaturas_certificados($id,$list){
		$lista	= json_decode($list);			
		$extra = array(
			'id_asig_padre'	 => $id
		);		
		$request = $this->insert_data_primary('asignaturas_certificados',$lista,$extra);						
		return $request;
	}
	
	function select_asignaturas_certificados($id){
		return $this->get_table('asignaturas_certificados',$this->limit_max,$this->limit_min,'id_asig_padre='.$id);
	}
	
	function get_mayus($per){
		$param = array(
			$this->get_year(),
			$per
		);
		$result= $this->getExecute('sp_update_mayus( ?, ? )',$param,false,FALSE);
		return $result;
	}
	
	function get_mover_estudiantes($grado,$grupo,$jorn,$sede,$gradoMove,$list){
		$lista	= json_decode($list);
		$count	= count($lista); // Contamos la cantidad de registros a insertar.
		$tableMove	= $this->tabla_notas($gradoMove); // Tabla de donde se moverán los datos
		$tableDest	= $this->tabla_notas($grado);	  // Tabla a donde se moverán los datos	
		$db			= $this->get_db_name();
		$year		= $this->get_year();
		$this->openconn();
		$this->trans_start();
		for($i = 0; $i < $count; $i++){					
			$fields = $lista[$i];			
			foreach ($fields as $field => $value) {	
				/**
				 * Consulta en la tabla de donde se moveran los datos de notas
				 */				
				$this->db->select('*');
				$this->db->from($db.'.'.$tableMove);
				$this->db->where('id_matric',$value);
				$this->db->where('year', $year);		
				$sqlMove	= $this->db->get();
				/**
				 * Actualiza los datos de la matricula existente por los nuevos
				 */
				$object	= array(
					'id_headquarters'	=> $sede,
					'id_group'			=> $grupo,
					'id_grade'			=> $grado,
					'id_study_day'		=> $jorn
				);
				$this->db->where('id', $value);		
				$this->db->limit(1);	
				$this->db->update($db.'.student_enrollment', $object);

				$id_matric	= $value;

				if ($sqlMove->num_rows() > 0){
					//Guarda los datos de las notas a mover antes de borrarlos de la tabla original
					$_SQL = "INSERT INTO ".$db.".backup_notes (id,id_curso,id_matric,periodo,year,
							n1,n2,n3,n4,n5,n6,n7,n8,n9,n10,n11,
							n12,n13,n14,n15,n16,n17,n18,
							n19,n20,n21,n22,n23,n24,n25,
							n26,n27,n28,n29,n30,final,id_escala,faltas,
							nota_perdida,nota_habilitacion,injustificadas,retraso,nivelacion,fecha,table_name) ".
							"SELECT id,id_curso,id_matric,periodo,year,
							n1,n2,n3,n4,n5,n6,n7,n8,n9,n10,n11,
							n12,n13,n14,n15,n16,n17,n18,
							n19,n20,n21,n22,n23,n24,n25,
							n26,n27,n28,n29,n30,final,id_escala,faltas,
							nota_perdida,nota_habilitacion,injustificadas,retraso,nivelacion,fecha,'".$tableMove.
							"' FROM ".$db.".".$tableMove." WHERE id_matric =".$id_matric;
					$this->db->query($_SQL);
					
					/**
					 * Borramos los datos de la tabla para evitar errores de duplicidad
					 */
					$this->db->where('id_matric', $id_matric);	
					$this->db->delete($db.".".$tableMove);
					
					/**
					 * Se realiza el movimiento de las notas
					 */
					foreach ($sqlMove->result() as $row)
					{
						/**
						 * Nuevo curso asignado a las notas
						 */
						$curso = $this->get_get_docente_curso($grado,$grupo,$sede,$jorn,$this->get_year(),$row->id_curso);
						if ($curso == 0 ){
							$curso = $row->id_curso;
						}
						$_SQL = "INSERT INTO ".$db.".".$tableDest." (id_curso,id_matric,periodo,year,
								n1,n2,n3,n4,n5,n6,n7,n8,n9,n10,n11,
								n12,n13,n14,n15,n16,n17,n18,
								n19,n20,n21,n22,n23,n24,n25,
								n26,n27,n28,n29,n30,final,id_escala,faltas,
								nota_perdida,nota_habilitacion,injustificadas,retraso,nivelacion,fecha) ".
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
								$row->retraso."','".$row->nivelacion."','".$row->fecha."')";
						$this->db->query($_SQL);
					}
				}
	  		}
			  														  		
		}	
		$this->trans_complete();
		if ($this->trans_status()) {
			$result = $this->get_request_ab();
		}else{
			$result	= $this->getError();
		}
		
		return $result;
	}
	
	function get_generate_cuadro_honor($per,$ck){
		$db	= $this->get_db_name();
		return $this->get_call_execute($db.".sp_gen_c_honor",$this->get_year().",".$per.",".$ck);
	}
	function upload_files_dig_est ($file,$cod_est) {
		$this->student_folders($cod_est);
		return $this->upload_file($file,$this->student_document_path);
	}	
	function read_files_dig_est ($cod_est) {
		$this->student_folders($cod_est);
		return $this->read_directory_files($this->student_document_path);
	}	
	function get_add_asignaturas($grado,$lista){
		$table	= $this->tabla_notas($grado);
		$lis 	= json_decode($lista);
		$extra	= array(
			'year'			=> $this->get_year()
		);		
		$this->insert_data_primary($table,$lis,$extra,FALSE);
	}
	
	function get_update_pass_est() {
		$db         = $this->get_db_name();	
		$query 	= "INSERT INTO ".$db.".users (user_id, names, last_name, username, password, user_type) 
		SELECT id, CONCAT(TRIM(nombre1),' ',TRIM(nombre2)), 
		CONCAT(TRIM(apellido1),' ',TRIM(apellido2)), nro_documento, 
		SHA1(nro_documento), 5 FROM ".$db.".inscripciones 
		ON DUPLICATE KEY UPDATE username = nro_documento, password = SHA1(nro_documento)";
		$query	= $this->db->query($query);
		return $this->getJsonResponse([],0);
	}
	
	function get_notas_save($c_grado,$fieldslist,$periodo){	
		$table		= $this->tabla_notas($c_grado);			
		$request 	= $this->update_data_primary($table,$fieldslist);		
		return	$request;
	}
	
	function get_notas($id,$periodo,$grado){
		$param = "'".$id."','".$periodo."',".$this->get_year().",'".$grado."'";				
		$request = $this->get_call('sp_select_notas_academicas_periodo',$param);		
		return $request;
	}
	
	function get_select_carga_notas($grado,$grupo,$jorn,$sede){		
		$param = "'".$sede."','".$jorn."','".$grado."','".$grupo."',".$this->get_year();				
		$request = $this->get_call('sp_select_cursos_notas',$param);		
		return $request;
	}
	
	function insert_carga($list){		
		$lista	= json_decode($list);			
		$extra = array(
			'year'			=> $this->get_year(),
			'id_school'		=> $this->get_id_school()
		);		
		$request = $this->insert_data_primary('cursos',$lista,$extra);						
		return $request;
	}
	
	function get_select_carga($grado){		
		$param = $this->get_year().",'".$grado."'";
		$request = $this->get_call('sp_select_cursos_grado',$param);		
		return $request;
	}
	
	function get_select_matcurso($grado){		
		$param = "'".$grado."',".$this->get_year();				
		$request = $this->get_call('sp_select_matcurso',$param);		
		return $request;
	}
	
	function get_select_asignaturas(){		
		$request = $this->get_table('asignaturas',$this->limit_max,$this->limit_min,null,'asignatura');		
		return $request;
	}
	
			
	function insert_archivos_digitales($cod,$file,$state,$codEst,$doc){
		
		$fileName = $file['name'];
        $fileTmp  = $file['tmp_name'];
        $filetype = $file['type'];		
        
        $foto	= $_SERVER["DOCUMENT_ROOT"]."/uploads/".basename($fileName);
        		
		if (is_uploaded_file($fileTmp)){
			if (move_uploaded_file($fileTmp,$foto)){
				$img  = fread(fopen($foto,"r"),filesize($foto));
				$foto = base64_encode($img);
				
				if ($state == 1){
					$query	= "INSERT INTO doc_digitales_est (id_estudiante,documento,mime,nombre_doc) 
					VALUES (".$codEst.",'".$foto."','".$filetype."','".$doc."')";
				}else{
					$query	= "UPDATE doc_digitales_est SET documento='".$foto.
					"',mime='".$filetype."',nombre_doc='".$doc."' WHERE id=".$cod;
				};				 
		
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
					$request = $this->M_sql->getError();
				}
				
			}else{
				$request = $this->M_sql->getError();
			}
			
		}else{
			$request = $this->M_sql->getError();
		}
		
		return $request;
		
	}
	
	function get_select_archivos_digitales($cod){
		
		$param = $cod;		
		
		return $this->get_call('sp_select_doc_digitales_est',$param);
	}
	
	function get_select_historial($cod){		
		$param = array($cod);		
		return $this->getExecute('sp_select_historial_matriculas(?)',$param);
	}
	
	public  function insert_familiares($lis,$cod){
		$lista = json_decode($lis);		
		$extra = array(
			'id_inst' 		=> $this->get_id_school()
		);
		$this->trans_start();
		$sql	= "SELECT id FROM familiares WHERE nro_documento=".$lista->nro_documento;
		$sql	= $this->db->query($sql);
		if($sql->num_rows() > 0){
			$id		= $sql->row('id');
			$result	= $this->get_request_ab();
		}else{
			$result = $this->insert_data_primary('familiares',$lista,$extra,TRUE);
			$id		= $this->last_insert_id();	
		}
		$query	= "INSERT INTO aux_families_students (id_family,cod_est,tipo_famil,parentesco) VALUES 
				  (".$id.",".$cod.",'".$lista->tipo_famil."','".$lista->parentesco."')";
		$this->db->query($query);
		
		$acud	= $lista->add_acud;
		$tipo	= $lista->tipo_famil;
		if (($acud > 0) AND ($tipo <> 'Acudiente')){
			$lista->tipo_famil = 'Acudiente';
			$query	= "INSERT INTO aux_families_students (id_family,cod_est,tipo_famil,parentesco) VALUES 
				  (".$id.",".$cod.",'".$lista->tipo_famil."','".$lista->parentesco."')";
			$this->db->query($query);
		}
		$this->trans_complete();
		if ($this->trans_status()){
			$result = $result;
		}else{
			$result = $this->getError();
		}
		return $result;
	}
	
	function get_update_familiares($list,$cod){	
		$db		= $this->get_db_name();
		$lista 	= json_decode($list);
		$this->trans_start();
		
		$sql	= "SELECT id_family FROM ".$db.".aux_families_students WHERE id=".$lista->id;
		$this->db->select('id');
		$this->db->from($db.'.aux_families_students');
		
		$sql	= $this->db->query($sql);
		if($sql->num_rows() > 0){
			$id		= $sql->row('id_family');
			$result	= $this->updateData('aux_families_students',$lista);
			$lista->id = $id;
			$result	= $this->updateData('familiares',$lista);
		}else{
			$result = $this->getJsonResponse([],0);
		}
		$this->trans_complete();
		if ($this->trans_status()){
			$result = $result;
		}else{
			$result = $this->getError();
		}
		return $result;
	}
	
	
	function get_select_student_enrollment($id = 0){		
		$query 	= "id=".$id;
		return $this->get_table('student_enrollment',1,0,$query);
	}
	
	function insert_inscripciones($list){
		$lista = json_decode($list);		
		$result = '';		
		$doc	= $lista->nro_documento;	
		$db		= $this->get_db_name();	
		$this->db->select('id, nro_documento');
		$this->db->from($db.'.inscripciones');
		$this->db->where('nro_documento', $doc);
		$this->db->limit(1);		
		$query_sel	= $this->db->get();
		if ($query_sel){
			try {
				$this->trans_start();	
				if ($query_sel->num_rows() > 0){
					$this->db->select("*,CONCAT(RTRIM(apellido1),' ',RTRIM(apellido2),' ',RTRIM(nombre1),' ',RTRIM(nombre2)) AS nombres");
					$this->db->from($db.'.inscripciones');				
					$this->db->where('nro_documento', $doc);
					$this->db->limit(1);
					$this->db->order_by('nombres');
					$query_ins	= $this->db->get();

					$lista->id_student = $query_sel->row('id');				
					$this->insertData('student_enrollment',$lista,'id',NULL);			
					$this->trans_commit();	
					$result = $this->getJsonResponse($query_ins->result_array(),1);
				}else{					

					$id = $this->insertData('inscripciones',$lista,'id',NULL,TRUE);					
					$lista->id_student = $id;			
					$this->insertData('student_enrollment',$lista,'id',NULL);
					$this->trans_complete();				
					if ($this->trans_status()){
						$this->db->select("*,CONCAT(RTRIM(apellido1),' ',RTRIM(apellido2),' ',RTRIM(nombre1),' ',RTRIM(nombre2)) AS nombres");
						$this->db->from($db.'.inscripciones');				
						$this->db->where('id', $id);
						$this->db->limit(1);
						$this->db->order_by('nombres');				
						$query_ins	= $this->db->get();
						$result 	= $this->getJsonResponse($query_ins->result_array(),1);
					}else{
						$result = $this->getError();
					}
				}
			} catch (Exception $e) {
				$this->trans_rollback();
				$result = $this->getError();
			}
		}else{
			$result = $this->getError();
		}		
		return $result;
	}
	
	function get_select_inscripciones($id = 0,$fields,$qSearch){		
		$fl		= json_decode($fields);
		$extra	= NULL;
		$count	= 0;
		$db	= $this->get_db_name();	
		$tb	= $db.'.inscripciones';
		if (is_array($fl)){
			$count	= count($fl);
		}
		if ($count > 0 AND strlen($qSearch) > 0){
			$arraySearch = explode(' ',$qSearch);
			$index		 = array_search('nombres',$fl);
			unset($fl[$index]);
			array_unshift($fl,'apellido1','apellido2','nombre1','nombre2');
			$count	= count($fl);
			if ($count == 1){
				$extra  = $fl[0]." REGEXP '".$qSearch."'";
				$this->db->where($extra);
			}else{
				$count	= count($arraySearch);
				if($count > 1){
					$search1 = $arraySearch[0];
					$search2 = $arraySearch[1];
					foreach($fl as $key => $value){						
						foreach($fl as $keyUP => $valueUP){
							if ($valueUP <> $value){
								$extra  = $value." REGEXP '".$search1."' AND ".$valueUP." REGEXP '".$search2."'";
								$this->db->select($value);
								$this->db->from($tb);
								$this->db->where($extra);																
						        $this->db->limit(1);																					
								$query	= $this->db->get();
								if ($query->num_rows() > 0){
									$this->db->where($extra);
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
						$this->db->from($tb);
						$this->db->where($extra);	
						$this->db->limit(1);																					
						$query	= $this->db->get();								;
						if ($query->num_rows() > 0){
							$this->db->where($extra);
							break;
						}
					}		
				}			
			}
		}

		$this->db->select("*,"."CONCAT(RTRIM(apellido1),' ',RTRIM(apellido2),' ',RTRIM(nombre1),' ',RTRIM(nombre2)) AS nombres");
		$this->db->from($tb);
		$this->db->limit($this->limit_max,$this->limit_min);		
		if($id > 0 ){
			$this->db->where('id', $id);			
		}					
		$this->db->order_by('nombres');				
		$query		= $this->db->get();
		$total		= $this->get_count_all('inscripciones',$extra);
		if($query){
			$query	= $this->get_request_select($query->result_array(), $total);
		}else{
			$query	= $this->getError();
		}
		return $query;
	}
}