<?php
defined('BASEPATH') OR exit('No direct script access allowed');
class Excel_manager extends SME_Controller {
	function __construct() {
		parent ::__construct();
		$this->load->model('Excel_manager_m');
		$this->load->model('M_notas');
	}	

	public function load_excel_students()
	{
		$file	= $_FILES['foto'];
		echo $this->Excel_manager_m->load_excel_students($file);
	}

	public function download_excel_students()
	{
		echo $this->Excel_manager_m->get_download_excel_students();
	}
	
	public function consolidado_sin_notas(){
		echo $this->Excel_manager_m->consolidado_sin_notas();
	}
	
	public function consolidado_matricula(){
		echo $this->Excel_manager_m->consolidado_matricula();
	}
	
	public function download_report_consolidado() {
		
		$per	= $this->input->post('pdbPeriodo');
		$hoj	= $this->input->post('pHojaReport');
		$type	= $this->input->post('pTypeReport');
		$all	= $this->input->post('pdbAllPer');
		$c_gdo	= $this->input->post('pdbCodGrado');
		$gpo	= $this->input->post('pdbGrupo');
		$jorn	= $this->input->post('pdbIdJorn');
		$sede	= $this->input->post('pdbIdSede');
		$format	= $this->input->post('pFormat');	
		if ($type == '1') { // Asignaturas
			echo $this->Excel_manager_m->download_report_consolidado_as($per,$all,$c_gdo,$gpo,$jorn,$sede);
		}else{			
			echo $this->Excel_manager_m->download_report_consolidado_ar($per,$all,$c_gdo,$gpo,$jorn,$sede);
		}
				
	}
	
	public function upload_plantilla (){
		$file	= $_FILES['foto'];
		$asig	= $this->input->get_post('pdbAsig');
		$grado	= $this->input->get_post('pdbGrado');
		$grupo	= $this->input->get_post('pdbGrupo');
		$per	= $this->input->get_post('pdbPeriodo');
		$jorn	= $this->input->get_post('pdbJornada');
		$sede	= $this->input->get_post('pdbSede');
		$curso	= $this->input->get_post('pdbCurso');
		echo $this->Excel_manager_m->upload_plantilla($asig,$grado,$grupo,$per,$jorn,$sede,$curso,$file);
		$this->M_notas->insert_log_notas($grado,$curso,$jorn,$sede,$grupo,$per,$asig);
	}
	
	public function delete_file(){
		$path = $this->input->get_post('pathFile');
		echo $this->Excel_manager_m->delete_file_exl($path);
	}
	
	public function exportar_notas_asignatura(){
		$asig	= $this->input->get_post('pdbAsig');
		$grado	= $this->input->get_post('pdbGrado');
		$grupo	= $this->input->get_post('pdbGrupo');
		$per	= $this->input->get_post('pdbPeriodo');
		$jorn	= $this->input->get_post('pdbJornada');
		$sede	= $this->input->get_post('pdbSede');
		$curso	= $this->input->get_post('pdbCurso');
		echo $this->Excel_manager_m->exportar_notas_asignatura($asig,$grado,$grupo,$per,$jorn,$sede,$curso);
	}
}