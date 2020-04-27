/**
 * Created by LOPEZSOFT on 5/12/2015.
 */
Ext.define('Admin.store.general.MatCursoStore', {
    extend: 'Admin.store.base.StoreApi',
    storeId : 'MatCursoStore',
    requires: [
        'Admin.model.general.MatCursoModel'
    ],
    model		: 'Admin.model.general.MatCursoModel',
    pageSize  : 0,
    proxy: {
        extraParams : {
            pdbTable    : 'matcurso',
            pdbGrado    : 0
        },
        api: {
            create  : 'General/insert_data',
            read    : 'c_academico/get_select_matcurso',
            update  : 'General/update_data',
            destroy : 'General/delete_data'
        }
    }
});