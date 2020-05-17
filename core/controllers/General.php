<?php  defined('BASEPATH') OR exit('No direct script access allowed');

class General extends SME_Controller {
	function __construct() {
		parent::__construct();
		$this->load->model('M_general');
		$this->load->model('M_generate_libro_final');
		$this->check_session_redirect();
	}

	function readSchoolLogo(){
		echo $this->M_general->readSchoolLogo();
	}
	
	function uploadSchoolLogo(){
		$file  = $_FILES['foto'];
		echo $this->M_general->uploadSchoolLogo($file);
	}

	function get_select_cons_cert() {
		$tb		= $this->input->post_get('pdbTable');
		$tp		= $this->input->post_get('pdbType');
		echo 	$this->M_general->select_cons_cert($tb, $tp);
	}	

	function get_select_jornadas() {
		$sede		= $this->input->get_post('pdbSede');
		echo $this->M_general->get_select_jornadas($sede);	
	}	
	
	function get_countries(){
		$query		= $this->input->get_post('query');
		echo $this->M_general->get_countries($query);	
	}
	
	function get_select_niveles_sedes(){
		$sede	= $this->input->get_post('sede');
		echo $this->M_general->get_select_niveles_sedes($sede);
	}
	
	function get_select_jorn_sedes(){
		$sede	= $this->input->get_post('sede');	
		echo $this->M_general->get_select_jorn_sedes($sede);	
	}
	
	function get_select_com_grado(){
		$grado	= $this->input->post_get('pdbGrado');
		echo $this->M_general->select_com_grado($grado);
	}
	
	function get_config_db(){
		$grado	= $this->input->post_get('pdbGrado');
		echo $this->M_general->config_db($grado);
	}
	
	function get_matricular_antiguos(){
		$grado 	= $this->input->get_post('pdbGrado');
		$grupo 	= $this->input->get_post('pdbGrupo');
		$jorn 	= $this->input->get_post('pdbJorn');
		$sede 	= $this->input->get_post('pdbSede');
		$list	= $this->input->get_post('pdbList');
		echo $this->M_general->matricular_antiguos($grado,$grupo,$jorn,$sede,$list);
	}
	
	function get_select_columnas_notas_competencias(){
		$id	= $this->input->post_get('pdbId');
		echo $this->M_general->select_columnas_notas_competencias($id);
	}

	
	function get_escala_notas(){
		echo $this->M_general->get_select_escala_notas();
	}
	
	
	
	function get_aux_grados_agrupados(){
		$id	= $this->input->post_get('pdbIdGradoAgrupado');
		echo $this->M_general->get_select_aux_grados_agrupados($id);
	}
		
	function get_select_proycupos(){
		echo $this->M_general->select_proycupos();
	}
	
	function get_generate_sabanas(){
		$grado = $this->input->get_post('pdbGrado');
		$grupo = $this->input->get_post('pdbGrupo');
		$jorn  = $this->input->get_post('pdbJorn');
		$sede  = $this->input->get_post('pdbSede');
		$all   = $this->input->get_post('pdbAll');
		echo $this->M_generate_libro_final->generate_sabanas($grado,$grupo,$jorn,$sede,$all);
	}
		
	function get_borrar_cerros(){
		echo $this->M_general->borrar_cerros();
	}
	
	function read_images_signature(){
		echo $this->M_general->read_images_signature();
	}
	
	function upload_foto_signature(){
		$file  = $_FILES['foto'];
		echo $this->M_general->upload_foto_signature($file);
	}
	
	function read_images(){
		echo $this->M_general->read_images();
	}
	
	function upload_foto(){
		$file  = $_FILES['foto'];
		echo $this->M_general->upload_foto($file);
	}
	
	function get_select_promovidos_detalle(){
		$grado 	= $this->input->get_post('pdbGrado');
		$est 	= $this->input->get_post('pdbEst');
		$sede 	= $this->input->get_post('pdbSede');
		echo $this->M_general->select_promovidos_detalle($grado,$sede,$est);
	}
	
