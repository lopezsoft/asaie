<?php
defined('BASEPATH') OR exit('No direct script access allowed');
class Recuperaciones extends SME_Controller {
	function __construct() {
		parent::__construct();
		$this->load->model('M_recuperaciones');
		$this->load->model('M_actividades_apoyo_finales');
	}
	
	public function get_act_apoyo_finales(){
		$doc	= $this->input->post_get('pdbDocente');
		$type	= $this->input->post_get('pdbType');
		echo 	$this->M_actividades_apoyo_finales->get_acta($doc,$type);
	}
	
	public function get_recuperaciones_finales(){
		$docente	= $this->input->post_get('pdbDocente');
		$request	= $this->M_recuperaciones->get_select_recuperaciones_finales($docente);
		
		echo $request;
	}
	

	public function get_recuperaciones () {		
		$grado		= $this->input->get_post('pdbGrado');
		$asig		= $this->input->get_post('pdbAsig')	;
		$periodo	= $this->input->get_post('pdbPeriodo')	;
		$docente	= $this->input->get_post('pdbType')	;
		$nivel		= $this->input->get_post('pdbNivel');	
		echo $this->M_recuperaciones->get_recuperaciones($grado,$asig,$periodo,$docente,$nivel);
	}
	
	public function get_recuperaciones_b() {
		$grado	= $this->input->get_post('pdbGrado');
		$asig	= $this->input->get_post('pdbAsig')	;
		$periodo	= $this->input->get_post('pdbPeriodo')	;
		$docente	= $this->input->get_post('pdbType')	;
		$nivel		= $this->input->get_post('pdbNivel');	
		$fieldslist = $_POST['records'];		
		echo $this->M_recuperaciones->get_recuperaciones_b($grado,$asig,$fieldslist,$periodo,$nivel);
	}
	
}