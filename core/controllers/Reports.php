<?php
defined('BASEPATH') OR exit('No direct script access allowed');
class Reports extends SME_Controller {
		
	public function __construct() {
		parent::__construct();
		$this->load->model('M_docentes_report');
		$this->load->model('M_report_general');
		$this->load->model('M_promocion_report');
		$this->load->model('M_consolidados');
	}

	public function carnets_esc()
	{
		$format	= $this->input->post('pFormat');
		$type	= $this->input->post('pdbType');
		$id		= $this->input->post('pdbId');
		$ckAll	= $this->input->post('ckAll');
		$ckRes	= $this->input->post('ckRes');
		echo $this->M_report_general->carnets($format, $type, $ckAll, $ckRes, $id);
	}
	
	public function report_historial_academico(){
		$f 		= $this->input->get_post('pFormat');
		$Grado 	= $this->input->post('pdbGrado');	
		echo $this->M_promocion_report->historial_academico($f,$Grado);
	}
	
	public function get_pre_matricula_nuevos(){
		$format	= $this->input->post('pFormat');
		echo $this->M_report_general->get_pre_matricula_nuevos($format);
	}
	
	public function generar_consolidado() {		
		$per	= $this->input->post('pdbPeriodo');
		$type	= $this->input->post('pTypeReport');
		$c_gdo	= $this->input->post('pdbCodGrado');
		$gpo	= $this->input->post('pdbGrupo');
		$jorn	= $this->input->post('pdbIdJorn');
		$perAll	= $this->input->post('allPer');
		$groupA = $this->input->post('allGroup');	
		$sede	= $this->input->post('pdbIdSede');
		echo $this->M_consolidados->generar_consolidados($per,$type,$c_gdo,$gpo,$jorn, $perAll, $groupA,$sede);
	}
	
		
	public function report_ficha_observador(){
		$format	= $this->input->post('pFormat');
		$Grado 	= $this->input->post('pdbGrado');
		$Grupo	= $this->input->post('pdbGrupo');	
		$Jorn 	= $this->input->post('pdbJorn');
		$Matric	= $this->input->post('pdbMatric');		
		$Sede	= $this->input->post('pdbSede');
		$Estudian= $this->input->post('pdbEstudian');
		echo $this->
		M_report_general->ficha_observador($format,$Grado,$Grupo,$Jorn,$Matric,$Sede,$Estudian);
	}
	
	public function report_sabanas_finales(){
		$f 		= $this->input->get_post('pFormat');
		$Grado 	= $this->input->post('pdbGrado');	
		$Sede	= $this->input->post('pdbSede');
		$Jorn	= $this->input->post('pdbJorn');
		$grupo	= $this->input->post('pdbGrupo');
		echo $this->M_promocion_report->sabanas_finales($f,$Grado,$Sede,$Jorn,$grupo);
	}
		
	public function report_acta_grado(){
		$f 		= $this->input->get_post('pFormat');
		$Grado 	= $this->input->post('pdbGrado');	
		$Sede	= $this->input->post('pdbSede');
		$Jorn	= $this->input->post('pdbJorn');
		$grupo	= $this->input->post('pdbGrupo');
		$matric	= $this->input->post_get('pdbMatric');
		$h		= $this->input->post_get('pdbHoja');
		$mod	= $this->input->post_get('pdbModelo');
		echo $this->M_promocion_report->acta_grado($f,$Grado,$Sede,$Jorn,$grupo,$matric);
	}
	
	public function report_promocion_anticipada(){
		$f 		= $this->input->get_post('pFormat');
		$pdbId	= $this->input->post('pdbId');
		$grade	= $this->input->post('pdbGrade');
		echo $this->M_promocion_report->promocion_anticipada($f,$pdbId, $grade);
	}
	
	public function report_actas_promocion_est(){
		$f 		= $this->input->get_post('pFormat');
		$type 	= $this->input->post('pdbType');	
		echo $this->M_promocion_report->actas_promocion_esta($f,$type);
	}
	
