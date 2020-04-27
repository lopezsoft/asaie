<?php defined('BASEPATH') OR exit('No direct script access allowed');
    // Incluimos el archivo fpdf
    require_once APPPATH."/third_party/fpdf/fpdf.php";

    //Extendemos la clase Pdf de la clase fpdf para que herede todas sus variables y funciones
    class Pdf extends FPDF {
    	private $CI;
        public function __construct() {
            parent::__construct();
            $this->CI	= &get_instance();
            $this->CI->load->model('M_sql');
            //$this->load->model('M_sql');
        }
        // El encabezado del PDF
        public function Header(){
        	$query	= "SELECT * FROM  encabezado_reportes WHERE id_inst=".$this->CI->M_sql->id_inst
        	." AND año=".$this->CI->M_sql->año_lectivo;
        	$query	= $this->CI->db->query($query);
        	
        	if ($query) {
				$this->Image('resources/img/logo_escuela.png',10,8,22);
	            $this->SetFont('Arial','B',12);
	            $this->Cell(30);
	            $this->MultiCell(120,5,rtrim(utf8_decode($query->row('encabezado'))),0,'C');
	            $this->Cell(30);
	            $this->MultiCell(120,5,rtrim(utf8_decode($query->row('dane'))),0,'C');
	            $this->Cell(30);
	            $this->MultiCell(120,5,rtrim(utf8_decode($query->row('nit'))),0,'C');	
	            $this->SetFont('Arial','B',8);
	            $this->Cell(30);
	            $this->MultiCell(120,3,rtrim(utf8_decode($query->row('resolucion'))),0,'C');
			}else{
				$this->Image('resources/img/logo_escuela.png',10,8,22);
	            $this->SetFont('Arial','B',13);
	            $this->Cell(30);
	            $this->Cell(120,10,'ESCUELA X',0,0,'C');
	            $this->Ln('5');
	            $this->SetFont('Arial','B',8);
	            $this->Cell(30);
	            $this->Cell(120,10,'INFORMACION DE CONTACTO',0,0,'C');
			}
            
            $this->Ln(10);
       }
       // El pie del pdf
       public function Footer(){
       		$query	= "SELECT * FROM  encabezado_reportes WHERE id_inst=".$this->CI->M_sql->id_inst
        	." AND año=".$this->CI->M_sql->año_lectivo;
        	$query	= $this->CI->db->query($query);
        	if ($query) {
				$this->SetY(-20);
           		$this->SetFont('Arial','B',9);
           		$this->MultiCell(0,4,rtrim(utf8_decode($query->row('pie'))),0,'C');
           		$this->SetFont('Arial','I',7);
           		$this->MultiCell(0,3,rtrim(utf8_decode('Software académico S.M.E - www.lopezsoft.net.co - lopezsoft.com@gmail.com - (057) 310 8435431 -  321 501 6931')),0,'C');
           		$this->Cell(0,3,'Page '.$this->PageNo().'/{nb}',0,0,'C');
			}else{
				$this->SetY(-15);
           		$this->SetFont('Arial','I',8);
           		$this->Cell(0,10,'Page '.$this->PageNo().'/{nb}',0,0,'C');
			}          
      }
    }
