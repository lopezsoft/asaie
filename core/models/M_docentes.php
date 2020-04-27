
<?php
defined('BASEPATH') OR exit('No direct script access allowed');
class M_docentes extends SME_Model {
    
    public function __construct() {
		parent::__construct();		
	}	
	
	public function upload_files_dig($file,$cod) {
		$this->folders_teachers($cod);
		return $this->upload_file($file,$this->teacher_directory_path);
	}	
	public function read_files_dig($cod) {
		$this->folders_teachers($cod);
		return $this->read_directory_files($this->teacher_directory_path);
	}
		
	public function read_files_mat_educ() {
		$this->folders_teachers($this->get_parent());
		$path	= $this->route_directory_teaching_material;
		return $this->read_directory_files($path);
	}	
	public function get_select_respuestas_evaluacion($eval) {
		$query	= "SELECT tm.* FROM te_respuestas AS tm ".
				  "LEFT JOIN te_preguntas AS tc ON tm.id_pregunta=tc.id ";
		$where	= "tc.id= ? AND tm.id_pregunta= ? ";
		$param	= array(
			$eval,
			$eval
		);
		
		return $this->get_query_param($this->limit_min,$this->limit_max,$query,$where,$param);
	}	
	public function get_select_preguntas_evaluacion($eval) {
		$query	= "SELECT tm.*,tc.nombre evaluacion, tp.descripcion tp FROM te_preguntas AS tm ".
				  "LEFT JOIN te_evaluaciones AS tc ON tm.id_evaluacion=tc.id ".
				  "LEFT JOIN te_tipo_preguntas AS tp ON tm.tipo=tp.id";
		$where	= "tc.id= ? AND tm.id_evaluacion= ? ";
		$param	= array(
			$eval,
			$eval
		);
		
		return $this->get_query_param($this->limit_min,$this->limit_max,$query,$where,$param);
	}	
	public function get_select_evaluaciones_est($curso) {
		$query	= "SELECT tm.* FROM te_evaluaciones AS tm ".
				  "LEFT JOIN cursos AS tc ON tm.id_curso=tc.id ".
				  "LEFT JOIN docentes AS td ON tc.id_docente = td.id_docente ";
		$where	= "tc.id_docente= ? AND tc.year = ? AND tc.id_inst= ? AND tc.id= ? ".
				  "AND td.id_inst= ? AND td.year = ?";
		$param	= array(
			$this->get_teacher_id(),
			$this->get_year(),
			$this->get_id_school(),
			$curso,
			$this->get_id_school(),
			$this->get_year()
		);
		
		return $this->get_query_param($this->limit_min,$this->limit_max,$query,$where,$param);
	}	
	
	
	public function upload_files_mat_educ($file){
		$this->folders_teachers($this->get_teacher_id());
		$request = $this->upload_file($file,$this->route_directory_teaching_material);		
		return $request;
	}
	
	
	public function get_select_reg_actividades($curso){
		$query 	="SELECT t.*,tm.id_grado,tm.grupo,RTRIM(ta.asignatura) asignatura,RTRIM(tg.grado) grado ".
				"FROM reg_actividades AS t ".
				"LEFT JOIN cursos AS tm ON t.id_curso=tm.id ".
				"LEFT JOIN asignaturas AS ta ON tm.id_asig=ta.id ".
				"LEFT JOIN grados AS tg ON tm.id_grado = tg.id ";
		$where 	= "tm.id_inst= ? AND tm.year = ? AND tm.id_docente= ? ".
				 " AND tm.id= ?";	
				 
		$para 	= array(
			$this->get_id_school(),
			$this->get_year(),
			$this->get_teacher_id(),
			$curso
		);
		
		return $this->get_query_param($this->limit_min,$this->limit_max,$query,$where,$para);
	}	
	public function read_images(){
		$this->folders_teachers($this->get_teacher_id());
		$path	= $this->teacher_directory_path;
		return $this->read_directory_files($path);
	}
	
	public function upload_foto($file){
		$this->folders_teachers($this->get_teacher_id());
		$request  = $this->upload_file($file,$this->teacher_directory_path);
		return $request;		
	}
	
