/**
 * Created by LOPEZSOFT on 25/01/2016.
 */
Ext.define('Admin.store.estudiantes.EvaluacionesEstudiantesStore',{
    extend  : 'Admin.store.base.StoreApi',
    storeId : 'EvaluacionesEstudiantesStore',
    requires : [
        'Admin.model.estudiantes.EvaluacionesEstudiantesModel'
    ],
    model   : 'Admin.model.estudiantes.EvaluacionesEstudiantesModel',
    proxy : {
        extraParams : {
            pdbTable    : 'te_evaluacion_compartida'
        },
        api: {
            create  : '',
            read    : 'students/get_select_evaluaciones',
            update  : 'General/update_data',
            destroy : ''
        }
    }
});