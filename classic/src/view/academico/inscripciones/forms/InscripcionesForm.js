Ext.define('Admin.view.academico.inscripciones.forms.InscripcionesForm',{
    extend	: 'Admin.base.SaveWindow',
    alias 	: 'widget.InscripcionesForm',
	maxWidth	: 750,
	controller	: 'academico',
	requires	: [
		'Admin.combo.CbCountries',
        'Admin.combo.CbDocumentos',
        'Admin.combo.CbCiudades',
		'Admin.combo.CbRH',
		'Admin.combo.CbPoblacionAtendida',
		'Admin.sockets.Socket'
	],
	initComponent: function () {
		this.callParent(arguments);
		this.setTitle(AppLang.getSTitleNewEdit() + ' ' + AppLang.getSTitleViewStudents());
	},
	store		: 'InscripcionesStore',
	defaultFocus: 'CbCountries',
    items : [
    	{
			xtype	: 'customform',
			defaultType	: 'fieldSet',
			items	: [
				{
					title	: 'DATOS DE IDENTIFICACIÓN',
					items 	: [
                        {
                            xtype       : 'CbCountries'
                        },
						{
                            fieldLabel  : 'Número del documento',
                            name        : 'nro_documento',
							listeners	: {
								focusleave : function (me, event, eOpts) {
									var
										form	= me.up('window').down('form'),
										values	= form.getValues(),
										app		= Admin.getApplication(),
										record	= form.getRecord();
									if (!record){
										if (me.getValue().length > 0){
											let 
												socket	= Global.getSocket();
											
											socket.emit('querySelect',{
												dataName: Global.getDbName(),
												table	: 'inscripciones',
												where	:  ['nro_documento = ?'],
												values	: [me.getValue()]
											}, function (err, result){
												if(err){
													app.onError(err.message);
												}else{
													values	= result;
													if (values.length > 0) {
														form.reset();
														form.getForm().setValues(values[0]);
														app.showResult('Ya existe una inscripción para el documento: '+me.getValue().toString());
														form.down('#FsMatricula').setHidden(true);
													}else{
														form.down('#FsMatricula').setHidden(false);
													}
												}
											});

										}
									}
								}
							}
						},
                        {
							xtype	: 'CbDocumentos',
							name	: 'id_documento'
                        },
                        {
                            xtype       : 'CbCiudades',
                            fieldLabel  : 'Lugar de expedición',
							name		: 'lug_expedicion'
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
							xtype		: 'CbPoblacionAtendida',
							fieldLabel	: 'Sexo',
							name		: 'id_sexo'
						},
						{
							xtype		: 'DateField',
							fieldLabel  : 'Fecha de nacimiento',
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
							xtype       : 'CbCiudades',
							fieldLabel  : 'Lugar de nacimiento',
							store		: 'CiudStore2',
							name		: 'lug_nacimiento'
						},
                        {
                            fieldLabel  : 'Correo electrónico',
                            name        : 'email',
                            vtype       : 'email',
                            emptyText   : 'example@email',
                            allowBlank  : true
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
							fieldLabel	: 'IPS asignada',
							name		: 'ips',
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
							fieldLabel	: 'Localidad',
							name		: 'localidad',
							allowBlank 	: true
						},
						{
							xtype       : 'CbCiudades',
							fieldLabel  : 'Lugar de residencia',
							store		: 'CiudStore3',
							name		: 'lug_residencia'
						},
						{
							xtype		: 'CbZona'
						},
						{
							fieldLabel	: 'Teléfono fijo',
							name		: 'telefono',
							allowBlank 	: true
						},
						{
							fieldLabel	: 'Movíl',
							name		: 'movil',
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
							xtype		: 'CbSedes',
							name		: 'id_headquarters',
							allowBlank 	: true,
							listeners: {
								select: function (cb, r) {
									var
										me = Admin.getApplication(),                
										param = {
											pdbTable    : 'jornadas',
											pdbSede     : r.id
										};
									me.setParamStore('JornadasStore', param, true);
				
									param = {
										pdbTable    : 'grados',
										pdbSede     : r.id
									};
									me.setParamStore('GradosStore', param, true);
								}
							}
						},
						{
							xtype	: 'CbJornadas',
							bind: {
								visible: '{comboSedes.value}'
							},
							name		: 'id_study_day',
							allowBlank 	: true
						},
						{
							xtype		: 'CbGrados',
							bind: {
								visible	: '{comboJornadas.value}'
							},
							name		:'id_grade',
							allowBlank 	: true
						},
						{
							xtype	: 'CbGrupo',
							bind: {
								visible: '{comboGrados.value}'
							},
							name		: 'id_group',
							allowBlank 	: true
						}
					]
				}

			]
		}		    
	]
});
