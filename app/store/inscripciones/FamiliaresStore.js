/**
 * Created by LOPEZSOFT2 on 23/09/2016.
 */
Ext.define('Admin.store.inscripciones.FamiliaresStore',{
    extend  : 'Admin.store.base.StoreApi',
    storeId : 'FamiliaresStore',
    pageSize: '60',
    proxy: {
        extraParams : {
            pdbTable : 'familiares'
        },
        api: {
            create  : 'c_academico/insert_familiares',
            read    : 'c_academico/get_select_familiares',
            update  : 'c_academico/get_update_familiares',
            destroy : 'master/deleteData'
        }
    },
    requires: [
        'Admin.model.inscripciones.FamiliaresModel'
    ],
    model   : 'Admin.model.inscripciones.FamiliaresModel'
});
