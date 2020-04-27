<?php
defined('BASEPATH') OR exit('No direct script access allowed');
class C_notas extends SME_Controller {
	function __construct() {
		parent::__construct();
		$this->load->model('M_notas');
	}
	
	public function logros_estandares_verify () {
		$periodo 	= $this->input->post('pdbPerio');
		$grado		= $this->input->post('pdbGrado');
		$asig		= $this->input->post('pdbAsig');
		echo $this->M_notas->get_logros_estandares_verify($periodo,$grado,$asig);
	}
	
	/**
	* Funcion para seleccionar los datos de los estudiantes con ausencias
	* 
	* @return
	*/
	public function get_select_ausencias () {
		echo $this->M_notas->get_select_ausencias();
	}
	
	/**
	* Funcion que guarda los logros e indicadores de desempeños
	* 
	* @return
	*/
	
	public function get_logro_estandares_save () {
		$list		= json_decode($this->input->post_get('records'));
		$grado		= $this->input->post_get('pdbGrado');		
		$request	= $this->M_notas->get_logro_estandares_save($list,$grado);
		echo $request;
	}

	function notas_delete(){
		$grade		= $this->input->post_get('pdbCodGrado');
		$recors		= $this->input->post_get('records');
		echo 	$this->M_notas->notas_delete($grade,$recors);
	}	
	/**
	* Funciones para las tablas de notas
	* 
	* @return
	*/
	public function get_notas () {		
		$type		= $this->input->get_post('pdbTable');
		$grado		= $this->input->get_post('pdbGrado');
		$curso		= $this->input->get_post('pdbCurso');
		$jorn		= $this->input->get_post('pdbJorn');
		$sede		= $this->input->get_post('pdbSede');
		$grupo		= $this->input->get_post('pdbGrupo');
		$periodo	= $this->input->get_post('pdbPeriodo');
		$sexo		= isset($_GET['pdbSexo']) ? $_GET['pdbSexo'] :'MX';			
		echo $this->M_notas->get_notas($type,$grado,$curso,$jorn,$sede,$grupo,$periodo,$sexo);	
	}	
	public function get_sync_notas(){
		$grado		= $this->input->post_get('pdbGrado');
		$curso		= $this->input->post_get('pdbCurso');
		$jorn		= $this->input->post_get('pdbJorn');
		$sede		= $this->input->post_get('pdbSede');
		$grupo		= $this->input->post_get('pdbGrupo');
		$periodo	= $this->input->post_get('pdbPeriodo');	
		$asig		= $this->input->post_get('pdbAsig');		
		$this->M_notas->insert_log_notas($grado,$curso,$jorn,$sede,$grupo,$periodo,$asig);
	}	
	public function get_notas_save () {		
		$grado		= $this->input->post_get('pdbGrado');
		$curso		= $this->input->post_get('pdbCurso');
		$jorn		= $this->input->post_get('pdbJorn');
		$sede		= $this->input->post_get('pdbSede');
		$grupo		= $this->input->post_get('pdbGrupo');
		$periodo	= $this->input->post_get('pdbPeriodo');	
		$asig		= $this->input->post_get('pdbAsig');		
		$fieldslist = $this->input->post_get('records');
		
		$request 	= $this->M_notas->get_notas_save($grado,$fieldslist,$periodo,$curso,$jorn,$sede,$grupo,$asig);		
		echo $request;
	}
}