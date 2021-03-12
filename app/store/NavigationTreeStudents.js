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
                    text        : 'Informes',
                    iconCls     : 'x-fa fa-newspaper-o nav-tree-change-new',
                    viewType    : 'studentreportscontainer',
                    routeId     : 'reports',
                    leaf        : true
                },
                // {
                //     text        : 'Seguimiento académico',
                //     iconCls     : 'x-fa fa-eye',
                //     leaf        : true
                // },
                {
                    text        : 'Actividades académicas',
                    iconCls     : 'x-fa fa-spinner',
                    routeId     : 'academicactivities',
                    viewType    : 'academicactivitiesstudents',
                    leaf        : true
                },
				{
                    text    : 'Personero NEW',
                    iconCls : 'x-fa fa-group',
                    leaf    : true,
					viewType: "representativestudentscontainerview",
                    routeId : 'representative'
                },
            ]
    }
});
