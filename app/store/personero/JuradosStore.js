/**
 * Created by LOPEZSOFT on 11/02/2016.
 */
Ext.define('Admin.store.personero.JuradosStore',{
    extend  : 'Admin.store.base.StoreApi',
    storeId : 'JuradosStore',
    requires: [
        'Admin.model.personero.JuradosModel'
    ],
    model   : 'Admin.model.personero.JuradosModel',
    proxy   : {
        extraParams : {
            pdbTable    : 'tp_jurados'
        },
        api : {
            create  : 'General/insert_data',
            read    : 'c_personero/get_select_jurados',
            update  : 'General/update_data',
            destroy : 'General/delete_data'
        }
    }
});