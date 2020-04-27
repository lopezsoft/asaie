<?php
defined('BASEPATH') OR exit('No direct script access allowed');
class M_estudiantes extends SME_Model {
	function __construct() {
		parent::__construct();
		$this->get_id_estudiante();
		$this->folders_estudiantes($this->get_id_estudiante());
	}	
	public function get_select_evaluaciones_estudiantes($id){
		$query	= "SELECT * FROM te_evaluaciones_estudiantes WHERE id_evaluacion_compartida=".$id;
		return	$this->get_query($this->limit_min,$this->limit_max,$query);
	}
	public function get_select_evaluaciones() {		
		$param	= "'".$this->get_id_school()."','".$this->get_year()."','".$this->get_get_idmatric()."'";
		return $this->get_call('sp_select_evaluacion_estudiantes',$param);
	}
	public function get_select_material_educ() {		
		$param	= "'".$this->get_id_school()."','".$this->get_year()."','".$this->get_get_idmatric()."'";
		return $this->get_call('sp_select_material_edu_est',$param);
	}
		
	public function get_notas(){
		$id		= $this->get_get_idmatric();
		$param = $this->get_id_school().",'".$this->get_year()."','".$id."'";				
		$request = $this->get_call('sp_select_notas_academicas_estudiante',$param);		
		return $request;
	}
	
	public function get_docentes_curso(){
		
		$qm	= "SELECT cod_grado,grupo,id_jorn,id_sede FROM matriculas WHERE ".
			  "cod_est=".$this->id_est." AND id_inst=".$this->get_id_school()." AND año=".$this->get_year();
		$qm	= $this->db->query($qm);
		if($qm){
			$cod_grado 	= $qm->row('cod_grado');
			$grupo 		= $qm->row('grupo');
			$cod_jorn	= $qm->row('id_jorn');
			$id_sede	= $qm->row('id_sede');
			
			$query	= 
				 "SELECT tc.id_docente,tc.grupo,RTRIM(tg.grado) grado,RTRIM(tj.jornada) jornada,RTRIM(ta.asignatura) ".
				  "asignatura,RTRIM(ts.nom_sede) sede,CONCAT(RTRIM(td.apellido1),' ',RTRIM(td.apellido2),' ',".
				  "RTRIM(td.nombre1),' ',RTRIM(td.nombre2)) nombres, td.foto, td.mime, td.año, 
				  td.movil,RTRIM(td.e_mail) e_mail FROM cursos AS tc ".
				  "LEFT JOIN grados AS tg ON tc.cod_grado=tg.cod_grado ".
				  "LEFT JOIN jornadas AS tj ON tc.cod_jorn=tj.cod_jorn ".
				  "LEFT JOIN asignaturas AS ta ON tc.id_asig=ta.id ".
				  "LEFT JOIN sedes AS ts ON tc.id_sede=ts.id ".
				  "LEFT JOIN docentes AS td ON tc.id_docente = td.id_docente";
				  
			$where	= "tc.estado=1 AND tc.id_inst= ? AND tc.año= ? AND tc.cod_grado= ? AND tc.grupo= ? 
					  AND tc.cod_jorn=? ".
				  	  "AND tc.id_sede= ? AND ta.año= ? AND ta.id_inst= ? AND td.año= ? AND td.id_inst= ?".
				  	  " ORDER BY asignatura";
			
			$param	= array(
				$this->get_id_school(),
				$this->get_year(),
				$cod_grado,
				$grupo,
				$cod_jorn,
				$id_sede,
				$this->get_year(),
				$this->get_id_school(),
				$this->get_year(),
				$this->get_id_school()
			);
			
			$result = $this->get_query_param($this->limit_min,$this->limit_max,$query,$where,$param);
			
		}else{
			$result = $this->get_error();
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