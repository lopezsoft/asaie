Ext.define('Admin.view.docentes.reportes.InformesDocentes',{
    extend: 'Ext.container.Container',
    requires: [
        'Ext.ux.layout.ResponsiveColumn'
    ],
    controller  : 'Reporboletin',
    alias       : 'widget.informesdocentes',
    reference   : 'informesdocentes',
    layout      : 'responsivecolumn',
    defaultType : 'containerButton',
    items   : [
        {
            items   : [
                {
                    xtype   : 'buttonPanel',
                    text    : 'Boletines',
                    handler : 'onReportView',
                    iconCls : 'x-fa fa-newspaper-o'
                }
            ]
        },
        {
            items   : [
                {
                    xtype   : 'buttonPanel',
                    text    : 'Consolidado académico',
                    handler : 'onViewConsolidado',
                    iconCls : 'x-fa fa-print'
                }
            ]
        },
        {
            xtype   : 'containerButton',
            items   : [
                {
                    xtype   : 'buttonPanel',
                    text    : 'Estadísticas',
                    handler : 'onViewEstadistica',
                    iconCls : 'x-fa fa-level-up'
                }
            ]
        }
    ]
});
