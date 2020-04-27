<?php
defined('BASEPATH') OR exit('No direct script access allowed');
class C_sql extends SME_Controller 
{
	
	public function __construct() 
	{
		parent::__construct();		
	  	$this->load->model('M_login');
	  	$this->load->model('M_carga');
	  	$this->load->model('M_docentes');
	  	$this->load->model('M_notas');
	  	$this->load->model('M_logros');
	  	$this->load->model('M_parcelador');
	  	$this->load->model('M_sql');
	  	
	  	date_default_timezone_set("America/Bogota");
		$this->check_session_redirect();
	}
	
	public function db_docente () {
		$curso	 = $this->input->get_post('pdbCurso');
		$grado	 = $this->input->get_post('pdbGrado');
		$grupo	 = $this->input->get_post('pdbGrupo');
		$periodo = $this->input->get_post('pdbPeriodo')	;
		$request	= $this->M_docentes->get_docentes($curso,$grupo,$grado,$periodo);
		echo $request;
	}
	
	public function db_docente_u () {
				
		$fieldslist = $this->input->get_post('fieldlist');
		$fieldslist	= json_decode($fieldslist);
		$request	= $this->M_docentes->get_docentes_up($fieldslist);
		
		echo $request;						
	}
	
	/**
	* Funcion que retorna la lista de los estudiantes de un curso
	* 
	* @return
	*/
	
	public function get_estudiantes () {
		$this->db_limit();
		
		$cod_grado 	= $_GET['pCod_Grado'];
		$grupo 		= $_GET['pGrupo'];
		$cod_jorn 	= $_GET['pCod_Jorn'];
		$id_sede 	= $_GET['pCons_Sede'];
		
		$param = array(
			$this->get_id_school(),
			$cod_grado,
			$grupo,
			$cod_jorn,
			$id_sede,
			$this->get_year()		
		);
		
		$query	= "SELECT te.cod_est, 
				CONCAT(RTRIM(te.apellido1),' ',RTRIM(te.apellido2),' ',RTRIM(te.nombre1),' ',RTRIM(te.nombre2)) AS nombres, 
				tm.cod_grado, UPPER(tg.grado) AS grado, tm.id_jorn, tj.jornada, tm.id_sede, ts.nom_sede ".
				"AS sede, tm.año, tm.grupo, tm.estado FROM inscripciones AS te LEFT JOIN matriculas AS tm ON tm.cod_est=te.cod_est 
				LEFT JOIN grados AS tg ON tg.cod_grado=tm.cod_grado LEFT JOIN jornadas AS tj ON ".
				"tm.id_jorn=tj.cod_jorn LEFT JOIN sedes AS ts ON tm.id_sede=ts.id ";
				  
		$where  = "te.id_inst= ? AND tm.cod_grado= ? AND tm.grupo= ? AND tm.id_jorn= ? 
					AND tm.id_sede= ? AND tm.año= ? ORDER BY nombres";
					
		$request = $this->M_sql->get_query_param($this->limit_min,$this->limit_max,$query,$where,$param,"",FALSE);
		
		echo $request;
		 
	}	
	
	/** 
	* Funcion que retorna el listado de la carga académica del docente en sesion
	*/
	
			
	public function get_carga_grupo () 
	{
		$limit_min =(isset($_GET['start'])?$_GET['start']:"0");
		$limit_max = (isset($_GET['limit'])?$_GET['limit']:"25");
		
		$query = "SELECT tm.cod_grado, UPPER(tg.grado) AS grado, tm.grupo, 
			tm.id_sede, TRIM(ts.nom_sede) AS sede , tm.cod_jorn, TRIM(tj.jornada) AS jornada, tm.id_docente, tm.año  
			FROM cursos as tm, grados as tg, sedes as ts, jornadas as tj ";
			
		$where = " tm.cod_grado=tg.cod_grado 
			AND	tm.id_sede=ts.id AND tm.estado=1 AND tm.cod_jorn=tj.cod_jorn AND 
			tm.id_docente= ? AND tm.año= ?  AND tm.id_inst= ? AND ts.id_inst= ? 
			 GROUP BY tm.cod_grado, tm.grupo, tm.cod_jorn, tm.id_docente, tm.año ";
			
		
		$id_docente		= $this->id_docente;
		$id_inst 		= $this->get_id_school();
		$año			= $this->get_year();
			
		$param = array(
			$id_docente,
			$año,
			$id_inst,
			$id_inst
		);	
		
		$db_return = $this->M_sql->get_query_param($limit_min,$limit_max,$query,$where,$param,"",FALSE);
		echo $db_return;
	}	
	
	public function get_carga_academica_agrupada_observador(){
		$db_return = $this->M_carga->get_carga_academica_agrupada_observador();
		echo $db_return;
	}
	
	public function get_carga_academica () 
	{
		$query = $this->input->get_post('query');
		$db_return = $this->M_carga->get_carga_academica($query);		
		echo $db_return;
	}
	
	public function get_carga_academica_agrupada () 
	{
		$db_return = $this->M_carga->get_carga_academica_agrupada();
		echo $db_return;
	}
		
