/**
 * Created by LOPEZSOFT on 5/12/2015.
 */
Ext.define('Admin.store.general.AreasAsignaturaStore', {
    extend: 'Admin.store.base.StoreApi',
    storeId : 'AreasAsignaturaStore',
    requires: [
        'Admin.model.general.AreasAsignaturaModel'
    ],
    model		: 'Admin.model.general.AreasAsignaturaModel',
    proxy: {
        extraParams : {
            pdbTable : 'aux_asignaturas'
        },
        api: {
            create  : 'c_academico/insert_aux_asignaturas',
            read    : 'c_academico/get_select_aux_asignaturas',
            update  : 'General/update_data',
            destroy : 'General/delete_data'
        }
    }
});