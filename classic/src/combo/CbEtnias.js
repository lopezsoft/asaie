Ext.define('Admin.combo.CbEtnias',{
	extend	: 'Admin.combo.CustomComboBox',
	 requires: [
       'Admin.store.general.EtniasStore'
    ],
	alias	: 'widget.CbEtnias',
	fieldLabel	: 'Etnia',
	name		: 'cod_etnia',
    displayField: 'NOM_ETNIA',
    valueField	: 'COD_ETNIA',
    itemId		: 'CbEtnias',
	reference 	: 'CbEtnias',
    publishes   : 'value',
    store		: 'EtniasStore'
});