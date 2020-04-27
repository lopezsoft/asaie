<?php
defined('BASEPATH') OR exit('No direct script access allowed');
// date_default_timezone_set("America/Bogota");
class SME_Model extends CI_Model {
	/**
	 * New Properties
	 */  
	protected $directory_path	= "";
	protected $school_folder	= "demo";
	protected $school_logo		= "logo_escuela.png";
	protected $logo_report		= "SME_R.png";
	protected $shield			= "escudo.png";
	
	protected $user_id          = 0;           // Id del usuario    
	protected $first_name  		= NULL; 		// Nombre real del usuario.
	protected $last_name		= NULL;    // Apellidos del usuario
 	protected $user_name        = NULL;     // Nombre de usuario del nocente (C.C)
	protected $user_pass        = NULL;    // Password o contraseña
	protected $user_id_school   = NULL;    // Indentificado del I.E
	protected $user_year        = NULL;    // year al que ingrese el usuario
	protected $user_type		= '0';	// Tipo de usuario
	protected $user_active		= 0; // Estado del usuario.
	protected $teacher_id		= -1;
	
	protected	$db_name		= '';
	protected	$year			= 0;
	protected	$id_school		= 0;
	
	protected $route_signature_dir	= NULL;
	protected $user_documents_path	= NULL;
	protected $user_images_path		= NULL;
	protected $teacher_directory_path = NULL;
	protected $route_directory_teaching_material = NULL;
	protected $path_directory_digital_documents_teacher = NULL;
	protected $teaching_excel_files_directory_path 		= NULL;
	protected $student_image_path 						= NULL;
	protected $student_material_path					= NULL;
	protected $student_document_path					= NULL;
	protected $resource_folder_path						= null;
	
	/**
	 * End New properties
	 */

	var $doc_docente	= NULL;
	var $proceso		= 0;
	var $desde			= 0;
	var $hasta			= 0;
	var $last_periodo	= 5;
	public  $limit_min 	= NULL;
	public 	$limit_max	= NULL;
	public	$limit_min_result		= 60;
	var	$id_est						= 0;
	var	$dirPathProyTrans			= "";
	var	$dirPathDocumentosUsuario	= "";
	var $dirPathImgUsuario	 		= "";
	var $date						= NULL;
	var	$adminDigitalDirectoryPath	= "";
	var	$adminImagesDirectoryPath	= "";
	
	public function __construct() 
	{
		parent::__construct()	;
		$this->update_properties();		
		$this->limit_min	= 0;
	  $this->limit_max	= 60;
	  $this->db_limit();
		$this->date			= date('Y-m-d h-m-s');
		$this->directory_path	= $_SERVER["DOCUMENT_ROOT"].PATH_DELIM;
		
		if( ! is_dir($this->directory_path.SCHOOL_DIRECTORY)){
			mkdir($this->directory_path.SCHOOL_DIRECTORY,0777);
		}
		
		if( ! is_dir($this->directory_path.SCHOOL_DIRECTORY)){
			mkdir($this->directory_path.SCHOOL_DIRECTORY,0777);
		}
	}
	
	/**
	* Update properties 
	* 
	* @return NONE
	*/
	
	protected function update_properties(){
		$this->teacher_id	= $this->get_teacher_id();
		$this->user_id		= $this->get_user_id();
		$this->id_school  	= $this->get_id_school();
		$this->year			= $this->get_year();
		$this->user_name	= $this->get_user_name();
		$this->db_name		= $this->get_db_name();
		$this->school_folder= $this->get_school_folder();
	}
	
	public function get_teacher_id(){
		return $this->session->userdata('user_parent');
	}
	
	protected function get_user_id(){
		return $this->session->userdata('user_id');
	}
	
	protected function get_user_name(){
		return $this->session->userdata('user_name');
	}
		
	protected function get_id_school(){
		return $this->session->userdata('user_id_school');
	}
	
	protected function get_year(){
		return $this->session->userdata('user_year');
	}

	protected function get_parent(){
		return $this->session->userdata('user_parent');
	}
	
	protected function get_school_folder(){
		return $this->session->userdata('school_folder');
	}
		
	/**
	* Get database name
	* 
	* @return STRING
	*/
	protected function get_db_name(){
		return $this->session->userdata('db_name');
	}

	/**
	 * Devuelve la totalidad de registros de una tabla
	 *
	 * @param STRING $table
	 * @param STRING $where
	 * @return INT
	 */
	function get_count_all($table, $where = null)
	{
		$db	= $this->get_db_name();
        if(!is_null($where)){
            $this->db->where($where);
        }
        return $this->db->from($db.'.'.$table)->count_all_results();
	}	

	function resource_folder(){
		$this->update_properties();
		// Crea el directorio para las images de recursos
		$dir	= $this->directory_path.SCHOOL_DIRECTORY.PATH_DELIM.$this->school_folder.
		PATH_DELIM.RESOURCE_FOLDER;
		if ( ! is_dir($dir)){
			mkdir($dir, 0777, true);
		}
		
		if(is_dir($dir)){
			$this->setResource_folder_path(SCHOOL_DIRECTORY.PATH_DELIM.$this->school_folder.
			PATH_DELIM.RESOURCE_FOLDER);
		}
			
	}

	function folders_signature(){
		$this->update_properties();
		// Crea el directorio Firmas
		$dir	= $this->directory_path.SCHOOL_DIRECTORY.PATH_DELIM.$this->school_folder.
		PATH_DELIM.UP_FOLDER.PATH_DELIM.SIGNATURE_DIR_NAME;
		if ( ! is_dir($dir)){
			mkdir($dir, 0777, true);
		}
		// Crea el directorio para las fotos de perfil
		
		$dir2	= $dir.PATH_DELIM.SCANNED_SIGNATURE;
		if ( ! is_dir($dir2)){
			mkdir($dir2, 0777, true);
		}		
		
		if (is_dir($dir2)){
			$this->route_signature_dir	= SCHOOL_DIRECTORY.PATH_DELIM.$this->school_folder.PATH_DELIM.
			UP_FOLDER.PATH_DELIM.SIGNATURE_DIR_NAME.PATH_DELIM.SCANNED_SIGNATURE;
		}
			
	}
	
	function folders_administrative($id){		
		$this->update_properties();
		$dir				  = $id;
		// Crea el directorio de cada admin 
		$dir_p	= $this->directory_path.SCHOOL_DIRECTORY.PATH_DELIM.$this->school_folder.
						  PATH_DELIM.UP_FOLDER.PATH_DELIM.ADMINISTRATIVE_DIR_NAME.PATH_DELIM.$dir;
		if (!is_dir($dir_p)){
			mkdir($dir_p, 0777, true);
		}
		// Crea el directorio para las fotos de perfil
		if (!is_dir($dir_p.PATH_DELIM.PROFILE_DIR_NAME)){
			mkdir($dir_p.PATH_DELIM.PROFILE_DIR_NAME, 0777, true);
		}
		if (!is_dir($dir_p.PATH_DELIM.DIGITAL_DOCUMENTS_DIR_NAME)){
			mkdir($dir_p.PATH_DELIM.DIGITAL_DOCUMENTS_DIR_NAME, 0777, true);
		}		
		
	}
	
	public function get_get_docente_curso($gdo,$gpo,$sede,$jorn,$a,$curso){
		$db		= $this->get_db_name();
		$sql	= "SELECT id_asig FROM ".$db.".cursos WHERE id=".$curso." LIMIT 1";
		$sql	= $this->db->query($sql);
		$result	= 0;
		if($sql->num_rows() > 0 ){
			$id_asig	= $sql->row('id_asig');
			$_SQL	= "SELECT id FROM ".$db.".cursos WHERE id_grado='".$gdo.
			"' AND id_sede=".$sede." AND grupo='".$gpo.
			"' AND id_jorn=".$jorn." AND year=".$a.
			" AND estado=1 AND id_asig=".$id_asig." LIMIT 1";
			$query	= $this->db->query($_SQL);		
			if ($query->num_rows() > 0){
				$result	= $query->row('id');
			}	
		}
		return $result;
	}
	
	public function	get_get_idmatric(){
		$query 	= "SELECT id_matric FROM matriculas ".
		" WHERE id_inst = '".$this->get_id_school()."' AND year = '".
		$this->get_year()."' AND cod_est = '".$this->get_id_student()."' LIMIT 1";
		$query	= $this->db->query($query);
		if ($query) {
			$result = $query->row('id_matric');
		}else{
			$result	= 0;
		}
		return $result;
	}
	
	public function upload_webcam_file($file,$path){
		$fileName = date('Y_m_d_h_m_s')."_webcam_file.jpg";
		if (is_dir($this->directory_path.$path)){
				$foto	= $this->directory_path.$path.PATH_DELIM.$fileName;	
			//eliminamos data:image/jpeg; y base64, de la cadena que tenemos
			$Base64Img = $file;			
			list(, $Base64Img) = explode(';', $Base64Img);
			list(, $Base64Img) = explode(',', $Base64Img);
			//Decodificamos $Base64Img codificada en base64.
			$Base64Img = base64_decode($Base64Img);
			//escribimos la información obtenida en un archivo llamado 
			//unodepiera.png para que se cree la imagen correctamente
			try{
				file_put_contents($foto, $Base64Img);
				$fileSize	= filesize($foto);	
				$foto	= $path.PATH_DELIM.$fileName;
				$request = json_encode(
					array(
						'success'	=> true,
						'foto'		=> $foto,
						'mime'		=> 'image/jpeg',
						'format' 	=> pathinfo($foto,PATHINFO_EXTENSION),
						'type'		=> $this->extension_to_type(pathinfo($foto,PATHINFO_EXTENSION)),
						'size'		=> round((($fileSize/1024)/1024),3)
					)
				);	
			} catch (Exception $E) {
				$request = $this->error_success();
			}
		}else{
			$request = $this->error_success();
		}	
		return $request;
	}
		
	/**
	* Función para guardar archivos o imagenes en un directorio en el servido.
	* 
	* @param file $file Archvivo
	* @param string $path Ruta donde se copiará el archivo
	* 
	* @return JsonEncode
	*/
	
	public function upload_file($file,$path){
		$fileName = $file['name'];
		$fileTmp  = $file['tmp_name'];
		$filetype = $file['type'];	
		$fileSize = $file['size'];
		if ($fileSize > 2048000) {
			$request = array(
					'success'       =>FALSE,
					'error'			=> 'No se permite subir archivos mayores a 2 MB'
				);
				$request = json_encode($request);
		}else{
	        if (is_dir($this->directory_path.$path)){
		        $foto	= $this->directory_path.$path.PATH_DELIM.basename($fileName);	
				if (is_uploaded_file($fileTmp)){
					if (move_uploaded_file($fileTmp,$foto)){				
						$foto	= $path.PATH_DELIM.basename($fileName);
						$request = json_encode(
							array(
								'success'	=> true,
								'foto'		=> $foto,
								'mime'		=> $filetype,
								'format' 	=> pathinfo($foto,PATHINFO_EXTENSION),
								'type'		=> $this->extension_to_type(pathinfo($foto,PATHINFO_EXTENSION)),
								'size'		=> round((($fileSize/1024)/1024),3)
							)
						);									
					}else{
						$request = $this->error_success();
					}				
				}else{
					$request = $this->error_success();
				}
			}else{
				$request = $this->error_success();
			}
		}		
		return $request;
	}
	
	function folders_proy_trans(){
		// Crea el directorio
		if (!is_dir($this->directory_path.'uploads/proy_transversales')){
			mkdir($this->directory_path.'uploads/proy_transversales', 0777, true);
		}
		
		if (is_dir($this->directory_path.'uploads/proy_transversales')){
			$this->dirPathProyTrans = 'uploads/proy_transversales';
		}
	}
	
	function get_id_student(){
		$query	= "SELECT id_estudiante FROM ".$this->get_db_name().
		".usuarios_estu WHERE id=".$this->get_user_id();
		$query	= $this->db->query($query);
		if($query){
			$this->id_est = $query->row('id_estudiante');
		}else{
			$this->id_est = 0;
		}
		return $this->id_est;
	}
	
