/**
 * Created by LOPEZSOFT2 on 23/09/2016.
 */
Ext.define('Admin.store.admin.EstablecimientoStore',{
    extend  : 'Admin.store.base.StoreApi',
    storeId : 'EstablecimientoStore',
    proxy: {
        extraParams : {
            pdbTable : 'establecimiento'
        },
        api: {
            create  : 'General/insert_data',
            read    : 'General/get_select_all',
            update  : 'General/update_data',
            destroy : 'General/delete_data'
        }
    },
    requires: [
        'Admin.model.admin.EstablecimientoModel'
    ],
    model   : 'Admin.model.admin.EstablecimientoModel'
});