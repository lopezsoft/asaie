/**
 * Created by LOPEZSOFT on 29/04/2016.
 */
Ext.define('Admin.view.estudiantes.home.PanelContainerEstudiantesView', {
    extend: 'Ext.container.Container',
    requires: [
        'Ext.ux.layout.ResponsiveColumn',
        'Admin.view.widgets.WidgetA',
        'Admin.view.estudiantes.home.DocentesCursoView'
    ],
    controller  : 'estudiantes',
    alias       : 'widget.PanelContainerEstudiantesView',
    reference   : 'PanelContainerEstHomeView',
    layout      : 'responsivecolumn',
    items   : [
        {
            xtype   : 'widget-a',
            userCls : 'small-100 big-100'
        },
        {
            xtype   : 'DocentesCursoView',
            userCls : 'small-100 big-100',
            titleCollapse   : true,
            collapsible     : true,
            collapsed       : true
        }
    ]
});