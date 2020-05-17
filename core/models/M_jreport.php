
<?php
defined('BASEPATH') OR exit('No direct script access allowed');
require_once $_SERVER["DOCUMENT_ROOT"].'/globales/dbconstanst.php';
/**
 * PHP Jasper Report Utlis
 * 
 * PHP version 5
 * 
 * LICENSE
 *
 * PHP-JRU is free software; you can redistribute it and/or modify 
 * it under the terms of the GNU General Public License as published 
 * by the Free Software Foundation; either version 2 of the License, 
 * or (at your option) any later version.
 * 
 * PHP-JRU is distributed in the hope that it will be useful, 
 * but WITHOUT ANY WARRANTY; without even the implied warranty 
 * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  
 * See the GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License 
 * along with PHP-JRU; if not, write to the Free Software Foundation, Inc., 
 * 51 Franklin St, Fifth Floor, Boston, MA 0110-1301, USA
 *
 * @author    Robert Alexander Bruno Monterrey <robert.alexander.bruno@gmail.com>JdbcConnection
 * @license   http://www.gnu.org/licenses/old-licenses/gpl-2.0.txt GNU/GPL
 * @version   SVN:$id
 */

/* determina si esta habilitado la inclusion de url*/

// Se Cambio esta linea "http://localhost:8080/PHP-jru/java/Java.inc" por la que esta a continuacion:

ini_set("allow_url_include",1);

if(ini_get("allow_url_include")){
	require_once(URL_JAVA_BRIDGE);	
}elseif( ! function_exists('java_require')){
	echo 'necesita habilitar allow_url_include en php.ini para poder usar php-jru.';
} 


/**
 * @see JdbcConnection
 */
//require_once 'JdbcConnection.php';
/**
 * Clase para gestionar reportes de jasper report 
 *
 * @author    Robert Alexander Bruno Monterrey <robert.alexander.bruno@gmail.com>
 */  
class M_jreport extends SME_Model {
	
	/**
	 * Conexion jdbc
	 * 
	 * @var  $connection 
	 */
	private $connection = NULL;
	
	/**
	 * Driver jdbc de la conexion
	 * 
	 * @var  String $driver 
	 */
	 
	private $driver	= "com.mysql.jdbc.Driver";
	/**
	* Nombre de la base de datos para la conexion jdbc
	* @var String $db_database
	* 
	*/
	private $db_database	= 'dbasaieplus';
	/**
	 * string o url de la conexion jdbc 
	 * 
	 * @var  String $connection_string 
	 */
	private $connection_string	= "jdbc:mysql://localhost/";
	/**
	 * usuario de la conexion  jdbc
	 * 
	 * @var  String $user 
	 */
	private $db_username	= 'root';
	
	/**
	* Contraseña del usuario de la conexion jdbc
	* @var String $db_password
	* 
	*/
	private $db_password	= NULL;
	
	/*
	 *Indica si ya se han cargado las librerias jasperreport
	 *@deprecated
	 *@var boolean $librarysLoad 
	 */
	private  $librarysLoad;
	/**
	 *indica la ruta de las librerias de jaspertreport
	 *@deprecated
	 *@var $librarysPath
	 */
	private  $librarysPath;	
	
	/*
	 *Indica una conexion jdbc
	 *@var JdbcConnection  
	 */
	private $jdbc_connection;
	
	/**
	* 
	* @var nombre de los folders donde se guaran los informes en sus respectivos formatos
	* 	   Estas carpetas deben estar dentro del directorio donde tengamos los informes	
	*/
	public $dir_folder_pdf;
	public $dir_folder_doc; 
	public $dir_folder_csv; 
	public $dir_folder_txt; 
	public $dir_folder_pptx; 
	public $dir_folder_html;
	public $dir_folder_rtf;
	public $dir_folder_xls;
	public $path_report;
	public $path_report_put;
	
	/**
	* Cargamos la Libreia Jdbc_connection_class
	*/
	
	private	$url_java		= NULL;
	