	public function report_actas_promocion(){
		$f 		= $this->input->get_post('pFormat');
		$Grado 	= $this->input->post('pdbGrado');	
		$Sede	= $this->input->post('pdbSede');
		$Jorn	= $this->input->post('pdbJorn');
		$grupo	= $this->input->post('pdbGrupo');
		echo $this->M_promocion_report->actas_promocion($f,$Grado,$Sede,$Jorn,$grupo);
	}
	
	public function recuperaciones_finales(){
		$f 		= $this->input->get_post('pFormat');
		$doc 	= $this->input->post_get('pdbDocente');	
		echo $this->M_promocion_report->recuperaciones_finales($f,$doc);
	}
	
	public function report_familiares(){
		$f 		= $this->input->get_post('pFormat');
		$Grado 	= $this->input->post('pdbGrado');	
		$Sede	= $this->input->post('pdbSede');
		$Jorn	= $this->input->post('pdbJorn');
		$tp		= $this->input->post('pdbType');
		$all	= $this->input->post('pdbAll');
		echo $this->M_report_general->report_familiares($f,$Grado,$Sede,$Jorn,$tp,$all);
	}
	
	public function report_certificado_final() {
		$f 		= $this->input->get_post('pFormat');
		$Grado 	= $this->input->post('pdbGrado');
		$Grupo	= $this->input->post('pdbGrupo');	
		$Sede	= $this->input->post('pdbSede');
		$Jorn	= $this->input->post('pdbJorn');
		$one	= $this->input->post_get('pdbMatric');
		$h		= $this->input->post_get('pdbHoja');
		$tp		= $this->input->post_get('pdbType');
		$per	= $this->input->post_get('pdbPer');
		$mod	= $this->input->post_get('pdbModelo');
		$dist	= $this->input->post_get('pdbDistrib');
		echo $this->M_promocion_report->report_certificado_final($Grado,$Grupo,$Sede,$Jorn,$one,$f,$h,$per,$tp,$mod,$dist);
	}
	
	public function report_libro_final() {
		$f 		= $this->input->get_post('pFormat');
		$Grado 	= $this->input->post('pdbGrado');
		$Grupo	= $this->input->post('pdbGrupo');	
		$Sede	= $this->input->post('pdbSede');
		$Jorn	= $this->input->post('pdbJorn');
		$one	= $this->input->post_get('pdbMatric');
		$h		= $this->input->post_get('pdbHoja');
		$per	= $this->input->post_get('pdbPer');
		echo $this->M_promocion_report->report_libro_final($Grado,$Grupo,$Sede,$Jorn,$one,$f,$h,$per);
	}
	
	public function get_generate_libro(){
		$Grado 	= $this->input->post('pdbGrado');
		$Grupo	= $this->input->post('pdbGrupo');	
		$Sede	= $this->input->post('pdbSede');
		$Jorn	= $this->input->post('pdbJorn');
		$all	= $this->input->post_get('pdbAll');
		$per	= $this->input->post_get('pdbPer');
		echo $this->M_promocion_report->get_generate_libros($Grado,$Grupo,$Sede,$Jorn,$all,$per);
	}
	
	
	public function report_fechas_nac(){
		$f 		= $this->input->get_post('pFormat');
		$Grado 	= $this->input->post('pdbGrado');
		$Grupo	= $this->input->post('pdbGrupo');	
		$Sede	= $this->input->post('pdbSede');
		$Jorn	= $this->input->post('pdbJorn');
		$tp		= $this->input->post_get('pdbType');
		echo $this->M_report_general->report_fechas_nac($f,$Grado,$Grupo,$Sede,$Jorn,$tp);
	}
	
	public function report_listas_docentes(){
		$f 		= $this->input->get_post('pFormat');
		echo $this->M_report_general->report_listas_docentes($f);
	}
	
	public function report_listas_asignacion_acad(){
		$f 		= $this->input->get_post('pFormat');
		$doc 	= $this->input->post('pdbDocente');		
		$sede	= $this->input->post_get('pdbSede');
		$grado	= $this->input->post_get('pdbGrado');
		echo $this->M_report_general->report_listas_asignacion_acad($f,$doc,$sede,$grado);
	}
	
