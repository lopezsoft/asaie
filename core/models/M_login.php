<?php
defined('BASEPATH') OR exit('No direct script access allowed');
require_once $_SERVER["DOCUMENT_ROOT"].'/globales/dbconstanst.php';
class M_login extends SME_Model { 
				  
	    public function __construct() 
		{
			parent::__construct();
		}
		
		function get_user() {
			$sess   = $this->session;
			$year 	= $sess->userdata('user_year');
			$user	= $sess->userdata('first_name');
			$db		= $sess->userdata('db_name');
			$this->id_school= $sess->userdata('user_id_school');
			$this->user_id	= $sess->userdata('user_id');
			
			$this->db->select("*");
			$this->db->from($db.".config001");
			$this->db->where("year",$year);
			$get_config = $this->db->get();
			
			$this->db->select("*");
			$this->db->from($db.".aux_grados_agrupados");
			$grupo_grados	= $this->db->get();

			$this->db->select('id,user_type,names, last_name,username,email,image,mime');
			$this->db->from($db.'.users');
			$this->db->where('id', $this->user_id);
			$get_user	= $this->db->get();
						
			$config 	= NULL;			
			$user_d		= NULL;
			
			if ($get_config AND $get_user) {
				
				foreach($get_config->result_array() as $field){
					$config [] = $field;
				}
				
				foreach($get_user->result_array() as $field){
					$user_d [] = $field;
				}
				
				$request	= array(
					'user'			=> $user,
					'request'		=> 1,
					'config'		=> $config,
					'user_data'		=> $user_d,
					'id_school'		=> $this->id_school,
					'user_id'		=> $this->user_id,
					'grupo_grados'	=> $grupo_grados->result(),
					'year'			=> $year,
					'db_name'		=> $db,
					'user_type'		=> $this->session->userdata('user_type')
				);
			}else{
				$request	= array(
					'year'		=> NULL,
					'user'		=> NULL,
					'request'	=> 0
				);
			}
			
			return $request;
		}
		
		/**
		* 
		* @param string $user, Nombre de usuario
		* @param string $pass, Contraseña
		* @param string $year, Año ingresado
		* @param string $inst, codigo inst 12 digitos
		* @param string $user_type, tipo de usuario
		* 
		* @return JSonCode
		*/
		
		function log_in($user,$pass,$year,$inst,$type){			
			$request	= "";			
			$this->db->select("*");
			$this->db->from('schools');
			$this->db->where("statecode='".$inst."'");
			$this->db->limit('1');
			
			$query	= $this->db->get();
			if($query->num_rows() > 0){
				$row					= $query->row();
				$this->db_name			= $row->database_name;
				$this->school_folder	= $row->folder_name;				
				$this->id_school		= $this->id_school($inst);			

				$where	=	'SHA1(username)=SHA1("'.$user.'") AND password="'.$pass.'"';
				$this->db->where($where);
				$this->db->where('user_type', $type);
				$re		= $this->db->get($row->database_name.'.users', 1);
				$re		= $re->row();
				
				$user_type	= $re->user_type;
				$request = $this->getLogin($user,$pass,$year,$inst,$user_type);
			}else{
				 $request = $this->getError();
			}						
			return	 $request;
		}
		
		public function check_active(){
			$result	= FALSE;
			$this->db_name	= $this->session->userdata('db_name');
			$sql = "SELECT * FROM schools WHERE database_name='".$this->db_name."' LIMIT 1";
			$sql = $this->db->query($sql);
			if($sql->num_rows() == 0){
				$result	= FALSE;
			}else{
				$result	= ($sql->row('state') > 0);
			}
			
			return $result;
		}
		
