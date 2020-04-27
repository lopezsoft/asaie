
<?php
defined('BASEPATH') OR exit('No direct script access allowed');
class C_docentes extends SME_Controller {
	function __construct() {
		parent::__construct();
		$this->load->model('M_docentes');
	}
	public function upload_files_dig() {
		$file  		= $_FILES['foto'];
		$cod		= $this->input->get_post('pdbDocumento');
		echo $this->M_docentes->upload_files_dig($file,$cod);
	}
	
	public function read_files_dig() {
		$cod		= $this->input->get_post('pdbDocumento');
		echo $this->M_docentes->read_files_dig($cod);
	}	
	public function read_files_mat_educ() {
		echo $this->M_docentes->read_files_mat_educ();
	}
	
	public function get_select_respuestas_evaluacion(){
	 	$preg	= $this->input->get_post('pdbPregunta');
		echo $this->M_docentes->get_select_respuestas_evaluacion($preg);
	}
	
	public function get_select_preguntas_evaluacion(){
	 	$evaluacion	= $this->input->get_post('pdbEvaluacion');
		echo $this->M_docentes->get_select_preguntas_evaluacion($evaluacion);
	}
	
	public function get_select_evaluaciones_est(){
	 	$curso	= $this->input->get_post('pdbCurso');
		echo $this->M_docentes->get_select_evaluaciones_est($curso);
	}
	
	public function get_select_material_educ(){
	 	$curso	= $this->input->get_post('pdbCurso');
		echo $this->M_docentes->get_select_material_educ($curso);
	}
	
	public function upload_files_mat_educ (){		
		$file	= $_FILES['foto'];
		echo $this->M_docentes->upload_files_mat_educ($file);
	}
	
	public function get_select_reg_actividades(){
	 	$curso	= $this->input->get_post('pdbCurso');
		echo $this->M_docentes->get_select_reg_actividades($curso);
	}
	
	public function read_images(){
		echo $this->M_docentes->read_images();
	}
	
	public function upload_foto(){
		$file  = $_FILES['foto'];
		echo $this->M_docentes->upload_foto($file);
	}
	
	public function get_asig_grado_carga(){
		$sede	= $this->input->get_post('pdbSede');
		$grado	= $this->input->get_post('pdbGrado');
		echo $this->M_docentes->get_asig_grados_carga($grado,$sede);
	}
	
	public function get_asig_grados_grupos_carga(){
		$sede	= $this->input->get_post('pdbSede');
		$grado	= $this->input->get_post('pdbGrado');
		$grupo	= $this->input->get_post('pdbGrupo');
		echo $this->M_docentes->get_asig_grados_grupos_carga($grado,$grupo,$sede);
	}
	
	public function get_grupos_carga(){
		$sede	= $this->input->get_post('pdbSede');
		$grado	= $this->input->get_post('pdbGrado');
		echo $this->M_docentes->get_grupos_carga($grado,$sede);
	}
	
	public function get_grados_carga(){
		$sede	= $this->input->get_post('pdbSede');
		echo $this->M_docentes->get_grados_carga($sede);
	}
	
	public function get_update_preinforme () {
		$list		= ($this->input->post('records'));
		$grado 		= $this->input->post_get('pdbGrado');		
		echo $this->M_docentes->get_update_preinforme($list,$grado);
	}
	
	public function get_preinforme() {
		$grado 		= $this->input->get('pdbGrado');
		$grupo		= $this->input->get('pdbGrupo');
		$periodo	= $this->input->get('pdbPeriodo');
		$curso		= $this->input->get('pdbCurso');
		echo $this->M_docentes->get_preinforme($grado,$grupo,$periodo,$curso);
	}
	
	public function get_select_docentes() {
		echo $this->M_docentes->get_select_docentes();
	}
	
	public function get_update_docentes () {
		$lista	= $this->input->post('records');
		
		echo $this->M_docentes->get_update_docentes($lista);
	}
	
	
}