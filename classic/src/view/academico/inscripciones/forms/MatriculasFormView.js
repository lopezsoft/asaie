Ext.define('Admin.view.academico.inscripciones.forms.MatriculasFormView' ,{
    extend	: 'Admin.base.WindowCrud',
    alias 	: 'widget.matriculas',
    xtype 	: 'matriculas',
	maximized	: false,
	maxWdth		: 550,
	controller: 'academico',
	initComponent: function () {
		this.callParent(arguments);
		this.setTitle(AppLang.getSTitleViewEnrollment());
	},
	onSave: function (btn) {
		var
			store 	= this.getStore(),
			me 		= this.getController(),
			sm		= Admin.getApplication();		
		if (store) {
			var win = this,
				form 		= win.down('form'),
				values 		= form.getValues(),
				record 		= form.getRecord(),
				dataGrid 	= Ext.ComponentQuery.query('InscripcionesView')[0].down('grid').getSelection()[0];
			store = Ext.getStore(store);
			if (dataGrid) {
				values.id_student = dataGrid.get('id');
				me.onDataSave(record, values, store, values, win);
				xStore = Ext.getStore('HistorialStore')
				xStore.reload();
			} else {
				sm.showResult('Debe seleccionar un estudiante.');
			}
		}
	},
	store	: 'MatriculasStore',
	defaultFocus    : 'CbSedes',
    items : [
    	{
			xtype		: 'customform',
			defaultType	: 'fieldSet',
			items	: [
				{
					title	: 'INFORMACIÓN DE MATRICULA',
					items 	: [
						{
							xtype	: 'CbSedes',
							name	: 'id_headquarters',
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
							fieldLabel	: 'INTS. Donde estudió el año anterior',
							name		: 'inst_origin',
							itemId		: 'inst_origin',
							allowBlank	: true
						},
						{
							fieldLabel	: 'Dirección de la INST.',
							name		: 'inst_address',
							itemId		: 'inst_address',
							allowBlank	: true
						},
						{
							xtype		: 'CbEstado'
						},
						{
							xtype	: 'CbGrados',
							name	: 'id_grade'
						},
						{
							xtype		: 'CbJornadas',
							name		: 'id_study_day'
						},
						{
							xtype		: 'CbGrupo',
							name		: 'id_group'
						},
						{
							xtype		: 'yearField',
							name		: 'year'
						},
						{
							xtype		: 'DateField',
							name		: 'date'
						},
						{
							xtype		: 'textAreaField',
							fieldLabel	: 'Observaciones',
							name		: 'obs',
							allowBlank	: true
						},
						{
							fieldLabel	: 'Folio de matricula',
							name		: 'folio',
							readOnly  	: true,
							allowBlank	: true,
							value		: '0'
						},
						{
							fieldLabel	: 'Libro de matricula',
							name: 'registration_number',
							readOnly 	: true,
							allowBlank	: true,
							value		: '0'
						}
					]
				}

			]
		}		    
	]
});
