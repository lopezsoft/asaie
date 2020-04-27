Ext.define('Admin.view.widgets.WidgetA', {
    extend  : 'Ext.panel.Panel',
    xtype   : 'widget-a',
    ui      : 'panel-white',
    cls     : 'admin-widget shadow',
    items: [
        {
            xtype   : 'image',
            cls     : 'widget-top-container-first-img',
            height  : 72,
            width   : 72,
            alt     : 'profile-image',
            src     : 'resources/img/avatars/unknown.png',
            itemId  : 'ImgPerfil'
        },
        {
            xtype: 'component',
            cls: 'widget-top-first-container postion-class',
            height: 135
        },
        {
            xtype: 'container',
            cls: 'widget-bottom-first-container postion-class',
            height: 165,
            padding: '30 0 0 0',
            layout: {
                type: 'vbox',
                align: 'center'
            },
            items: [
                {
                    xtype   : 'label',
                    cls     : 'widget-name-text',
                    html    : 'Estudiante',
                    itemId  : 'labelName'
                },
                {
                    xtype   : 'label',
                    html    : 'Sede',
                    itemId  : 'labelSede'
                },
                {
                    xtype   : 'label',
                    html    : 'Curso',
                    itemId  : 'labelCurso'
                },
                {
                    xtype   : 'label',
                    html    : 'Jornada',
                    itemId  : 'labelJorn'
                },
                {
                    xtype   : 'toolbar',
                    cls     : 'widget-tool-button',
                    flex    : 1,
                    items   : [
                        {
                            ui      : 'soft-blue',
                            iconCls : 'x-fa fa-pencil',
                            text    : 'Editar datos personales',
                            handler : function (btn) {
                                var
                                    me = Admin.getApplication();
                                me.onMsgWait();
                                Ext.require([
                                    'Admin.view.estudiantes.EditarInscripcionView',
                                    'Admin.store.general.CiudStore2',
                                    'Admin.store.general.CiudStore3',
                                    'Admin.store.general.CiudStore4',
                                    'Admin.combo.CbEps',
                                    'Admin.combo.CbEstrato',
                                    'Admin.combo.CbSisben',
                                    'Admin.combo.CbZona',
                                    'Admin.combo.CbEtnias',
                                    'Admin.combo.CbResguardos',
                                    'Admin.combo.CbPoblacionVictimaCon',
                                    'Admin.combo.CbTipoDiscapacidad',
                                    'Admin.combo.CbCapacidadesExcepcionales',
                                    'Admin.combo.CbDesicion',
                                    'Admin.store.inscripciones.InscripcionesStore'
                                ]);
                                Ext.onReady(function() {
                                    me.onStore('inscripciones.InscripcionesStore');
                                    me.onStore('general.DocumentosStore');
                                    me.onStore('general.DptosStore');
                                    me.onStore('general.CiudStore');
                                    me.onStore('general.CiudStore4');
                                    me.onStore('general.CiudStore2');
                                    me.onStore('general.CiudStore3');
                                    me.onStore('general.SexoStore');
                                    me.onStore('general.RHStore');
                                    me.onStore('general.EstratoStore');
                                    me.onStore('general.EPSStore');
                                    me.onStore('general.SisbenStore');
                                    me.onStore('general.ZonaStore');
                                    me.onStore('general.EtniasStore');
                                    me.onStore('general.ResguardosStore');
                                    me.onStore('general.PoblacionVictimaConStore');
                                    me.onStore('general.TipoDiscapacidadStore');
                                    me.onStore('general.CapacidadesExcepcionalesStore');
                                    me.onStore('docentes.observador.DesicionStore');
                                    me.onStore('general.SedesStore');
                                    me.onStore('general.GradosStore');
                                    me.onStore('general.GrupoStore');
                                    me.onStore('general.JornadasStore');
                                    extra = {
                                        pdbTable    : 'inscripciones',
                                        pdbId       : globales.General.DbConfig.cod_est
                                    };
                                    me.setParamStore('InscripcionesStore',extra,false);
                                    store   = Ext.getStore('InscripcionesStore');
                                    store.load({
                                        scope: this,
                                        callback: function(records, operation, success) {
                                            if (records.length == 1){
                                                win = me.getWindow('Edición de datos personales', 'Admin.view.estudiantes.EditarInscripcionView');
                                                var
                                                    form    = win.down('form');
                                                form.loadRecord(records[0]);
                                                win.down('#FsMatricula').setHidden(true);
                                                win.down('#comboSedes').allowBlank = true;
                                                win.down('#comboJornadas').allowBlank = true;
                                                win.down('#comboGrados').allowBlank = true;
                                                win.down('#comboGrupo').allowBlank = true;
                                                win.show();
                                            }
                                            me.onMsgClose();
                                        }
                                    });
                                });
                            }
                        },
                        {
                            ui      : 'soft-purple',
                            iconCls : 'x-fa fa-book',
                            text    : 'Documentos digitales',
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
                            }
                        }
                    ]
                }
            ]
        }
    ],
    listeners   : {
        afterrender : function (pn) {
            var
                me          = globales.General.DbConfig,
                gn          = globales.General;
            if (me) {
                foto        = me.foto;
                mime        = me.mime;
                sexo        = me.sexo;

                avatarEmpty  = sexo  === "M" ? gn.avatarMan : gn.avatarWomen;

                if(Ext.isEmpty(foto)) {
                    imgUrl  = avatarEmpty;
                }else{
                    imgUrl	= foto;
                }

                pn.down('#ImgPerfil').setSrc(imgUrl);
                pn.down('#labelName').setHtml(gn.userData);
                pn.down('#labelSede').setHtml('SEDE: '+me.sede);
                pn.down('#labelCurso').setHtml('CURSO: '+me.grado+' - '+me.grupo);
                pn.down('#labelJorn').setHtml('JORNADA: '+me.jornada);
            }
        }
    }
});
