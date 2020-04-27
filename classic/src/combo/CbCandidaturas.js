Ext.define('Admin.combo.CbCandidaturas',{
	extend	: 'Admin.combo.CustomComboBox',
	 requires: [
       'Admin.store.personero.CandidaturaStore'
    ],
	alias	: 'widget.CbCandidaturas',
	fieldLabel	: 'Candidatura',
	name		: 'candidatura',
    displayField: 'candidatura',
    valueField	: 'id',
    itemId		: 'comboCandidaturas',
	reference 	: 'comboCandidaturas',
	publishes   : 'value',
	store		: 'CandidaturaStore'
});
