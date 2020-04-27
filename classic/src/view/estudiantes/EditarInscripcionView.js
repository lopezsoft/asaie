Ext.define('Admin.view.estudiantes.EditarInscripcionView' ,{
    extend	: 'Admin.base.WindowCrud',
    alias 	: 'widget.EditarInscripcionView',
	maximized	: false,
	height		: 550,
	controller	: 'estudiantes',
	requires	: [
		'Admin.combo.CbDptos',
        'Admin.combo.CbDocumentos',
        'Admin.combo.CbDepartamentos',
        'Admin.combo.CbCiudades',
		'Admin.combo.CbRH',
		'Admin.store.general.DptosStore'
	],
    items : [
    	{
			xtype		: 'customform',
			defaultType	: 'fieldSet',
			items	: [
				{
					title	: 'DATOS DE IDENTIFICACIÓN',
					items 	: [
						{
                            fieldLabel  : 'Número del documento',
                            name        : 'nro_doc_id'
						},
                        {
                            xtype       : 'CbDocumentos'
                        },
                        {
                            xtype       : 'CbDepartamentos',
                            fieldLabel  : 'Departamento de Expedición',
							name		: 'dpto_lug_exp'
                        },
                        {
                            xtype       : 'CbCiudades',
                            fieldLabel  : 'Ciudad de expedición',
							name		: 'mun_lug_exp'
                        },
                        {
                            fieldLabel  : 'Primer apellido',
                            name        : 'apellido1'
                        },
                        {
                            fieldLabel  : 'Segundo apellido',
                            name        : 'apellido2',
                            allowBlank 	: true
                        },
                        {
                            fieldLabel  : 'Primer nombre',
                            name        : 'nombre1'
                        },
                        {
                            fieldLabel  : 'Segundo nombre',
                            name        : 'nombre2',
                            allowBlank 	: true
                        },
                        {
                            xtype       : 'CbRH'
                        },
						{
							xtype       : 'CbSexo'
						},
						{
							xtype		: 'DateField',
							fieldLabel  : 'Fecha nacimiento',
							name        : 'fecha_nacimiento'
						},
						{
							fieldLabel  : 'Edad',
							name        : 'edad',
							disabled	: false,
							readonly	: true,
							allowBlank 	: false
						},
						{
							xtype       : 'Combo',
							fieldLabel  : 'Departamento de nacimiento',
							name		: 'dpto_lug_nac',
							reference   : 'dpto_nac',
							publishes   : 'value',
							store		: 'DptosStore',
							allowBlank	: false,
							emptyText 	: 'Elija un departamento',
							displayField: 'nombre',
							valueField	: 'id',
							listeners	: {
								select 	: function(combo, record, eOpts){
									var cSME	= Admin.getApplication();
									extParam	= {
										pDpto : record.get('id')
									};
									cSME.setParamStore('CiudStore2', extParam, true);
								},
								afterrender : function ( cbo, eOpts ){
									if(!Ext.isEmpty(cbo.getValue())){
										var cSME	= Admin.getApplication(),
										extParam	= {
											pDpto : cbo.getValue()
										};
										cSME.setParamStore('CiudStore2', extParam, true);
									}
								}
							}
						},
						{
							xtype       : 'CbCiudades',
							fieldLabel  : 'Ciudad de nacimiento',
							store		: 'CiudStore2',
							name		: 'mun_lug_nac',
							reference	: 'mun_lug_nac',
							displayField: 'nombre_mun',
							valueField	: 'id',
							bind: {
								visible: '{dpto_nac.value}'
							}
						}
					]
				},
				{
					title	: 'INFORMACIÓN SOCIO-ECONÓMICA',
					items 	: [
						{
							xtype	: 'CbEstrato'
						},
						{
							xtype	: 'CbSisben'
						},
						{
							fieldLabel 	: 'Número del carné',
							name		: 'nro_sisben',
							allowBlank 	: true
						},
						{
							fieldLabel	: 'Puntaje',
							name		: 'puntaje_sisben',
							allowBlank 	: true
						},
						{
							xtype		: 'fieldcontainer',
							fieldLabel	: 'Benericiario',
							defaultType	: 'customcheckboxfield',
							items: [
								{
									boxLabel  : 'Alumno Madre cabeza de familia',
									name      : 'cab_familia',
									id        : 'checkbox1'
								},
								{
									boxLabel  : 'Beneficiario Hijos dependientesde de Madre cabeza de familia',
									name      : 'ben_mad_flia',
									id        : 'checkbox2'
								},
								{
									boxLabel  : 'Beneficiario Veteranos de la fuerza pública',
									name      : 'ben_vet_fp',
									id        : 'checkbox3'
								},
								{
									boxLabel  : 'Beneficiario Héroes de la Nación',
									name      : 'ben_her_nan',
									id        : 'checkbox4'
								}
							]
						},
						{
							xtype	: 'CbEps'
						},
						{
							fieldLabel	: 'IPS asignada',
							name		: 'IPS',
							allowBlank 	: true
						}
					]
				},
				{
					title	: 'INFORMACIÓN DE RESIDENCIA',
					items 	: [
						{
							fieldLabel	: 'Dirección residencial',
							name		: 'direccion'
						},
						{
							fieldLabel	: 'Teléfono residencial',
							name		: 'telefono',
							allowBlank 	: true
						},
						{
							xtype       : 'Combo',
							fieldLabel  : 'Departamento de residencia',
							name		: 'dpto_lug_res',
							reference   : 'dpto_res',
							publishes   : 'value',
							store		: 'DptosStore',
							allowBlank	: false,
							emptyText 	: 'Elija un departamento',
							displayField: 'nombre',
							valueField	: 'id',
							listeners	: {
								select 	: function(combo, record, eOpts){
									var cSME	= Admin.getApplication();
									extParam	= {
										pDpto : record.get('id')
									};
									cSME.setParamStore('CiudStore3', extParam, true);
								},
								afterrender : function ( cbo, eOpts ){
									if(!Ext.isEmpty(cbo.getValue())){
										var cSME	= Admin.getApplication(),
											extParam	= {
												pDpto : cbo.getValue()
											};
										cSME.setParamStore('CiudStore3', extParam, true);
									}
								}
							}
						},
						{
							xtype       : 'CbCiudades',
							fieldLabel  : 'Ciudad de residencia',
							store		: 'CiudStore3',
							name		: 'mun_lug_res',
							reference	: 'mun_lug_res',
							displayField: 'nombre_mun',
							valueField	: 'id',
							bind: {
								visible: '{dpto_res.value}'
							}
						},
						{
							xtype	: 'CbZona'
						}
					]
				},
				{
					title	: 'INFORMACIÓN COMPLEMENTARIA',
					items 	: [
						{
							xtype	: 'CbPoblacionVictimaCon'
						},
						{
							xtype       : 'Combo',
							fieldLabel  : 'Último departamento expulsor',
							name		: 'dpto_lug_pobl',
							reference   : 'dpto_exp',
							publishes   : 'value',
							store		: 'DptosStore',
							allowBlank	: false,
							emptyText 	: 'Elija un departamento',
							displayField: 'nombre',
							valueField	: 'id',
							listeners	: {
								select 	: function(combo, record, eOpts){
									var cSME	= Admin.getApplication();
									extParam	= {
										pDpto : record.get('id')
									};
									cSME.setParamStore('CiudStore4', extParam, true);
								},
								afterrender : function ( cbo, eOpts ){
									if(!Ext.isEmpty(cbo.getValue())){
										var cSME	= Admin.getApplication(),
											extParam	= {
												pDpto : cbo.getValue()
											};
										cSME.setParamStore('CiudStore4', extParam, true);
									}
								}
							}
						},
						{
							xtype       : 'CbCiudades',
							fieldLabel  : 'Última Ciudad de expulsión',
							store		: 'CiudStore4',
							name		: 'mun_lug_pobl',
							reference	: 'mun_lug_exp',
							displayField: 'nombre_mun',
							valueField	: 'id',
							bind: {
								visible: '{dpto_exp.value}'
							}
						},
						{
							xtype		: 'CbDesicion',
							name		: 'proviene_sector_priv',
							fieldLabel	: 'Proviene del sector privado?'
						},
						{
							xtype		: 'CbDesicion',
							name		: 'proviene_otro_mun',
							fieldLabel	: 'Proviene de otro Municipio?'
						},
						{
							xtype		: 'CbTipoDiscapacidad'
						},
						{
							xtype		: 'CbCapacidadesExcepcionales'
						},
						{
							xtype		: 'CbEtnias'
						},
						{
							xtype		: 'CbResguardos'
						},
						{
							fieldLabel	: 'Código de familias en acción',
							name		: 'cod_flia_accion',
							allowBlank 	: true
						}
					]
				},
				{
					title	: 'INFORMACIÓN DE MATRICULA',
					itemId	: 'FsMatricula',
					hidden	: true,
					items 	: [
						{
							xtype	: 'CbSedes',
							allowBlank 	: true
						},
						{
							xtype	: 'CbGrados',
							allowBlank 	: true
						},
						{
							xtype	: 'CbGrupo',
							allowBlank 	: true
						},
						{
							xtype	: 'CbJornadas',
							name	: 'id_jorn',
							allowBlank 	: true
						}
					]
				}

			]
		}		    
	]
});