/**
 * Created by LOPEZSOFT on 2/06/2016.
 */
Ext.define('Admin.view.estudiantes.menu.PanelReportEstudiantesView',{
    extend: 'Ext.container.Container',
    requires: [
        'Ext.ux.layout.ResponsiveColumn'
    ],
    controller  : 'estudiantes',
    alias       : 'widget.PanelReportEstudiantesView',
    reference   : 'PanelReportEstudiantesView',
    layout      : 'responsivecolumn',
    defaultType : 'containerButton',
    items   : [
        {
            items   : [
                {
                    xtype   : 'buttonPanel',
                    text    : 'Boletín'+'<br>'+'periódico',
                    handler : 'onBoletin',
                    iconCls : 'x-fa fa-newspaper-o'
                }
            ]
        },
        {
            items   : [
                {
                    xtype   : 'buttonPanel',
                    text    : 'Consolidado'+'<br>'+'académico',
                    itemId  : 'btnConsolidado',
                    handler : '',
                    disabled: true,
                    iconCls : 'x-fa fa-print'
                }
            ]
        },
        {
            items   : [
                {
                    xtype   : 'buttonPanel',
                    text    : 'Pre Informe',
                    disabled: true,
                    iconCls : 'x-fa fa-newspaper-o',
                    handler : ''
                }
            ]
        },
        {
            xtype   : 'containerButton',
            items   : [
                {
                    xtype   : 'buttonPanel',
                    text    : 'Certificado'+'<br>'+'final de'+'<br>'+'promoción',
                    itemId  : 'btnCertificadoFinal',
                    disabled: true,
                    handler : '',
                    iconCls : 'x-fa fa-graduation-cap"'
                }
            ]
        },
        {
            xtype   : 'containerButton',
            items   : [
                {
                    xtype   : 'buttonPanel',
                    text    : 'Informe'+'<br>'+'final de'+'<br>'+'promoción',
                    itemId  : 'btnLibroFinal',
                    disabled: true,
                    handler : '',
                    iconCls : 'x-fa fa-graduation-cap"'
                }
            ]
        },
        {
            xtype   : 'containerButton',
            items   : [
                {
                    xtype   : 'buttonPanel',
                    text    : 'Constancias'+'<br>'+'de'+'<br>'+'estudio',
                    itemId  : 'btnConstancias',
                    handler : 'onConstancias',
                    iconCls : 'x-fa fa-certificate"'
                }
            ]
        },
        {
            xtype   : 'containerButton',
            items   : [
                {
                    xtype   : 'buttonPanel',
                    text    : 'Archivos'+'<br>'+'digitales',
                    itemId  : 'btnArchivos',
                    handler : function (btn) {
                        var me  = Admin.getApplication();
                        me.onMsgWait();
                        Ext.require([
                            'Admin.view.docs.FilesView'
                        ]);
                        Ext.onReady(function () {
                            me.onStore('docs.ImageBrowserStore');
                            var win = Ext.create({
                                xtype       : 'FilesView',
                                title       : 'Seleccionar archivo',
                                pathReadFile    : 'c_academico/read_files_dig_est',
                                pathUploadFile  : 'c_academico/upload_files_dig_est',
                                titlePanelLoad  : 'Subir archivos',
                                titlePanelView  : 'Mis archivos',
                                textButtonLoad  : 'Seleccionar una archivo en el equipo',
                                textButtonApply : 'Aceptar',
                                extraParams     : {
                                    pdbCodEst   : globales.General.DbConfig.cod_est
                                }
                            });
                            win.show();
                            me.onMsgClose();
                        });
                    },
                    iconCls : 'x-fa fa-archive"'
                }
            ]
        }
    ]
});