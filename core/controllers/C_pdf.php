<?php defined('BASEPATH') OR exit('No direct script access allowed');

class C_pdf extends SME_Controller 
{
	public function __construct() 
	{
		parent::__construct();
		// Se carga el modelo alumno
		$this->load->model('M_pdf');
		// Se carga la libreria fpdf
		$this->load->library('pdf');
		
		$this->load->model('M_sql');
	}
		
	public function recuperaciones() {
		
	
		// Sentencia SQL para el parametro
		
		
		$c_grado	= $_GET['pdbCodGrado']	;
		$periodo	= $_GET['pdbPeriodo']	;
		
		// Nombre dado al informe de salida
		$report_export	= "recuperaciones_periodicas_periodo".$periodo.".pdf";
		
		$table = $this->M_sql->tabla_notas($c_grado);
		
		$this->M_sql->get_filter_bajo();
		
		$query	= "SELECT tn.id_inst,tn.cod_est, tn.cod_grado, tn.grupo, tm.año, tn.periodo,
		tn.cod_jorn, tn.id_sede, tn.id_asig, tn.id_docente,tn.final,tn.nota_perdida,tn.nota_habilitacion, 
		tn.fecha, tn.conceptual,CONCAT(RTRIM(te.apellido1),' ',RTRIM(te.apellido2),' ',RTRIM(te.nombre1)
		,' ',RTRIM(te.nombre2)) AS estudiante, tm.estado,tar.area, tar.abrev AS abre_area, 
		tas.des_asign AS asignatura, tas.abrv AS abrev_asig, tas.cod_area, 
		CONCAT(RTRIM(td.apellido1),' ',RTRIM(td.apellido2),' ',	RTRIM(td.nombre1),' ',RTRIM(td.nombre2)) as docente,
		ts.nom_sede AS sede, tj.jornada, tg.grado FROM ".$table." AS tn LEFT JOIN inscripciones AS te
		 ON te.cod_est=tn.cod_est LEFT JOIN matriculas AS tm on tm.cod_est=te.cod_est 
		 LEFT JOIN asignaturas AS tas ON tn.id_asig=tas.cod_asign 
	    LEFT JOIN areas AS tar ON tas.cod_area=tar.cod_area LEFT JOIN docentes AS td ON 
	    td.id_docente=tn.id_docente LEFT JOIN sedes AS ts ON tn.id_sede=ts.id 
	    LEFT JOIN jornadas AS tj ON tn.cod_jorn=tj.cod_jorn 
	    LEFT JOIN grados As tg ON tn.cod_grado=tg.cod_grado ";
	   
				
		$where	= "tn.nota_perdida>0 AND tm.estado= ? 
		AND tn.cod_grado= ? AND tn.periodo= ? AND tm.año= ? AND tn.año= ?  
		AND tas.año= ? and tar.año= ? AND tn.id_inst=? AND tn.id_docente= ? 
		ORDER BY tn.cod_grado, tn.grupo, tn.cod_jorn, estudiante, docente,tn.id_asig,tas.cod_area";
		
		$param	= array(
			2,
			$c_grado,
			$periodo,
			$this->M_sql->año_lectivo,
			$this->M_sql->año_lectivo,
			$this->M_sql->año_lectivo,
			$this->M_sql->año_lectivo,
			$this->M_sql->id_inst,
			$this->M_sql->id_docente
		);
		
		$query = $query.' WHERE '.$where;
		
		$request	= $this->db->query($query,$param);

		if ($request){
			$this->M_sql->get_filter_bajo();
			$this->pdf = new Pdf('p','mm','Letter');
			// Agregamos una páginna
			$this->pdf->AddPage();
			// Define el alias para el número de página que se imprimir el pie
			$this->pdf->AliasNbPages();

			/* Se define el titulo, márgenes izquierdo, derecho y
			 * el color de relleno predeterminado
			 */
			$this->pdf->SetTitle("Lista de alumnos en recuperación");
			$this->pdf->SetLeftMargin(15);
			$this->pdf->SetRightMargin(15);
			$this->pdf->SetFillColor(200,200,200);
			
			// Se define el nombre del docente, el periodo y la sedes
			
			$this->pdf->Cell(0,4,'   SEDE: '.rtrim(utf8_decode($request->row('sede'))),0,0,'L');
			$this->pdf->Ln(3);
			$this->pdf->Cell(0,4,'PERIODO: '.utf8_decode($request->row('periodo')." - ".$request->row('año')),0,0,'L');
			$this->pdf->Ln(3);
			$this->pdf->Cell(0,4,'DOCENTE: '.rtrim(utf8_decode($request->row('docente'))),0,0,'L');
			$this->pdf->Ln(5);
			// Se define el formato de fuente: Arial, negritas, tama�o 9
			$this->pdf->SetFont('Arial', 'B', 7);
			/*
			 * TITULOS DE COLUMNAS
			 *
			 * $this->pdf->Cell(Ancho, Alto,texto,borde,posici�n,alineaci�n,relleno);
			 */

			$this->pdf->Cell(7,3,utf8_decode('Nº'),			1,0,'C','1');
			$this->pdf->Cell(65,3,'ESTUDIANTE',				1,0,'C','1');
			$this->pdf->Cell(10,3,'CURSO',					1,0,'C','1');
			$this->pdf->Cell(10,3,'ASIG',					1,0,'C','1');
			$this->pdf->Cell(10,3,'N.PER',					1,0,'C','1');
			$this->pdf->Cell(10,3,'N.REC',					1,0,'C','1');
			$this->pdf->Cell(15,3,'FECHA',					1,0,'C','1');
			$this->pdf->Cell(13,3,utf8_decode('ÁREA'),		1,0,'C','1');
			$this->pdf->Cell(35,3,'FIRMA DEL ESTUDIANTE',	1,0,'C','1');
			$this->pdf->Ln(3);
			// La variable $x se utiliza para mostrar un n�mero consecutivo
			$this->pdf->SetFont('Arial', '', 7);
			$x = 1;
			$lista	= $request->result() ;
			foreach ($lista as $alumno) {
				// Seteo de variables
				$nota_habilitacion	= ($alumno->nota_habilitacion > 0.00 ? $alumno->nota_habilitacion : '');
				$fecha				= ($alumno->fecha	== '0000-00-00' ? '' : $alumno->fecha);
				// se imprime el numero actual y despues se incrementa el valor de $x en uno
				$this->pdf->Cell(7,3,$x++,1,0,'R',0);
				// Se imprimen los datos de cada alumno
				$this->pdf->Cell(65,3,rtrim(utf8_decode($alumno->estudiante)),1,0,'L',0);
				$this->pdf->Cell(10,3,utf8_decode($alumno->cod_grado." - ".$alumno->grupo),1,0,'L',0);
				$this->pdf->Cell(10,3,utf8_decode($alumno->abrev_asig),1,0,'C',0);
				$this->pdf->Cell(10,3,$alumno->nota_perdida,1,0,'R',0);
				$this->pdf->Cell(10,3,$nota_habilitacion,1,0,'R',0);
				$this->pdf->Cell(15,3,$fecha,1,0,'C',0);
				$this->pdf->Cell(13,3,rtrim(utf8_decode($alumno->abre_area)),1,0,'L',0);
				$this->pdf->Cell(35,3,'',1,0,'C',0);
				//Se agrega un salto de linea
				$this->pdf->Ln(3);
			}
						
			/*
			 * Se manda el pdf al navegador
			 *
			 * $this->pdf->Output(nombredelarchivo, destino);
			 *  
			 * I = Muestra el pdf en el navegador
			 * D = Envia el pdf para descarga
			 *
			 */
			$this->pdf->Output($report_export, 'D');
		}		
		
	}
}


/* End of file C_pdf.php */
/* Location: ./application/controllers/C_pdf.php */