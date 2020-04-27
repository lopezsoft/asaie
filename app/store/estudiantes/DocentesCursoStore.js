Ext.define('Admin.store.estudiantes.DocentesCursoStore', {
    extend: 'Admin.store.base.StoreUrl',
    storeId : 'DocentesCursoStore',
    fields  : [
        {name : 'asignatura'},
        {name : 'grado'},
        {name : 'grupo'},
        {name : 'jornada'},
        {name : 'sede'}
    ],
    pageSize	: 0,
    proxy: {
        url : 'c_estudiantes/get_docentes_curso'
    }
});