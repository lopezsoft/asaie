/**
 * Created by LOPEZSOFT on 8/02/2016.
 */
Ext.define('Admin.model.personero.MesasSedesModel',{
    extend  : 'Admin.model.base.BaseModel',
    fields  : [
        { name  : 'id_mesa'},
        { name  : 'id_sede'},
        { name  : 'sede'},
        { name  : 'grados_votantes', type : 'int'}
    ]
});