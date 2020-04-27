/**
 * Created by LOPEZSOFT on 11/02/2016.
 */
Ext.define('Admin.view.promocion.AntiguosView',{
    extend      : 'Admin.base.CustomWindow',
    controller  : 'Promocion',
    title       : 'Estudiantes',
    requires    : [
        'Admin.store.promocion.ListaMatriculaStore',
        'Admin.store.general.MatricularAntiguosStore'
    ],
    alias       : 'widget.AntiguosView',
    maximized   : true,
    notGrupo    : [],
    items       : [
        {
            xtype   : 'customform',
            layout: {
                type: 'hbox',
                align: 'stretch'
            },
            items   : [
                {
                    xtype   : 'customform',
                    flex    : 3,
                    items   : [
                        {
                            xtype   : 'fieldset',
                            title   : 'Búsqueda de estudiantes antiguos a matricular',
                            defaults : {
                                labelWidth	: 60
                            },
                            flex    : 2,
                            items   : [
                                {
                                    xtype       : 'CbSedes'
                                },
                                {
                                    xtype   : 'CbGrados',
                                    bind    : {
                                        visible : '{comboSedes.value}'
                                    },
                                    listeners   : {
                                        select : function(cb, record , eOpts ){
                                            var
                                                win = cb.up('window'),
                                                gdo = record.get('id'),
                                                gb  = SME.ConfigApp;
                                            if (gdo == 22 || gdo == 23){
                                                win.down('#yr').setValue(gb.year);
                                            }else {
                                                win.down('#yr').setValue(gb.year - 1);
                                            }
                                        }
                                    }
                                },
                                {
                                    xtype   : 'CbGrupo',
                                    bind    : {
                                        visible : '{comboGrados.value}'
                                    }
                                },
                                {
                                    xtype   : 'CbJornadas',
                                    bind    : {
                                        visible : '{comboGrupo.value}'
                                    }
                                },
                                {
                                    xtype       : 'customnumberfield',
                                    itemId      : 'yr',
                                    fieldLabel  : 'Año',
                                    disabled    : true,
                                    value       : Global.getYear() - 1
                                },
                                {
                                    xtype       : 'customButton',
                                    iconCls     : 'x-fa fa-search',
                                    text        : 'Búscar',
                                    bind    : {
                                        visible : '{comboJornadas.value}'
                                    },
                                    handler     : function (btn) {
                                        var
                                            win     = btn.up('window'),
                                            me      = Admin.getApplication(),
                                            store   = Ext.getStore('ListaMatriculaStore'),
                                            cUrl    = globales.SetUrls.UrlBase+'General/get_select_acta_promocion',
                                            gdo     = win.down('#comboGrados').selection.get('id');
                                        if (gdo ==22 || gdo == 23){
                                            extra   = {
                                                pdbCodGrado : win.down('#comboGrados').selection.get('id'),
                                                pdbGrupo    : win.down('#comboGrupo').selection.get('grupo'),
                                                pdbSede     : win.down('#comboSedes').selection.get('ID'),
                                                pdbJorn     : win.down('#comboJornadas').selection.get('cod_jorn'),
                                                pdbYear     : Global.getYear(),
                                                pdbTable    : 'matriculas'
                                            };
                                        }else{
                                            extra   = {
                                                pdbCodGrado : win.down('#comboGrados').selection.get('id'),
                                                pdbGrupo    : win.down('#comboGrupo').selection.get('grupo'),
                                                pdbSede     : win.down('#comboSedes').selection.get('ID'),
                                                pdbJorn     : win.down('#comboJornadas').selection.get('cod_jorn'),
                                                pdbYear     : Global.getYear() - 1,
                                                pdbTable    : 'matriculas'
                                            };
                                        }
                                        me.setParamStore('ListaMatriculaStore',extra,true);
                                        Ext.Ajax.request({
                                            url: cUrl,
                                            params : extra,
                                            success: function(response){
                                               result 	= Ext.decode(response.responseText);
                                                win.notGrupo = result.records;
                                            },
                                            failure: function (response) {
                                                me.onAler('No se pueden cargar los datos');
                                            }

                                        });
                                    }
                                }
                            ]
                        },
                        {
                            xtype   : 'fieldset',
                            itemId  : 'Mat',
                            title   : 'Matricular estudiantes',
                            hidden  : true,
                            defaults : {
                                labelWidth	: 60
                            },
                            flex    : 2,
                            items   : [
                                {
                                    xtype       : 'CbSedes',
                                    reference   : 'cbSedes',
                                    itemId      : 'cbSedes'
                                },
                                {
                                    xtype   : 'CbGrupo',
                                    reference   : 'cbGrupos',
                                    bind    : {
                                        visible : '{cbSedes.value}'
                                    },
                                    itemId      : 'cbGrupos'
                                },
                                {
                                    xtype   : 'CbJornadas',
                                    reference   : 'cbJornadas',
                                    bind    : {
                                        visible : '{cbGrupos.value}'
                                    },
                                    itemId      : 'cbJornadas'
                                },
                                {
                                    xtype       : 'customnumberfield',
                                    fieldLabel  : 'Año',
                                    disabled    : true,
                                    value       : Global.getYear()
                                },
                                {
                                    xtype       : 'customButton',
                                    iconCls     : 'x-fa fa-check',
                                    text        : 'Matricular',
                                    bind    : {
                                        visible : '{cbJornadas.value}'
                                    },
                                    handler     : 'onMatricularAntiguos'
                                }
                            ]
                        }
                    ],
                    dockedItems : [
                        {}
                    ]
                },
                {
                    xtype   : 'customgrid',
                    store   : 'ListaMatriculaStore',
                    margin  : '0 1 0 0',
                    flex    : 4,
                    title   : 'CONSULTA',
                    autoLoad    : false,
                    plugins: [
                        {
                            ptype: 'rowexpander',
                            rowBodyTpl: new Ext.XTemplate(
                                '<p><b>Apellidos y Nombres:</b> {nombres}</p>'
                            )
                        }
                    ],
                    listeners : {
                        'selectionchange': function(grid, selected, eOpts) {
                            var me = this;

                            if (me.up('window').down('#Mat')) {
                                me.up('window').down('#Mat').setHidden(!selected.length);
                            }
                        }
                    },
                    columns: [
                        {
                            xtype: 'rownumberer'
                        },
                        {
                            text: 'Apellidos y Nombres',
                            dataIndex: 'nombres',
                            width: 290
                        },
                        {
                            text: 'Grado',
                            dataIndex: 'grado',
                            width: 100
                        },
                        {
                            text: 'Grupo',
                            dataIndex: 'grupo',
                            width: 60
                        },
                        {
                            text: 'Jornada',
                            dataIndex: 'jornada',
                            width: 120
                        },
                        {
                            text: 'Sede',
                            dataIndex: 'sede',
                            width: 190
                        }
                    ],
                    dockedItems: [
                        {
                            xtype: 'toolbarCrud',
                            items: [
                                '->',
                                '-',
                                {
                                    xtype: 'closebutton',
                                    iconAlign: 'left'
                                }
                            ]
                        },
                        {
                            xtype: 'pagination'
                        }
                    ]
                }
            ],
            dockedItems : [
                {}
            ]
        }
    ]
});
