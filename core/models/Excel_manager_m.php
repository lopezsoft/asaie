<?php 
defined('BASEPATH') OR exit('No direct script access allowed');
      
class Excel_manager_m extends SME_Model {
	var $objXls,
	 	$fileXls,
	 	$fileExport;
	function __construct() {
		parent::__construct();
		$this->load->library('Excel');
		$this->load->helper('download');
		$this->objXls	= new Excel();
		$this->fileXls	= $this->directory_path.'assets/plantillas/plantilla notas.xlsx';
		$this->fileExport	= "uploads/Archivo_salida.xlsx";
		$this->load->model('M_jreport');
	}

	public function load_excel_students($file){
		$path		= $this->get_excel_user_folders($this->get_user_id());
		$palntila	= $this->upload_file($file,$path);
		$year		= $this->get_year();
		$db			= $this->get_db_name();

		$palntila	= json_decode($palntila);

		if ($palntila->success == TRUE){
			$doc			= $palntila->foto;
			$this->fileXls 	= $this->directory_path.$doc;
			$this->objXls	= $this->objXls->load_xls($this->fileXls);
			$this->objXls->setActiveSheetIndex(3);

			// Número de filas
			$rows_xls	= $this->objXls->setActiveSheetIndex(3)->getHighestRow();
			if($rows_xls > 2){
				try {
					//iterando el contenido de las celdas
					$objWorksheet = $this->objXls->getActiveSheet();
					for ($i=3; $i <= $rows_xls; $i++) { 
						// Inscripción
						$zona		= $objWorksheet->getCell('A'.$i)->getValue();	
						$tipo_doc	= $objWorksheet->getCell('B'.$i)->getValue();
						$sexo		= $objWorksheet->getCell('C'.$i)->getValue();
						$pais		= $objWorksheet->getCell('D'.$i)->getValue();
						$documento	= $objWorksheet->getCell('E'.$i)->getValue();
						$ciud_naci	= $objWorksheet->getCell('F'.$i)->getValue();
						$ciud_resi	= $objWorksheet->getCell('G'.$i)->getValue();
						$ciud_exp	= $objWorksheet->getCell('H'.$i)->getValue();
						$apellido1	= $objWorksheet->getCell('I'.$i)->getValue();
						$apellido2	= $objWorksheet->getCell('J'.$i)->getValue();
						$nombre1	= $objWorksheet->getCell('K'.$i)->getValue();
						$nombre2	= $objWorksheet->getCell('L'.$i)->getValue();
						$tipo_sangr	= $objWorksheet->getCell('M'.$i)->getValue();
						$objWorksheet->getStyle('N'.$i)->getNumberFormat()->setFormatCode(PHPExcel_Style_NumberFormat::FORMAT_DATE_YYYYMMDD2);
						$fec_naci	= $objWorksheet->getCell('N'.$i)->getFormattedValue();
						$edad		= $objWorksheet->getCell('O'.$i)->getValue();
						$estrato	= $objWorksheet->getCell('P'.$i)->getValue();
						$direccion	= $objWorksheet->getCell('Q'.$i)->getValue();
						$localidad	= $objWorksheet->getCell('R'.$i)->getValue();
						$telefono	= $objWorksheet->getCell('S'.$i)->getValue();
						$movil		= $objWorksheet->getCell('T'.$i)->getValue();
						$ips		= $objWorksheet->getCell('U'.$i)->getValue();
						$email		= $objWorksheet->getCell('V'.$i)->getValue();
						
						$data	= array(
							'id_zona'			=> ($zona) 			? $zona 		: 0,
							'id_documento'		=> ($tipo_doc) 		? $tipo_doc 	: 99, 
							'id_sexo'			=> ($sexo) 			? $sexo 		: 0, 
							'id_country'		=> ($pais) 			? $pais 		: 45, 
							'nro_documento'		=> ($documento) 	? $documento 	: rand(5,10), 
							'lug_nacimiento'	=> ($ciud_naci) 	? $ciud_naci 	: 1128, 
							'lug_residencia'	=> ($ciud_resi) 	? $ciud_resi 	: 1128,
							'lug_expedicion'	=> ($ciud_exp) 		? $ciud_exp		: 1128,
							'apellido1'			=> ($apellido1) 	? $apellido1 	: '',
							'apellido2'			=> ($apellido2) 	? $apellido2 	: '', 
							'nombre1'			=> ($nombre1) 		? $nombre1 		: '',
							'nombre2'			=> ($nombre2) 		? $nombre2 		: '',
							'tipo_sangre'		=> ($tipo_sangr) 	? $tipo_sangr 	: 'O+', 
							'fecha_nacimiento'	=> ($fec_naci) 		? $fec_naci 	: date('Y-m-d'),
							'edad'				=> ($edad) 			? $edad 		: 0,
							'estrato'			=> ($estrato) 		? $estrato 		: 1, 
							'direccion'			=> ($direccion) 	? $direccion 	: '',
							'localidad'			=> ($localidad) 	? $localidad 	: '',
							'telefono'			=> ($telefono) 		? $telefono 	: '', 
							'movil'				=> ($movil) 		? $movil 		: '',
							'ips'				=> ($ips) 			? $ips 			: '', 
							'email'				=> ($email) 		? $email 		: 'email@email.com'
						);

						$this->db->where('nro_documento', $documento);
						$student	= $this->db->get($db.'.inscripciones', 1);
						$student	= $student->row();
						$studentId	= 0;
						if($student){
							$studentId	= $student->id;
							$this->db->where('id', $student->id);
							$this->db->limit(1);
							$this->db->update($db.'.inscripciones', $data);
						}else{
							$this->db->insert($db.'.inscripciones', $data);
							$studentId	= $this->getInsertId();
						}

						// Matricula
						$sede		= $objWorksheet->getCell('W'.$i)->getValue();
						$jornada	= $objWorksheet->getCell('X'.$i)->getValue();
						$grado		= $objWorksheet->getCell('Y'.$i)->getValue();
						$grupo		= $objWorksheet->getCell('Z'.$i)->getValue();
						$year		= $objWorksheet->getCell('AC'.$i)->getValue();

						if($sede > 0 && $jornada > 0  && $grado > 0  && strlen($grupo) > 0 && $year > 0 ){
							$ins_origen	= $objWorksheet->getCell('AA'.$i)->getValue() ? $objWorksheet->getCell('AA'.$i)->getValue() : 'No aplica';
							$dir_origen	= $objWorksheet->getCell('AB'.$i)->getValue() ? $objWorksheet->getCell('AB'.$i)->getValue() : 'No aplica';
							$objWorksheet->getStyle('AD'.$i)->getNumberFormat()->setFormatCode(PHPExcel_Style_NumberFormat::FORMAT_DATE_YYYYMMDD2);
							$fecha		= $objWorksheet->getCell('AD'.$i)->getFormattedValue();
							$query	= "INSERT IGNORE INTO ".$db.".student_enrollment (id_headquarters, id_study_day, id_student, id_grade, ".
							"id_state,id_group, inst_address, inst_origin, `date`, `year`) VALUES (".$sede.",".$jornada.",".$studentId.",".$grado.
							",2,'".$grupo."','".$dir_origen."','".$ins_origen."','".$fecha."',".$year.")";
							$this->db->query($query);
						}

					}
					
					if($this->trans_status()){
						$request = array(
							'success'       => TRUE
						);		
						/**
						* Respuesta en formato Json
						*/
						$this->trans_commit();
						$result = json_encode($request);
					}else{
						$this->trans_rollback();
					}
				} catch (\Throwable $th) {
					$this->trans_rollback();
					$result	= $this->error_success();
				}
			}else{
				$result	= $this->error_success();
			}
		}else{
			$result	= $this->error_success();
		}
		return $result;
	}

