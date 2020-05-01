<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Families_m extends SME_Model {
    public function __construct()
    {
        parent::__construct();
    }


    
	function getFamilies($cod){
		if (empty($cod)){		
			$total	= $this->get_count_all('families');			
		}else{			
			$total 	= $this->get_count_all('aux_families_students',"id_student=".$cod);	
			$this->db->where('t2.id_student', $cod);			
		};
		$db	= $this->get_db_name();
		$this->db->select("t1.*, CONCAT(RTRIM(lastname1),' ',RTRIM(lastname2),' ',RTRIM(name1),' ',RTRIM(name2)) AS nombres,".
							"t2.id_student,t2.id_type, t2.id_relationship, t3.name_kinship, t4.family_type_name");
		$this->db->from($db.'.families AS t1');
		$this->db->join($db.'.aux_families_students AS t2', 't2.id_family = t1.id', 'left');
		$this->db->join($db.'.family_relationships AS t3', 't2.id_relationship = t3.id', 'left');
		$this->db->join($db.'.family_type AS t4', 't2.id_type = t4.id ', 'left');
		$this->db->order_by('nombres,t2.id_student');
		$query	= $this->db->get();			
		return $this->get_request_select($query->result_array(), $total);
	}
	
    
    function getFamiliesStudent($id){
        $db     = $this->get_db_name()  ;
        $this->db->select("t2.*, t1.document, t1.address, t1.mobile, CONCAT(RTRIM(lastname1),' ',RTRIM(lastname2),' ',RTRIM(name1),' ',RTRIM(name2)) AS nombres,".
        "t2.id_student,t2.id_type, t2.id_relationship, t3.name_kinship, t4.family_type_name");
        $this->db->from($db.'.families AS t1');
        $this->db->join($db.'.aux_families_students AS t2', 't2.id_family = t1.id', 'left');
        $this->db->join($db.'.family_relationships AS t3', 't2.id_relationship = t3.id', 'left');
        $this->db->join($db.'.family_type AS t4', 't2.id_type = t4.id ', 'left');
        $this->db->where('t2.id_student', $id);
        $this->db->order_by('nombres,t2.id_student');
        $query  = $this->db->get();
        
        return $this->getJsonResponse($query->result(), $query->num_rows()); ;
    }
}

/* End of file Families_m.php */