	function folders_users($id){
		$this->update_properties();
		// Crea el directorio de cada usuario
		$dir	= $this->directory_path.SCHOOL_DIRECTORY.PATH_DELIM.$this->school_folder.
		PATH_DELIM.UP_FOLDER.PATH_DELIM.USER_DOCUMENTS_DIR.PATH_DELIM;
		if (!is_dir($dir.$id)){
			mkdir($dir.$id, 0777, true);
		}
		// Crea el directorio para las fotos de perfil
		$dir2	= $dir.$id.PATH_DELIM.PROFILE_DIR_NAME;
		if (!is_dir($dir2)){
			mkdir($dir2, 0777, true);
		}
		// Crea el directorio para los documentos del usuario
		$dir3	= $dir.$id.PATH_DELIM.DOCUMENTS_DIR_NAME;
		if (!is_dir($dir3)){
			mkdir($dir3, 0777, true);
		}
		
		$dir4	= SCHOOL_DIRECTORY.PATH_DELIM.$this->school_folder.PATH_DELIM.UP_FOLDER.PATH_DELIM.USER_DOCUMENTS_DIR.PATH_DELIM;
		if (is_dir($dir2)){
			$this->user_images_path = $dir4.$id.PATH_DELIM.PROFILE_DIR_NAME;
		}		
		if (is_dir($dir3)){
			$this->user_documents_path = $dir4.$id.PATH_DELIM.DOCUMENTS_DIR_NAME;
		}
		
	}
		
	function student_folders($id){
		$this->update_properties();
		$dir			= $id;
		$dirPerfil		= PATH_DELIM.PROFILE_DIR_NAME;
		$dirDocs		= PATH_DELIM.DOCUMENTS_DIR_NAME;
		$dirDocsDig		= PATH_DELIM.DIGITAL_DOCUMENTS_DIR_NAME;
		$aDir			= $this->directory_path.SCHOOL_DIRECTORY.PATH_DELIM.$this->get_school_folder().PATH_DELIM.UP_FOLDER.PATH_DELIM.STUDENT_FOLDERS.PATH_DELIM;
		// Crea el directorio de cada estudiante
		if (!is_dir($aDir.$dir)){
			mkdir($aDir.$dir, 0777, true);
		}
		// Crea el directorio para las fotos de perfil
		if (!is_dir($aDir.$dir.$dirPerfil)){
			mkdir($aDir.$dir.$dirPerfil, 0777, true);
		}
		// Crea el directorio para los documentos del estudiante
		if (!is_dir($aDir.$dir.$dirDocs)){
			mkdir($aDir.$dir.$dirDocs, 0777, true);
		}
		if (!is_dir($aDir.$dir.$dirDocsDig)){
			mkdir($aDir.$dir.$dirDocsDig, 0777, true);
		}		
		$aDir			= SCHOOL_DIRECTORY.PATH_DELIM.$this->get_school_folder().PATH_DELIM.UP_FOLDER.PATH_DELIM.STUDENT_FOLDERS.PATH_DELIM;
		if (is_dir($aDir.$dir.$dirPerfil)){
			$this->student_image_path = $aDir.$dir.$dirPerfil;
		}		
		if (is_dir($aDir.$dir.$dirDocs)){
			$this->student_material_path = $aDir.$dir.$dirDocs;
		}
		if (is_dir($aDir.$dir.$dirDocsDig)){
			$this->student_document_path = $aDir.$dir.$dirDocsDig;
		}
	}
	/**
	* Borra el archivo pasado como parametr
	* @param STRING $path
	* 
	* @return
	*/
	public function delete_file($path) {
		$apath	= utf8_decode($path);
		if (unlink($apath)){
			$request	= $this->get_request_ab();
		}else{
			$request 	= $this->error_success();
		}
		return $request;
	}
	
	/**
	*  Extensión de archivo que se desea obtener el tipo MIME
	* 
	* @param strin $extension
	* 
	* @return Type MIME
	*/
	
	function extension_to_mime($extension){
		$mime 	= "xx/xx";
		$ext	= strtoupper($extension);
		switch($ext){
			case "CSV" 	: $mime	= "text/csv"; break;
	/*					image							*/		
			case "PNG" : $mime 	= "image/png";break;			
			case "GIJ" : $mime 	= "image/gif";break;
			case "BMP" : $mime 	= "image/bmp";break;	
			case "JPG" : $mime 	= "image/jpeg";break;
			case "JPEG" : $mime = "image/jpeg";break;
	/*					application							*/
			case "PDF" : $mime	= "application/pdf"; break;
			case "DOC" : $mime	= "application/msword"; break;
			case "DOCX" : $mime	= "application/msword"; break;
			case "XLS" 	: $mime	= "application/vnd.ms-excel"; break;
			case "XLSX" : $mime	= "application/vnd.ms-excel"; break;
			case "ZIP" : $mime	= "application/zip"; break;		
			case "PPT" : $mime	= "application/vnd.ms-powerpoint"; break;
			case "PPTX" : $mime	= "application/vnd.ms-powerpoint"; break;
			case "RAR" : $mime	= "application/x-rar-compressed"; break;			
			case "RTF" : $mime	= "application/rtf"; break;	
			case "7Z" 	: $mime	= "application/x-7z-compressed"; break;
	/*					audio							*/	
			case "OGA" : $mime	= "audio/ogg"; break;	
			case "ACC" : $mime	= "audio/aac"; break;
			case "WAV" : $mime	= "audio/x-wav"; break;	
	/*					video							*/			
			case "AVI" : $mime	= "video/x-msvideo"; break;
			case "MPEG" : $mime	= "video/mpeg"; break;			
			case "OGV" 	: $mime	= "video/ogg"; break;		
			default: break;
		}
		return $mime;
	}
	
	/**
	* 
	* @param sting $extension
	* 
	* @return INTEGER
	*/
	
	function extension_to_type($extension){
		$mime 	= 0;
		$ext	= strtoupper($extension);
		switch($ext){
			case "CSV" 	: $mime	= 0; break;
	/*					image							*/		
			case "PNG" : $mime 	= 1;break;			
			case "GIJ" : $mime 	= 1;break;
			case "BMP" : $mime 	= 1;break;	
			case "JPG" : $mime 	= 1;break;
			case "JPEG" : $mime = 1;break;
	/*					application							*/
			case "PDF" : $mime	= 2; break;
			case "DOC" : $mime	= 2; break;
			case "DOCX" : $mime	= 2; break;
			case "XLS" 	: $mime	= 2; break;
			case "XLSX" : $mime	= 2; break;
			case "ZIP" : $mime	= 2; break;		
			case "PPT" : $mime	= 2; break;
			case "PPTX" : $mime	= 2; break;
			case "RAR" : $mime	= 2; break;			
			case "RTF" : $mime	= 2; break;	
			case "7Z" 	: $mime	= 2; break;
	/*					audio							*/	
			case "OGA" : $mime	= 3; break;	
			case "ACC" : $mime	= 3; break;
			case "WAV" : $mime	= 3; break;	
	/*					video							*/			
			case "AVI" : $mime	= 4; break;
			case "MPEG" : $mime	= 4; break;			
			case "OGV" 	: $mime	= 4; break;		
			default: break;
		}
		return $mime;
	}
	
	
	
	/**
	* Funcion que lee los archivos guradados en la ruta especificada
	* y muestra la lista de los archivos.
	* 
	* @return
	*/
	
	public function read_directory_files($path){			  	
		$directory_home 	= $this->directory_path.$path.PATH_DELIM;
		$path_download		= base_url().$path.PATH_DELIM;
		$list_dir	= NULL;
		$reccount	= 0;
		if (is_dir($directory_home)) {
			$directory = scandir($directory_home);
			foreach($directory as $key => $value){
				if ($value <> "." AND $value <> "..") {
					if (!empty($value)){  
						$ext	= pathinfo($directory_home.$value,PATHINFO_EXTENSION);
						if(!empty($ext)){
							$list_dir [] = array(
								'name' 			=> $value, 
								'format' 		=> pathinfo($directory_home.$value,PATHINFO_EXTENSION), 
								'mime'			=> $this->extension_to_mime($ext),
								'path_download' => $path_download.$value,
								'path_delete'	=> $directory_home.$value,
								'path_set'		=> $path.PATH_DELIM.$value,
								'fecha'			=> date("m d Y H:i:s",filectime($directory_home.$value)),
								'type'			=> $this->extension_to_type($ext),
								'size'			=> round((filesize($directory_home.$value)/1024)/1024,3)
							);
							$reccount	 = ++$reccount;	
						}
					}		
				}				
			}
					
			$request = array(
				'success'       =>TRUE,
				'records'	=> $list_dir,
				'reccount' 		=> $reccount	
			);
			
			
		}else{
			$request = $this->error_success();
			
		}
		
		return json_encode($request);
	}
	
	/**
	* Funcion que crea los directorios para guardar archivos por parte del docente
	* 
	* @return
	*/
	public function folders_teachers($doc){
		$dirDocente			= PROFILE_DIR_NAME;
		$dirMaterialdocente = MATERIAL_DIRECTORY;
		$dirDocsDig			= DIGITAL_DOCUMENTS_DIR_NAME;
		$dirDocsXls			= XLS_FILE_DIRECTORY;
		$dirDocsXlsUp		= UPLOADED_DIRECTORY;
		$docs				= PATH_DELIM.DOCUMENTS_DIR_NAME.PATH_DELIM;
		$dir		= $this->directory_path.SCHOOL_DIRECTORY.PATH_DELIM.$this->get_school_folder().PATH_DELIM.UP_FOLDER.PATH_DELIM.TEACHERS_DIRECTORY.PATH_DELIM;
		if (!is_dir($dir)){
			mkdir($dir, 0777, true);
		}		
		if (!is_dir($dir.$doc)){
			mkdir($dir.$doc, 0777, true);
		}
		if (!is_dir($dir.$doc.$docs)){
			mkdir($dir.$doc.$docs, 0777, true);
		}		
		if (!is_dir($dir.$doc.$docs.$dirDocente)){
			mkdir($dir.$doc.$docs.$dirDocente, 0777, true);
		}
		if (!is_dir($dir.$doc.$docs.$dirMaterialdocente)){
			mkdir($dir.$doc.$docs.$dirMaterialdocente, 0777, true);
		}
		if (!is_dir($dir.$doc.$docs.$dirDocsXls)){
			mkdir($dir.$doc.$docs.$dirDocsXls, 0777, true);
		}
		if (!is_dir($dir.$doc.$docs.$dirDocsDig)){
			mkdir($dir.$doc.$docs.$dirDocsDig, 0777, true);
		}
		if (!is_dir($dir.$doc.$docs.$dirDocsXls.PATH_DELIM.$dirDocsXlsUp)){
			mkdir($dir.$doc.$docs.$dirDocsXls.PATH_DELIM.$dirDocsXlsUp, 0777, true);
		}	

		/** */
		$dir2		= SCHOOL_DIRECTORY.PATH_DELIM.$this->get_school_folder().PATH_DELIM.UP_FOLDER.PATH_DELIM.TEACHERS_DIRECTORY.PATH_DELIM;

		if (is_dir($dir.$doc.$docs.$dirDocente)){
			$this->teacher_directory_path = $dir2.$doc.$docs.$dirDocente;
		}		
		if (is_dir($dir.$doc.$docs.$dirMaterialdocente)){
			$this->route_directory_teaching_material = $dir2.$doc.$docs.$dirMaterialdocente;
		}
		if (is_dir($dir.$doc.$docs.$dirDocsDig)){
			$this->path_directory_digital_documents_teacher = $dir2.$doc.$docs.$dirDocsDig;
		}
		if (is_dir($dir.$doc.$docs.$dirDocsXls)){
			$this->teaching_excel_files_directory_path = $dir2.$doc.$docs.$dirDocsXls;
		}
		if (is_dir($dir.$doc.$docs.$dirDocsXls.PATH_DELIM.$dirDocsXlsUp)){
			$this->path_directory_excel_files_teacher_uploads = $dir2.$doc.$docs.$dirDocsXls.PATH_DELIM.$dirDocsXlsUp;
		}
		
	}
	
