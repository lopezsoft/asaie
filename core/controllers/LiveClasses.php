<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class LiveClasses extends SME_Controller {

	public function __construct()
	{
		parent::__construct();
		$this->load->model('Live_classes_m');
	}

	public function read_files_live_classes() {
		echo $this->Live_classes_m->read_files_live_classes();
	}
	

	public function upload_files_live_classes (){		
		$file	= $_FILES['foto'];
		echo $this->Live_classes_m->upload_files_live_classes($file);
	}
	
	public function getStudentsByCourses()
	{
		$classId	= $this->input->get_post('classId');
		$courseId  		= $this->input->get_post('courseId');
		echo $this->Live_classes_m->getStudentsByCourses($classId, $courseId);
	}

    public function getLiveClasses()
	{
		$query	= $this->input->get_post('query');
		$start	= $this->input->get_post('start');
		$limit	= $this->input->get_post('limit');
		echo $this->Live_classes_m->getLiveClasses($query, $start, $limit);
    }

    public function insertLiveClasses()
	{
		$primaryKey	= $this->input->post('primaryKey');
		$table		= $this->input->post('pdbTable');
		$serial		= $this->input->post('serial');
		$records	= json_decode($this->input->post('records'));
		$primaryKey = ($primaryKey) ? $primaryKey : 'id' ;	
		$records->teacher_id	= $this->Live_classes_m->get_teacher_id();
		echo $this->Live_classes_m->insertData('tl_live_classes', $records, $primaryKey, $serial);
	}

	public function getCourses()
	{
		$id		= $this->input->get_post('id');
		$type   = $this->input->get_post('type');
		echo $this->Live_classes_m->getCourses($id, $type);
	}
	
}

/* End of file LiveClasses.php */
