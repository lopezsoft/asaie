/**
 * Created by LOPEZSOFT on 25/01/2016.
 */
Ext.define('Admin.store.estudiantes.MaterialEducativoEstudiantesStore',{
    extend  : 'Admin.store.base.StoreApi',
    storeId : 'MaterialEducativoEstudiantesStore',
    requires : [
        'Admin.model.estudiantes.MaterialEducativoEstudiantesModel'
    ],
    model   : 'Admin.model.estudiantes.MaterialEducativoEstudiantesModel',
    proxy : {
        extraParams : {
            pdbTable    : 'material_educ_compartido'
        },
        api: {
            create  : '',
            read    : 'c_estudiantes/get_select_material_educ',
            update  : 'General/update_data',
            destroy : ''
        }
    }
});