	//Variables del informe
	public	$p_title		= 'TITULO DEL REPORTE';
 	public	$p_nit			= '';
	public	$p_footer		= 'Leyenda del reporte'; 
	public	$p_dane			= '';
	public 	$p_resol		= '';
	public	$p_img_left		= '';
	public 	$p_img_right	= '';
	public  $p_escudo;
	public  $p_marketing;
	public	$subreport_dir	= '';
	
	
	public function __construct() 
	{
		parent::__construct();
		require_once(URL_JAVA_BRIDGE);
		$this->dir_folder_pdf	= PDF_REPORT_DIRECTORY;
		$this->dir_folder_doc	= DOC_REPORT_DIRECTORY; 
		$this->dir_folder_csv	= CSV_REPORT_DIRECTORY; 
		$this->dir_folder_txt	= TXT_REPORT_DIRECTORY; 
		$this->dir_folder_pptx	= PPTX_REPORT_DIRECTORY; 
		$this->dir_folder_html 	= HTML_REPORT_DIRECTORY;
		$this->dir_folder_rtf 	= RTF_REPORT_DIRECTORY;
		$this->dir_folder_xls 	= XLS_REPORT_DIRECTORY;
		$this->driver			= "com.mysql.jdbc.Driver";
		$this->connection_string= "jdbc:mysql://localhost:".PORT.PATH_DELIM.$this->db_database.
			"?user=".$this->db_username."&"."password=".$this->db_password;

		
		$this->db_database		= $this->db->database;
		$this->db_username		= $this->db->username;
		$this->db_password		= $this->db->password;
		
		$this->load->model('M_parcelador');		
		$this->load->helper('download');	
		
		/**
		* 
		* @var Ruta Raiz donde están guardados los informes
		* 
		*/	
		$this->path_report	= $this->directory_path.PATH_DELIM.REPORT_DIRECTORY.PATH_DELIM;		
		$this->subreport_dir = $this->path_report;	  	
	  	/**
		  * 
		  * @$path_folders Ruta completa donde se guardarán los informes es sus respectivos formatos
		  * 
		  */
	  	$path_folders		= $this->directory_path.SCHOOL_DIRECTORY.PATH_DELIM.$this->get_school_folder().PATH_DELIM.REPORT_DIRECTORY.PATH_DELIM.EXPORT_FOLDER;	  	
	  	/**
		  * 
		  * @$set_folders Nombre de la carpeta donde se guardarán los informes, esta carpeta la creará el sistema 
		  * 
		  */
	  	$set_folders		= EXPORT_FOLDER;
	  	
	  	$delim				= PATH_DELIM;
	  		  		  	
	  	//Ruta de las imagenes del informe
	  	$this->p_img_right	= $this->directory_path.$delim.SCHOOL_DIRECTORY.$delim.$this->get_school_folder().
	  	$delim.'resources'.$delim.'img'.$delim.$this->logo_report;
	  	$this->p_img_left	= $this->directory_path.$delim.SCHOOL_DIRECTORY.$delim.$this->get_school_folder().
	  	$delim.'resources'.$delim.'img'.$delim.$this->school_logo;
	  	$this->p_escudo		= $this->directory_path.$delim.SCHOOL_DIRECTORY.$delim.$this->get_school_folder().
	  	$delim.'resources'.$delim.'img'.$delim.$this->shield;;
	  	
	  	// Creamos los directorios don se guardaran los documentos geenerados por el docente
	  	if (!is_dir($path_folders.PATH_DELIM.PDF_REPORT_DIRECTORY)){
			mkdir($path_folders.PATH_DELIM.PDF_REPORT_DIRECTORY, 0777, true);
		}
		
		if (!is_dir($path_folders.PATH_DELIM.DOC_REPORT_DIRECTORY)){
			mkdir($path_folders.PATH_DELIM.DOC_REPORT_DIRECTORY, 0777, true);
		}
		
		if (!is_dir($path_folders.PATH_DELIM.HTML_REPORT_DIRECTORY)){
			mkdir($path_folders.PATH_DELIM.HTML_REPORT_DIRECTORY, 0777, true);
		}
		
		if (!is_dir($path_folders.PATH_DELIM.CSV_REPORT_DIRECTORY)){
			mkdir($path_folders.PATH_DELIM.CSV_REPORT_DIRECTORY, 0777, true);
		}
		
		if (!is_dir($path_folders.PATH_DELIM.PPTX_REPORT_DIRECTORY)){
			mkdir($path_folders.PATH_DELIM.PPTX_REPORT_DIRECTORY, 0777, true);
		}		
		if (!is_dir($path_folders.PATH_DELIM.TXT_REPORT_DIRECTORY)){
			mkdir($path_folders.PATH_DELIM.TXT_REPORT_DIRECTORY, 0777, true);
		}		
		if (!is_dir($path_folders.PATH_DELIM.RTF_REPORT_DIRECTORY)){
			mkdir($path_folders.PATH_DELIM.RTF_REPORT_DIRECTORY, 0777, true);
		}		
		if (!is_dir($path_folders.PATH_DELIM.XLS_REPORT_DIRECTORY)){
			mkdir($path_folders.PATH_DELIM.XLS_REPORT_DIRECTORY, 0777, true);
		}				
		//Seteamos las rutas de los forlders	
		$this->dir_folder_pdf	= $set_folders.PATH_DELIM.PDF_REPORT_DIRECTORY;
		$this->dir_folder_doc	= $set_folders.PATH_DELIM.DOC_REPORT_DIRECTORY; 
		$this->dir_folder_csv	= $set_folders.PATH_DELIM.CSV_REPORT_DIRECTORY; 
		$this->dir_folder_txt	= $set_folders.PATH_DELIM.TXT_REPORT_DIRECTORY; 
		$this->dir_folder_pptx	= $set_folders.PATH_DELIM.PPTX_REPORT_DIRECTORY; 
		$this->dir_folder_html 	= $set_folders.PATH_DELIM.HTML_REPORT_DIRECTORY;
		$this->dir_folder_rtf 	= $set_folders.PATH_DELIM.RTF_REPORT_DIRECTORY;
		$this->dir_folder_xls 	= $set_folders.PATH_DELIM.XLS_REPORT_DIRECTORY;		
		/**
		 * Seteamos la ruta de salida del informe para mostrarlo en el IFRAME 
		 */
		$dir = SCHOOL_DIRECTORY.PATH_DELIM.$this->get_school_folder().PATH_DELIM.REPORT_DIRECTORY.PATH_DELIM;
		 $this->path_report_put	= base_url().$dir;
		 
		 /**
		 * Seteamos las variables del encabezado del reporte
		 * @var 
		 * 
		 */		 
		$this->set_report_params();	  
	}
	
