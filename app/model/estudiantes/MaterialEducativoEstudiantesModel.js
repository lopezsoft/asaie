/**
 * Created by LOPEZSOFT on 25/01/2016.
 */
Ext.define('Admin.model.estudiantes.MaterialEducativoEstudiantesModel',{
    extend  : 'Admin.model.base.BaseModel',
    fields  : [
        { name: 'id'},
        { name: 'id_matric'},
        { name: 'id_material'},
        { name: 'docente'},
        { name: 'grado'},
        { name: 'grupo'},
        { name: 'jornada'},
        { name: 'nombre'},
        { name: 'descripcion'},
        { name: 'asignatura'},
        { name: 'url_video'},
        { name: 'url_archivo'},
        { name: 'mime'},
        { name: 'fecha'},
        { name: 'url_enlace'},
        { name: 'leido', type : 'bool'}
    ]
});