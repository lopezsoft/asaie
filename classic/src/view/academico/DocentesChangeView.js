/**
 * Created by LOPEZSOFT2 on 31/03/2017.
 */
Ext.define('Admin.view.academico.DocentesChangeView',{
    extend  : 'Admin.base.WindowCrud',
    controller  : 'academico',
    alias       : 'widget.DocentesChangeView',
	requires	: [
		'Admin.store.admin.DocentesDirGrupoStore'
	],
	initComponent: function () {
		this.callParent(arguments);
		this.setTitle(AppLang.getSTitleViewTeachers() + ' - ' + Global.getYear());
	},
    height	    : 550,
	record		: null,
    items       : [
        {
			xtype       : 'customgrid',
			plugins		: [
				{
					ptype : 'responsive'
				},
				{
					ptype			: 'gridSearch',
					readonlyIndexes	: ['note'],
					disableIndexes	: ['pctChange'],
					minChars		: 1,
					mode            : 'local',
					flex			: 1,
					autoFocus		: true,
					independent		: true
				}
			],
			iconCls     : '',
			selModel	: 'rowmodel',
			store   	: 'DocentesDirGrupoStore',
			columns: [
				{
					xtype		: 'customrownumberer'
				},
				{
					text        : 'Docentes',
					dataIndex   : 'nombres',
					flex        : 1,
					filter  	: 'string'
				}
			],
			dockedItems: [
				{
					xtype		: 'toolbarSave'
				},
				{
					xtype 		: 'pagination',
					itemId		: 'pToolbar'
				}
			]
        }
    ]
});
