/**
 * Created by LOPEZSOFT on 19/03/2016.
 */
Ext.define('Admin.store.general.CiudStore',{
    extend  : 'Admin.store.base.StoreUrl',
    storeId : 'CiudStore',
    pageSize: 1300,
    requires    : [
        'Admin.model.general.CiudModel'
    ],
    model   : 'Admin.model.general.CiudModel',
    proxy   : {
        url : 'General/get_ciudades'
    }
});
