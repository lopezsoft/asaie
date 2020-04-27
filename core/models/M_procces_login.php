<?php
defined('BASEPATH') OR exit('No direct script access allowed');
class M_procces_login extends CI_Model {
	
	public function __construct(){
		parent::__construct();
		$this->load->model('M_login');
	}
	
	// function procces_login ($_POST['user'],$_POST['pass'],$_POST['dane'],$_POST['año']) {
	// 	if (isset($_POST['user'],$_POST['pass'],$_POST['dane'],$_POST['año'])) {
	// 		$this->load->model('M_login');
			
	// 		$login = $this->M_login->login($_POST['user'],$_POST['pass'],$_POST['dane'],$_POST['año']);
			
	// 	    if ($login) {
	// 	        // Inicio de sesión exitosa
	// 			echo 1 ;
	// 	    } else {
	// 	        // Inicio de sesión exitosa
	// 			echo 0;
	// 	    }
	// 	} else {
	// 	    // Las variables POST correctas no se enviaron a esta página.
	// 	    //echo 'Solicitud no válida';
	// 		echo  2;
	// 	}
	// }
}



/* End of file M_procces_login.php */
/* Location: ./application/models/M_procces_login.php */