    public function db_limit () 
	{
		$this-> limit_min = (isset($_GET['start'])?$_GET['start']:"0");
		$this-> limit_max = (isset($_GET['limit'])?$_GET['limit']:"60");
	}
	/**
	* Funcion que duevuelve el ID  del establecimiento
	* 
	* @param string $dane
	* 
	* @return 
	*/
	public function id_school ($dane = "" ) {
		$query 	= "SELECT ID FROM ".$this->db_name.".establecimiento WHERE COD_DANE='".
		$dane."' LIMIT 1";
		$query	=  $this->db->query($query);
		$request	= 0;
		if ($query){
			$request	= $query->row('ID');
		}else{
			$request	= 0;
		}
		return $request;
	}
	
	public function id_inst_pre_mat () {
		$query 	= "SELECT ID FROM establecimiento LIMIT 1";
		$query	=  $this->db->query($query);
		$request	= 0;
		if ($query){
			$request	= $query->row('ID');
		}else{
			$request	= 0;
		}
		return $request;
	}
	
	/**
	* Funcion que retorna los errores generador en el servidor
	* 
	* @return
	*/
	
	public function error_success() 
	{
		$request = array(
		'success'       =>FALSE,
		'error'			=> 'Error interno de la aplicación'
		);
		$request = json_encode($request);
		return $request;
	}
	
	public function get_error () 
	{
		// if (ESTADO_DEPURACION == TRUE) {
		// 	return $this->db->error();
		// }else{
			$request = array(
			'success'       =>FALSE
			);
			$request = json_encode($request);
			return $request;
		// }
	}
	/**
	* Funcion que retorna el mesnaje de vencimiento de la fecha del periodo academico.
	* 
	* @return
	*/
	
	public function control_date_msg () {
		$date	= date('Y-m-d');
		$reuqest = array(
				'success'	=> FALSE,
				'request'   => 'Se ha vencido la fecha del periodo',
				'fecha'		=> $date
			);
			
		return json_encode($reuqest);
	}
	
	/**
	* funcion que verifica si el periodo se encuentra habilitado o no.
	* @param string $periodo
	* @param string $grado
	* 
	* @return bolean
	*/
	
	public function control_date ($periodo, $grado) {
		$db			= $this->get_db_name();
		$query 	= "SELECT fecha_cierre AS recupera 
			FROM ".$db.".periodos_academicos tc
			LEFT JOIN ".$db.".grados_agrupados AS t1 ON tc.id_grado_agrupado = t1.id
			LEFT JOIN ".$db.".aux_grados_agrupados AS t2 ON t2.id_grado_agrupado = t1.id 
			WHERE year = ".$this->get_year()." AND t2.id_grado = ".$grado
			." AND tc.periodo = ".$periodo." LIMIT 1";							
		$query			= $this->db->query($query);
		$system_date	= date("Y-m-d");		
		if ($query) {			
			$close_date = $query->row('recupera');
			if ($system_date > $close_date) {
				$request	= FALSE;				
			}else{
				$request	= TRUE;
			}
			
		}else{
			$request = FALSE;
		}
		return $request;
	}
	
	
	public function control_date_nivelacion ($periodo, $grado) {
		$db	= $this->get_db_name();
		$query 	= "SELECT fecha_cierre_nivelacion AS recupera 
			FROM ".$db.".periodos_academicos tc
			LEFT JOIN ".$db.".grados_agrupados AS t1 ON tc.id_grado_agrupado = t1.id
			LEFT JOIN ".$db.".aux_grados_agrupados AS t2 ON t2.id_grado_agrupado = t1.id 
			WHERE year = ".$this->get_year()." AND t2.id_grado = ".$grado
			." AND tc.periodo = ".$periodo." LIMIT 1";				
		$query			= $this->db->query($query);
		$system_date	= date("Y-m-d");		
		if ($query) {			
			$close_date = $query->row('recupera');
			if ($system_date > $close_date) {
				$request	= FALSE;				
			}else{
				$request	= TRUE;
			}
			
		}else{
			$request = FALSE;
		}
		return $request;
	}

	/**
	* Funcion para ejecutar una consulta al servidor mediante un procedimiento almacenado
	* @param string $func_name Nombre de la funcion o almacenamiento almacenado
	* @param string $param  Cadena con los parametros del procedimiento almacenado
	* 
	* @return Resultado en formato Json
	*/	
	public function	getExecute($func_name, $param = [], $encode = true, $result = true){
   		
		if(isset($func_name)){
			try {
				$db         = $this->get_db_name();
				$query	= "CALL ".$db.".".$func_name;
				if(count($param) > 0){
					$query = $this->db->query($query,$param);
				}else {
					$query 	= $this->db->query($query);
				}
				if($result){
					$this->next_result();
					if($encode){
						$request = $this->getJsonResponse($query->result_array(),count($query->result_array()));			
					}else{
						$request = $query->result_array();			
					}
				}else{
					$request	= TRUE;
				}
			} catch (Exception $e) {
				$request  = $this->getError($e->getMessage());
			}finally{
				// $this->db->close();
			}				
		}else{
			$request = $this->getError('Error en los parametros');
		}
		return $request;
	}

	public function getQuery($queryCount, $queryStatemente, $start, $limit, $querySearch, $fieldsSearch = [], $where = [], $order=NULL)
	{
		try{
			$stringFields 	= $fieldsSearch;
			$order 			= ($order) ? " ORDER BY ".$order." ": '' ;	
            if (strlen($querySearch) > 0 ) {
				$queryField = "";
				$whereArray	= [];
                foreach ($stringFields as $value) {
					$whereArray	= $where;
					if(count($where) > 0){
						$query	= $queryStatemente." AND ".$value." LIKE ? ".
						" LIMIT 1";
						array_push($whereArray,"%".$querySearch."%");
					}else{
						$query	= $queryStatemente." WHERE ".$value." LIKE ? ".
						" LIMIT 1";
						array_push($whereArray,"%".$querySearch."%");
					}
                    $select = $this->db->query($query,$whereArray);
                    if ($select->num_rows() > 0) {
						$queryField = $value;
						$whereArray	= $where;
						array_push($whereArray,"%".$querySearch."%");
                        break;
                    }
                }
                
                if (strlen($queryField)) {
					if(count($where) > 0){
						$total  = $this->db->query($queryCount." AND ".$queryField." LIKE ? ", $whereArray);
					}else{
						$total  = $this->db->query($queryCount." WHERE ".$queryField." LIKE ? ",$whereArray);
					}

					if(count($where) > 0){
						$query	= $queryStatemente." AND ".$queryField." LIKE ? ".
						$order." LIMIT ".$start.",".$limit;
					}else{
						$query	= $queryStatemente." WHERE ".$queryField." LIKE ? ".
						$order." LIMIT ".$start.",".$limit;
					}
                    
                    $select = $this->db->query($query, $whereArray);
                    $result = $this->getJsonResponse($select->result_array(),$total->row('total'));
                }else {
                    $result = $this->getJsonResponse([],0);
                }
            }else{         
				if(count($where) > 0){
					$total  = $this->db->query($queryCount, $where);
				}else{
					$total  = $this->db->query($queryCount);
				}

				$query	= $queryStatemente.$order." LIMIT ".$start.",".$limit;
                if(count($where) > 0){
					$query = $this->db->query($query,$where);
				}else{
					$query = $this->db->query($query);
				}
				
                $result     = $this->getJsonResponse($query->result_array(), $total->row('total'));
            }
        } catch (Exception $e) {
			$result  = $this->getError($e->getMessage());
		}finally{
			// $this->db->close();
		}
		return $result;
	}
	

	/**
	 * Devuelve la totalidad de registros de una tabla
	 *
	 * @param STRING $table
	 * @param STRING $where
	 * @return INT
	 */
	
	function getCountAll($table, $where = null)
	{
        if(!is_null($where)){
            $this->db->where($where);
        }
        return $this->db->from($table)->count_all_results();
	}	

	
	/**
	* Funcion que retorna los errores generador en el servidor
	* 
	* @return
	*/
	
	
	public function getError ($message = "") 
	{

		$request = array(
			'success'       => FALSE,
			'Error'			=> $message
		);
		$request = json_encode($request);
		return $request;
	}
	
  	
  	/**
	  * Funcion para realizar un INSERT  a una tabla con campos primarios 
	  * auto incrementables
	  * 
	  * @table string Nombre de la tabla
	  * @array_data array  lista de campos y datos a insertar
	  * @extra_data array datos extras a insertar
	  * @primary_value Boolean Bebe pasar un valor TRUE si desea obtener el valor del campo primario sin codificación JSON.
	  * 
	  * 
	  * @return
	  */
  	public function insertData($table, $data, $primaryKey = 'id', $serial, $primary_value = FALSE, $where = []) {
		$db         = $this->get_db_name();	
		$db_field 	= '';	
		$db_value 	= '';
		$table		= $db.'.'.$table;
		$db_field1 	= '';
		$db_value1 	= '';
		
		$value_insert	= '';
		
		$i		= 0;
		$count 	= 0;
		
		try{			

			if (isset($serial)) {
				$serial	= json_decode($serial);
			}else{
				$serial	= null;
			}

			$fields	= $data;
			
			/**
			* 
			* @var $fiels_table : Obtiene la lista de los campos de la tabla donde se realizará el INSERT
			* 
			*/		
			$fiels_table = $this->db->field_data($table);
			/**
			* @var Si hay más de un registro que insertar
			*/
			if(is_array($fields)){
				$fieldsSend		= [];
				foreach ($fields as $key => $sendvalue) {
					$values	= [];
					/**
					 * Si se pasan parametros para la serializacion de un campo
					 * $serial->field :  Es el nombre del campo a serializar
					 * $serial->length : Es la longitud del campo a serializar
					 */
					
					if ($serial) {
						
						if(count($where) > 0){
							$this->db->where($where);
						}
						foreach ($fiels_table as $fieldvalue) {
							if( strtolower($fieldvalue->name) == "year"){
								$this->db->where($fieldvalue->name, $this->get_year());
								break;
							}
						}

						$this->db->select($serial->field);	
						$this->db->order_by($serial->field, 'desc');
						$query	= $this->db->get($table, 1);
						if ($query->num_rows() > 0) {
							$valSerial	= $query->row($serial->field);
						}else{
							$valSerial	= '0';
						}
						$length		= ($serial->length) ? $serial->length : $serial->lenght;
						$nroSerial	= str_pad(strval($valSerial) + 1, $length,'0',STR_PAD_LEFT);
						$values[$serial->field]	= $nroSerial;
					}

					foreach ($sendvalue as $field => $value) {
						/**
						* @var Se hace el recorrido por todos los campos de la estructura de la tabla
						* para guardar los datos correctos
						*/
						foreach ($fiels_table AS $field_compare) {
							/**
							* @var Nombre del campo
							*/
							$name 		= $field_compare->name;	
							$type		= $field_compare->type;			
							/**
							* 
							* @var Si no es un campo primario recorre el array con los datos
							* y compara si los campos son iguales y alamcena los datos en las variables
							* para  preparar el insert
							* 
							*/
							if($field_compare->primary_key == 0){
								/**
								* @var Si los campos son iguales almacena los datos en las 
								* variables $db_field y $db_value
								*/

								if (strtoupper($field) === strtoupper($name)) {
									if($type == 'date'){
										$values[$field] = date('Y-m-d',strtotime($value));
									}else{
										$values[$name]	= $value;
									}
									break;
								}elseif(strtolower($name) == "year"){
									$values[$name]	= $this->get_year();
								}  
							}else{
								$primaryKey	= $name;	
							}
						}
					}

					if(count($values) > 0){
						$this->db->insert($table, $values);
						$id	= $this->getInsertId();	
						if($primary_value){
							$$fieldsSend[]	= $id;
						}else{			
							$this->db->where($primaryKey, $id);
							$query			= $this->db->get($table,1);
							$fieldsSend[]	= $query->row();
						}
					}
				}	
				$this->trans_commit();
				$request	= $this->getJsonResponse($fieldsSend,count($fieldsSend));		
			}else{
				$values	= [];
				/**
				 * Si se pasan parametros para la serializacion de un campo
				 * $serial->field :  Es el nombre del campo a serializar
				 * $serial->length : Es la longitud del campo a serializar
				 */
				if ($serial) {
					foreach ($fiels_table as $fieldvalue) {
						if( strtolower($fieldvalue->name) == "year"){
							$this->db->where($fieldvalue->name, $this->get_year());
							break;
						}
					}

					$this->db->select($serial->field);	
					$this->db->order_by($serial->field, 'desc');
					$query	= $this->db->get($table, 1);
					if ($query->num_rows() > 0) {
						$valSerial	= $query->row($serial->field);
					}else{
						$valSerial	= '0';
					}
					$nroSerial	= str_pad(strval($valSerial) + 1, $serial->length,'0',STR_PAD_LEFT);
					$values[$serial->field]	= $nroSerial;
				}

				foreach ($fields as $field => $value) {
					/**
					* @var Se hace el recorrido por todos los campos de la estructura de la tabla
					* para guardar los datos correctos
					*/
					foreach ($fiels_table AS $field_compare) {
						/**
						* @var Nombre del campo
						*/
						$name 		= $field_compare->name;
						$primaryKey	= $field_compare->primary_key;	
						$type		= $field_compare->type;			
						/**
						* 
						* @var Si no es un campo primario recorre el array con los datos
						* y compara si los campos son iguales y alamcena los datos en las variables
						* para  preparar el insert
						* 
						*/
						if($primaryKey == 0){
							/**
							* @var Si los campos son iguales almacena los datos en las 
							* variables $db_field y $db_value
							*/

							if (strtoupper($field) === strtoupper($name)) {
								if($type == 'date'){
									$values[$name] = date('Y-m-d',strtotime($value));
								}else{
									$values[$name]	= $value;
								}
								break;
							}elseif(strtolower($name) == "year"){
								$values[$name]	= $this->get_year();
							}  
													
						}	
					}
				}

				if(count($values) > 0){
					$this->db->insert($table, $values);
					$id	= $this->getInsertId();	
					if($primary_value){
						$request	= $id;
					}else{			
						$this->db->where($primaryKey, $id);
						$query		= $this->db->get($table,1);
						$request	= $this->getJsonResponse($query->result_array(),1);
					}
				}else{
					$request	= $this->getJsonResponse([],0);
				}
			}
	  		$this->trans_commit();
		} catch (Exception $e) {
			$this->trans_rollback();
			$request  = $this->getError($e->getMessage());
		}finally{
			// $this->db->close();
		}
		return $request;
	}
  	  	
