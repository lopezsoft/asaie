/**
 * Created by LOPEZSOFT on 19/03/2016.
 */

Ext.define('Admin.view.estudiantes.ConstanciasEstView',{
    extend  : 'Admin.base.CustomWindow',
    alias   : 'widget.ConstanciasEstView',
    title   : 'estudiantes',
    itemId  : 'ConstanciasEstView',
    height      : 200,
    width       : 480,
    items   : [
        {
            xtype   : 'customform',
            defaults: {
                labelWidth  : 120
            },
            items   : [
                {
                    xtype       : 'radiogroup',
                    fieldLabel  : 'Tipo de reporte',
                    columns     : 2,
                    vertical    : true,
                    labelStyle	: 'font-weight:bold',
                    itemId      : 'hType',
                        items   : [
                        {
                            boxLabel  : 'Modelo 1',
                            name      : 'modelo',
                            inputValue: '1',
                            checked   : true
                        },
                        {
                            boxLabel  : 'Modelo 1',
                            name      : 'modelo',
                            inputValue: '2'
                        }
                    ]
                }
            ],
            dockedItems : []
        }
    ],
    buttons : [
        {
            xtype       : 'printButton',
            disabled    : false,
            formBind    : true
        }
    ]
});