/**
 * Created by LOPEZSOFT on 20/02/2016.
 */

var store   = Ext.create('Ext.data.Store', {
    fields  : [
        { name : 'id'},
        { name : 'nombre'}
    ],
    data : [
        {id: '1',    nombre: 'CERTIFICADO ELECTORAL'},
        {id: '2',    nombre: 'LISTADO DE ESTUDIANTES'}
    ]
});


Ext.define('Admin.view.personero.PersoneroReportView',{
    extend  : 'Admin.base.CustomWindow',
    alias   :'widget.PersoneroReportView',
    title   : 'Reportes personero',
    controller  : 'personero',
    requires    : [
        'Admin.combo.CbGrados',
        'Admin.combo.CbSedes'
    ],
    height      : 250,
    width       : 480,
    items   : [
        {
            xtype   : 'customform',
            defaults: {
                labelWidth  : 120
            },
            items   : [
                {
                    xtype   : 'CbSedes'
                },
                {
                    xtype   : 'CbGrados'
                },
                {
                    xtype       : 'ComboExpand',
                    itemId      : 'comboReport',
                    store       : store,
                    fieldLabel	: 'Tipo de reporte',
                    name		: 'id',
                    displayField: 'nombre',
                    valueField	: 'id',
                    reference 	: 'comboReport',
                    publishes   : 'value'
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