	public function get_download_excel_students() {
		$this->fileXls	= $this->directory_path.'assets/plantillas/plantilla matriculas ASAIE.xlsx';
		$date	= date('Y-m-d h-m-s');
		$dir	= SCHOOL_DIRECTORY.PATH_DELIM.$this->get_school_folder().PATH_DELIM.
		UP_FOLDER.PATH_DELIM.XLS_FILE_DIRECTORY.PATH_DELIM;
		$this->fileExport	= ($dir."Plantilla Inscripciones y matriculas ASAIE ".$date.".xlsx");
		$db	= $this->get_db_name();	
		$ie	= $this->db->get($db.'.establecimiento');
		$ie	= $ie->row();

		$head	= $this->db->get($db.'.sedes');

		if ($ie && $head->num_rows() > 0){
			$this->objXls	= $this->objXls->load_xls($this->fileXls);
			$this->objXls->setActiveSheetIndex(1);
			$objPorp	= $this->objXls->getProperties();
			$objPorp->setCreator("LOPEZSOFT S.A.S");
			$objPorp->setLastModifiedBy("LOPEZSOFT S.A.S");
			$objPorp->setTitle("Plantilla Inscripciones y matriculas");
			$objPorp->setSubject("Plantilla Inscripciones y matriculas");
			$objPorp->setDescription("Hoja de excel para realizar la importación de Inscripciones y matriculas.");
			$objPorp->setCategory("ASAIE ÉXODO - SISTEMA ACADÉMICO Y ADMINISTRATIVO");

			$this->objXls->getActiveSheet()->setCellValue('A1',$ie->NOMBRE_IE);

			$count	= 3;
			foreach($head->result_array() as $field){			
				$count ++;
				$this->objXls->getActiveSheet()->setCellValue('A'.$count,$field['ID']);
				$this->objXls->getActiveSheet()->setCellValue('B'.$count,$field['NOMBRE_SEDE']);
			}	
			//Guardamos el archivo en formato Excel 2007
			$objWriter = PHPExcel_IOFactory::createWriter($this->objXls,'Excel2007');
			$objWriter->save($this->fileExport);
			$request = array(
				'success'       => true,
				'pathFile'		=> utf8_encode($this->fileExport)
			);		
			/**
			* Respuesta en formato Json
			*/
			$result = json_encode($request);
		}else{
			$result	= $this->error_success();
		}
		return $result;
	}
	
