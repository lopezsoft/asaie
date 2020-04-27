<?php
defined('BASEPATH') OR exit('No direct script access allowed');
class M_pre_matricula extends SME_Model {
	function __construct() {
		parent::__construct();
	}
	
	public function get_select_nuevos(){
		$sql = "SELECT t.*, RTRIM(ts.NOM_SEDE) sede, tg.grado,
				CONCAT(RTRIM(ti.apellido1),' ',RTRIM(ti.apellido2),' ',RTRIM(ti.nombre1),' ',RTRIM(ti.nombre2)) estudiante,
				ti.nro_doc_id, ti.fecha_nacimiento FROM pre_matricula_nuevos AS t
				LEFT JOIN sedes AS ts ON t.id_sede =  ts.ID
				LEFT JOIN grados AS tg ON t.cod_grado = tg.COD_GRADO
				LEFT JOIN inscripciones AS ti ON t.cod_est = ti.cod_est
				WHERE ts.ID_INST = ".$this->get_id_school()." AND ti.id_inst = ".$this->get_id_school()."
				ORDER BY t.id_sede, t.cod_grado";
		return $this->get_query($this->limit_min,$this->limit_max,$sql,FALSE);
	}
	
	public function get_prematricula($inst,$sede,$grado,$grupo,$repite,$a,$ins_proced,$fCC,$fOBS,$sql){
		$id		= 0;  	
		$this->trans_start();
		$query  = $this->db->query($sql);
  		if ($query) {
  			$id	= $this->db->insert_id();
  			$sqlMat	= "INSERT INTO pre_matricula_nuevos (id_inst,id_sede,cod_est,id_grado,repite,
  					ins_proced,estado,año) VALUES(".$inst.",".$sede.",".$id.",'".$grado.
  					"','".$repite."','".$ins_proced."','2',".$a.")";
  			$this->db->query($sqlMat);
  			$this->folders_estudiantes($id);
  			$this->upload_file($fCC,$this->dirPathDocsDigEstudiantes);
  			$this->upload_file($fOBS,$this->dirPathDocsDigEstudiantes);
		}else{
			$request = $this->get_error();
		}
		$this->trans_complete();
		if($this->trans_status()){
			$list	= array(
  				'id' => $id
  			);
			$request = $this->get_request_insert($list);
		}else{
			$request = $this->get_error();
		}
		return $request;
	}
}