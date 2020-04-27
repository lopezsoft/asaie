<?php
defined('BASEPATH') OR exit('No direct script access allowed');
class C_server extends SME_Controller {
	function __construct() {
		parent::__construct();
	}
	
	public function run_server_socket(){
		$path = $_SERVER['DOCUMENT_ROOT'].'/socket/server.php';
		
		echo exec("php ".$path);
		echo $path;		
	}
}