	function get_select_promovidos(){
		echo $this->M_general->select_promovidos();
	}
	
	function get_promover_estudiantes(){
		$grado 		= $this->input->get_post('pdbGrado');
		$grupo 		= $this->input->get_post('pdbGrupo');
		$jorn 		= $this->input->get_post('pdbJorn');
		$sede 		= $this->input->get_post('pdbSede');
		$gradoMove	= $this->input->get_post('pdbGradoMove');
		$list		= $this->input->get_post('pdbList');
		echo $this->M_general->promover_estudiantes($grado,$grupo,$jorn,$sede,$gradoMove,$list);
	}
	
	function get_select_acta_prom_est(){
		$matric	= $this->input->post_get('pdbMatric');
		echo $this->M_general->get_select_acta_prom_est($matric);
	}
	
	function get_select_matriculados() {
		$cod_grado	= $this->input->get_post('pdbCodGrado');
		$grupo		= $this->input->get_post('pdbGrupo');
		$sede		= $this->input->get_post('pdbSede');
		$jornada	= $this->input->get_post('pdbJorn');

		echo $this->M_general->get_select_matriculados($cod_grado,$grupo,$sede,$jornada);
	}
	
	public  function upload_foto_proy() {
		$file  = $_FILES['foto'];
		echo $this->M_general->upload_foto_proy($file);
	}
	
	function read_images_proy(){
		echo $this->M_general->read_images_proy();
	}
	
	function get_select_criterios_aspectos_observador(){
		$type	= $this->input->get_post('pdbType');
		echo $this->M_general->get_select_criterios_aspectos_observador($type);
	}
	
	function get_select_aspectos_observador(){
		$type	= $this->input->get_post('pdbType');
		echo $this->M_general->get_select_aspectos_observador($type);
	}
	
	function get_select_cuerpo_observador(){
		$type	= $this->input->get_post('pdbType');
		echo $this->M_general->get_select_cuerpo_observador($type);
	}
	
	
	function get_select_competencias(){
		$type	= $this->input->get_post('pdbType');
		echo $this->M_general->get_select_competencias($type);
	}
	
	function get_select_acta_promocion() {
		$cod_grado	= $this->input->get_post('pdbCodGrado');
		$grupo		= $this->input->get_post('pdbGrupo');
		$sede		= $this->input->get_post('pdbSede');
		$jornada	= $this->input->get_post('pdbJorn');
		$año		= $this->input->get_post('pdbYear');
		echo $this->M_general->get_select_acta_promocion($cod_grado,$grupo,$sede,$jornada,$año);
	}
	
	function get_select_matricula_antiguos() {
		$cod_grado	= $this->input->get_post('pdbCodGrado');
		$grupo		= $this->input->get_post('pdbGrupo');
		$sede		= $this->input->get_post('pdbSede');
		$jornada	= $this->input->get_post('pdbJorn');
		$a			= $this->input->get_post('pdbYear');
		echo $this->M_general->get_select_matricula_antiguos($cod_grado,$grupo,$sede,$jornada,$a);
	}
	
	function change_year (){
		$y	= $this->input->get('pYear');
		echo $this->M_general->change_year($y);	
	}
	
	function get_tipo_discapacidad(){
		echo $this->M_general->get_tipo_discapacidad();
	}
		
	function get_poblacion_victima_conflicto(){
		echo $this->M_general->get_poblacion_victima_conflicto();
	}
	
	function get_Capacidades_excepcionales(){
		echo $this->M_general->get_Capacidades_excepcionales();
	}
	
	function get_zona(){
		echo $this->M_general->get_zona();
	}
	
	function get_eps(){
		echo $this->M_general->get_eps();
	}
	
	function get_departamentos(){
		$query = $this->input->get_post('query');
		echo $this->M_general->get_departamentos($query);
	}

