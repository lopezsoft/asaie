/**
 * Created by LOPEZSOFT on 5/02/2016.
 */
Ext.define('Admin.store.personero.PanelControlStore',{
    extend  : 'Admin.store.base.StoreApi',
    storeId : 'PanelControlStore',
    requires: [
        'Admin.model.personero.PanelControlModel'
    ],
    model   : 'Admin.model.personero.PanelControlModel',
    proxy   : {
        extraParams : {
            pdbTable    : 'tp_panel_control'
        }
    }
});