	/**
	* Funcion que realiza la conexion al servidor 
	* 
	* @return $conn Numero de la conexion
	*/
	public function jdbc_connection () {
		$this->connection_string= "jdbc:mysql://localhost:".PORT.PATH_DELIM.$this->get_db_name().
			"?user=".$this->db_username."&"."password=".$this->db_password;
		$system = new JavaClass('java.lang.System');
 		$class = new JavaClass("java.lang.Class");
 		$class->forName($this->driver);
 		$driverManager = new JavaClass("java.sql.DriverManager");
 		$conn = $driverManager->getConnection($this->connection_string);
		$this->connection = $conn;
		return $conn;
	}
	/*
	 * obtienes conneccion a la base de datos
	 */
	public function getConnection(){
		return $this->connection->getconnection();	
	}
	/*
	 * Retorna el driver de la conexion jdbc
	 */
	public function getDriver(){
		return $this->driver;
	}
	/*
	 * Retorna el string de la conexion jdbc
	 */
	public function get_connect_string(){
		return $this->connection_string;
	}
	/*
	 * Retorna el usuario de la conexion jdbc
	 */
	public function get_user(){
		return $this->user;
	}
	/*
	 *retorna true cuando se han cargado las librerias de jasper report
	 *@deprecated 
	 *@return boolean  
	 */	
	public function is_librarys_load()
	{
		return $this->librarysLoad;	
	}
	 /**
	 * retorna la conexion jdbc
	 * 
	 * @return
	 */
	public function get_jdbc_connection()
	{
		return $this->jdbc_connection;
	}
	function close_connection(){
		$this->connection->close();
	}
	/*
	 * retorna la ruta de las librerias
	 * @deprecated 
	 * @return string ruta de la carpeta que contiene las  librerias 
	 */
	public function get_librarys_path()
	{
		return $this->librarysPath;
	}
	 /*
	 * Carga librerias java 
	 * @deprecated
	 * @param string path ruta de la carpeta que contiene las  librerias
	 */
 	public function load_dir_library($path)
 	{		
		$librarys = '';
				
	 	if(function_exists('java_require'))
	 	{ 	
			$handle = @opendir($path);
			
			while(($new_item = readdir($handle))!==false)
			{
 				$librarys .= 'file://'.$path.PATH_DELIM.$new_item .';';
			}		
			
			java_require($librarys);
			
			$this->librarysPath = $path;
			
			$this->librarysLoad = true;
	 	}else
	 	{
			$this->librarysLoad = false;
			
			echo 'No se ha cargado el M&oacute;dulo de Java';			
	 	}	
 	}
 	
