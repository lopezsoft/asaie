/**
 * Created by LOPEZSOFT on 6/02/2016.
 */
Ext.define('Admin.model.personero.MesasVotacionModel',{
    extend  : 'Admin.model.base.BaseModel',
    fields  : [
        { name  : 'nom_mesa'},
        { name  : 'num_mesa'},
        { name  : 'ubicacion'},
        { name  : 'estado'},
        { name  : 'hora_inicio'},
        { name  : 'hora_final'},
        { name  : 'año'}
    ]
});