Ext.define('Admin.view.admin.forms.SaveTeacher' ,{
    extend		: 'Admin.base.SaveWindow',
    alias 		: 'widget.saveteacher',
	controller	: 'admin',
	initComponent: function () {
		this.callParent(arguments);
		this.setTitle(AppLang.getSTitleNewEdit()+' '+AppLang.getSTitleViewTeachers());
	},
	store		: 'ADocentesStore',
	defaultFocus: 'CbCountries',
    items : [
    	{
			xtype		: 'customform',
			defaultType	: 'fieldSet',
			items	: [
				{
					title	: 'DATOS BÁSICOS',
					items: [
						{
							xtype: 'CbCountries'
						},
						{
                            fieldLabel  : 'Número del documento',
                            name        : 'documento'
						},
                        {
                            xtype       : 'CbDocumentos',
							name		: 'id_documento'
                        },
                        {
                            xtype       : 'CbCiudades',
                            fieldLabel  : 'Lugar de expedición',
							name		: 'mun_exp'
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
                            xtype       : 'CbRH',
							name		: 'tipo_sangre'
                        },
						{
							xtype       : 'CbSexo',
							name		: 'sexo'
						},
						{
							xtype		: 'DateField',
							fieldLabel  : 'Fecha nacimiento',
							name        : 'fecha_nacimiento'
						},
						{
							xtype       : 'CbCiudades',
							fieldLabel  : 'Lugar de nacimiento',
							store		: 'CiudStore2',
							name		: 'mun_nac',
							itemId		: 'mun_lug_nac',
							displayField: 'name_city',
							valueField	: 'id'
						}
					]
				},
				{
					title	: 'DATOS GENERALES',
					items 	: [
						{
							fieldLabel	: 'Dirección residencial',
							name		: 'direccion',
							allowBlank 	: true
						},
						{
							fieldLabel	: 'Celular',
							name		: 'movil',
							allowBlank 	: true
						},
						{
							fieldLabel	: 'Teléfono fijo',
							name		: 'fijo',
							allowBlank 	: true
						},
						{
							xtype		: 'CbNivelEns'
						},
						{
							xtype		: 'CbAreaEns'
						},
						{
							xtype		: 'CbEscalafon'
						},
						{
							name		: 'email',
							fieldLabel	: 'Correo electrónico',
							vtype		: 'email',
							allowBlank	: true
						},
						{
							xtype		: 'CbNivelEdu'
						},
						{
							xtype		: 'customradiogroup',
							columns		: 2,
							fieldLabel	: 'Estado',
							items		: [
								{
									boxLabel	: 'Activo',
									name		: 'estado',
									inputValue	: 'true'
								},
								{
									boxLabel	: 'Inactivo',
									name		: 'estado',
									inputValue	: 'false'
								}
							]
						}
					]
				}
			]
		}		    
	]
});
