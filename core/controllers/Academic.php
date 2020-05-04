<?php
defined('BASEPATH') OR exit('No direct script access allowed');
class Academic extends SME_Controller {
	function __construct() {
		parent::__construct();
		$this->load->model('Academic_m');
		$this->check_session_redirect();
	}

	function get_select_asignaturas_year(){
		echo $this->Academic_m->select_asignaturas_year(0);
	}

	function insert_aux_asignaturas(){
		$id	= $this->input->post_get('pdbId');
		$list = $this->input->get_post('records');
		echo $this->Academic_m->insert_aux_asignaturas($id,$list);
	}

	function get_select_aux_asignaturas() {
		$tb		= $this->input->post_get('pdbTable');
		$id		= $this->input->post_get('pdbId');
		echo 	$this->Academic_m->select_aux_asignaturas($id);
	}
	
	function get_transferir_notas(){
		$id		   = $this->input->get_post('pdbId');
		$list		= $this->input->get_post('pdbList');
		echo $this->Academic_m->get_transferir_notas($id,$list);
	}
	
	function get_force_delete_matricula(){
		$list	= $this->input->post_get('records');
		$f		= $this->input->post_get('pdbForce');
		echo $this->Academic_m->force_delete_matricula($list,$f);
	}
	
	function upload_foto_webcam(){
		$cod_est	= $this->input->get_post('pdbCodEst');
		$file  		= $this->input->get_post('foto');
		echo $this->Academic_m->upload_foto_webcam($file,$cod_est);
	}
	
	function upload_foto(){
		$cod_est	= $this->input->get_post('pdbCodEst');
		$file  = $_FILES['foto'];
		echo $this->Academic_m->upload_foto($file,$cod_est);
	} 	 	
 	function read_images(){
 		$cod_est	= $this->input->get_post('pdbCodEst');
		echo $this->Academic_m->read_images($cod_est);
	}
	
	function get_pre_matricula_viejos(){
		echo $this->Academic_m->get_pre_matricula_viejos();
	}
	
	function get_pre_matricula_nuevos(){
		echo $this->Academic_m->get_pre_matricula_nuevos();
	}
		
	function insert_asignaturas_certificados(){
		$id	= $this->input->post_get('pdbId');
		$list = $this->input->get_post('records');
		echo $this->Academic_m->insert_asignaturas_certificados($id,$list);
	}
	
	function get_select_asignaturas_certificados(){
		$id	= $this->input->post_get('pdbId');
		echo $this->Academic_m->select_asignaturas_certificados($id);
	}
	
	function get_mayus(){
		$pdbPeriodo 	= $this->input->post_get('pdbPeriodo');
		echo $this->Academic_m->get_mayus($pdbPeriodo);
	}
	
	function get_mover_estudiantes(){
		$grado		= $this->input->get_post('pdbGrado');
		$grupo 		= $this->input->get_post('pdbGrupo');
		$jorn 		= $this->input->get_post('pdbJorn');
		$sede 		= $this->input->get_post('pdbSede');
		$gradoMove	= $this->input->get_post('pdbGradoMove');
		$list		= $this->input->get_post('pdbList');
		echo $this->Academic_m->get_mover_estudiantes($grado,$grupo,$jorn,$sede,$gradoMove,$list);
	}
	
	function get_generate_cuadro_honor(){
		$pdbPeriodo 	= $this->input->post_get('pdbPeriodo');
		$pdbCk		 	= $this->input->post_get('pdbCk');
		echo $this->Academic_m->get_generate_cuadro_honor($pdbPeriodo,$pdbCk);
	}
		
	function upload_files_dig_est() {
		$file  		= $_FILES['foto'];
		$cod_est	= $this->input->get_post('pdbCodEst');
		echo $this->Academic_m->upload_files_dig_est($file,$cod_est);
	}
	function read_files_dig_est() {
		$cod_est	= $this->input->get_post('pdbCodEst');
		echo $this->Academic_m->read_files_dig_est($cod_est);
	}
	function get_add_asignaturas(){
		$grado	= $this->input->get_post('pdbGrado');
		$lista	= $this->input->get_post('records');
		echo $this->Academic_m->get_add_asignaturas($grado,$lista);
	}
	
