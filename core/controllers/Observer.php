<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Observer extends SME_Controller 
{
	public function __construct() 
	{
		parent::__construct();
	  	$this->load->model('M_funciones');
	  	$this->load->model('Observer_m');	  	
	}

	public function getStudents()
	{
		echo $this->Observer_m->getStudents();
	}
	
	public function	get_modelo_observador() {
		echo $this->Observer_m->get_modelo_observador();
	}
	
	public function get_itemsmodelo3(){
		$id	= $this->input->get('pId_Observador');
		echo $this->Observer_m->get_itemsmodelo3($id);
	}
	
	public function get_observador_t() {
		echo $this->Observer_m->get_observador_tipo();
	}
		
	public function get_observador() {		
		$pdbId		=	$this->input->get_post('pdbId');
		$estado		=	'1';		
		echo $this->Observer_m->get_observador($pdbId,$estado);		
	}
	
	public function get_observador_insert () {
		
		$id_matric	= $this->input->post('pdbCodEst');
			
		$list_data	= $this->input->post('records');
		
		$table		= $this->input->post('pdbTable');
		
		$request 	= $this->Observer_m->get_observador_insert($id_matric,$list_data,$table);
		
		echo $request;
	}
	
	public function get_observador_update (){
		$list_data	= json_decode($_POST['records']);
		
		$where		= 'id= '.$list_data->id;
		
		$table		= $this->input->post('pdbTable');
		
		$request 	= $this->Observer_m->update_data($table,$list_data,$where);
		
		echo $request;
	}
	
	public function get_fortdif () {
		$id_observador	= $this->input->get('pId_Observador');
		echo 	$this->Observer_m->get_fortdif($id_observador);
	}
	
	/*public function	get_modelo_observador () {
		$result	= $this->Observer_m->get_modelo_observador();
		
		echo $result;
	}*/
	
	public function get_fortdif_insert () {
		$list_data		= $_POST['records'];
		
		$id_observador	= $_POST['pId_Observador'];
		
		$request	= $this->Observer_m->get_fortdif_insert($id_observador,$list_data);
		
		echo 	$request;
	}
	
	public function get_fortdif_update () {
		
		$list_data	= ($_POST['records']);
		
		$request	= $this->Observer_m->get_fortdif_update($list_data);
		
		echo 	$request;
	}
	
}