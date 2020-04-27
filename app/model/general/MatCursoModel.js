/**
 * Created by LOPEZSOFT on 5/12/2015.
 */
Ext.define('Admin.model.general.MatCursoModel',{
    extend  : 'Admin.model.base.BaseModel',
    fields: [
        { name: 'id_gradi',	type : 'int'},
        { name: 'id_asig',	type : 'int'},
        { name: 'ih'},
        { name: 'año'},
        { name: 'porciento'},
        { name: 'proc1'},
        { name: 'proc2'},
        { name: 'proc3'},
        { name: 'proc4'},
        { name: 'id_area', type : 'int'},
        { name: 'grado'},
        { name: 'asignatura'},
        { name: 'estado', type : 'bool'}
    ]
});
