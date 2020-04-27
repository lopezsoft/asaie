Ext.define('Admin.combo.CbSisben',{
	extend	: 'Admin.combo.ComboExpand',
	requires: [
        'Admin.store.general.SisbenStore'
    ],
	alias		: 'widget.CbSisben',
	fieldLabel	: 'Sisben',
	name		: 'sisben',
    displayField: 'sisben',
    valueField	: 'sisben',
    itemId		: 'CbSisben',
    store		: 'SisbenStore',
    queryMode	: 'local'
});