	public function report_listas_con_carga(){
		$f 		= $this->input->get_post('pFormat');
		$doc 	= $this->input->post('pdbDocente');		
		$tp		= $this->input->post_get('pdbType');
		$per	= $this->input->post_get('pdbPeriodo');
		echo $this->M_report_general->report_listas_con_carga($f,$doc,$tp,$per);
	}
	
	public function report_listas_sin_carga(){
		$f 		= $this->input->get_post('pFormat');
		$Grado 	= $this->input->post('pdbGrado');
		$Grupo	= $this->input->post('pdbGrupo');	
		$Sede	= $this->input->post('pdbSede');
		$Jorn	= $this->input->post('pdbJorn');
		$tp		= $this->input->post_get('pdbType');
		$per	= $this->input->post_get('pdbPeriodo');
		echo $this->M_report_general->report_listas_sin_carga($f,$Grado,$Grupo,$Sede,$Jorn,$tp,$per);
	}
	
	public function report_estadistica_edades(){
		$f 		= $this->input->get_post('pFormat');
		echo $this->M_report_general->report_estadistica_edades($f);
	}
	
	public function report_matriculados(){
		$f 		= $this->input->get_post('pFormat');
		$Grado 	= $this->input->post('pdbGrado');
		$Grupo	= $this->input->post('pdbGrupo');	
		$Sede	= $this->input->post('pdbSede');
		$Jorn	= $this->input->post('pdbJorn');
		$tp		= $this->input->post_get('pdbType');
		echo $this->M_report_general->report_matriculados($f,$Grado,$Grupo,$Sede,$Jorn,$tp);
	}
	
	public function report_desplazados(){
		$f = $this->input->get_post('pFormat');
		echo $this->M_report_general->report_desplazados($f);
	}
	
	public function report_estudiantes_jorn(){
		$f = $this->input->get_post('pFormat');
		echo $this->M_report_general->report_estudiantes_jorn($f);
	}
	
	public function report_cuadro_honor(){
		$format		= $this->input->post('pFormat');
		$pdbGrado 	= $this->input->post('pdbGrado');
		$pdbGrupo	= $this->input->post('pdbGrupo');	
		$pdbPhoto 	= $this->input->post('pdbPhoto');
		$pdbCkGrado	= $this->input->post('pdbCkGrado');		
		$pdbSede	= $this->input->post('pdbSede');
		$pdbCkSede	= $this->input->post('pdbCkSede');
		$pdbCkNivel	= $this->input->post('pdbCkNivel');
		$pdbPeriodo	= $this->input->post('pdbPeriodo');
		$lm			= $this->input->post_get('pdbLimit');
		$niv		= $this->input->post_get('pdbNiv');
		$ck			= $this->input->post_get('pdbCk');
		echo $this->
		M_report_general->
		report_cuadro_honor($format,$pdbGrado,$pdbGrupo,$pdbPhoto,$pdbCkGrado,$pdbSede,$pdbCkSede,
								$pdbCkNivel,$pdbPeriodo,$lm,$niv,$ck);
	}
	
	public function report_certificados_per(){
		$format		= $this->input->post('pFormat');
		$pdbGrado 	= $this->input->post('pdbGrado');
		$pdbGrupo	= $this->input->post('pdbGrupo');	
		$pdbJorn 	= $this->input->post('pdbJorn');
		$pdbMatric	= $this->input->post('pdbMatric');		
		$pdbSede	= $this->input->post('pdbSede');
		$pdbType	= $this->input->post('pdbType');
		$pdbEstudian= $this->input->post('pdbEstudian');
		$pdbPeriodo	= $this->input->post('pdbPeriodo');
		echo $this->
		M_report_general->
		report_certificados_per($format,$pdbGrado,$pdbGrupo,$pdbJorn,$pdbMatric,$pdbSede,$pdbType,
								$pdbEstudian,$pdbPeriodo);
	}
	
	public function report_constancias(){
		$format		= $this->input->post('pFormat');
		$pdbGrado 	= $this->input->post('pdbGrado');
		$pdbGrupo	= $this->input->post('pdbGrupo');	
		$pdbJorn 	= $this->input->post('pdbJorn');
		$pdbMatric	= $this->input->post('pdbMatric');		
		$pdbSede	= $this->input->post('pdbSede');
		$pdbType	= $this->input->post('pdbType');
		$pdbEstudian= $this->input->post('pdbEstudian');
		echo $this->
		M_report_general->
		report_constancias($format,$pdbGrado,$pdbGrupo,$pdbJorn,$pdbMatric,$pdbSede,$pdbType,$pdbEstudian);
	}
	
