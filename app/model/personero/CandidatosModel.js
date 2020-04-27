/**
 * Created by LOPEZSOFT on 11/02/2016.
 */
Ext.define('Admin.model.personero.CandidatosModel',{
    extend  : 'Admin.model.base.BaseModel',
    fields  : [
        { name  : 'nombres'},
        { name  : 'cod_grado'},
        { name  : 'grupo'},
        { name  : 'numero'},
        { name  : 'nom_candidato'},
        { name  : 'foto'},
        { name  : 'id_matric'},
        { name  : 'candidatura', type : 'int'},
        { name  : 'año'},
        { name  : 'mime'},
        { name  : 'tipo'}
    ]
});