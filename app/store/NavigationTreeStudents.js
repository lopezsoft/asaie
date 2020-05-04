Ext.define('Admin.store.NavigationTreeStudents', {
    extend  : 'Ext.data.TreeStore',
    storeId : 'NavigationTreeStudents',
    fields  : [
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
                    viewType    : 'studentsdashboard',
                    routeId     : 'dashboard', // routeId defaults to viewType
                    leaf        : true
                },
                {
                    text        : 'Notas académicas',
                    iconCls     : 'x-fa fa-briefcase',
                    leaf        : true,
                    routeId     : 'studentnotes',
                    viewType    : 'studentnotes'
                },
                {
                    text        : 'Nivelaciones',
                    iconCls     : 'x-fa fa-thumbs-up',
                    leaf        : true
                },
                {
                    text        : 'Seguimiento académico',
                    iconCls     : 'x-fa fa-eye',
                    leaf        : true
                },
                {
                    text        : 'Actividades académicas',
                    iconCls     : 'x-fa fa-spinner',
                    leaf        : true
                }
            ]
    }
});