	/**
	 * Genera un reporte  pdf, csv, html, txt, doc, pptx, rtf  
	 * 
	 * @param string $path_save_report url de la carpeta que contiene el reporte .jrxml
	 * @param string $name_report nombre del reporte .jrxml
	 * @param string $name_report_export nombre de salida del reporte
	 * @param java.util.HashMap $parameters parametros del reporte 
	 * @param JdbcConnection $conn conexcion jdbc
	 * @param String $format Formato de salida del documento
	 */
	public function export_report($path_save_report,$name_report, $name_report_export, $parameters, $conn, $format)
	{
		if(!isset($conn)){
			$conn = $this->get_jdbc_connection();
		}
		if(!isset($format)){
			$format = '.pdf';
		}
		$inputPrint			= $path_save_report.$name_report.'.jasper';
		$inputFileName 		= $path_save_report.$name_report.'.jrxml';
		$report_return		= '';
		$path_folders		= $this->directory_path.SCHOOL_DIRECTORY.PATH_DELIM.$this->get_school_folder().PATH_DELIM.REPORT_DIRECTORY.PATH_DELIM;	
		try {           
			//compilation
 			$compileManager = new JavaClass("net.sf.jasperreports.engine.JasperCompileManager");
 			$viewer = new JavaClass("net.sf.jasperreports.view.JasperViewer");
 			$report = $compileManager->compileReport($inputFileName);
 			// fill
 			$fillManager = new JavaClass("net.sf.jasperreports.engine.JasperFillManager");
 			$emptyDataSource = new Java("net.sf.jasperreports.engine.JREmptyDataSource");
 			$runmanager = new Java("net.sf.jasperreports.engine.JasperRunManager");
 			$jasperPrint = $fillManager->fillReport($report, $parameters, $conn);
			switch ($format) 
				{
					case 'pdf':
						$dir_forlser_expor 	= $path_folders.$this->dir_folder_pdf;
						if (is_dir($dir_forlser_expor)) {
							$outputPath = $dir_forlser_expor.PATH_DELIM.$name_report_export.".pdf";
							$report_return = $this->dir_folder_pdf.PATH_DELIM.$name_report_export.".pdf";		
							$exporter= new Java("net.sf.jasperreports.engine.export.JRPdfExporter");
							
							$exporter->setParameter(java("net.sf.jasperreports.engine.JRExporterParameter")->
							JASPER_PRINT,$jasperPrint);
							$exporter->setParameter(java("net.sf.jasperreports.engine.JRExporterParameter")->
							OUTPUT_FILE_NAME,$outputPath);
							$exporter->exportReport();
							$request	= TRUE;
						}else{
							echo 'NO EXISTE EL DIRECTORIO : '.strtoupper($dir_forlser_expor);
							$request	= FALSE;
						}
						break;
					case 'csv':
						$dir_forlser_expor 	=  $path_folders.$this->dir_folder_csv;
						if (is_dir($dir_forlser_expor)) {
							$outputPath = $dir_forlser_expor.PATH_DELIM.$name_report_export.".csv";
							$report_return = $this->dir_folder_csv.PATH_DELIM.$name_report_export.".csv";
							$exporter= new Java("net.sf.jasperreports.engine.export.JRCsvExporter");				
							$exporter->setParameter(java("net.sf.jasperreports.engine.JRExporterParameter")->
							JASPER_PRINT,$jasperPrint);
							$exporter->setParameter(java("net.sf.jasperreports.engine.JRExporterParameter")->
							OUTPUT_FILE_NAME,$outputPath);
							$exporter->exportReport();
							$request	= TRUE;
						}else{
							echo 'NO EXISTE EL DIRECTORIO : '.strtoupper($dir_forlser_expor);
							$request	= FALSE;
						}
						break;
					case 'txt':
						$dir_forlser_expor 	=  $path_folders.$this->dir_folder_txt;
						if (is_dir($dir_forlser_expor)) {
							$outputPath = $dir_forlser_expor.PATH_DELIM.$name_report_export.".txt";
							$report_return =$this->dir_folder_txt.PATH_DELIM.$name_report_export.".txt";					
							$exporter= new Java("net.sf.jasperreports.engine.export.JRTextExporter");
							$exporter->setParameter(java("net.sf.jasperreports.engine.export.JRTextExporterParameter")
							->PAGE_WIDTH,120);
							$exporter->setParameter(java("net.sf.jasperreports.engine.export.JRTextExporterParameter")
							->PAGE_HEIGHT,60);
							$exporter->setParameter(java("net.sf.jasperreports.engine.JRExporterParameter")->
							JASPER_PRINT,$jasperPrint);
							$exporter->setParameter(java("net.sf.jasperreports.engine.JRExporterParameter")->
							OUTPUT_FILE_NAME,$outputPath);

							$exporter->exportReport();
							$request	= TRUE;
							;
						}else{
							echo 'NO EXISTE EL DIRECTORIO : '.strtoupper($dir_forlser_expor);
							$request	= FALSE;
						}
						break;
					case 'pptx':
						$dir_forlser_expor 	=  $path_folders.$this->dir_folder_pptx;
						if (is_dir($dir_forlser_expor)) {
							$outputPath = $dir_forlser_expor.PATH_DELIM.$name_report_export.".pptx";		
							$report_return = $this->dir_folder_pptx.PATH_DELIM.$name_report_export.".pptx";
							
							$exporter= new Java("net.sf.jasperreports.engine.export.ooxml.JRPptxExporter");
							$exporter->setParameter(java("net.sf.jasperreports.engine.JRExporterParameter")
							->JASPER_PRINT,$jasperPrint);
							$exporter->setParameter(java("net.sf.jasperreports.engine.JRExporterParameter")
							->OUTPUT_FILE_NAME,$outputPath);
							
							$exporter->exportReport();
							$request	= TRUE;
						}else{
							echo 'NO EXISTE EL DIRECTORIO : '.strtoupper($dir_forlser_expor);
							$request	= FALSE;
						}
						break;
					case 'doc':
						$dir_forlser_expor 	=  $path_folders.$this->dir_folder_doc;
						if (is_dir($dir_forlser_expor)) {
							$outputPath = $dir_forlser_expor.PATH_DELIM.$name_report_export.".docx";	
							$report_return = $this->dir_folder_doc.PATH_DELIM.$name_report_export.".docx";							
							$exporterDOC = new Java ('net.sf.jasperreports.engine.export.ooxml.JRDocxExporter');							
							$JRExporterParameter  =  new Java ('net.sf.jasperreports.engine.JRExporterParameter');						
							$exporterDOC->setParameter($JRExporterParameter->JASPER_PRINT, $jasperPrint);									
							$exporterDOC->setParameter($JRExporterParameter->OUTPUT_FILE_NAME, $outputPath);									
							$exporterDOC->exportReport();							
							$request	= TRUE;
						}else{
							echo 'NO EXISTE EL DIRECTORIO : '.strtoupper($dir_forlser_expor);
							$request	= FALSE;
						}
						break;	
					case 'rtf':	
						$dir_forlser_expor 	=  $path_folders.$this->dir_folder_rtf;
						if (is_dir($dir_forlser_expor)) {
							$outputPath = $dir_forlser_expor.PATH_DELIM.$name_report_export.".rtf";	
							$report_return = $this->dir_folder_rtf.PATH_DELIM.$name_report_export.".rtf";							
							$exporterRTF = new Java ('net.sf.jasperreports.engine.export.JRRtfExporter');		
							$JRExporterParameter  =  new Java ('net.sf.jasperreports.engine.JRExporterParameter');								
							$exporterRTF->setParameter($JRExporterParameter->JASPER_PRINT, $jasperPrint);									
							$exporterRTF->setParameter($JRExporterParameter->OUTPUT_FILE_NAME, $outputPath);								
							$exporterRTF->exportReport();							
							$request	= TRUE;
						}else{
							echo 'NO EXISTE EL DIRECTORIO : '.strtoupper($dir_forlser_expor);
							$request	= FALSE;
						}	
						break;	
					case 'xls':	
						$dir_forlser_expor 	=  $path_folders.$this->dir_folder_xls;
						if (is_dir($dir_forlser_expor)) {
							$outputPath = $dir_forlser_expor.PATH_DELIM.$name_report_export.".xlsx";		
							$report_return = $this->dir_folder_xls.PATH_DELIM.$name_report_export.".xlsx";							
							$exporter= new Java("net.sf.jasperreports.engine.export.ooxml.JRXlsxExporter");
							$JRExporterParameter  =  new Java ('net.sf.jasperreports.engine.JRExporterParameter');					
							$exporter->setParameter($JRExporterParameter->JASPER_PRINT,$jasperPrint);
							$exporter->setParameter($JRExporterParameter->OUTPUT_FILE_NAME,$outputPath);			
							$exporter->exportReport();																					
							$request	= TRUE;
						}else{
							echo 'NO EXISTE EL DIRECTORIO : '.strtoupper($dir_forlser_expor);
							$request	= FALSE;
						}	
						break;	
					case 'html':	
						$dir_forlser_expor 	=  $path_folders.$this->dir_folder_html;
						if (is_dir($dir_forlser_expor)) {
							$outputPath = $dir_forlser_expor.PATH_DELIM.$name_report_export.".html";		
							$report_return = $this->dir_folder_html.PATH_DELIM.$name_report_export.".html";											
							$exporterHTML = new Java ('net.sf.jasperreports.engine.export.JRXhtmlExporter');							
							$JRExporterParameter  =  new Java ('net.sf.jasperreports.engine.export.JRHtmlExporterParameter');					
							$exporterHTML->setParameter($JRExporterParameter->JASPER_PRINT,$jasperPrint);									
							$exporterHTML->setParameter($JRExporterParameter->OUTPUT_FILE_NAME,$outputPath);							
							$Boolean = new Java('java.lang.Boolean');									
							$exporterHTML->setParameter($JRExporterParameter->IS_OUTPUT_IMAGES_TO_DIR,$Boolean->TRUE);							
							$exporterHTML->exportReport();
							$request	= TRUE;
						}else{
							echo 'NO EXISTE EL DIRECTORIO : '.strtoupper($dir_forlser_expor);
							$request	= FALSE;
						}	
						break;
					case 'print' : 	
						$printReport = new Java("net.sf.jasperreports.engine.JasperPrintManager");
						$printReport->printReport($jasperPrint, false);
						$request	= TRUE;
						break;
					default:
						$outputPath	= '';
						echo 'FORMATO NO SOPORTADO : '.strtoupper($format);
						$request	= FALSE;
						break;
				}

			/*$mod	= "sudo chmod 644 ".$outputPath;
			system($mod);
			chown($outputPath,'lopezsoft');
			chmod($outputPath,0644);*/
			$this->path_report_put = $this->path_report_put.$report_return;
			$this->close_connection();
			return $request;
		} catch (JavaException $ex) {
			$this->close_connection();
  			$trace = new Java('java.io.ByteArrayOutputStream');
			$ex->printStackTrace(new Java('java.io.PrintStream', $trace));
			print nl2br("java stack trace : $trace\n");
			return false;
		}
	}
	
