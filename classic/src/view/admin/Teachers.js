Ext.define('Admin.view.admin.Teachers',{
    extend  : 'Admin.forms.CustomForm',
    alias   : 'widget.teachers',
    showSaveButton  : false,
    controller      : 'admin',
	initComponent : function(){
        var
			me	= Admin.getApplication();
        me.onStore('general.DocumentosStore');
        me.onStore('admin.ADocentesStore');
		me.onStore('general.CiudStore');
		me.onStore('general.CiudStore4');
		me.onStore('general.CiudStore2');
		me.onStore('general.CiudStore3');
		me.onStore('general.SexoStore');
		me.onStore('general.RHStore');
		me.onStore('general.NivelEnsStore');
		me.onStore('general.AreaEnsStore');
		me.onStore('general.EscalafonStore');
		me.onStore('general.AreaTecnicaStore');
        me.onStore('general.NivelEduStore');
        me.onStore('general.CountryStore');
        this.setTitle(AppLang.getSTitleViewTeachers	());
		this.callParent(arguments);
    },
    modalView   : 'Admin.view.admin.forms.SaveTeacher',
    items   : [{
        xtype       : 'customgrid',
		plugins		: [
			{
				ptype			: 'gridSearch',
				readonlyIndexes	: ['note'],
				disableIndexes	: ['pctChange'],
				mode            : 'local',
				flex			: 1,
				autoFocus		: false,
				independent		: true
			}
		],
        store       : 'ADocentesStore',
        columns     : [
            {
                xtype   : 'customrownumberer',
                width   : 50
            },
            {
                text        : 'Apellidos y nombres',
                dataIndex   : 'docente',
                width       : 300,
                filter      : 'string'
            },
            {
                text        : 'Documento',
                dataIndex   : 'documento',
                width       : 120,
                filter      : 'string'
            },
            {
                text        : 'Dirección',
                dataIndex   : 'direccion',
                width       : 250
            },
            {
                text        : 'Sexo',
                dataIndex   : 'sexo',
                filter      : 'list',
                width       : 65
            },
            {
                text        : 'Fecha de nacimiento',
                dataIndex   : 'fecha_nacimiento',
                width       : 180
            },
            {
                text        : 'Edad',
                dataIndex   : 'edad',
                width       : 65
            },
            {
                xtype       : 'checkcolumn',
                text        : 'Activo',
                dataIndex   : 'estado',
                width       : 80,
                disabled    : true
            }
        ],
        dockedItems : [
            {
                xtype   : 'toolbarCrud',
                items   : [
					'->',
					{
						xtype       : 'btnWebcam',
						iconCls		: 'far fa-images',
						tooltip		: 'Imaganes del docente',
						handler		: 'onViewWebcam'
					},'-',
                    {
                        xtype       : 'customButton',
                        tooltip     : AppLang.getSToolTipDigitalDocuments(),
                        itemId      : 'btnDocDig',
                        disabled  	: true,
                        iconCls     : 'x-fa fa-book',
                        handler     : function (btn) {
                            var me  = Admin.getApplication(),
                                rec = btn.up('form').down('grid').getSelection()[0];
                                me.onStore('docs.ImageBrowserStore');
                            var win = Ext.create({
                                xtype           : 'FilesView',
                                pathReadFile    : 'c_docentes/read_files_dig',
                                pathUploadFile  : 'c_docentes/upload_files_dig',
                                textButtonApply : AppLang.getSButtonAcept(),
                                extraParams     : {
                                    pdbDocumento: rec.get('documento')
                                }
                            }).show();
                        }
                    },'-',
                    {
                        xtype   : 'addButton'
                    },'-',
                    {
                        xtype   : 'editButton'
                    },'-',
                    {
                        xtype   : 'deletebutton'
                    },'-',
                    {
                        xtype   : 'closebutton'
                    }
                ]
            },
            {
                xtype 		: 'pagination',
                itemId      : 'pToolbar',
                showPrint   : false
            }
        ]
    }]
});