	public function consolidado_sin_notas() {
		$this->fileXls	= $this->directory_path.'assets/plantillas/CONSOLIDADO ESTUDIANTES SIN NOTAS.xlsx';
		$date	= date('Y-m-d h-m-s');
		$dir	= SCHOOL_DIRECTORY.PATH_DELIM.$this->get_school_folder().PATH_DELIM.
		UP_FOLDER.PATH_DELIM.XLS_FILE_DIRECTORY.PATH_DELIM;
		$this->fileExport	= utf8_decode($dir."CONSOLIDADO ESTUDIANTES SIN NOTAS ".$date.".xlsx");
		$db	= $this->get_db_name();
		$m_SQL	= "CALL ".$db.".sp_select_estudiantes_sin_notas(".$this->get_year().")";		
		$m_SQL	= $this->db->query($m_SQL);
		mysqli_next_result($this->db->conn_id);
		if ($m_SQL){
			$this->objXls	= $this->objXls->load_xls($this->fileXls);
			$this->objXls->setActiveSheetIndex(0);
			$objPorp	= $this->objXls->getProperties();
			$objPorp->setCreator("LOPEZSOFT S.A.S");
			$objPorp->setLastModifiedBy("LOPEZSOFT S.A.S");
			$objPorp->setTitle("Consolidado de estudiantes sin notas");
			$objPorp->setSubject("Consolidado de estudiantes sin notas");
			$objPorp->setDescription("Hoja de excel con el consolidado los estudiantes sin 
			notas en cada periodo.");
			$objPorp->setCategory("ASAIE ÉXODO - SISTEMA ACADÉMICO Y ADMINISTRATIVO");
			$count	= 1;
			foreach($m_SQL->result_array()as $field){			
				$count ++;
				$this->objXls->getActiveSheet()->setCellValue('A'.$count,$field['estudiante']);
				$this->objXls->getActiveSheet()->setCellValue('B'.$count,$field['grado']);
				$this->objXls->getActiveSheet()->setCellValue('C'.$count,$field['id_group']);
				$this->objXls->getActiveSheet()->setCellValue('D'.$count,$field['jornada']);	
				$this->objXls->getActiveSheet()->setCellValue('E'.$count,$field['sede']);
				$this->objXls->getActiveSheet()->setCellValue('F'.$count,$field['asignatura']);
				$this->objXls->getActiveSheet()->setCellValue('G'.$count,$field['area']);
				$this->objXls->getActiveSheet()->setCellValue('H'.$count,$field['final']);	
				$this->objXls->getActiveSheet()->setCellValue('I'.$count,$field['docente']);
				$this->objXls->getActiveSheet()->setCellValue('J'.$count,$field['periodo']);	
			}	
			//Guardamos el archivo en formato Excel 2007
			$objWriter = PHPExcel_IOFactory::createWriter($this->objXls,'Excel2007');
			$objWriter->save($this->fileExport);
			$request = array(
				'success'       => TRUE,
				'fecha'			=> date('Y-m-d'),
				'user_id'		=> $this->get_user_id(),
				'id_scholl'		=> $this->get_id_school(),
				'year'			=> $this->get_year(),
				'user_type'		=> $this->session->userdata('user_type'),
				'pathFile'		=> utf8_encode($this->fileExport)
			);		
			/**
			* Respuesta en formato Json
			*/
			$result = json_encode($request);
		}else{
			$result	= $this->get_error();
		}
		return $result;
	}
	
	public function consolidado_matricula() {
		$this->fileXls	= $this->directory_path.'assets/plantillas/CONSOLIDADO MATRICULA.xlsx';
		$date	= date('Y-m-d h-m-s');
		$dir	= SCHOOL_DIRECTORY.PATH_DELIM.$this->get_school_folder().PATH_DELIM.
		UP_FOLDER.PATH_DELIM.XLS_FILE_DIRECTORY.PATH_DELIM;
		$this->fileExport	= ($dir."CONSOLIDADO MATRICULA ".$date.".xlsx");
		$db	= $this->get_db_name();	
		$m_SQL	= "CALL ".$db.".sp_select_consolidado_matricula(".$this->get_year().")";		
		$m_SQL	= $this->db->query($m_SQL);
		mysqli_next_result($this->db->conn_id);
		if ($m_SQL){
			$this->objXls	= $this->objXls->load_xls($this->fileXls);
			$this->objXls->setActiveSheetIndex(0);
			$objPorp	= $this->objXls->getProperties();
			$objPorp->setCreator("LOPEZSOFT S.A.S");
			$objPorp->setLastModifiedBy("LOPEZSOFT S.A.S");
			$objPorp->setTitle("Consolidado de matricula");
			$objPorp->setSubject("Consolidado de matricula");
			$objPorp->setDescription("Hoja de excel con el consolidado de la matricula completa del 
			establecimiento educativo.");
			$objPorp->setCategory("ASAIE ÉXODO - SISTEMA ACADÉMICO Y ADMINISTRATIVO");
			$count	= 1;
			foreach($m_SQL->result_array()as $field){			
				$count ++;
				$this->objXls->getActiveSheet()->setCellValue('A'.$count,$field['estado']);
				$this->objXls->getActiveSheet()->setCellValue('B'.$count,$field['apellido1']);
				$this->objXls->getActiveSheet()->setCellValue('C'.$count,$field['apellido2']);
				$this->objXls->getActiveSheet()->setCellValue('D'.$count,$field['nombre1']);	
				$this->objXls->getActiveSheet()->setCellValue('E'.$count,$field['nombre2']);
				$this->objXls->getActiveSheet()->setCellValue('F'.$count,$field['sexo']);
				$this->objXls->getActiveSheet()->setCellValue('G'.$count,$field['tipo_sangre']);
				$this->objXls->getActiveSheet()->setCellValue('H'.$count,$field['fecha_nacimiento']);	
				$this->objXls->getActiveSheet()->setCellValue('I'.$count,$field['edad']);
				$this->objXls->getActiveSheet()->setCellValue('J'.$count,$field['sisben']);
				$this->objXls->getActiveSheet()->setCellValue('K'.$count,$field['estrato']);
				$this->objXls->getActiveSheet()->setCellValue('L'.$count,$field['IPS']);	
				$this->objXls->getActiveSheet()->setCellValue('M'.$count,$field['direccion']);
				$this->objXls->getActiveSheet()->setCellValue('N'.$count,$field['zona']);
				$this->objXls->getActiveSheet()->setCellValue('O'.$count,$field['documento']);
				$this->objXls->getActiveSheet()->setCellValue('P'.$count,$field['tipo_documento']);	
				$this->objXls->getActiveSheet()->setCellValue('Q'.$count,$field['telefono']);
				$this->objXls->getActiveSheet()->setCellValue('R'.$count,$field['cod_grado']);
				$this->objXls->getActiveSheet()->setCellValue('S'.$count,$field['grado']);
				$this->objXls->getActiveSheet()->setCellValue('T'.$count,$field['id_group']);	
				$this->objXls->getActiveSheet()->setCellValue('U'.$count,$field['jornada']);
				$this->objXls->getActiveSheet()->setCellValue('V'.$count,$field['sede']);
				$this->objXls->getActiveSheet()->setCellValue('W'.$count,$field['year']);
				$this->objXls->getActiveSheet()->setCellValue('X'.$count,$field['pob_vict_conf']);	
				$this->objXls->getActiveSheet()->setCellValue('Y'.$count,$field['cod_flia_accion']);
				$this->objXls->getActiveSheet()->setCellValue('Z'.$count,$field['nro_sisben']);
			}	
			//Guardamos el archivo en formato Excel 2007
			$objWriter = PHPExcel_IOFactory::createWriter($this->objXls,'Excel2007');
			$objWriter->save($this->fileExport);
			$request = array(
				'success'       => TRUE,
				'fecha'			=> date('Y-m-d'),
				'user_id'		=> $this->get_user_id(),
				'id_scholl'		=> $this->get_id_school(),
				'year'			=> $this->get_year(),
				'user_type'		=> $this->session->userdata('user_type'),
				'pathFile'		=> utf8_encode($this->fileExport)
			);		
			/**
			* Respuesta en formato Json
			*/
			$result = json_encode($request);
		}else{
			$result	= $this->get_error();
		}
		return $result;
	}
	
	public function download_report_consolidado_as($per,$all,$c_gdo,$gpo,$jorn,$sede) {
		if ($per == "5"){
			return $this->get_request_ab();
			exit;
		}
		$dir	= $this->directory_path.SCHOOL_DIRECTORY.PATH_DELIM.$this->get_school_folder().PATH_DELIM.
		UP_FOLDER.PATH_DELIM.XLS_FILE_DIRECTORY;
		if (!is_dir($dir)){
			mkdir($dir, 0777, true);
		}
		$this->fileXls	= $this->directory_path.'assets/plantillas/CONSOLIDADO ASIGNATURAS.xlsx';
		$date	= date('Y-m-d h-m-s');
		$dir	= SCHOOL_DIRECTORY.PATH_DELIM.$this->get_school_folder().PATH_DELIM.
		UP_FOLDER.PATH_DELIM.XLS_FILE_DIRECTORY.PATH_DELIM;
		$this->fileExport	= $dir."CONSOLIDADO ASIGNATURAS CURSO ".$c_gdo."-".$gpo."-JORN ".$jorn."-SEDE ".$sede."-".$date.".xlsx";
		IF ($all == '1'){
			$z_per = '0';
		}else{
			$z_per = $per;			
		}
		$db	= $this->get_db_name();
		$year	= $this->get_year();	
		$xtype	= 1;
		
		$m_SQL	= "CALL ".$db.".sp_select_consolidado_asig(".$sede.",".$jorn.",'".$c_gdo."','".$gpo."',".$this->get_year().",'".$z_per."',".$xtype.")";		
		$m_SQL	= $this->db->query($m_SQL);
		mysqli_next_result($this->db->conn_id);
		$query_ar	=  "CALL ".$db.".`sp_select_matcurso`('".$c_gdo."','".$this->get_year()."')";
		$query_ar	= $this->db->query($query_ar);
		mysqli_next_result($this->db->conn_id);
		if ($m_SQL AND $query_ar){
			$this->M_jreport->set_report_params();
			$this->objXls	= $this->objXls->load_xls($this->fileXls);
			$this->objXls->setActiveSheetIndex(0);
			$objPorp	= $this->objXls->getProperties();
			$objPorp->setCreator("LOPEZSOFT S.A.S");
			$objPorp->setLastModifiedBy("LOPEZSOFT S.A.S");
			$objPorp->setTitle("Plantilla de consolidado por asignaturas");
			$objPorp->setSubject("Plantilla de consolidado");
			$objPorp->setDescription("Plantilla con el consolidado de las notas académicas de los estudiantes.");
			$objPorp->setCategory("ASAIE ÉXODO -  SISTEMA ACADÉMICO Y ADMINISTRATIVO");
			$valCol	= TRUE;
			$lisCol	='DEFGHIJKLMNOPQRSTUVWXYZ';
			$countCell	= 4;
			$oldMatric	= 0;
			$counTotal	= 6;
			$posCell	= 7;
			$reCountCell= 6;
			foreach($m_SQL->result_array()as $field){
				// Encabezado del informe
				if ($valCol){
					$this->objXls->getActiveSheet()->setCellValue('C1',$this->M_jreport->p_title);
					$this->objXls->getActiveSheet()->setCellValue('E3',$field['sede']);
					$this->objXls->getActiveSheet()->setCellValue('E4',$field['grado']);
					$this->objXls->getActiveSheet()->setCellValue('L4',$field['id_group']);
					$this->objXls->getActiveSheet()->setCellValue('N4',$field['jornada']);
					$this->objXls->getActiveSheet()->setCellValue('S4',$field['year']);
					$count = 0;
					for($i = 0; $i < 23; $i++){
						$count ++;
						$ar	= "ar".$count;
						$cellVal	= "";
						$celCol		= "";
						$cellValP	= "0.00%";	
						foreach($query_ar->result_array() as  $field_ar){
							if ($field_ar['id_asig'] == $field[$ar]) {
								$cellVal	= $field_ar['abrev'];
								$cellValP	=$field_ar['porciento']."%";
								break;
							}
						}
						$celCol	= substr($lisCol,$i,1)."5";	// Nombre de la columna				
						$this->objXls->getActiveSheet()->setCellValue($celCol,$cellVal);
						$celCol	= substr($lisCol,$i,1)."6";	// Porciento de la columna				
						$this->objXls->getActiveSheet()->setCellValue($celCol,$cellValP);
					}
					$valCol = FALSE;
				}			
				// Cuerpo del informe	
				$counTotal	++;
				$id_matric = $field['id_matric'];
				if ($oldMatric == 0){
					$oldMatric	= $id_matric;
					$count = 0;
					$this->objXls->getActiveSheet()->setCellValue('B'.$counTotal,$field['estudiante']);
					$this->objXls->getActiveSheet()->setCellValue('C'.$counTotal,"P-".$field['periodo']);
					$this->objXls->getActiveSheet()->setCellValue('AA'.$counTotal,$field['prom']);
					$this->objXls->getActiveSheet()->setCellValue('AB'.$counTotal,$field['t']);
					for($i = 0; $i < 20; $i++){
						$count ++;
						$ar	= "nar".$count;
						$cellVal	= $field[$ar];
						$celCol		= "";
						$celCol	= substr($lisCol,$i,1).$counTotal;	// Nombre de la columna				
						$this->objXls->getActiveSheet()->setCellValue($celCol,$cellVal);
					}
					//print_r($counTotal);
				}elseif ($id_matric <> $oldMatric) {
					$oldMatric	= $id_matric;
					$posCell	+= $reCountCell;	
					$counTotal	= $posCell;
					$count = 0;
					$this->objXls->getActiveSheet()->setCellValue('B'.$posCell,$field['estudiante']);
					$this->objXls->getActiveSheet()->setCellValue('C'.$counTotal,"P-".$field['periodo']);
					$this->objXls->getActiveSheet()->setCellValue('AA'.$counTotal,$field['prom']);
					$this->objXls->getActiveSheet()->setCellValue('AB'.$counTotal,$field['t']);
					for($i = 0; $i < 20; $i++){
						$count ++;
						$ar	= "nar".$count;
						$cellVal	= $field[$ar];
						$celCol		= "";
						$celCol	= substr($lisCol,$i,1).$counTotal;	// Nombre de la columna				
						$this->objXls->getActiveSheet()->setCellValue($celCol,$cellVal);
					}
				}else{
					$count = 0;
					$this->objXls->getActiveSheet()->setCellValue('C'.$counTotal,"P-".$field['periodo']);
					$this->objXls->getActiveSheet()->setCellValue('AA'.$counTotal,$field['prom']);
					$this->objXls->getActiveSheet()->setCellValue('AB'.$counTotal,$field['t']);
					for($i = 0; $i < 20; $i++){
						$count ++;
						$ar	= "nar".$count;
						$cellVal	= $field[$ar];
						$celCol		= "";
						$celCol	= substr($lisCol,$i,1).$counTotal;	// Nombre de la columna				
						$this->objXls->getActiveSheet()->setCellValue($celCol,$cellVal);
					}
				}				
			}
			//Guardamos el archivo en formato Excel 2007
			$objWriter = PHPExcel_IOFactory::createWriter($this->objXls,'Excel2007');
			$objWriter->save($this->fileExport);
			$request = array(
				'success'       => TRUE,
				'fecha'			=> date('Y-m-d'),
				'user_id'		=> $this->get_user_id(),
				'id_school'		=> $this->get_id_school(),
				'year'			=> $this->get_year(),
				'user_type'		=> $this->session->userdata('user_type'),
				'pathFile'		=> utf8_encode($this->fileExport)
			);		
			/**
			* Respuesta en formato Json
			*/
			$result = json_encode($request);
		}else{
			$result	= $this->get_error();
		}
		return $result;
	}
	
	public function download_report_consolidado_ar($per,$all,$c_gdo,$gpo,$jorn,$sede) {
		if ($per == "5"){
			return $this->get_request_ab();
			exit;
		}
		$dir	= $this->directory_path.SCHOOL_DIRECTORY.PATH_DELIM.$this->get_school_folder().PATH_DELIM.
		UP_FOLDER.PATH_DELIM.XLS_FILE_DIRECTORY;
		if (!is_dir($dir)){
			mkdir($dir, 0777, true);
		}
		if (!is_dir($dir)){
			mkdir($dir, 0777, true);
		}
		$this->fileXls	= $this->directory_path.'assets/plantillas/CONSOLIDADO AREAS.xlsx';
		$date	= date('Y-m-d h-m-s');
		$dir	= SCHOOL_DIRECTORY.PATH_DELIM.$this->get_school_folder().PATH_DELIM.
		UP_FOLDER.PATH_DELIM.XLS_FILE_DIRECTORY.PATH_DELIM;
		$this->fileExport	= $dir."CONSOLIDADO AREAS CURSO ".$c_gdo."-".$gpo."-JORN ".$jorn."-SEDE ".$sede."-".$date.".xlsx";
		IF ($all == '1'){
			$z_per = '0';
		}else{
			$z_per = $per;			
		}
				
		$xtype	= 2;
		$db	= $this->get_db_name();
		$m_SQL	= "CALL ".$db.".sp_select_consolidado_asig(".$sede.",".$jorn.",'".$c_gdo."','".$gpo."',".$this->get_year().",'".$z_per."',".$xtype.")";		
		$m_SQL	= $this->db->query($m_SQL);
		mysqli_next_result($this->db->conn_id);
		$query_ar	= "SELECT t.id AS cod_area, RTRIM(t.area) area, t.abrev FROM ".$db.".areas t WHERE t.estado = 1";
		$query_ar	= $this->db->query($query_ar);
		if ($m_SQL AND $query_ar){
			$this->M_jreport->set_report_params();
			$this->objXls	= $this->objXls->load_xls($this->fileXls);
			$this->objXls->setActiveSheetIndex(0);
			$objPorp	= $this->objXls->getProperties();
			$objPorp->setCreator("LOPEZSOFT S.A.S");
			$objPorp->setLastModifiedBy("LOPEZSOFT S.A.S");
			$objPorp->setTitle("Plantilla de consolidado por áreas");
			$objPorp->setSubject("Plantilla de consolidado");
			$objPorp->setDescription("Plantilla con el consolidado de las notas académicas de los estudiantes.");
			$objPorp->setCategory("ASAIE ÉXODO -  SISTEMA ACADÉMICO Y ADMINISTRATIVO");
			$valCol	= TRUE;
			$lisCol	='DEFGHIJKLMNOPQRSTUVW';
			$countCell	= 4;
			$oldMatric	= 0;
			$counTotal	= 5;
			$posCell	= 6;
			$reCountCell= 6;
			foreach($m_SQL->result_array()as $field){
				// Encabezado del informe
				if ($valCol){
					$this->objXls->getActiveSheet()->setCellValue('C1',$this->M_jreport->p_title);
					$this->objXls->getActiveSheet()->setCellValue('E3',$field['sede']);
					$this->objXls->getActiveSheet()->setCellValue('E4',$field['grado']);
					$this->objXls->getActiveSheet()->setCellValue('L4',$field['id_group']);
					$this->objXls->getActiveSheet()->setCellValue('N4',$field['jornada']);
					$this->objXls->getActiveSheet()->setCellValue('S4',$field['year']);
					$count = 0;
					for($i = 0; $i < 20; $i++){
						$count ++;
						$ar	= "ar".$count;
						$cellVal	= "";
						$celCol		= "";
						foreach($query_ar->result_array() as  $field_ar){
							if ($field_ar['cod_area'] == $field[$ar]) {
								$cellVal	= $field_ar['abrev'];
								break;
							}
						}
						$celCol	= substr($lisCol,$i,1)."5";	// Nombre de la columna				
						$this->objXls->getActiveSheet()->setCellValue($celCol,$cellVal);
					}
					$valCol = FALSE;
				}			
				// Cuerpo del informe	
				$counTotal	++;
				$id_matric = $field['id_matric'];
				if ($oldMatric == 0){
					$oldMatric	= $id_matric;
					$count = 0;
					$this->objXls->getActiveSheet()->setCellValue('B'.$counTotal,$field['estudiante']);
					$this->objXls->getActiveSheet()->setCellValue('C'.$counTotal,"P-".$field['periodo']);
					$this->objXls->getActiveSheet()->setCellValue('X'.$counTotal,$field['prom']);
					$this->objXls->getActiveSheet()->setCellValue('Y'.$counTotal,$field['t']);
					for($i = 0; $i < 20; $i++){
						$count ++;
						$ar	= "nar".$count;
						$cellVal	= $field[$ar];
						$celCol		= "";
						$celCol	= substr($lisCol,$i,1).$counTotal;	// Nombre de la columna				
						$this->objXls->getActiveSheet()->setCellValue($celCol,$cellVal);
					}
					//print_r($counTotal);
				}elseif ($id_matric <> $oldMatric) {
					$oldMatric	= $id_matric;
					$posCell	+= $reCountCell;	
					$counTotal	= $posCell;
					$count = 0;
					$this->objXls->getActiveSheet()->setCellValue('B'.$posCell,$field['estudiante']);
					$this->objXls->getActiveSheet()->setCellValue('C'.$counTotal,"P-".$field['periodo']);
					$this->objXls->getActiveSheet()->setCellValue('X'.$counTotal,$field['prom']);
					$this->objXls->getActiveSheet()->setCellValue('Y'.$counTotal,$field['t']);
					for($i = 0; $i < 20; $i++){
						$count ++;
						$ar	= "nar".$count;
						$cellVal	= $field[$ar];
						$celCol		= "";
						$celCol	= substr($lisCol,$i,1).$counTotal;	// Nombre de la columna				
						$this->objXls->getActiveSheet()->setCellValue($celCol,$cellVal);
					}
				}else{
					$count = 0;
					$this->objXls->getActiveSheet()->setCellValue('C'.$counTotal,"P-".$field['periodo']);
					$this->objXls->getActiveSheet()->setCellValue('X'.$counTotal,$field['prom']);
					$this->objXls->getActiveSheet()->setCellValue('Y'.$counTotal,$field['t']);
					for($i = 0; $i < 20; $i++){
						$count ++;
						$ar	= "nar".$count;
						$cellVal	= $field[$ar];
						$celCol		= "";
						$celCol	= substr($lisCol,$i,1).$counTotal;	// Nombre de la columna				
						$this->objXls->getActiveSheet()->setCellValue($celCol,$cellVal);
					}
				}				
			}
			//Guardamos el archivo en formato Excel 2007
			$objWriter = PHPExcel_IOFactory::createWriter($this->objXls,'Excel2007');
			$objWriter->save($this->fileExport);
			$request = array(
				'success'       => TRUE,
				'fecha'			=> date('Y-m-d'),
				'user_id'		=> $this->get_user_id(),
				'id_school'		=> $this->get_id_school(),
				'year'			=> $this->get_year(),
				'user_type'		=> $this->session->userdata('user_type'),
				'pathFile'		=> utf8_encode($this->fileExport)
			);		
			/**
			* Respuesta en formato Json
			*/
			$result = json_encode($request);
		}else{
			$result	= $this->get_error();
		}
		return $result;
	}
	
	public function upload_plantilla($asig,$grado,$id_group,$per,$jorn,$sede,$curso,$file){
		$this->folders_teachers($this->get_teacher_id());
		$control	= $this->control_date($per,$grado);
		$palntila	= json_decode($this->upload_file($file,$this->teaching_excel_files_directory_path));
		$year		= $this->get_year();
		$id			= $this->get_id_school();
		$db			= $this->get_db_name();
		if ($palntila->success){
			$doc			= $palntila->foto;
			$this->fileXls 	= $this->directory_path.$doc;
			$this->objXls	= $this->objXls->load_xls($this->fileXls);
			$this->objXls->setActiveSheetIndex(0);
			//iterando el contenido de las celdas
			$objWorksheet = $this->objXls->getActiveSheet();
			$count = 0 ;
			$id_inst	= $this->objXls->getActiveSheet()->getCell('C1')->getValue();	
			$id_asig	= $this->objXls->getActiveSheet()->getCell('C3')->getValue();
			$cod_grado	= $this->objXls->getActiveSheet()->getCell('C4')->getValue();
			$periodo	= $this->objXls->getActiveSheet()->getCell('G5')->getValue();
			$id_docente	= $this->objXls->getActiveSheet()->getCell('C6')->getValue();
			$year		= $this->objXls->getActiveSheet()->getCell('G8')->getValue();
			$id_jorn	= $this->objXls->getActiveSheet()->getCell('C8')->getValue();
			$id_sede	= $this->objXls->getActiveSheet()->getCell('C9')->getValue();
			$id_group	= $this->objXls->getActiveSheet()->getCell('O4')->getValue();
			$id_curso	= $this->objXls->getActiveSheet()->getCell('G10')->getValue();
			$query_comp		= "SELECT tc.id_pk, tc.id, tc.competencia, tc.porcentaje, tc.calificable, tc.`year`
							FROM ".$db.".competencias AS tc
							LEFT JOIN ".$db.".grados_agrupados AS t1 ON tc.id_grado_agrupado = t1.id
							LEFT JOIN ".$db.".aux_grados_agrupados AS t2 ON t2.id_grado_agrupado = t1.id
							WHERE tc.`year` = ".$year." AND tc.calificable = 1  AND t2.id_grado =".$grado;
			$query_comp		= $this->db->query($query_comp);
			if (($id_curso == $curso) AND ($periodo == $per) AND $query_comp){
				$table	= $db.".".$this->tabla_notas($grado);
				$count	= 3;
				$this->trans_start();
				$this->objXls->setActiveSheetIndex(1);
				// Importando las notas 
				for($i = 0; $i < 61 ; $i++){
					$count ++;
					$id_matric = $this->objXls->getActiveSheet()->getCell('B'.$count)->getValue();
					$id_matric ? $id_matric : 0;
					if ($id_matric > 0){
						$sql	= 'SELECT id FROM '.$table." WHERE id_curso = ? AND id_matric = ? AND periodo = ? AND year = ? LIMIT 1";
						$param	= array(
							$curso,
							$id_matric,
							$periodo,
							$year
						);
						$sql	= $this->db->query($sql,$param);
						if ($sql){
							if ($sql->num_rows() > 0){
								$cel_count	= 8;
								$sqlSet		= '';
								foreach ($query_comp->result_array() as $field)
							 	{
							 		$query	= "SELECT t.id_competencia, t.numero_column, 
							 		CONCAT('n',t.numero_column) name_column, 
									t.tipo, tc.competencia,
									ROW_NUMBER() OVER (PARTITION BY tipo ORDER BY t.id_competencia, t.tipo, t
									.numero_column) AS row_num
									FROM ".$db.".columnas_notas_competencias t
									LEFT JOIN ".$db.".competencias AS tc ON t.id_competencia = tc.id_pk
									LEFT JOIN ".$db.".grados_agrupados AS t1 ON tc.id_grado_agrupado = t1.id
									LEFT JOIN ".$db.".aux_grados_agrupados AS t2 ON t2.id_grado_agrupado = t1.id
									WHERE tc.`year` = ".$year." AND tc.id_pk =".$field['id_pk']." AND t2.id_grado = ".$grado."
									ORDER BY t.id_competencia, t.tipo, t.numero_column;";
									$query	= $this->db->query($query);
									if($query->num_rows() > 0){
										foreach($query->result_array() as $value){	
											$cel_count ++;		
							 				switch($value['tipo']){
											 	case 'PROM': 
											 		$beforeCol	= $this->get_row_sheet($cel_count);
											 		$val	= $this->objXls->getActiveSheet()->getCell($beforeCol.$count)->
											 						getOldCalculatedValue();
											 		break;
											 	case 'PORC':	
											 		$beforeCol	= $this->get_row_sheet($cel_count);
											 		$val	= $this->objXls->getActiveSheet()->getCell($beforeCol.$count)->
											 						getOldCalculatedValue();			 		
											 		break;
											 	default:
											 		$beforeCol	= $this->get_row_sheet($cel_count);
											 		$val	= $this->objXls->getActiveSheet()
											 				->getCell($beforeCol.$count)->getValue();
											 		break;
											}
											$val	= $val ? $val : 0;
											$sqlSet	= $sqlSet.$value['name_column']."='".$val."',";
										}
										
									}
								}	
								$final	=  $this->objXls->getActiveSheet()->getCell('AN'.$count)->
											 						getOldCalculatedValue();
								$final		= $final ? $final : 0;
								$id_escala	= $this->get_desempeños_id($final,$grado);
								$sqlSet		= $sqlSet."final='".$final."',id_escala='".$id_escala."'";
								$sqlUp	= 'UPDATE '.$table.' SET '.$sqlSet." WHERE id = ? ";
								$this->db->query($sqlUp,array($sql->row('id')));
							}else{
								$cel_count	= 8;
								$sqlSet		= '';
								$sqlCol		= '';
								foreach ($query_comp->result_array() as $field)
							 	{
							 		$query	= "SELECT t.id_competencia, t.numero_column, 
							 		CONCAT('n',t.numero_column) name_column, 
									t.tipo, tc.competencia,
									ROW_NUMBER() OVER (PARTITION BY tipo ORDER BY t.id_competencia, t.tipo, t
									.numero_column) AS row_num
									FROM ".$db.".columnas_notas_competencias t
									LEFT JOIN ".$db.".competencias AS tc ON t.id_competencia = tc.id_pk
									LEFT JOIN ".$db.".grados_agrupados AS t1 ON tc.id_grado_agrupado = t1.id
									LEFT JOIN ".$db.".aux_grados_agrupados AS t2 ON t2.id_grado_agrupado = t1.id
									WHERE tc.`year` = ".$year." AND tc.id_pk =".$field['id_pk']." AND t2.id_grado = ".$grado."
									ORDER BY t.id_competencia, t.tipo, t.numero_column;";
									$query	= $this->db->query($query);
									if($query->num_rows() > 0){
										foreach($query->result_array() as $value){	
											$cel_count ++;		
											$sqlCol	= $sqlCol.$value['name_column'].",";
							 				switch($value['tipo']){
											 	case 'PROM': 
											 		$beforeCol	= $this->get_row_sheet($cel_count);
											 		$val	= $this->objXls->getActiveSheet()->getCell($beforeCol.$count)->
											 						getOldCalculatedValue();
											 		break;
											 	case 'PORC':	
											 		$beforeCol	= $this->get_row_sheet($cel_count);
											 		$val	= $this->objXls->getActiveSheet()->getCell($beforeCol.$count)->
											 						getOldCalculatedValue();	 		
											 		break;
											 	default:
											 		$beforeCol	= $this->get_row_sheet($cel_count);
											 		$val	= $this->objXls->getActiveSheet()
											 				->getCell($beforeCol.$count)->getValue();
											 		break;
											}
											$val	= $val ? $val : 0;
											$sqlSet	= $sqlSet."'".$val."',";
										}
										
									}
								}		
								$final	=  $this->objXls->getActiveSheet()->getCell('AN'.$count)->
											 						getOldCalculatedValue();
								$final		= $final ? $final : 0;
								$id_escala	= $this->get_desempeños_id($final,$grado);
								$sqlCol		= $sqlCol."final,id_matric,year,id_curso,periodo,id_escala";	
								$sqlSet		= $sqlSet."'".$final."','".$id_matric."','".$year."','".$curso."','".$periodo."','".$id_escala."'";
								$sqlUp		= 'INSERT IGNORE INTO '.$table.'('.$sqlCol.' VALUES ('.$sqlSet.')';
								$this->db->query($sqlUp);
							}
						}else{
							$result = $this->get_error();
						}	
					}
				}			
				$this->trans_complete();	
				if ($this->trans_status()) {
					$estado = 1;
				}else{
					$result	= $this->error_success();
					return $result;
				}						
			}else{
				$estado = 0;
			}
			$request = array(
				'success'       => TRUE,
				'year'			=> $this->get_year(),
				'estado'		=> $estado
			);		
			/**
			* Respuesta en formato Json
			*/
			$result = json_encode($request);
		}else{
			$result	= $this->error_success();
		}
		return $result;
	}
	
	public function delete_file_exl($path){
		$this->folders_teachers($this->doc_docente);
		return $this->delete_file($this->directory_path.$path);
	}
	
	public function exportar_notas_asignatura($asig,$grado,$id_group,$per,$jorn,$sede,$curso){
		$db			= $this->get_db_name();		
		/**
		 * Trae los datos del curso a exportar
		 */
		$query_cur 	= $this->db->query("CALL ".$db.".sp_carga_curso ('".$curso."',".$this->get_year().")");
		$year		= $this->get_year();
		$id			= $this->get_id_school();
		if ($query_cur){
			$this->next_result();
		}
		/** Nombre de la tabla de notas */
		$table	= $db.".".$this->tabla_notas($grado);
		/** Columnas configuradas en la plantilla de notas */
		$filds	= $this->get_columns_notas($grado);
		/** Nota minima y máxima para controlar los cambios en la plantilla excel */
		$query_min	= "SELECT min(desde) desde, max(hasta) hasta
				FROM ".$db.".desempeños AS td
				LEFT JOIN ".$db.".grados_agrupados AS t1 ON td.id_grado_agrupado = t1.id
				LEFT JOIN ".$db.".aux_grados_agrupados AS t2 ON t2.id_grado_agrupado = t1.id 
				WHERE td.`year` = ".$year." AND td.hasta > 0 AND t2.id_grado =".$grado;
		$query_min	= $this->db->query($query_min); 
		/** Escala de desempeños */
		$query_escala	= "SELECT td.id_pk,td.id, td.id_escala, td.desde, td.hasta, es.nombre_escala, es.abrev
				FROM ".$db.".desempeños AS td
				LEFT JOIN ".$db.".escala_nacional AS es ON td.id_escala = es.id
				LEFT JOIN ".$db.".grados_agrupados AS t1 ON td.id_grado_agrupado = t1.id
				LEFT JOIN ".$db.".aux_grados_agrupados AS t2 ON t2.id_grado_agrupado = t1.id 
				WHERE td.`year` = ".$year." AND t2.id_grado = ".$grado." ORDER BY td.id;";
		$query_escala	= $this->db->query($query_escala);
		/** Escala de competencias */
		$query_comp		= "SELECT tc.id_pk, tc.id, tc.competencia, tc.porcentaje, tc.calificable, tc.`year`
				FROM ".$db.".competencias AS tc
				LEFT JOIN ".$db.".grados_agrupados AS t1 ON tc.id_grado_agrupado = t1.id
				LEFT JOIN ".$db.".aux_grados_agrupados AS t2 ON t2.id_grado_agrupado = t1.id
				WHERE tc.`year` = ".$year." AND tc.calificable = 1  AND t2.id_grado =".$grado;
		$query_comp		= $this->db->query($query_comp);
		/** Listado de los estudiantes */
		$query_est		= "SELECT tn.id_matric,".$filds.",
				CONCAT(RTRIM(te.apellido1),' ',RTRIM(te.apellido2),' ',RTRIM(te.nombre1),' ',RTRIM(te.nombre2)) 
				estudiante FROM ".$table." AS tn
				LEFT JOIN ".$db.".cursos AS tc ON (tn.id_curso = tc.id AND tn.year = tc.year)
				LEFT JOIN ".$db.".student_enrollment AS tm ON (tn.id_matric = tm.id AND tm.id_grade = tc.id_grado AND tm.year = tc.year 
				AND tm.id_study_day = tc.id_jorn AND tm.id_group = tc.grupo AND tm.id_headquarters = tc.id_sede)
				LEFT JOIN ".$db.".inscripciones AS te ON tm.id_student = te.id 
				WHERE tc.id=".$curso." AND tn.periodo ='".$per."' AND tm.id_state = 2  ORDER BY estudiante";
		$query_est		= $this->db->query($query_est);

		if ($query_cur AND $query_escala AND $query_comp AND $query_est AND $query_min){
			$this->folders_teachers($this->get_parent());
			$this->objXls	= $this->objXls->load_xls($this->fileXls);
			$this->objXls->setActiveSheetIndex(0);
			$objPorp	= $this->objXls->getProperties();
			$objPorp->setCreator("LOPEZSOFT S.A.S");
			$objPorp->setLastModifiedBy("LOPEZSOFT S.A.S");
			$objPorp->setTitle("Plantilla de calificaciones");
			$objPorp->setSubject("Plantilla de calificaciones sin internet");
			$objPorp->setDescription("Plantilla para el registro de notas de los docentes.");
			$objPorp->setCategory("ASAIE ÉXODO - SISTEMA ACADÉMICO Y ADMINISTRATIVO");
			
			//Encabezado  
			$this->fileExport = $this->teaching_excel_files_directory_path.'/'.
			strtoupper(utf8_decode($this->normaliza($query_cur->row('asignatura').' '.
			$query_cur->row('grado').
			' '.$query_cur->row('id_group').' periodo'.$per." ".$query_cur->row('jornada').
			" ".$query_cur->row('docente')." ".$query_cur->row('sede')))).".xlsx";
			$this->objXls->getActiveSheet()->setCellValue('D1',$query_cur->row('NOMBRE_IE'));
			$this->objXls->getActiveSheet()->setCellValue('C1',$id);
			$this->objXls->getActiveSheet()->setCellValue('G2',$query_cur->row('area'));
			$this->objXls->getActiveSheet()->setCellValue('G3',$query_cur->row('asignatura'));
			$this->objXls->getActiveSheet()->setCellValue('C3',$query_cur->row('id_asig'));
			$this->objXls->getActiveSheet()->setCellValue('G4',$query_cur->row('grado'));
			$this->objXls->getActiveSheet()->setCellValue('C4',$query_cur->row('cod_grado'));
			$this->objXls->getActiveSheet()->setCellValue('G5',$per);
			$this->objXls->getActiveSheet()->setCellValue('G6',$query_cur->row('docente'));
			$this->objXls->getActiveSheet()->setCellValue('C6',$query_cur->row('id_docente'));
			$this->objXls->getActiveSheet()->setCellValue('G8',$this->get_year());			
			$this->objXls->getActiveSheet()->setCellValue('K8',$query_cur->row('jornada'));
			$this->objXls->getActiveSheet()->setCellValue('C8',$query_cur->row('id_jorn'));
			$this->objXls->getActiveSheet()->setCellValue('G9',$query_cur->row('sede'));
			$this->objXls->getActiveSheet()->setCellValue('G10',$curso);
			$this->objXls->getActiveSheet()->setCellValue('C9',$query_cur->row('id_sede'));
			$this->objXls->getActiveSheet()->setCellValue('O4',$query_cur->row('id_group'));
			// Activa la pagina 2 donde se digitaran las notas
			$this->objXls->setActiveSheetIndex(1);
			//Escala
			$count	= 2;
			foreach ($query_escala->result_array() as $field)
		 	{
		 		$count	++;
				$this->objXls->getActiveSheet()->setCellValue('AQ'.$count,$field['nombre_escala']);
				$this->objXls->getActiveSheet()->setCellValue('AT'.$count,$field['desde']);
				$this->objXls->getActiveSheet()->setCellValue('AU'.$count,$field['hasta']);
				$this->objXls->getActiveSheet()->setCellValue('AV'.$count,$field['abrev']);	
				$this->objXls->getActiveSheet()->setCellValue('AP'.$count,$field['id']);			
			}		
			//Data Validation
			$objValidation	= $this->objXls->getActiveSheet()->getCell('J4')
							->getDataValidation();
			$objValidation->setType( PHPExcel_Cell_DataValidation::TYPE_DECIMAL );
			$objValidation->setErrorStyle( PHPExcel_Cell_DataValidation::STYLE_STOP );
			$objValidation->setAllowBlank(true);
			$objValidation->setShowInputMessage(true);
			$objValidation->setShowErrorMessage(true);
			$objValidation->setErrorTitle('FUERA DE RANGO');
			$objValidation->setError('El valor ingresado está fuera del rango de la escala INSTITUCIONAL!');
			$desde	= $query_min->row('desde');
			$hasta	= $query_min->row('hasta');
			$objValidation->setFormula1($desde);
			$objValidation->setFormula2($hasta);
			// Carga listado de estudiantes			
			$count	= 3;
			foreach ($query_est->result_array() as $fields)
		 	{
		 		$count	++;
				$this->objXls->getActiveSheet()->setCellValue('B'.$count,$fields['id_matric']);
				$this->objXls->getActiveSheet()->setCellValue('D'.$count,$fields['estudiante']);
				$cel_count	= 8;
				foreach ($query_comp->result_array() as $field)
			 	{
			 		$query	= "SELECT t.id_competencia, t.numero_column, CONCAT('n',t.numero_column) name_column, 
								t.tipo, tc.competencia,
								ROW_NUMBER() OVER (PARTITION BY tipo ORDER BY t.id_competencia, t.tipo, t.numero_column) AS row_num
								FROM ".$db.".columnas_notas_competencias t
								LEFT JOIN ".$db.".competencias AS tc ON t.id_competencia = tc.id_pk
								LEFT JOIN ".$db.".grados_agrupados AS t1 ON tc.id_grado_agrupado = t1.id
								LEFT JOIN ".$db.".aux_grados_agrupados AS t2 ON t2.id_grado_agrupado = t1.id
								WHERE tc.`year` = ".$year." AND tc.id_pk =".$field['id_pk']." AND t2.id_grado = ".$grado."
								ORDER BY t.id_competencia, t.tipo, t.numero_column;";
					$query	= $this->db->query($query);
					if($query->num_rows() > 0){
						foreach($query->result_array() as $value){	
							$cel_count ++;		
			 				switch($value['tipo']){
							 	case 'PROM': 
							 		break;
							 	case 'PORC':							 		
							 		break;
							 	default:
							 		$beforeCol	= $this->get_row_sheet($cel_count);
							 		$val	= $fields[$value['name_column']] ? $fields[$value['name_column']] : 0;
							 		if ($val > 0){
										//$val	= number_format($val,2,',', '.');
								 		$cel	= $beforeCol.$count;
								 		$this->objXls->getActiveSheet()->setCellValue($cel,$val);	
									}
							 		break;
							}
						}
						
					}
				}			
			}					
			$count	= 8;
			$sumFinal	= '';
			foreach ($query_comp->result_array() as $field)
		 	{
		 		$query	= "SELECT t.id_competencia, t.numero_column, CONCAT('#',t.numero_column) name_column, 
							t.tipo, tc.competencia,
							ROW_NUMBER() OVER (PARTITION BY tipo ORDER BY t.id_competencia, t.tipo, t.numero_column) AS row_num
							FROM ".$db.".columnas_notas_competencias t
							LEFT JOIN ".$db.".competencias AS tc ON t.id_competencia = tc.id_pk
							LEFT JOIN ".$db.".grados_agrupados AS t1 ON tc.id_grado_agrupado = t1.id
							LEFT JOIN ".$db.".aux_grados_agrupados AS t2 ON t2.id_grado_agrupado = t1.id
							WHERE tc.`year` = ".$year." AND tc.id_pk =".$field['id_pk']." AND t2.id_grado = ".$grado."
							ORDER BY t.id_competencia, t.tipo, t.numero_column;";
							
				$query	= $this->db->query($query);
				$initCol= $this->get_row_sheet($count+1);
				if($query->num_rows() > 0){
					foreach($query->result_array() as $value){
						$count	++;
						$finalCol	= $this->get_row_sheet($count);
		 				$beforeCol	= $this->get_row_sheet($count);
		 				$this->objXls->getActiveSheet()->getColumnDimension($beforeCol)->setVisible(TRUE); 				
		 				switch($value['tipo']){
						 	case 'PROM': 
						 		$merge	= $initCol.'2:'.$finalCol.'2';
						 		$this->objXls->getActiveSheet()->setCellValue($beforeCol.'3','NP');
						 		$this->objXls->getActiveSheet()->mergeCells($merge);
						 		$this->cellColor($initCol.'2','D8D8D8');
						 		$this->cellColor($beforeCol.'3','D8D8D8');
						 		$this->objXls->getActiveSheet()->setCellValue($initCol.'2',$value['competencia']);
						 		$this->objXls->getActiveSheet()->getComment($beforeCol.'3')->setHeight(20);
								$this->objXls->getActiveSheet()->getComment($beforeCol.'3')->setWidth(170);
								$this->objXls->getActiveSheet()->getComment($beforeCol.'3')->getText()
																->createTextRun('NOTA PROMEDIO');
								$this->cellLocked($beforeCol.'4:'.$beforeCol.'64');
								$cel_count	= 3;
									for($i = 0; $i < 61 ; $i++){
										$cel_count ++;
										$prom	= '=AVERAGE('.$initCol.$cel_count.':'.
										$this->get_row_sheet($count-1).$cel_count.')';
										$this->objXls->getActiveSheet()->setCellValue($beforeCol.$cel_count,$prom);
										$this->cellColor($beforeCol.$cel_count,'D8D8D8');
									}
									break;
						 	case 'PORC': 
						 		$this->objXls->getActiveSheet()->setCellValue($beforeCol.'3','%');
						 		$val	= $query_cur->row('proc'.$field['id']) > 0 ? $query_cur->row('proc'.$field['id']) 
						 		: $field['porcentaje'];
						 		$val	= number_format($val,0,',', '.');
						 		$this->objXls->getActiveSheet()->setCellValue($beforeCol.'2',$val.'%');
						 		$this->cellColor($beforeCol.'2','F7BE81');
						 		$this->cellColor($beforeCol.'3','F7BE81');
						 		$this->objXls->getActiveSheet()->getComment($beforeCol.'3')->setHeight(20);
								$this->objXls->getActiveSheet()->getComment($beforeCol.'3')->setWidth(170);
						 		$this->objXls->getActiveSheet()->getComment($beforeCol.'3')->getText()
											->createTextRun('NOTA PORCENTUAL');
								$this->cellLocked($beforeCol.'4:'.$beforeCol.'64');
								$cel_count	= 3;
									for($i = 0; $i < 61 ; $i++){
										$cel_count ++;
										$this->cellColor($beforeCol.$cel_count,'F7BE81');
										$prom	= '=('.$this->get_row_sheet($count-1).$cel_count.'*$'.$beforeCol.'$2'.')';
										$this->objXls->getActiveSheet()->setCellValue($beforeCol.$cel_count,$prom);
										$val = $this->objXls->getActiveSheet()->getCell('AN'.$cel_count).'+'.$beforeCol.$cel_count;
										$this->objXls->getActiveSheet()->setCellValue('AN'.$cel_count,$val);
									}
						 		break;
						 	default:
						 		$this->objXls->getActiveSheet()->setCellValue($beforeCol.'3',$value['row_num']);
						 		$this->cellColor($beforeCol.'3','F2F2F2');
						 			$cel_count	= 3;
									for($i = 0; $i < 61 ; $i++){
										$cel_count ++;
										if($value['row_num'] == 1){
										  $val	= $this->objXls->getActiveSheet()->getCell($beforeCol.$cel_count)->getValue();
										  $val	= $val ? $val : 0;
										  $this->objXls->getActiveSheet()->setCellValue($beforeCol.$cel_count,$val);	
										  
										}
										$this->objXls->getActiveSheet()->setDataValidation($beforeCol.$count,$objValidation);
										
									}
						 		break;
						}
					}
					
				}
			}
						
			// Comentarios en columnas
			$this->objXls->getActiveSheet()->getComment('G3')->getText()->createTextRun('Justificadas');
			$this->objXls->getActiveSheet()->getComment('G3')->setHeight(20);
			$this->objXls->getActiveSheet()->getComment('H3')->getText()->createTextRun('Injustificadas');
			$this->objXls->getActiveSheet()->getComment('H3')->setHeight(20);
			$this->objXls->getActiveSheet()->getComment('I3')->getText()
											->createTextRun('Retraso, llegada tarde a clase');		
			$this->objXls->getActiveSheet()->getComment('I3')->setHeight(20);
			$this->objXls->getActiveSheet()->getComment('I3')->setWidth(220);	
			$this->objXls->getActiveSheet()->getComment('AN2')->getText()
											->createTextRun('NOTA FINAL');
			$this->objXls->getActiveSheet()->getComment('AN2')->setHeight(20);
			$this->objXls->getActiveSheet()->getComment('AN2')->setWidth(120);
			
			$this->objXls->getActiveSheet()->getComment('AQ2')->getText()
											->createTextRun('ESCALA NACIONAL');
			$this->objXls->getActiveSheet()->getComment('AQ2')->setHeight(20);
			$this->objXls->getActiveSheet()->getComment('AQ2')->setWidth(150);
			
			//Protección de la hoja de calculo
			$this->objXls->setActiveSheetIndex(0);
			$this->objXls->getActiveSheet()->getProtection()->setPassword('1');
			$this->objXls->getActiveSheet()->getProtection()->setSheet(TRUE);
			$this->objXls->getActiveSheet()->getProtection()->setDeleteColumns(TRUE);
			$this->objXls->getActiveSheet()->getProtection()->setDeleteRows(TRUE);
			$this->objXls->getActiveSheet()->getProtection()->setInsertColumns(TRUE);
			$this->objXls->getActiveSheet()->getProtection()->setInsertRows(TRUE);
			$this->objXls->getActiveSheet()->getProtection()->setInsertHyperlinks(TRUE);
			$this->objXls->getActiveSheet()->getProtection()->setFormatCells(FALSE);
			$this->objXls->getActiveSheet()->getProtection()->setFormatColumns(FALSE);
			$this->objXls->getActiveSheet()->getProtection()->setFormatRows(FALSE);
			$this->objXls->getActiveSheet()->getProtection()->setObjects(TRUE);
			$this->objXls->getActiveSheet()->getProtection()->setSort(TRUE);
			$this->objXls->getActiveSheet()->getProtection()->setScenarios(TRUE);
			$this->objXls->getActiveSheet()->getProtection()->setSelectLockedCells(FALSE);
			$this->objXls->getActiveSheet()->getProtection()->setSelectUnlockedCells(FALSE);
			$this->objXls->setActiveSheetIndex(1);
			$this->objXls->getActiveSheet()->getProtection()->setPassword('1');
			$this->objXls->getActiveSheet()->getProtection()->setSheet(TRUE);
			$this->objXls->getActiveSheet()->getProtection()->setDeleteColumns(TRUE);
			$this->objXls->getActiveSheet()->getProtection()->setDeleteRows(TRUE);
			$this->objXls->getActiveSheet()->getProtection()->setInsertColumns(TRUE);
			$this->objXls->getActiveSheet()->getProtection()->setInsertRows(TRUE);
			$this->objXls->getActiveSheet()->getProtection()->setInsertHyperlinks(TRUE);
			$this->objXls->getActiveSheet()->getProtection()->setFormatCells(FALSE);
			$this->objXls->getActiveSheet()->getProtection()->setFormatColumns(FALSE);
			$this->objXls->getActiveSheet()->getProtection()->setFormatRows(FALSE);
			$this->objXls->getActiveSheet()->getProtection()->setObjects(TRUE);
			$this->objXls->getActiveSheet()->getProtection()->setSort(TRUE);
			$this->objXls->getActiveSheet()->getProtection()->setScenarios(TRUE);
			$this->objXls->getActiveSheet()->getProtection()->setSelectLockedCells(FALSE);
			$this->objXls->getActiveSheet()->getProtection()->setSelectUnlockedCells(FALSE);
			
			//Guardamos el archivo en formato Excel 2007
			$objWriter = PHPExcel_IOFactory::createWriter($this->objXls,'Excel2007');
			$objWriter->setIncludeCharts(true);
			$objWriter->save($this->fileExport);
			$request = array(
				'success'       => TRUE,
				'pathFile'		=> utf8_encode($this->fileExport)
			);		
			/**
			* Respuesta en formato Json
			*/
			$result = json_encode($request);
		}else{
			$result = $this->get_error();
		}
		$query_cur->free_result();
		return $result;
	}
	
	function cellLocked($cell){
		$this->objXls->getActiveSheet()
			->getStyle($cell)
			->getProtection()
			->setLocked(
			    PHPExcel_Style_Protection::PROTECTION_PROTECTED
			);
	}
	
	function cellColor($cells,$color){	
	    $this->objXls->getActiveSheet()->getStyle($cells)->getFill()->applyFromArray(array(
	        'type' => PHPExcel_Style_Fill::FILL_SOLID,
	        'startcolor' => array(
	             'rgb' => $color
	        )
	    ));
	}

	
	function get_row_sheet($index){
		$rows = array(
			'A',
			'B',
			'C',
			'D',
			'E',
			'F',
			'G',
			'H',
			'I',
			'J',
			'K',
			'L',
			'M',
			'N',
			'O',
			'P',
			'Q',
			'R',
			'S',
			'T',
			'U',
			'V',
			'W',
			'X',
			'Y',
			'Z',
			'AA',
			'AB',
			'AC',
			'AD',
			'AE',
			'AF',
			'AG',
			'AH',
			'AI',
			'AJ',
			'AK',
			'AL',
			'AM',
			'AN',
			'AO',
			'AP',
			'AQ',
			'AR',
			'AS',
			'AT',
			'AU',
			'AV',
			'AW',
			'AX',
			'AY',
			'AZ'
		);
		
		return $rows[$index];
	}
		
}
