<?php
defined('BASEPATH') OR exit('No direct script access allowed');
class M_pdf extends CI_Model {
	
	public function __construct() 
	{
		parent::__construct();
	}
	
	 /* Devuelve la lista de alumnos que se encuentran en la tabla tblalumno */
    function obtenerListaAlumnos()
    {
        $alumnos = $this->db->get('tblalumno');
        return $alumnos->result();
    }
}

/* End of file M_pdf.php */
/* Location: ./application/models/M_pdf.php */