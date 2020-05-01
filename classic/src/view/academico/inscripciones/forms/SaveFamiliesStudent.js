Ext.define('Admin.view.academico.inscripciones.forms.SaveFamiliesStudent',{
    extend		: 'Admin.base.SaveWindow',
    alias 		: 'widget.savefamiliesstudent',
	controller	: 'academico',
	initComponent: function () {
		this.callParent(arguments);
		this.setTitle(AppLang.getSTitleNewEdit()+' '+AppLang.getSTitleViewFamilies());
	},
	store			: 'FamiliesStudentStore',
	maxHeight		: 260,
    items : [
		{
			xtype	: 'customform',
			store	: 'FamiliesStudentStore',
			items	: [
				{
					xtype       : 'cbfamilies'
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
		}
	]
});
