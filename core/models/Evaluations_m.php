<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Evaluations_m extends SME_Model {
    public function __construct()
    {
        parent::__construct();
    }

	function getStudentsByCourses($evaluationId, $courseId){
		$param = array(
			$courseId,
			$evaluationId
		);
		return $this->getExecute('sp_evaluation_courses_students ( ?, ? )', $param);
	}

	function getAsignacionEval($id, $type)
	{
		$param = array(
			$this->get_parent(),
			$this->get_year(),
			$id,
			$type
		);
		return $this->getExecute('sp_carga_evaluations ( ?, ?, ?, ? )', $param);
	}

	function getEvaluations($query, $start, $limit)
	{
		$where	= array(
			'teacher_id'	=> $this->get_teacher_id()
		);
		return $this->getTable('te_evaluations', $start, $limit, $query, $where);
	}

}

/* End of file Evaluations_m.php */
