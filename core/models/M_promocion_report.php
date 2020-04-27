<?php
	defined('BASEPATH') OR exit('No direct script access allowed');
class M_promocion_report extends SME_Model {
	function __construct() {
		parent::__construct();
		$this->load->model('M_jreport');
		$this->load->model('M_generate_libro_final');
	}
	
	public function historial_academico($f,$grado){
		$db     = $this->get_db_name();
		$id		= $this->get_id_school();
		$ye		= $this->get_year();
		$date	= date('Y-m-d h-m-s');
		//Reporte a Procesar : Este nombre es del reporte creado en JasReport
		$report	= 'historial_academico';		
				
		$query	= "SELECT ta.id_matric,ta.msg,ta.promedio, ta.promedio_rec, ta.prom_comision, ta.areas_p,
		tm.id_grade AS cod_grado,tm.id_group AS grupo, tm.year, tx.abrev_sexo AS sexo,
		CONCAT(RTRIM(te.apellido1),' ',RTRIM(te.apellido2),' ',RTRIM(te.nombre1),' ',RTRIM(te.nombre2)) estudiante,
		RTRIM(tg.grado) grado, RTRIM(tj.JORNADA) jornada, RTRIM(ts.NOMBRE_SEDE) sede
		FROM ".$db .".acta_promocion AS ta
		LEFT JOIN ".$db .".student_enrollment AS tm ON ta.id_matric = tm.id 
		LEFT JOIN ".$db .".inscripciones AS te ON tm.id_student = te.id 
		LEFT JOIN ".$db .".sexo AS tx ON te.id_sexo = tx.id
		LEFT JOIN ".$db .".grados tg ON tm.id_grade = tg.id
		LEFT JOIN ".$db .".jornadas AS tj ON tm.id_study_day = tj.cod_jorn 
		LEFT JOIN ".$db .".sedes AS ts ON tm.id_headquarters = ts.ID
		WHERE tm.id_grade BETWEEN ".$grado." AND 15 AND tm.id_state = 2 AND 
		ta.estado = 2
		ORDER BY estudiante,tm.id_grade, tm.id_group,ta.estado,tm.year;";
		
		// Nombre dado al informe de salida
		$report_export	= 'Historial academico '.$date;
				
		//Extension de Salida
		$format 	= $f;
				
		$request	= $this->M_jreport->get_report_export($report,$report_export,$format,$query);
				
		return $request;
	}
	
	public function sabanas_finales($f,$grado,$sede,$jorn,$grupo){
		$ye		= $this->get_year();
		$db     = $this->get_db_name();
		$date	= date('Y-m-d h-m-s');
		//Reporte a Procesar : Este nombre es del reporte creado en JasReport
		$report	= 'sabanas_finales';		
				
		$query	= "CALL ".$db.".sp_select_sabanas('".$ye."','".$sede."','".$jorn."','".$grado."','".$grupo."')";
		
		// Nombre dado al informe de salida
		$report_export	= 'Sabanas finales '.$date;
				
		//Extension de Salida
		$format 	= $f;
				
		$parm	= array(
			"FILTRO_AÑO"	=> strval($this->get_year())
		);
	
		$request	= $this->M_jreport->get_report_export($report,$report_export,$format,$query,$parm);
				
		return $request;
	}
	
