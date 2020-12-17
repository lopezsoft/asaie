<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Formatos extends SME_Controller 
{
	public function __construct() 
	{
		parent::__construct();
	  	$this->load->model('M_funciones');
	  	$this->load->model('Formatos_m');	  	
	}

	public function getformato01()
	{
		$grado		= $this->input->post_get('pdbGrado');
		$jorn		= $this->input->post_get('pdbJorn');
		$sede		= $this->input->post_get('pdbSede');
		$grupo		= $this->input->post_get('pdbGrupo');
		echo $this->Formatos_m->getformato01($grado, $grupo, $jorn, $sede);
	}
	
}
