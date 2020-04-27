/**
 * Created by LOPEZSOFT on 25/01/2016.
 */
Ext.define('Admin.view.estudiantes.EvaluacionesEstudiantesView',{
    extend	: 'Admin.base.WindowCrud',
    requires: [
        'Admin.view.docs.VideoView',
        'Admin.store.estudiantes.EvaluacionesEstudiantesStore',
        'Admin.grid.CustomGrid'
    ],
    title	: 'Evaluaciones',
    alias 	: 'widget.EvaluacionesEstudiantesView',
    controller  : 'estudiantes',
    maximized   : true,
    items   : [
        {
            xtype       : 'customgrid',
            store		: 'EvaluacionesEstudiantesStore',
            iconCls     : '',
            selModel	: 'rowmodel',
            plugins		: [
                {
                    ptype			: 'gridSearch',
                    readonlyIndexes	: ['note'],
                    disableIndexes	: ['pctChange'],
                    minChars		: 1,
                    mode            : 'local',
                    flex			: 1,
                    autoFocus		: false,
                    independent		: true
                }
            ],
            // Reusable actions
            actions: {
                leer: {
                    iconCls: 'x-fa fa-eye',
                    tooltip: 'Responder evaluación',
                    handler: function (grid, rowIndex, colIndex) {
                        var rec = grid.getStore().getAt(rowIndex),
                            app = Admin.getApplication();
                        Ext.require('Admin.view.docs.VideoView');
                        Ext.onReady(function () {
                            var
                                gb      = globales.General,
                                socket  = gb.getSocket(),
                                dt  = new Date();
                            socket.emit('sql-query',{
                                cSql    : 'select CURDATE() fecha_sis,CURRENT_TIME() hora_sis'
                            });
                            socket.on('receiveSqlQuery',function (data) {
                                if (data.length > 0){
                                    socket  = gb.getSocket();
                                    var hoy     = Ext.Date.format(dt, 'Y-m-d'),
                                        hora    = Ext.Date.format(dt, 'g:i A'),
                                        db      = data[0],
                                        dts     = new Date(db.fecha_sis),
                                        hoyS    = Ext.Date.format(dts, 'Y-m-d'),
                                        contunue= false;
                                    if (hoy == hoyS){
                                        if (hoyS > rec.get('fecha_cierre')){
                                            app.onError('La fecha se ha vencido.')
                                        }else {
                                            contunue    = true;
                                        }
                                        if (contunue){
                                            socket.emit('sql-query-select',{
                                                cFields     : 'COUNT(intento) total ',
                                                cTable      : 'te_evaluaciones_estudiantes',
                                                cWhereFields: 'id_evaluacion_compartida = ? ',
                                                cWhereValues: [rec.get('id')]
                                            });
                                            socket.on('receiveSqlQuerySelect',function (d, e) {
                                                if (d) {
                                                    if (d.length > 0) {
                                                        var val   = d[0].total;
                                                        win     = Ext.create('Admin.view.docs.VideoView',{
                                                            height  : 250,
                                                            width   : 350,
                                                            title   : rec.get('nombre'),
                                                            alwaysOnTop	: false,
                                                            items   :[
                                                                {
                                                                    xtype   : 'form',
                                                                    items   : [
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
                                                                                    html    : 'Intentos permitidos: '+rec.get('intentos')
                                                                                },
                                                                                {
                                                                                    xtype   : 'label',
                                                                                    cls     : 'widget-name-text',
                                                                                    html    : 'Limite de tiempo: '+rec.get('tiempo')+' minutos'
                                                                                },
                                                                                {
                                                                                    xtype   : 'label',
                                                                                    cls     : 'widget-name-text',
                                                                                    html    : 'Intentos realizados: '+val.toString()
                                                                                },
                                                                                {
                                                                                    xtype   : 'toolbar',
                                                                                    cls     : 'widget-tool-button',
                                                                                    flex    : 1,
                                                                                    items   : [
                                                                                        {
                                                                                            ui      : 'soft-purple',
                                                                                            iconCls : 'x-fa fa-check-square-o',
                                                                                            text    : 'Responder evaluación',
                                                                                            disabled: val < rec.get('intentos') ? false : true,
                                                                                            handler : function (btn) {
                                                                                                Ext.require('Admin.view.docs.ResponseView');
                                                                                                Ext.onReady(function () {
                                                                                                    var
                                                                                                        win = Ext.create({
                                                                                                            xtype     : 'ResponseView',
                                                                                                            listeners : {
                                                                                                                cancel   : function (me) {
                                                                                                                    var
                                                                                                                        form     = me.down('form'),
                                                                                                                        values   = form.getValues();
                                                                                                                    console.log(values);
                                                                                                                }
                                                                                                            }
                                                                                                        });
                                                                                                    win.intentos = val + 1;
                                                                                                    win.show();
                                                                                                    win.recordValues(rec);
                                                                                                    btn.up('window').close();
                                                                                                });
                                                                                            }
                                                                                        }
                                                                                    ]
                                                                                }
                                                                            ]
                                                                        }
                                                                    ]
                                                                }
                                                            ]
                                                        });
                                                        win.show();
                                                    }
                                                }
                                            });
                                        }
                                    }else{
                                        app.onError('La fecha de su computador está mal configurada.')
                                    }
                                }
                            });

                        });
                        if (!rec.get('leida')) {
                            rec.set('leida',1);
                            grid.getStore().sync({
                                success : function (r, o) {
                                    var
                                        gb      = globales.General,
                                        socket  = gb.getSocket(),
                                        view    = Admin.getApplication().getMainView(),
                                        btn     = view.down('#btnEval');
                                    socket.emit('sql-query-select',{
                                        cFields     : 'COUNT(id_evaluacion) total ',
                                        cTable      : 'te_evaluacion_compartida',
                                        cWhereFields: 'id_matric = ? AND leida = ? ',
                                        cWhereValues: [rec.get('id_matric'),0]
                                    });
                                    socket.on('receiveSqlQuerySelect',function (d, e) {
                                        if (d) {
                                            if (d.length > 0) {
                                                var val   = d[0].total;
                                                if (val > 0 ){
                                                    cls  = 'x-btn-badgeCls';
                                                }else {
                                                    cls  = 'x-btn-badgeCls-green';
                                                }
                                                btn.setBadgeCls(cls);
                                                btn.setBadgeText(val.toString());
                                            }
                                        }
                                    });
                                }
                            });
                        }
                    }
                }
            },
            viewConfig: {
                getRowClass: function(record) {
                    return record.get('leida') == 1 ? 'letter-row' : 'no-letter-row';
                }
            },
            columns	: [
                {
                    xtype	: 'customrownumberer'
                },
                {
                    menuDisabled    : true,
                    sortable        : false,
                    xtype       : 'actioncolumn',
                    width       : 30,
                    items       : ['@leer']
                },
                {
                    text        : 'Nombre',
                    width       : 300,
                    dataIndex   : 'nombre'
                },
                {
                    text        : 'Per',
                    width       : 45,
                    dataIndex   : 'periodo'
                },
                {
                    text 		: 'Fecha cierre',
                    width 		: 115,
                    dataIndex	: 'fecha_cierre'
                },
                {
                    text 		: 'Hora cierre',
                    width 		: 115,
                    dataIndex	: 'hora_cierre'
                },
                {
                    text 		: 'Grado',
                    width 		: 120,
                    dataIndex	: 'grado'
                },
                {
                    text 		: 'Grupo',
                    width 		: 60,
                    dataIndex	: 'grupo'
                },
                {
                    text 		: 'Jornada',
                    width 		: 100,
                    dataIndex	: 'jornada'
                },
                {
                    text 		: 'Asignatura',
                    width 		: 300,
                    dataIndex	: 'asignatura'
                },
                {
                    text 		: 'Docente',
                    width 		: 300,
                    dataIndex	: 'docente'
                },
                {
                    text 		: 'Sede',
                    width 		: 300,
                    dataIndex	: 'sede'
                }
            ],
            dockedItems: [
                {
                    xtype 		: 'pagination',
                    itemId		: 'pToolbar'
                },
                {
                    xtype       : 'customToolbar',
                    items       : [
                        '->',
                        {
                            xtype   : 'customButton',
                            iconCls : 'x-fa fa-history',
                            text    : 'Historial',
                            itemId  : 'btnHistory',
                            disabled: true,
                            handler : function (btn) {
                                var
                                    app = Admin.getApplication(),
                                    rec = btn.up('grid').getSelection()[0];
                                Ext.require('Admin.view.estudiantes.EvaluacionesHistorialEstudiantesView');
                                Ext.onReady(function () {
                                    param = {
                                        pdbTable    : 'te_evaluaciones_estudiantes',
                                        pdbIdEva    : rec.get('id')
                                    };
                                    app.onStore('estudiantes.EvaluacionesHistorialEstudiantesStore');
                                    app.setParamStore('EvaluacionesHistorialEstudiantesStore',param,false);
                                    win = app.getWindow('Hirtorial: '+rec.get('nombre'),'Admin.view.estudiantes.EvaluacionesHistorialEstudiantesView');
                                    win.show();
                                });
                            }
                        },'-',
                        {
                            xtype   : 'closebutton'
                        }
                    ]
                }
            ]
        }
    ]
});
