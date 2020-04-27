<?php defined('BASEPATH') OR exit('No direct script access allowed');

class C_parcelador extends SME_Controller {
	function __construct() {
		parent::__construct();
		$this->load->model('M_parcelador');
	}
	
	public function get_importar_logros_ind () {
		$cod_grado	= $_GET['pdbCodGrado'];
		$id_asig	= $_GET['pdbIdAsig'];
		$type		= $_GET['pdbType'];
		$id_sede	= $_GET['pdbIdSede'];
		
		echo  $this->M_parcelador->get_importar_logros_ind($cod_grado,$id_asig,$type,$id_sede);
	}
	
	
	/**
	* Funciones para tabla parcelador.
	*/
	
	// Insert 
	public function get_parcelador_insert () 
	{
		echo $this->M_parcelador->insert_parcelador($_POST['records']);	
	}
	
	/**
	* Funcion que retorna el query de la tabla parcelador
	* 
	* @return
	*/
	public function get_parcelador () 
	{
		echo $this->M_parcelador->get_select_parcelador();
	}
	
	
	public function get_select_parcelador_cli()
	{
		echo $this->M_parcelador->get_select_parcelador_cli($this->input->get_post('pdbGrado'),$this->input->get_post('pdbId'));
	}
	
 	public function insert_parcelador_cli () {
		echo $this->M_parcelador->insert_parcelador_cli($_POST['records'],$_POST['pdbId']);
	}
	
	public function get_select_unidades(){
		echo $this->M_parcelador->get_select_unidades($_GET['pdbId']);
	}
	
	public function insert_unidades () {
		echo $this->M_parcelador->insert_unidades($_POST['records'],$_POST['pdbId']);
	}
	
	public function get_update_unidades () {
		echo $this->M_parcelador->get_update_unidades($_POST['records']);
	}
	
	public function get_select_parcelador_cont () {
		echo $this->M_parcelador->get_select_parcelador_cont($_GET['pdbId']);	
	}
	
	public function get_select_items_con_tem () {
		echo $this->M_parcelador->get_select_items_con_tem();
	}
	
	public function insert_parcelador_cont () {
		echo $this->M_parcelador->insert_parcelador_cont($_POST['records'],$_POST['pdbId']);
	}
	
	public function get_update_parcelador_cont () {
		echo $this->M_parcelador->get_update_parcelador_cont($_POST['records']);
	}
	
	public function get_select_plan () {
		echo $this->M_parcelador->get_select_plan();
	}
	
	public function insert_plan () {
		echo $this->M_parcelador->insert_plan($_POST['records']);
	}
	
	public function get_update_plan () {
		echo $this->M_parcelador->get_update_plan($_POST['records']);
	}
	
	
}