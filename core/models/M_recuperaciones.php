<?php
defined('BASEPATH') OR exit('No direct script access allowed');
class m_recuperaciones extends SME_Model {
	function __construct() {
		parent::__construct();
	}
	
	public function get_select_recuperaciones_finales($doc){
		
		$id_doc	= $doc > 0 ? $doc : $this->get_parent();
		$param	= $this->get_year().",".$id_doc.",1";
		$query	= "sp_select_respeciales_docente";
					
		$request = $this->get_call($query,$param);
		
		return $request;
	}
	
	public function get_recuperaciones_b($grado,$asig,$fieldslist,$periodo,$niv){	
		$db         = $this->get_db_name();	
		if ($niv > 0){
			$sql	= "SELECT * FROM ".$db.".grados WHERE id_nivel=".$niv." LIMIT 1";
			$sql	= $this->db->query($sql);
			if($sql->num_rows() > 0){
				$grado	= $sql->row('id');
			}else{
				$request	= $this->getError();
				return	$request;
			}
		}
		
		if($this->control_date_nivelacion($periodo,$grado)){
			$table	= $this->tabla_notas($grado);		
			$request = $this->updateData($table,json_decode($fieldslist));
		}else{
			$request	= $this->control_date_msg();
		}									
		return $request;
	}
	
	public function get_recuperaciones ($grado,$asig,$periodo,$doc,$niv) {		
		$db         = $this->get_db_name();
		$year		= $this->get_year();
		$year_now	= date('Y');
		if ($niv > 0){
			$this->db->where('id_nivel', $niv);
			$sql	= $this->db->get($db.'.grados',1);
			if($sql->num_rows() > 0){
				$grado	= $sql->row('id');
				$table	= $this->tabla_notas($grado);
			}else{
				$request	= $this->getError();
				return	$request;
			}
		}else{
			$table 	= $this->tabla_notas($grado);
		}		
		
		$this->get_desempeños_rango($grado);
		$date	= date('Y-m-d');	
		
		$this->db->select("tn.id,tn.periodo, tn.year, tn.nota_perdida, 
			tn.nota_habilitacion, tn.final,tn.fecha, tc.id_docente, tc.id_grado, 
			tc.id_asig, tc.id_jorn, tc.id_sede, tc.grupo,
			CONCAT(RTRIM(ti.apellido1),' ',RTRIM(ti.apellido2),' ',RTRIM(ti.nombre1),' ',RTRIM(ti.nombre2)) AS nombres,
			tm.id_student");
		$this->db->from($db.'.'.$table." AS tn");
		$this->db->join($db.'.cursos AS tc', '(tn.id_curso = tc.id AND tn.year = tc.year)', 'left');
		$this->db->join($db.'.student_enrollment AS tm', 'tn.id_matric = tm.id', 'left');
		$this->db->join($db.'.inscripciones AS ti', 'tm.id_student = ti.id', 'left');
						
		$doc	= $doc > 0 ? $doc : $this->get_parent();
				
		if($niv <= 0){
			$this->db->where('tc.id_grado', $grado);
			$this->db->where('tm.id_grade', $grado);
			$this->db->where('tc.id_asig', $asig);
		}	

		$this->db->where('tn.year', $year);
		$this->db->where('tn.periodo',$periodo);
		$this->db->where("tn.final BETWEEN '".$this->desde."' AND '".$this->hasta."'");
		$this->db->where('tc.id_docente', $doc);
		$this->db->where('tc.year', $year);
		$this->db->where('tm.year', $year);
		$this->db->where('tm.id_state', 2);
		$this->db->order_by('tc.id_grado,  tc.grupo, tc. id_asig,  tc.id_jorn, nombres');
		$query_up = $this->db->get();			

		if ($query_up) {		
			if($year	== $year_now ){	
				foreach($query_up->result_array() as $row){
					$update	= "UPDATE ".$db.".".$table." SET nota_perdida=final, fecha='".$date."' ".
					"WHERE id=".$row['id']." AND nota_perdida = 0 LIMIT 1";				
					$this->db->query($update);

					$update	= "UPDATE ".$db.".".$table." SET nota_perdida=0, nota_habilitacion=0, fecha='NULL'".
					"WHERE id=".$row['id']." AND nota_perdida > 0 AND final > nota_perdida LIMIT 1";				
					$this->db->query($update);
				}	
			}		
			$this->db->select("tn.id,tn.periodo, tn.year, tn.nota_perdida, 
			tn.nota_habilitacion, tn.final,tn.fecha, tc.id_docente, tc.id_grado, 
			tc.id_asig, tc.id_jorn, tc.id_sede, tc.grupo,
			CONCAT(RTRIM(ti.apellido1),' ',RTRIM(ti.apellido2),' ',RTRIM(ti.nombre1),' ',RTRIM(ti.nombre2)) AS nombres,
			tm.id_student, ta.asignatura, ta.abrev, tar.area, tg.cod_grado");
			
			$this->db->from($db.'.'.$table." AS tn ");
			$this->db->join($db.'.cursos AS tc', '(tn.id_curso = tc.id AND tn.year = tc.year)', 'left');
			$this->db->join($db.'.student_enrollment AS tm', 'tn.id_matric = tm.id', 'left');
			$this->db->join($db.'.inscripciones AS ti', 'tm.id_student = ti.id', 'left');
			$this->db->join($db.'.asignaturas AS ta','tc.id_asig = ta.id_pk','left');
			$this->db->join($db.'.aux_asignaturas AS tau','(tau.id_asign = ta.id_pk AND tau.year='.$year.')','left');
			$this->db->join($db.'.areas AS tar','tau.id_area = tar.id','left');
			$this->db->join($db.'.grados AS tg ','tc.id_grado = tg.id ','left');

			if($niv <= 0){
				$this->db->where('tc.id_grado', $grado);
				$this->db->where('tm.id_grade', $grado);
				$this->db->where('tc.id_asig', $asig);
			}	
			$this->db->where('tn.year', $year);
			$this->db->where('tn.periodo',$periodo);
			$this->db->where("tn.final BETWEEN '".$this->desde."' AND '".$this->hasta."'");
			$this->db->where('tn.nota_perdida > 0');			
			$this->db->where('tc.id_docente', $doc);
			$this->db->where('tc.year', $year);
			$this->db->where('tm.year', $year);
			$this->db->where('tm.id_state', 2);
			$this->db->order_by('tc.id_grado,  tc.grupo, tc.id_asig,  tc.id_jorn, nombres');
			
			$records	= $this->db->get();
			$total		= $records->num_rows();
			$records	= $records->result_array();
			$request = $this->getJsonResponse($records,$total);
		}else{
			$request = $this->getError();
		}	
		
		return $request;
		
	}
	
}