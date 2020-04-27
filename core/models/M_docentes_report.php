<?php
defined('BASEPATH') OR exit('No direct script access allowed');
class M_docentes_report extends SME_Model {
	function __construct() {
		parent::__construct();
		$this->load->model('M_jreport');
	}
	
	public function report_boletin ($c_grado,$id_sede,$periodo,$grupo,$cod_jorn,$hojaReport,$typeReport,$format,$mat) {
		$year		= $this->get_year();
		$table		= $this->tabla_notas($c_grado);
		$date		= $this->date;
		$db			= $this->get_db_name();
		$active		= 0;
		$active_msg	= 0;
		$notaPrees	= 0;

		$this->db->select('COUNT(id_pk) notas_num_prees');
		$this->db->from($db.'.desempeños AS td');
		$this->db->join($db.'.grados_agrupados AS t1', 'td.id_grado_agrupado = t1.id', 'left');
		$this->db->join($db.'.aux_grados_agrupados AS t2', 't2.id_grado_agrupado = t1.id', 'left');
		$this->db->where('td.year', $year);
		$this->db->where('t2.id_grado', $c_grado);		
		$get_prees	= $this->db->get();

		if($get_prees->num_rows() > 0){
			$notaPrees = $get_prees->row('notas_num_prees');
		}		
		if(($c_grado <=4) AND ($notaPrees == 0)) {
			if($hojaReport == 1){
				$report			= 'boletin_oficio_preescolar';
				$report_export	= $this->get_user_id().' boletin oficio prescolar perido'.$periodo." ".$date;
			}else{
				$report			= 'boletin_carta_preescolar';
				$report_export	= $this->get_user_id().' boletin carta prescolar perido'.$periodo." ".$date;
			}
		}else{				
			switch($typeReport){
				case 2 :   				// Modelo 2
					if($hojaReport == 1){
						$report			= 'boletin_oficio_asig';
						$report_export	= $this->get_user_id().' boletin oficio asignatutas'.$periodo." ".$date;
					}else{
						$report			= 'boletin_carta_asig';
						$report_export	= $this->get_user_id().' boletin carta asignatutas'.$periodo." ".$date;
					}
					break;
				case 3 :   				// Modelo 3
					if($hojaReport == 1){
						$report			= 'boletin_oficio_areas_comp';
						$report_export	= $this->get_user_id().' boletin oficio areas competencia'.$periodo." ".$date;
					}else{
						$report			= 'boletin_carta_areas_comp';
						$report_export	= $this->get_user_id().' boletin carta areas competencia'.$periodo." ".$date;
					}
					break;
				case 4 :   				// Modelo 4
					if($hojaReport == 1){
						$report			= 'boletin_oficio_areas_proy';
						$report_export	= $this->get_user_id().' boletin oficio proy transversales'.$periodo." ".$date;
					}else{
						$report			= 'boletin_carta_areas_proy';
						$report_export	= $this->get_user_id().' boletin carta proy transversales'.$periodo." ".$date;
					}
					break;
				case 5 :   				// Modelo 5
					if($hojaReport == 1){
						$report			= 'boletin_oficio_areas2';
						$report_export	= $this->get_user_id().' boletin oficio areas'.$periodo." ".$date;
					}else{
						$report			= 'boletin_carta_areas2';
						$report_export	= $this->get_user_id().' boletin carta areas'.$periodo." ".$date;
					}
					break;
				case 6 :   				// Modelo 6
					if($hojaReport == 1){
						$report			= 'boletin_oficio_asig2';
						$report_export	= $this->get_user_id().' boletin oficio asignatutas'.$periodo." ".$date;
					}else{
						$report			= 'boletin_carta_asig2';
						$report_export	= $this->get_user_id().' boletin carta asignatutas'.$periodo." ".$date;
					}
					break;
				case 9	: // Modelo areas samac
					if($hojaReport == 1){
						$report			= 'boletin_oficio_areas3';
						$report_export	= $this->get_user_id().' boletin oficio areas'.$periodo." ".$date;
					}else{
						$report			= 'boletin_carta_areas3';
						$report_export	= $this->get_user_id().' boletin carta areas'.$periodo." ".$date;
					}
					break;
				case 10	: // Modelo areas samac
					if($hojaReport == 1){
						$report			= 'preinforme_oficio';
						$report_export	= 'preinforme '.$periodo." ".$date;
					}else{
						$report			= 'preinforme_carta';
						$report_export	= ' preinforme '.$periodo." ".$date;
					}
					break;
				default: 		// Modelo 1
					if($hojaReport == 1){
						$report			= 'boletin_oficio_areas';
						$report_export	= $this->get_user_id().' boletin oficio areas'.$periodo." ".$date;
					}else{
						$report			= 'boletin_carta_areas';
						$report_export	= $this->get_user_id().' boletin carta areas'.$periodo." ".$date;
					}
					break;
			}			
		}
									
		$query = "CALL ".$db.".`sp_boletines_reportes`(".$id_sede.",'".$c_grado."','".$grupo."',".$cod_jorn.",".$year.",".$periodo.",".$mat.")";
		$queryp = "SELECT activeindica, activamsg FROM ".$db.".configboletin  LIMIT 1";

		$queryp = $this->db->query($queryp);
		if($queryp->num_rows() > 0){
			$active		= $queryp->row('activeindica');
			$active_msg	= $queryp->row('activamsg');
		}
		
		$ext_param = array(
			'R_MSG_IND'		=> $active,
			'R_MSG_ACT'		=> $active_msg
		);
				
		$request	= $this->M_jreport->get_report_export($report,$report_export,$format,$query,$ext_param,$c_grado);
		return $request;
	}
	
