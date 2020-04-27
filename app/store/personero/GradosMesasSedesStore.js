/**
 * Created by LOPEZSOFT on 8/02/2016.
 */
Ext.define('Admin.store.personero.GradosMesasSedesStore',{
    extend  : 'Admin.store.base.StoreApi',
    storeId : 'GradosMesasSedesStore',
    requires: [
        'Admin.model.personero.GradosMesasSedesModel'
    ],
    model   : 'Admin.model.personero.GradosMesasSedesModel',
    proxy   : {
        extraParams : {
          pdbTable  : 'tp_grados_sedes_mesa'
        },
        api : {
            create  : 'c_personero/insert_grados_sedes_mesa',
            read    : 'c_personero/get_select_grados_sedes_mesa',
            update  : 'General/update_data',
            destroy : 'General/delete_data'
        }
    }
});