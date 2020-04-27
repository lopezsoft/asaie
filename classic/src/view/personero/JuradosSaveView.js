/**
 * Created by LOPEZSOFT on 11/02/2016.
 */
Ext.define('Admin.view.personero.JuradosSaveView',{
    extend  : 'Admin.base.CustomWindow',
    title   : 'Jurados',
    controller  : 'personero',
    alias   : 'widget.JuradosSaveView',
    height  : 200,
    items   : [
        {
            xtype   : 'customform',
            defaultType : 'TextField',
            items   : [
                {
                    name        : 'nom_jurado',
                    fieldLabel  : 'Nombre del jurado'
                },
                {
                    name        : 'cargo',
                    fieldLabel  : 'Cargo'
                }
            ]
        }
    ]
});