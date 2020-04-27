<?php
defined('BASEPATH') OR exit('No direct script access allowed');
class M_convivencia_reportes extends SME_Model {
	function __construct() {
		parent ::__construct();
		$this->load->model('M_jreport');
	}
	
	public function get_report_acta_ctrl_seguimiento($pdbId, $pdbIdMatric, $forma) {
		$SQLC = "CALL sp_conv_select_control_seguimiento_est_situacion('".
		$pdbIdMatric."','".$pdbId."','".$this->get_id_school()."','".$this->get_year()."');";
		
		//Reporte a Procesar : Este nombre es del reporte creado en JasReport
		$report			=	'conv_control_seguimiento';
			
		// Nombre dado al informe de salida
		$report_export	= $this->session->userdata('user_description').' conv_control_seguimiento';
			
				
		//Extension de Salida
		$format 	= $forma;
									
		$query	= "";
								
		$query	= $SQLC;
				
		$parm	= array(
			'SQL_PARAM' 	=> $query,
			'R_TITLE'		=> $this->M_jreport->p_title,
			'R_NIT'			=> $this->M_jreport->p_nit,
			'R_DANE'		=> $this->M_jreport->p_dane,
			'R_RESOL'		=> $this->M_jreport->p_resol,
			'R_FOOTER'		=> $this->M_jreport->p_footer,
			'R_IMG_LEFT'	=> $this->M_jreport->p_img_left,
			'R_IMG_RIGHT'	=> $this->M_jreport->p_img_right,
			'R_MARKETING'	=> $this->M_jreport->p_marketing,
			'SUBREPORT_DIR' => $this->M_jreport->subreport_dir
		);
	
		$request	= $this->M_jreport->get_report_export($report,$report_export,$format,$query,$parm);
				
		return $request;
	}
	
	public function get_report_acciones_estudiante ($forma,$id) {
		
			
		$SQLC = "CALL sp_conv_select_acciones_est(".$this->get_id_school().",".$this->get_year().",".$id.");";
		
		//Reporte a Procesar : Este nombre es del reporte creado en JasReport
		$report			=	'acciones_estudiantes';
			
		// Nombre dado al informe de salida
		$report_export	= $this->session->userdata('user_description').' acciones_estudiantes';
			
				
		//Extension de Salida
		$format 	= $forma;
									
		$query	= "";
								
		$query	= $SQLC;
		
		$escala	= $this->escala();
		
		$parm	= array(
			'SQL_PARAM' 	=> $query,
			'R_TITLE'		=> $this->M_jreport->p_title,
			'R_NIT'			=> $this->M_jreport->p_nit,
			'R_DANE'		=> $this->M_jreport->p_dane,
			'R_RESOL'		=> $this->M_jreport->p_resol,
			'R_FOOTER'		=> $this->M_jreport->p_footer,
			'R_IMG_LEFT'	=> $this->M_jreport->p_img_left,
			'R_IMG_RIGHT'	=> $this->M_jreport->p_img_right,
			'R_MARKETING'	=> $this->M_jreport->p_marketing,
			'R_ESCALA'		=> $escala,
			'SUBREPORT_DIR' => $this->M_jreport->subreport_dir
		);
	
		$request	= $this->M_jreport->get_report_export($report,$report_export,$format,$query,$parm);
				
		return $request;
	}
	
	public function get_report_estadistica ($forma,$pdbNivel,$pdbAllPer,$pdbPeriodo,$type) {		
		IF ($pdbAllPer == '1'){
			$z_per = '0';
		}else{
			$z_per = $pdbPeriodo;			
		}		
		IF ($z_per == '0'){
			$periodo = "";
		}else{
			$periodo = " AND te.periodo ='".$z_per."' ";
		}		
		$xr = $pdbNivel;	
		$db	= $this->get_db_name();	
		$SQLC = "CALL ".$db.".sp_estadistica_grupo(".$this->get_year().",".$xr.",'".$z_per."');";		
		if ($type == '1') {
			//Reporte a Procesar : Este nombre es del reporte creado en JasReport
			$report			=	'estadisticas';
		}else{
			//Reporte a Procesar : Este nombre es del reporte creado en JasReport
			$report			=	'estadisticas_perdidos';
		}		
		// Nombre dado al informe de salida
		$report_export	= $this->session->userdata('user_description').' estadistica';				
		//Extension de Salida
		$format 	= $forma;		
		$SQLC	= $this->db->query($SQLC);		
		if($SQLC) {					
			$m_SQL	= "CALL ".$db.".`sp_estadistica_select_grado`(".$this->get_year().",".$xr.",".$z_per.",".$type.")";			
			$query	= "";									
			$query	= $m_SQL;			
			$escala	= $this->escala();			
			$parm	= array(
				'SQL_PARAM' 	=> $query,
				'R_TITLE'		=> $this->M_jreport->p_title,
				'R_NIT'			=> $this->M_jreport->p_nit,
				'R_DANE'		=> $this->M_jreport->p_dane,
				'R_RESOL'		=> $this->M_jreport->p_resol,
				'R_FOOTER'		=> $this->M_jreport->p_footer,
				'R_IMG_LEFT'	=> $this->M_jreport->p_img_left,
				'R_IMG_RIGHT'	=> $this->M_jreport->p_img_right,
				'R_MARKETING'	=> $this->M_jreport->p_marketing,
				'R_ESCALA'		=> $escala,
				'SUBREPORT_DIR' => $this->M_jreport->subreport_dir,
				'P_NIVEL'		=> $xr,
				'P_PERIODO'		=> $z_per,
				'P_ALLPER'		=> $pdbAllPer
			);
		
			$request	= $this->M_jreport->get_report_export($report,$report_export,$format,$query,$parm);
			
		}else{
			$request	= $this->get_error();
		}
				
		return $request;
	}
}