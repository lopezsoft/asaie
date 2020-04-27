<?php
defined('BASEPATH') OR exit('No direct script access allowed');
class M_convivencia extends SME_Model {
	function __construct() {
		parent::__construct();
	}
	
	public function insert_control_seguimiento_estudiantes($list,$id){
		
		$lista = json_decode($list);
			
		$lista->id_reg_sit_est = $id;
		
		$request	= $this->insert_primary('conv_control_seguimiento',$lista,NULL);
		
		return $request;
	}
		
	public function get_select_control_seguimiento_estudiantes($id){
		$query 	= "SELECT t1.* FROM conv_control_seguimiento AS t1 
				   LEFT JOIN conv_reg_situaciones_est AS t2 ON t1.id_reg_sit_est = t2.id";
		
		$where = "t2.año = ? AND t1.id_reg_sit_est = ?";
		
		$param	= array(
			$this->get_year(),
			$id
		); 
		
		$query = $this->get_query_param($this->limit_min,$this->limit_max,$query,$where,$param);
		
		echo $query;
	}
	
	public function get_insertacciones_estudiantes($list,$id){
		
		$lista = json_decode($list);
		
		$extra	= array('año' 	=> $this->get_year(),'id_res_sit_est' => $id);
		
		$request	= $this->insert_primary('conv_reg_acciones_est',$lista,$extra,TRUE);
		
		return $request;
	}
	
	public function	 get_select_acciones_estudiantes($id){
		$query	= "SELECT * FROM conv_reg_acciones_est ";
		$where	= "id_res_sit_est = ? ";
		$param	= array($id);
		
		return $this->get_query_param($this->limit_min,$this->limit_max,$query,$where,$param);
	}	
	
	public function insert_formatos($list){
		$data	= json_decode($list);	
		
		$extra	= array(
			'id_inst' => $this->get_id_school()
		);
		
		$id		= $this->insert_primary('conv_formatos',$data,$extra,TRUE);
		
		$queyr 	= "SELECT t1.*, t2.nombre AS accion FROM  conv_formatos AS t1 
				  LEFT JOIN conv_acciones AS t2 ON t1.id_accion = t2.id";
		
		$where	= "t1.id_inst = ? AND t2.id_inst = ? AND t1.id = ? AND t1.estado=1 AND t2.estado = 1";
		
		$param	= array(
			$this->get_id_school(),
			$this->get_id_school(),
			$id
		);
		
		return $this->get_query_param($this->limit_min,$this->limit_max,$queyr,$where,$param);
		
	}	
	
	public function get_select_acciones(){
		$query = "SELECT * FROM conv_acciones WHERE estado = 1 AND id_inst = ".$this->get_id_school();
		
		return $this->get_query($this->limit_min,$this->limit_max,$query);
	}
	
	public function get_select_formatos(){
		$queyr 	= "SELECT t1.*, t2.nombre AS accion FROM  conv_formatos AS t1 
				  LEFT JOIN conv_acciones AS t2 ON t1.id_accion = t2.id";
		
		$where	= "t1.id_inst = ? AND t2.id_inst = ?  AND t1.estado=1 AND t2.estado = 1";
		
		$param	= array(
			$this->get_id_school(),
			$this->get_id_school()
		);
		
		return $this->get_query_param($this->limit_min,$this->limit_max,$queyr,$where,$param);	
	}
	
