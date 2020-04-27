Ext.define('Admin.view.academico.inscripciones.forms.FamiliaresFormView' ,{
    extend	: 'Admin.base.WindowCrud',
    alias 	: 'widget.FamiliaresFormView',
	height	: '100%',
	controller	: 'academico',
	requires	: [
		'Admin.sockets.Socket'
	],
	closeAction : 'hide',
	initComponent: function () {
		this.callParent(arguments);
		this.setTitle(AppLang.getSTitleNewEdit()+' '+AppLang.getSTitleViewFamilies());
	},
	width	: 450,
	store: 'FamiliaresStore',
	defaultFocus	: 'CbCountries',
    items : [
    	{
			xtype		: 'customform',
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
							name        : 'document',
							listeners	: {
								focusleave : function (me, event, eOpts) {
									var
										form	= me.up('window').down('form'),
										values	= form.getValues(),
										app		= Admin.getApplication(),
										record	= form.getRecord();
									if (!record){
										if (me.getValue().length > 0){
											SME.sockets.Socket.request({
												url		: ['sqlQuerySQL','requestQuerySQL'],
												host	: Globale.getHostSocket(),
												extraParams	: {
													pdbQuery		: Globale.getDbName()+'.families',
													pdbWhereFields	: ['document = ?'],
													pdbWhereValues	: [me.getValue()],
													pdbFields		: '*'
												},
												params	: {
													start	: 0,
													limit	: 1
												},
												success : function (req, res) {
													var
														resVal	= Ext.decode(req.responseText);
													values	= resVal.records[0];
													if (values){
														form.getForm().setValues(values);
														app.showResult('Ya existe un familiar para el documento: '+me.getValue().toString());
													}
												},
												failure	: function (req, res) {
													app.onMsgClose();
													app.onError('ERROR');
												},
												callback	: function () {
													app.onMsgClose();
												}
											});
										}
									}
								}
							}
						},
						{
							xtype       : 'CbDocumentos',
							name		: 'id_document'
						},
						{
							xtype       : 'CbCiudades',
							fieldLabel  : 'Lugar de expedición',
							name		: 'expedition_plane'
						},
						{
							fieldLabel  : 'Primer apellido',
							name        : 'lastname1'
						},
						{
							fieldLabel  : 'Segundo apellido',
							name        : 'lastname2',
							allowBlank 	: true
						},
						{
							fieldLabel  : 'Primer nombre',
							name        : 'name1'
						},
						{
							fieldLabel  : 'Segundo nombre',
							name        : 'name2',
							allowBlank 	: true
						},
						{
							xtype		: 'CbPoblacionAtendida',
							fieldLabel	: 'Sexo',
							name		: 'id_sex'
						},
						{
							xtype	: 'CbRH',
							name	: 'blood_type'
						},
						{
							xtype		: 'CbTipoFamiliar'
						},
						{
							xtype		: 'CbParentescoFamiliar'
						},
						{
							xtype		: 'customcheckboxfield',
							boxLabel  	: 'Agregar como acudiente',
							name      	: 'add_acud',
							id        	: 'CkAcud',
							hidden		: true
						}
					]
				},
				{
					title	: 'INFORMACIÓN DE RESIDENCIA',
					items 	: [
						{
							fieldLabel	: 'Dirección residencial',
							name		: 'address'
						},
						{
							fieldLabel	: 'Teléfono celular',
							name		: 'mobile',
							allowBlank 	: true
						},
						{
							xtype       : 'CbCiudades',
							fieldLabel  : 'Lugar de residencia',
							store		: 'CiudStore2',
							name		: 'birth_place'
						}
					]
				},
				{
					title	: 'DATOS LABORALES',
					items 	: [
						{
							fieldLabel	: 'Empresa donde labora',
							name		: 'company',
							allowBlank	: true
						},
						{
							fieldLabel	: 'Ocupación o cargo',
							name		: 'occupation',
							allowBlank	: true
						},
						{
							fieldLabel	: 'Dirección laboral',
							name		: 'work_address',
							allowBlank	: true
						},
						{
							fieldLabel	: 'Correo electrónico',
							name		: 'email',
							allowBlank	: true
						}
					]
				}

			]
		}		    
	]
});
