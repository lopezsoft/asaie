/**
 * Created by LOPEZSOFT on 11/02/2016.
 */
Ext.define('Admin.store.personero.CandidaturaStore',{
    extend  : 'Admin.store.base.StoreApi',
    storeId : 'CandidaturaStore',
    requires: [
        'Admin.model.personero.CandidaturaModel'
    ],
    model   : 'Admin.model.personero.CandidaturaModel',
    proxy   : {
        extraParams : {
            pdbTable    : 'tp_candidaturas'
        },
        api : {
            create  : 'General/insert_data',
            read    : 'General/get_select_id',
            update  : 'General/update_data',
            destroy : 'General/delete_data'
        }
    }
});