	public function get_asig_grados_carga($grado,$sede){
		$query = "SELECT tm.id_grado, UPPER(tg.grado) AS grado,".
			"RTRIM(ta.asignatura) AS asignatura, tm.id_asig 
			FROM cursos as tm ".
			"LEFT JOIN grados as tg  ON tm.id_grado = tg.id ".
			"LEFT JOIN asignaturas AS ta ON tm.id_asig = ta.id_pk";
			
		$where ="tm.estado=1 AND ta.estado=1 AND tm.id_docente= ? AND tm.year = ?  AND tm.id_inst= ? ".
				"AND tm.id_grado= ?  AND ta.id_inst= ? AND tm.id_sede= ?".
				" GROUP BY tm.id_grado, tm.id_asig, tm.id_docente, tm.year ";
						
		$param = array(
			$this->get_teacher_id(),
			$this->get_year(),
			$this->get_id_school(),
			$grado,
			$this->get_id_school(),
			$sede
		);	
		
		$db_return = $this->get_query_param($this->limit_min,$this->limit_max,$query,$where,$param);
		echo $db_return;
	}
	
	public function get_asig_grados_grupos_carga($grado,$grupo,$sede){
		$query = "SELECT tm.cod_grado, UPPER(tg.grado) AS grado,grupo,".
			"RTRIM(ta.asignatura) AS asignatura, tm.id_asig FROM cursos as tm ".
			"LEFT JOIN grados as tg  ON tm.cod_grado = tg.cod_grado ".
			"LEFT JOIN asignaturas AS ta ON tm.id_asig = ta.id";
			
		$where ="tm.estado=1 AND ta.estado=1 AND tm.id_docente= ? AND tm.year = ?  AND tm.id_inst= ? ".
				"AND tm.cod_grado= ? AND tm.grupo= ? AND ta.id_inst= ? AND ta.year = ? AND tm.id_sede= ?".
				" GROUP BY tm.cod_grado, tm.grupo, tm.id_asig, tm.id_docente, tm.year ";
						
		$param = array(
			$this->get_teacher_id(),
			$this->get_year(),
			$this->get_id_school(),
			$grado,
			$grupo,
			$this->get_id_school(),
			$this->get_year(),
			$sede
		);	
		
		$db_return = $this->get_query_param($this->limit_min,$this->limit_max,$query,$where,$param);
		echo $db_return;
	}
	
	
	public function get_grupos_carga($grado,$sede){
		$query = "SELECT tm.cod_grado, UPPER(tg.grado) AS grado, grupo FROM cursos as tm 
			LEFT JOIN grados as tg  ON tm.cod_grado = tg.cod_grado";
			
		$where = "tm.estado=1 AND tm.id_docente= ? AND tm.year = ?  
				AND tm.id_inst= ? AND tm.cod_grado= ? AND tm.id_sede= ?
			 	GROUP BY tm.cod_grado, tm.grupo, tm.id_docente, tm.year ";
						
		$param = array(
			$this->get_teacher_id(),
			$this->get_year(),
			$this->get_id_school(),
			$grado,
			$sede
		);	
		
		$db_return = $this->get_query_param($this->limit_min,$this->limit_max,$query,$where,$param);
		echo $db_return;
	}
	
	public function get_grados_carga($sede){
		$query = "SELECT tm.id_docente, tm.id_grado, UPPER(tg.grado) AS grado 
			FROM cursos as tm 
			LEFT JOIN grados as tg ON tm.id_grado = tg.id";
			
		$where = " tm.estado=1 AND tm.id_docente= ? AND tm.year = ? AND tm.id_inst= ? AND tm.id_sede= ? 
			 GROUP BY tm.id_grado, tm.id_docente, tm.year  ";
						
		$param = array(
			$this->get_teacher_id(),
			$this->get_year(),
			 $this->get_id_school(),
			 $sede
		);	
		
		$db_return = $this->get_query_param($this->limit_min,$this->limit_max,$query,$where,$param);
		echo $db_return;
	}
	
