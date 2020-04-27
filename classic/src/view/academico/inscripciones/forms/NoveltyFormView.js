Ext.define('Admin.view.academico.inscripciones.forms.NoveltyFormView', {
	extend: 'Admin.base.WindowCrud',
	alias: 'widget.NoveltyFormView',
	maximized: false,
	maxWidth: 450,
	maxHeight: 350,
	controller: 'academico',
	initComponent: function () {
		this.callParent(arguments);
		this.setTitle(AppLang.getSTitleViewNovelty());
	},
	config : {
		record : null
	},
	closeAction	: 'hide',
	onSave: function (btn) {
		var
			store 	= this.getStore(),
			me 	  	= this.getController(),
			sm 	  	= Admin.getApplication();
		if (store) {
			var win 		= this,
				form 		= win.down('form'),
				values 		= form.getValues(),
				record 		= form.getRecord(),
				dataGrid 	= win.getRecord();
			store = Ext.getStore(store);
			if (dataGrid) {
				values.id_register	= dataGrid.get('id');
				me.onDataSave(record, values, store, values, win);
			} else {
				sm.showResult('Debe seleccionar una matricula.');
			}
		}
	},
	store: 'NoveltyStore',
	items: [
		{
			xtype: 'customform',
			items: [
				{

					xtype	: 'CbEstado',
					name	: 'id_state'
				},
				{
					xtype	: 'DateField',
					name	: 'date'
				},
				{
					xtype		: 'textAreaField',
					fieldLabel	: 'Movtivo',
					name		: 'motive'
				}
			]
		}
	]
});
