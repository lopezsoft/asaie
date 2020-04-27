<?php
defined('BASEPATH') OR exit('No direct script access allowed');
class Evaluations extends SME_Controller {
    public function __construct()
    {
        parent::__construct();
        $this->load->model('Evaluations_m');
    }
	
	
	public function getStudentsByCourses()
	{
		$evaluationId	= $this->input->get_post('evaluationId');
		$courseId  		= $this->input->get_post('courseId');
		echo $this->Evaluations_m->getStudentsByCourses($evaluationId, $courseId);
	}


    public function getAsignacionEval()
	{
		$id		= $this->input->get_post('id');
		$type  	= $this->input->get_post('type');
		echo $this->Evaluations_m->getAsignacionEval($id, $type);
	}

	public function insertEvaluations()
	{
		$primaryKey	= $this->input->post('primaryKey');
		$table		= $this->input->post('pdbTable');
		$serial		= $this->input->post('serial');
		$records	= json_decode($this->input->post('records'));
		$primaryKey = ($primaryKey) ? $primaryKey : 'id' ;	
		$records->teacher_id	= $this->Evaluations_m->get_teacher_id();
		echo $this->Evaluations_m->insertData('te_evaluations', $records, $primaryKey, $serial);
	}

	public function getEvaluations()
	{
		$query	= $this->input->get_post('query');
		$start	= $this->input->get_post('start');
		$limit	= $this->input->get_post('limit');
		echo $this->Evaluations_m->getEvaluations($query, $start, $limit);
	}

}

/* End of file Evaluations.php */
