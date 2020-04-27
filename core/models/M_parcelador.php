<?php 
defined('BASEPATH') OR exit('No direct script access allowed');
class M_parcelador extends SME_Model {
 	public function __construct() {
		parent::__construct();
	}
	
	public function get_importar_logros_ind ($cod_grado,$id_asig,$type,$id_sede) {
		
		if(isset($cod_grado) AND isset($id_asig) AND isset($cod_grado) AND isset($id_sede)){
			if($type == 3){
				$query	= "SELECT tpar.id_docente, tpar.periodo, tp.*, tc.competencia, td.desempeño  FROM
							parcelador AS tpar 
							LEFT JOIN parcelador_cli AS tp ON tp.id_parcelador = tpar.id 
						 	LEFT JOIN competencias AS tc ON tp.id_competencia=tc.id  
						 	LEFT JOIN desempeños AS td ON tp.id_desempeño=td.id 
							WHERE tpar.id_docente=".$this->id_docente." AND tp.tipo > 2  
							AND tc.año=".$this->get_year()." AND tpar.id_inst=".$this->get_id_school().
							" AND tc.id_inst=".$this->get_id_school()." AND td.año=".$this->get_year().
							" AND td.id_inst=".$this->get_id_school()." AND tpar.cod_grado='".$cod_grado.
							"' AND tpar.id_asig=".$id_asig." AND tpar.id_sede=".$id_sede;
			}else{
				$query	= "SELECT tpar.id_docente, tpar.periodo, tp.*, tc.competencia, td.desempeño  FROM
							parcelador AS tpar 
							LEFT JOIN parcelador_cli AS tp ON tp.id_parcelador = tpar.id 
						 	LEFT JOIN competencias AS tc ON tp.id_competencia=tc.id  
						 	LEFT JOIN desempeños AS td ON tp.id_desempeño=td.id 
							WHERE tpar.id_docente=".$this->id_docente." AND tp.tipo =".$type."   
							AND tc.año=".$this->get_year()." AND tpar.id_inst=".$this->get_id_school().
							" AND tc.id_inst=".$this->get_id_school()." AND td.año=".$this->get_year().
							" AND td.id_inst=".$this->get_id_school()." AND tpar.cod_grado='".$cod_grado.
							"' AND tpar.id_asig=".$id_asig." AND tpar.id_sede=".$id_sede;
			}			
			$request	= $this->get_query($this->limit_min,$this->limit_max,$query);
			
		}else{
			$request	= $this->get_error();
		}
		
		return $request;
	}
	
	public function get_select_plan () {
		
		$param = $this->get_id_school().",".$this->id_docente.",".$this->get_year() ;
		
		$request = $this->get_query_call('sp_select_plan_semanal_clases',$param);
		
		return $request;
	}
	
	public function insert_plan ($fields_list) {
		if (isset($fields_list))
		{
						
			$data = json_decode($fields_list);
			
			$narray = array (
				"id_inst" 		=> $this->get_id_school(),
				'id_docente' 	=> $this->id_docente,
				'año'			=> $this->get_year()
			);
			
			$request = $this->insert_primary('plan_semanal_clases',$data,$narray,TRUE);
						
			if ($request) {
				
				$query = "SELECT tp.*, CONCAT(rtrim(td.apellido1),' ',rtrim(td.apellido2),' ',
				rtrim(td.nombre1),' ',rtrim(td.nombre2)) AS docente,
				tg.grado, tas.asignatura FROM plan_semanal_clases AS tp 
				left join docentes AS td on tp.id_docente=td.id_docente 
				left join grados as tg on tp.cod_grado=tg.cod_grado 
				left join asignaturas as tas on tp.id_asig=tas.id WHERE 
				tp.id_inst=".$this->get_id_school()." AND tp.id_docente=".$this->id_docente." AND 
				tp.año=".$this->get_year()." and tas.año=".$this->get_year().
				" and tas.id_inst=".$this->get_id_school()." AND tp.id=".$request;	
							
				$request = $this->get_query(0,1,$query);
			}
			
		}else{
			$request = $this->get_error();
		}	
		