  	/**
	  * Funcion para realizar la accion de actualizacion en el servidor usando un campo primario
	  * @table STRING Nombre de la tabla donde se realizará la accion
	  * @data ARRAY  Lista del array codificado en formato JSON para actualizar en el servidor
	  * 
	  * @return 
	  */
	
	public function updateData ($table, $data, $primaryKey	= "id") {
		$db         = $this->get_db_name();
		$table		= $db.'.'.$table;  
		$primary_key_name 	= ''; // Nombre del campo primario de la tabla		
		$values				= '';		
		$return_value 		= NULL;		
		$i	= 0;	
		try {	
			/**
			* @$fiels_table : Obtiene la lista de los campos de la tabla donde se realizará el UPDATE
			*/				
			$fiels_table = $this->db->field_data($table);
			if(is_array($data)){ // Si es más de un registro				
				// Se inicia una transaccion			
				$this->trans_begin();			
				foreach ($data as $value_data) {
					$values		= [];
					$where		= [];
					/**
					* Se hace el recorrido por todos los campos de la estructura de la tabla
					* para guardar los datos correctos
					*/
					foreach ($value_data as $field => $value) {
						foreach ($fiels_table AS $field_compare) {	
							// Se almacena el nombre del campo
							$name 		= $field_compare->name;
							$primaryKey	= $field_compare->primary_key;
							$type		= $field_compare->type;
							/**
							* Si es un campo primario recorre el array con los datos
							* y compara si los campos son iguales y alamcena los datos en las variables
							* para  preparar el insert
							*/
							if($primaryKey == 1){
								$where[$name]    	= $value;
							}else{
								/**
								* Si los campos son iguales almacena los datos en las 
								* variable $values
								*/
								if (strtoupper($field) == strtoupper($name)) {
									if($type == 'date'){
										$values[$field] = date('Y-m-d',strtotime($value));
									}else{
										$values[$field] = $value;
									}
									break;
								}    
							}		
						}	
					}		
					if (count($values) > 0){
						$this->db->where($where);				
						$this->db->update($table, $values);
						$request	= $this->getJsonResponse([],0);
					}	
				}			
				$this->trans_commit();			
				if($this->trans_status()){
					$request	= $this->getJsonResponse([],0);
				}else{
					$request	= $this->getError();
				}
			}else{
				$values		= [];
				$where		= [];
				/**
				* Se hace el recorrido por todos los campos de la estructura de la tabla
				* para guardar los datos correctos
				*/
				foreach ($data as $field => $value) {
					foreach ($fiels_table AS $field_compare) {	
						// Se almacena el nombre del campo
						$name 		= $field_compare->name;
						$primaryKey	= $field_compare->primary_key;
						$type		= $field_compare->type;
						/**
						* Si es un campo primario recorre el array con los datos
						* y compara si los campos son iguales y alamcena los datos en las variables
						* para  preparar el insert
						*/
						if($primaryKey == 1){
							$where[$name]    	= $value;
						}else{
							/**
							* Si los campos son iguales almacena los datos en las 
							* variable $values
							*/
							if (strtoupper($field) == strtoupper($name)) {
								if($type == 'date'){
									$values[$field] = date('Y-m-d',strtotime($value));
								}else{
									$values[$field] = $value;
								}
								break;
							}    
						}		
					}	
				}		
				if (count($values) == 0){
					$request	= $this->getJsonResponse([],0);
				}else{
					$this->db->where($where);				
					$this->db->update($table, $values);
					$request	= $this->getJsonResponse([],0);
				}			
			}
		} catch (Exception $e) {
			$request  = $this->getError($e->getMessage());
		}finally{
			// $this->db->close();
		}
		return $request;  	
   	}
  	
  	
  	/**
	  * Funcion SQL para eliminar un registro de una tabla
	  * @param string $table  Nombre de la tabla
	  * @param array $where  Condicion para realizar el borrado
	  * 
	  * @return Json
	  */
  	public function deleteData ($tb,$records,  $primaryKey	= "id"){
		$db         = $this->get_db_name();	
  		$table	= $db.'.'.$tb;
  		try{
			$this->trans_begin();
			
			$fields	= $records;
			
			/**
			* 
			* @var $fiels_table : Obtiene la lista de los campos de la tabla donde se realizará el INSERT
			* 
			*/		
			$fiels_table = $this->db->field_data($table);
			
			if (is_array($fields)) {
				foreach ($fields as $fieldslist) {
					foreach ($fieldslist as $field => $value) {
						$data	= [];	
						foreach ($fiels_table AS $field_compare){
						
							$name 	= $field_compare->name;
	
							if (strtoupper($field) === strtoupper($name)) {
								$data[$field]	= $value;
								break;
							}   
						}	
					}	
					$this->db->delete($table,$data);
				}
				$data	= [];	
				$this->trans_commit();
				$request = $this->getJsonResponse($data,1);
			}else{
				foreach ($fields as $field => $value) {
					$data	= [];	
					foreach ($fiels_table AS $field_compare){
					
						$name 	= $field_compare->name;

						if (strtoupper($field) === strtoupper($name)) {
							$data[$field]	= $value;
							break;
						}   
					}	
				}	
				$this->db->delete($table,$data);
			}
			
			$this->trans_commit();
			$request = $this->getJsonResponse($data,1);
		} catch (Exception $e) {
			$request  = $this->getError($e->getMessage());
		}finally{
			// $this->db->close();
		}
		
		return $request;
	}
	
    /**
     * Función que retorna la consulta en una tabla
     *
     * @param string $table Nombre de la tabla
     * @param integer $limit
     * @param integer $offset
     * @param string $where
     * @return void
     */
    function getTable($table, $offset, $limit, $query, $where = [], $order = [])
    {
		try {
			$db		= $this->get_db_name();
			$table	= $db.'.'.$table;
			$fields_table 	= $this->db->field_data($table);
			if ($query) {
				$searchField	= "";
				foreach ($fields_table as $value) {
					if(count($where) > 0){
						$this->db->where($where);
					}
					$name = $value->name;

					if(strtolower($name) == "year"){
						$this->db->where($name, $this->get_year());
					}

					$this->db->like($name,$query);
					$this->db->limit(1);
					$select	= $this->db->get($table);
					if($select->num_rows() > 0 ){
						$searchField	= $name;
						break;
					}
				}

				if (strlen($searchField) > 0) {
					if(count($where) > 0){
						$this->db->where($where);
					}
					$this->db->like($searchField,$query);
					$total 		= $this->db->from($table)->count_all_results();

					if(count($where) > 0){
						$this->db->where($where);
					}
					$this->db->like($name,$query);
					$this->db->limit($limit, $offset);            
					$result  	= $this->db->get($table);
					$result  	= $result->result_array();
					$result 	= $this->getJsonResponse($result, $total);
				}else {
					$result 	= $this->getJsonResponse(null, 0);
				}

			}else{
				$searchField	= "";
				$whereVig		= [];
				foreach ($fields_table as $value) {
					
					$name = $value->name;

					if(strtolower($name) == "year"){
						$whereVig[$name]	= $this->get_year();
					break;
					}
				}

				if(count($where) > 0){
					$this->db->where($where);
				}

				if(count($whereVig) > 0){
					$this->db->where($whereVig);
				}

				$total 		= $this->db->from($table)->count_all_results();
				if(count($where) > 0){
					$this->db->where($where);
				}
				if(count($whereVig) > 0){
					$this->db->where($whereVig);
				}
				$this->db->limit($limit, $offset);            
				$result  	= $this->db->get($table);
				$result  	= $result->result_array();
				$result 	= $this->getJsonResponse($result, $total);
			}
		} catch (Exception $e) {
			$result  = $this->getError($e->getMessage());
		}finally{
			// $this->db->close();
		}
		
        return  $result;
    }
	
	
	/**
	* Funcion que retorna el Json al cliente cuando se realiza un SELECT
	* @fields Lista de filas a devolver 
	* @reccount Cantidad de regustros 
	* 
	* @return Retorna un Json_encode
	*/
	public function getJsonResponse ($fields,$total)
	{
		$request = array(
			'records'	    => $fields,
			'total' 		=> $total,
			'success'       => TRUE,
			'year'			=> $this->get_year(),
			'date'			=> date('Y-m-d'),
			'id_user'		=> $this->get_user_id(),
			'id_school'		=> $this->get_id_school(),
			'user_type'		=> $this->session->userdata('user_type')
		);
		
		/**
		* Respuesta en formato Json
		*/
		$request = json_encode($request);
			
		/**
		* Enviamos la repustas en formato Json
		*/
	 	return $request	;
	}
		
	/**
	* Inicia una transacción
	* 
	* @return
	*/	
	public function	trans_begin()
	{
		$this->db->trans_begin();
	}
	
	/**
	* Termina la transacción y cancela los cambios
	* 
	* @return
	*/	
	public function	trans_rollback()
	{
		$this->db->trans_rollback();
	}


	/**
	* Termina la transacción y confirma los cambios
	* 
	* @return
	*/	
	public function	trans_commit()
	{
		$this->db->trans_commit();
	}

	/**
	* Retorna el untimo id insertado
	* @return INT
	*/
	public function getInsertId(){
		return  $this->db->insert_id();
	}

	/**
	* Funcion que realiza un INSERT.
	* @param string $table - nombre de la tabla,
	* @param array  $array - lista de campos y datos a insertar
	* @param array  $extra - datos extras a insertar
	* 
	* @return
	*/
	
