/**
 * Created by LOPEZSOFT on 6/02/2016.
 */
Ext.define('Admin.view.personero.MesasVotacionView',{
    extend      : 'Admin.base.WindowCrud',
    alias       : 'widget.MesasVotacionView',
    title       : 'Mesas de votación',
    controller  : 'personero',
    width       : 700,
    maximized   : true,
    requires    : [
        'Admin.store.personero.MesasVotacionStore',
        'Admin.view.personero.MesasVotacionSaveView',
        'Admin.view.personero.SedesAsignadasView'
    ],
    items   : [
        {
            xtype   : 'customgrid',
            iconCls : '',
            store   : 'MesasVotacionStore',
            columns : [
                {
                    xtype   : 'rownumberer'
                },
                {
                    dataIndex   : 'nom_mesa',
                    flex        : 2,
                    text        : 'Nombre de la mesa'
                },
                {
                    dataIndex   : 'ubicacion',
                    flex        : 1,
                    text        : 'Ubicación geográfica o dirección'
                },
                {
                    dataIndex   : 'num_mesa',
                    width        : 75,
                    text        : 'Mesa Nº'
                },
                {
                    dataIndex   : 'estado',
                    width       : 70,
                    text        : 'Estado'
                },
                {
                    dataIndex   : 'año',
                    width        : 55,
                    text        : 'Año'
                }
            ],
            dockedItems : [
                {
                    xtype   : 'pagination',
                    store   : 'MesasVotacionStore'
                },
                {
                    xtype   : 'toolbarCrud'
                },
                {
                    xtype       : 'toolbarCrud',
                    itemId      : 'ToolCrudSede',
                    defaultType : 'customButton',
                    items   : [
                        {
                            text    : 'Sedes asignadas',
                            itemId  : 'btnSedes',
                            iconCls : 'x-fa fa-home',
                            disabled: true,
                            handler : 'onSedesCreate'
                        },'-',
                        {
                            text    : 'Jurados',
                            itemId  : 'btnJurados',
                            iconCls : 'x-fa fa-users',
                            disabled: true,
                            handler : 'onJuradosCreate'
                        }
                    ]
                }
            ]
        }
    ]
});