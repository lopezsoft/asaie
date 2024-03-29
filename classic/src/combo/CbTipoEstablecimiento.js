Ext.define('Admin.combo.CbTipoEstablecimiento',{
	extend	: 'Admin.combo.ComboExpand',
	 requires: [
       'Admin.store.general.TipoEstablecimientoStore'
    ],
	alias	    : 'widget.CbTipoEstablecimiento',
	fieldLabel	: 'Tipo establecimiento',
	name		: 'TIPO_EST',
    displayField: 'tipo',
    valueField	: 'id_test',
	reference 	: 'CbTipoEstablecimiento',
    publishes   : 'value',
    store		: 'TipoEstablecimientoStore'
});