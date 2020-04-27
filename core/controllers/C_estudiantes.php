<?php
defined('BASEPATH') OR exit('No direct script access allowed');
 class C_estudiantes extends SME_Controller {
 	function __construct() {
 		parent::__construct();
 		$this->load->model('M_estudiantes');
 	} 	
 	public function get_select_evaluaciones_estudiantes(){
 		$id	= $this->input->get_post('pdbIdEva');
		echo $this->M_estudiantes->get_select_evaluaciones_estudiantes($id);
	} 
 	public function get_select_evaluaciones(){
		echo $this->M_estudiantes->get_select_evaluaciones();
	} 
 	public function get_select_material_educ(){
		echo $this->M_estudiantes->get_select_material_educ();
	} 	
 	public function get_notas(){
		echo $this->M_estudiantes->get_notas();
	} 	
 	public function get_docentes_curso(){
		echo $this->M_estudiantes->get_docentes_curso();
	} 	 	
 	public function get_select_perfil(){
		echo $this->M_estudiantes->get_select_perfil();
	} 	
 	public function upload_foto(){
		$file  = $_FILES['foto'];
		echo $this->M_estudiantes->upload_foto($file);
	} 	 	
 	public function read_images(){
		echo $this->M_estudiantes->read_images();
	}
 	
 }