Ext.define('Admin.view.estudiantes.NotasEstudiantesView' ,{
     extend : 'Admin.panel.Panel',
     alias 	: 'widget.NotasEstudiantesView',
	 title	: 'Registro de notas',
	 requires: [
		 'Ext.ux.layout.ResponsiveColumn',
		 'Admin.store.estudiantes.NotasEstudiantesStore',
		 'Admin.grid.CustomGrid'
	 ],
	controller 	: 'estudiantes',
	layout		: 'fit',
	items		: [
		{
			xtype 			: 'customform',
			items : [
				{

				}
			],
			dockedItems: [{

			}]
		}
	],
	tbar : [
		'->',
		{
			xtype	: 'customButton',
			iconCls	: 'x-fa fa-eye',
			text	: 'Ver notas',
			handler	: 'verNotas'
		}
	]
});