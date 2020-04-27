<?php  
defined('BASEPATH') OR exit('No direct script access allowed');

class M_admin extends SME_Model{
	function __construct() {
		parent::__construct();
		$this->check_ession();
	}
	
	function read_images($cod){
		$this->folders_administrative($cod);
		return $this->read_directory_files($this->adminImagesDirectoryPath);
	}
	
	function upload_images($file,$cod){
		$file  = $_FILES['foto'];
		$this->folders_administrative($cod);
		return $this->upload_file($file,$this->adminImagesDirectoryPath);
	}
	
	function upload_files_dig($file,$cod) {
		$this->folders_administrative($cod);
		return $this->upload_file($file,$this->adminDigitalDirectoryPath);
	}	
	function read_files_dig($cod) {
		$this->folders_administrative($cod);
		return $this->read_directory_files($this->adminDigitalDirectoryPath);
	}
	
	function get_select_docentes_dir_grupo(){
		$result = '';
		$ye		= $this->get_year();
		$db		= $this->get_db_name();
		$query 	= "td.estado,".
		"CONCAT(RTRIM(td.apellido1),' ',RTRIM(td.apellido2),' ',RTRIM(td.nombre1),' ',RTRIM(td.nombre2)) AS nombres,".
		"t1.id_docente, t1.year";
		$this->db->select($query);
		$this->db->from($db.'.docentes AS td');
		$this->db->join($db.'.aux_docentes AS t1', 't1.id_docente = td.id_docente', 'left');
		$this->db->where('t1.id_docente = td.id_docente');		
		$this->db->where('td.estado',1);
		$this->db->where('t1.year', $ye);
		$this->db->order_by('nombres');
		$query	= $this->db->get();
		if ($query) {
			$total	= $query->num_rows();
			$result	= $this->get_request_select($query->result_array(),$total);
		} else {
			$result	= $this->get_error();
		}
		return $result;
	}

	
}