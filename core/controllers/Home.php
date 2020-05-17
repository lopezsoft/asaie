<?php defined('BASEPATH') OR exit('No direct script access allowed');
class Home extends SME_Controller {
	public function __construct() 
	{
		parent::__construct();
	  	$this->load->model('M_login');
	  	$this->load->model('M_app_update');
		$this->lang->load('login','es');
	}
	public function index()
	{
		$template 	= 'login/index' ;
		$data		= [];
		if($this->M_login->check_session()){
            $template = 'home/index' ;
		}else{
            $template = 'login/index' ;
			$this->close_session();
		}
		if (!$this->M_login->check_active()){
			$this->db->where('state', 1);
			$query	= $this->db->get('schools');
			$data['schools']	= $query->result_array();
			
			$this->db->where('active', 1);
			$query	= $this->db->get('user_types');
			$data['user_types']	= $query->result_array();

			if($this->M_login->check_session()){
            	$this->close_session();
			}
			$template = 'login/index';
		}
		$this->load->view($template,$data);
	}	
	public function app_update(){
		$this->M_app_update->app_update_control();
	}	
	public function access_matric(){
		$this->app_update();
		$this->load->view('v_access_matric');
	}
}
