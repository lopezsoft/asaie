/**
 * Created by LOPEZSOFT on 5/02/2016.
 */
Ext.define('Admin.model.personero.PanelControlModel',{
    extend  : 'Admin.model.base.BaseModel',
    fields  : [
        { name  : 'año'},
        { name  : 'voto_x_mesa'},
        { name  : 'discriminar_x_sede'},
        { name  : 'base_de_datos'},
        { name  : 'nom_inst'},
        { name  : 'logo'},
        { name  : 'nom_certificado'},
        { name  : 'int_voto_nulo'},
        { name  : 'hora_inicio'},
        { name  : 'hora_final'}
    ]
});