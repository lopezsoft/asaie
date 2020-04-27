<?php
defined('BASEPATH') OR exit('No direct script access allowed');
class C_personero_report extends SME_Controller {
	function __construct() {
		parent::__construct();
		$this->load->model('M_personero_report');
	}
	public function report_resultados () {
		$format 	= $_POST['pFormat'];
						
		$report	= $_POST['pdbReport'];
								
		$request	= $this->M_personero_report->report_resultados($format,$report);
		
		echo $request;
	}
	
	
	public function report_certificado () {
		$format 	= $_POST['pFormat'];				
		$cod_grado	= $_POST['pdbGrado'];		
		$id_sede	= $_POST['pdbSede'];		
		$report	= $_POST['pdbReport'];								
		$request	= $this->M_personero_report->report_certificado($format,$cod_grado,$id_sede,$report);		
		echo $request;
	}
}