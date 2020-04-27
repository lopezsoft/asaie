/**
 * Created by LOPEZSOFT on 6/01/2016.
 */
Ext.define('Admin.view.docentes.ActividadesClaseSaveView',{
    extend : 'Admin.base.WindowCrud',
    alias  	: 'widget.ActividadesClaseSaveView',
    width	: 580,
    height	: 250,
    defaultFocus    : 'textAreaField',
    controller : 'actividades',
    items 	: [
        {
            xtype 	: 'customform',
            items : [
                {
                    xtype 	    : 'textAreaField',
                    name 	    : 'actividad',
                    fieldLabel	: 'Descripción de la actividad'
                },
                {
                    xtype       : 'DateField',
                    name        : 'fecha'
                }
            ]
        }
    ]
});