	public function acta_grado($f,$grado,$sede,$jorn,$grupo,$matric){
		$id		= $this->get_id_school();
		$ye		= $this->get_year();
		$date	= date('Y-m-d h-m-s');
		$SQL	= "SELECT * FROM config_acta_grado WHERE id_inst = ".$id." AND año = ".$ye;
		$SQL	= $this->db->query($SQL);
		$total	= 0;
		$sqlt	= "SELECT COUNT(tac.id_matric) total FROM matriculas AS tm 
			      	LEFT JOIN acta_promocion AS tac ON tac.id_matric = tm.id_matric 
					WHERE tm.año = ".$ye." AND tm.id_sede  = ".$sede." and tm.cod_grado= '".$grado."' 
					and tm.grupo= '".$grupo."' and tm.id_jorn= ".$jorn." AND tm.estado = 2 
					AND (tac.estado = 1 OR tac.estado = 4) AND tm.id_inst = 1;";
		$sqlt 	= $this->db->query($sqlt);
		if ($sqlt -> num_rows() > 0){
			$total	= $sqlt->row('total');
		}
		$constancia	= $SQL->row('constancia');
		if ($total > 0){
			$constancia = str_replace("{P_N_STUDENT}",$total,$constancia);
		}		
		$sqlFist	= "SELECT concat(rtrim(te.nombre1),' ',rtrim(te.nombre2),' ',
						rtrim(te.apellido1),' ',rtrim(te.apellido2)) as estudiantes
						FROM matriculas AS tm 
			      		LEFT JOIN acta_promocion AS tac ON tac.id_matric = tm.id_matric 
						LEFT JOIN inscripciones AS te ON tm.cod_est=te.cod_est 
						WHERE tm.año = ".$ye." AND tm.id_sede  = ".$sede." AND tm.cod_grado= '".$grado."' AND
						tm.grupo= '".$grupo."' AND tm.id_jorn= ".$jorn.
						" AND tm.estado = 2 AND (tac.estado = 1 OR tac.estado = 4) AND 
						tm.id_inst = 1 AND te.id_inst = 1 
						ORDER BY estudiantes LIMIT 1;";
		$sqlFist	= $this->db->query($sqlFist);
		if($sqlFist->num_rows() > 0){
			$sqlFist = $sqlFist->row('estudiantes');
			$constancia = str_replace("{P_FIRST_STUDENT}",$sqlFist,$constancia);
		}
		
