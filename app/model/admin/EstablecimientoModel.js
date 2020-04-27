/**
 * Created by LOPEZSOFT2 on 23/09/2016.
 */
Ext.define('Admin.model.admin.EstablecimientoModel',{
    extend  : 'Admin.model.base.BaseModel',
    idProperty  : 'ID',
    fields  : [
        {name : 'ID'},
        {name : 'ID_CARACTER'},
		{name : 'ID_SECTOR'},
		{name : 'ID_CITY'},
		{name : 'ID_ZONA'},
        {name : 'GENERO'},
        {name : 'COD_DANE'},
        {name : 'LOCALIDAD'},
        {name : 'NOMBRE_IE'},
        {name : 'NOMBRE_RECTOR'},
        {name : 'BARRIO'},
        {name : 'DIRECCION'},
        {name : 'TELEFONOS'},
        {name : 'FAX'},
        {name : 'WEB'},
        {name : 'CORREO'},
        {name : 'SEDES'},
        {name : 'NUCLEO'},
        {name : 'NIT'}
    ]
});
