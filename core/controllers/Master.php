<?php defined('BASEPATH') OR exit('No direct script access allowed');
class Master extends SME_Controller {
	public function __construct() 
	{
		parent::__construct();
	  	$this->load->model('Master_m');
	}
	
	/** 
	 * Retorna el listado del estado del estudiante al promocionarlo
	 */
	public function getEstadoFinalEstudiante()
	{
		echo $this->Master_m->getEstadoFinalEstudiante();
	}

	/**
	 * Regresa el listado de las areas que afecta la promoción del estudiante
	 * en configuraciones
	 */

	public function getPromotionAreas()
	{
		$id		= $this->input->get_post('pdbId');
		echo $this->Master_m->getPromotionAreas($id);
	}
	/**
	 * Configuración general del sistema
	 */
	public function getGeneralConfig()
	{
		echo $this->Master_m->getGeneralConfig();
	}

	public function getGroupDirectorByGrade()
	{
		$grade	= $this->input->get_post('pdbGrado');
		echo $this->Master_m->getGroupDirectorByGrade($grade);
	}

	/** 
	* Funcion que retorna el listado de los grados académicos
	*/
	function getGrades() 
	{
		$query = $this->input->get_post('query');
		$headq	= $this->input->post_get('pdbSede');
		echo $this->Master_m->getSelectGrades ($query,$headq);
	}

	public function insertTeachers()
	{
		$primaryKey	= $this->input->post('primaryKey');
		$table		= $this->input->post('pdbTable');
		$serial		= $this->input->post('serial');
		$records	= json_decode($this->input->post('records'));
		$primaryKey = ($primaryKey) ? $primaryKey : 'id' ;	

		echo $this->Master_m->insertTeachers($table, $records, $primaryKey, $serial);
	}

	public function getSelectAdmin(){
		$query	= $this->input->get_post('query');
		$start	= $this->input->get_post('start');
		$limit	= $this->input->get_post('limit');

		echo $this->Master_m->getSelectAdmin($query, $start, $limit);
	}

	public function getSelectTeachers(){
		$query	= $this->input->get_post('query');
		$start	= $this->input->get_post('start');
		$limit	= $this->input->get_post('limit');

		echo $this->Master_m->getSelectTeachers($query, $start, $limit);
	}

	public function deleteData()
	{
		$primaryKey	= $this->input->post('primaryKey');
		$table		= $this->input->post('pdbTable');
		$records	= json_decode($this->input->post('records'));
		$primaryKey = ($primaryKey) ? $primaryKey : 'id' ;	

		echo $this->Master_m->deleteData($table, $records, $primaryKey);
	}

	public function insertData()
	{
		$primaryKey	= $this->input->post('primaryKey');
		$table		= $this->input->post('pdbTable');
		$serial		= $this->input->post('serial');
		$records	= json_decode($this->input->post('records'));
		$primaryKey = ($primaryKey) ? $primaryKey : 'id' ;	

		echo $this->Master_m->insertData($table, $records, $primaryKey, $serial);
	}

	public function updateData()
	{
		$primaryKey	= $this->input->post('primaryKey');
		$table		= $this->input->post('pdbTable');
		$records	= json_decode($this->input->post('records'));
		$primaryKey = ($primaryKey) ? $primaryKey : 'id' ;	

		echo $this->Master_m->updateData($table, $records, $primaryKey);
	}
	
	public function getTable()
	{
		$table	= $this->input->get_post('pdbTable');
		$query	= $this->input->get_post('query');
		$start	= $this->input->get_post('start');
		$limit	= $this->input->get_post('limit');
		$where	= $this->input->get_post('where');
		$order	= $this->input->get_post('order');
		if(isset($where)){
			$where 	= json_decode($where);
			$zwher	= [];
			foreach ($where as $key => $value) {
				$zwher[$key]	= $value;
			}
			$where	= $zwher;
		}else{
			$where	= [];
		}
		if(isset($order)){
			$order 	= json_decode($order);
			$zorder	= [];
			foreach ($where as $key => $value) {
				$zorder[$key]	= $value;
			}
			$order	= $zorder;
		}else{
			$order	= [];
		}
		echo $this->Master_m->getTable($table, $start, $limit, $query,$where, $order);
	}

}
