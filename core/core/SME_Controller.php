<?php
defined('BASEPATH') OR exit('No direct script access allowed');
date_default_timezone_set("America/Bogota");
class SME_Controller extends CI_Controller {
			
    public function __construct()
    {
            parent::__construct();
		  	$this->load->model('M_funciones');			  
    }
               
    /* 
	* Cerrar sesion sin reridercción
	*/
    public function close_session() 
    {
		$this->M_sessions->close_sess()	;
	}
	  /* 
	* Cerrar sesion con reridercción
	*/
	public function close_session_redirect() 
	{
		$this->M_sessions->close_session_red();
	}
	
	protected function check_session(){
		return $this->M_sessions->check();
	}
	
	protected function check_session_redirect(){
		if (!$this->M_sessions->check()){
			redirect(base_url());
		};
	}  

}

/* End of file SME_Controller.php */
/* Location: ./application/core/SME_Controller.php */