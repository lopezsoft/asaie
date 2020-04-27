/**
 * Created by LOPEZSOFT on 8/02/2016.
 */
Ext.define('Admin.store.personero.MesasSedesStore',{
    extend  : 'Admin.store.base.StoreApi',
    storeId : 'MesasSedesStore',
    requires: [
        'Admin.model.personero.MesasSedesModel'
    ],
    model   : 'Admin.model.personero.MesasSedesModel',
    proxy   : {
        api : {
            create  : 'c_personero/insert_sedes_mesa',
            read    : 'c_personero/get_select_sedes_mesa',
            update  : 'c_personero/get_update_sedes_mesa',
            destroy : 'General/delete_data'
        }
    }
});