<?php 
defined('BASEPATH') OR exit('No direct script access allowed');
class C_personero extends SME_Controller {
	function __construct() {
		parent::__construct();
		$this->load->model('M_personero');
	}
	
	public function insert_foto_candidato(){
		$file  = $_FILES['foto'];
		$type  = $this->input->get_post('pdbType'); 
		$table = $this->input->get_post('pdbTable'); 
		$id	   = $this->input->get_post('pdbId');
		
		echo $this->M_personero->insert_foto_candidato($file,$type,$table,$id);
	}
	
	public function insert_grados_sedes_mesa() {
		
		$fields		= json_decode($_POST['records']);
		
		$idm		= $this->input->get_post('pdbMesa');
		
		$request	= $this->M_personero->insert_grados_sedes_mesa($fields,$idm);
		
		echo $request;
	}
	
	public function get_select_grados_sedes_mesa() {
		$id	= $_GET['pdbMesa'];
		
		echo $this->M_personero->get_select_grados_sedes_mesa($id);
	}
	
	public function insert_votos () {
		$id_matric		= $_POST['id_matric'];
		$id_candidato	= $_POST['id_candidato'];
		$id_mesa		= $_POST['id_mesa'];
		$estado			= $_POST['estado'];
		$type			= $this->input->get_post('tipo');
		$request	= $this->M_personero->insert_votos($id_matric,$id_candidato,$id_mesa,$estado,$type);
		
		echo $request;
	}
	
	public function get_update_candidatos() {
		$field	= $_POST['records'];
		echo $this->M_personero->get_update_candidatos($field);
	}
	
	public function insert_candidatos() {
		$field	= json_decode($_POST['records']);
		$table	= $this->input->get_post('pdbTable');
		$type	= $this->input->get_post('pdbType');
		echo $this->M_personero->insert_candidatos($field,$table,$type);
	}
	
	public function get_select_estudiantes () {
		$fields	= $this->input->get_post('fields');
		$query	= $this->input->get_post('query');
		$type	= isset($_GET['pdbType']) ? $_GET['pdbType'] : 0;
		
		echo $this->M_personero->get_select_estudiantes($fields,$query,$type);
	}
	
	public function get_select_candidatos () {
		$type	=  $this->input->get_post('pdbType');
		echo $this->M_personero->get_select_candidatos($type);
	}
	
	public function get_select_jurados(){
		$id	= $_GET['pdbIdMesa'];
		
		echo $this->M_personero->get_select_jurados($id);
	}
	
	public function insert_sedes_mesa() {
		
		$fields		= json_decode($_POST['records']);
		
		$request	= $this->M_personero->insert_sedes_mesa($fields);
		
		echo $request;
	}
	
	public function get_update_sedes_mesa() {
		$fields		= $_POST['records'];
		
		echo $this->M_personero->get_update_sedes_mesa($fields);
	}
	
	public function get_select_sedes_mesa() {
		$id	= $_GET['pdbIdMesa'];
		
		echo $this->M_personero->get_select_sedes_mesa($id);
	}
	
}