/**
 * Created by LOPEZSOFT2 on 11/12/2016.
 */
Ext.define('Admin.model.general.CiudModel',{
    extend  : 'Admin.model.base.BaseModel',
    property    : 'id',
    fields      : [
        { name  : 'id'},
        { name  : 'id_dept'},
		{ name  : 'id_country'},
        { name  : 'city_code'},
        { name  : 'name_city'}
    ]
});
