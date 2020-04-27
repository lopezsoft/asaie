/**
 * Created by LOPEZSOFT on 2/02/2016.
 */
Ext.define('Admin.view.personero.PersoneroContainerView',{
    extend  : 'Ext.container.Container',
    requires    : [
        'Admin.view.personero.controller.PersoneroController',
        'Admin.view.personero.PanelControlView',
        'Ext.ux.layout.ResponsiveColumn'
    ],
    controller  : 'personero',

    alias   : 'widget.PersoneroContainerView',

    layout: 'responsivecolumn' ,

    items   : [
        {
            xtype   : 'containerButton',
            items   : [
                {
                    xtype       : 'buttonPanel',
                    text    : 'Panel'+'<br>'+'de control',
                    iconCls : 'x-fa fa-cog',
                    itemId  : 'btnPanel',
                    handler : 'onPanelControl'
                }
            ]
        },
        {
            xtype   : 'containerButton',
            items   : [
                {
                    xtype       : 'buttonPanel',
                    text    : 'Mesas'+'</br>'+'de votación',
                    iconCls : 'x-fa fa-table',
                    itemId  : 'btnVotacion',
                    tooltip : 'Mesas de votación',
                    handler : 'onMesasVotacion'
                }
            ]
        },
        {
            xtype   : 'containerButton',
            items   : [
                {
                    xtype       : 'buttonPanel',
                    text    : 'Candidatos',
                    iconCls : 'x-fa fa-users',
                    itemId  : 'btnCandidatos',
                    handler : 'onCandidatos'
                }
            ]
        },
        {
            xtype   : 'containerButton',
            items   : [
                {
                    xtype       : 'buttonPanel',
                    text    : 'Voto'+'</br>'+'en blanco',
                    iconCls : 'xi-blank_vote-24',
                    itemId  : 'btnVotoBlanco',
                    handler : 'onVotoBlanco'
                }
            ]
        },
        {
            xtype   : 'containerButton',
            items   : [
                {
                    xtype   : 'buttonPanel',
                    text    : 'Candidatura',
                    iconCls : 'xi-candidates-24',
                    itemId  : 'btnCandidaturas',
                    handler : 'onCandidaturas'
                }
            ]
        },
        {
            xtype   : 'containerButton',
            items   : [
                {
                    xtype   : 'buttonPanel',
                    text    : 'Iniciar'+'</br>'+'jornada',
                    iconCls : 'x-fa fa-external-link',
                    itemId  : 'btnOpen',
                    handler : 'onOpenTable'
                }
            ]
        },
        {
            xtype   : 'containerButton',
            items   : [
                {
                    xtype   : 'buttonPanel',
                    text    : 'Reportes',
                    iconCls : 'x-fa fa-print',
                    itemId  : 'btnPrint',
                    handler : 'onPrint'
                }
            ]
        },
        {
            xtype   : 'containerButton',
            items   : [
                {
                    xtype   : 'buttonPanel',
                    text    : 'Resultados',
                    iconCls : 'x-fa fa-print',
                    itemId  : 'btnResult',
                    handler : 'onResult'
                }
            ]
        }
    ]
});
