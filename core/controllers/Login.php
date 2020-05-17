<?php defined('BASEPATH') OR exit('No direct script access allowed');
require_once $_SERVER["DOCUMENT_ROOT"].'/globales/dbconstanst.php';

class Login extends SME_Controller 
{
	
	public function __construct() 
	{
		parent::__construct();
	  	$this->load->model('M_login');
	}

	public function getCurrentUser()
	{
		echo $this->M_login->getCurrentUser();
	}
	
	public function get_login_user () {						
		$request	= $this->M_login->get_login_user();
		echo json_encode($request);
	}
	
	
	/**
	* Funcion de inicio de session
	* 
	*/
	
	public function log_in () {		
		$year	= $this->input->post_get('year');
		$user	= $this->input->post_get('user');
		$pass	= $this->input->post_get('pass');
		$inst	= $this->input->post_get('inst');
		$type	= $this->input->post_get('type');
	 	$request = $this->M_login->log_in($user,$pass,$year,$inst,$type);		
		echo $request;
	}
	
	/**
	* Funcion para verificar si se está logueado o no.
	* 
	*/
	
	public function check_session() {		
		if ($this->M_login->check_session()) {
			$request = array(
				'request'	=> 1,
				'userType'	=> intval($this->session->userdata('user_type')),
				'data'		=> $this->M_login->get_login_user()
			);						
								
		}else{
			$request = array(
				'request'	=> 0,
				'userType'	=> 0
			);	
		}
		
		$request	= json_encode($request);
		
		echo $request;
	}
		
	public function name_user_login ()
	{
		echo $this->session->userdata('user_description');
	}
}


/* End of file welcome.php */
/* Location: ./application/controllers/Welcome.php */