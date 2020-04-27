<?php
defined('BASEPATH') OR exit('No direct script access allowed');
class C_cierre extends SME_Controller {
	function __construct() {
		parent::__construct();
		$this->load->model('M_cierre');
	}
	public function get_close(){
		echo $this->M_cierre->cierre_anio();
		
	}
}