		function get_login_user (){
			$userType = $this->session->userdata('user_type');	

			switch($userType){
				case '4':  // Usuario Docente
					$sess   		= $this->session;
					$year 			= $sess->userdata('user_year');;
					$user			= $sess->userdata('first_name');
					$db				= $sess->userdata('db_name');
					$user_parent	= $sess->userdata('user_parent');
					$this->id_school= $sess->userdata('user_id_school');
					$this->user_id	= $sess->userdata('user_id');
					
					$this->db->select("*");
					$this->db->from($db.".config001");
					$this->db->where("year",$year);
					$config = $this->db->get();
					
					$this->db->select("*");
					$this->db->from($db.".aux_grados_agrupados");
					$grupo_grados	= $this->db->get();

					$this->db->select('id,user_type,names, last_name,username,email,image,mime');
					$this->db->from($db.'.users');
					$this->db->where('id', $this->user_id);
					$user_data	= $this->db->get();
					
					$this->db->where('id_docente', $user_parent);
					$this->db->where('year', $year);
					$dir_grupo	= $this->db->get($db.'.dir_grupo');

					$config_bol	= $this->db->get($db.'.configboletin');
				
					$request	= array(
						'user'			=> $user,
						'request'		=> 1,
						'config'		=> $config->result(),
						'user_data'		=> $user_data->result(),
						'dir_group'		=> $dir_grupo->result(),
						'config_bol'	=> $config_bol->result(),
						'id_school'		=> $this->id_school,
						'user_id'		=> $this->user_id,
						'grupo_grados'	=> $grupo_grados->result(),
						'year'			=> $year,
						'db_name'		=> $db,
						'user_parent'	=> $user_parent,
						'user_type'		=> $this->session->userdata('user_type')
					);
					break;
				case '5':  // Usuario Estudiante
					$sess   		= $this->session;
					$year 			= $sess->userdata('user_year');;
					$user			= $sess->userdata('first_name');
					$db				= $sess->userdata('db_name');
					$user_parent	= $sess->userdata('user_parent');
					$this->id_school= $sess->userdata('user_id_school');
					$this->user_id	= $sess->userdata('user_id');
					
					$this->db->select("*");
					$this->db->from($db.".config001");
					$this->db->where("year",$year);
					$config = $this->db->get();
	
					$this->db->select('id,user_type,names, last_name,username,email,image,mime');
					$this->db->from($db.'.users');
					$this->db->where('id', $this->user_id);
					$user_data	= $this->db->get();
					
					$this->db->select("a.*, c.cod_grado, c.grado, trim(d.jornada) AS jornada, trim(e.NOMBRE_SEDE) sede,
					CONCAT(TRIM(g.apellido1),' ',TRIM(g.apellido2),' ',TRIM(g.nombre1),' ',TRIM(g.nombre2)) estudiante");
					$this->db->from($db.'.student_enrollment AS a');
					$this->db->join($db.'.grados AS c', 'a.id_grade = c.id', 'left');
					$this->db->join($db.'.jornadas AS d', 'a.id_study_day = d.cod_jorn', 'left');
					$this->db->join($db.'.sedes AS e', 'a.id_headquarters = e.ID', 'left');
					$this->db->join($db.'.inscripciones AS g', 'a.id_student = g.id', 'left');
					$this->db->where('a.id_student', $this->get_student_id());
					$this->db->where('a.year', $this->get_year());
					$this->db->limit(1);
					$enrollement	= $this->db->get();
				
					$request	= array(
						'user'			=> $user,
						'request'		=> 1,
						'config'		=> $config->result(),
						'user_data'		=> $user_data->result(),
						'id_school'		=> $this->id_school,
						'user_id'		=> $this->user_id,
						'enrollment'	=> $enrollement->result(),
						'year'			=> $year,
						'db_name'		=> $db,
						'user_parent'	=> $user_parent,
						'user_type'		=> $this->session->userdata('user_type')
					);
					break;
				default :
					$request = $this->get_user();
					break;
			}			
			return $request;
		}
		
	
		function getLogin($user,$pass,$year,$inst,$user_type){
			$request = "";
			
			$param	= array(
				$pass,
				$this->id_school,
				$user_type		
			);
			
			$where	=	'SHA1(username)=SHA1("'.$user.'") AND password="'.$pass.'" AND user_type="'.$user_type.'"';	
			$this->db->where($where);
			$query	= $this->db->get($this->db_name.".users");						
			$this->user_year	= $year;					
			if($query){
				if($query->num_rows() === 1 ){
					if ($this->setLogin($query, $user_type, $year, $inst)){															
						$request	= array(
							'request'	=> 1,
							'success'	=> true
						);						
						$request	= json_encode($request);
					}else{
						$request	= $this->error_success();
					}
				}else{
					$request	= $this->error_success();
				}
			}else{
				$request	= $this->getError();
			}
			return $request;	
		}
		
		//Funcion que controla el login del usuario.
		function setLogin($query=NULL, $user_type=NULL, $year = 0, $inst)
		{
			if ( $query===NULL OR $user_type===NULL) {
				throw new Exception("Error Processing Request", 1);
			}else {				
				$this->user_id              = $query->row('id');
				$this->first_name     		= $query->row('names');
				$this->last_name			= $query->row('last_name');
				$this->user_name 			= $query->row('username');
				$this->user_pass			= $query->row('password');
				$this->user_id_school       = $inst;
				$this->user_year			= $year;
		
				$this->user_active 		    = 1;	
				$this->user_type			= $user_type;				
				/* 
				 Si el usuario existe, revisa si la cuenta está bloqueada
				 por muchos intentos de conexión.
				 */
				if ($this->checkbrute($this->user_id)) {
					// Si la cuenta está bloqueada
					return FALSE;
				}else {
					/*
					Matris de sesion
					*/							
					$new_data_session = array(
						'user_id'          	=> $this->user_id,
						'first_name' 	   	=> $this->first_name,
						'last_name' 	   	=> $this->last_name,
						'user_name'        	=> $this->user_name,
						'user_pass'        	=> $this->user_pass,
						'user_id_school'   	=> $this->user_id_school,
						'user_year' 	   	=> $year,
						'user_active'      	=> $this->user_active,
						'user_type'		   	=> $this->user_type,
						'db_name'		   	=> $this->db_name,
						'user_parent'		=> $query->row('user_id'),
						'school_folder'	   	=> $this->school_folder
					);
					/**
					* 
					* Registramos nuestros datos de sesion.
					* 
					*/		
					
					$this->session->set_userdata($new_data_session);
					// Inicio de sesión exitoso
					
					return TRUE;
				}		
					
			}
		}
		
		public function checkbrute($user_id) 
		{
		    return false;
		} 
		
		/**
		*Verificamos que el usuario este conectado.
		*/
		public function check_session() {
		    // Revisa si todas las variables de sesión están configuradas.
			$sess	= $this->session;
			if ($sess->userdata('user_id')!=NULL AND $sess->userdata('user_id_school')!=NULL AND $sess->userdata('user_year')!=NULL AND 
				$sess->userdata('user_active')!=NULL AND $sess->userdata('user_active')==1 AND $sess->userdata('user_name')!=NULL 
				AND $sess->userdata('user_pass')!=NULL) {
				
				$result 		= FALSE;				
				$query			= NULL;				
				$user_type		= $sess->userdata('user_type'); // Tipo de usuario				
				$user_id		= $sess->userdata('user_id'); // id de usuario				
				$bd_user        = $sess->userdata('user_name');
				$db_password    = $sess->userdata('user_pass');
				$db_inst        = $sess->userdata('user_id_school');
				$db_Año         = $sess->userdata('user_year');
				$db				= $sess->userdata('db_name');

				$Select_Db ="SELECT * FROM ".$db.".users WHERE SHA1(username)=SHA1('".$bd_user.
				"') AND password= ? AND user_type= ? ";						
				$query = $this->db->query($Select_Db,array($db_password,$user_type));
					
				if ($query) {					
					if ($query->num_rows() == 1) {
						$row = $query->row();
						// Si el usuario existe, obtiene las variables del resultado.
						/**
						* Comparamos que coincidan los datos
						*/
						if ($row->username==$bd_user AND $row->password==$db_password AND 
							$row->id==$user_id AND $row->user_type == $user_type AND $row->active == 1) {						
							$result = TRUE;
						}else{						
							$result = FALSE;
						}	
					} else {
						$result = FALSE;
					}
				} else {
					$result = FALSE;
				}
			} else {
				// No se han iniciado las variables de session.
				$result = FALSE;		
			}
			return $result;
		}
}


/* End of file M_login.php */
/* Location: ./application/models/M_login.php */