/**
 * Created by LOPEZSOFT on 5/02/2016.
 */
Ext.define('Admin.view.personero.PanelControlView',{
    extend  : 'Admin.base.CustomWindow',
    title   : 'Panel de Control',
    alias   : 'widget.PanelControlView',
    maximized   : true,
    controller  : 'personero',
    items   : [
        {
            xtype   : 'customform',
            defaultType : 'TextField',
            items   : [
                {
                    xtype       : 'customnumberfield',
                    fieldLabel  : 'Votos por mesa',
                    name        : 'voto_x_mesa'
                },
                {
                    xtype       : 'radiogroup',
                    fieldLabel  : 'Discriminar votación por sede',
                    labelStyle  : 'font-weight:bold',
                    labelWidth  : 180,
                    defaults    : {
                        name    : 'discriminar_x_sede'
                    },
                    items       : [
                        {
                            boxLabel    : 'Si',
                            inputValue  : '1',
                            checked     : true
                        },
                        {
                            boxLabel    : 'No',
                            inputValue  : '2'
                        }
                    ]
                },
                {
                    xtype       : 'radiogroup',
                    fieldLabel  : 'Tipo de base de datos',
                    labelStyle  : 'font-weight:bold',
                    labelWidth  : 180,
                    defaults    : {
                        name    : 'base_de_datos'
                    },
                    items       : [
                        {
                            boxLabel    : 'Local, sistama de notas',
                            inputValue  : '1',
                            checked     : true
                        },
                        {
                            boxLabel    : 'Importarda',
                            inputValue  : '2'
                        }
                    ]
                },
                {
                    fieldLabel  : 'Nombre de la Instución o centro educativo',
                    name        : 'nom_inst',
                    hidden      : true,
                    allowBlank  :  true
                },
                {
                    fieldLabel  : 'Descripción del encabezado del certificado electoral',
                    name        : 'nom_certificado'
                },
                {
                    xtype       : 'customnumberfield',
                    name        : 'int_voto_nulo',
                    fieldLabel  : 'Intentos posibles para voto nulo'
                },
                {
                    xtype       : 'DateField',
                    fieldLabel  : 'Fecha inicio jornada electoral',
                    name        : 'inicio_jorn'
                },
                {
                    xtype       : 'TimeField',
                    name        : 'hora_inicio',
                    fieldLabel  : 'Hora de inicio'
                },
                {
                    xtype       : 'TimeField',
                    name        : 'hora_final',
                    fieldLabel  : 'Hora de cierre'
                }
            ]
        }
    ]
});