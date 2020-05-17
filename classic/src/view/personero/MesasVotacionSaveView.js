/**
 * Created by LOPEZSOFT on 8/02/2016.
 */
Ext.define('Admin.view.personero.MesasVotacionSaveView',{
    extend  : 'Admin.base.CustomWindow',
    alias   : 'widget.MesasVotacionSaveView',
    controller  : 'personero',
    title   : 'Mesas de votación',
    height  : 300,
    items   : [
        {
            xtype   : 'customform',
            defaultType : 'customtextarea',
            items   : [
                {
                    fieldLabel  : 'Nombre de la mesa',
                    name        : 'nom_mesa'
                },
                {
                    xtype       : 'customnumberfield',
                    fieldLabel  : 'Número de la mesa',
                    name        : 'num_mesa',
                    keyNavEnabled	: true,
                    value       : 1,
                    minValue 	: 1,
                    maxValue	: 20
                },
                {
                    fieldLabel  : 'Ubicación, dirección',
                    name        : 'ubicacion'
                }
            ]
        }
    ]
});