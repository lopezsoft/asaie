/**
 * Created by LOPEZSOFT on 19/03/2016.
 */
Ext.define('Admin.store.general.CiudStore2',{
    extend  : 'Admin.store.base.StoreUrl',
    storeId : 'CiudStore2',
    pageSize: 1300,
    requires    : [
        'Admin.model.general.CiudModel'
    ],
    model   : 'Admin.model.general.CiudModel',
    proxy   : {
        url : 'General/get_ciudades'
    }
});