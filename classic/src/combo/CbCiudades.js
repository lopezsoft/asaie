Ext.define('Admin.combo.CbCiudades',{
	extend	: 'Admin.combo.CustomComboBox',
	alias	: 'widget.CbCiudades',
	fieldLabel	: 'Ciudad o municipio:',
    emptyText 	: 'Elija una ciudad o municipio',
    requires: [
        'Admin.store.general.CiudStore'
    ],
    name		: 'id_city',
    displayField: 'name_city',
    valueField	: 'id',
    store		: 'CiudStore',
    autoLoadOnValue : true
});
