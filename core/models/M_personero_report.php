<?php 
defined('BASEPATH') OR exit('No direct script access allowed');
class M_personero_report extends SME_Model {
	function __construct() {
		parent::__construct();
		$this->load->model('M_jreport');
	}
	
		public function report_resultados ($formato,$report) {
		
		switch($report){
			case '1':
				//Reporte a Procesar : Este nombre es del reporte creado en JasReport
				$report			=	'personero_resultado';
			
				// Nombre dado al informe de salida
				$report_export	= 'Resultado electoral global';
				break;
			case '2':
				//Reporte a Procesar : Este nombre es del reporte creado en JasReport
				$report			=	'lista_estudiantes';
				
				// Nombre dado al informe de salida
				$report_export	= $this->session->userdata('user_description').' listado_estudiantes ';
				break;
			case '3':
				break;
		}
				
				
		//Extension de Salida
		$format 	= $formato;
		
		$query	= "SELECT COUNT(id_matric) AS total FROM matriculas WHERE id_estado=2 
					AND id_inst=".$this->get_id_school()." AND año=".$this->get_year();
						
		$query	= $this->db->query($query);
		
		$queryVotos	= "SELECT COUNT(id) AS total FROM tp_votos WHERE id_inst="
						.$this->get_id_school()." AND año=".$this->get_year()." AND 
						tipo=1";
						
		$queryVotosc= "SELECT COUNT(id) AS total FROM tp_votos WHERE id_inst="
						.$this->get_id_school()." AND año=".$this->get_year()." AND 
						tipo=2";
		
		$queryVotos	= $this->db->query($queryVotos);
		$queryVotosc= $this->db->query($queryVotosc);
		
		if($query AND $queryVotos AND $queryVotosc) {
			
			$capacidad_electoral	= strval($query->row()->total);
			$total_votos			= strval($queryVotos->row()->total);
			$abstinencia_electoral	= ($capacidad_electoral)-($total_votos);
			$total_votos_c			= strval($queryVotosc->row()->total);
			$abstinencia_electoral_c= ($capacidad_electoral)-($total_votos_c);
			
			$p1	= '100';
			$p2	= round(($total_votos*100)/$capacidad_electoral,2);
			$p3	= round(($abstinencia_electoral*100)/$capacidad_electoral,2);
		
			$p4	= round(($total_votos_c*100)/$capacidad_electoral,2);
			$p5	= round(($abstinencia_electoral_c*100)/$capacidad_electoral,2);
						
			$query	= "(SELECT tp.id,tp.id_inst,tp.id_matric,tp.nom_candidato,tp.numero,tp.estado,
				tm.id_grado cod_grado,tm.grupo, tm.año,
				CONCAT(rtrim(ti.apellido1),' ',rtrim(ti.apellido2),' ',rtrim(ti.nombre1),' ',
				rtrim(ti.nombre2)) AS nombres,tp.foto,tp.mime, COUNT(tv.id_candidato) AS total_votos,
				IF(tv.estado = 1, 'ACEPTADO','NULO') AS estado_v, 
				tc.candidatura AS tipo FROM tp_candidatos AS tp 
				LEFT JOIN matriculas AS tm ON tp.id_matric = tm.id_matric 
				LEFT JOIN inscripciones AS ti ON tm.cod_est = ti.cod_est 
				LEFT JOIN tp_votos AS tv ON tv.id_candidato = tp.id 
				LEFT JOIN tp_candidaturas AS tc ON tp.candidatura = tc.id  
				WHERE tm.id_estado = 2 AND tm.id_inst=".$this->get_id_school()." AND tm.año="
				.$this->get_year()." AND tv.estado=1 AND tc.id_inst=".$this->get_id_school().
				" AND tv.año =".$this->get_year()." AND tv.id_inst=".$this->get_id_school().
				" GROUP BY tv.id_candidato,tv.id_inst,tv.año)
			UNION 
			(SELECT tpv.id, tpv.id_inst,tpv.id_matric,tpv.nom_candidato,tpv.numero,tpv.estado,tpv.cod_grado,tpv.grupo,
				tpv.`año`,tpv.nombres,tpv.foto, tpv.mime, COUNT(tv.id_candidato) AS total_votos, 
				IF(tv.estado = 1, 'ACEPTADO', 'NULO') AS 
				estado_v, tc.candidatura AS tipo FROM tp_voto_blanco AS tpv
				LEFT JOIN tp_votos AS tv ON tv.id_candidato = tpv.id 
				LEFT JOIN tp_candidaturas AS tc ON tpv.candidatura = tc.id 
				WHERE tpv.id_inst = ".$this->get_id_school()." AND tpv.año =".$this->get_year()." AND tv.estado = 1 
				GROUP BY tv.id_candidato,tv.id_inst,tv.año)
			UNION
			(SELECT tp.id,tp.id_inst,tp.id_matric,tp.nom_candidato,tp.numero,tp.estado,
				tm.id_grado cod_grado,tm.grupo, tm.año,
				CONCAT(rtrim(ti.apellido1),' ',rtrim(ti.apellido2),' ',rtrim(ti.nombre1),' ',
				rtrim(ti.nombre2)) AS nombres,tp.foto,tp.mime, COUNT(tv.id_candidato) AS total_votos,
				IF(tv.estado = 1, 'ACEPTADO','NULO') AS estado_v, 
				tc.candidatura AS tipo FROM tp_candidatos AS tp 
				LEFT JOIN matriculas AS tm ON tp.id_matric = tm.id_matric 
				LEFT JOIN inscripciones AS ti ON tm.cod_est = ti.cod_est 
				LEFT JOIN tp_votos AS tv ON tv.id_candidato = tp.id 
				LEFT JOIN tp_candidaturas AS tc ON tp.candidatura = tc.id  
				WHERE tm.id_estado = 2 AND tm.id_inst=".$this->get_id_school()." AND tm.año="
				.$this->get_year()." AND tv.estado=0 AND tc.id_inst=".$this->get_id_school().
				" AND tv.año =".$this->get_year()." AND tv.id_inst=".$this->get_id_school().
				" GROUP BY tv.id_candidato,tv.id_inst,tv.año)
			UNION 
			(SELECT tpv.id, tpv.id_inst,tpv.id_matric,tpv.nom_candidato,tpv.numero,tpv.estado,tpv.cod_grado,tpv.grupo,
				tpv.`año`,tpv.nombres,tpv.foto, tpv.mime, COUNT(tv.id_candidato) AS total_votos, 
				IF(tv.estado = 1, 'ACEPTADO', 'NULO') AS 
				estado_v, tc.candidatura AS tipo FROM tp_voto_blanco AS tpv
				LEFT JOIN tp_votos AS tv ON tv.id_candidato = tpv.id 
				LEFT JOIN tp_candidaturas AS tc ON tpv.candidatura = tc.id 
				WHERE tpv.id_inst = ".$this->get_id_school()." AND tpv.año=".$this->get_year()." AND tv.estado = 0
				GROUP BY tv.id_candidato,tv.id_inst,tv.año)
				ORDER BY estado,tipo, total_votos DESC";
									
			$query	= $query;
			
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
				'P_CAP_ELECT'	=> $capacidad_electoral,
				'P_VOTOS_EJEC'	=> $total_votos,
				'P_ABSTINENCIA' => $abstinencia_electoral,
				'P_VOTOS_EJEC_C'=> $total_votos_c,
				'P_ABSTINENCIA_C' => $abstinencia_electoral_c,
				'P_1'			=>$p1,
				'P_2'			=>$p2,
				'P_3'			=>$p3,
				'P_4'			=>$p4,
				'P_5'			=>$p5
			);
		
			$request	= $this->M_jreport->get_report_export($report,$report_export,$format,$query,$parm);
			
		}else{
			$request	= $this->get_error();
		}
				
		return $request;
	}
	
