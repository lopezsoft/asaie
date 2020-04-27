<?php
defined('BASEPATH') OR exit('No direct script access allowed');
class M_sugerencias extends SME_Model {
	public function __construct() {
		parent::__construct();
	}
	public function get_delete_estudiantes($list,$cod_grado){
		$db		= $this->get_db_name();
		$table_log	= $db.".".$this->tabla_sugerencias($cod_grado);
		$this->trans_start();
		if (is_array($list)) {
			foreach ($list as $value) {
				$param = array (
					$value->id,
					$value->id_nota
				);
				$query 	= "DELETE FROM ".$table_log." WHERE id_sugerencia= ? AND id_nota= ?";
				$query	= $this->db->query($query,$param);
			}
		}else{
			$param = array (
				$list->id,
				$list->id_nota
			);
			$query 	= "DELETE FROM ".$table_log." WHERE id_sugerencia= ? AND id_nota= ?";
			$query	= $this->db->query($query,$param);
		}
		
		$this->trans_complete();
		
		if ($this->trans_status()) {
			$request = $this->get_request_ab();
		}else{
			$request = $this->get_error();
		}		
		return $request;
	}

	public function get_select_estudiantes($cod_grado,$periodo,$id_sede,$cod_jorn,$grupo,$id_asig){

		$param = array(
			$this->get_parent(),
			$this->get_year(),
			$cod_grado,
			$periodo,
			$grupo,
			$id_sede,
			$cod_jorn,
			$id_asig
		);
				
		return $this->getExecute('sp_select_sugerencias_estudiante_all(?, ?, ?, ?, ?, ?, ?, ?)',$param);;
	}
	
	/**
	* Funcion que guarda los logros e indicadores de desempeños
	* 
	* @return
	*/
	
	public function insert_sugerencias_est ($list,$cod_grado) {
		$db		= $this->get_db_name();
		$table_log	= $db.".".$this->tabla_sugerencias($cod_grado);
		if(is_array($list)){
			$this->trans_start();
			foreach ($list as $value) {
				$id_nota		= $value->id_nota;
				$id_sugerencia  = $value->id_sugerencia;
				
				$query 	= "SELECT * FROM ".$table_log." WHERE id_nota=".$id_nota.
						 " AND id_sugerencia=".$id_sugerencia;
				
				$query	= $this->db->query($query);
				
				if ($query->num_rows() == 0){
					/**
					*  Se inserta el logro y/o el indicador
					*/
					$query	= "INSERT INTO ".$table_log.
					" (id_nota,id_sugerencia) VALUES ('".
					$id_nota."','".$id_sugerencia."')" ;
					$this->db->query($query);		
				}
			}
			$this->trans_complete();
		}else{
			$id_nota		= $list->id_nota;
			$id_sugerencia  = $list->id_sugerencia;
			$query 	= "SELECT * FROM ".$table_log." WHERE id_nota=".$id_nota.
					 " AND id_sugerencia=".$id_sugerencia;
			$query	= $this->db->query($query);
			if ($query->num_rows() == 0){
				/**
				*  Se inserta el logro y/o el indicador
				*/
				$query	= "INSERT INTO ".$table_log.
				" (id_nota,id_sugerencia) VALUES ('".
				$id_nota."','".$id_sugerencia."')" ;
				$this->db->query($query);
			}	
		}
	}
		
	public function insert_sugerencias ($table,$field_list) {
				
		$extra	= array(
			'id_docente'	=> $this->get_parent(),
			'year'			=> $this->get_year()
		);
		
		$request	= $this->insert_data_primary($table,$field_list,$extra);
		
		return	$request;
	}
	
	public function get_select_sugerencias($periodo) {
		
		if($periodo == '0'){
			$param 	= array(
				'id_docente'	=> $this->get_parent()
			);
		}else{
			$param 	= array(
				'id_docente'	=> $this->get_parent(),
				'periodo'		=> $periodo
			);
		}
		
		return	$this->getTable('sugerencias',$this->limit_min,$this->limit_max,'',$param);
	}
}

