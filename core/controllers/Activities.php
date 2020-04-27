<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Activities extends SME_Controller {
    
    public function __construct()
    {
        parent::__construct();
        $this->load->model('Activities_m');
    }

    public function getStudentsByCourses()
	{
		$activityId	= $this->input->get_post('activityId');
		$courseId  		= $this->input->get_post('courseId');
		echo $this->Activities_m->getStudentsByCourses($activityId, $courseId);
	}

    public function getActivities()
	{
		$query	= $this->input->get_post('query');
		$start	= $this->input->get_post('start');
		$limit	= $this->input->get_post('limit');
		echo $this->Activities_m->getActivities($query, $start, $limit);
    }

    public function insertActivities()
	{
		$primaryKey	= $this->input->post('primaryKey');
		$table		= $this->input->post('pdbTable');
		$serial		= $this->input->post('serial');
		$records	= json_decode($this->input->post('records'));
		$primaryKey = ($primaryKey) ? $primaryKey : 'id' ;	
		$records->teacher_id	= $this->Activities_m->get_teacher_id();
		echo $this->Activities_m->insertData('ta_online_activities', $records, $primaryKey, $serial);
	}

	public function getAsignacionAct()
	{
		$id		= $this->input->get_post('id');
		$type   = $this->input->get_post('type');
		echo $this->Activities_m->getAsignacionActividades($id, $type);
	}

}

/* End of file Activities.php */