	public function insert_data ($table, $array, $extra = NULL){
		$db_field = '';
		$db_value = '';
		
		$db_field1 = '';
		$db_value1 = '';
		$db	= $this->get_db_name();
		foreach ($array as $field => $value) {
			if (strtoupper($field) <> 'ID') {
				$db_field = $db_field.$field.",";
      			$db_value = $db_value."'".$value."',";
			}      		
  		}
  		
  		if ($extra <> NULL){
  			foreach($extra as $key => $value){
			  	$db_field1 = $db_field1.$key.",";
      			$db_value1 = $db_value1."'".$value."',";
			}		
		}
  		
  		$field_insert = $db_field.$db_field1 ;
  		$value_insert = $db_value.$db_value1;
  		
  		$field_insert = substr($field_insert,0,strlen($field_insert)-1);
  		$value_insert = substr($value_insert,0,strlen($value_insert)-1);

  		$query	=  "INSERT INTO ".$db.".".$table." (".$field_insert.") VALUES (".$value_insert.")";
  		$query  = $this->db->query($query);
  	
  		if ($query) {
  			$list	= array(
  				'id' => $this->db->insert_id()
  			);
				$request = $this->getJsonResponse($list,1);
			}else{
				$request = $this->getError();
			}
			return $request;
  }
  	
  	
  	/**
	  * Funcion para realizar un INSERT  a una tabla con campos primarios 
	  * auto incrementables
	  * 
	  * @table string Nombre de la tabla
	  * @array_data array  lista de campos y datos a insertar
	  * @extra_data array datos extras a insertar
	  * @primary_value Boolean Bebe pasar un valor TRUE si desea obtener el valor del campo primario sin codificación JSON.
	  * 
	  * 
	  * @return
	  */
  	public function insert_data_primary($table, $array_data, $extra_data = NULL, $primary_value = FALSE ) {
		$this->openconn();
		$db		= 		$this->get_db_name();
		$db_field 	= '';
		$db_value 	= '';
		$table		= $db.'.'.$table;
		$db_field1 	= '';
		$db_value1 	= '';
		
		$value_insert	= '';
		
		$i		= 0;
		$count 	= 0;
		
		if(isset($table) AND isset($array_data)){
			
			$fields	= $array_data;
			if(is_array($fields)){
				$count	= count($fields); // Contamos la cantidad de registros a insertar.
			}
						
			$primary_key_name = 'id'; // Nombre del campo primario de la tabla
			
			/**
			* 
			* @var $fiels_table : Obtiene la lista de los campos de la tabla donde se realizará el INSERT
			* 
			*/		
			$fiels_table = $this->db->field_data($table);
			/**
			* 
			* @var Si hay más de un registro que insertar
			* 
			*/
			if($count > 1){
				for($i = 0; $i < $count; $i++){
					/**
					* 
					* @var Se hace el recorrido por todos los campos de la estructura de la tabla
					* para guardar los datos correctos
					* 
					*/
					foreach ($fiels_table AS $field_compare) {
						
						/**
						* 
						* @var Nombre del campo
						* 
						*/
						$name = $field_compare->name;
						
						/**
						* 
						* @var Tipo de campo, si es primario devuelve 1, sino 0
						* 
						*/
						$primary_key = $field_compare->primary_key;
						
						/**
						* 
						* @var Si no es un campo primario recorre el array con los datos
						* y compara si los campos son iguales y alamcena los datos en las variables
						* para  preparar el insert
						* 
						*/
						if($primary_key == 0){
							
							$fields = $array_data[$i];
							
							foreach ($fields as $field => $value) {
								/**
								* 
								* @var Si los campos son iguales almacena los datos en las 
								* variables $db_field y $db_value
								* 
								*/
								if (strtoupper($field) === strtoupper($name)) {
									$db_field = $db_field.$field.",";
					      			$db_value = $db_value."'".$value."',";
					      			break;
								}      		
					  		}
					  		
					  		if ($extra_data <> NULL){
					  			
					  			foreach($extra_data as $key => $value){
					  			/**
								* 
								* @var Si los campos son iguales almacena los datos en las 
								* variables $db_field1 y $db_value1
								* 
								*/
					  				if (strtoupper($key) === strtoupper($name)) {
									  	$db_field1 = $db_field1.$key.",";
						      			$db_value1 = $db_value1."'".$value."',";
						      		}
						      		
								}		
							}
																					  		
						}else{
							$primary_key_name	= $name;
						}
					}
					
					$values		 	= $db_value.$db_value1;
					$field_insert	= $db_field.$db_field1;
					
					$value_insert	= $value_insert."(".substr($values,0,strlen($values)-1)."),";
					$field_insert	= substr($field_insert,0,strlen($field_insert)-1);	
					
					$db_field 	= '';
					$db_field1	= '';		
					
					$db_value	= '';
					$db_value1	= '';
				}		
			}else{
				/**
				* 
				* @var Se hace el recorrido por todos los campos de la estructura de la tabla
				* para guardar los datos correctos
				* 
				*/
				foreach ($fiels_table AS $field_compare) {
					
					/**
					* 
					* @var Nombre del campo
					* 
					*/
					$name = $field_compare->name;
					
					/**
					* 
					* @var Tipo de campo, si es primario devuelve 1, sino 0
					* 
					*/
					$primary_key = $field_compare->primary_key;
					
					/**
					* 
					* @var Si no es un campo primario recorre el array con los datos
					* y compara si los campos son iguales y alamcena los datos en las variables
					* para  preparar el insert
					* 
					*/
					if($primary_key == 0){
						
						foreach ($fields as $field => $value) {
							/**
							* 
							* @var Si los campos son iguales almacena los datos en las 
							* variables $db_field y $db_value
							* 
							*/
							if (strtoupper($field) === strtoupper($name)) {
								$db_field = $db_field.$field.",";
				      			$db_value = $db_value."'".$value."',";
				      			break;
							}      		
				  		}
				  		
				  		if ($extra_data <> NULL){				  			
				  			foreach($extra_data as $key => $value){
				  			/**
							* 
							* @var Si los campos son iguales almacena los datos en las 
							* variables $db_field1 y $db_value1
							* 
							*/
				  				if (strtoupper($key) === strtoupper($name)) {
								  	$db_field1 = $db_field1.$key.",";
					      			$db_value1 = $db_value1."'".$value."',";
					      		}
					      		
							}		
						}  
										  		
					}else{
						$primary_key_name	= $name;
					}		
				}
				
				$values		 	= $db_value.$db_value1;
				$field_insert	= $db_field.$db_field1;				
				$value_insert	= $value_insert."(".substr($values,0,strlen($values)-1)."),";
				$field_insert	= substr($field_insert,0,strlen($field_insert)-1);				
				$db_field 	= '';
				$db_field1	= '';						
				$db_value	= '';
				$db_value1	= '';
			}
	  		
	  		$value_insert	= substr($value_insert,0,strlen($value_insert)-1);	  		
	  		$query	=  "INSERT IGNORE INTO ".$table." (".$field_insert.") VALUES ".$value_insert.";";
	  		$query  = $this->db->query($query);	  	
	  		if ($query) {
	  			
	  			$id	= $this->last_insert_id();
	  			
	  			if($primary_value === TRUE){
					$request 	= $id;	
				  }else{				  	
				  	if ($id > 0){
						$list	= array(
			  				$primary_key_name => $id,
			  				'year'			  => $this->get_year()
			  			);			
						$request = $this->get_request_insert($list);	
					}else{
						$request	= $this->get_request_ab();
					}
				  				
				  }
	  			
			}else{
				$request = $this->get_error();
			}
		}else{
			$request = $this->get_error();
		}
		return $request;
	}
  	
  	/**
	  * Funcion para realizar actulizaciones en el servidor
	  * @param string $table - Nombre de la tabla a actualizar.
	  * @param array  $array - Lista datos.
	  * @param string $where - La clausula para la actualización
	  * 
	  * @return
	  */
  	public function update_data ($table, $array, $where) {
  	  $this->openconn();
  	  $tb	= $this->get_db_name().".".$table;
	  	$str = $this->db->update_string($tb,$array,$where);
	  	
			$query = $this->db->query($str);		
			if ($query) {
				$request	= $this->get_request_ab();
			}else{
				$request	= $this->get_error();
			}	
			return $request;  	
  	}
  	
  	/**
	  * Funcion para realizar la accion de actualizacion en el servidor usando un campo primario
	  * @table STRING Nombre de la tabla donde se realizará la accion
	  * @array_data ARRAY  Lista del array codificado en formato JSON para actualizar en el servidor
	  * @return_val BOOLEAN Pasar TRUE para que devuelva el valor del campo.
	  * 
	  * @return 
	  */
  	
	public function update_data_primary ($tb, $array_data, $return_val = FALSE) {
  	    $this->openconn();
  	  	$table	= $this->get_db_name().".".$tb;
  	  	$fields	= json_decode($array_data);
  	  	
  		if(is_array($fields)){
			$count	= count($fields); // Contamos la cantidad de registros a insertar.
		}else{
			$count	= 0; // Se inserta 1 registro.
		}
					
		$primary_key_name = ''; // Nombre del campo primario de la tabla		
		$values			= '';		
		$return_value 	= NULL;		
		$i	= 0;		
		/**
		* @$fiels_table : Obtiene la lista de los campos de la tabla donde se realizará el UPDATE
		*/				
		$fiels_table = $this->db->field_data($table);
		if($count > 1){ // Si es más de un registro				
			// Se inicia una transaccion			
			$this->trans_start();			
			for($i = 0; $i < $count; $i++){				
				$fields_val = $fields [$i];
				/**
				* Se hace el recorrido por todos los campos de la estructura de la tabla
				* para guardar los datos correctos
				* 
				*/
				$values		= [];	
				$where		= [];
				foreach ($fiels_table AS $field_compare) {					
					
					// Nombre del campo
					$name = $field_compare->name;
					
					// Tipo de campo, si es primario devuelve 1, sino 0
					$primary_key = $field_compare->primary_key;
					
					/**
					* Si es un campo primario recorre el array con los datos
					* y compara si los campos son iguales y alamcena los datos en las variables
					* para  preparar el insert
					*/
					
					if($primary_key == 0){												
						foreach ($fields_val as $field => $value) {
							/**
							* Si los campos son iguales almacena los datos en las 
							* variables $db_field y $db_value
							*/
							if (strtoupper($field) == strtoupper($name)) {
								$values[$field] = $value;
								break;
							}      		
						}
					}else{
						$where[$name]    	= $fields_val->$name;
					}		
				}			
				if (count($values) > 0){
					$this->db->where($where);				
				 	$query = $this->db->update($table, $values);
				}				
				$primary_key_name 	= '';
			}			
			$this->trans_complete();			
			if($this->trans_status()){
				$request	= $this->get_request_ab();
			}else{
				$request	= $this->get_error();
			}
			
		}else{
			/**
			* Se hace el recorrido por todos los campos de la estructura de la tabla
			* para guardar los datos correctos
			*/
			$values		= [];
			$where		= [];
			foreach ($fiels_table AS $field_compare) {	
				// Nombre del campo
				$name = $field_compare->name;
				// 	Tipo de campo, si es primario devuelve 1, sino 0	
				$primary_key = $field_compare->primary_key;				
				/**
				* Si es un campo primario recorre el array con los datos
				* y compara si los campos son iguales y alamcena los datos en las variables
				* para  preparar el insert
				*/
				if($primary_key == 0){
					foreach ($fields as $field => $value) {
						/**
						* Si los campos son iguales almacena los datos en las 
						* variables $db_field y $db_value
						*/
						if (strtoupper($field) == strtoupper($name)) {
							$values[$field] = $value;
			      			break;
						}      		
			  		}
				}else{
					$where[$name]    	= $fields->$name;
				}		
			}
			if (count($values) == 0){
				$request	= $this->get_request_ab();
			}else{
				$this->db->where($where);				
				$query = $this->db->update($table, $values);
				if ($query) {					
					if ($return_val) {						
						$request	= $return_value;						
					}else{
						$request	= $this->get_request_ab();
					}					
				}else{
					$request	= $this->get_error();
				}	
			}			
		}
		return $request;  	
   	}
  	
  	
  	/**
	  * Funcion SQL para eliminar un registro de una tabla
	  * @param string $table  Nombre de la tabla
	  * @param array $where  Condicion para realizar el borrado
	  * 
	  * @return Json
	  */
  	public function delete_data ($tb,$listvalues){
  		$this->openconn();
  		$table	= $this->get_db_name().".".$tb;
  		if(isset($table) AND isset($listvalues)){
  			
  			$this->trans_start();
  			
  			$fields	= json_decode($listvalues);
  			if(is_array($fields)){
				$count	= count($fields); // Contamos la cantidad de registros a insertar.
			}else{
				$count	= 0; // Se inserta 1 registro.
			}
  		
			$i  	= 0;
			  			  			
  			
	  		$db_field = '';
			
			$primary_key_name = 'id'; // Nombre del campo primario de la tabla
			
			/**
			* 
			* @var $fiels_table : Obtiene la lista de los campos de la tabla donde se realizará el INSERT
			* 
			*/		
			$fiels_table = $this->db->field_data($table);
			
			if ($count > 1) {
				
				for($i = 0; $i < $count; $i++){
					/**
					* 
					* @var Se hace el recorrido por todos los campos de la estructura de la tabla
					* para guardar los datos correctos
					* 
					*/
					foreach ($fiels_table AS $field_compare){
						
						/**
						* 
						* @var Nombre del campo
						* 
						*/
						$name = $field_compare->name;
						
						/**
						* 
						* @var Tipo de campo, si es primario devuelve 1, sino 0
						* 
						*/
						$primary_key = $field_compare->primary_key;
						
						/**
						* 
						* @var SE recorre el array con los datos
						* y compara si los campos son iguales y alamcena los datos en las variables
						* para  preparar el DELETE
						* 
						*/
						
						$fields_value = $fields [$i];
						
						foreach ($fields_value as $field => $value) {
							/**
							* 
							* @var Si los campos son iguales almacena los datos en las 
							* variables $db_field
							* 
							*/
							if (strtoupper($field) === strtoupper($name)) {
								$db_field = $db_field.$field."=".$value." AND ";
				      			break;
							}      		
				  		}		
					}	
				  		
			  		$field_delete = substr($db_field,0,strlen($db_field)-5);
			  		 		  		  		
					$query 	= "DELETE FROM ".$table." WHERE ".$field_delete.' LIMIT 1';
					
					$query	= $this->db->query($query);	
					
					$db_field = ''	;
				}
			
			}else{
			
				/**
				* 
				* @var Se hace el recorrido por todos los campos de la estructura de la tabla
				* para guardar los datos correctos
				* 
				*/
				foreach ($fiels_table AS $field_compare){
					
					/**
					* 
					* @var Nombre del campo
					* 
					*/
					$name = $field_compare->name;
					
					/**
					* 
					* @var Tipo de campo, si es primario devuelve 1, sino 0
					* 
					*/
					$primary_key = $field_compare->primary_key;
					
					/**
					* 
					* @var SE recorre el array con los datos
					* y compara si los campos son iguales y alamcena los datos en las variables
					* para  preparar el DELETE
					* 
					*/
				
					foreach ($fields as $field => $value) {
						/**
						* 
						* @var Si los campos son iguales almacena los datos en las 
						* variables $db_field
						* 
						*/
						if (strtoupper($field) === strtoupper($name)) {
							$db_field = $db_field.$field."=".$value." AND ";
			      			break;
						}      		
			  		}		
				}	
			  		
		  		$field_delete = substr($db_field,0,strlen($db_field)-5);
		  		 		  		  		
				$query 	= "DELETE FROM ".$table." WHERE ".$field_delete.' LIMIT 1';
				
				$query	= $this->db->query($query);
			}
			
			$this->trans_complete();
		
			if ($this->trans_status()) {
				$request = $this->get_request_ab();
			}else{
				$request = $this->get_error();
			}	
		
		}else{
			$request	= $this->get_error();
		}
		return $request;
	}
	