	public function get_update_preinforme ($list,$grado) {
		$table	= $this->tabla_pre_informe($grado);
		return $this->updateData($table,json_decode($list));
	}
	
	public function get_preinforme ($grado,$grupo,$periodo,$curso) {
		$param	= array(
			$curso,
			$periodo,
			$grado,
			$grupo,
			$this->get_year()
		);
		return $this->getExecute('sp_select_preinforme_all (?, ?, ?, ?, ?)', $param);
	}
	
	public	function get_update_docentes ($lista) {
		$result	= $this->get_update_primary('docentes',$lista);
		
		$query	= "SELECT pasw FROM docentes WHERE id_docente =".$this->get_teacher_id();
		
		$query = $this->db->query($query);
		if($query){
			
			$pasw	= $query->row('pasw');
			
			$set_data	=  array(
				'user_pass'        => $pasw
				);
			
			$this->session->set_userdata($set_data);	
		}		
		return $result;
	}
	
	public function get_select_docentes() {
		$query	= "SELECT id_docente,sexo,RTRIM(apellido1) apellido1,
		RTRIM(apellido2) apellido2,RTRIM(nombre1) nombre1,RTRIM(nombre2) nombre2,foto,mime,documento,e_mail, 
		RTRIM(direccion) direccion,documento,RTRIM(tipo_sangr) tipo_sangr,foto,mime,id_doc,id_sede,cod_car,cod_ense,
		cod_nivel,cod_vin,cod_zona 
		FROM docentes WHERE	id_docente=".$this->get_teacher_id();
				
		$result	= $this->get_query(0,1,$query);
		
		return	$result;
	}
	
	public function get_docentes_up($fieldslist){
		
		$table	= "config_columns_docentes";
				
		$count 	= count($fieldslist);
		$i 		= 0;
		$data	= '';
		$id		= NULL;
		$query	= '';
		
		$this->trans_start();
		
		for($i = 0; $i < $count; $i++){
			$where	= " id = '".$fieldslist[$i]->id."'";
			$data	= $fieldslist[$i];
			
			$query	= $this->db->update_string($table, $data, $where).";";
			$request = $this->db->query($query);
		}
			
		$this->trans_complete();
		
		if ($this->trans_status()){
			$request = $this->get_request_insert($fieldslist);
		}else{
			$request = $this->get_error();
		}			
		
		return	$request;	
	}
	
