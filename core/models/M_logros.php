<?php
defined('BASEPATH') OR exit('No direct script access allowed');
class M_logros extends SME_Model {
	public function __construct() {
		parent::__construct();
		
	}
	
	public function get_importar_logros_ind($grado,$asig,$sede) {
		$a			= $this->get_year() - 1;
		$db         = $this->get_db_name();		
		$query	="SELECT tl.*,tp.nombre_proceso, tc.competencia, es.nombre_escala
			FROM ".$db.".logros_estandares AS tl 
			LEFT JOIN ".$db.".escala_nacional AS es ON tl.id_escala = es.id
			LEFT JOIN ".$db.".tipo_procesos_educativos AS tp ON tl.tipo = tp.id
			LEFT JOIN ".$db.".competencias AS tc ON (tl.id_competencia = tc.id AND tl.year = tc.year)
			LEFT JOIN ".$db.".grados_agrupados AS t1 ON tc.id_grado_agrupado = t1.id
			LEFT JOIN ".$db.".aux_grados_agrupados AS t2 ON (t2.id_grado_agrupado = t1.id)
			WHERE t2.id_grado = tl.id_grado AND tl.year = tc.year 
			AND tl.id_grado = ".$grado." 
			AND tl.id_asig = ".$asig." AND tl.year = ".$a." AND tc.year = ".$a." AND t2.id_grado =".$grado."
			ORDER BY tl.tipo, tl.periodo, tl.id_competencia,tl.id_escala";				
		$request	= $this->get_query($this->limit_min,$this->limit_max,$query,FALSE);			
		return $request;
	}
	
	public function get_delete_logros_estudiantes_all($list,$cod_grado){
		$db		= $this->get_db_name();
		$count	= count($list);
		$i  	= 0;
		$table_log	= $db.".".$this->tabla_logros_estandares($cod_grado);
		$this->trans_start();
		if ($count > 1) {
			for($i = 0; $i < $count; $i++){
				$id_logro	= $list[$i]->id;
				$id_nota	= $list[$i]->id_nota;
				
				$param = array (
					$id_logro,
					$id_nota
				);				
				$query 	= "DELETE FROM ".$table_log." WHERE id_logro_estandar= ? AND id_nota= ?";				
				$query	= $this->db->query($query,$param);				
			}
		}else{
			
			$id_logro	= $list[0]->id;
			$id_nota	= $list[0]->id_nota;			
				
			$param = array (
				$id_logro,
				$id_nota
			);
			$query 	= "DELETE FROM ".$table_log." WHERE id_logro_estandar= ? AND id_nota= ?";
			$query	= $this->db->query($query,$param);
		}
		$this->trans_complete();
		if ($this->trans_status()) {
			$request = $this->getJsonResponse([],0);
		}else{
			$request = $this->getError();
		}		
		return $request;
	}
	
	public function get_delete_logros_estudiantes($list,$cod_grado,$id_nota){
				
		$count	= count($list);
		$i  	= 0;
		
		$table_log	= $this->tabla_logros_estandares($cod_grado);
		
		$this->trans_start();
		if ($count > 1) {
			
			for($i = 0; $i < $count; $i++){
				$id_logro	= $list[$i]->id;
				
				$param = array (
					$id_logro,
					$id_nota
				);
				
				$query 	= "DELETE FROM ".$table_log." WHERE id_logro_estandar= ? AND id_nota= ?";
				
				$query	= $this->db->query($query,$param);
				
			}
		}else{
			$id_logro	= $list->id;
				
			$param = array (
				$id_logro,
				$id_nota
			);
			
			$query 	= "DELETE FROM ".$table_log." WHERE id_logro_estandar= ? AND id_nota= ?";
			
			$query	= $this->db->query($query,$param);
		}
		
		$this->trans_complete();
		
		if ($this->trans_status()) {
			$request = $this->getJsonResponse([],0);
		}else{
			$request = $this->getError();
		}		
		return $request;
	}
	
	/**
	* Funcion que devuelve el query de los logros e indicadores del docente 
	* 
	* @param string $cod_grado - Codigo del grao
	* @param string $id_asig - Codigo de la asignatura
	* @param integer $type - Identificador
	* @param integer $id_nota - ID  de la nota
	* 	
	* @return
	*/
	
	public function get_select_logros_estudiantes($cod_grado,$id_asig,$periodo,$id_nota){
				
		$param =	$this->get_id_school().','.
					$this->get_parent().','.
					$this->get_year().",'".
					$cod_grado."',".
					$id_asig.','.
					$periodo.','.
					$id_nota;
					
		$request = $this->get_query_call('sp_select_logros_estudiante',$param);
		
		return $request;
	}
	
	public function get_select_logros_estudiantes_all($grado,$asig,$periodo,$grupo,$sede,$jorn){
				
		$param = array(
			$this->get_parent(),
			$this->get_year(),
			$grado,
			$asig,
			$periodo,
			$grupo,
			$sede,
			$jorn
		);
				
		return  $this->getExecute('sp_select_logros_estudiante_all(?, ?, ?, ?, ?, ?, ?, ?)',$param);
	}
	
	public function get_logros_update ($table,$lista) {
		$request = $this->updateData($table,json_decode($lista));
		return $request;
	}
	
	public function get_logros_insert ($lista_data,$grado,$asig) {
		$lista =json_decode($lista_data);
		$extra = array(
			'year'			=> $this->get_year(),
			'id_docente'	=> $this->get_parent(),
			'id_asig'		=> $asig,
			'id_grado'		=> $grado
		);		
		return $this->insert_data_primary('logros_estandares',$lista,$extra);
	}
	
	/**
	* Funcion que devuelve el query de los logros e indicadores del docente 
	* 
	* @param string $cod_grado - Codigo del grao
	* @param string $id_asig - Codigo de la asignatura
	* @param integer $type - Identificador
	* 	
	* @return
	*/
	
	public function get_select_logros_estandares($grado,$id_asig,$periodo){
		$param = array(
			$this->get_parent(),
			$this->get_year(),
			$grado,
			$id_asig,
			$periodo
		);
		return $this->getExecute('sp_select_logros_es_docente(?, ?, ?, ?, ?)',$param);
	}
}