	public function delete_data_extra($table,$listvalues,$extra_data = NULL){
  		$this->openconn();
  		if(isset($table) AND isset($listvalues)){
  			
  			$this->trans_start();
  			
  			$fields	= json_decode($listvalues);
  			
  			$count	= count($fields);
			$i  	= 0;
			  			  			
  			
	  		$db_field = '';
	  		$db_field1 = '';
			
			$primary_key_name = 'id'; // Nombre del campo primario de la tabla
			
			/**
			* 
			* @var $fiels_table : Obtiene la lista de los campos de la tabla donde se realizará el INSERT
			* 
			*/		
			$fiels_table = $this->db->field_data($table);
			
			if ($count > 1) {
				
				for($i = 0; $i < $count; $i++){
					/**
					* 
					* @var Se hace el recorrido por todos los campos de la estructura de la tabla
					* para guardar los datos correctos
					* 
					*/
					foreach ($fiels_table AS $field_compare){
						
						/**
						* 
						* @var Nombre del campo
						* 
						*/
						$name = $field_compare->name;
						
						/**
						* 
						* @var Tipo de campo, si es primario devuelve 1, sino 0
						* 
						*/
						$primary_key = $field_compare->primary_key;
						
						/**
						* 
						* @var SE recorre el array con los datos
						* y compara si los campos son iguales y alamcena los datos en las variables
						* para  preparar el DELETE
						* 
						*/
						
						$fields_value = $fields [$i];
						
						foreach ($fields_value as $field => $value) {
							/**
							* 
							* @var Si los campos son iguales almacena los datos en las 
							* variables $db_field
							* 
							*/
							if (strtoupper($field) === strtoupper($name)) {
								$db_field = $db_field.$field."=".$value." AND ";
				      			break;
							}      		
				  		}
				  		
				  		if ($extra_data <> NULL){
					  			
					  			foreach($extra_data as $key => $value){
					  			/**
								* 
								* @var Si los campos son iguales almacena los datos en las 
								* variables $db_field1 y $db_value1
								* 
								*/
					  				if (strtoupper($key) === strtoupper($name)) {
									  	$db_field1 = $db_field1.$key."=".$value." AND ";
									  	break;
						      		}
						      		
								}		
							}		
					};
					
					$db_field = $db_field.$db_field1;
				  		
			  		$field_delete = substr($db_field,0,strlen($db_field)-5);
			  		 		  		  		
					$query 	= "DELETE FROM ".$table." WHERE ".$field_delete;
					
					$query	= $this->db->query($query);	
					
					$db_field = ''	;
				}
			
			}else{
			
				/**
				* 
				* @var Se hace el recorrido por todos los campos de la estructura de la tabla
				* para guardar los datos correctos
				* 
				*/
				foreach ($fiels_table AS $field_compare){
					
					/**
					* 
					* @var Nombre del campo
					* 
					*/
					$name = $field_compare->name;
					
					/**
					* 
					* @var Tipo de campo, si es primario devuelve 1, sino 0
					* 
					*/
					$primary_key = $field_compare->primary_key;
					
					/**
					* 
					* @var SE recorre el array con los datos
					* y compara si los campos son iguales y alamcena los datos en las variables
					* para  preparar el DELETE
					* 
					*/
				
					foreach ($fields as $field => $value) {
						/**
						* 
						* @var Si los campos son iguales almacena los datos en las 
						* variables $db_field
						* 
						*/
						if (strtoupper($field) === strtoupper($name)) {
							$db_field = $db_field.$field."=".$value." AND ";
			      			break;
						}      		
			  		};
			  		
			  		if ($extra_data <> NULL){
					  			
			  			foreach($extra_data as $key => $value){
			  			/**
						* 
						* @var Si los campos son iguales almacena los datos en las 
						* variables $db_field1 y $db_value1
						* 
						*/
			  				if (strtoupper($key) === strtoupper($name)) {
							  	$db_field1 = $db_field1.$key."=".$value." AND ";
							  	break;
				      		}
				      		
						}		
					};			
				};
				
				$db_field = $db_field.$db_field1;
			  		
		  		$field_delete = substr($db_field,0,strlen($db_field)-5);
		  		 		  		  		
				$query 	= "DELETE FROM ".$table." WHERE ".$field_delete;
				
				$query	= $this->db->query($query);
			}
			
			$this->trans_complete();
		
			if ($this->trans_status()) {
				$request = $this->get_request_ab();
			}else{
				$request = $this->get_error();
			}	
		
		}else{
			$request	= $this->get_error();
		}
		return $request;
	}
		 
	/** 
	* Funcion que retorna el numero de periodos académicos a trabajar
	*/
	public function	get_periodos($grado,$type)
	{
		$db		= $this->get_db_name();
		$ye		= $this->get_year();
		switch($type){
			case 1:
				$this->db->select('t1.*, t2.nombre_grado_agrupado');
				$this->db->from($db.'.periodos_academicos AS t1');
				$this->db->join($db.'.grados_agrupados AS t2', 't1.id_grado_agrupado = t2.id', 'left');
				$this->db->where('t1.year', $ye);
				$this->db->order_by('t2.nombre_grado_agrupado, t1.periodo');
				break;
			case 2:
				$this->db->select('t1.periodo');
				$this->db->from($db.'.periodos_academicos AS t1');
				$this->db->where('t1.year', $ye);
				$this->db->group_by('t1.periodo,t1.year');				
				$this->db->order_by('t1.periodo');
				break;
			default:
				$this->db->select('t1.*, t2.nombre_grado_agrupado');
				$this->db->from($db.'.periodos_academicos AS t1');
				$this->db->join($db.'.grados_agrupados AS t2', 't1.id_grado_agrupado = t2.id', 'left');
				$this->db->join($db.'.aux_grados_agrupados AS t3', 't3.id_grado_agrupado = t2.id', 'left');
				$this->db->where('t1.year', $ye);
				$this->db->where('t3.id_grado', $grado);				
				$this->db->order_by('t2.nombre_grado_agrupado, t1.periodo');
				break;
		}		
		$query	= 	$this->db->get();			
		return $this->get_request_select($query->result_array(),$query->num_rows());	;		
	}

 	
	/**
	* 
	* @param INTEGER $limit_min - Rango de registros desde donde se iniciará la consulta
	* @param INTEGER $limit_max - Limite máximo de registros a mostrar
	* @param STRING  $query - Cadena que contiene la sentencia SQL SELECT
	* @param STRING  $where - Cadena que contiene la clausula SQL WHERE
	* @param ARRAY() $param - Array con los parametros de la clausula SQL WHERE
	* 
	* @return - Devuelve en formato Json los registros
	*/	
	public function get_query_param($limit_min = 0,$limit_max=30,$query = NULL, $where = NULL, $param = array(),$tbl="",$page = TRUE) 
	{
		$this->openconn();
		if($query == NULL OR $where == NULL OR $param ==array() ){
			$request = array(
				'success' 	=> FALSE,
				'msg'		=> 'Uno de los parametros está vacio',
				'select ' 	=> $query, 
				'where ' 	=> $where,
				'param' 	=> $param
			);
			$request =  json_encode($request);
		}else{	
			if ($page){
				/* 
				* Consulta con limite de registros
				*/				
				if ($limit_max == 0){
					$sqlconsul= $query." WHERE ".$where;
				}else{
					$sqlconsul= $query." WHERE ".$where." LIMIT ".$limit_min.",".$limit_max;
				}			
				/* 
				* Consulta con el total de registros
				*/
				$sqlconsul2= $query." WHERE ".$where;
					
				$query  = $this->db->query($sqlconsul,$param);
				if (empty($tbl)){
					$query2  = $this->db->query($sqlconsul2,$param);	
				}else{
					$query2  = $this->db->query($tbl);
				}
					
				if ($query AND $query2) 
				{
					if (empty($tbl)){
						$reccount = $query2->num_rows(); //Cantidad de registros de la tabla
					}else{
						$reccount = $query2->row('total'); //Cantidad de registros de la tabla
					}
				 	
				 	
				 	/**
					* Armamos el array de registros de la tabla cursos y su campos
					*/

					$fields_list = NULL;
					
				 	foreach ($query->result_array() as $field)
				 	{
						$fields_list [] = $field;
					}
					
			
					/**
					* Respuesta en formato Json
					*/
					$request = $this->get_request_select($fields_list,$reccount);
					
				} else {
					$request = $this->get_error();	
				}	
			}else{
				/* 
				* Consulta con limite de registros
				*/
				
				if ($limit_max == 0){
					$sqlconsul= $query." WHERE ".$where;
				}else{
					$sqlconsul= $query." WHERE ".$where." LIMIT ".$limit_min.",".$limit_max;
				}
				
									
				$query  = $this->db->query($sqlconsul,$param);
				
					
				if ($query) 
				{
					$reccount = $query->num_rows(); //Cantidad de registros de la tabla
				 	
				 	/**
					* Armamos el array de registros de la tabla cursos y su campos
					*/

					$fields_list = NULL;
					
				 	foreach ($query->result_array() as $field)
				 	{
						$fields_list [] = $field;
					}
					
			
					/**
					* Respuesta en formato Json
					*/
					$request = $this->get_request_select($fields_list,$reccount);
					
				} else {
					$request = $this->get_error();	
				}
			}
		}
		/**
		* Enviamos la repustas en formato Json
		*/
	 	return $request	;
	}

