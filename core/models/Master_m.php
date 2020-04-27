<?php
defined('BASEPATH') or exit('No direct script access allowed');
class Master_m extends SME_Model
{

	public function __construct()
	{
		parent::__construct();
	}
	
	function getEstadoFinalEstudiante()
	{
		$db         = $this->get_db_name();
		$this->db->select('a.*, b.nombre_grado_agrupado');
		$this->db->from($db . '.estado_estudiante a ');
		$this->db->join($db . '.grados_agrupados AS b', 'a.id_grupo_grados = b.id', 'left');

		$query	= $this->db->get();
		return $this->getJsonResponse($query->result(), $query->num_rows());
	}

	function getPromotionAreas($id)
	{
		$db         = $this->get_db_name();
		$this->db->select('a.*, b.year, c.area');
		$this->db->from($db . '.promotion_areas AS a');
		$this->db->join($db . '.config001 AS b', 'a.config_id = b.id', 'left');
		$this->db->join($db . '.areas as c', 'a.area_id = c.id', 'left');
		$this->db->where('b.id', $id);

		$query	= $this->db->get();
		return $this->getJsonResponse($query->result(), $query->num_rows());
	}

	function getGeneralConfig()
	{
		$db         = $this->get_db_name();
		$query	= "SELECT t1.*, t2.nombre_grado_agrupado FROM " . $db . ".config001 AS t1 
			LEFT JOIN " . $db . ".grados_agrupados As t2 ON t1.id_grupo_grados = t2.id
			WHERE t1.year =" . $this->get_year();

		$query = $this->db->query($query);

		return $this->getJsonResponse($query->result(), $query->num_rows());
	}

	function getGroupDirectorByGrade($grade)
	{
		$fun	= "sp_select_group_dir_grade ( ?, ? )";
		$param	= array($this->get_year(), $grade);
		return $this->getExecute($fun, $param);
	}

	function getSelectGrades($query, $headq)
	{
		$db	= $this->get_db_name();
		$extra	= '';
		if (!empty($query)) {
			$table	= $db . '.grados';
			$fiels_table = $this->db->field_data($table);
			foreach ($fiels_table as $field_compare) {
				$name 			= $field_compare->name;
				$primary_key 	= $field_compare->primary_key;
				if ($primary_key == 0) { // Si no es una llave primaria
					$extra  = $name . " REGEXP '" . $query . "'";
					$sql 	= "SELECT " . $name . " FROM " . $table . " WHERE " . $extra . " LIMIT 1";
					$sql	= $this->db->query($sql);
					if ($sql->num_rows() > 0) {
						break;
					}
				}
			}
		}
		$this->db->select('tg.*, t2.nombre_nivel');
		$this->db->from($db . '.grados AS tg');
		$this->db->join($db . '.niveles_estudio AS t2', 'tg.id_nivel = t2.id', 'left');
		if (!empty($headq)) {
			$this->db->join($db . '.niveles_sedes AS tn', 'tg.id_nivel = tn.id_nivel', 'left');
			$this->db->where('tn.id_sede', $headq);
		}
		if (!empty($extra)) {
			$this->db->where($extra);
		}
		$this->db->limit($this->limit_max, $this->limit_min);
		$this->db->order_by('tg.cod_grado');
		$qry	= $this->db->get();
		if ($qry) {
			$total	= $this->get_count_all('grados');
			$result	= $this->get_request_select($qry->result_array(), $total);
		} else {
			$result	= $this->get_error();
		}

		return $result;
	}

	function getSelectAdmin($query, $start, $limit)
	{
		$db		= $this->get_db_name();

		$querySelect = "SELECT *," .
			"CONCAT(RTRIM(apellido1),' ',RTRIM(apellido2),' ',RTRIM(nombre1),' ',RTRIM(nombre2)) AS admin 
					FROM " . $db . ".administrativos";
		$queryCount = "SELECT COUNT(id) AS total FROM " . $db . ".administrativos";

		$fieldSearch	= array('numero_documento', 'apellido1', 'apellido2', 'nombre1', 'nombre2');
		return $this->getQuery($queryCount, $querySelect, $start, $limit, $query, $fieldSearch, [], 'admin');
	}

	function insertTeachers($table, $records, $primaryKey, $serial)
	{
		$result = '';
		$extra = null;
		$db         = $this->get_db_name();
		$id_d = $this->insertData('docentes', $records, $primaryKey, $serial, TRUE);

		if ($id_d) {
			$result = '';
			$year	= $this->get_year();
			$aux	= array(
				'id_docente'	=> $id_d,
				'year'			=> $year
			);
			$this->db->insert($db . '.aux_docentes', $aux);
			$where	= array("id_docente" 	=>		$id_d);
			$result = $this->getTable('docentes', 0, 1, '', $where);
		} else {
			$result = $this->get_error();
		};

		return $result;
	}

	function getSelectTeachers($query, $start, $limit)
	{
		$db		= $this->get_db_name();

		$querySelect = "SELECT *," .
			"CONCAT(RTRIM(apellido1),' ',RTRIM(apellido2),' ',RTRIM(nombre1),' ',RTRIM(nombre2)) AS docente 
					  FROM " . $db . ".docentes";
		$queryCount = "SELECT COUNT(id_docente) AS total FROM " . $db . ".docentes";

		$fieldSearch	= array('documento', 'apellido1', 'apellido2', 'nombre1', 'nombre2');
		return $this->getQuery($queryCount, $querySelect, $start, $limit, $query, $fieldSearch, [], 'docente');
	}
}



/* End of file M_login.php */
/* Location: ./application/models/M_login.php */
