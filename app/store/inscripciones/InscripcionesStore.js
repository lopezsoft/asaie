/**
 * Created by LOPEZSOFT2 on 23/09/2016.
 */
Ext.define('Admin.store.inscripciones.InscripcionesStore',{
    extend  : 'Admin.store.base.StoreApi',
    storeId : 'InscripcionesStore',
    proxy: {
        extraParams : {
            pdbTable : 'inscripciones'
        },
        api: {
            create  : 'c_academico/insert_inscripciones',
            read    : 'c_academico/get_select_inscripciones',
            update  : 'master/updateData',
            destroy : 'master/deleteData'
        }
    },
    requires: [
        'Admin.model.inscripciones.InscripcionesModel'
    ],
    model   : 'Admin.model.inscripciones.InscripcionesModel'
});