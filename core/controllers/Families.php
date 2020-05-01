<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Families extends SME_Controller {
    
    public function __construct()
    {
        parent::__construct();
        $this->load->model('Families_m');
    }

    public function getFamilies()
    {
        echo $this->Families_m->getFamilies();
    }
    
    public function getFamiliesStudent()
    {
        $id     = $this->input->get_post('pdbIdStudent');
        echo $this->Families_m->getFamiliesStudent($id);
    }

}

/* End of file Families.php */
