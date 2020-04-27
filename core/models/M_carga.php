<?php
defined('BASEPATH') OR exit('No direct script access allowed');
class M_carga extends SME_Model {
 	public function __construct() {
		parent::__construct();
	}
	
	public function get_carga_academica_agrupada_observador(){
		$param = array(
			$this->get_parent(),
			$this->get_year(),
			1
		);
		return $this->getExecute('sp_carga_docente_agrupada(?, ?, ?)',$param);
	}
	
	public function get_carga_academica ($query){
		$param = array(
			$this->get_parent(),
			$this->get_year(),
			$query
		);
		$db_return = $this->getExecute('sp_carga_docente ( ?, ?, ? )',$param);
		return $db_return;
	}
	
	public function get_carga_academica_agrupada(){
		$param = array(
			$this->get_parent(),
			$this->get_year(),
			0
		);
		return $this->getExecute('sp_carga_docente_agrupada(?, ?, ?)',$param);
	}
}