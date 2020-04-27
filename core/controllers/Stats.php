<?php 
defined('BASEPATH') OR exit('No direct script access allowed');
class Stats extends SME_Controller {
    function __construct() {
        parent::__construct();
        $this->check_session_redirect();
        $this->load->model('M_stats');
    }
    /**
     * Regresa el total de estudiantes matriculados del año lectivo seleccionado
     * @return   JSOND 
     */
    function get_students_enrolled()
    {
        $this->check_session_redirect();
        echo $this->M_stats->get_students_enrolled();
    }

    function get_retired_year()
    {
        $this->check_session_redirect();
        echo $this->M_stats->get_retired_year();        
    }
    function get_teachers_year()
    {
        $this->check_session_redirect();
        echo $this->M_stats->get_teachers_year();        
    }
    function get_registered_year()
    {
        $this->check_session_redirect();
        echo $this->M_stats->get_registered_year();        
    }
}
/* End of file Stats.php */
/* Location: ./../controllers/Stats.php */    