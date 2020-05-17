<?php
defined('BASEPATH') OR exit('No direct script access allowed');
class Students_m extends SME_Model {
	function __construct() {
		parent::__construct();
		$this->student_folders($this->get_student_id());
	}	

	function getCommentsActivities($id, $course_id, $enrollment){
		$param	= array(
			$id,
			$course_id,
			$enrollment
		);
		return $this->getExecute('sp_select_comments_activities(?, ?, ?)',$param);
	}

	public function setCommentsActivities($file, $comment, $id, $course_id, $activity_id, $comment_title){
		$url	= $this->activities_comments_folder().PATH_DELIM.'A'.$activity_id.PATH_DELIM.'C'.$course_id.PATH_DELIM.'M'.$id.PATH_DELIM;
		$path	= $this->directory_path.$url;
		$mime	= '';
		$db		= $this->get_db_name();
		if(!is_dir($path)){
			mkdir($path,0777, true);
		}	
		$fileSize = $file['size'];
		if ($fileSize > 2048000) {
			$request = array(
				'success'       => false,
				'error'			=> 'No se permite subir archivos mayores a 2 MB'
			);
			$request = json_encode($request);
		}else{
			try {
				if(!$fileSize > 0){
					$mime	= '';
					$url	= '';
				}
				$data	= array(
					'shared_activity_id'	=> $id,
					'comment_activity'		=> $comment,
					'comment_title'			=> $comment_title,
					'url_attached'			=> $url,
					'mime'					=> $mime,
					'type_comment'			=> 2 // Comments by student
				);
				$this->trans_begin();
				$this->db->insert($db.'.ta_comments_activities', $data);
				$id	= $this->getInsertId();
				// Si se adjunta un archivo realiza las siguientes operaciones
				if($fileSize > 0){
					$path	= $url.$id;
					if(!is_dir($path)){
						mkdir($path,0777, true);
					}
					if(is_dir($path)){
						$result	= json_decode($this->upload_file($file, $path));
						if($result->success){
							$data	= array(
								'url_attached'			=> $result->foto,
								'mime'					=> $result->mime,
							);
							$this->db->where('id', $id);
							$this->db->limit(1);
							$this->db->update($db.'.ta_comments_activities', $data);
							$this->trans_commit();
							$request = $this->getJosnSuccess();
						}else{
							$request = $result;
							$this->trans_rollback();
						}
					}
				}else{
					$this->trans_commit();
					$request = $this->getJosnSuccess();
				}
			} catch (Exception $e) {
				$this->trans_rollback();
				$request	= $this->error_success();
			}
		}
		return $request;
	}
	public function get_select_evaluaciones_estudiantes($id){
		$query	= "SELECT * FROM te_evaluaciones_estudiantes WHERE id_evaluacion_compartida=".$id;
		return	$this->get_query($this->limit_min,$this->limit_max,$query);
	}
	public function getStudentsEvaluations() {		
		$param	= array(
			$this->get_get_idmatric()
		);
		return $this->getExecute('sp_select_students_evaluations(?)',$param);
	}
	public function getStudentsActivities() {		
		$param	= array(
				$this->get_get_idmatric()
		);
		return $this->getExecute('sp_students_activities(?)',$param);
	}
		
	public function get_notas(){
		$id			= $this->get_get_idmatric();
		$param 		= array(
			$id,
			$this->get_year()
		);
		return $this->getExecute('sp_select_notas_academicas_estudiante (?, ?) ',$param);
	}
	
	public function get_docentes_curso(){
		$db	= $this->get_db_name();
		$this->db->where('id_student', $this->get_student_id());
		$this->db->where('year', $this->get_year());
		$qm		= $this->db->get($db.'.student_enrollment');
		$row	= $qm->row();
		if($row){
			
			$this->db->select("tc.id,tc.id_docente,tc.grupo,RTRIM(tg.grado) grado,RTRIM(tj.jornada) jornada,RTRIM(ta.asignatura) ".
				  "asignatura,RTRIM(ts.NOMBRE_SEDE) sede,CONCAT(RTRIM(td.apellido1),' ',RTRIM(td.apellido2),' ',".
				  "RTRIM(td.nombre1),' ',RTRIM(td.nombre2)) nombres, td.image, td.mime, tc.year, 
				  td.movil,RTRIM(td.email) email ");
			$this->db->from($db.'.cursos AS tc');			
			$this->db->join($db.".grados 		AS tg", "tc.id_grado=tg.id ","left");
			$this->db->join($db.".jornadas 		AS tj", "tc.id_jorn=tj.cod_jorn ","left");
			$this->db->join($db.".asignaturas 	AS ta", "tc.id_asig=ta.id_pk ","left");
			$this->db->join($db.".sedes 		AS ts", "tc.id_sede=ts.ID ","left");
			$this->db->join($db.".docentes 		AS td", "tc.id_docente = td.id_docente","left");
			$this->db->where('tc.estado=1');
			$this->db->where('tc.year', $this->get_year());
			$this->db->where('tc.id_grado', $row->id_grade);
			$this->db->where('tc.grupo', $row->id_group);
			$this->db->where('tc.id_jorn', $row->id_study_day);
			$this->db->where('tc.id_sede', $row->id_headquarters);
			$this->db->where('tc.id_grado', $row->id_grade);
			$this->db->order_by('asignatura', 'asc');
			$query	= $this->db->get();
			$result	= $this->getJsonResponse($query->result(), $query->num_rows());
		}else{
			$result = $this->getError();
		}
		
		return $result;
		
	}
	
	public function get_select_perfil(){
		$query	= "SELECT id,id_estudiante,nombre_usuario,foto_perfil,mime,fecha,estado,timestamp ".
				" FROM usuarios_estu WHERE id=".$this->id_usuario;
		return $this->get_query($this->limit_min,$this->limit_max,$query);
	}
	
	public function upload_foto($file){		
		return $this->upload_file($file,$this->dirPathImgEstudiantes);
	}
	
	public function read_images(){
		$dir	= $this->dirPathImgEstudiantes;
		return	$this->read_directory_files($dir);
	}
}