		$sqlLast	= "SELECT concat(rtrim(te.nombre1),' ',rtrim(te.nombre2),' ',
						rtrim(te.apellido1),' ',rtrim(te.apellido2)) as estudiantes
						FROM matriculas AS tm 
			      		LEFT JOIN acta_promocion AS tac ON tac.id_matric = tm.id_matric 
						LEFT JOIN inscripciones AS te ON tm.cod_est=te.cod_est 
						WHERE tm.año = ".$ye." AND tm.id_sede  = ".$sede." AND tm.cod_grado= '".$grado."' AND
						tm.grupo= '".$grupo."' AND tm.id_jorn= ".$jorn.
						" AND tm.estado = 2 AND (tac.estado = 1 OR tac.estado = 4) AND 
						tm.id_inst = 1 AND te.id_inst = 1 
						ORDER BY estudiantes DESC LIMIT 1;";
		$sqlLast	= $this->db->query($sqlLast);
		if($sqlLast->num_rows() > 0){
			$sqlLast = $sqlLast->row('estudiantes');
			$constancia = str_replace("{P_LAST_STUDENT}",$sqlLast,$constancia);
		}
		
		$sqlFolio	= "SELECT tac.folio, tac.libro
						FROM matriculas AS tm 
      					LEFT JOIN acta_promocion AS tac ON tac.id_matric = tm.id_matric 
						WHERE tm.año = ".$ye." AND tm.id_matric =".$matric;		
		$sqlFolio	= $this->db->query($sqlFolio);
		
		$copia		= $SQL->row('copia_folio');
		
		if ($sqlFolio->num_rows() > 0){
			$folio	= $sqlFolio->row('folio');
			$libro	= $sqlFolio->row('libro');
			$copia = str_replace("{P_NRO_FOLIO}",str_pad($folio,3,'0',STR_PAD_LEFT),$copia);
			$copia = str_replace("{P_NRO_LIBRO}",str_pad($libro,3,'0',STR_PAD_LEFT),$copia);
		}
		//Reporte a Procesar : Este nombre es del reporte creado en JasReport
		$report	= 'acta_grado_carta';		
				
		$query	= "CALL `sp_select_listado_diploma`('".$id."','".$sede."','".$grado."','".$grupo
													."','".$jorn."','".$ye."','".$matric."')";
		
		// Nombre dado al informe de salida
		$report_export	= 'Acta de grado '.$date;
				
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
			"FILTRO_AÑO"	=> strval($this->get_year()),
			'R_ENCABEZADO'	=> $SQL->row('encabezado'),
			'R_NOMBRE_INST'	=> $SQL->row('nombre_inst'),
			'R_RESOLUCION'	=> $SQL->row('resolucion'),
			'R_OTORGA'		=> $SQL->row('otorga'),
			'R_DIPLOMA'		=> $SQL->row('diploma'),
			'R_FIRMA'		=> $SQL->row('firma'),
			'R_AL_ALUMNO'	=> $SQL->row('al_alumno'),
			'R_COPIA_FOLIO'	=> $copia,
			'R_CONSTANCIA'	=> $constancia,
			'R_FIRMA_REC'	=> intval($SQL->row('firma_rec')),
			'R_FIRMA_SEC'	=> intval($SQL->row('firma_sec'))
		);
	
		$request	= $this->M_jreport->get_report_export($report,$report_export,$format,$query,$parm);
				
		return $request;
	}
	
	public function promocion_anticipada($f,$pdbId, $grade){
		$db    	= $this->get_db_name();
		$date	= date('Y-m-d h-m-s');
		//Reporte a Procesar : Este nombre es del reporte creado en JasReport
		$report	= 'certificado_promovidos';		
		$query	= "SELECT * FROM ".$db.".promoted_observation WHERE promoted_id =".$pdbId." LIMIT 1";
		// Nombre dado al informe de salida
		$report_export	= 'Certificado promocion anticipada '.$date;
		//Extension de Salida
		$format 	= $f;
		$parm		= array(
			"FILTRO_AÑO"	=> $this->get_year()
		);
		$request	= $this->M_jreport->get_report_export($report,$report_export,$format,$query,$parm, $grade);
		return $request;
	}
	
	public function actas_promocion_esta($f,$type){
		$id		= $this->get_id_school();
		$ye		= $this->get_year();
		$date	= date('Y-m-d h-m-s');
		if ($type == 1){
			//Reporte a Procesar : Este nombre es del reporte creado en JasReport
			$report	= 'actas_promocion_esta_grado';
		}else{
			//Reporte a Procesar : Este nombre es del reporte creado en JasReport
			$report	= 'actas_promocion_esta';
		}
		
				
		$query	= "CALL `sp_acta_promo_estadistica`(".$this->get_year().",".$type.")";
		
		// Nombre dado al informe de salida
		$report_export	= 'Acta de promocion estadistica '.$date;
				
		//Extension de Salida
		$format 	= $f;
				
		$parm	= array(
			"FILTRO_AÑO"	=> strval($this->get_year())
		);
	
		$request	= $this->M_jreport->get_report_export($report,$report_export,$format,$query,$parm);
				
		return $request;
	}
	
	public function actas_promocion($f,$Grado,$Sede,$Jorn,$grupo){
		$ye		= $this->get_year();
		$date	= date('Y-m-d h-m-s');
		//Reporte a Procesar : Este nombre es del reporte creado en JasReport
		$report	= 'actas_promocion';
				
		$query	= "CALL `sp_select_acta_promocion`('".$Grado."','".$grupo."',".$Jorn.",".$Sede.",".$this->get_year().")";
		
		// Nombre dado al informe de salida
		$report_export	= 'Acta de promocion '.$date;
				
		//Extension de Salida
		$format 	= $f;
				
		$parm	= array(
			"FILTRO_AÑO"	=> strval($this->get_year())
		);
	
		$request	= $this->M_jreport->get_report_export($report,$report_export,$format,$query,$parm);
				
		return $request;
	}
	
	public function recuperaciones_finales($f,$doc){
		$db         = $this->get_db_name();
		$date	= date('Y-m-d h-m-s');
		//Reporte a Procesar : Este nombre es del reporte creado en JasReport
		$report	= 'recuperacionesfinales';
				
		$query	= "CALL  ".$db.".`sp_select_respeciales_docente`(".$this->get_year().",".$doc.",0)";
		
		
		// Nombre dado al informe de salida
		$report_export	= 'Actividades de apoyo finales '.$date;
				
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
	
	public function report_certificado_final($Grado,$Grupo,$Sede,$Jorn,$one,$f,$h,$per,$tp,$mod,$dist){
		$db     = $this->get_db_name();
		$ye		= $this->get_year();
		$date	= date('Y-m-d h-m-s');	
		$niv	= $this->get_nivel_escolar($Grado);
		if ($niv > 1){
			if ($dist == 1){
				if ($h == '1'){
					//Reporte a Procesar : Este nombre es del reporte creado en JasReport
					$report	= 'certificado_final_distri';
				}else{
					//Reporte a Procesar : Este nombre es del reporte creado en JasReport
					$report	= 'certificado_final_carta_distri';
				}
				$query	= "CALL `sp_select_areasf`(".$ye.",".$Sede.",'".$Grado."','".$Grupo."',".$Jorn.",".$one.",".$dist.")";
			}else{
				// Solo Áreas
				if ($tp == 1){
					if ($h == '1'){
						//Reporte a Procesar : Este nombre es del reporte creado en JasReport
						$report	= 'certificado_final_areas';
					}else{
						//Reporte a Procesar : Este nombre es del reporte creado en JasReport
						$report	= 'certificado_final_areas_carta';
					}
					$query	= "CALL `sp_select_areasf_agrupada`(".$ye.",".$Sede.",'".$Grado."','".$Grupo."',".$Jorn.",".$one.")";
				}else{
					if ($h == '1'){
						//Reporte a Procesar : Este nombre es del reporte creado en JasReport
						$report	= 'certificado_final';
					}else{
						//Reporte a Procesar : Este nombre es del reporte creado en JasReport
						$report	= 'certificado_final_carta';
					}
					$query	= "CALL `sp_select_areasf`(".$ye.",".$Sede.",'".$Grado."','".$Grupo."',".$Jorn.",".$one.",0)";	
				}
			}
		}else{
			$periodo = 5;
			$query	= "SELECT periodo FROM ".$db.".periodos_academicos AS td
			LEFT JOIN ".$db.".grados_agrupados AS t1 ON td.id_grado_agrupado = t1.id
			LEFT JOIN ".$db.".aux_grados_agrupados AS t2 ON t2.id_grado_agrupado = t1.id
			WHERE td.year = ".$ye." AND t2.id_grado = ".$Grado." 
			ORDER BY td.periodo DESC LIMIT 1";
			$query	= $this->db->query($query);
			if($query->num_rows() > 0){
				$periodo = $query->row('periodo');
			}
			
			if ($h == '1'){
				//Reporte a Procesar : Este nombre es del reporte creado en JasReport
				$report	= 'certificado_final_oficio_preescolar';
			}else{
				//Reporte a Procesar : Este nombre es del reporte creado en JasReport
				$report	= 'certificado_final_carta_preescolar';
			}
			$query	= 	"CALL `sp_boletines_reportes`(".$Sede.",'".$Grado."','".$Grupo."',".$Jorn.",".$ye.",'".$periodo."',".$one.")";
		}

		if($Grado > 15){
			$type	= 5;
		}else{
			$type	= 4;
		}
	
		$up		= "INSERT INTO ".$db.".certificate_numbers(id_parent,year,total,type) ".
				  "SELECT id,".$ye.",1,1 FROM ".$db.".config_const_cert_end WHERE type = ".$type." LIMIT 1 ".
				  "ON DUPLICATE KEY UPDATE total=total + 1";		
		$this->db->query($up);		

		$sql	= "SELECT t.*, RIGHT(CONCAT('0000000',t2.total),7) cons, t2.year ".
		"FROM ".$db.".config_const_cert_end AS t ".
		"LEFT JOIN ".$db.".certificate_numbers AS t2 ON t2.id_parent = t.id".
		" WHERE ".$ye." BETWEEN t.year_from AND t.year_until AND t2.year =".$ye." AND t.type = ".$type." LIMIT 1";
		
		$sql	= $this->db->query($sql);

		// Nombre dado al informe de salida
		$report_export	= 'Certificado final '.$date;

		//Extension de Salida
		$format 	= $f;
				
		$parm	= array(
			'R_ENCABEZADO'	=> $sql->row('header1'),
			'R_ENCABEZADO2'	=> $sql->row('header2'),
			'R_CUERPO'		=> $sql->row('body'),
			'R_CERTIFICA'	=> $sql->row('message'),
			'R_TYPE'		=> intval($mod),
			'R_RESOLUCION'	=> $sql->row('resolution'),
			'R_EXPEDICION'	=> $sql->row('expedition'),
			'R_FIRMA_REC'	=> intval($sql->row('rector_firm')),
			'R_FIRMA_SEC'	=> intval($sql->row('signature_secretary')),
			'R_NRO_CERT'	=> $sql->row('cons'),
			'R_VIEW_CERT'	=> intval($sql->row('show_number'))
		);	
		$request	= $this->M_jreport->get_report_export($report,$report_export,$format,$query,$parm,$Grado);			
		return $request;
	}
	
	public function  get_generate_libros($Grado,$Grupo,$Sede,$Jorn,$all,$per){	
		return $this->M_generate_libro_final->sp_generar_libros($Grado,$Grupo,$Sede,$Jorn,$all,$per);
	}
	
	public function report_libro_final($Grado,$Grupo,$Sede,$Jorn,$one,$f,$h,$per){
		$id		= $this->get_id_school();
		$db     = $this->get_db_name();
		$ye		= $this->get_year();
		$date	= date('Y-m-d h-m-s');
		$niv	= $this->get_nivel_escolar($Grado);
		if ($niv > 1){
			if($per == 1){
				if ($h == '1'){
					//Reporte a Procesar : Este nombre es del reporte creado en JasReport
					$report	= 'libro_final_quinta';
				}else{
					//Reporte a Procesar : Este nombre es del reporte creado en JasReport
					$report	= 'libro_final_carta_quinta';
				}	
			}else{
				if ($h == '1'){
					//Reporte a Procesar : Este nombre es del reporte creado en JasReport
					$report	= 'libro_final';
				}else{
					//Reporte a Procesar : Este nombre es del reporte creado en JasReport
					$report	= 'libro_final_carta';
				}	
			}	
			$query	= "CALL `sp_select_areasf`(".$ye.",".$Sede.",'".$Grado."','".$Grupo."',".$Jorn.",".$one.",0)";
			// Nombre dado al informe de salida
			$report_export	= 'Lista final '.$date;	
		}else{
			$periodo = 5;
			$query	= "SELECT periodo FROM ".$db.".periodos_academicos AS td
			LEFT JOIN ".$db.".grados_agrupados AS t1 ON td.id_grado_agrupado = t1.id
			LEFT JOIN ".$db.".aux_grados_agrupados AS t2 ON t2.id_grado_agrupado = t1.id
			WHERE td.year = ".$ye." AND t2.id_grado = ".$Grado." 
			ORDER BY td.periodo DESC LIMIT 1";
			$query	= $this->db->query($query);
			if($query->num_rows() > 0){
				$periodo = $query->row('periodo');
			}
			if ($h == '1'){
				//Reporte a Procesar : Este nombre es del reporte creado en JasReport
				$report	= 'libro_oficio_prescolar';
			}else{
				//Reporte a Procesar : Este nombre es del reporte creado en JasReport
				$report	= 'libro_carta_prescolar';
			}			
			$query	= "CALL `sp_boletines_reportes`(".$Sede.",'".$Grado."','".$Grupo."',".$Jorn.",".$ye.",'".$periodo."',".$one.")";
			// Nombre dado al informe de salida
			$report_export	= 'Lista final preescolar '.$date;
		}
								
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
	
		$request	= $this->M_jreport->get_report_export($report,$report_export,$format,$query,$parm,$Grado);
				
		return $request;
	}
}