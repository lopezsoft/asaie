<?php
defined('BASEPATH') OR exit('No direct script access allowed');
class M_funciones extends CI_Model {
	
	public function __construct() 
	{
		parent::__construct();
	}
	
	/**
	* Función para numeros correlativos
	* @param String $num, la cadena de entrada (obligatorio).
	* @param String $length  default "000000", longitud del correlativo (opcional).
	* 
	* @return $result El correlativo del numero pasado
	*/
	public function correlativo ($num = '', $length = "000000") {
		$long = strlen($length);
		if ($num == '') {
			$result = NULL;
		}else{
			$numer = strlen($num);
			
			$result = substr($length, $numer, $long-$numer);
			
			$result  = $result.$num;
		}
		
		return $result;
	}
}
/* End of file M_sql.php */
/* Location: ./application/models/M_funciones.php */