/**
 * Created by LOPEZSOFT on 24/04/2016.
 */
Ext.define('Admin.store.NavigationTreeConvivencia', {
    extend: 'Ext.data.TreeStore',

    storeId: 'NavigationTreeConvivencia',

    fields: [
        {
            name: 'text'
        }
    ],
    root:
    {
        expanded: true,
        children:
            [
                {
                    text    : 'Psicoorientación',
                    iconCls : 'x-fa fa-sitemap',
                    leaf    : true,
                    itemId  : 'btnInicio'
                },
                {
                    text    : 'Coord académica',
                    iconCls : 'x-fa fa-briefcase',
                    leaf     : true,
                    itemId  : 'btnAcademica'
                },
                {
                    text    : 'Coor convivencia',
                    iconCls : 'x-fa fa-comments',
                    leaf    : true,
                    itemId  : 'btnConvivencia'
                },
                {
                    text    : 'Reportes',
                    iconCls : 'x-fa fa-print',
                    leaf    : true,
                    itemId  : 'btnReportes'
                },
                {
                    text    : 'Configuraciones',
                    iconCls : 'x-fa fa-wrench',
                    leaf    : true,
                    itemId  : 'btnConfiguraciones'
                }
            ]
    }
});
