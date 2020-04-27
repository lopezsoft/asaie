/**
 * Created by LOPEZSOFT on 7/02/2016.
 */
Ext.define('Admin.store.personero.MesasVotacionStore',{
    extend  : 'Admin.store.base.StoreApi',
    storeId : 'MesasVotacionStore',
    requires: [
        'Admin.model.personero.MesasVotacionModel'
    ],
    model   : 'Admin.model.personero.MesasVotacionModel',
    proxy   : {
        extraParams : {
            pdbTable    : 'tp_mesas_votacion'
        }
    }
});