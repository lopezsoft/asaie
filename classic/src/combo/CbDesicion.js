Ext.define('Admin.combo.CbDesicion',{
	extend	: 'Admin.combo.ComboExpand',
	requires: [
        'Admin.store.docentes.observador.DesicionStore'
    ],
	alias		: 'widget.CbDesicion',
	fieldLabel	: 'Desición:',
	name		: 'desicion',
    displayField: 'desicion',
    valueField	: 'desicion',
    //itemId		: 'cbDesicion',
    store		: 'DesicionStore',
    queryMode	: 'local'
});