		return $request;
	}
	
	public function get_update_plan ($records) {
		
		if (isset($records)) 
		{
			$fields_list = json_decode($records);
			
			$id	="id= '".$fields_list->id."'";	
						
			$request	= $this->update_data('plan_semanal_clases',$fields_list,$id);	
			
			if($request){
				$query =  "SELECT tp.*, CONCAT(rtrim(td.apellido1),' ',rtrim(td.apellido2),' ',
				rtrim(td.nombre1),' ',rtrim(td.nombre2)) AS docente,
				tg.grado, tas.asignatura FROM plan_semanal_clases AS tp 
				left join docentes AS td on tp.id_docente=td.id_docente 
				left join grados as tg on tp.cod_grado=tg.cod_grado 
				left join asignaturas as tas on tp.id_asig=tas.id WHERE 
				tp.id_inst=".$this->get_id_school()." AND tp.id_docente=".$this->id_docente." AND 
				tp.año=".$this->get_year()." and tas.año=".$this->get_year().
				" and tas.id_inst=".$this->get_id_school()." AND tp.id=".$fields_list->id;	
							
				$request = $this->get_query(0,1,$query);
			}
					
		}else{
			$request	= $this->get_error();
		}
		
		return $request;
	}
	
	public function get_update_parcelador_cont ($records) {
		if (isset($records)) 
		{
			$fields_list = json_decode($records);
			
			$id	="id= '".$fields_list->id."'";	
						
			$request	= $this->update_data('parcelador_con_tem',$fields_list,$id);	
			
			if($request){
				$query = "SELECT tc.*, ti.descripcion AS descripcion_item FROM parcelador_con_tem AS tc 
						LEFT JOIN parcelador_items_con_tem AS ti ON 
						tc.tipo=ti.id WHERE tc.id=".$fields_list->id;	
							
				$request = $this->get_query(0,1,$query);
			}
					
		}else{
			$request	= $this->get_error();
		}
		
		return $request;
	}
	
	public function insert_parcelador_cont ($fields_list,$id) {
		if (isset($fields_list))
		{
						
			$data = json_decode($fields_list);
			
			$narray = array (
				"id_parcelador" 	=> $id
			);
			
			$request = $this->insert_primary('parcelador_con_tem',$data,$narray,TRUE);
						
			if ($request) {
				
				$query = "SELECT tc.*, ti.descripcion AS descripcion_item FROM parcelador_con_tem AS tc 
						LEFT JOIN parcelador_items_con_tem AS ti ON 
						tc.tipo=ti.id WHERE tc.id=".$request;	
							
				$request = $this->get_query(0,1,$query);
			}
			
		}else{
			$request = $this->get_error();
		}	
		
		return $request;
	}
	
	public function get_select_items_con_tem () {
		$request = "SELECT * FROM  parcelador_items_con_tem";
		return  $this->get_query($this->limit_min,$this->limit_max,$request);
	}
	
	public function get_select_parcelador_cont ($type) {
		if (isset($type)){
			$request = "SELECT tc.*, ti.descripcion AS descripcion_item FROM parcelador_con_tem AS tc 
						LEFT JOIN parcelador_items_con_tem AS ti ON 
						tc.tipo=ti.id WHERE tc.id_parcelador=".$type." ORDER BY tipo";
			
			$request = $this->get_query($this->limit_min,$this->limit_max,$request);
		}else{
			$request	= $this->get_error();
		}
		
		return $request;
	}
	
	public function get_select_unidades($type){
		if(isset($type)){
			$query = "SELECT * FROM parcelador_unidades WHERE id_parcelador=".$type;
			
			$request = $this->get_query($this->limit_min,$this->limit_max,$query);
		}else{
			$request = $this->get_error();
		}
		
		return $request;
	}
	
	public function insert_unidades ($fields_list,$id) {
		if (isset($fields_list))
		{
						
			$data = json_decode($fields_list);
			
			$narray = array (
				"id_parcelador" 	=> $id
			);
			
			$request = $this->insert_primary('parcelador_unidades',$data,$narray,TRUE);
						
		}else{
			$request = $this->get_error();
		}	
		
		return $request;
	}
	
	public function get_update_unidades ($records) {
		if (isset($records)) 
		{
			$fields_list = json_decode($records);
			
			$id	="id= '".$fields_list->id."'";	
						
			$request	= $this->update_data('parcelador_unidades',$fields_list,$id);			
					
		}else{
			$request	= $this->get_error();
		}
		
		return $request;
	}
		
	public function get_select_parcelador() {
				
		$id_docente		= $this->id_docente;	
		$id_inst 		= $this->get_id_school();
		$año			= $this->get_year();
		
		$param = $id_inst.",".$id_docente.",".$año;
		
		return $this->get_call('sp_select_parcelador',$param);
	}
	
	/**
	* 
	* @param INT $grado
	* @param INT $id
	* 
	* @return
	*/
	public function get_select_parcelador_cli($grado,$id) {
		$year	= $this->get_year();
		$inst	= $this->get_id_school();
		$query 	= "SELECT tp.*, tc.competencia, td.nombre_escala, t.nombre_proceso
		FROM parcelador_cli AS tp 
	 	LEFT JOIN competencias AS tc ON tp.id_competencia=tc.id  
	 	LEFT JOIN grados_agrupados AS t1 ON tc.id_grado_agrupado = t1.id
	 	LEFT JOIN aux_grados_agrupados AS t2 ON t2.id_grado_agrupado = t1.id
	 	LEFT JOIN escala_nacional AS td ON tp.id_escala =td.id 
	 	LEFT JOIN tipo_procesos_educativos AS t ON tp.tipo = t.id
		WHERE tp.id_parcelador=".$id." AND tc.año=".$year."
		AND tc.id_inst=".$inst." AND td.id_inst=".$inst." AND t2.id_grado =".$grado."
		ORDER BY tp.tipo, tp.id_competencia, tp.id_escala;";
		$request	= $this->get_query($this->limit_min,$this->limit_max,$query,FALSE);
		return $request;
	}
	
	public function insert_parcelador_cli($fields_list,$id){				
		$data = json_decode($fields_list);		
		$narray = array (
			"id_parcelador" 	=> $id
		);		
		$request = $this->insert_primary('parcelador_cli',$data,$narray,TRUE);
		return $request;
	}
	
	public function insert_parcelador($fields_list) {		
		if (isset($fields_list))
		{
			$data = json_decode($fields_list);			
			$narray = array (
				"id_docente" 	=> $this->id_docente,
				"id_inst"		=> $this->get_id_school(),
				"año"			=> $this->get_year()
			);
						
			$request = $this->insert_primary('parcelador',$data,$narray,TRUE);			
		}else{
			$request = $this->get_error();
		}	
		
		return $request;
	}
		
	public function get_select_matcursos($grado){	
		$query="SELECT tm.id_grado, UPPER(tg.grado) AS grado, tm.id_asig , 
		TRIM(ta.asignatura) as asignatura,tm.año 
		FROM matcurso as tm, grados as tg, asignaturas as ta ";
		$where = "tm.id_grado=tg.id AND tm.id_asig=ta.id_pk AND ta.año= ? 
		AND tm.año= ?  AND tm.id_inst= ? AND ta.id_inst= ? AND tm.id_grado = ? 
		ORDER BY asignatura";		
		$id_inst 		= $this->get_id_school();
		$año			= $this->get_year();		
		$param = array(
			$año,$año,
			$id_inst,
			$id_inst,
			$grado
		);		
		$request = $this->get_query_param($this->limit_min,$this->limit_max,$query,$where,$param);	
		return $request;
	}
}


