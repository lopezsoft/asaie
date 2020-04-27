<?php defined('BASEPATH') OR exit('No direct script access allowed');
require_once $_SERVER["DOCUMENT_ROOT"].'/globales/dbconstanst.php';

class Account extends SME_Controller 
{
	
	public function __construct() 
	{
		parent::__construct();
	}
	
	public function LogOff () {						
		$request	= $this->close_session();
	}
	
}


/* End of file welcome.php */
/* Location: ./application/controllers/Welcome.php */