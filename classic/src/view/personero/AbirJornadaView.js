/**
 * Created by LOPEZSOFT on 14/02/2016.
 */
Ext.define('Admin.view.personero.AbrirJornadaView',{
    extend      : 'Admin.base.WindowCrud',
    alias       : 'widget.AbrirJornadaView',
    title       : 'Mesas de votación',
    controller  : 'personero',
    width       : 700,
    maximized   : true,
    scrollable  : true,
    requires    : [
        'Admin.store.personero.MesasVotacionStore',
        'Admin.view.personero.VotacionView',
        'Admin.view.personero.ClassVotoView',
        'Admin.view.personero.ImagenBrowserView'
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
                    dataIndex   : 'num_mesa',
                    width        : 75,
                    text        : 'Mesa Nº'
                },
                {
                    dataIndex   : 'estado',
                    width       : 100,
                    text        : 'Estado',
                    renderer    : function (val) {
                        switch (val) {
                            case '1' :
                                value   = 'ABIERTA';
                                break;
                            case '2' :
                                value   = 'CERRADA';
                                break;
                            default :
                                value   = 'INDEFINIDO';
                                break;
                        }

                        return '<p> <b>'+value+' </b></p>';
                    }
                },
                {
                    dataIndex   : 'hora_inicio',
                    width        : 75,
                    text        : 'H. Inicio'
                },
                {
                    dataIndex   : 'hora_final',
                    width        : 75,
                    text        : 'H. Cierre'
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
                    xtype       : 'toolbarCrud',
                    defaultType : 'customButton',
                    items   : [
                        {
                            text    : 'Abrir mesa',
                            tooltip : 'Abir mesa electoral',
                            itemId  : 'btnSedes',
                            iconCls : 'x-fa fa-external-link',
                            disabled: true,
                            handler : 'onOpenTableJorn'
                        },
                        {
                            text    : 'Cerrar mesa',
                            itemId  : 'btnCloseJorn',
                            iconCls : 'x-fa fa-sign-out',
                            tooltip : 'Cerrar mesa electoral',
                            disabled: true,
                            handler : 'onCloseTableJorn'
                        },
                        {
                            xtype       : 'closebutton',
                            iconAlign	: 'left'
                        }
                    ]
                }
            ]
        }
    ]
});