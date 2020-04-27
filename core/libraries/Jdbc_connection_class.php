<?php defined('BASEPATH') OR exit('No direct script access allowed');
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
 * @author    Robert Alexander Bruno Monterrey <robert.alexander.bruno@gmail.com>
 * @license   http://www.gnu.org/licenses/old-licenses/gpl-2.0.txt GNU/GPL
 * @version   SVN:$id
 */

/**
 * clase que permite optener una connecion jdbc 
 *
 * @author    Robert Alexander Bruno Monterrey <robert.alexander.bruno@gmail.com>
 * @license   http://www.gnu.org/licenses/old-licenses/gpl-2.0.txt GNU/GPL
 * @version   SVN:$id
 */
class Jdbc_connection_class {
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
	private $driver				= "com.mysql.jdbc.Driver";
	/**
	* Nombre de la base de datos para la conexion jdbc
	* @var String $db_database
	* 
	*/
	private $db_database		= 'dbasaieplus';
	/**
	 * string o url de la conexion jdbc 
	 * 
	 * @var  String $connectionString 
	 */
	private $connectionString	= "jdbc:mysql://localhost/";
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
	/**
	* 
	* @var $CI Variable para instanciar el CORE de CodeIgnigter
	* 
	*/
	private $CI;
	 /**
	 * contructor de la clase inicia los valores
	 * @param String $driver: Nombre de la base de datos para la conexion jdbc
	 * @param String $connectionString : string o url de la conexion jdbc
	 * @param String $db_username: usuario de la conexion  jdbc
	 * @param String $db_password: Contraseña del usuario de la conexion jdbc
	 * 
	 * @return String : conexcion
	 */	 
	public function __construct(){
		$this->CI 				= & get_instance();
		$this->driver			= "com.mysql.jdbc.Driver";
		$this->db_database		= $this->CI->db->database;
		$this->db_username		= $this->CI->db->username;
		$this->db_password		= $this->CI->db->password;
		$this->connectionString = "jdbc:mysql://localhost/".$this->db_database."?user=".$this->db_username."&"."password=".$this->db_password;
	}
	 
	public function JdbcConnection () {
		$system = new JavaClass('java.lang.System');
 		$class = new JavaClass("java.lang.Class");
 		$class->forName($this->driver);
 		$driverManager = new JavaClass("java.sql.DriverManager");
 		$conn = $driverManager->getConnection($this->connectionString);
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
	public function getConnectString(){
		return $this->connectionString;
	}
	
	/*
	 * Retorna el usuario de la conexion jdbc
	 */
	public function getUser(){
		return $this->user;
	}
	
}

/* End of file JdbcConnection.php */