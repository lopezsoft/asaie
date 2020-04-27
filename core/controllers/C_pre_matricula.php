<?php
defined('BASEPATH') OR exit('No direct script access allowed');
class C_pre_matricula extends SME_Controller {
	function __construct() {
		parent::__construct();
		$this->load->model('M_pre_matricula');
	}
	
	public function get_select_nuevos(){
		echo $this->M_pre_matricula->get_select_nuevos();
	}
	
	public function prematricula(){
		$nro_doc_id      = $this->input->post_get('nro_doc_id');
        $cod_doc         = $this->input->post_get('cod_doc');
        $dpto_lug_exp    = $this->input->post_get('dpto_lug_exp');
        $mun_lug_exp     = $this->input->post_get('mun_lug_exp');
        $apellido1       = $this->input->post_get('apellido1');
        $apellido2       = $this->input->post_get('apellido2');
        $nombre1         = $this->input->post_get('nombre1');
        $nombre2         = $this->input->post_get('nombre2');
        $tipo_sangre     = $this->input->post_get('tipo_sangre');
        $sexo            = $this->input->post_get('sexo');
        $fecha_nacimiento = $this->input->post_get('fecha_nacimiento');
        $dpto_lug_nac    = $this->input->post_get('dpto_lug_nac');
        $mun_lug_nac     = $this->input->post_get('mun_lug_nac');
        $estrato         = $this->input->post_get('estrato');
        $sisben          = $this->input->post_get('sisben');
        $nro_sisben      = $this->input->post_get('nro_sisben');
        $puntaje_sisben  = $this->input->post_get('puntaje_sisben');
        $cab_familia     = $this->input->post_get('cab_familia');
        $ben_mad_flia    = $this->input->post_get('ben_mad_flia');
        $ben_vet_fp      = $this->input->post_get('ben_vet_fp');
        $ben_her_nan     = $this->input->post_get('ben_her_nan');
        $cod_eps         = $this->input->post_get('id_eps');
        $IPS             = $this->input->post_get('IPS');
        $direccion       = $this->input->post_get('direccion');
        $telefono        = $this->input->post_get('telefono');
        $dpto_lug_res    = $this->input->post_get('dpto_lug_res');
        $mun_lug_res     = $this->input->post_get('mun_lug_res');
        $id_zona         = $this->input->post_get('id_zona');
        $dpto_lug_pobl   = $this->input->post_get('dpto_lug_pobl');
        $mun_lug_pobl    = $this->input->post_get('mun_lug_pobl');
        $proviene_sector_priv = $this->input->post_get('proviene_sector_priv');
        $proviene_otro_mun = $this->input->post_get('proviene_otro_mun');
        $tipo_discapacidad = $this->input->post_get('tipo_discapacidad');
        $cap_exc           = $this->input->post_get('cap_exc');
        $cod_etnia         = $this->input->post_get('cod_etnia');
        $cod_resgua        = $this->input->post_get('cod_resgua');
        $cod_flia_accion   = $this->input->post_get('cod_flia_accion');
        $pob_vict_conf     = $this->input->post_get('pob_vict_conf');
        $e_mail     	   = $this->input->post_get('e_mail');
        // Matricula
        $id_sede           = $this->input->post_get('id_sede');
        $cod_grado         = $this->input->post_get('id_grado');
        $grupo             = $this->input->post_get('grupo');
        $repite            = $this->input->post_get('repite');
        $año           	   = $this->input->post_get('año');
        $ins_proced        = $this->input->post_get('ins_proced');
        $fileCC  		   = $_FILES['doc_cc'];
        $fileOBS  		   = $_FILES['doc_obs'];
        $id_inst		   = $this->M_pre_matricula->id_inst_pre_mat();
        $sqlInsert	= "INSERT INTO inscripciones (apellido1,apellido2,ben_her_nan,ben_mad_flia,ben_vet_fp,cab_familia,
        				cap_exc,cod_doc,id_eps,cod_etnia,cod_flia_accion,cod_resgua,direccion,dpto_lug_exp,
        				dpto_lug_nac,dpto_lug_pobl,dpto_lug_res,mun_lug_exp,mun_lug_nac,mun_lug_pobl,mun_lug_res,
        				nombre1,nombre2,sexo,sisben,nro_doc_id,nro_sisben,tipo_sangre,tipo_discapacidad,
        				id_inst,id_zona,IPS,telefono,estrato,fecha_nacimiento,puntaje_sisben,proviene_sector_priv,
        				pob_vict_conf,proviene_otro_mun,e_mail) VALUES('".
        				$apellido1."','".$apellido2."','".$ben_her_nan."','".$ben_mad_flia."','".$ben_vet_fp
        				."','".$cab_familia."','".$cap_exc."','".$cod_doc."','".$cod_eps."','".$cod_etnia.
        				"','".$cod_flia_accion."','".$cod_resgua."','".$direccion."','".$dpto_lug_exp.
        				"','".$dpto_lug_nac."','".$dpto_lug_pobl."','".$dpto_lug_res."','".$mun_lug_exp.
        				"','".$mun_lug_nac."','".$mun_lug_pobl."','".$mun_lug_res."','".$nombre1."','".
        				$nombre2."','".$sexo."','".$sisben."','".$nro_doc_id."','".$nro_sisben."','".
        				$tipo_sangre."','".$tipo_discapacidad."','".$id_inst."','".$id_zona."','".$IPS.
        				"','".$telefono."','".$estrato."','".$fecha_nacimiento."','".$puntaje_sisben.
        				"','".$proviene_sector_priv."','".$pob_vict_conf."','".$proviene_otro_mun."','".$e_mail."')";
		echo $this->M_pre_matricula->get_prematricula($id_inst,$id_sede,$cod_grado,$grupo,$repite,$año,
		$ins_proced,$fileCC,$fileOBS,$sqlInsert);
	}
}