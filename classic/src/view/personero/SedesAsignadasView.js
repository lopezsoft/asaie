/**
 * Created by LOPEZSOFT on 8/02/2016.
 */
Ext.define('Admin.view.personero.SedesAsignadasView',{
    extend  :'Admin.base.WindowCrud',
    title   : 'Sedes mesas de votación',
    alias   : 'widget.SedesAsignadasView',
    controller  : 'personero',
    requires    : [
        'Admin.store.personero.MesasSedesStore',
        'Admin.store.general.SedesStore',
        'Admin.view.personero.SedesAsignadasSaveView',
        'Admin.view.personero.JuradosView'
    ],
    items   : [
        {
            xtype   : 'customgrid',
            iconCls : '',
            store   : 'MesasSedesStore',
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
                    dataIndex   : 'sede',
                    text        : 'Sede',
                    flex        : 1
                },
                {
                    dataIndex   : 'grados_votantes',
                    text        : 'Grados votantes en la sede',
                    width       : 195,
                    renderer    : function (val) {
                        if (val == 1) {
                            value   = 'Todos los grados';
                            this.down('#btnGrados').setDisabled(true);
                        }else{
                            value   = 'Selección';
                            this.down('#btnGrados').setDisabled(false);
                        }

                        return '<span style="color:#7e55ef;"> <b>'+value+' </b></span>';
                    }
                }
            ],
            dockedItems : [
                {
                    xtype   : 'pagination'
                },
                {
                    xtype   : 'customButton',
                    text    : 'Grados sede',
                    itemId  : 'btnGrados',
                    handler : 'onCreateGradosMesa',
                    disabled: true
                },
                {
                    xtype   : 'toolbarCrud'
                }
            ]
        }
    ]
});