    /**
     * Función que retorna la consulta en una tabla
     *
     * @param string $table Nombre de la tabla
     * @param integer $limit
     * @param integer $offset
     * @param string $where
	 * @param string $order
     * @return void
     */
    function get_table($table, $limit = 0, $offset = 0, $where=NULL, $order=null)
    {

		$db	= $this->get_db_name();

        if(!is_null($where)){
            $this->db->where($where);
        }
        $total = $this->db->from($db.'.'.$table)->count_all_results();

        if(!is_null($where)){
            $this->db->where($where);
        }

		if(!is_null($order)){
			$this->db->order_by($order);
		}
		
        if($limit > 0 AND $offset >= 0){
            $this->db->limit($limit, $offset);            
        }

        $result  = $this->db->get($db.'.'.$table);
        if($result){
            $result  = $result->result_array();
            $result = $this->get_request_select($result, $total);
        }else{
            $result  = $this->get_error();
        }
        return  $result;
    }
	
	/**
	* 
	* @param INTEGER $limit_min - Rango de registros desde donde se iniciará la consulta
	* @param INTEGER $limit_max - Limite máximo de registros a mostrar
	* @param STRING  $query - Cadena que contiene la sentencia SQL SELECT
	* 
	* @return - Devuelve en formato Json los registros
	*/	
	public function get_query($limit_min = 0, $limit_max = 30, $query = NULL, $page = TRUE, $tbl = "") 
	{
		$this->openconn();
		/* 
		* Consulta con limite de registros
		*/
		if ($page){
			if ($limit_max == 0) {
				$sqlconsul= $query;
			}else{
				$sqlconsul= $query." LIMIT ".$limit_min.",".$limit_max;
			}	
			
			/* 
			* Consulta con el total de registros
			*/
			$sqlconsul2= $query;
				
			$query  = $this->db->query($sqlconsul);
			
			if (empty($tbl)){
				$query2  = $this->db->query($sqlconsul2);
			}else{
				$query2  = $this->db->query($tbl);	
			}
				
			if ($query AND $query2) 
			{
			 	if (empty($tbl)){
					$reccount = $query2->num_rows(); //Cantidad de registros de la tabla
				}else{
					$reccount = $query2->row('total'); //Cantidad de registros de la tabla
				}
			 	
			 	/**
				* Armamos el array de registros de la tabla cursos y su campos
				*/

				$fields_list = NULL;
				
			 	foreach ($query->result_array() as $field)
			 	{
					$fields_list [] = $field;
				}
				
		
				/**
				* Respuesta en formato Json
				*/
				$request = $this->get_request_select($fields_list,$reccount);
					
				/**
				* Enviamos la repustas en formato Json
				*/
			 	return $request	;
			} else {
				$request = $this->get_error();
				return $request;		
			}
		}else{
			/* 
			* Consulta con el total de registros
			*/					
			$quer  = $this->db->query($query);				
			if ($quer)			{
			 	$reccount = $quer->num_rows(); //Cantidad de registros de la tabla			 	
			 	/**
				* Armamos el array de registros de la tabla cursos y su campos
				*/
				$fields_list = NULL;				
			 	foreach ($quer->result_array() as $field)
			 	{
					$fields_list [] = $field;
				}		
		
				/**
				* Respuesta en formato Json
				*/
				$request = $this->get_request_select($fields_list,$reccount);
					
				/**
				* Enviamos la repustas en formato Json
				*/
			 	return $request	;
			} else {
				$request = $this->get_error();
				return $request;		
			}
		}
	}
	
		
	
	/**
	* Funcion que retorna el Json al cliente cuando se realiza un INSERT o un UPDATE
	* @param  $fields Lista de filas 
	* 
	* @return Retorna un Json_encode
	*/
	public function get_request_insert ($fields)
	{
		$request = array(
			'success'       =>TRUE,
			'records'		=> $fields,
			'date'			=> date('Y-m-d'),
			'id_user'		=> $this->get_user_id(),
			'id_school'		=> $this->get_id_school(),
			'year'			=> $this->get_year(),
			'user_type'		=> $this->session->userdata('user_type')
		);		
		/**
		* Respuesta en formato Json
		*/
		$request = json_encode($request);			
		/**
		* Enviamos la repustas en formato Json
		*/
	 	return $request	;
	}
	
	/**
	* Funcion que retorna el Json al cliente cuando se realiza un SELECT
	* @fields Lista de filas a devolver 
	* @reccount Cantidad de regustros 
	* 
	* @return Retorna un Json_encode
	*/
	public function get_request_select ($fields,$reccount)
	{
		$date	= date('Y-m-d');
		$request = array(
			'success'       =>TRUE,
			'records'	    => $fields,
			'total' 		=> $reccount,
			'date'			=> $date,
			'id_user'		=> $this->get_user_id(),
			'id_school'		=> $this->get_id_school(),
			'year'			=> $this->get_year(),
			'user_type'		=> $this->session->userdata('user_type')
		);
		
		/**
		* Respuesta en formato Json
		*/
		$request = json_encode($request);
			
		/**
		* Enviamos la repustas en formato Json
		*/
	 	return $request	;
	}
	
	/**
	* Funcion que retorna el Json al cliente cuando se realiza un DELETE 
	* @return Retorna un Json_encode
	*/
	public function get_request_ab ()
	{
		$request = array(
			'success'       => TRUE,
			'year'			=> $this->get_year(),
			'date'			=> date('Y-m-d'),
			'id_user'		=> $this->get_user_id(),
			'id_school'		=> $this->get_id_school(),
			'user_type'		=> $this->session->userdata('user_type')
		);
		
		/**
		* Respuesta en formato Json
		*/
		$request = json_encode($request);
			
		/**
		* Enviamos la repustas en formato Json
		*/
	 	return $request	;
	}
		
	/**
	* Establece la transacción
	* 
	* @return
	*/	
	public function	trans_start ()
	{
		$this->db->trans_start();
	}
	
	/**
	* Termina la transacción
	* 
	* @return
	*/	
	public function	trans_complete ()
	{
		$this->db->trans_complete();
	}
	
	/**
	* Retorna el estado de la transacción
	* 
	* @return
	*/	
	public function	trans_status ()
	{
		return	$this->db->trans_status();
	}
	
	/**
	* Funcion que retorna el nombre de la tabla de notas.
	* @param STRING $cod_grado
	* 
	* @return
	*/
	public function tabla_notas($cod_grado) {
		$c_grado	= $cod_grado;
		$table		= 'nscp00';
		$db	= $this->get_db_name();
		// Preescolar 
		if(($c_grado <= 4)) {
			$table = 'nscp00';
		}else{			
			// Educacion media y superior
			if ($c_grado > 13) {
				$table = 'nscp003';
			}else if ($c_grado >=5 AND $c_grado <=9) { // Educacion básica primaria
				$table = 'nscp001';
			}else{
				$table = 'nscp002'; // Educacion básica secundaria
			}	
		}		
		return $table;
	}
	
	/**
	* Funcion que retorna el nombre de la tabla de pre-informes.
	* @param STRING $cod_grado
	* 
	* @return
	*/
	public function tabla_pre_informe($cod_grado) {
		$c_grado	= $cod_grado;
		$table		= 'preinforme_nscp00';
		//$niv		= $this->get_nivel_escolar($Grado);
		// Preescolar 
		if(($c_grado <= 4)) {
			$table = 'preinforme_nscp00';
		}else{			
			// Educacion media y superior
			if ($c_grado > 13) {
				$table = 'preinforme_nscp003';
			}else if ($c_grado >=5 AND $c_grado <=9) { // Educacion básica primaria
				$table = 'preinforme_nscp001';
			}else{
				$table = 'preinforme_nscp002'; // Educacion básica secundaria
			}	
		}
		return $table;
	}
	
	
	
	/**
	* Funcion que retorna el nombre de la tabla de sugerencias.
	* @param STRING $cod_grado
	* 
	* @return
	*/
	public function tabla_sugerencias($c_grado) {
		$table		= 'sug_nscp00';
		//$niv		= $this->get_nivel_escolar($Grado);
		// Preescolar 
		if(($c_grado <= 4)) {
			$table = 'sug_nscp00';
		}else{			
			// Educacion media y superior
			if ($c_grado > 13) {
				$table = 'sug_nscp003';
			}else if ($c_grado >=5 AND $c_grado <=9) { // Educacion básica primaria
				$table = 'sug_nscp001';
			}else{
				$table = 'sug_nscp002'; // Educacion básica secundaria
			}	
		}		
		return $table;
	}
	
	/**
	* Funcion que retorna el nombre de la tabla de logros y estandades.
	* @param STRING $cod_grado
	* 
	* @return
	*/
	public function tabla_logros_estandares($c_grado = 0) {		
		$table		= 'log_nscp00';
		//$niv		= $this->get_nivel_escolar($Grado);
		// Preescolar 
		if(($c_grado <= 4)) {
			$table = 'log_nscp00';
		}else{			
			// Educacion media y superior
			if ($c_grado > 13) {
				$table = 'log_nscp003';
			}else if ($c_grado >=5 AND $c_grado <=9) { // Educacion básica primaria
				$table = 'log_nscp001';
			}else{
				$table = 'log_nscp002'; // Educacion básica secundaria
			}	
		}		
		return $table;
	}
	
	public function escala ($g = "") {
		if (empty($g)){
			$request = "";
		}else{
			$db	= $this->get_db_name();
			$this->db->select('td.id_pk,td.desde,td.hasta, t2.nombre_escala, t2.abrev');
			$this->db->from($db.".desempeños AS td ");
			$this->db->join($db.'.grados_agrupados AS t1', 'td.id_grado_agrupado = t1.id', 'left');
			$this->db->join($db.'.escala_nacional AS t2', 'td.id_escala = t2.id', 'left');
			$this->db->join($db.'.aux_grados_agrupados AS ta', 'ta.id_grado_agrupado = t1.id', 'left');
			$this->db->where('ta.id_grado', $g);
			$this->db->where('td.year', $this->get_year());
			$this->db->where('td.id > 0');
			$this->db->order_by('td.year,ta.id_grado_agrupado,td.id');
			
			$query	= $this->db->get();
			$request = "";
			if ($query) {
				foreach($query->result_array() as $row){
					$request = $request.$row['nombre_escala']."(".$row['abrev'].")".': '
					.abs($row['desde']).' - '.abs($row['hasta']).'  ';
				}			
			}else{
				$request = "";
			}
		}
		return $request;
	}
	
	/**
	* Funcion para realizar una consulta al servidor mediante un procedimiento almacenado
	* @param string $func_name Nombre de la funcion o almacenamiento almacenado
	* @param array $param  Array con los parametros del procedimiento almacenado
	* 
	* @return Resultado en formato Json
	*/	
	
   	public function	get_query_call($func_name = NULL,$param = NULL){
   		
		if(isset($param) and isset($func_name)){
			$this->openconn();
			$query_total = $this->db->query("CALL ".$func_name."(".$param.",0,0,0)");
			
			if ($query_total) 
			{
			 	$reccount = $query_total->num_rows(); //Cantidad de registros de la tabla
			 	
			 	$query_total->free_result();
			 	
			 	$this->next_result();
			 	
			 	$query = $this->db->query("CALL ".$func_name."(".$param.",1,".
			 	$this->limit_min.",".$this->limit_max.")");	
			 	
			 	$this->next_result();
			 	
			 	/**
				* Armamos el array de registros de la tabla cursos y su campos
				*/

				$fields_list = NULL;
				
			 	foreach ($query->result_array() as $field)
			 	{
					$fields_list [] = $field;
				}			
				
				// liberamos la memoria
				
				$query->free_result();
				
				/**
				* Respuesta en formato Json
				*/
				$request = $this->get_request_select($fields_list,$reccount);
					
			} else {
				$request = $this->get_error();		
			}
					
		}else{
			$request = $this->get_error();
		}
		/**
		* Enviamos la repustas en formato Json
		*/
		return $request;
	}
	