	function get_update_pass_est(){
		echo $this->Academic_m->get_update_pass_est();
	}
	
	function get_notas_save(){
		$c_grado	= $this->input->get_post('pdbCodGrado')	;
		$periodo	= $this->input->get_post('pdbPeriodo')	;		
		$fieldslist = $this->input->get_post('records');		
		$request 	= $this->Academic_m->get_notas_save($c_grado,$fieldslist,$periodo);		
		echo $request;
	}
	
	function get_notas(){
		$id 		= $this->input->get_post('pdbMatric');
		$periodo	= $this->input->get_post('pdbPeriodo');
		$grado		= $this->input->get_post('pdbCodGrado');
		
		echo $this->Academic_m->get_notas($id,$periodo,$grado);
	}
	
	function get_select_carga_notas(){
		$grado = $this->input->get_post('pdbGrado');
		$grupo = $this->input->get_post('pdbGrupo');
		$jorn = $this->input->get_post('pdbJorn');
		$sede = $this->input->get_post('pdbSede');
		
		echo $this->Academic_m->get_select_carga_notas($grado,$grupo,$jorn,$sede);
	}
	
	function insert_carga(){
		$list = $this->input->get_post('records');
		echo $this->Academic_m->insert_carga($list);
	}
	
	function get_select_carga(){
		$grado = $this->input->get_post('pdbGrado');
		echo $this->Academic_m->get_select_carga($grado);
	}
	
	function get_select_matcurso(){
		$grado = $this->input->get_post('pdbGrado');
		echo $this->Academic_m->get_select_matcurso($grado);
	}
	
	function get_select_asignaturas(){
		echo $this->Academic_m->get_select_asignaturas();
	}
	
	function insert_asignaturas(){
		$list = $this->input->get_post('records');
		echo $this->Academic_m->insert_asignaturas($list);
	}
	
	function get_update_asignaturas(){
		$list = $this->input->get_post('records');
		echo $this->Academic_m->get_update_asignaturas($list);
	}
	
	function insert_areas(){
		$list = $this->input->get_post('records');
		echo $this->Academic_m->insert_areas($list);
	}
	
	function get_update_areas(){
		$list = $this->input->get_post('records');
		echo $this->Academic_m->get_update_areas($list);
	}
	
	function insert_archivos_digitales(){
		$cod = $this->input->get_post('pId');
		$state = $this->input->get_post('pAdd');
		$file  = $_FILES['foto'];
		$codEst	= $this->input->get_post('pIdEst'); 
		$doc	= $this->input->get_post('nombre_doc');
		
		echo $this->Academic_m->insert_archivos_digitales($cod,$file,$state,$codEst,$doc);
	}
	
	function get_select_archivos_digitales(){
		$cod = $this->input->get_post('cod_est');
		echo $this->Academic_m->get_select_archivos_digitales($cod);
	}
	
	function get_select_historial(){
		$cod = $this->input->get_post('id_student');
		echo $this->Academic_m->get_select_historial($cod);
	}
	
	function get_update_familiares(){
		$list = $this->input->post('records');
		$cod  = $this->input->post('pdbIdStudent');
		echo $this->Academic_m->get_update_familiares($list,$cod);
	}
	
	function insert_familiares(){
		$list = $this->input->post('records');
		$cod  = $this->input->post('cod_est');
		echo $this->Academic_m->insert_familiares($list,$cod);
	}
	
	function get_select_familiares(){
		$id = $this->input->get_post('pdbIdStudent');
		echo $this->Academic_m->get_select_familiares($id);
	}
	
	function get_select_matriculas(){
		$id = $this->input->get_post('id');
		echo $this->Academic_m->get_select_student_enrollment($id);
	}
	
	function insert_inscripciones(){
		$list = $this->input->post('records');
		echo $this->Academic_m->insert_inscripciones($list);		
	}
	
	function get_select_inscripciones(){
		$id		= $this->input->get_post('pdbId');
		$fields	= $this->input->get_post('fields');
		$query	= $this->input->get_post('query');
		echo $this->Academic_m->get_select_inscripciones($id,$fields,$query);
	}
}