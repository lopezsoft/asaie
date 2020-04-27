<?php
defined('BASEPATH') OR exit('No direct script access allowed');
class M_report_general extends SME_Model {
	function __construct() {
		parent::__construct();
		$this->load->model('M_jreport');
	}
	
	function get_pre_matricula_nuevos($f){
		
		$id		= $this->get_id_school();
		$ye		= $this->get_year();
		$date	= date('Y-m-d h-m-s');
		//Reporte a Procesar : Este nombre es del reporte creado en JasReport
		$report	= 'pre_matricula_nuevos';
		
		$query	=  "SELECT ti.cod_est, ti.nro_doc_id, 
				CONCAT(RTRIM(ti.apellido1),' ',RTRIM(ti.apellido2),' ',RTRIM(ti.nombre1),' ',RTRIM(ti.nombre2)) nombres, 
				ti.direccion, ti.telefono,tm.id_grado as cod_grado, tm.id as id_matric, tm.estado,tm.repite, 
				tm.fecha, tm.`año` , RTRIM(tg.grado) grado, RTRIM(ts.NOMbre_SEDE) sede, 
				td.abrev tdocumento
				FROM inscripciones AS ti 
				LEFT JOIN ".$db.".pre_matricula_nuevos AS tm ON tm.cod_est = ti.cod_est
				LEFT JOIN ".$db.".sedes AS ts ON tm.id_sede = ts.ID
				LEFT JOIN ".$db.".grados AS tg ON tm.id_grado = tg.id
				LEFT JOIN ".$db.".documentos AS td ON ti.cod_doc = td.id
				WHERE tm.id_inst = ".$this->get_id_school().
				" AND ti.id_inst = ".$this->get_id_school()." AND ts.ID_INST = ".$this->get_id_school()
				." ORDER BY tm.id_grado, sede, nombres";;
		
		// Nombre dado al informe de salida
		$report_export	= 'pre_matricula_nuevos'.$date;
				
		//Extension de Salida
		$format 	= $f;
				
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
		
	function ficha_observador($format,$Grado,$Grupo,$Jorn,$Matric,$Sede,$est){
		//Reporte a Procesar : Este nombre es del reporte creado en JasReport
		$report			=	'ficha_observador_mod3';
		$date			= date('Y-m-d h-m-s');
		// Nombre dado al informe de salida
		$report_export	= 'Observador '.$this->normaliza($est)." ".$date;
		//Extension de Salida
		$format 	= $format;
		$c_cuerpo	= "";
		$db         = $this->get_db_name();
		$ye		= $this->get_year();
		$query = "SELECT t1.encabezado,t1.cuerpo,t1.firma 
				FROM ".$db.".obs_modelos_observador_cuerpo AS t1 
				LEFT JOIN ".$db.".obs_modelos_observador AS t2 ON t1.id_observador = t2.id
				WHERE t2.estado = 1 LIMIT 1;";
		$sql  = $this->db->query($query);
		if ($sql->num_rows() > 0){
			$c_cuerpo	= $sql->row('cuerpo');
			$c_cuerpo	= str_replace("{P_NAME_STUDENT}",$est,$c_cuerpo);
		}
				
		$parm	= array(
			'SQL_PARAM' 	=> $query,
			'P_ID_MATRIC'	=> intval($Matric),
			'P_ANIO'		=> intval($ye),
			'P_ID_SEDE'		=> intval($Sede),
			'P_GRADO'		=> ($Grado),
			'P_GRUPO'		=> ($Grupo),
			'P_ID_JORN'		=> intval($Jorn),
			'R_CUERPO'		=> $c_cuerpo
		);
		
		$request	= $this->M_jreport->get_report_export($report,$report_export,$format,$query,$parm);
				
		return $request;
	}
	
	function report_familiares($f,$Grado,$Sede,$Jorn,$tp,$all){
		$db	= $this->get_db_name();
		$ye		= $this->get_year();
		$date	= date('Y-m-d h-m-s');
		//Reporte a Procesar : Este nombre es del reporte creado en JasReport
		$report	= 'familiares';
		
		$query	= "CALL ".$db.".`sp_familiares`(".$ye.",'".$Grado."',".$Sede.",".$tp.",".$all.")";
		
		// Nombre dado al informe de salida
		$report_export	= 'Lista familiares '.$date;
				
		//Extension de Salida
		$format 	= $f;
				
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
	
	function report_fechas_nac($f,$Grado,$Grupo,$Sede,$Jorn,$tp){
		$db	= $this->get_db_name();
		$ye		= $this->get_year();
		$date	= date('Y-m-d h-m-s');
		//Reporte a Procesar : Este nombre es del reporte creado en JasReport
		$report	= 'fechas_nacimiento';
		$query	= "CALL ".$db.".`sp_select_fechas_nac_report`('".$ye."','".$Sede."','".$Grado."','".$Grupo."',".$Jorn.",'".$tp."')";
		// Nombre dado al informe de salida
		$report_export	= 'Lista fechas de nacimiento '.$date;
		//Extension de Salida
		$format 	= $f;
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
	
	function report_listas_docentes($f){
		$db	= $this->get_db_name();
		$ye		= $this->get_year();
		$date	= date('Y-m-d h-m-s');
		//Reporte a Procesar : Este nombre es del reporte creado en JasReport
		$report	= 'lista_docentes';
		
		$query	= "CALL ".$db.".`sp_select_docentes_report`(".$ye.",0)";
		// Nombre dado al informe de salida
		$report_export	= 'Lista docentes'.$date;
		//Extension de Salida
		$format 	= $f;
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
	
	function report_listas_asignacion_acad($f,$doc,$sede,$grado){
		$db	= $this->get_db_name();
		$ye		= $this->get_year();
		$date	= date('Y-m-d h-m-s');
		if ($doc > 0){
			//Reporte a Procesar : Este nombre es del reporte creado en JasReport
			$report	= 'carga_academica';
		}else{
			//Reporte a Procesar : Este nombre es del reporte creado en JasReport
			$report	= 'carga_academica2';
		}
		$query	= "CALL ".$db.".`sp_select_carga_report`(".$ye.",".$sede.",'".$grado."',".$doc.")";
		// Nombre dado al informe de salida
		$report_export	= 'Carga academica '.$date;
		//Extension de Salida
		$format 	= $f;
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
	
	function report_listas_con_carga($f,$doc,$tp,$per){
		$id		= $this->get_id_school();
		$ye		= $this->get_year();
		$date	= date('Y-m-d h-m-s');
		
		//Reporte a Procesar : Este nombre es del reporte creado en JasReport
		$report	= 'listasc'.$tp;	
		$db	= $this->get_db_name();
		$query	= "CALL ".$db.".`sp_select_listas_carga`(".$ye.",'".$doc."')";
		
		// Nombre dado al informe de salida
		$report_export	= 'Listas '.$date;				
		//Extension de Salida
		$format 	= $f;				
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
			'SUBREPORT_DIR' => $this->M_jreport->subreport_dir,
			'R_PER'			=> $per
		);	
		$request	= $this->M_jreport->get_report_export($report,$report_export,$format,$query,$parm);				
		return $request;
	}
	
	function report_listas_sin_carga($format,$Grado,$Grupo,$Sede,$Jorn,$tp,$per){
		$ye		= $this->get_year();
		$date	= date('Y-m-d h-m-s');
		$db	= $this->get_db_name();
		//Reporte a Procesar : Este nombre es del reporte creado en JasReport
		$report	= 'listas'.$tp;			
		$query	= "CALL ".$db.".`sp_select_listas`(".$ye.",'".$Sede."','".$Grado."','".$Grupo."','".$Jorn."')";		
		// Nombre dado al informe de salida
		$report_export	= 'Listas '.$date;				
		//Extension de Salida
		$format 	= $format;				
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
			'SUBREPORT_DIR' => $this->M_jreport->subreport_dir,
			'R_PER'			=> $per
		);	
		$request	= $this->M_jreport->get_report_export($report,$report_export,$format,$query,$parm);				
		return $request;
	}
	
	function report_estadistica_edades($format){
		$db	= $this->get_db_name();
		$ye		= $this->get_year();
		$date	= date('Y-m-d h-m-s');
		//Reporte a Procesar : Este nombre es del reporte creado en JasReport
		$report	= 'estadistica_edades';	
		$query	= "CALL ".$db.".`sp_select_estadistica_edades`(".$ye.")";
		
		// Nombre dado al informe de salida
		$report_export	= 'Estadistica por edades '.$date;
				
		//Extension de Salida
		$format 	= $format;
				
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
	
	function report_matriculados($format,$Grado,$Grupo,$Sede,$Jorn,$tp){
		$ye		= $this->get_year();
		$db	= $this->get_db_name();
		$date	= date('Y-m-d h-m-s');
		if ($tp == 1){
			//Reporte a Procesar : Este nombre es del reporte creado en JasReport
			$report	= 'matriculados_acud';	
		}else{
			//Reporte a Procesar : Este nombre es del reporte creado en JasReport
			$report	= 'matriculados';
		}
		$query	= "CALL ".$db.".`sp_select_matriculados`(".$ye.",'".$Sede."','".$Grado."','".$Grupo."','".$Jorn."')";
		
		// Nombre dado al informe de salida
		$report_export	= 'Estudiantes matriculados '.$date;
				
		//Extension de Salida
		$format 	= $format;
				
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
	
	function report_desplazados($format){
		$ye		= $this->get_year();
		$db	= $this->get_db_name();
		$date	= date('Y-m-d h-m-s');
		//Reporte a Procesar : Este nombre es del reporte creado en JasReport
		$report	= 'desplazados';
		$query	= "CALL ".$db.".`sp_select_desplazados`(".$ye.")";
		
		// Nombre dado al informe de salida
		$report_export	= 'Estudiantes desplazados '.$date;
				
		//Extension de Salida
		$format 	= $format;
				
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
	
	function report_estudiantes_jorn($format){
		$ye		= $this->get_year();
		$date	= date('Y-m-d h-m-s');
		//Reporte a Procesar : Este nombre es del reporte creado en JasReport
		$report	= 'estudiantes_jornada';
		$db	= $this->get_db_name();	
		$query	= "CALL ".$db.".`sp_select_estudiantes_jorn`(".$ye.")";
		
		// Nombre dado al informe de salida
		$report_export	= 'Estudiantes por jornada '.$date;
				
		//Extension de Salida
		$format 	= $format;
				
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
	
	function report_cuadro_honor($format,$Grado,$Grupo,$Photo,$CkGrado,$Sede,$CkSede,$Nivel,$per,$lm,$niv,$ck){
		$id		= $this->get_id_school();
		$ye		= $this->get_year();
		$date	= date('Y-m-d h-m-s');
		if($CkGrado == 0 AND $CkSede == 0 AND $Nivel == 0 AND $Photo == 0){
			//Reporte a Procesar : Este nombre es del reporte creado en JasReport
			$report			=	'cuadro_honor';
						
			$query = "CALL `sp_select_cuadro_honor`(".$ye.",".$Sede.",'".$Grado."','".$Grupo."','".$per."',".$lm.
			",1,0,".$ck.")";
			
		}else if ($Photo == 1){
			//Reporte a Procesar : Este nombre es del reporte creado en JasReport
			$report			=	'cuadro_honor2';
						
			$query = "CALL `sp_select_cuadro_honor`(".$ye.",".$Sede.",'".$Grado."','".$Grupo."','".$per."',".$lm.
			",2,0,".$ck.")";
		}else if($CkGrado == 1){
			//Reporte a Procesar : Este nombre es del reporte creado en JasReport
			$report			=	'cuadro_honor3';
		 	$query = "CALL `sp_select_cuadro_honor`(".$ye.",".$Sede.",'".$Grado."','".$Grupo."','".$per."',".$lm.
		 	",3,0,".$ck.")";
		}else if($CkSede == 1){
			//Reporte a Procesar : Este nombre es del reporte creado en JasReport
			$report=	'cuadro_honor4';
		 	$query = "CALL `sp_select_cuadro_honor`(".$ye.",".$Sede.",'".$Grado."','".$Grupo."','".$per."',".$lm.
		 	",4,0,".$ck.")";
		}else if($Nivel == 1){
			//Reporte a Procesar : Este nombre es del reporte creado en JasReport
			$report	=	'cuadro_honor5';
		 	$query 	= "CALL `sp_select_cuadro_honor`(".$ye.",".$Sede.",'".$Grado."','".$Grupo."','".$per."',".$lm.",5,'".
		 	$niv."',".$ck.")";
		}
		
		// Nombre dado al informe de salida
		$report_export	= 'Cuadro de honor '.$date;
				
		//Extension de Salida
		$format 	= $format;
				
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
	
	
	function report_certificados_per($format,$pdbGrado,$pdbGrupo,$pdbJorn,$pdbMatric,$pdbSede,$pdbType,$est,$per){
		//Reporte a Procesar : Este nombre es del reporte creado en JasReport
		$report			=	'certificado_estudio_per';
		$date			= date('Y-m-d h-m-s');
		// Nombre dado al informe de salida
		$report_export	= 'certificado de estudio periodico '.$this->normaliza($est)." ".$date;
		
		//Extension de Salida
		$format 	= $format;
		
		$ye		= $this->get_year();
		$db		= $this->get_db_name();		
		$up		= "INSERT INTO ".$db.".certificate_numbers(id_parent,year,total,type) ".
				  "SELECT id,".$ye.",1,2 FROM ".$db.".config_const_cert WHERE type = 2 LIMIT 1 ".
				  "ON DUPLICATE KEY UPDATE total=total + 1";		
		$this->db->query($up);				
		$query = "SELECT t.*, RIGHT(CONCAT('0000000',t2.total),7) cons, t2.year ".
		"FROM ".$db.".config_const_cert AS t ".
		"LEFT JOIN ".$db.".certificate_numbers AS t2 ON t2.id_parent = t.id".
		" WHERE t2.year =".$ye." AND t.type = 2 LIMIT 1";

		$parm	= array(
			'R_ID_MATRIC'	=> intval($pdbMatric),
			'R_type'		=> intval($pdbType),
			'R_PERIODO'		=> $per,
			'R_GRADO'		=> $pdbGrado
		);
	
		$request	= $this->M_jreport->get_report_export($report,$report_export,$format,$query,$parm,$pdbGrado);
				
		return $request;
	}
	
	
	function report_constancias($format,$pdbGrado,$pdbGrupo,$pdbJorn,$pdbMatric,$pdbSede,$pdbType,$est){
		//Reporte a Procesar : Este nombre es del reporte creado en JasReport
		$report			= 'constancia_estudio';
		$date			= date('Y-m-d h-m-s');
		// Nombre dado al informe de salida
		$report_export	= 'constancia de estudio '.$this->normaliza($est)." ".$date;
		
		//Extension de Salida
		$format 	= $format;		
		$ye		= $this->get_year();
		$db		= $this->get_db_name();		
		$up		= "INSERT INTO ".$db.".certificate_numbers(id_parent,year,total,type) ".
				  "SELECT id,".$ye.",1,1 FROM ".$db.".config_const_cert WHERE type = 1 LIMIT 1 ".
				  "ON DUPLICATE KEY UPDATE total=total + 1";		
		$this->db->query($up);				
		$query = "SELECT t.*, RIGHT(CONCAT('0000000',t2.total),7) cons, t2.year ".
		"FROM ".$db.".config_const_cert AS t ".
		"LEFT JOIN ".$db.".certificate_numbers AS t2 ON t2.id_parent = t.id".
		" WHERE t2.year =".$ye." AND t.type = 1 LIMIT 1";
		$parm	= array(
			'R_ID_MATRIC'	=> intval($pdbMatric),
			'R_type'		=> intval($pdbType)
		);	
		$request	= 
		$this->M_jreport->get_report_export($report,$report_export,$format,$query,$parm,$pdbGrado);				
		return $request;
	}
	
	function report_nota_reportada($format,$pdbDocente,$pdbPeriodo){		
		//Reporte a Procesar : Este nombre es del reporte creado en JasReport
		$report			=	'notas_reportadas';
		$date	= date('Y-m-d h-m-s');
		// Nombre dado al informe de salida
		$report_export	= 'Notas reportadas '.$date;		
		//Extension de Salida
		$format 	= $format;		
		$id		= $this->get_id_school();
		$ye		= $this->get_year();		
		$query = "CALL `sp_select_notas_reportadas`(".$pdbDocente.",".$ye.",'".$pdbPeriodo."')";		
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
	
	function report_dir_grupos($forma){
				
		//Reporte a Procesar : Este nombre es del reporte creado en JasReport
		$report			=	'dir_grupo';
		// Nombre dado al informe de salida
		$report_export	= $this->session->userdata('user_description').' directores de grupo';		
		//Extension de Salida
		$format 	= $forma;		
		$ye		= $this->get_year();
		$db		= $this->get_db_name();	
		$query = "CALL `sp_select_dir_grupo`('".$ye."')";
		
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
	
	function report_ficha_matricula($id,$forma,$type,$Grado,$Grupo,$Sede,$Jorn, $year){
		$db	= $this->get_db_name();
		if($id > 0 ){
			$year	= $year;
		}else{
			$year	= $this->get_year();
		}

		$this->db->select('ficha_mat_x_año');
		$this->db->from($db.'.config001 AS t1');
		$this->db->join($db.'.grados_agrupados AS t2', 't1.id_grupo_grados = t2.id', 'left');
		$this->db->join($db.'.aux_grados_agrupados AS t3', 't3.id_grado_agrupado = t2.id', 'left');
		$this->db->join($db.'.grados AS tg', 't3.id_grado = tg.id', 'left');
		$this->db->where('t1.year', $year);
		$this->db->where('tg.id', $Grado);
		
		$sql = $this->db->get();
		$ficha = 0;
		if ($sql->num_rows() > 0){
			$ficha = $sql->row('ficha_mat_x_año');
		}
		//Reporte a Procesar : Este nombre es del reporte creado en JasReport
		if ($ficha > 0){
			$report			=	'ficha_matricula';
		}else{
			$report			=	'ficha_matricula2';
		}		
		// Nombre dado al informe de salida
		$report_export	= 'Ficha de matricula ';
		
		//Extension de Salida
		$format 	= $forma;
		if ($id > 0){
			$m_SQL	= "CALL ".$db.".sp_select_ficha_matricula('".$year."','".$id."',0,'".$Grupo."',1,1,".$type.")";
		}else{
			$m_SQL	= "CALL ".$db.".sp_select_ficha_matricula('".$year."',0,'".$Grado."','".$Grupo."','".$Sede."','".$Jorn."',".$type.")";
		}
		
		$query	= "";								
		$query	= $m_SQL;			
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
		$request	= $this->M_jreport->get_report_export($report,$report_export,$format,$query,$parm,$Grado);				
		return $request;	
	}
	
	function report_consolidado($per,$hoj,$type,$all,$c_gdo,$gpo,$jorn,$sede,$forma) {
		IF ($all == '1'){
			$z_per = '0';
		}else{
			$z_per = $per;			
		}
		$db	= $this->get_db_name();
		$year	= $this->get_year();
		$date	= $this->date;
		
		if ($type == '1') {
			if ($hoj == '1') {
				//Reporte a Procesar : Este nombre es del reporte creado en JasReport
				$report			=	'consolidado_asignaturas';
			}else{
				//Reporte a Procesar : Este nombre es del reporte creado en JasReport
				$report			=	'consolidado_asignaturas_horz';
			// Nombre dado al informe de salida
			}
			$tableTottal	= $db.'.consolidado_totales';
			$report_export	= $this->get_id_school().' consolidado_asignaturas '.$date;
			$xtype	= 1;
		}else{
			
			//Reporte a Procesar : Este nombre es del reporte creado en JasReport
			$report			=	'consolidado_areas';
			// Nombre dado al informe de salida
			$report_export	= $this->get_id_school().' consolidado_areas '.$date;
			$xtype	= 2;
			$tableTottal	= $db.'.consolidado_areas_totales';
		}
		
		//Extension de Salida
		$format 	= $forma;
		$m_SQL	= "CALL sp_select_consolidado_asig(".$sede.",".$jorn.",'".$c_gdo."','".$gpo."',".$this->get_year().",'".$z_per."',".$xtype.")";
		
		// $SQL1	= "SELECT desde,hasta FROM desempeños AS td
		// 		   LEFT JOIN ".$db.".grados_agrupados AS t1 ON td.id_grado_agrupado = t1.id
		// 		   LEFT JOIN ".$db.".aux_grados_agrupados AS t2 ON t2.id_grado_agrupado = t1.id
		// 		   WHERE reprueba=1 AND id_inst=".$this->get_id_school()." AND año=".$this->get_year().
		// 		  " AND t2.id_grado=".$c_gdo;
		// $SQL1	= $this->db->query($SQL1);
		$desde	= 0;
		$hasta	= 0;
		$NotaMin	= 0;
		$NotaMinB	= 0;
		if ($this->get_desempeños_rango($c_gdo)){
			$desde	= $this->desde;
			$hasta	= $this->hasta;
		};
				
		$this->db->select('desde, hasta');
		$this->db->from($db.'.desempeños AS td');
		$this->db->join($db.'.grados_agrupados AS t1', 'td.id_grado_agrupado = t1.id', 'left');
		$this->db->join($db.'.aux_grados_agrupados AS t2', 't2.id_grado_agrupado = t1.id', 'left');
		$this->db->where('td.year', $year);
		$this->db->where('td.id', 2);
		$this->db->where('t2.id_grado', $c_gdo);
		$this->db->limit(1);
		$SQL1 = $this->db->get();		
		if ($SQL1) {
			$row		= $SQL1->row(); 
			$NotaMin	= $row->desde;
			$NotaMinB	= $row->desde;
			$SQL1->free_result();	
		}
		
		$query	= "";
		$query	= $m_SQL;
		$escala	= $this->escala($c_gdo);
		$queryTotales	= "SELECT * FROM ".$tableTottal." WHERE id_grado = ".$c_gdo." AND id_sede=".$sede.
					" AND year = ".$this->get_year()." AND id_jorn=".$jorn."
					 AND grupo= '".$gpo."' AND periodo <> 0";
		
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
			'P_ALLPER'		=> $all,
			'P_DESDE'		=> $desde,
			'P_HASTA'		=> $hasta,
			'P_NotaMin'		=> $NotaMin,
			'P_NotaMinB'	=> $NotaMinB,
			'SQL_TOTALES'	=> $queryTotales
		);
		//print_r($queryTotales);
		$request	= $this->M_jreport->get_report_export($report,$report_export,$format,$query,$parm);
				
		return $request;
	}
}