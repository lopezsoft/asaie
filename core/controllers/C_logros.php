<?php
defined('BASEPATH') OR exit('No direct script access allowed');
class C_logros extends SME_Controller {
	function __construct() {
		parent::__construct();		
		$this->load->model('M_logros');
		$this->load->model('M_notas');
	}
	
	public function get_importar_logros_ind () {
		$grado	= $this->input->post_get('pdbGrado');
		$asig	= $this->input->post_get('pdbAsig');
		$sede	= $this->input->post_get('pdbSede');
		echo  $this->M_logros->get_importar_logros_ind($grado,$asig,$sede);
	}
	
	public function get_delete_logros_estudiantes_all () {
		$cod_grado	= $this->input->post_get('pdbGrado');
		$list		= json_decode($this->input->post_get('records'));				
		$request = $this->M_logros->get_delete_logros_estudiantes_all($list,$cod_grado);		
		echo $request;
	}
	
	public function get_select_logros_estudiantes_all () {
		$grado		= $this->input->get_post('pdbGrado');
		$asig		= $this->input->get_post('pdbAsig');
		$periodo	= (isset($_GET['pdbPeriodo'])?$_GET['pdbPeriodo']:"0");
		$grupo		= $this->input->get_post('pdbGrupo');
		$sede		= $this->input->get_post('pdbSede');
		$jorn		= $this->input->get_post('pdbJorn');					
		$request 	= $this->M_logros->get_select_logros_estudiantes_all($grado,$asig,$periodo,$grupo,$sede,$jorn);
		
		echo $request;
	}
	
	public function get_delete_logros_estudiantes () {
		$cod_grado	= $_POST['pdbCodGrado'];
		$id_asig	= $_POST['pdbIdAsig'];
		$periodo	= (isset($_POST['pdbPeriodo'])?$_POST['pdbPeriodo']:"0");
		$id_nota	= $_POST['pdbIdNota'];
		$list		= json_decode($_POST['records']);
				
		$request = $this->M_logros->get_delete_logros_estudiantes($list,$cod_grado,$id_nota);
		
		echo $request;
	}
	
	public function get_select_logros_estudiantes () {
		$cod_grado	=$this->input->post_get('pdbCodGrado');
		$id_asig	=$this->input->post_get('pdbIdAsig');
		$periodo	= (isset($_GET['pdbPeriodo'])?$_GET['pdbPeriodo']:"0");
		$id_nota	=$this->input->post_get('pdbIdNota');
				
		$request = $this->M_logros->get_select_logros_estudiantes($cod_grado,$id_asig,$periodo,$id_nota);
		
		echo $request;
	}
	
	public function get_logros_update () {
		$listado	= $this->input->post_get('records');
		$grado		= $this->input->post_get('pdbGrado');
		$asig		= $this->input->post_get('pdbAsig');
		$grupo		= $this->input->post_get('pdbGrupo');
		$sede		= $this->input->post_get('pdbSede');
		$jorn		= $this->input->post_get('pdbJorn');
		$curso		= $this->input->post_get('pdbCurso');
		$per		= $this->input->post_get('pdbPeriodo');	
		$table		= $this->input->post_get('pdbTable');
		echo $this->M_logros->get_logros_update($table,$listado);
		$this->M_notas->insert_log_notas($grado,$curso,$jorn,$sede,$grupo,$per,$asig);
	}
	
	public function get_logros_insert(){
		$listado	= $this->input->post_get('records');
		$grado		= $this->input->post_get('pdbGrado');
		$asig		= $this->input->post_get('pdbAsig');
		$grupo		= $this->input->post_get('pdbGrupo');
		$sede		= $this->input->post_get('pdbSede');
		$jorn		= $this->input->post_get('pdbJorn');
		$curso		= $this->input->post_get('pdbCurso');
		$per		= $this->input->post_get('pdbPeriodo');		
				
		echo $this->M_logros->get_logros_insert($listado,$grado,$asig);	
		$this->M_notas->insert_log_notas($grado,$curso,$jorn,$sede,$grupo,$per,$asig);
			
	}
	
	/**
	* funciones para la tabla logros_estandares
	* 
	* @return
	*/
	public function	get_logros_estandares () {				
		$cod_grado	= $this->input->post_get('pdbGrado');
		$id_asig	= $this->input->post_get('pdbAsig');
		$periodo	= $this->input->post_get('pdbPeriodo');
				
		$request = $this->M_logros->get_select_logros_estandares($cod_grado,$id_asig,$periodo);
		
		echo $request;		
	}
		
		/**
	* funciones para la tabla indicadores
	* 
	* @return
	*/
	public function	get_indicadores () {
				
		$cod_grado	=$this->input->post_get('pdbCodGrado');
		$id_asig	=$this->input->post_get('pdbIdAsig');
				
		$request = $this->M_logros->get_select_indicadores($cod_grado,$id_asig);
		
		echo $request;		
	}
	
	
	public function get_log_ind () {
			
		$cod_grado	= $this->input->post_get('pdbGrado');
		$id_asig	= $this->input->post_get('pdbAsig');
		$periodo	= $this->input->post_get('pdbPerio');
		
		$request = $this->M_notas->get_logros_indicadores($cod_grado,$id_asig,$periodo);
		
		echo $request;
	}
}