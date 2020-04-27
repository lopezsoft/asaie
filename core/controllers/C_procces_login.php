<?php 
defined('BASEPATH') OR exit('No direct script access allowed');

class C_procces_login extends SME_Controller 
{

	public function __construct() 
	{
		parent::__construct();
		$this->load->model('M_login');
		date_default_timezone_set("America/Bogota");
	}
	public function mifuncion () 
	{
		if (isset($_POST['user'],$_POST['pass'],$_POST['dane'],$_POST['db_a'])) 
		{
			$login_estate = $this->M_login->login($_POST['user'],$_POST['pass'],$_POST['dane'],$_POST['db_a']);
			if ($login_estate)
			{
				echo 1; 
			}else{
				echo 0;
			} 		   		
		} else {
		    // Las variables POST correctas no se enviaron a esta página.
			echo  2;
		}
	}	
}

/* End of file C_procces_login */
/* Location: ./application/core/C_procces_login.php */