	public function get_update_situaciones_estudiantes($list) {
		$id = $this->get_update_primary('conv_reg_situaciones_est',$list,TRUE);
		$query 	= "SELECT t1.id,t1.id_matric,t1.id_situacion,t1.observacion,t1.fecha_registro,
				   t1.id_docente,t1.id_admin,ts.numero,ts.descripcion, ta.descripcion AS tipo, tg.grado, 
				   tm.grupo, CONCAT(RTRIM(td.apellido1),' ',RTRIM(td.apellido2),' ',RTRIM(td.nombre1)
				   ,' ',RTRIM(td.nombre2)) AS docente, CONCAT(RTRIM(tdi.apellido1),' ',RTRIM(tdi.apellido2)
				   ,' ',RTRIM(tdi.nombre1),' ',RTRIM(tdi.nombre2)) AS directivo, tm.año 
				   FROM conv_reg_situaciones_est AS t1 
				   LEFT JOIN conv_situaciones AS ts ON t1.id_situacion = ts.id
				   LEFT JOIN conv_tipo_situaciones AS ta ON ts.id_tipo = ta.id
				   LEFT JOIN matriculas AS tm ON t1.id_matric = tm.id_matric 
				   LEFT JOIN grados AS tg ON tm.cod_grado = tg.cod_grado 
				   LEFT JOIN docentes AS td ON t1.id_docente = td.id_docente 
				   LEFT JOIN administrativos As tdi ON t1.id_admin = tdi.id";
		
		$where = "ts.id_inst = ? AND ts.año = ? AND ta.id_inst = ? AND ta.estado=1 AND ts.estado=1 
				 AND tm.id_inst = ? AND tm.año = ? AND td.id_inst = ? AND td.año = ? AND tdi.id_inst = ? 
				 AND t1.id = ? ORDER BY id_tipo,descripcion";
		
		$param	= array(
			$this->get_id_school(),
			$this->get_year(),
			$this->get_id_school(),
			$this->get_id_school(),
			$this->get_year(),
			$this->get_id_school(),
			$this->get_year(),
			$this->get_id_school(),
			$id
		); 
		
		 echo $query = $this->get_query_param($this->limit_min,$this->limit_max,$query,$where,$param);
	}
	
	public function get_insertsituaciones_estudiantes($list){
		$data	= json_decode($list);
		$list_decode = $data;	
		$extra	= array('año' => $this->get_year());
		$id		= $this->insert_primary('conv_reg_situaciones_est',$data,$extra,TRUE);
		
		
		$id_m	= $list_decode->id_matric;		
		
		$call	= $this->db->query("CALL `sp_insert_conv_situaciones_est_reincidencia`(".$id_m.")");
		
		$row = $call->row();
				
		$call->free_result();
					 	
	    mysqli_next_result($this->db->conn_id);		
		
		if ($row->id > 0){
			
			$list_decode->id_situacion 	= $row->id;
			$list_decode->observacion 	= "Reincidencia de situaciones";		
			
			$this->insert_primary('conv_reg_situaciones_est',$list_decode,$extra,TRUE);
			
		}
		
		$query 	= "SELECT t1.id,t1.id_matric,t1.id_situacion,t1.observacion,t1.fecha_registro,
				   t1.id_docente,t1.id_admin,ts.numero,ts.descripcion, ta.descripcion AS tipo, tg.grado, 
				   tm.grupo, CONCAT(RTRIM(td.apellido1),' ',RTRIM(td.apellido2),' ',RTRIM(td.nombre1)
				   ,' ',RTRIM(td.nombre2)) AS docente, CONCAT(RTRIM(tdi.apellido1),' ',RTRIM(tdi.apellido2)
				   ,' ',RTRIM(tdi.nombre1),' ',RTRIM(tdi.nombre2)) AS directivo, tm.año 
				   FROM conv_reg_situaciones_est AS t1 
				   LEFT JOIN conv_situaciones AS ts ON t1.id_situacion = ts.id
				   LEFT JOIN conv_tipo_situaciones AS ta ON ts.id_tipo = ta.id
				   LEFT JOIN matriculas AS tm ON t1.id_matric = tm.id_matric 
				   LEFT JOIN grados AS tg ON tm.cod_grado = tg.cod_grado 
				   LEFT JOIN docentes AS td ON t1.id_docente = td.id_docente 
				   LEFT JOIN administrativos As tdi ON t1.id_admin = tdi.id";
		
		$where = "ts.id_inst = ? AND ts.año = ? AND ta.id_inst = ? AND ta.estado=1 AND ts.estado=1 
				 AND tm.id_inst = ? AND tm.año = ? AND td.id_inst = ? AND td.año = ? AND tdi.id_inst = ? 
				 AND t1.id = ? ORDER BY id_tipo,descripcion";
		
		$param	= array(
			$this->get_id_school(),
			$this->get_year(),
			$this->get_id_school(),
			$this->get_id_school(),
			$this->get_year(),
			$this->get_id_school(),
			$this->get_year(),
			$this->get_id_school(),
			$id
		); 
		
		$query = $this->get_query_param($this->limit_min,$this->limit_max,$query,$where,$param);
		
		echo $query;
	}
	