	public function report_nota_reportada(){
		$format		= $this->input->post('pFormat');
		$pdbDocente = $this->input->post('pdbDocente');
		$pdbPeriodo	= $this->input->post('pdbPeriodo');		
		$grado		= $this->input->post('pdbGrado');	
		echo $this->M_report_general->report_nota_reportada($format,$pdbDocente,$pdbPeriodo,$grado);
	}
	
	public function report_dir_grupos(){
		$format	= $this->input->post('pFormat');		
		echo $this->M_report_general->report_dir_grupos($format);	
	}
	
	public function report_ficha_matricula(){
		$id	    = $this->input->post('pdbId');
		$year	= $this->input->post('pdbYear');
		$format	= $this->input->post('pFormat');
		$type	= $this->input->post('pdbType');
		$Grado 	= $this->input->post('pdbGrado');
		$Grupo	= $this->input->post('pdbGrupo');	
		$Jorn 	= $this->input->post('pdbJorn');
		$Sede	= $this->input->post('pdbSede');
		
		echo $this->M_report_general->report_ficha_matricula($id,$format,$type,$Grado,$Grupo,$Sede,$Jorn,$year);
	}
	
	public function report_consolidado() {
		
		$per	= $this->input->post('pdbPeriodo');
		$hoj	= $this->input->post('pHojaReport');
		$type	= $this->input->post('pTypeReport');
		$all	= $this->input->post('pdbAllPer');
		$c_gdo	= $this->input->post('pdbCodGrado');
		$gpo	= $this->input->post('pdbGrupo');
		$jorn	= $this->input->post('pdbIdJorn');
		$sede	= $this->input->post('pdbIdSede');
		$format	= $this->input->post('pFormat');
		
		echo $this->M_report_general->report_consolidado($per,$hoj,$type,$all,$c_gdo,$gpo,$jorn,$sede,$format);
		
	}	
	
	/**
	* Funcion para genrerar el reporte de las recuperaciones periodicas
	* 
	* @return
	*/
	
	public function nivelaciones_per() {
		$format 	= $this->input->post_get('pFormat');				
		$grado		= $this->input->post_get('pdbGrado');		
		$periodo	= $this->input->post_get('pdbPeriodo');
		$doc		= $this->input->post_get('pdbType');
		$niv		= $this->input->post_get('pdbNivel');
		$report		= $this->input->post_get('pdbReport');
		$request	= $this->M_docentes_report->recuperaciones_periodicas($format,$grado,$periodo,$doc,$niv,$report);
		
		echo $request;
	}
	
	/**
	* Funcion para generar el informe del observdor
	* 
	* @return
	*/
	public function report_parcelador() {				
		$format 	= $_POST['pFormat'];				
		$id			= $_POST['pId'];						
		$request	= $this->M_docentes_report->report_parcelador($_POST['pdbPeriodo'],$format,$id);		
		echo $request;
	}
	
	
	/**
	* Funcion para generar los boletines periodicos
	* 
	* @return
	*/
	public function report_boletin() {
		$c_grado	= $this->input->post_get('pdbCodGrado')	;
		$id_sede	=$this->input->post_get('pdbIdSede')	;
		$periodo	= $this->input->post_get('pdbPeriodo');
		$grupo		= $this->input->post_get('pdbGrupo');
		$cod_jorn	= $this->input->post_get('pdbIdJorn');
		$matric		= $this->input->post_get('pdbMatric');
		//Extension de Salida
		$format 		= $this->input->post_get('pFormat');		
		/*
			Var
			$report : Reporte a Procesar : Este nombre es del reporte creado en JasReport
			$report_export : Nombre dado al informe de salida
		*/
		$hojaReport	= $this->input->post_get('pHojaReport');
		$typeReport	= $this->input->post_get('pTypeReport');							
		echo $this->M_docentes_report->report_boletin($c_grado,$id_sede,$periodo,$grupo,$cod_jorn,$hojaReport,$typeReport,$format,$matric);
	}
		
