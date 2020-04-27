<?php
defined('BASEPATH') OR exit('No direct script access allowed');
date_default_timezone_set("America/Bogota");
class WA_Model extends CI_Model {

	/**
	 * End New properties
	 */
	public	$primary_key	= "id";
	public	$user			= "Web01";
	public	$wFechaP		= null;
	public	$wAnioFechaP	= null;

	public function __construct() 
	{
		parent::__construct();
	}

	public function getWFechaP()
	{
		return	$this->session->userdata('wFechaP');
	}

	public function getWanioFechaP()
	{
		return	$this->session->userdata('wAnioFechaP');
	}

	public function pa_gene_wFechaP()
	{
		$func	= "pa_gene_wFechaP ?";
		$param	= array(Date('Y-m-d'));
		$result	= $this->db->query("EXEC ".$func,$param);
		if ($result) {
			/*
			Matris de sesion
			*/							
			$new_data_session = array(
				'wFechaP'          => $result->row('fechaP'),
				'wAnioFechaP' 	   => $result->row('anoFechaP')
			);
	
			$this->session->set_userdata($new_data_session);
		}
	}

	/**
	* Funcion para ejecutar una consulta al servidor mediante un procedimiento almacenado
	* @param string $func_name Nombre de la funcion o almacenamiento almacenado
	* @param string $param  Cadena con los parametros del procedimiento almacenado
	* 
	* @return Resultado en formato Json
	*/	
	public function	getExecute($func_name, $param = [], $encode = true){
   		
		if(isset($func_name)){
			try {
				$this->next_result();
				if(count($param) > 0){
					$query = $this->db->query("exec ".$func_name,$param);
				}else {
					$query	= "exec ".$func_name;
					$query 	= $this->db->query($query);
				}
				if($encode){
					$request = $this->getJsonResponse($query->result_array(),1);			
				}else{
					$request = $query->result_array();			
				}
			} catch (Exception $e) {
				$result  = $this->getError($e->getMessage());
			}finally{
				$this->db->close();
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
			$order 			= ($order) ? $order : '1' ;	
            if (strlen($querySearch) > 0 ) {
				$queryField = "";
				$whereArray	= [];
                foreach ($stringFields as $value) {
					$whereArray	= $where;
					if(count($where) > 0){
						$query	= $queryStatemente." AND ".$value." LIKE ? ".
						" ORDER BY 1 OFFSET 0 ROWS FETCH NEXT 1 ROWS ONLY";
						array_push($whereArray,"%".$querySearch."%");
					}else{
						$query	= $queryStatemente." WHERE ".$value." LIKE ? ".
						" ORDER BY 1 OFFSET 0 ROWS FETCH NEXT 1 ROWS ONLY";
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
						" ORDER BY ".$order." OFFSET ".$start." ROWS FETCH NEXT ".$limit." ROWS ONLY";
					}else{
						$query	= $queryStatemente." WHERE ".$queryField." LIKE ? ".
						" ORDER BY ".$order." OFFSET ".$start." ROWS FETCH NEXT ".$limit." ROWS ONLY";
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

				$query	= $queryStatemente.
				" ORDER BY ".$order." OFFSET ".$start." ROWS FETCH NEXT ".$limit." ROWS ONLY";
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
			$this->db->close();
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
  	public function insertData($table, $data, $primaryKey = 'id', $serial) {
		$db_field 	= '';
		$db_value 	= '';
		$table		= $table;
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
				$values	= [];
				/**
				 * Si se pasan parametros para la serializacion de un campo
				 * $serial->field :  Es el nombre del campo a serializar
				 * $serial->length : Es la longitud del campo a serializar
				 */
				if ($serial) {
					foreach ($fiels_table as $fieldvalue) {
						if( strtolower($fieldvalue->name) == "vigencia"){
							$this->db->where($fieldvalue->name, $this->getWanioFechaP());
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
						$name = $field_compare->name;
											
						/**
						* 
						* @var Si no es un campo primario recorre el array con los datos
						* y compara si los campos son iguales y alamcena los datos en las variables
						* para  preparar el insert
						* 
						*/
						if($name !== $primaryKey){
							/**
							* @var Si los campos son iguales almacena los datos en las 
							* variables $db_field y $db_value
							*/

							if (strtoupper($field) === strtoupper($name)) {
								$values[$name]	= $value;
								break;
							}elseif(strtolower($name) == "vigencia"){
								$values[$name]	= $this->getWanioFechaP();
							}  
													
						}	
					}
				}

				if(count($values) > 0){
					$this->db->insert($table, $values);
					$id	= $this->getInsertId();					
					$this->db->where($primaryKey, $id);
					$query		= $this->db->get($table,1);
					$request	= $this->getJsonResponse($query->result_array(),1);
				}else{
					$request	= $this->getJsonResponse([],0);
				}
			}
	  		$this->trans_commit();
		} catch (Exception $e) {
			$this->trans_rollback();
			$request  = $this->getError($e->getMessage());
		}finally{
			$this->db->close();
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
  	
	public function updateData ($table, $data, $primaryKey	= "id") {
  						
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
							$name = $field_compare->name;
							/**
							* Si es un campo primario recorre el array con los datos
							* y compara si los campos son iguales y alamcena los datos en las variables
							* para  preparar el insert
							*/
							if($name == $primaryKey){
								$where[$name]    	= $value;
							}else{
								/**
								* Si los campos son iguales almacena los datos en las 
								* variable $values
								*/
								if (strtoupper($field) == strtoupper($name)) {
									$values[$field] = $value;
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
						$name = $field_compare->name;
						/**
						* Si es un campo primario recorre el array con los datos
						* y compara si los campos son iguales y alamcena los datos en las variables
						* para  preparar el insert
						*/
						if($name == $primaryKey){
							$where[$name]    	= $value;
						}else{
							/**
							* Si los campos son iguales almacena los datos en las 
							* variable $values
							*/
							if (strtoupper($field) == strtoupper($name)) {
								$values[$field] = $value;
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
			$this->db->close();
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
  		$table	= $tb;
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
			$this->db->close();
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
    function getTable($table, $offset, $limit, $query, $where = [])
    {
		try {
			if ($query) {
				$fields_table 	= $this->db->field_data($table);
				$searchField	= "";
				foreach ($fields_table as $value) {
					if(count($where) > 0){
						$this->db->where($where);
					}
					$name = $value->name;

					if(strtolower($name) == "vigencia"){
						$this->db->where($name, $this->getWanioFechaP());
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
				$fields_table 	= $this->db->field_data($table);
				$searchField	= "";
				$whereVig		= [];
				foreach ($fields_table as $value) {
					
					$name = $value->name;

					if(strtolower($name) == "vigencia"){
						$whereVig[$name]	= $this->getWanioFechaP();
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
			$this->db->close();
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
			'success'       => TRUE,
			'records'	    => $fields,
			'total' 		=> $total
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
	* Retorna el estado de la transacción
	* 
	* @return
	*/	
	public function	trans_status ()
	{
		return	$this->db->trans_status();
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
	         return sqlsrv_next_result($this->db->conn_id);
	     }
	}
	
	/**
	* Retorna el untimo id insertado
	* @return INT
	*/
	public function getInsertId(){
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
}