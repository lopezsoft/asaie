Ext.define('Admin.view.admin.forms.SchoolInformation' ,{
    extend		: 'Admin.forms.CustomForm',
    alias 		: 'widget.schoolinformation',
	controller	: 'admin',	
	initComponent : function(){
		let me	= this;
			app	= Admin.getApplication();
		app.onStore('general.CiudStore');
		app.onStore('general.PoblacionatendidaStore');
		app.onStore('general.ZonaStore');
		app.onStore('general.SectorStore');
		app.onStore('admin.EstablecimientoStore');
		me.setTitle(AppLang.getSTitleNewEdit()+AppLang.getSSpace()+AppLang.getSTitleViewSchool());
		me.callParent(arguments);
	},
	onSave : function(btn){
		this.saveData('EstablecimientoStore', false);
	},
	store		: 'EstablecimientoStore',
	defaultType	: 'fieldSet',
	items	: [
		{
			title	: 'DATOS BÁSICOS',
			items 	: [
				{
					fieldLabel  : 'Dane',
					name        : 'COD_DANE'
				},
				{
					fieldLabel  : 'Nombre del establecimiento',
					name        : 'NOMBRE_IE'
				},
				{
					fieldLabel  : 'Rector(a)/Director(a)',
					name        : 'NOMBRE_RECTOR'
				},
				{
					xtype       : 'CbSector'
				},
				{
					fieldLabel  : 'Núcleo educativo',
					name        : 'NUCLEO',
					allowBlank 	: true
				},
				{
					fieldLabel  : 'Número de sedes',
					name        : 'SEDES'
				},
				{
					fieldLabel  : 'N.I.T',
					name        : 'NIT'
				}
			]
		},
		{
			title	: 'POBLACIÓN ATENDIDA',
			items 	: [
				{
					xtype	: 'CbPoblacionAtendida'
				}
			]
		},
		{
			title	: 'UBICACIÓN',
			items 	: [
				{
					xtype       : 'CbCiudades',
					fieldLabel  : 'Ciudad o Municipio',
					name		: 'ID_CITY'
				},
				{
					fieldLabel	: 'Dirección',
					name		: 'DIRECCION'
				},
				{
					fieldLabel	: 'Barrio',
					name		: 'BARRIO'
				},
				{
					fieldLabel	: 'Localidad',
					name		: 'LOCALIDAD',
					allowBlank 	: true
				},
				{
					xtype		: 'CbZona',
					name		: 'ID_ZONA'
				},
				{
					fieldLabel	: 'FAX',
					name		: 'FAX',
					allowBlank 	: true
				},
				{
					fieldLabel	: 'Teléfonos',
					name		: 'TELEFONOS',
					allowBlank 	: true
				},
				{
					fieldLabel	: 'Correo electrónico',
					name		: 'CORREO',
					allowBlank 	: true
				},
				{
					fieldLabel	: 'Página WEB',
					name		: 'WEB',
					allowBlank 	: true
				}
			]
		}
	]
});