	public function recuperaciones_periodicas ($formato,$cod_grado,$periodo,$doc,$niv,$report_type	= 0) {
		$db         = $this->get_db_name();	
		$year		= $this->get_year();
		if ($niv > 0){
			$this->db->where('id_nivel', $niv);
			$sql	= $this->db->get($db.'.grados',1);
			if($sql->num_rows() > 0){
				$cod_grado	= $sql->row('id');
				$this->get_desempeños_rango($cod_grado);
				$table		= $this->tabla_notas($cod_grado);
			}else{
				$request	= $this->get_error();
				return	$request;
			}
		}else{
			$this->get_desempeños_rango($cod_grado);
			$table 	= $this->tabla_notas($cod_grado);
		}		
		//Reporte a Procesar : Este nombre es del reporte creado en JasReport
		$report			=	'recuperacionesperiodicas';
		// Nombre dado al informe de salida
		$report_export	= $this->session->userdata('user_description').' nivelaciones periodicas '
							.'periodo'.$periodo;
		//Extension de Salida
		$format 	= $formato;
		$query	= "SELECT tn.periodo,tn.final,tn.nota_perdida,tn.nota_habilitacion, 
		tn.fecha,tc.id_grado, tc.grupo, tc.year, 
		tc.id_jorn, tc.id_sede, tc.id_asig, tc.id_docente,
		tn.id_escala conceptual,CONCAT(RTRIM(te.apellido1),' ',RTRIM(te.apellido2),' ',RTRIM(te.nombre1)
		,' ',RTRIM(te.nombre2)) AS estudiante,te.id AS id_student, tm.id_state estado,tar.area, tar.abrev AS abre_area, 
		tas.asignatura, tas.abrev AS abrev_asig, tau.id_area cod_area, 
		CONCAT(RTRIM(td.apellido1),' ',RTRIM(td.apellido2),' ',	RTRIM(td.nombre1),' ',RTRIM(td.nombre2)) as docente,
		ts.NOMBRE_SEDE AS sede, tj.jornada, tg.grado, tg.cod_grado
		FROM ".$table." AS tn 
		LEFT JOIN cursos AS tc ON (tn.id_curso=tc.id AND tn.year = tc.year)
		LEFT JOIN student_enrollment AS tm ON tn.id_matric = tm.id 
		LEFT JOIN inscripciones AS te ON tm.id_student = te.id 
		LEFT JOIN asignaturas AS tas ON tc.id_asig=tas.id_pk  
		LEFT JOIN aux_asignaturas AS tau ON (tau.id_asign = tas.id_pk  AND tau.year = tc.year)
	    LEFT JOIN areas AS tar ON tau.id_area=tar.id
	    LEFT JOIN docentes AS td ON tc.id_docente=td.id_docente 
	    LEFT JOIN sedes AS ts ON tc.id_sede=ts.id 
	    LEFT JOIN jornadas AS tj ON tc.id_jorn=tj.cod_jorn 
	    LEFT JOIN grados As tg ON tc.id_grado=tg.id ";
		
		if($report_type < 2){
			if ($doc > 0){	
				$where	= "tn.nota_perdida > 0 AND tm.id_state = 2 ".
				" AND tn.periodo='".$periodo."' AND tm.year=".$year.
				" AND tn.year=".$year." AND tc.year=".$year.
				" AND tc.id_docente=".$doc."  
				ORDER BY tm.id_grade, tm.id_group, tm.id_study_day, estudiante, docente,tc.id_asig,tau.id_area";
			}else{
				$where	= "tn.nota_perdida > 0 AND tm.id_state = 2 AND tm.id_grade='".$cod_grado.
				"' AND tn.periodo=".$periodo." AND tm.year=".$year.
				" AND tn.year=".$year." AND tc.year=".$year.
				" AND tc.id_grado=".$cod_grado.
				" AND tc.id_docente=".$this->get_parent()."  
				ORDER BY tm.id_grade, tm.id_group, tm.id_study_day, estudiante, docente,tc.id_asig,tau.id_area";
			}
		}else{
			if ($doc > 0){	
				$where	= "tn.final BETWEEN '".$this->desde."' AND '".$this->hasta."' AND tm.id_state = 2 ".
				" AND tn.periodo='".$periodo."' AND tm.year=".$year.
				" AND tn.year=".$year." AND tc.year=".$year.
				" AND tc.id_docente=".$doc."  
				ORDER BY tm.id_grade, tm.id_group, tm.id_study_day, estudiante, docente,tc.id_asig,tau.id_area";
			}else{
				$where	= "tn.final BETWEEN '".$this->desde."' AND '".$this->hasta."' AND tm.id_state = 2 AND tm.id_grade='".$cod_grado.
				"' AND tn.periodo=".$periodo." AND tm.year=".$year.
				" AND tn.year=".$year." AND tc.year=".$year.
				" AND tc.id_grado=".$cod_grado.
				" AND tc.id_docente=".$this->get_parent()."  
				ORDER BY tm.id_grade, tm.id_group, tm.id_study_day, estudiante, docente,tc.id_asig,tau.id_area";
			}

		}
		$query = $query." WHERE ".$where;
		$request	= $this->M_jreport->get_report_export($report,$report_export,$format,$query);
		return $request;
	}
	
