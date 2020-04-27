/**
 * Created by LOPEZSOFT on 11/02/2016.
 */
Ext.define('Admin.model.personero.CandidaturaModel',{
    extend  : 'Admin.model.base.BaseModel',
    idProperty  : 'id',
    fields  : [
        { name  : 'id', type : 'int'},
        { name  : 'candidatura', type : 'string'},
        { name  : 'estado', type : 'bool'}
    ]
});