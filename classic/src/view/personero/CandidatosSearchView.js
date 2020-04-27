/**
 * Created by LOPEZSOFT on 11/02/2016.
 */
Ext.define('Admin.view.personero.CandidatosSearchView',{
    extend      : 'Admin.base.CustomWindow',
    controller  : 'personero',
    title       : 'Estudiantes',
    requires    : [
        'Admin.store.personero.CandidatosSearchStore'
    ],
    alias       : 'widget.CandidatosSearchView',
    maximized   : true,
    items       : [
        {
            xtype   : 'customgrid',
            store   : 'CandidatosSearchStore',
            iconCls : '',
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
					mode            : 'remote',
					flex			: 1,
					autoFocus		: false,
					independent		: true
				}
            ],
            columns : [
                {
                    xtype       : 'rownumberer'
                },
                {
                    text        : 'Apellidos y Nombres',
                    dataIndex   : 'nombres',
                    flex        : 2,
                    filter      : 'string'
                },
                {
                    text        : 'Grado',
                    dataIndex   : 'grado',
                    flex        : 1,
                    filter      : 'list'
                },
                {
                    text        : 'Grupo',
                    dataIndex   : 'grupo',
                    width       : 60,
                    filter      : 'list'
                },
                {
                    text        : 'Sede',
                    dataIndex   : 'sede',
                    flex        : 1,
                    filter      : 'list'
                }
            ],
            dockedItems : [
                {
                   xtype    : 'toolbarCrud',
                    items   : [
                        {
                            xtype   : 'customButton',
                            text    : 'Improtar...',
                            iconCls : 'x-fa fa-upload',
                            handler : 'onImportEstudent'
                        }
                    ]
                },
                {
                    xtype   : 'pagination',
                    store   : 'CandidatosSearchStore'
                }
            ]
        }
    ]
});
