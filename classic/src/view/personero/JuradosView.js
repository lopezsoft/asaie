/**
 * Created by LOPEZSOFT on 11/02/2016.
 */
Ext.define('Admin.view.personero.JuradosView',{
    extend      : 'Admin.base.WindowCrud',
    title       : 'Lista de jurados',
    controller  : 'personero',
    alias       : 'widget.JuradosView',
    requires    : [
        'Admin.view.personero.JuradosSaveView',
        'Admin.store.personero.JuradosStore'
    ],
    maximized   : true,
    items       : [
        {
            xtype   : 'customgrid',
            iconCls : '',
            store   : 'JuradosStore',
            columns : [
                {
                    xtype   : 'rownumberer'
                },
                {
                    dataIndex   : 'id_mesa',
                    text        : 'Mesa',
                    width       : 60
                },
                {
                    dataIndex   : 'nom_jurado',
                    text        : 'Nombre del jurado',
                    flex        : 2
                },
                {
                    dataIndex   : 'cargo',
                    text        : 'Cargo',
                    flex        : 1
                }
            ],
            dockedItems : [
                {
                    xtype   : 'pagination',
                    store   : 'JuradosStore'
                },
                {
                    xtype   : 'toolbarCrud'
                }
            ]
        }
    ]
});