	/**
	* Funcion para ejecutar una consulta al servidor mediante un procedimiento almacenado
	* @param string $func_name Nombre de la funcion o almacenamiento almacenado
	* @param string $param  Cadena con los parametros del procedimiento almacenado
	* 
	* @return Resultado en formato Json
	*/	
	
   	public function	get_call_execute($func_name = NULL,$param = NULL){
   		$db         = $this->get_db_name();
		if(isset($param) and isset($func_name)){
			$this->openconn();
			$query = $this->db->query("CALL ".$db.".".$func_name."(".$param.")");
			if ($query) {
				// $this->next_result();
				// liberamos la memoria
								
				//$query->free_result();
				
				/**
				* Respuesta en formato Json
				*/
				$request = $this->get_request_ab();
					
			} else {
				$request = $this->get_error();		
			}					
		}else{
			$request = $this->get_error();
		}
		/**
		* Enviamos la repustas en formato Json
		*/
		return $request;
	}
	
	/**
	* Funcion para realizar una consulta al servidor mediante un procedimiento almacenado
	* @param string $func_name Nombre de la funcion o almacenamiento almacenado
	* @param string $param  Cadena con los parametros del procedimiento almacenado
	* 
	* @return Resultado en formato Json
	*/	
	
   	public function	get_call($func_name = NULL,$param = NULL){   		
		if(isset($param) and isset($func_name)){
			$this->openconn();	
			$db	= $this->get_db_name();		 				 	
			$query = $this->db->query("CALL ".$db.".".$func_name."(".$param.")");
			if ($query) {				
				$reccount = $query->num_rows(); //Cantidad de registros de la tabla							 	
			 	/**
				* Armamos el array de registros de la tabla cursos y su campos
				*/
				$fields_list = NULL;				
			 	foreach ($query->result_array() as $field)
			 	{
					$fields_list [] = $field;
				}				
				// liberamos la memoria				
				$this->next_result();				
				$query->free_result();				
				/**
				* Respuesta en formato Json
				*/
				$request = $this->get_request_select($fields_list,$reccount);
					
			} else {
				$request = $this->get_error();		
			}					
		}else{
			$request = $this->get_error();
		}
		/**
		* Enviamos la repustas en formato Json
		*/
		return $request;
	}
	
	
	public function get_columns_notas($id_grado = 0){
		$db     = $this->get_db_name();
		$query	= "CALL ".$db.".`sp_get_columns_notas`('.$id_grado.','".$this->get_year()."')";
		$query	= $this->db->query($query);
		$this->next_result();
		if($query->num_rows() > 0){
			$result	= $query->row('filas');
		}else{
			$result	= '';
		}
		return $result;
	}
	
	/**
	* Funcion que retorna el grado al cual es promovido el estudiante
	* @param INT $id_grado
	* 
	* @return INT
	*/
	public function get_grado_promocion($id_grado = 0){
		$sql = "SELECT t2.id_grado FROM grados_agrupados AS t1 
			LEFT JOIN aux_grados_agrupados AS t2 ON t2.id_grado_agrupado = t1.id
			WHERE t2.id_grado = ".$id_grado." AND t1.fin_ciclo_escolar = 1;";
		$sql = $this->db->query($sql);
		if($sql->num_rows() > 0){
			$_result = $id_grado;
		}else{
			$_result = $id_grado + 1;
		}
		return $_result;
	}
	
	/**
	*Devuelve el nivel escolar del grado
	* 
	* @param INT $id_grado
	* 
	* @return INT
	*/
	public  function get_nivel_escolar($id_grado = 1){
		$db         = $this->get_db_name();
		$sql = "SELECT tg.id_nivel
					FROM ".$db.".grados AS tg WHERE tg.id = ".$id_grado." LIMIT 1;";
		$sql = $this->db->query($sql);
		if($sql->num_rows() > 0){
			$result = $sql->row('id_nivel');
		}else{
			$result	= 0;
		}
		
		return $result;
	}
	
	public function last_periodo($grado = 0){
		$db         = $this->get_db_name();
		$query 	= "SELECT t.periodo FROM ".$db.".periodos_academicos t 
				LEFT JOIN ".$db.".grados_agrupados AS t1 ON t.id_grado_agrupado = t1.id 
				LEFT JOIN ".$db.".aux_grados_agrupados AS t2 ON t2.id_grado_agrupado = t1.id 
				WHERE t.`year` = ? AND t2.id_grado = ? AND t.estado = 1
				ORDER BY t.periodo DESC LIMIT 1";
		$param	= array(
			$this->get_year(),
			$grado
		);
		$query = $this->db->query($query,$param);	
		if ($query) {
			$this->last_periodo = $query->row()->periodo;
			$request = TRUE;
		}else{
			$this->last_periodo = 5;
			$request = TRUE;
		}
		return $request;
	}
	
	/**
	* Funcion que devuelve el rango de desempeños
	* @param STRING $cValue
	* 
	* @return BOLEAN
	*/
	
	public function get_desempeños_rango ($grado = 1)
	{		
		$db		= $this->get_db_name();
		$year	= $this->get_year();
		$this->db->select('desde, hasta');
		$this->db->from($db.'.desempeños AS td');
		$this->db->join($db.'.grados_agrupados AS t1', 'td.id_grado_agrupado = t1.id', 'left');
		$this->db->join($db.'.aux_grados_agrupados AS t2', 't2.id_grado_agrupado = t1.id', 'left');
		$this->db->where('td.year', $year);
		$this->db->where('td.reprueba', 1);
		$this->db->where('t2.id_grado', $grado);
		$this->db->limit(1);
		$query = $this->db->get();			
		if ($query) {
			$this->desde = $query->row()->desde;
			$this->hasta = $query->row()->hasta;
			$request = TRUE;
		}else{
			$request = FALSE;
		}
		return $request;
	}
	
	/**
	* Funcion que devuelve el desempeño segun escala
	* @param decimal $cValue Valor de la nota para obtener el desempeño
	* @param undefined $cTable Nombre de la tabla de donde se extarerá el desempeño
	* 
	* @return
	*/
	
	public function get_desempeño ($cValue = 0,$cTable = 'desempeños')
	{
		
		$query 	= "SELECT * FROM ".$cTable."  WHERE year= ? AND id_inst= ? AND ? between desde  AND hasta";
		
		$param	= array(
			$this->get_year(),
			$this->id_school,
			$cValue
		);
		
		$query = $this->db->query($query,$param);	
			
		if ($query) {
			$request = $query->row()->desempeño;
			
		}else{
			$request = FALSE;
		}
		return $request;
	}
	
	
	/**
	* Funcion que devuelve el ID del desempeño de la escala
	* @param DECIMAL $nota
	* @param INT $id_grado
	* 
	* @return
	*/
	public function get_desempeños_id ($nota = 0, $id_grado = 0)
	{	
		$db		= $this->get_db_name();
		$query 	= "SELECT id_escala FROM ".$db.".desempeños AS td
				LEFT JOIN ".$db.".grados_agrupados AS t1 ON td.id_grado_agrupado = t1.id
				LEFT JOIN ".$db.".aux_grados_agrupados AS t2 ON t2.id_grado_agrupado = t1.id
				WHERE td.`year` = ? AND t2.id_grado = ? AND ? BETWEEN td.desde AND td.hasta LIMIT 1";		
		$param	= array(
			$this->get_year(),
			$id_grado,
			$nota
		);		
		$query 	= $this->db->query($query,$param);	
		$row	= $query->row();		
		if ($row) {
			$request =  $row->id_escala;	
		}else{
			$request = 0;
		}
		return $request;
	}
	
	
	/**
	* Funcion que duevuelve el tipo de proceso educativo para impresion de boletines
	* 
	* 
	* @return 
	*/
	public function proceso_educativo($grado) {
		$db     = $this->get_db_name();
		$query 	= "SELECT procesos FROM ".$db.".config001 AS tc
		LEFT JOIN ".$db.".grados_agrupados AS t1 ON tc.id_grupo_grados = t1.id
		LEFT JOIN ".$db.".aux_grados_agrupados AS t2 ON t2.id_grado_agrupado = t1.id
		WHERE tc.year=".$this->get_year()." AND t2.id_grado = ".$grado." LIMIT 1";
		$query	=  $this->db->query($query);
		$request	= 0;
		if ($query){
			$request	= $query->row('procesos');
		}else{
			$request	= 0;
		}
		return $request;
	}
	
	/**
	* Función que cambia los acentos en una cadena por sus equivalentes
	* @param STRING $cadena
	* 
	* @return Cadena normalizada con sus equivales
	*/
	
	function normaliza ($cadena){
    	$originales = 'ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõöøùúûýýþÿŔŕ';
	    $modificadas = 'aaaaaaaceeeeiiiidnoooooouuuuybsaaaaaaaceeeeiiiidnoooooouuuyybyRr';
	    $cadena = utf8_decode($cadena);
	    $cadena = strtr($cadena, utf8_decode($originales), $modificadas);
	    $cadena = strtolower($cadena);
	    return utf8_encode($cadena);
	}
	
	public function next_result()
	{
	     if (is_object($this->db->conn_id))
	     {
	        return mysqli_next_result($this->db->conn_id);
	     }
	}
	 
	
	/**
	*Change database connect 
	* 
	* @param string $namedb Name DataBase
	* 
	* @return Bool
	*/
	public function changedb($namedb){
		$this->db->db_select($namedb);
	}
	
	/**
	* Open connection or reconnect to db
	* 
	* @return Bool
	*/
	
	public function openconn(){
		//$this->db->reconnect();
	}
	
	/**
	* Close connection 
	* 
	* @return Bool
	*/ 
	public function closeconn(){
		//$this->db->close();
	}
	
	/**
	* Retorna el untimo id insertado
	* 
	* @return INT
	*/
	
	public function last_insert_id(){
		return  $this->db->insert_id();
	}

	/**
	* Verifica si hay una session activa* 
	* @return BOOL
	*/
	
	protected function check_ession(){
		$ses	= $this->session;
		$result	= FALSE;
		if($ses->userdata('user_name') AND $ses->userdata('user_pass') AND 
			$ses->userdata('user_type') and $ses->userdata('user_id') AND 
            $ses->userdata('user_active')){
			$result	= $this->compare_session();
		}
		return $result;
	}



	
	/**
	* Compara la session activa, y verifica que el usuario conectado se correcto
	* 
	* @return BOOL
	*/
	
	protected function compare_session(){
		$ses	= $this->session;
		$user	= $ses->userdata('user_name');
		$pass	= $ses->userdata('user_pass');
		$id		= $ses->userdata('user_id');
		$type	= $ses->userdata('user_type');
        $log    = $ses->userdata('user_active');
		
		$this->db->where('id',$id);
		$this->db->where('user_type',$type);
		$this->db->where('username',$user);
		$this->db->where('password',$pass);
		$this->db->where('active',1);
		$db		= $this->get_db_name();
		$qry	= $this->db->get($db.'.users');
		
		$result	= FALSE;
		
		if($qry->num_rows() > 0){
			$row	= $qry->row();
			if($row->active > 0 AND $log == 1){	
				$result	= TRUE;
			}
		}
		
		if(!$result){
			$this->close_session();
		}
		
		return $result;
	}
	
	protected function close_session_redirect() {
		$this->close_session();
        redirect(base_url());
	}

 	protected function close_session() {
		$this->session->sess_destroy();
		$this->output->set_header('Last-Modified:'.gmdate('D, d M Y H:i:s').'GMT');
        $this->output->set_header('Cache-Control: no-store, no-cache, must-revalidate');
        $this->output->set_header('Cache-Control: post-check=0, pre-check=0',false);
        $this->output->set_header('Pragma: no-cache');
 	}

	/**
	 * Get the value of resource_folder_path
	 */ 
	public function getResource_folder_path()
	{
		return $this->resource_folder_path;
	}

	/**
	 * Set the value of resource_folder_path
	 *
	 * @return  self
	 */ 
	public function setResource_folder_path($resource_folder_path)
	{
		$this->resource_folder_path = $resource_folder_path;

		return $this;
	}
}