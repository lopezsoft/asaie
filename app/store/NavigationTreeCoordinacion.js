/**
 * Created by LOPEZSOFT on 24/04/2016.
 */
Ext.define('Admin.store.NavigationTreeCoordinacion', {
    extend: 'Ext.data.TreeStore',

    storeId: 'NavigationTreeCoordinacion',

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
                    text    : 'Administrativo',
                    iconCls : 'x-fa fa-home',
                    leaf    : true,
                    itemId  : 'btnInicio'
                },
                {
                    text    : 'Académico',
                    iconCls : 'x-fa fa-briefcase',
                    leaf     : true,
                    itemId  : 'btnAcademico'
                },
                {
                    text    : 'Promoción',
                    iconCls : 'x-fa fa-graduation-cap',
                    leaf    : true,
                    itemId  : 'btnPromocion'
                },
                {
                    text    : 'Personero',
                    iconCls : 'x-fa fa-group',
                    leaf    : true,
                    itemId  : 'btnPersonero'
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
