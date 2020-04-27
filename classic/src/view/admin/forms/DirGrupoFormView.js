Ext.define('Admin.view.admin.forms.DirGrupoFormView' ,{
    extend	: 'Admin.base.WindowCrud',
    alias 	: 'widget.DirGrupoFormView',
	controller	: 'admin',
	requires	: [
		'Admin.store.admin.DocentesDirGrupoStore',
		'Admin.combo.CbGrados',
		'Admin.combo.CbGrupo',
		'Admin.container.SedesJorn'
	],
	height	: '100%',
	width	: 450,
	initComponent: function (cnf) {  
		this.callParent(arguments);	
		this.setTitle(AppLang.getSTitleViewAddGroupDirectors());
	},
	onSave: function (btn) {
		var win 	= btn.up('window'),
			values 	= win.down('grid').getSelection()[0],
			data 	= [],
			store 	= Ext.getStore('DirGrupoStore'),
			me 		= Admin.getApplication();

		if (Ext.isEmpty(values)) {
			me.onAler('No ha selecionado un docente.');
		} else {
			data = {
				id_sede		: win.down('#comboSedes').getSelection().id,
				id_docente	: values.get('id_docente'),
				id_grado	: win.down('#comboGrados').getSelection().id,
				grupo		: win.down('#comboGrupo').getSelection().data.grupo,
				id_jorn		: win.down('#comboJornadas').getSelection().data.cod_jorn,
				estado		: 1
			};
			store.insert(0, data);
			store.sync({
				callback: function (r) {
					me.showResult('Proceso terminado');
					store.reload();
				}
			});
		};
	},
	defaultFocus	: 'CbSedes',
    items : [
    	{
			xtype		: 'customform',
			items: [
				{
					xtype: 'sedesJorn'
				},
				{
					xtype: 'CbGrupo'
				},
				{
					xtype	: 'customgrid',
					selModel: 'rowmodel',
					margin  : '0 3 0 0',
					iconCls	: '',
					plugins		: [
						{
							ptype			: 'gridSearch',
							readonlyIndexes	: ['note'],
							disableIndexes	: ['pctChange'],
							minChars		: 1,
							mode            : 'local',
							flex			: 1,
							autoFocus		: false,
							independent		: true
						}
					],
					store   : 'DocentesDirGrupoStore',
					columns: [
						{
							xtype		: 'customrownumberer'
						},
						{
							text        : 'DOCENTES',
							dataIndex   : 'nombres',
							flex        : 1,
							filter  	: 'string'
						}
					],
					dockedItems : [
						{
							xtype 		: 'pagination',
							itemId		: 'pToolbar'
						}
					]
				}
			]
		}		    
	]
});
