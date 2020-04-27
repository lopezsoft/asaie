Ext.define('Admin.store.general.EtniasStore', {
    extend: 'Admin.store.base.StoreUrl',
    storeId : 'EtniasStore',
    pagSize : 100,
    requires: [
    	'Admin.model.general.EtniasModel'
    ],    
    model		: 'Admin.model.general.EtniasModel',
    proxy: {
    	type	: 'ajax',
        url	    : 'General/get_etnias'
    }
});