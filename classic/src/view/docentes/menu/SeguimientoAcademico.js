Ext.define('Admin.view.docentes.menu.SeguimientoAcademico',{
    extend: 'Ext.container.Container',
    requires: [
        'Ext.ux.layout.ResponsiveColumn'
    ],
    controller  : 'seguimiento',
    alias       : 'widget.seguimientoacademico',
    xtype       : 'seguimientoacademico',
    layout      : 'responsivecolumn',
    defaultType : 'containerButton',
    items   : [
        {
            items   : [
                {
                    xtype   : 'buttonPanel',
                    text    : 'Ficha de seguimiento',
                    handler : 'onViewObservador',
                    iconCls : 'x-fa fa-eye'
                }
            ]
        },
        {
            items   : [
                {
                    xtype   : 'buttonPanel',
                    text    : 'Acciones de seguimiento',
                    disabled: true,
                    iconCls : 'x-fa fa-eye'
                }
            ]
        },
        {
            items   : [
                {
                    xtype   : 'buttonPanel',
                    text    : 'Reporte disciplinario',
                    disabled: true,
                    iconCls : 'x-fa fa-eye'
                }
            ]
        }
    ]
});