    function get_ciudades()
    {
    	$query = $this->input->get_post('query');
    	$dpto	= $this->input->get_post('pDpto');
        echo $this->M_general->get_ciudades($dpto,$query);
    }

    public  function get_documentos(){
        echo $this->M_general->get_documentos();
    }
	
	function get_select_docentes() {
		$quer = $this->input->get_post('query');
		echo $this->M_general->get_select_docentes($quer);
	}
	
	function get_select_administrativos() {
		$query = $this->input->get_post('query');
		echo $this->M_general->get_select_administrativos($query);
	}
	
	function get_select_users() {
		$this->check_session_redirect();
		echo $this->M_general->get_user();
	}
	
	function get_jornadas() {
		echo $this->M_general->get_jornadas();
	}
	
	function get_grupos(){
		echo $this->M_general->get_grupos();
	}
	
	function get_select_estudiantes () {
		$grado		= $this->input->get_post('pdbGrado');
		$grupo		= $this->input->get_post('pdbGrupo');
		$sede		= $this->input->get_post('pdbSede');
		$jorn		= $this->input->get_post('pdbJorn');
		echo $this->M_general->get_select_estudiantes($grado,$grupo,$sede,$jorn);
	}
	
	function get_select_banco_cli () {
		$cod_grado	= $_GET['pdbCodGrado'];
		$id_asig	= $_GET['pdbIdAsig'];
		$type		= $_GET['pdbType'];
		$periodo	= $_GET['pdbPeriodo'];
		
		echo  $this->M_general->get_select_banco_cli($cod_grado,$id_asig,$periodo,$type);	
	}
	
	function get_select_asignaturas_banco () {
		echo  $this->M_general->get_select_asignaturas_banco();	
	}
	
	function get_select_all_id() {
		$query = $this->input->get_post('query');
		echo $this->M_general->get_select_all_id($_GET['pdbTable'],$query);
	}
	
	function get_select_all () {
		$query = $this->input->get_post('query');
		echo $this->M_general->get_select_all($_GET['pdbTable'],$query);
	}
	
	function get_select_id() {
		$query = $this->input->get_post('query');
		echo $this->M_general->get_select_id($_GET['pdbTable'],$query);
	}
	
	function get_select () {
		$tb		= $this->input->get_post('pdbTable');
		$fields	= $this->input->get_post('fields');
		$query	= $this->input->get_post('query');
		echo $this->M_general->get_select($tb,$fields,$query);
	}
	
	function insert_data () {
		$extra	= array (
			// 'id_inst'		=> $this->M_general->id_inst,
			// 'id_docente'	=> $this->M_general->id_docente,
			// 'año'			=> $this->M_general->año_lectivo
		);		
		$list = json_decode($_POST['records']);				
		echo $this->M_general->insert_data_primary($this->input->post_get('pdbTable'),$list);
	}
	
	function insert_data_id() {
		$extra	= array (
			'id_inst'		=> $this->M_general->id_inst
		);
		
		$list = json_decode($_POST['records']);
				
		echo $this->M_general->insert_data_primary($_POST['pdbTable'],$list,$extra);
	}
	
	function update_data () {
		$list 	= $this->input->post_get('records');
		$table	= $this->input->post_get('pdbTable');
		echo $this->M_general->update_data_primary($table,$list);
	}
	
	function delete_data_extra() {
		$extra = array(
				'año'			=> $this->M_general->año_lectivo,
				'id_inst'		=> $this->M_general->id_inst
		);
		echo $this->M_general->delete_data_extra($_POST['pdbTable'],$_POST['records'],$extra);
	}
	
	function delete_data () {
		echo $this->M_general->delete_data($_POST['pdbTable'],$_POST['records']);
	}
		
	/**
	* Funcion que elimina los archivos del servidor
	* 
	* @return
	*/
	function delete_file() {
		$list = json_decode($this->input->get_post('records'));
		$path_delete =$list->path_delete;
		echo $this->M_general->delete_file($path_delete);
	}
}