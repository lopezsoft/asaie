/**
 * Created by LOPEZSOFT2 on 23/09/2016.
 */
Ext.define('Admin.view.admin.DirGruposView',{
    extend  : 'Admin.base.WindowCrud',
    alias   : 'widget.DirGruposView',
    requires: [
        'Admin.store.general.GradosStore',
        'Admin.store.admin.DirGrupoStore'
    ],
    controller      : 'admin',
    showSaveButton  : false,
    initComponent   : function () {
        this.callParent(arguments);
        this.setTitle(AppLang.getSTitleViewGroupDirectors());
    },
    buildWindow: function () {
        var
            me = this.getApp();
        me.onStore('general.GradosStore');
        me.onStore('general.GrupoStore');
        me.onStore('general.SedesStore');
        me.onStore('general.JornadasStore');
        me.onStore('admin.DocentesDirGrupoStore');
        this.winObject = Ext.create('Admin.view.admin.forms.DirGrupoFormView');
    },
    showWindow: function (btn) {
        var me = this.app,
            ts = this;
        Ext.require([
            'Admin.view.admin.forms.DirGrupoFormView'
        ]);

        Ext.onReady(function () {
            if (!ts.getWinObject()) {
                ts.buildWindow();
            }
            ts.winObject.show();
        });
    },
    layout: {
        type: 'hbox',
        align: 'stretch'
    },
    items : [
        {
            xtype   : 'customgrid',
            selModel: 'rowmodel',
            plugins		: [
                {
                    ptype : 'gridfilters'
                },
                {
                    ptype : 'responsive'
                }
            ],
            listeners : {
                'selectionchange': function(grid, selected, eOpts) {
                    var me      = Admin.getApplication(),
                        extra   = [];
                    if (!Ext.isEmpty(selected)) {
                        gdo = selected[0].get('id');
                        extra = {
                            pdbTable: 'dir_grupo',
                            pdbGrado: gdo
                        };
                        me.setParamStore('DirGrupoStore', extra, true);
                    }

                }
            },
            collapseFirst       : true,
            collapseDirection   : 'right',
            collapseMode        : 'undefined',
            collapsible         : true,
            title   : 'GRADOS ACADÉMICOS',
            store   : 'GradosStore',
            margin  : '0 3 0 0',
            width   : 300,
            columns: [
                {
                    xtype: 'customrownumberer'
                },
                {
                    text        : 'Grados',
                    dataIndex   : 'grado',
                    flex        : 1,
                    filter  : 'string'
                }
            ],
            dockedItems: [
                {
                    xtype: 'pagination',
                    itemId: 'pToolbar'
                }
            ]
        },
        {
            xtype   : 'customgrid',
            flex    : 2,
            title   : 'DIRECTORES DE GRUPO',
            store   : 'DirGrupoStore',
            plugins		: [
                {
                    ptype : 'gridfilters'
                },
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
            columns: [
                {
                    xtype: 'customrownumberer'
                },
                {
                    xtype       : 'checkcolumn',
                    text        : 'Activo',
                    dataIndex   : 'estado',
                    width       : 65,
                    headerCheckbox: true,
                    stopSelection: false
                },
                {
                    text        : 'Grado',
                    dataIndex   : 'grado',
                    width       : 150
                },
                {
                    text: 'Grupo',
                    dataIndex: 'grupo',
                    width: 65,
                    filter: 'list'
                },
                {
                    text: 'Año',
                    dataIndex: 'year',
                    width: 55
                },
                {
                    text: 'Docente',
                    dataIndex: 'docente',
                    width: 300,
                    filter: 'string'
                },
                {
                    text: 'Sede',
                    dataIndex: 'sede',
                    width: 300,
                    filter: 'string'
                },
                {
                    text: 'Jornada',
                    dataIndex: 'jornada',
                    width: 180,
                    filter: 'list'
                }
            ],
            dockedItems: [
                {
                    xtype: 'toolbarCrud',
                    items: [
                        {
                            xtype     : 'saveButton',
                            handler   : function (btn) {
                                var
                                    store   = Ext.getStore('DirGrupoStore'),
                                    me      = Admin.getApplication();
                                store.sync({
                                    success : function(batch, o){
                                        me.showResult('Se han guardado los datos');
                                    }
                                });
                            }
                        },
                        {
                            xtype   : 'addButton',
                            tooltip : AppLang.getSTitleViewAddGroupDirectors()
                        }, '-',
                        {
                            xtype: 'deletebutton'
                        }, '-',
                        {
                            xtype: 'closebutton'
                        },'->',
                        {
                            xtype       : 'printButton',
                            disabled 	: false,
                            alias	    : 'widget.btnPrinter1',
                            itemId		: 'printButton'
                        }
                    ]
                },
                {
                    xtype: 'pagination',
                    itemId: 'pToolbar'
                }
            ]
        }
    ]
});