	public function get_select_situaciones_estudiantes($id_matric){
		$query 	= "SELECT t1.id,t1.id_matric,t1.id_situacion,t1.observacion,t1.fecha_registro,
				   t1.id_docente,t1.id_admin,ts.numero,ts.descripcion, ta.descripcion AS tipo, tg.grado, 
				   tm.grupo, CONCAT(RTRIM(td.apellido1),' ',RTRIM(td.apellido2),' ',RTRIM(td.nombre1)
				   ,' ',RTRIM(td.nombre2)) AS docente, CONCAT(RTRIM(tdi.apellido1),' ',RTRIM(tdi.apellido2)
				   ,' ',RTRIM(tdi.nombre1),' ',RTRIM(tdi.nombre2)) AS directivo, tm.año 
				   FROM conv_reg_situaciones_est AS t1 
				   LEFT JOIN conv_situaciones AS ts ON t1.id_situacion = ts.id
				   LEFT JOIN conv_tipo_situaciones AS ta ON ts.id_tipo = ta.id
				   LEFT JOIN matriculas AS tm ON t1.id_matric = tm.id_matric 
				   LEFT JOIN grados AS tg ON tm.cod_grado = tg.cod_grado 
				   LEFT JOIN docentes AS td ON t1.id_docente = td.id_docente 
				   LEFT JOIN administrativos As tdi ON t1.id_admin = tdi.id";
		
		$where = "ts.id_inst = ? AND ts.año = ? AND ta.id_inst = ? AND ta.estado=1 AND ts.estado=1 
				 AND tm.id_inst = ? AND tm.año = ? AND td.id_inst = ? AND td.año = ? AND tdi.id_inst = ? 
				 AND tm.id_matric = ? ORDER BY id_tipo,descripcion";
		
		$param	= array(
			$this->get_id_school(),
			$this->get_year(),
			$this->get_id_school(),
			$this->get_id_school(),
			$this->get_year(),
			$this->get_id_school(),
			$this->get_year(),
			$this->get_id_school(),
			$id_matric
		); 
		
		$query = $this->get_query_param($this->limit_min,$this->limit_max,$query,$where,$param);
		
		echo $query;
	}
	
	public function get_select_situaciones($queyr,$xtype){
		
		if ($xtype > 0) {
	
			if (empty($queyr)){
				$where = "ts.id_inst = ? AND ts.año = ? AND ta.id_inst = ? AND ta.estado=1 AND ts.estado=1 
					AND id_tipo = ? ORDER BY id_tipo,descripcion";
			
				$param	= array(
					$this->get_id_school(),
					$this->get_year(),
					$this->get_id_school(),
					$xtype
				);
			}else{
				$where = "ts.id_inst = ? AND ts.año = ? AND ta.id_inst = ? AND ta.estado=1 AND ts.estado=1 
					  AND id_tipo = ? AND ts.descripcion REGEXP ? ORDER BY id_tipo,descripcion";
			
				$param	= array(
					$this->get_id_school(),
					$this->get_year(),
					$this->get_id_school(),
					$xtype,
					$queyr
				);
			}
			
		}else if (empty($queyr)){
												
			$where = "ts.id_inst = ? AND ts.año = ? AND ta.id_inst = ? AND ta.estado=1 AND ts.estado=1 
					ORDER BY id_tipo,descripcion";
			
			$param	= array(
				$this->get_id_school(),
				$this->get_year(),
				$this->get_id_school()
			); 
		}else{
			
			$where = "ts.id_inst = ? AND ts.año = ? AND ta.id_inst = ? AND ta.estado=1 AND ts.estado=1 
					AND ts.descripcion REGEXP ? ORDER BY id_tipo,descripcion";
			
			$param	= array(
				$this->get_id_school(),
				$this->get_year(),
				$this->get_id_school(),
				$queyr
			); 
		}
		
		$query 	= "SELECT ts.*, ta.descripcion AS tipo FROM conv_situaciones AS ts 
					   LEFT JOIN conv_tipo_situaciones AS ta ON 
					   ts.id_tipo = ta.id";
		
		$query = $this->get_query_param($this->limit_min,$this->limit_max,$query,$where,$param);
		
		echo $query;
	}
	
	public function get_select_tipo_situaciones(){
		$query 	= "SELECT * FROM conv_tipo_situaciones";
		
		$where = "id_inst = ? ";
		
		$param	= array(
			$this->get_id_school()
		); 
		
		$query = $this->get_query_param($this->limit_min,$this->limit_max,$query,$where,$param);
		
		echo $query;
	}
	
	
	
}