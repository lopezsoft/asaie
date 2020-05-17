<?php
defined('BASEPATH') OR exit('No direct script access allowed');
 class Students extends SME_Controller {
 	function __construct() {
 		parent::__construct();
 		$this->load->model('Students_m');
	} 	

	public function getCommentsActivities()
	{
		$id			= $this->input->get_post('id');
		$course_id	= 0;
		$enrollment	= 0;
		echo $this->Students_m->getCommentsActivities($id, $course_id, $enrollment);	
	}
	 
	public function commentsactivities()
	{
		$file  		= $_FILES['nfile'];
		$comment	= $this->input->get_post('comment');
		$comment_title	= $this->input->get_post('comment_title');
		$id			= $this->input->get_post('id');
		$course_id	= $this->input->get_post('course_id');
		$activity_id= $this->input->get_post('activity_id');
		echo $this->Students_m->setCommentsActivities($file, $comment, $id, $course_id, $activity_id, $comment_title);		
	}

 	public function get_select_evaluaciones_estudiantes(){
 		$id	= $this->input->get_post('pdbIdEva');
		echo $this->Students_m->get_select_evaluaciones_estudiantes($id);
	} 
 	public function getStudentsEvaluations(){
		echo $this->Students_m->getStudentsEvaluations();
	} 
 	public function getStudentsActivities(){
		echo $this->Students_m->getStudentsActivities();
	} 	
 	public function get_notas(){
		echo $this->Students_m->get_notas();
	} 	
 	public function get_docentes_curso(){
		echo $this->Students_m->get_docentes_curso();
	} 	 	
 	public function get_select_perfil(){
		echo $this->Students_m->get_select_perfil();
	} 	
 	public function upload_foto(){
		$file  = $_FILES['foto'];
		echo $this->Students_m->upload_foto($file);
	} 	 	
 	public function read_images(){
		echo $this->Students_m->read_images();
	}
 	
 }