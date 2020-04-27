/**
 * Created by LOPEZSOFT on 4/12/2015.
 */
Ext.define('Admin.view.docentes.DesempenoView',{
    extend : 'Admin.base.WindowCrud',
    alias  	: 'widget.DesempenoView',

    requires: [
        'Admin.store.general.EscalaNacionalStore',
        'Admin.toolbar.ToolbarSave'
    ],
    controller 	: 'carga',
    title	: 'Desempeños',
    width	: 350,
    height	: 400,
    items 	: [
        {
            xtype 		: 'grid',
            loadmask 	: true,
            autoLoad	: true,
            store		: 'EscalaNacionalStore',
            border		: false,
            columnLines : true,
            plugins		: [
                {
                    ptype : 'gridfilters'
                }
            ],
            columns: [
                {
                    xtype: 'rownumberer'
                },
                {
                    text		: "Desempeño",
                    flex		: 2,
                    sortable	: true,
                    dataIndex	: 'nombre_escala',
                    filter		: 'list'
                }
            ],
            listeners: {
                'selectionchange': function(grid, selected, eOpts) {
                    this.down('#btnSave').setDisabled(!selected.length);
                }
            },
            dockedItems: [
                {
                    xtype: 'toolbarSave'
                },
                {
                    xtype 			: 'pagingtoolbar',
                    store			: 'EscalaNacionalStore',
                    dock			: 'bottom'
                }
            ]
        }
    ]
});
