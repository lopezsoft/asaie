/**
 * Created by LOPEZSOFT on 24/04/2016.
 */
Ext.define('Admin.store.NavigationTreeMonitor', {
    extend: 'Ext.data.TreeStore',

    storeId: 'NavigationTreeMonitor',

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
                    text    : 'Académico',
                    iconCls : 'x-fa fa-briefcase',
                    leaf     : true,
                    itemId  : 'btnAcademicoM'
                },
                {
                    text    : 'Promoción',
                    iconCls : 'x-fa fa-graduation-cap',
                    leaf    : true,
                    itemId  : 'btnPromocionM'
                }
            ]
    }
});
