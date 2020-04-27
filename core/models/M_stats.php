<?php 
defined('BASEPATH') OR exit('No direct script access allowed');
class M_stats extends SME_Model {
    function __construct() {
         parent::__construct();
    }

    function get_retired_year()
    {
        $year   = $this->get_year();
        $db     = $this->get_db_name();
        
        $this->db->select('COUNT(id) AS total, year');
        $this->db->from($db.'.student_enrollment');
        $this->db->where('id_state > 2');
        $this->db->group_by('year');
        $result = $this->db->get();
        if ($result) {
            $result = $this->get_request_select($result->result_array(),0);
        } else {
            $result = $this->get_error();
        }
        return $result;
    }
    function get_teachers_year()
    {
        $year   = $this->get_year();
        $db     = $this->get_db_name();
        
        $this->db->select('COUNT(td.id_docente) AS total, t2.year');
        $this->db->from($db.'.docentes AS td');
        $this->db->join($db.'.aux_docentes AS t2', 't2.id_docente = td.id_docente', 'left');
        $this->db->where('td.estado', 1);
        $this->db->group_by('t2.year');
        $result = $this->db->get();
        if ($result) {
            $result = $this->get_request_select($result->result_array(),0);
        } else {
            $result = $this->get_error();
        }
        return $result;
    }
    function get_registered_year()
    {
        $year   = $this->get_year();
        $db     = $this->get_db_name();
        
        $this->db->select('COUNT(id) AS total, year');
        $this->db->from($db.'.student_enrollment');
        $this->db->where('id_state', 2);
        $this->db->group_by('year');
        $result = $this->db->get();
        if ($result) {
            $result = $this->get_request_select($result->result_array(),0);
        } else {
            $result = $this->get_error();
        }
        return $result;
    }
    
    /**
     * Regresa el total de estudiantes matriculados del año lectivo seleccionado
     * @return   JSON
     */
    function get_students_enrolled()
    {
        $year   = $this->get_year();
        $db     = $this->get_db_name();
        $this->db->where('id_state', 2);
        $this->db->where('year', $year);
        $this->db->from($db.'.student_enrollment'); 
        $m  = $this->db->count_all_results();        

        $this->db->where('id_state > 2');
        $this->db->where('year', $year);
        $this->db->from($db.'.student_enrollment');        
        $r  = $this->db->count_all_results();        
        
        $this->db->where('t1.estado', 1);
        $this->db->where('t2.year', $year);
        $this->db->from($db.'.docentes AS t1');  
        $this->db->join($db.'.aux_docentes AS t2', 't2.id_docente = t1.id_docente', 'left');      
        $d  = $this->db->count_all_results();        
        
        return json_encode(array(
            'SUCCESS'       => TRUE,
            'registered'    => $m,
            'retired'       => $r,
            'teachers'      => $d
        ));
    }
    
}
/* End of file M_stats.php */
/* Location: ./../models/M_stats.php */   