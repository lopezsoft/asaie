<?php defined('BASEPATH') OR exit('No direct script access allowed');

class M_app_update extends SME_Model {
	private $dir_origen;
	function __construct() {
		parent::__construct();
		$this->dir_origen 	= "/var/www/vhosts/smescolar.com/appUpdate";
	}
	
	public function app_update_control(){
		if (file_exists($this->dir_origen)){
			$dirs_local	= scandir($this->dirPath);
			$dirs_origen= scandir($this->dir_origen);
			foreach($dirs_origen as $key => $value){
				if ($value <> "." AND $value <> ".." AND !empty($value)){
					if (is_dir($this->dir_origen."/".$value)) {
						$this->recursive_subdir($this->dir_origen."/".$value,$this->dirPath.$value);
					}else {
						$old_file	= $this->dirPath.$value;
						$new_file	= $this->dir_origen."/".$value;
						if (file_exists($old_file)){
							if (filemtime($new_file) > filemtime($old_file) AND filesize($new_file) <> filesize($old_file)){
								copy($new_file,$old_file);
							}
						}else{
							copy($new_file,$old_file);
						}
					}
				}
			}
		}	
	}
	
	function recursive_subdir($new_path,$old_path, $recursive = FALSE){
		if (!file_exists($old_path)){
			mkdir($old_path,0775,TRUE);
		}
		$dirs_origen= scandir($new_path);		
		foreach($dirs_origen as $key => $value){
			if ($value <> "." AND $value <> ".." AND !empty($value)){
				if (is_dir($new_path."/".$value)) {
					$this->recursive_subdir($new_path."/".$value,$old_path."/".$value,TRUE);
				}else {
				 	$old_file	= $old_path."/".$value;
				 	$new_file	= $new_path."/".$value;
				 	if (file_exists($old_file)){
						if (filemtime($new_file) > filemtime($old_file) AND filesize($new_file) <> filesize($old_file)){
							copy($new_file,$old_file);
						}
					}else{
						copy($new_file,$old_file);
					}
				}
			}
		}
		
	}
}