	public function report_parcelador ($periodo,$formato,$id) {
		//Reporte a Procesar : Este nombre es del reporte creado en JasReport
		$report			=	'parcelador';		
		// Nombre dado al informe de salida
		$report_export	= $this->session->userdata('user_description').' parcelador '.'periodo'.$periodo." ".$this->date;	
		//Extension de Salida
		$format 	= $formato;				
		$id			= $id;				
		$query ="SELECT tp.*, CONCAT(RTRIM(td.apellido1),' ',RTRIM(td.apellido2),' ',
		RTRIM(td.nombre1),' ',RTRIM(td.nombre2)) AS docente, 
		tg.grado, ts.nom_sede AS sede, tme.metodologia, tas.asignatura, tar.area 
		FROM parcelador AS tp 
		LEFT JOIN docentes AS td ON tp.id_docente=td.id_docente 
		LEFT JOIN grados AS tg ON tp.id_grado=tg.id 
		LEFT JOIN sedes AS ts ON tp.id_sede=ts.id 
		LEFT JOIN metodologias AS tme ON tp.id_metod=tme.id 
		LEFT JOIN asignaturas AS tas ON tp.id_asig=tas.id_pk  
		LEFT JOIN areas AS tar ON tau.id_area=tar.id";				
		$where	= "tp.id=".$id;		
		$query = $query.' WHERE '.$where;				
		$request	= $this->M_jreport->get_report_export($report,$report_export,$format,$query);		
		return $request;
	}
}