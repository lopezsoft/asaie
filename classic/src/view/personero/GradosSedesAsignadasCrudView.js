/**
 * Created by LOPEZSOFT on 8/02/2016.
 */
Ext.define('Admin.view.personero.GradosSedesAsignadasCrudView',{
    extend  :'Admin.base.WindowCrud',
    title   : 'Grados mesa de votación',
    alias   : 'widget.GradosSedesAsignadasCrudView',
    controller  : 'personero',
    requires    : [
        'Admin.store.personero.GradosMesasSedesStore',
        'Admin.view.personero.GradosSedesAsignadasView',
        'Admin.combo.CbGrupo',
        'Admin.combo.CbGrados'
    ],
    items   : [
        {
            xtype   : 'customgrid',
            iconCls : '',
            store   : 'GradosMesasSedesStore',
            columns : [
                {
                    xtype   : 'rownumberer'
                },
                {
                    dataIndex   : 'grado',
                    text        : 'Grado',
                    flex        : 1
                },
                {
                    dataIndex   : 'grupo',
                    text        : 'Grupo',
                    width       : 60
                },
                {
                    dataIndex   : 'sede',
                    text        : 'Sede',
                    flex        : 1
                }
            ],
            dockedItems : [
                {
                    xtype   : 'pagination'
                },
                {
                    xtype   : 'toolbarCrud'
                }
            ]
        }
    ]
});