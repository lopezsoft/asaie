<?php
defined('BASEPATH') OR exit('No direct script access allowed');
class c_sugerencias extends SME_Controller {
	function __construct() {
		parent::__construct();
		$this->load->model('M_sugerencias');
	}
	
	public function get_delete_estudiantes () {
		$cod_grado	= $_POST['pdbGrado'];
		$list		= json_decode($_POST['records']);
				
		$request = $this->M_sugerencias->get_delete_estudiantes($list,$cod_grado);
		
		echo $request;
	}
	
	public function get_select_estudiantes () {
		$cod_grado	= $this->input->get_post('pdbGrado');
		$id_asig	= $this->input->get_post('pdbAsig');
		$grupo		= $this->input->get_post('pdbGrupo');
		$id_sede	= $this->input->get_post('pdbSede');
		$cod_jorn	= $this->input->get_post('pdbJorn');
		$periodo 	= $this->input->get_post('pdbPeriodo') ? $this->input->get_post('pdbPeriodo') : 0;
			
		$request = $this->M_sugerencias->get_select_estudiantes($cod_grado,$periodo,$id_sede,$cod_jorn,$grupo,$id_asig);
		
		echo $request;
	}
	
	public function insert_sugerencias_est () {
		$cod_grado	= $_POST['pdbGrado'];
		$list		= json_decode($_POST['records']);
		$this->M_sugerencias->insert_sugerencias_est($list,$cod_grado);
	}
	
	/**
	* Funciones para la tabla de sugerencias
	* 
	* @return
	*/
	
	public function get_sugerencias () {
		
		$periodo = $this->input->get_post('pdbPeriodo') ? $this->input->get_post('pdbPeriodo') : 0;
		$request = $this->M_sugerencias->get_select_sugerencias($periodo);
		
		echo $request;
	}
	
	public function insert_sugerencias () {
		
		$field_list = json_decode($_POST['records']);
		
		$table = $_POST['pdbTable'];
		
		$request = $this->M_sugerencias->insert_sugerencias($table,$field_list);
		
		echo $request;
	}
	
	public function get_update_sugerencias () {
		
		$field_list = $_POST['records'];
		
		$table = $_POST['pdbTable'];
		
		$request = $this->M_sugerencias->get_update_sugerencias($table,$field_list);
		
		echo $request;
	}
			
}