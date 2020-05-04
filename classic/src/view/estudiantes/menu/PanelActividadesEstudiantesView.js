/**
 * Created by LOPEZSOFT on 2/06/2016.
 */
Ext.define('Admin.view.estudiantes.menu.PanelActividadesEstudiantesView',{
    extend: 'Ext.container.Container',
    requires: [
        'Ext.ux.layout.ResponsiveColumn'
    ],

    controller  : 'estudiantes',
    alias       : 'widget.PanelActividadesEstudiantesView',
    reference   : 'PanelActividadesEstudiantesView',

    layout      : 'responsivecolumn',
    defaultType : 'containerButton',
    items   : [
        {
            items   : [
                {
                    xtype   : 'buttonPanel',
                    text    : 'Evaluaciones',
                    handler : function (btn) {
                        var
                            app  = Admin.getApplication();
                        app.onMsgWait();
                        Ext.require('Admin.view.estudiantes.EvaluacionesEstudiantesView');
                        Ext.onReady(function () {
                            app.onStore('estudiantes.EvaluacionesEstudiantesStore');
                            win  = app.getWindow(null,'Admin.view.estudiantes.EvaluacionesEstudiantesView');
                            app.onMsgClose();
                            win.show();
                        });
                    },
                    iconCls : 'x-fa fa-spinner'
                }
            ]
        },
        {
            items   : [
                {
                    xtype   : 'buttonPanel',
                    text    : 'Actividades'+'<br>'+'en clase',
                    handler : '',
                    iconCls : 'x-fa fa-spinner'
                }
            ]
        },
        {
            items   : [
                {
                    xtype   : 'buttonPanel',
                    text    : 'Solicitud'+'<br>'+'de permisos',
                    handler : '',
                    iconCls : 'x-fa fa-spinner'
                }
            ]
        },
        {
            items   : [
                {
                    xtype   : 'buttonPanel',
                    text    : 'Ausencias'+'<br>'+'diarias',
                    handler : '',
                    iconCls : 'x-fa fa-spinner'
                }
            ]
        },
        {
            items   : [
                {
                    xtype   : 'buttonPanel',
                    text    : 'Material'+'<br>'+'educativo',
                    iconCls : 'x-fa fa-spinner',
                    handler     : function (btn) {
                        var
                            app  = Admin.getApplication();
                        app.onMsgWait();
                        Ext.require('Admin.view.estudiantes.StudentsActivities');
                        Ext.onReady(function () {
                            app.onStore('estudiantes.MaterialEducativoEstudiantesStore');
                            win  = app.getWindow(null,'Admin.view.estudiantes.StudentsActivities');
                            app.onMsgClose();
                            win.show();
                        });
                    }
                }
            ]
        }
    ]
});