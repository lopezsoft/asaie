<?php
defined('BASEPATH') OR exit('No direct script access allowed');
class M_cierre extends SME_Model {
	function __construct() {
		parent::__construct();
	}
	
		
	public function cierre_anio(){
		$cListTables = 
		  'desempeños,'.
		  'competencias,'.
		  'config001,'.
		  'configcerfinal,'.
		  'configconstancias,'.
		  'matcurso,'.
		  'docentes,'.
		  'configcerfinalciclos,'.
		  'configconstanciasciclos,'.
		  'encabezado_reportes,'.
		  'configdiplomas,'.
		  'config_acta_grado,';	
		$result	= "";
		$aNext	= strval($this->get_year())+1;
		$get_a	= 'SELECT * FROM cierre WHERE año='.$this->get_year().' AND id_inst='.$this->get_id_school();
		$get_a 	= $this->db->query($get_a);
		$x		= 0;
		if ($get_a ->num_rows() > 0){
			$result	= $this->get_request_ab();
		}else{
			$nCount = substr_count($cListTables,',');
			$this->trans_start();
			for($x = 0; $x < $nCount; $x++){
				$SQLInsert 	= '';
		    	$SQLValues	= '';
		    	$nOccur 	= strpos($cListTables,',');
		    	$cTableName = substr($cListTables,0,$nOccur);
			 	$cListTables= substr($cListTables,$nOccur+1);
				$fiels_table = $this->db->field_data($cTableName);
				foreach($fiels_table as $field_compare){
	   				/* 
					* @var Nombre del campo
					* 
					*/
					$name = trim($field_compare->name);
					$name_C = $this->normaliza(strtolower($name));
					$nor	= $this->normaliza('año');
					
					/**
					* 
					* @var Tipo de campo, si es primario devuelve 1, sino 0
					* 
					*/
					$primary_key = $field_compare->primary_key;
					if ($primary_key == 0){
						$SQLInsert = $SQLInsert.$name.',';	
						
						if ($name_C == $nor){
							$SQLValues	= $SQLValues.$aNext.',';
						}else{
							$SQLValues	= $SQLValues.$name.',';
						}

					}
			   	
			   	}   
			   
				$SQLInsert = substr($SQLInsert,0,strlen($SQLInsert)-1);
				$SQLValues = substr($SQLValues,0,strlen($SQLValues)-1);				
				$SQL = 'INSERT INTO '.$cTableName.' ('.$SQLInsert.') '.
						'SELECT '.$SQLValues.' FROM '.$cTableName.
						' WHERE año='.$this->get_year()." AND id_inst=".$this->get_id_school();
				$DEL = 'DELETE FROM '.$cTableName.' WHERE año='.$aNext.' AND id_inst='.$this->get_id_school();
				
				$this->db->query($DEL);
				$this->db->query($SQL);
			}
			$get_a	= 'INSERT INTO cierre (año,id_inst) VALUES ('.$this->get_year().','.$this->get_id_school().')';
			$this->db->query($get_a);
			$this->trans_complete();
			if ($this->trans_status()){
				$result	= $this->get_request_ab();
			}else{
				$result = $this->get_error();
			}
		}
		return $result;
	}
	
}