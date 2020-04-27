Ext.define('Admin.store.personero.CandidatosSearchStore',{
    extend  : 'Admin.store.docentes.EstudiantesStore',
    storeId : 'CandidatosSearchStore',
    proxy   : {
        url : 'c_personero/get_select_estudiantes'
    }
});
