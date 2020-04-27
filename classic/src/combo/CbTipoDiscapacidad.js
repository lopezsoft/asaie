Ext.define('Admin.combo.CbTipoDiscapacidad',{
	extend	: 'Admin.combo.ComboExpand',
	 requires: [
       'Admin.store.general.TipoDiscapacidadStore'
    ],
	alias	    : 'widget.CbTipoDiscapacidad',
	fieldLabel	: 'Tipo de discapacidad',
	name		: 'tipo_discapacidad',
    displayField: 'nombre',
    valueField	: 'id',
    itemId		: 'CbTipoDiscapacidad',
	reference 	: 'CbTipoDiscapacidad',
    publishes   : 'value',
    store		: 'TipoDiscapacidadStore'
});