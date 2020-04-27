<?php 
	defined('BASEPATH') OR exit('No direct script access allowed');
	// Incluimos los archivos
    require_once "PHPExcel.php";
    require_once "PHPExcel/IOFactory.php";
    require_once 'PHPExcel/Shared/String.php';
class Excel extends PHPExcel {
	private $CI;
	var 
		$objReader,
		$fileXls,
		$objWriter;
	function __construct() {
		parent::__construct();
		$this->CI	=  &get_instance();
		PHPExcel_Shared_String::setDecimalSeparator(',');
		PHPExcel_Shared_String::setThousandsSeparator('.');
		$this->objReader= PHPExcel_IOFactory::createReader('Excel2007');
	}
	/**
	* Función para carga el archivo
	* @param string $file  Path del archivo
	* 
	* @return OBJECT
	*/	
	public function load_xls($file){
		$this->fileXls	= $file;
		return $this->objReader->load($this->fileXls);
	}
	/**
	* Función para escribir en una plantilla de excel y guardarla en la ruta especificada
	* @param STRING $file_out Path donde se guardará el archivo
	* @param OBJECT $objXls objeto donde se escribiran los valores
	* @return
	*/
	public function write_xls($file_out,$objXls){
		//Guardamos el archivo en formato Excel 2007
		$this->objWriter = PHPExcel_IOFactory::createWriter($objXls,'Excel2007');
		$$this->objWriter->save($file_out);
	}
}