<?php  defined('BASEPATH') OR exit('No direct script access allowed');

class C_admin extends SME_Controller {
	function __construct() {
		parent ::__construct();	
		$this->load->model('M_admin');
	}
		
	public function read_images(){
		$cod		= $this->input->get_post('pdbDocumento');
		echo $this->M_admin->read_images($cod);
	}
	
	public function upload_images(){
		$cod		= $this->input->get_post('pdbDocumento');
		$file  = $_FILES['foto'];
		echo $this->M_admin->upload_images($file,$cod);
	}
	
	public function upload_files_dig() {
		$file  		= $_FILES['foto'];
		$cod		= $this->input->get_post('pdbDocumento');
		echo $this->M_admin->upload_files_dig($file,$cod);
	}
	public function read_files_dig() {
		$cod		= $this->input->get_post('pdbDocumento');
		echo $this->M_admin->read_files_dig($cod);
	}
	
	public function get_select_docentes_dir_grupo(){
		echo $this->M_admin->get_select_docentes_dir_grupo();
	}
	
	public function insert_dir_grupo(){
		$lis = $this->input->get_post('records');
		echo $this->M_admin->insert_dir_grupo($lis);
	}
	
	public function get_select_dir_grupo(){
		$grado = $this->input->get_post('pdbGrado');
		echo $this->M_admin->get_select_dir_grupo($grado);
	}
	
	
	public function insert_administrativos(){
		$lis = $this->input->get_post('records');
		echo $this->M_admin->insert_administrativos($lis);
	}
	
	public function get_select_administrativos(){
		echo $this->M_admin->get_select_administrativos();
	}
	
	
	public function insert_docentes(){
		$lis = $this->input->get_post('records');
		echo $this->M_admin->insert_docentes($lis);
	}
	
	public function get_select_docentes(){
		echo $this->M_admin->get_select_docentes();
	}
}