	public function report_certificado ($formato,$cod_grado,$id_sede,$report) {
		
		if($report == '1'){
			//Reporte a Procesar : Este nombre es del reporte creado en JasReport
			$report			=	'certificado_electoral';
			
			// Nombre dado al informe de salida
			$report_export	= $this->session->userdata('user_description').' certificado electoral ';
		}else{
			//Reporte a Procesar : Este nombre es del reporte creado en JasReport
			$report			=	'lista_estudiantes';
			
			// Nombre dado al informe de salida
			$report_export	= $this->session->userdata('user_description').' listado_estudiantes ';
		}
			
				
		//Extension de Salida
		$format 	= $formato;
		
		$query	= "SELECT tm.*, CONCAT(rtrim(ti.apellido1),' ',rtrim(ti.apellido2),' ',
					rtrim(ti.nombre1),' ',rtrim(ti.nombre2)) AS nombres,
					rtrim(tg.grado) AS grado, rtrim(ts.nom_sede) AS sede, ti.foto, ti.mime FROM 
					matriculas AS tm LEFT JOIN inscripciones AS ti ON tm.cod_est=ti.cod_est
					LEFT JOIN grados AS tg ON tm.id_grado=tg.id 
					LEFT JOIN sedes AS ts ON tm.id_sede=ts.id ";
		
		$where	= " WHERE tm.id_inst= ".$this->get_id_school()."  AND tm.año= ".$this->get_year()." AND tm.id_estado=2 
						AND ts.id_inst=".$this->get_id_school()." AND tm.id_grado='".$cod_grado.
						"' AND tm.id_sede=".$id_sede." ORDER BY tm.id_grado,tm.grupo,nombres";
						
		$query	= $query.$where;
		
		$request	= $this->M_jreport->get_report_export($report,$report_export,$format,$query);
		
		return $request;
	}
	
}