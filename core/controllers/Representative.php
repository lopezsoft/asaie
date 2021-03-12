<?php 
defined('BASEPATH') OR exit('No direct script access allowed');
class Representative extends SME_Controller {
	function __construct() {
		parent::__construct();
		$this->load->model('Representative_m');
		$this->load->model('Representative_report_m');
	}

	public function getStudentData()
	{
		$enrollment_id 	= $this->input->get_post('enrollment_id');
		$request		= $this->Representative_m->getStudentData($enrollment_id);
		
		echo $request;
	}
	
	public function getResults () {
		$format 	= $this->input->get_post('pFormat');
		$report		= $this->input->get_post('pdbReport');
								
		$request	= $this->Representative_report_m->getResults($format,$report);
		echo $request;
	}
	

	public function getCertificate () {
		$format 	= $this->input->get_post('pFormat');				
		$cod_grado	= $this->input->get_post('pdbGrado');		
		$id_sede	= $this->input->get_post('pdbSede');		
		$report		= $this->input->get_post('pdbReport');								
		$request	= $this->Representative_report_m->getCertificate($format,$cod_grado,$id_sede,$report);		
		echo $request;
	}

	public function uploadCandidatePhoto(){
		$file  = $_FILES['image'];
		$type  = $this->input->get_post('pdbType'); 
		$table = $this->input->get_post('pdbTable'); 
		$id	   = $this->input->get_post('pdbId');
		
		echo $this->Representative_m->uploadCandidatePhoto($file,$type,$table,$id);
	}
	
	
	public function getDegreesPerTable() {
		$id	= $this->input->get_post('pdbPolling_stattion_id');
		echo $this->Representative_m->getDegreesPerTable($id);
	}
	
	public function insertVotes () {
		$enrollment_id		= $this->input->get_post('enrollment_id');
		$id					= $this->input->get_post('id');
		$candidate_id		= $this->input->get_post('candidate_id');
		$polling_station_id	= $this->input->get_post('polling_station_id');
		$candidacy_id  		= $this->input->get_post('candidacy_id');
		$type        		= $this->input->get_post('type');
		$request	= $this->Representative_m->insertVotes($enrollment_id,$id, $candidate_id, $polling_station_id, $candidacy_id, $type);
		
		echo $request;
	}
		
	public function getStudents () {
		$fields	= $this->input->get_post('fields');
		$query	= $this->input->get_post('query');
		$type	= $this->input->get_post('pdbType');
		
		echo $this->Representative_m->get_select_estudiantes($fields,$query,$type);
	}
	
	public function getCandidates () {
		$type				=  $this->input->get_post('pdbType');
		$polingStationId	=  $this->input->get_post('pdbPolingStationId');
		echo $this->Representative_m->getCandidates($type, $polingStationId);
	}
	
	public function getJuries(){
		$id	= $this->input->get_post('pdbPolingStationId');
		echo $this->Representative_m->getJuries($id);
	}
		
	public function getTableHeadquarters() {
		$id	= $this->input->get_post('pdbPolingStationId');		
		echo $this->Representative_m->getTableHeadquarters($id);
	}
	
}
