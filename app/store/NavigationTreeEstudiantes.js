/**
 * Created by LOPEZSOFT on 23/04/2016.
 */
Ext.define('Admin.store.NavigationTreeEstudiantes', {
    extend: 'Ext.data.TreeStore',
    storeId: 'NavigationTreeEstudiantes',
    fields: [
        {
            name: 'text'
        }
    ],
    root: {
        expanded: true,
        children:
            [
                {
                    text        : 'Dashboard',
                    iconCls     : 'x-fa fa-desktop',
                    viewType    : 'admindashboard',
                    routeId     : 'dashboard', // routeId defaults to viewType
                    leaf        : true
                },
                {
                    text    : 'Notas académicas',
                    iconCls : 'x-fa fa-briefcase',
                    leaf    : true,
                    itemId  : 'btnCarga',
                    reference : 'btnCarga'
                },
               /* {
                    text: 'Logros e indicadores',
                    iconCls: 'x-fa fa-chevron-right',
                    leaf: true,
                    itemId  : 'btnLogros'
                },
                {
                    text: 'Sugerencias',
                    iconCls: 'x-fa fa-chevron-right',
                    leaf: true,
                    itemId  : 'btnSugerencias'
                },*/
                {
                    text    : 'Plan de mejoramiento',
                    iconCls : 'x-fa fa-thumbs-up',
                    leaf    : true,
                    itemId  : 'btnMejoramiento'
                },
                {
                    text    : 'Seguimiento académico',
                    iconCls : 'x-fa fa-eye',
                    leaf    : true,
                    itemId  : 'btnSeguimiento'
                },
                {
                    text    : 'Reportes',
                    iconCls : 'x-fa fa-newspaper-o nav-tree-change-new',
                    cls     : 'parpadea chat-button',
                    leaf    : true,
                    itemId  : 'btnReportes'
                },
                {
                    text    : 'Actividades académicas',
                    iconCls : 'x-fa fa-spinner',
                    leaf    : true,
                    itemId  : 'btnActividades'
                }
            ]
    }
});
