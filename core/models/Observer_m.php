<?php 
defined('BASEPATH') OR exit('No direct script access allowed');
class Observer_m extends SME_Model {
	function __construct() {
		parent::__construct();
	}
	
	function getStudents(){
		$param	= array($this->get_year());
		return $this->getExecute('sp_select_students_with_observer ( ? )', $param);
	}
	public function get_itemsmodelo3($id){
		$param	= array(
			$id,
			$this->get_parent(),
			$this->get_year()
		);
		return $this->getExecute('sp_criterios_obs_m3 (?, ?, ?)', $param);
	}
	
	public function get_observador_tipo(){
		$query	= "SELECT * FROM obs_modelos_observador ";
		$where	= "id_inst= ? AND estado= ?";
		$param	= array(
			$this->get_id_school(),
			1
		);
		
		$result	= $this->get_query_param($this->limit_min,$this->limit_max,$query,$where,$param);
	
		return $result;
	}
		
	public function get_observador($id_matric,$estado) {		
		$db		= $this->get_db_name();
		$tipo	= 3;		
		switch($tipo){
			case 1:
				$query 	= "SELECT tob.*, tm.id_grade, tm.id_group, tm.id_headquarters, tm.id_study_day, rtrim(tg.grado) AS grado, 
							rtrim(tj.jornada) AS jornada FROM obs_observador_mod_1 AS tob  
							LEFT JOIN student_enrollment AS tm ON tob.id_matric = tm.id 
							LEFT JOIN grados AS tg ON tm.id_grade=tg.cod_grado 
							LEFT JOIN jornadas AS tj ON tm.id_study_day=tj.cod_jorn ";
				break;
			case 2:
				$query 	= "SELECT tob.*, tm.id_grade, tm.id_group, tm.id_headquarters, tm.id_study_day, rtrim(tg.grado) AS grado, 
							rtrim(tj.jornada) AS jornada FROM obs_observador_mod2 AS tob  
							LEFT JOIN student_enrollment AS tm ON tob.id_matric = tm.id 
							LEFT JOIN grados AS tg ON tm.id_grade=tg.cod_grado 
							LEFT JOIN jornadas AS tj ON tm.id_study_day=tj.cod_jorn ";
				break;
			case 3:
				$query 	= "SELECT tob.*, tm.id_grade, tm.id_group, tm.id_headquarters, tm.id_study_day, rtrim(tg.grado) AS grado, 
							rtrim(tj.jornada) AS jornada 
							FROM ".$db.".obs_observador_mod_3 AS tob  
							LEFT JOIN ".$db.".student_enrollment AS tm ON tob.id_matric = tm.id 
							LEFT JOIN ".$db.".grados AS tg ON tm.id_grade=tg.id 
							LEFT JOIN ".$db.".jornadas AS tj ON tm.id_study_day=tj.cod_jorn ";
				break;
			case 4:
				$query 	= "SELECT tob.*, tm.id_grade, tm.id_group, tm.id_headquarters, tm.id_study_day, rtrim(tg.grado) AS grado, 
							rtrim(tj.jornada) AS jornada FROM obs_observador_mod_1 AS tob  
							LEFT JOIN student_enrollment AS tm ON tob.id_matric = tm.id 
							LEFT JOIN grados AS tg ON tm.id_grade=tg.cod_grado 
							LEFT JOIN jornadas AS tj ON tm.id_study_day=tj.cod_jorn ";
				break;
			default:
				break;
		}		
		$where	= "tob.id_matric = ? AND tob.estado = ? AND tm.year = ? ";		
		$param 	= array(
			$id_matric,
			$estado,
			$this->get_year()
		);
		$query	= $this->db->query($query." WHERE ".$where, $param);
		return $this->getJsonResponse($query->result(), $query->num_rows());
	}
	
	
	public function get_fortdif ($id_observador) {
		$query 	= "SELECT * FROM obs_items_modelo_1 WHERE id_observador = ".$id_observador;
		return 	$this->get_query($this->limit_min,$this->limit_max,$query);
	}
	
	public function	get_modelo_observador() {
		
		$query	= "SELECT * FROM obs_modelos_observador WHERE estado = 1 AND id_inst=".$this->get_id_school();
		$query 		= $this->db->query($query);
		
		$id_modelo	= $query->num_rows('id');
		
		$query2	= "SELECT * FROM obs_items_modelos ";
		
		$where	= "id_modelo= ? AND año= ?";
		
		$param	= array(
			$id_modelo,
			$this->get_year()
		);
		
		$query2	= $this->get_query_param($this->limit_min,$this->limit_max,$query2,$where,$param);
		
		return $query2;
	}
	
	public function get_fortdif_insert ($id_obs,$lista) {
		$list_data	= json_decode($lista);
		$param 		= array(
			'id_observador'		=> $id_obs,
			'id_docente'		=> $this->id_docente,
			'estado'			=> '1',
			'fecha'				=> date('Y-m-d')
		);
		
		$request	= $this->insert_primary('obs_items_modelo_1',$list_data,$param);
		return	$request;
	}
	
	public function get_fortdif_update ($lista) {
		
		$list_data	= $lista;
				
		$request	= $this->get_update_primary('obs_items_modelo_1',$list_data);
		
		return $request;
	}
	
	public function get_tipo_observador(){
		$query	= "SELECT * FROM obs_modelos_observador WHERE id_inst= ? AND estado= ?";
		$where	= array(
			$this->get_id_school(),
			1
		);		
		$query	= $this->db->query($query,$where);		
		if ($query) {			
			$row	= $query->row();			
			$result = $row->id;			
		}else{
			$result = 0;
		}		
		return $result;
	}
}