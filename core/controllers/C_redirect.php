<?php defined('BASEPATH') OR exit('No direct script access allowed');

class C_redirect extends SME_Controller 
{
	public function __construct() 
	{
		parent::__construct();
	}
	
	public function index() {
		redirect('index.php/c_pdf','location',301);
	}
}
