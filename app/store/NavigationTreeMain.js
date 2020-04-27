/**
 * Created by LOPEZSOFT on 24/04/2016.
 */
Ext.define('Admin.store.NavigationTreeMain', {
    extend: 'Ext.data.TreeStore',
    storeId: 'NavigationTreeMain',
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
                    text        : 'Dashboard',
                    iconCls     : 'x-fa fa-desktop',
                    viewType    : 'admindashboard',
                    routeId     : 'dashboard', // routeId defaults to viewType
                    leaf        : true
                },
                {
                    text    : 'Administrativo',
                    iconCls : 'x-fa fa-home',
                    leaf    : true,
                    viewType: 'admincontainer',
                    routeId : 'administrative'
                },
                {
                    text    : 'Académico',
                    iconCls : 'x-fa fa-briefcase',
                    leaf    : true,
                    viewType: 'academicContainerView',
                    routeId : 'academico'
                },
                {
                    text    : 'Promoción',
                    iconCls : 'x-fa fa-graduation-cap',
                    leaf    : true,
                    routeId : 'promocion'
                },
                // {
                //     text    : 'Perfil',
                //     iconCls : 'x-fa fa-user',
                //     routeId : 'profile',
                //     leaf    : true
                // },
                // {
                //     text    : 'Biblioteca',
                //     iconCls : 'x-fa fa-book',
                //     leaf    : true,
                //     routeId : 'biblioteca'
                // },
                // {
                //     text    : 'Personero',
                //     iconCls : 'x-fa fa-group',
                //     leaf    : true,
                //     routeId : 'personero'
                // },
                // {
                //     text    : 'Financiero',
                //     iconCls : 'x-fa fa-money',
                //     leaf    : true,
                //     routeId : 'finaciero'
                // },
                {
                    text    : 'Configuraciones',
                    iconCls : 'x-fa fa-wrench',
                    leaf    : true,
                    viewType: 'configPanel',
                    routeId : 'configuraciones'
                }
                // {
                //     text    : 'Simulacros',
                //     iconCls : 'x-fa fa-flask',
                //     leaf    : true,
                //     routeId : 'simulacros'
                // }
            ]
    }
});
