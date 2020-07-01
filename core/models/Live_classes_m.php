<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Live_classes_m extends SME_Model {

	
	public function __construct()
	{
		parent::__construct();
	}
	
	public function upload_files_live_classes($file){
		$this->folders_teachers($this->get_teacher_id());
		$request = $this->upload_file($file,$this->live_classes_directory_path);		
		return $request;
	}

	public function read_files_live_classes() {
		$this->folders_teachers($this->get_parent());
		$path	= $this->live_classes_directory_path;
		return $this->read_directory_files($path);
	}	
	

	function getStudentsByCourses($classId, $courseId){
		$param = array(
			$courseId,
			$classId
		);
		return $this->getExecute('sp_select_class_course_students ( ?, ? )', $param);
    }
    
    function getLiveClasses($query, $start, $limit){
        $where  = array(
            'teacher_id'    => $this->get_teacher_id()
        );
        return $this->getTable('tl_live_classes', $start, $limit, $query, $where);
    }


	function getCourses($id, $type)
	{
		$param = array(
			$this->get_parent(),
			$this->get_year(),
            $id,
            $type
		);
		return $this->getExecute('sp_courses_live_classes ( ?, ?, ?, ? )', $param);;
	}

	
}

/* End of file Live_classes_m.php */

