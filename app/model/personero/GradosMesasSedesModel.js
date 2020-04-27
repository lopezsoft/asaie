/**
 * Created by LOPEZSOFT on 8/02/2016.
 */
Ext.define('Admin.model.personero.GradosMesasSedesModel',{
    extend  : 'Admin.model.base.BaseModel',
    fields  : [
        { name  : 'id_sede_mesa'},
        { name  : 'cod_grado'},
        { name  : 'grupo'},
        { name  : 'grado'},
        { name  : 'mesa'},
        { name  : 'sede'}
    ]
});