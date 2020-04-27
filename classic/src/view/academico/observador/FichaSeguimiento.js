Ext.define('Admin.view.academico.FichaSeguimiento',{
    extend      : 'Admin.forms.CustomForm',
    controller  : 'academico',
    alias       : 'widget.fichaseguimiento',
    initComponent: function () {
        let me      = this,
            zstore  = undefined;
        zstore      = Ext.create('Admin.store.base.StoreUrl',{
            extend      : 'Admin.store.docentes.EstudiantesStore',
            model       : 'Admin.model.docentes.EstudiantesModel',
            pageSize    : 0,
            proxy   : {
                url : 'observer/getStudents'
            },
            autoLoad    : true
        });

        me.items = [
            {
                xtype   : 'customgrid',
                store   : zstore,
                plugins		: [
                    {
                        ptype: 'rowexpander',
                        rowBodyTpl : new Ext.XTemplate(
                            '<p><b>Apellidos y Nombres:</b> {nombres}</p>'
                        )
                    },
                    {
                        ptype : 'gridfilters'
                    },
                    {
                        ptype			: 'gridSearch',
                        readonlyIndexes	: ['note'],
                        disableIndexes	: ['pctChange'],
                        mode            : 'local',
                        flex			: 1,
                        autoFocus		: true,
                        independent		: true
                    }
                ],
                columns : [
                    {
                        xtype       : 'customrownumberer'
                    },
                    {
                        text        : 'Apellidos y Nombres',
                        dataIndex   : 'nombres',
                        width       : 320,
                        filter      : 'string'
                    },
                    {
                        text        : 'Grado',
                        dataIndex   : 'grado',
                        width       : 200,
                        filter      : 'list'
                    },
                    {
                        text        : 'Grupo',
                        dataIndex   : 'id_group',
                        width       : 60,
                        filter      : 'list'
                    },
                    {
                        text        : 'Estado',
                        dataIndex   : 'estado_mat',
                        width       : 200,
                        filter      : 'list'
                    },
                    {
                        text        : 'Jornada',
                        dataIndex   : 'jornada',
                        width       : 120,
                        filter      : 'list'
                    },
                    {
                        text        : 'Sede',
                        dataIndex   : 'sede',
                        width       : 320,
                        filter      : 'list'
                    }
                ],
                dockedItems : [
                    {
                       xtype    : 'toolbarCrud',
                        items   : [
                            '->',
                            {
                                xtype		: 'printButton'
                            },
                            '-',
                            {
                                xtype		: 'closebutton'
                            }
                        ]
                    },
                    {
                        xtype   : 'pagination'
                    }
                ]
            }
        ];
        me.callParent(arguments);
        me.setTitle('Ficha de seguimiento'+' - '+ Global.getYear());
    },
    itemId          : 'fichaseguimiento',
    showSaveButton  : false,
   
});
