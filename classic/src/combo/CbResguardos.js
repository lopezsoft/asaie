Ext.define('Admin.combo.CbResguardos',{
	extend	: 'Admin.combo.CustomComboBox',
	 requires: [
       'Admin.store.general.ResguardosStore'
    ],
	alias	: 'widget.CbResguardos',
	fieldLabel	: 'Resguardo',
	name		: 'cod_resgua',
    displayField: 'NOMB_RESG',
    valueField	: 'COD_RESGUA',
    itemId		: 'CbResguardos',
	reference 	: 'CbResguardos',
    publishes   : 'value',
    store		: 'ResguardosStore'
});