	/**
	* 
	* @param string $report_name, Nonbre del reporte creado en JasReport
	* @param string $report_name_export, Nombre del reporte de salida
	* @param string $format, Formato o extensión del informe
	* @param string $query, sentencia SQL.
	* @param string $param, parametros del reporte SQL.
	* @param string $g, grado para la escala del reporte SQL.
	* 
	* @return
	*/	
	public function get_report_export ($report_name, $report_name_export, $format, $query, $param = NULL,$g="") {

		//Reporte a Procesar : Este nombre es del reporte creado en JasReport
		$name_report	=	$report_name;		
		// Nombre dado al informe de salida
		$name_report_export	= $report_name_export.'_'.$this->get_id_school().'_'.time();		
		//Ruta donde se encuentra guardado el informe
		$path_save_report 	=	$this->path_report;		
		//Extension de Salida
		$format = $format;		
		//Funcion de Conexion a mi Base de datos tipo MySql
		$conn = $this->jdbc_connection();		
		// Sentencia SQL para el parametro
		
		//$query 	= $query;
			
		//Parametro en caso de que el reporte no este parametrizado		
		$escala	= $this->escala($g);
		$this->set_report_params();
		if($param == NULL){			
			$parm	= array(
				'SQL_PARAM' 	=> $query,
				'R_TITLE'		=> $this->p_title,
				'R_NIT'			=> $this->p_nit,
				'R_DANE'		=> $this->p_dane,
				'R_RESOL'		=> $this->p_resol,
				'R_FOOTER'		=> $this->p_footer,
				'R_IMG_LEFT'	=> $this->p_img_left,
				'R_IMG_RIGHT'	=> $this->p_img_right,
				'R_MARKETING'	=> $this->p_marketing,
				'R_ESCALA'		=> $escala,
				'SUBREPORT_DIR' => $this->subreport_dir,
				'R_PATH_DIR'	=> $this->directory_path,
				'R_HOME_DIR'	=> $this->directory_path.SCHOOL_DIRECTORY.PATH_DELIM.$this->get_school_folder().PATH_DELIM
			);			
		}else{
			$parm	= array(
				'SQL_PARAM' 	=> $query,
				'R_TITLE'		=> $this->p_title,
				'R_NIT'			=> $this->p_nit,
				'R_DANE'		=> $this->p_dane,
				'R_RESOL'		=> $this->p_resol,
				'R_FOOTER'		=> $this->p_footer,
				'R_IMG_LEFT'	=> $this->p_img_left,
				'R_IMG_RIGHT'	=> $this->p_img_right,
				'R_MARKETING'	=> $this->p_marketing,
				'R_ESCALA'		=> $escala,
				'SUBREPORT_DIR' => $this->subreport_dir,
				'R_PATH_DIR'	=> $this->directory_path,
				'R_HOME_DIR'	=> $this->directory_path.SCHOOL_DIRECTORY.PATH_DELIM.$this->get_school_folder().PATH_DELIM
			);			
			foreach($param as $key => $value){
				$parm[$key] = $value;
			}
		}
		
		$parameters	=	new java('java.util.HashMap',$parm);		

		//Pasamos los parametros a la función encargada de ralizar la exportación del informe	
		$result = $this->export_report($path_save_report,$name_report,$name_report_export,$parameters,$conn,$format);
		//Mandamos respuesta del Servidor al iFrame de Extjs para darle el nombre del PDF que mostrara
		
	    if ($result) {
			$request	= array(
				'success'		=> TRUE,
				'path_report'	=> utf8_encode($this->path_report_put)
			);
			
			$request	= json_encode($request);
			
		}else{
			$request	= array(
				'success'		=> FALSE,
				'path_report'	=> utf8_encode($this->path_report_put)
			);
			
			$request	= json_encode($request);
		}
		return $request;
	}

	public function set_report_params () {	
		$db			= $this->get_db_name();		
		$query		= $this->db->get($db.".encabezado_reportes");	
		$imgleft	= $this->directory_path.PATH_DELIM.$query->row('logo');
		$imgright	= $this->directory_path.PATH_DELIM.$query->row('escudo');
		if(file_exists($imgleft)){
			$this->p_img_left	= $imgleft;
		}
		if(file_exists($imgright)){
			$this->p_img_right	= $imgright;
		}
		$this->p_title		= $query->row('encabezado');
 		$this->p_nit		= $query->row('dane');
 		$this->p_dane		= $query->row('dni');
		$this->p_footer		= $query->row('pie'); 
		$this->p_resol		= $query->row('resolucion');
		$this->p_marketing	= SOFT_NAME.' - '.FOOTER_EMAIL_SME.' - '.FOOTER_WEB_SME;
	}	
}


/* End of file M_jreport.php */
/* Location: ./application/models/M_jreport.php */