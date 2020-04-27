<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Activities_m extends SME_Model {
    public function __construct()
    {
        parent::__construct();
    }
    function getStudentsByCourses($activityId, $courseId){
		$param = array(
			$courseId,
			$activityId
		);
		return $this->getExecute('sp_activity_courses_students ( ?, ? )', $param);
    }
    
    function getActivities($query, $start, $limit){
        $where  = array(
            'teacher_id'    => $this->get_teacher_id()
        );
        return $this->getTable('ta_online_activities', $start, $limit, $query, $where);
    }


	function getAsignacionActividades($id, $type)
	{
		$param = array(
			$this->get_parent(),
			$this->get_year(),
            $id,
            $type
		);
		return $this->getExecute('sp_carga_activities ( ?, ?, ?, ? )', $param);;
	}

}

/* End of file Activities_m.php */
