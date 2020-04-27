Ext.define('Admin.store.base.StoreApi',{
	extend		: 'Admin.store.base.StoreUrl',
	storeId		: 'StoreApi',
	pageSize	: 100,
    proxy: {
		type	: 'ajax',
	    api: {
			create  : 'master/insertData',
			read    : 'master/getTable',
			update  : 'master/updateData',
			destroy : 'master/deleteData'
		},
	    writer : {
			type 			: 'json',
			rootProperty	: 'records',
			encode 			: true
		}
	}
});
