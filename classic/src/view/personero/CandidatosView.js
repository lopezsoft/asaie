/**
 * Created by LOPEZSOFT on 11/02/2016.
 */
Ext.define('Admin.view.personero.CandidatosView',{
    extend  : 'Admin.base.CustomWindow',
    title   : 'Candidatos',
    controller  : 'personero',
    maximized   : true,
    alias       : 'widget.CandidatosView',
    requires    : [
        'Admin.view.personero.CandidatosSearchView',
        'Admin.view.personero.CandidatosSaveView',
        'Admin.store.personero.CandidatosStore',
        'Admin.combo.CbCandidaturas',
        'Admin.view.personero.CandidatosBlancoSaveView',
        'Admin.base.WinFotoFile'
    ],
    items       : [
        {
            xtype   : 'customgrid',
            plugins		: [
                {
                    ptype: 'rowexpander',
                    selectRowOnExpand : true,
                    rowBodyTpl : new Ext.XTemplate(
                        '<div class="thumb-wrap">',
                            '<div class="thumb">',
                                '<img alt="{nombres}" src="{foto}"/>',
                            '</div>',
                            '<span>{nombres}</span>',
                        '</div>'
                    )
                },
                {
                    ptype : 'gridfilters'
                }
            ],
            iconCls : '',
            store   : 'CandidatosStore',
            columns : [
                {
                    xtype   : 'rownumberer'
                },
                {
                    text        : 'Candidatos',
                    dataIndex   : 'nombres',
                    flex        : 2,
                    filter      : 'string'
                },
                {
                    text        : 'Curso',
                    defaults    : {
                        width   : 65
                    },
                    columns     : [
                        {
                            dataIndex   : 'grado',
                            text        : 'Grado',
                            filter      : 'list',
                            width       : 120
                        },
                        {
                            text        : 'Grupo',
                            dataIndex   : 'grupo',
                            filter      : 'list'
                        }
                    ]
                },
                {
                    dataIndex   : 'foto',
                    text        : 'Fotografía',
                    width       : 142,
                    renderer    : function (val) {
                        return '<img alt="{nombres}" height="128" width="128" src="'+val+'"/>';
                    }
                },
                {
                    xtype   :'actioncolumn',
                    width   :50,
                    items   : [
                        {
                            iconCls: 'x-fa fa-upload',
                            tooltip: 'Editar foto',
                            handler: function(grid, rowIndex, colIndex) {
                                var rec = grid.getStore().getAt(rowIndex),
                                    me  = Admin.getApplication();

                                if (rec.get('tipo') == 1){
                                    extra   = {
                                        pdbTable    : 'tp_voto_blanco',
                                        pdbType     : 1,
                                        pdbId       : rec.get('id')
                                    };
                                }else {
                                    extra   = {
                                        pdbTable    : 'tp_candidatos',
                                        pdbType     : 2,
                                        pdbId       : rec.get('id')
                                    };
                                }

                                win             = me.getWindow('Editar foto','Admin.base.WinFotoFile');
                                win.urlPhoto 	= me.getUrlBase()+'c_personero/insert_foto_candidato';
                                win.extParam	= extra;
                                win.store       = 'CandidatosStore';
                                win.show();
                            }
                        }
                    ]
                },
                {
                    dataIndex   : 'numero',
                    text        : 'Número',
                    width       : 90
                },
                {
                    dataIndex   : 'estados',
                    text        : 'Candidatura',
                    width       : 120
                },
                {
                    dataIndex   : 'año',
                    text        : 'Año',
                    width       : 60
                }

            ],
            dockedItems : [
                {
                    xtype   : 'pagination',
                    store   : 'CandidatosStore'
                },
                {
                    xtype   : 'toolbarCrud'
                }
            ]
        }
    ]
});