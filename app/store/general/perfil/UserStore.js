/**
 * Created by LOPEZSOFT on 2/05/2016.
 */
Ext.define('Admin.store.general.perfil.UserStore',{
    extend  : 'Admin.store.base.StoreApi',
    storeId : 'UserStore',
    requires: [
        'Admin.model.general.perfil.UserModel'
    ],
    model   : 'Admin.model.general.perfil.UserModel',
    proxy   : {
        api: {
            create  : 'General/insert_data',
            read    : 'General/get_select_users',
            update  : 'General/update_data',
            destroy : 'General/delete_data'
        },
        extraParams : {
            pdbTable    : 'users'
        }
    }
});