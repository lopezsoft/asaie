<?php
defined('BASEPATH') OR exit('No direct script access allowed');
date_default_timezone_set("America/Bogota");
class WA_Controller extends CI_Controller {
	public	$user			= "Web01";	
    public function __construct()
    {
        parent::__construct();
    }
               
    /* 
	* Cerrar sesion sin reridercción
	*/
    public function close_session() 
    {
		$this->Sessions_m->close_sess()	;
	}
	  /* 
	* Cerrar sesion con reridercción
	*/
	public function close_session_redirect() 
	{
		$this->Sessions_m->close_session_red();
	}
	
	protected function check_session(){
		return $this->Sessions_m->check();
	}
	
	protected function check_session_redirect(){
		if (!$this->Sessions_m->check()){
			redirect(base_url());
		};
	}  

}

/* End of file SME_Controller.php */
/* Location: ./application/core/SME_Controller.php */