	public function get_docentes($curso,$cgrupo,$grado,$periodo){		
		$db         = $this->get_db_name();
		// if(!$this->db->field_exists('abrev','columnas_notas_competencias')){
		// 	$sql = "ALTER TABLE `columnas_notas_competencias`
		// 			CHANGE COLUMN `descripcion` `descripcion` VARCHAR(120) NOT NULL DEFAULT '' AFTER `porciento`;";
		// 	$this->db->query($sql);
		// 	$sql = "ALTER TABLE `columnas_notas_competencias`
		// 			ADD COLUMN `abrev` VARCHAR(10) NOT NULL DEFAULT '' AFTER `descripcion`;";
		// 	$this->db->query($sql);
		// }		
		
		// if(!$this->db->field_exists('modificable','columnas_notas_competencias')){
		// 	$sql = "ALTER TABLE `columnas_notas_competencias`
		// 			ADD COLUMN `modificable` INT(1) NOT NULL DEFAULT '0' AFTER `tipo`;";
		// 	$this->db->query($sql);
		// }		
		
		$create ="SELECT t.id,t.numero_column, CONCAT('#',t.numero_column) name_column, 
		t.tipo, t.porciento, t.descripcion, t.abrev, t.modificable,
		ROW_NUMBER() OVER (PARTITION BY tipo ORDER BY t.id_competencia, t.tipo, t.numero_column) AS row_num
		FROM ".$db.".columnas_notas_competencias t
		LEFT JOIN ".$db.".competencias AS tc ON t.id_competencia = tc.id_pk
		LEFT JOIN ".$db.".grados_agrupados AS t1 ON tc.id_grado_agrupado = t1.id
		LEFT JOIN ".$db.".aux_grados_agrupados AS t2 ON t2.id_grado_agrupado = t1.id
		WHERE tc.year = ".$this->get_year()." AND t2.id_grado =".$grado."
		ORDER BY t.id_competencia, t.tipo, t.numero_column;";
		$queryx = $this->db->query($create);				
		$nombre	= "";
		$cinsert= "";
		$descripcion	= "";
		$request ='';
		if ($curso > 0){
			if ($queryx) {
							
				$query	= "	SELECT COUNT(id) total  FROM ".$db.".config_columns_theacher tc
							WHERE tc.id_curso = ".$curso." AND tc.periodo ='".$periodo."'";				
				$select	= $this->db->query($query);				
				if ($select) {					
					if ($select->num_rows()>0){						
						if($select->num_rows() < $queryx->num_rows()){
							foreach($queryx->result_array() as $key => $value){
								switch($value['tipo']){
									case 'PROM':
										$nombre		= "PROM";
										$modif		= 0;
										$descripcion= 'PROMEDIO DE NOTAS';
										$activa		= 0;
										break;
									case 'PORC':
										$nombre		= "%";
										$modif		= 0;
										$descripcion= 'NOTA PORCENTUAL';
										$activa		= 0;
										break;
									default:
										$nombre		= strlen($value['abrev']) > 0 ? $value['abrev'] : 
										'#'.$value['row_num'];
										$modif		= strlen($value['descripcion']) > 0 ? $value['modificable'] : 1;
										$descripcion= strlen($value['descripcion']) > 0 ? $value['descripcion'].' '.
										$value['porciento'].' %' : 
										'Nota académica';
										$activa		= 1;
										break;
								}
								$cinsert = $cinsert."('".$this->get_id_school()."','".$curso.
								"','".$value['id']."','".$nombre."','".$descripcion."','".$value['porciento'].
								"','".$periodo."','".$modif."','".$activa."'),";								
							}
							$ainsert = substr($cinsert, 0, strlen($cinsert)-1);											
							$this->trans_start();
							$cinsert = "INSERT IGNORE INTO ".$db.".`config_columns_theacher` (`id_inst`,`id_curso`,`id_column`,
										`nombre`,`descripcion`,`porcentual`,`periodo`,`modificable`,`activa`) VALUES ".
										$ainsert;							
							$this->db->query($cinsert);							
							$this->trans_complete();			
																	
							if ( $this->trans_status()){												
								$request	= TRUE;
							}else{
								$request	= $this->get_error();
							}	
													
						}					
										
					}					
					$queryc	=  "SELECT t.*, CONCAT('n',t1.numero_column) AS name_column, t1.id_competencia,
								t1.tipo, t1.porciento, 
								CONCAT(t2.id_pk,'- ',t2.competencia) AS grupo, te.nombre des_evaluacion, 
								te.auto_calificar 
								FROM ".$db.".config_columns_theacher t 
								LEFT JOIN ".$db.".columnas_notas_competencias AS t1 ON t.id_column = t1.id
								LEFT JOIN ".$db.".competencias AS t2 ON t1.id_competencia = t2.id_pk
								LEFT JOIN ".$db.".grados_agrupados AS t3 ON t2.id_grado_agrupado = t3.id
								LEFT JOIN ".$db.".aux_grados_agrupados AS t4 ON t4.id_grado_agrupado = t3.id
								LEFT JOIN ".$db.".te_evaluation_courses tc ON tc.column_note_id = t.id 
								LEFT JOIN ".$db.".te_evaluations te ON (tc.evaluation_id = te.id AND tc.course_id = t.id_curso)
								WHERE t.id_curso = ".$curso." AND t.periodo ='".$periodo.
								"' AND t2.year = ".$this->get_year()." 
								AND t4.id_grado = ".$grado." 
								ORDER BY t1.id_competencia,t1.tipo, t1.numero_column";
			
					$request	= $this->get_query($this->limit_min, $this->limit_max, $queryc);
				}else{
					$request = $this->get_error();
				}
				
			}else{
				$request	= $this->get_error();
			}
		}
		
		return $request;
	}	
	
}