	/** 
	* Funcion que retorna el listado del banco de logros de desempeño
	*/
	public function get_banco_logros () 
	{
		$limit_min = (isset($_GET['start'])?$_GET['start']:"0");
		$limit_max = (isset($_GET['limit'])?$_GET['limit']:"25");
		
		if (isset($_GET['pdbCodGrado']) AND isset($_GET['pdbIdAsig'])) 
		{
			
			$query = "SELECT tl.id, tl.id_logro, tl.cod_grado, UPPER(tg.grado) AS grado, tl.id_asig , TRIM(ta.des_Asign) as asignatura, 
				tl.periodo, tl.logro, tl.año FROM banco_logros as tl, grados as tg, asignaturas as ta ";
			
			$where = "tl.cod_grado=tg.cod_grado AND tl.id_asig=ta.cod_Asign AND ta.año= ? AND tl.año= ? 
				AND tl.id_inst= ? AND tl.id_asig= ? AND tl.cod_grado= ? AND ta.id_inst= ? ";
			
			
			$db_cod_grado = $_GET['pdbCodGrado'];
			$db_id_asig	  = $_GET['pdbIdAsig'];

			$id_inst 		= $this->get_id_school();
			$año			= $this->get_year()-1;
				
			$param = array(
					$año,
					$año,
					$id_inst,
					$db_id_asig,
					$db_cod_grado,
					$id_inst
				);
		
			$db_return = $this->M_sql->get_query_param($limit_min,$limit_max,$query,$where,$param);
			echo $db_return;
			
		} else {
			echo $this->M_sql->get_error()	;
		}		
	}

	/** 
	* Funcion que retorna el listado del banco de indicadores de desempeño
	*/
	public function get_banco_indicadores () 
	{
		$this->db_limit();
		
		if (isset($_GET['pdbCodGrado']) AND isset($_GET['pdbIdAsig'])) 
		{
			$query = "SELECT ti.id, ti.id_logro, id_indicador, ti.cod_grado, UPPER(tg.grado) AS grado, ti.id_asig , 
				TRIM(ta.des_Asign) as asignatura, 
				ti.periodo, ti.indicador, ti.año FROM banco_indicadores as ti, grados as tg, asignaturas as ta ";
			
			$where= "ti.cod_grado=tg.cod_grado AND ti.id_asig=ta.cod_Asign AND ta.año= ? 
				AND ti.año= ? AND ti.id_inst= ? AND ti.id_asig= ? AND ti.cod_grado= ? AND ta.id_inst= ?";
			
			$db_cod_grado = $_GET['pdbCodGrado'];
			$db_id_asig	  = $_GET['pdbIdAsig'];
		
			$id_inst 		= $this->get_id_school();
			$año			= $this->get_year()-1;
				
			$param = array(
					$año,
					$año,
					$id_inst,
					$db_id_asig,
					$db_cod_grado,
					$id_inst
				);
		
			$db_return = $this->M_sql->get_query_param($this->limit_min,$this->limit_max,$query,$where,$param);
			echo $db_return;
			
		} else {
			echo $this->M_sql->get_error()	;
		}		
	}
		
	/** 
	* Funcion que retorna el numero de periodos académicos a trabajar
	*/
	public function	get_periodos()
	{
		$grado = $this->input->get_post('pdbGrado');
		$type  = $this->input->get_post('pdbType');
		echo $this->M_sql->get_periodos($grado,$type);
	}
	
	/** 
	* Funcion que retorna el listado de los grados académicos
	*/
	public function get_matcursos () 
	{
		echo $this->M_parcelador->get_select_matcursos($this->input->post_get('pdbGrado'));		
	}
		
	/**
	* Funcion para la tabla metodologias
	* 
	* @return
	*/
	
	public function get_metodologias ()
	{
		$limit_min = (isset($_GET['start'])?$_GET['start']:"0");
		$limit_max = (isset($_GET['limit'])?$_GET['limit']:"25");
		
		$query = "SELECT COD_METOD AS cod_metod, UPPER(RTRIM(METODOLOG)) AS metodolog FROM metodologias";
		
		$db_return = $this->M_sql->get_query($limit_min,$limit_max,$query,FALSE);
		echo $db_return;
	}
	
	/**
	* Funcion para la tabla sedes
	* 
	* @return
	*/	
	public function get_sedes ()
	{
		$request = $this->M_notas->get_select_sedes();
		echo $request;
	}
				
	/**
	* Funcion para la tabla Dimensiones
	* 
	* @return
	*/
	function get_competencias () {						
		$request	= $this->M_notas->competencias($this->input->post_get('idGrado'));
		echo $request;		
	}
	
	/**
	* Funcion para la consulta a la tabla valnotas
	* 
	* @return
	*/
	public function get_desemp ()
	{
						
		echo $this->M_notas->get_select_desempeños();
		
	}
			
	public	function get_password () {
		$newpass  = $_POST['newpass'];
		$xuser	  = $_POST['user'];
		$yuser 	  = $this->session->userdata('user_pass');
		
		if ($xuser == $yuser) {
			$query = "UPDATE docentes SET pasw= '".$newpass."' WHERE id_docente= '".$this->id_docente."'";
						
			$query = $this->db->query($query);
			
			if ($query){
				$request = $this->M_sql->get_request_ab();
			}else{
				$request = $this->M_sql->get_error();
			}
		}else{
						
			$request = 'FALSE';
		}
			
		
		echo $request;
	}
	
			
	public function control_date_msg () {
		$date	= date('Y-m-d');
		$reuqest = array(
				'success'	=> FALSE,
				'request'   => 'Se ha vencido la fecha del periodo',
				'fecha'		=> $date
			);
			
		return json_encode($reuqest);
	}

}


/* End of file C_sql.php */
/* Location: ./application/controllers/C_sql.php */
	