<?php
defined('BASEPATH') OR exit('No direct script access allowed');
class C_convivencia extends SME_Controller {
	function __construct() {
		parent::__construct();
		$this->load->model('M_convivencia');
		$this->load->model('M_convivencia_reportes');
	}
	
	public function get_report_acta_ctrl_seguimiento(){
		$forma		= $this->input->post_get('pFormat');
		$pdbId 		= $this->input->post_get('pbdId');
		$pdbIdMatric = $this->input->post_get('pdbIdMatric');
		echo $this->M_convivencia_reportes->get_report_acta_ctrl_seguimiento($pdbId,$pdbIdMatric,$forma);
	}
	
	public function insert_control_seguimiento_estudiantes(){
		$list	= $this->input->post('records');
		$id		= $this->input->post('pdbId');
		echo $this->M_convivencia->insert_control_seguimiento_estudiantes($list,$id);
	}
	
	public function get_select_control_seguimiento_estudiantes(){
		$pdbId = $this->input->get('pdbId');
		echo $this->M_convivencia->get_select_control_seguimiento_estudiantes($pdbId);
	}
	
	public function get_report_acciones_estudiante(){
		$forma		= $this->input->post('pFormat');
		$pbdId	= $this->input->post('pbdId');		
		echo $this->M_convivencia_reportes->get_report_acciones_estudiante($forma,$pbdId);
	}
	
	public function get_insertacciones_estudiantes(){
		$list	= $this->input->post('records');
		$id		= $this->input->post('pdbId');
		echo $this->M_convivencia->get_insertacciones_estudiantes($list,$id);
	}
	
	public function get_select_acciones_estudiantes(){
		$pdbId = $this->input->get('pdbId');
		echo $this->M_convivencia->get_select_acciones_estudiantes($pdbId);
	}
	
	public function get_report_estadistica(){
		$forma		= $this->input->post('pFormat');
		$pbdNivel	= $this->input->post('pbdNivel');
		$pdbAllPer	= $this->input->post('pdbAllPer');
		$pdbPeriodo	= $this->input->post('pdbPeriodo');
		$pdbTypeReport	= $this->input->post('pdbTypeReport');
		
		echo $this->M_convivencia_reportes->get_report_estadistica($forma,$pbdNivel,$pdbAllPer,$pdbPeriodo,$pdbTypeReport);		
	}
	
	public function insert_formatos(){
		$list	= $this->input->post('records');
		echo $this->M_convivencia->insert_formatos($list);
	}	
	
	
	public function get_select_acciones(){
		echo $this->M_convivencia->get_select_acciones();
	}
	
	public function get_select_formatos(){
		echo $this->M_convivencia->get_select_formatos();
	}
	
	public function get_update_situaciones_estudiantes() {
		$list	= $this->input->post('records');
		echo $this->M_convivencia->get_update_situaciones_estudiantes($list);
	}
	
	public function get_insertsituaciones_estudiantes(){
		
		$list	= $this->input->post('records');
		echo $this->M_convivencia->get_insertsituaciones_estudiantes($list);	
	}
	
	public function get_select_situaciones_estudiantes(){		
		$id_matric = $this->input->get_post('pdbIdMatric');
		echo $this->M_convivencia->get_select_situaciones_estudiantes($id_matric);
	}
	
	public function get_select_situaciones(){
		$queyr 	= $this->input->get_post('query');
		$xtype	= $this->input->get_post('pdbType');		
		echo $this->M_convivencia->get_select_situaciones($queyr,$xtype);
	}
	
	public function get_select_tipo_situaciones(){
		echo $this->M_convivencia->get_select_tipo_situaciones();
	}
	
}