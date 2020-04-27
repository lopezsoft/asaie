/**
 * Created by LOPEZSOFT on 8/02/2016.
 */
Ext.define('Admin.view.personero.SedesAsignadasSaveView',{
    extend  : 'Admin.base.CustomWindow',
    title   : 'Sedes asignadas a la mesa',
    alias   : 'widget.SedesAsignadasSaveView',
    controller  : 'personero',
    height  : 250,
    items   : [
        {
            xtype   : 'customform',
            items   : [
                {
                    xtype   : 'CbSedes'
                },
                {
                    xtype       : 'radioGroup',
                    fieldLabel  : 'Grados votantes',
                    defaults    : {
                        name    : 'grados_votantes'
                    },
                    items   : [
                        {
                            boxLabel    : 'Todos los grados',
                            inputValue  : '1'
                        },
                        {
                            boxLabel    : 'Selección',
                            inputValue  : '2'
                        }
                    ]
                }
            ]
        }
    ]
});