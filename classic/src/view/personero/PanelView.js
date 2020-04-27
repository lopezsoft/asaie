/**
 * Created by LOPEZSOFT on 5/02/2016.
 */
Ext.define('Admin.view.personero.PanelView',{
    extend  : 'Admin.base.WindowCrud',
    title   : 'Panel de control',
    controller  : 'personero',
    alias       : 'widget.PanelView',
    maximized   : true,
    requires    : [
        'Admin.store.personero.PanelControlStore',
        'Admin.view.personero.MesasVotacionView'
    ],
    items   : [
        {
            xtype   : 'customgrid',
            store   : 'PanelControlStore',
            iconCls : '',
            columns: [
                {
                    xtype: 'rownumberer'
                },
                {
                    text        : 'Votos por mesa',
                    dataIndex   : 'voto_x_mesa',
                    width       : 120
                },
                {
                    text        : 'Discriminar por sede',
                    dataIndex   : 'discriminar_x_sede',
                    width       : 160,
                    renderer 	:  function(val) {
                        if (val == 1) {
                            value   = '<span style="color:#7e55ef;"> <b> Si </b></span>';
                        }else{
                            value   = '<span style="color:#7e55ef;"> <b> No </b></span>';
                        }
                        return value;
                    }
                },
                {
                    text        : 'Tipo de base de datos',
                    dataIndex   : 'base_de_datos',
                    width       : 170,
                    renderer 	:  function(val) {
                        if (val == 1) {
                            value   = '<span style="color:#7e55ef;"> <b> Local, sistema de notas </b></span>';
                        }else{
                            value   = '<span style="color:#7e55ef;"> <b> Importada </b></span>';
                        }
                        return value;
                    }
                },
                {
                    text        : 'Intentos posibles para voto nulo',
                    dataIndex   : 'int_voto_nulo',
                    width       : 220
                },
                {
                    text        : 'Fecha de inicio de la jornada',
                    dataIndex   : 'inicio_jorn',
                    width       : 200
                }
            ],
            dockedItems : [
                {
                    xtype   : 'toolbarCrud',
                    items   : [
                        {
                            xtype   : 'addButton'
                        },
                        {
                            xtype   : 'editButton'
                        },
                        {
                            xtype   : 'closebutton'
                        }
                    ]
                },
                {
                    xtype   : 'pagination',
                    store   : 'PanelControlStore'
                }
            ]
        }
    ]
});