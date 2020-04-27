<?php
defined('BASEPATH') OR exit('No direct script access allowed');
class M_sessions extends SME_Model {

	public function __construct() 
	{
		parent::__construct();
	}
	

	public function close_session_red() {
		$this->close_session_redirect();
	}

 	public function close_sess() {
		$this->close_session();
 	}
 	
 	public function check(){
		return $this->check_ession();
	}
}
/* End of file M_sessions.php */
/* Location: ./application/models/M_sessions.php */