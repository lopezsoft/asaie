Ext.define('Admin.view.estudiantes.controller.EstudiantesController',{
    extend  : 'Admin.base.BaseController',
    alias   : 'controller.estudiantes',
    init: function() {
        me  = this;
        me.setConfigVar();
    },

    onCommentsActivities : function(grid, rowIndex){
        let
            record      = grid.getStore().getAt(rowIndex),
            items       = [],
            img         = record.get('image') ? rec.get('image') : Global.getAvatarUnknoun(),
            docente     = record.get('docente'),
            asignatura  = record.get('asignatura'),
            app         = Admin.getApplication(),
            view        = app.getMainView();
        if(view){
            app.setParamStore('CommentsActivitiesStore',{
                id  : record.get('id')
            });
            cont    = view.getController();
            cont.onRemove('commentsactivities');
            items.push(
                {
                    xtype       : 'form',
                    bodyPadding : 5,
                    ui          : 'panel-white', 
                    items   : [
                        {
                            xtype   : 'container',
                            height  : 82,
                            layout  : {
                                type    : 'hbox',
                                align   : 'stretch'
                            },
                            bodyCls     : 'statistics-body shadow',
                            items: [
                                {
                                    xtype   : 'image',
                                    itemId  : 'userImage',
                                    cls     : 'email-sender-img',
                                    src     : img,
                                    height  : 80,
                                    width   : 80
                                },
                                {
                                    xtype   : 'component',
                                    flex    : 1,
                                    cls     : 'single-mail-email-subject',
                                    itemId  : 'emailSubjectContainer',
                                    padding : 10,
                                    html:
                                        '<div class="user-name-d">'+docente+'</div>'+
                                        '<div class="user-info-d">'+asignatura+' - '+record.get('jornada')+'</div>'+
                                        '<div class="user-info-d">'+record.get('grado')+' - '+record.get('grupo')+'</div>'+
                                        '<div class="user-info-d">'+record.get('sede')+'</div>'
                                }
                            ]
                        },
                        {
                            xtype   : 'box',
                            cls     : 'mail-body',
                            html    :
                            '<br>'+
                            '<div class="user-name-d">'+record.get('nombre')+'</div>'+
                            '<div class="user-info-d">'+record.get('descripcion')+'</div>'
                        }
                    ],
                    bbar : [
                        '->',
                        {
                            xtype       : 'custombutton',
                            iconCls     : 'fas fa-comments',
                            text        : 'Responder',
                            handler     : function(){
                                Ext.create('Admin.view.general.SendFeedback',{
                                    title   : 'Agregar comentario a la actividad', 
                                    params  : {
                                        id          : record.get('id'), // Id de al actividad compartida
                                        activity_id : record.get('activity_id'), // Id de la actividad sin cursos a principal
                                        course_id   : record.get('course_id') // Id del curso al que pertence al actividad
                                    },  
                                    url     : Global.getUrlBase() +  'students/commentsactivities'
                                }).show().on('closed', function(me){
                                    if(me){
                                        me.close();
                                        Ext.getStore('CommentsActivitiesStore').reload();
                                    }
                                });
                            }
                        }
                    ]
                },
                {
                    xtype   : 'viewcommentsactivities'
                }
            );
            newView = Ext.create({
                xtype           : 'commentsactivities',
                routeId         : 'commentsactivities',
                activityId      : record.get('id'),
                newItems        : items,
                activityName    : record.get('nombre'),
                hideMode        : 'offsets'
            });
            cont.setChangeCurrentView('commentsactivities',newView);
        }
    },

    onConstancias : function (btn) {
        var me   = this.app,
            win  = null,
            gb  = Global;
        me.onMsgWait();
        Ext.require([
            'Admin.view.estudiantes.ConstanciasEstView'
        ]);

        Ext.onReady(function () {
            me.onMsgClose();
            win     = me.getWindow('Constancia de estudio - '+gb.year,'Admin.view.estudiantes.ConstanciasEstView');
            win. show();
        });
    },

    onBoletin : function (btn) {
        var me   = this.app,
            win  = null,
             gb  = Global;
        me.onMsgWait();
        Ext.require([
            'Admin.view.estudiantes.BoletinEstView'
        ]);

        Ext.onReady(function () {
            me.onStore('general.PeriodosStore');
            me.onMsgClose();
            win     = me.getWindow('Boletines - '+gb.year,'Admin.view.estudiantes.BoletinEstView');
            win. show();
        });
    },

    onViewPerfil   : function () {
        var me   = this.app,
            win  = null,
            form = null;

        Ext.require([
            'Admin.store.estudiantes.perfil.PerfilEstudiantesStore',
            'Admin.view.estudiantes.perfil.PerfilEstudianteView'
        ]);

        Ext.onReady(function () {
            me.onStore('estudiantes.perfil.PerfilEstudiantesStore');
            var  cStore   = Ext.getStore('PerfilEstudiantesStore');

            cStore.reload({
                callback: function(records) {

                    win     = me.getWindow('Perfil del estudiante','Admin.view.estudiantes.perfil.PerfilEstudianteView');

                    form    = win.down('form');
                    form.loadRecord(records[0]);

                    win. show();
                }
            });
        });
    },
    onSavePerfil    : function (btn) {
        var win     = btn.up('window'),
            form    = win.down('form'),
            record  = form.getRecord(),
            values  = form.getValues(),
            data    = [],
            store   = Ext.getStore('PerfilEstudiantesStore'),
            me      = this;
        if (!Ext.isEmpty(values.password_u) && !Ext.isEmpty(values.pasw2)){
            var
                p1      = globales.General.sha1.hash(values.password_u),
                p2      = globales.General.sha1.hash(values.pasw2);
        };

        if (p1 === p2) {
            data = {
            };

            values.password_u   = p1;
            values.pasw2        = p2;
            me.onDataSave(record, values, store, data, win);
            win.close();
        }else{
            Ext.Msg.alert('Las contraseñas no coinciden');
        }
    },
    viewNotes : function (btn) {
        let app     = Admin.getApplication(),
            win 	= btn.up('panel'),
            form	= win.down('form'),
            grid	= null,
            gb      = Global,
            socket  = gb.getSocket();
            me		= this,
            columns = [];
        socket.emit('querySelect',{
            dataName    : gb.getDbName(),
            fields      : "a.*, CONCAT('n',b.numero_column) col_name, b.tipo",
            table       : 'competencias a LEFT JOIN columnas_notas_competencias AS b ON b.id_competencia = a.id_pk',
            where       : 'a.year = ? AND a.calificable = ?  AND b.tipo = ? ',
            values      : [gb.getYear(),1, 'PORC']
        },(err, res)=>{
            if(err){
                app.showResult('Error en el servidor','error');
            }else{
                columns = [
                    {
                        xtype       : 'customrownumberer'
                    },
                    {
                        text        : 'Asignaturas',
                        dataIndex   : 'asignatura',
                        width       : 300,
                        menuDisabled: true,
                        sortable    : true
                    },
                    {
                        text        : 'Prom',
                        dataIndex   : 'prom',
                        menuDisabled: true,
                        width       : 60
                    },
                    {
                        text        : 'P',
                        dataIndex   : 'periodo',
                        tooltip     : 'periodo',
                        menuDisabled: true,
                        width       : 40
                    }
                ];
                res.forEach(ele => {
                    let data    = {
                        text        : ele.competencia + ' ' + ele.porcentaje + ' %',
                        tooltip     : ele.competencia + ' ' + ele.porcentaje + ' %',
                        menuDisabled: true,
                        defaults    : {
                            width               : 77,
                            align               : 'right',
                            menuDisabled        : true,
                            cellWrap            : true,
                            headerWrap          : true,
                            variableRowHeight   : true,
                            sortable            : true
                        },
                        columns: [
                            {
                                text        : 'NOTA',
                                dataIndex   : ele.col_name,
                                renderer: function (val) {
                                    return '<span style="color:Darkviolet;"> <b>' + val + '</b></span>'
                                }
                            }
                        ]
                    };
                    columns.push(data);
                    // let 
                    //     xsocket     = Global.getSocket();
                    // xsocket.emit('querySelect',{
                    //     dataName    : gb.getDbName(),
                    //     fields      : "CONCAT('n',a.numero_column) col_name",
                    //     table       : 'columnas_notas_competencias a',
                    //     where       : 'a.id_competencia = ? AND a.tipo = ? ',
                    //     values      : [ele.id_pk, 'PROM']
                    // },(err, res)=>{
                    //     console.log(res);
                    //     if(res){
                    //         if(res.length > 0){
                    //             data.columns.push({
                    //                 text        : '%',
                    //                 dataIndex   : res[0].col_name,
                    //                 renderer: function (val) {
                    //                     return '<span style="color:red;"> <b>' + val + '</b></span>'
                    //                 }
                    //             });
                    //             columns.push(data);
                    //         }
                    //     }
                    // });
                });

                columns.push(
                    {
                        text        : 'FINAL',
                        dataIndex   : 'final',
                        menuDisabled: true,
                        align       : 'right',
                        summaryType : 'average',
                        summaryRenderer: function (value) {
                            return 'PROM: ' + value.toFixed(2).toString();
                        },
                        renderer: function (val) {
                            return '<span style="color:red;"> <b>' + val + '</b></span>'
                        }
                    },
                    {
                        text        : 'Desempeño',
                        width       : 100,
                        menuDisabled: true,
                        dataIndex   : 'nombre_escala',
                        tooltip     : 'Escala de desempeño',
                        renderer: function (val) {
                            switch (val.trim()) {
                                case 'BAJO':
                                    return '<span style="color:red;"> <b>' + val.trim() + '</b></span>';
                                    break;
                                case 'BÁSICO':
                                    return '<span style="color:green;"> <b>' + val.trim() + '</b></span>';
                                    break;
                                case 'ALTO':
                                    return '<span style="color:Darkviolet;"> <b>' + val.trim() + '</b></span>';
                                    break;
                                case 'SUPERIOR':
                                    return '<span style="color:Steelblue;"> <b>' + val.trim() + '</b></span>';
                                    break;
                            }

                            return val;
                        }
                    },
                    {
                        text: 'FALTAS',
                        menuDisabled: true,
                        defaults: {
                            width: 77,
                            align: 'right',
                            menuDisabled: true,
                            cellWrap: true,
                            headerWrap: true,
                            variableRowHeight: true,
                            sortable: true
                        },
                        columns: [
                            {
                                text        : 'J',
                                dataIndex   : 'faltas',
                                tooltip     : 'Faltas Justifcadas',
                                summaryType : 'sum',
                                summaryRenderer: function (value) {
                                    return 'T: ' + value.toString();
                                }
                            },
                            {
                                text        : 'I',
                                dataIndex   : 'injustificadas',
                                tooltip     : 'Faltas Injustifcadas',
                                summaryType : 'sum',
                                summaryRenderer: function (value) {
                                    return 'T: ' + value.toString();
                                }
                            },
                            {
                                text        : 'R',
                                dataIndex   : 'retraso',
                                tooltip     : 'Faltas por llegada tarde a clase',
                                summaryType : 'sum',
                                summaryRenderer: function (value) {
                                    return 'T: ' + value.toString();
                                }
                            }
                        ]
                    }
                );
                /**/
                grid = new Ext.create('Admin.grid.CustomGrid', {
                    itemId      : 'grid1',
                    store       : 'NotasEstudiantesStore',
                    plugins: [
                        {

                            ptype: 'gridSearch',
                            readonlyIndexes: ['note'],
                            disableIndexes: ['pctChange'],
                            minChars: 1,
                            mode: 'local',
                            flex: 1,
                            autoFocus: true,
                            independent: true
                        }
                    ],
                    multiColumnSort: false,
                    features: [{
                        ftype: 'groupingsummary',
                        startCollapsed: true,
                        groupHeaderTpl: 'Periodo: {name} ({rows.length} Asignatura{[values.rows.length > 1 ? "s" : ""]})'
                    }],
                    columns: columns
                });
                form.remove('grid1', true);
                form.add(grid);
                socket.close();
            }
        });
    },
    onDocument : function (grid, rowIndex) {
        let
            rec     = grid.getStore().getAt(rowIndex),
            app     = Admin.getApplication(),
            socket  = Global.getSocket();
        if (Ext.isEmpty(rec.get('url_archivo'))) {
            app.showResult('No hay documento adjunto');
        }else {
            this.onViewDocument(rec.get('url_archivo'),rec.get('mime'));
              
            socket.emit('insertData',{
                dataName    : Global.getDbName(),
                table       : 'ta_online_activities_history',
                values      : {
                    shared_activity_id  : rec.get('id'),
                    url_archivo         : rec.get('url_archivo')
                }
            },(err, res, id)=>{
                if(err){
                    app.showResult('Error en el servidor.','error');
                    return;
                };
                socket.emit('updateData',{
                    dataName    : Global.getDbName(),
                    table       : 'ta_online_activities_history',
                    values      : [{
                        url_archivo : rec.get('url_archivo')
                    },{
                        id  : id
                    }]
                },(err, res)=>{
                    if(err){
                        app.showResult('Error en el servidor.','error');
                    };
                });
            });
        }
    },
    onVideo : function (grid, rowIndex, colIndex) {
        let 
            rec = grid.getStore().getAt(rowIndex),
            app = Admin.getApplication();
        if (Ext.isEmpty(rec.get('url_video'))) {
            app.showResult('No hay video adjunto');
        }else {
            let
                socket  = Global.getSocket(),
                xUrl    = rec.get('url_video'),
                retVal  = false,
                yt      = "https://www.youtube.com",
                rExp    = new RegExp(yt);
            rExp.exec(yt);
            retVal  = rExp.test(xUrl);
            if(retVal){ // Video en youtbe
                var
                    newUrl= xUrl.replace('watch?v=','embed/');
                cHtml ='<iframe width="100%" height="100%" src="'+newUrl+'?&autoplay=1" cc_load_policy=1 frameborder="0" allowfullscreen></iframe>';
            }else{
                var
                    cHtml  = '<object><embed  width="100%" height="100%" src="'+xUrl+'"></object>';
            }
            socket.emit('insertData',{
                dataName    : Global.getDbName(),
                table       : 'ta_online_activities_history',
                values      : {
                    shared_activity_id  : rec.get('id'),
                    url_video           : rec.get('url_video')
                }
            },(err, res, id)=>{
                if (err){
                    app.showResult('Error en el servidor.','error');
                }else {
                    Ext.create('Admin.view.docs.VideoView',{
                        html        : cHtml,
                        listeners   : {
                            cancel : function (me) {
                                xsocket  = Global.getSocket();
                                xsocket.emit('updateData',{
                                    dataName    : Global.getDbName(),
                                    table       : 'ta_online_activities_history',
                                    values      : [{
                                        url_video : rec.get('url_video')
                                    },{
                                        id  : id
                                    }]
                                },(err)=>{
                                    console.log(err);
                                });
                            }
                        }
                    }).show();
                }
            });
        }
    },
    onUrl : function (grid, rowIndex, colIndex) {
        let
            rec     = grid.getStore().getAt(rowIndex),
            app     = Admin.getApplication();
        if (Ext.isEmpty(rec.get('url_enlace'))) {
            app.showResult('No hay enlace adjunto');
        }else {
            let
                xUrl    = rec.get('url_enlace'),
                socket  = Global.getSocket(),
                cHtml   = '<object><embed  width="100%" height="100%" src="'+xUrl+'"></object>';
            socket.emit('insertData',{
                dataName    : Global.getDbName(),
                table       : 'ta_online_activities_history',
                values      : {
                    shared_activity_id  : rec.get('id'),
                    url_enlace          : rec.get('url_enlace')
                }
            },(err, res, id)=>{
                if(err){
                    app.showResult('Error en el servidor','error');
                    return;
                }
                Ext.create('Admin.view.docs.VideoView',{
                    title 	: 'Vista previa del enlace',
                    html  	: cHtml,
                    width   : 700,
                    height  : 550,
                    listeners : {
                        cancel : function (me) {
                            xsocket  = Global.getSocket();
                            xsocket.emit('updateData',{
                                dataName    : Global.getDbName(),
                                table       : 'ta_online_activities_history',
                                values      : [{
                                    url_enlace : rec.get('url_enlace')
                                },{
                                    id  : id
                                }]
                            },(err, res)=>{
                                console.log(err);
                            });
                        }
                    }
                }).show();
                app.onOpenUrl(xUrl);
            });
        }
    },

    /**
     * Funcion para setear los datos que se enviar al servidor para lamar el reporte.
     * @param btn
     */
    onSetReport: function(btn){
        var
            win     = btn.up('window'),
            gb      = Global.dbConfig,
            grid    = win.down('grid'),
            name    = win.getItemId();
        switch (name){
            case 'ConstanciasEstView' :
                var
                    url     = 'reports/report_constancias',
                    rbVal   = win.down('form').getValues(),
                    param   = {
                        pdbGrado    : gb.cod_grado,
                        pdbGrupo    : gb.grupo,
                        pdbJorn     : gb.id_jorn,
                        pdbMatric   : gb.id_matric,
                        pdbSede     : gb.id_sede,
                        pdbType     : rbVal.modelo,
                        pdbEstudian : gb.nombre1+ ' '+gb.apellido1
                    };
                break;
            default :
                var
                    url     = 'reports/report_boletin',
                    values  = win.down('form').getValues(),
                    param   = {
                        pdbCodGrado : gb.cod_grado,
                        pdbIdJorn   : gb.id_jorn,
                        pdbGrupo    : gb.grupo,
                        pHojaReport : values.hoja,
                        pTypeReport : values.id_report,
                        pdbIdSede   : gb.id_sede,
                        pdbPeriodo  : values.periodo,
                        pdbMatric   : gb.id_matric
                    };

                break;
        }
        this.onGenReport(btn,url,param);
    }
});
