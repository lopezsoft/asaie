Ext.define('Admin.store.personero.CandidatosSearchStore',{
    extend  : 'Admin.store.docentes.EstudiantesStore',
    storeId : 'CandidatosSearchStore',
    proxy: {
		type	: 'ajax',
	    api: {
			create  : 'master/insertData',
			read    : 'c_personero/get_select_estudiantes',
			update  : 'master/updateData',
			destroy : 'master/deleteData'
		}
	}
});
