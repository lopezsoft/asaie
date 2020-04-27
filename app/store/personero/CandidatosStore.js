/**
 * Created by LOPEZSOFT on 11/02/2016.
 */
Ext.define('Admin.store.personero.CandidatosStore',{
    extend  : 'Admin.store.base.StoreApi',
    storeId : 'CandidatosStore',
    requires: [
        'Admin.model.personero.CandidatosModel'
    ],
    model   : 'Admin.model.personero.CandidatosModel',
    proxy   : {
        extraParams : {
            pdbTable    : 'tp_candidatos'
        },
        api : {
            create  : 'c_personero/insert_candidatos',
            read    : 'c_personero/get_select_candidatos',
            update  : 'c_personero/get_update_candidatos',
            destroy : 'General/delete_data'
        }
    }
});