	/**
	* Funcion para generar el reporte de las recuperaciones periodicas
	* 
	* @return
	*/
	
	public function report_recuperaciones() {
		//Reporte a Procesar : Este nombre es del reporte creado en JasReport
		$report			=	$_POST['pReportName'];
		
		// Nombre dado al informe de salida
		$report_export	= $_POST['pReportExp'].'periodo'.$_POST['pdbPeriodo'];
				
		//Extension de Salida
		$format 		= $_POST['pFormat'];
				
		// Sentencia SQL para el parametro
		
		$this->db_limit();
		
		$c_grado	= $_POST['pdbCodGrado']	;
		$cod_asig	= $_POST['pdbCodAsig']	;
		$periodo	= $_POST['pdbPeriodo']	;
		
		$table = $this->M_sql->tabla_notas($c_grado);
			
		
		$querya ="tn.id_inst, tn.id_docente, tn.cod_grado, tn.id_asig, tn.cod_est, tn.cod_jorn, 
				tn.id_sede, tn.grupo, tn.periodo, tn.año, tn.nota_perdida, tn.nota_habilitacion, tn.final, tn.fecha";
			
		$query	= "SELECT CONCAT(RTRIM(ti.apellido1),' ',RTRIM(ti.apellido2),' ',RTRIM(ti.nombre1),' ',RTRIM(ti.nombre2)) AS nombres,".$querya.
				" FROM ".$table." AS tn, inscripciones AS ti";
				
		$where	= "tn.cod_est=ti.cod_est AND ti.id_inst= '".$this->get_id_school()."' AND tn.año= '".$this->get_year()."' AND 
				tn.id_inst= '".$this->get_id_school()."' AND tn.cod_grado= '".$c_grado."' AND tn.id_asig='".$cod_asig."' AND  
				periodo= '".$periodo."' AND id_docente= '".$this->id_docente."' AND tn.nota_perdida>0  
				ORDER BY cod_grado, grupo, id_asig, cod_jorn, nombres";
		
		$query = $query.' WHERE '.$where;
				
		$request	= $this->get_report_export($report,$report_export,$format,$query);
		
		echo $request;
	}	
		
	
	/**
	* Funcion que lee el directorio donde estan guardados los sub directorios de los archivos guradados
	* y muestra la lista de los archivos.
	* 
	* @return
	*/
	
	public function read_directory(){
			  	
		$directory_home 	= $this->path_report.'folder'.$this->id_docente.$this->get_id_school()."/" ;
		$path_download		= base_url().'reports/folder'.$this->id_docente.$this->get_id_school()."/";
		$list_dir	= NULL;
		$reccount	= 0;
		if (is_dir($directory_home)) {
			$directory = scandir($directory_home);
			foreach($directory as $key => $value){
				if ($value <> "." AND $value <> "..") {
					$fiel	= scandir($directory_home.$value);
					foreach($fiel as $ckey => $cvalue){
						if ($cvalue <> "." AND $cvalue <> "..") {
							if (!empty($cvalue)){
								$list_dir [] = array(
									'name' 			=> $cvalue, 
									'format' 		=> $value, 
									'path_download' => $path_download.$value."/".$cvalue,
									'path_delete'	=> $directory_home.$value."/".$cvalue,
									'fecha'			=> date("m d Y H:i:s",filectime($directory_home.$value."/".$cvalue))
								);
								$reccount	 = ++$reccount;	
							}								
						}
					}
				}				
			}
					
			$request = array(
				'success'       =>TRUE,
				'records'	=> $list_dir,
				'reccount' 		=> $reccount	
			);
			
			
		}else{
			$request = array(
				'success'       =>FALSE,
				'directory'		=> $this->path_report	
			);
			
		}
		
		echo json_encode($request);
	}
	
	/**
	* Funcion que elimina los archivos del servidor
	* 
	* @return
	*/
	public function delete_file() {
		$list = json_decode($this->input->get_post('records'));
		$path_delete =$list->path_delete;
		echo $this->M_docentes_report->delete_file($path_delete);
	}
}

/* End of file C_report.php */
/* Location: ./application/controllers/C_report.php */
