Ext.define('Admin.store.general.ResguardosStore', {
    extend: 'Admin.store.base.StoreUrl',
    storeId : 'ResguardosStore',
    pagSize : 100,
    requires: [
    	'Admin.model.general.ResguardosModel'
    ],    
    model		: 'Admin.model.general.ResguardosModel',
    proxy: {
    	type	: 'ajax',
        url	    : 'General/get_resguardos'
    }
});