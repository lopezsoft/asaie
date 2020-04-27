/**
 * Created by LOPEZSOFT on 8/03/2016.
 */
Ext.define('Admin.view.estudiantes.controller.EstudiantesController',{
    extend  : 'Admin.base.BaseController',
    alias: 'controller.estudiantes',
    init: function() {
        me  = this;
        me.setConfigVar();
        me.control({
            'PerfilEstudianteView button#btnSave' : {
                'click' : this.onSavePerfil
            },
            'EditarInscripcionView button#btnSave' : {
                click : this.onSaveInscripciones
            }
        });
    },

    onConstancias : function (btn) {
        var me   = this.app,
            win  = null,
            gb  = SME.ConfigApp;
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
             gb  = SME.ConfigApp;
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

    onNavigationTreeSelectionChange: function (tree, node) {
        var selection   = null,
            refs        = Ext.ComponentQuery.query('Estudiantes')[0].getReferences(),
            queryComp   = refs.mainCardPanel,
            nItemsComp  = queryComp.items.length,
            itemsAdd    = {},
            path,
            treelist    = refs.navigationTreeList;
        if (node) {
            selection = node.get('itemId')
        }
        queryComp.el.mask(AppLang.getSMsgLoading());
        if (selection) {
            path    =   selection;
            if (!Ext.isEmpty(path)) {
                if (nItemsComp > 0) {
                    queryComp.removeAll(true);
                }
                switch (path) {
                    case 'btnCarga' :
                        var
                            me   = Admin.getApplication();
                        Ext.require([
                            'Admin.view.estudiantes.NotasEstudiantesView'
                        ]);
                        Ext.onReady(function(){
                            me.onStore('estudiantes.NotasEstudiantesStore');
                            queryComp.el.unmask();
                            itemsAdd = {
                                xtype   : 'NotasEstudiantesView'
                            };
                        });
                        break;
                    case 'btnLogros' :

                        Ext.onReady(function(){
                            me   = Admin.getApplication();
                            queryComp.el.unmask();
                            itemsAdd = {
                                xtype   : ''
                            };
                        });
                        break;
                    case 'btnSugerencias' :

                        Ext.onReady(function(){
                            me   = Admin.getApplication();
                            itemsAdd = {
                                xtype   : ''
                            };
                        });

                        break;
                    case 'btnMejoramiento' :
                        Ext.require([
                            'Admin.view.estudiantes.menu.PanelMejoramientoEstudiantesView'
                        ]);
                        Ext.onReady(function(){
                            queryComp.el.unmask();
                            itemsAdd = {
                                xtype   : 'PanelMejoramientoEstudiantesView'
                            };
                        });
                        break;
                    case 'btnReportes' :
                        Ext.require([
                            'Admin.view.estudiantes.menu.PanelReportEstudiantesView'
                        ]);
                        Ext.onReady(function(){
                            me   = Admin.getApplication();
                            queryComp.el.unmask();
                            itemsAdd = {
                                xtype   : 'PanelReportEstudiantesView'
                            };
                        });
                        break;
                    case 'btnSeguimiento' :

                        Ext.require([
                            'Admin.view.estudiantes.menu.PanelSeguimientoEstudiantesView'
                        ]);

                        Ext.onReady(function(){

                            queryComp.el.unmask();
                            itemsAdd = {
                                xtype   : 'PanelSeguimientoEstudiantesView'
                            };

                        });
                        break;
                    case 'btnActividades' :
                        Ext.require([
                            'Admin.view.estudiantes.menu.PanelActividadesEstudiantesView'
                        ]);

                        Ext.onReady(function(){
                            queryComp.el.unmask();
                            itemsAdd = {
                                xtype   : 'PanelActividadesEstudiantesView'
                            };
                        });
                        break;
                    default :
                        queryComp.el.unmask();
                        itemsAdd = {
                            xtype   : 'PanelContainerEstudiantesView'
                        };
                        treelist.setSelection(0);
                        break
                }
                Ext.onReady(function() {
                    queryComp.add(itemsAdd);
                });
            }
        }
        else{
            queryComp.el.unmask();
        }

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
    onToolBarChange: function (btn) {
        var selection = btn.itemId,
            queryComp   = Ext.ComponentQuery.query('Estudiantes')[0].lookupReference('mainCardPanel'),
            nItemsComp  = queryComp.items.length,
            itemsAdd    = {},
            path,
            refs        = Ext.ComponentQuery.query('Estudiantes')[0].getReferences(),
            treelist    = refs.navigationTreeList;

        queryComp.el.mask(AppLang.getSMsgLoading());

        if (selection) {
            path    =   selection;
            treelist.setSelection(0);
            if (!Ext.isEmpty(path)) {

                if (nItemsComp > 0) {
                    queryComp.removeAll(true);
                }

                switch (path) {
                    case 'btnHome' :

                        Ext.onReady(function(){
                            queryComp.el.unmask();
                            me   = Admin.getApplication();
                            itemsAdd = {
                                xtype   : 'PanelContainerEstudiantesView'
                            };
                        });
                        break;
                    default :
                        queryComp.el.unmask();
                        itemsAdd = {

                        };
                        break
                }
                Ext.onReady(function() {
                    queryComp.add(itemsAdd);
                });
            }
        }
        else{
            queryComp.el.unmask();
        }
    },
    verNotas : function (view) {
        var win 	= view.up('panel'),
            form	= win.down('form'),
            grid	= null,
            c1		= '1',
            c2		= '2',
            c3		= '3',
            c4		= '4',
            gb      = SME.ConfigApp,
            socket  = gb.getSocket();
            me		= this;
        socket.emit('sql-query-select',{
            cFields : 'id_inst,year,competencia',
            cTable  : 'competencias',
            cWhereFields    : '`id_inst` = ? AND `year` = ? AND `tipo` = ? ',
            cWhereValues    : [gb.id_inst,gb.year,1]
        });
        socket.on('receiveSqlQuerySelect',function (data,e) {
            if (e) {
                me.app.onAler(e.code);
            }else {
                console.log(data);
                if (data.length > 0) {
                    c1 = data[1]['competencia']; // Nombre de la primera competencia o dimensión
                    c2 = data[2]['competencia']; // Nombre de la segunda competencia o dimensión
                    c3 = data[3]['competencia']; // Nombre de la tercera competencia o dimensión
                    c4 = data[4]['competencia']; // Nombre de la cuarta competencia o dimensión
                }
                /**/
                grid = new Ext.create('Admin.grid.CustomGrid', {
                    itemId: 'grid1',
                    maxHeight: 500,
                    title: 'Lista de notas',
                    store: 'NotasEstudiantesStore',
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
                    columns: [
                        {
                            xtype: 'customrownumberer'
                        },
                        {
                            text: 'Asignaturas',
                            dataIndex: 'asignatura',
                            width: 300,
                            menuDisabled: true,
                            sortable: true
                        },
                        {
                            text: 'Prom',
                            dataIndex: 'prom',
                            menuDisabled: true,
                            width: 60
                        },
                        {
                            text: 'Per',
                            dataIndex: 'periodo',
                            menuDisabled: true,
                            width: 45
                        },
                        {
                            text: c1,
                            tooltip: c1,
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
                                    text: 'NOTA',
                                    dataIndex: 'NOTAP1',
                                    renderer: function (val) {
                                        return '<span style="color:Darkviolet;"> <b>' + val + '</b></span>'
                                    }
                                },
                                {
                                    text: '%',
                                    dataIndex: 'P1',
                                    renderer: function (val) {
                                        return '<span style="color:red;"> <b>' + val + '</b></span>'
                                    }
                                }
                            ]
                        },
                        {
                            text: c2,
                            tooltip: c2,
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
                                    text: 'NOTA',
                                    dataIndex: 'NOTAP2',
                                    renderer: function (val) {
                                        return '<span style="color:Darkviolet;"> <b>' + val + '</b></span>'
                                    }
                                },
                                {
                                    text: '%',
                                    dataIndex: 'P2',
                                    renderer: function (val) {
                                        return '<span style="color:red;"> <b>' + val + '</b></span>'
                                    }
                                }
                            ]
                        },
                        {
                            text: c3,
                            tooltip: c3,
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
                                    text: 'NOTA',
                                    dataIndex: 'NOTAP3',
                                    renderer: function (val) {
                                        return '<span style="color:Darkviolet;"> <b>' + val + '</b></span>'
                                    }
                                },
                                {
                                    text: '%',
                                    dataIndex: 'P3',
                                    renderer: function (val) {
                                        return '<span style="color:red;"> <b>' + val + '</b></span>'
                                    }
                                }
                            ]
                        },
                        {
                            text: c4,
                            tooltip: c4,
                            hidden: Ext.isEmpty(c4) ? true : false,
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
                                    hidden: Ext.isEmpty(c4) ? true : false,
                                    text: 'NOTA',
                                    dataIndex: 'n1P4'
                                },
                                {
                                    hidden: Ext.isEmpty(c4) ? true : false,
                                    text: '%',
                                    dataIndex: 'P4',
                                    renderer: function (val) {
                                        return '<span style="color:red;"> <b>' + val + '</b></span>'
                                    }
                                }
                            ]
                        },
                        {
                            text: 'FINAL',
                            dataIndex: 'final',
                            menuDisabled: true,
                            align: 'right',
                            summaryType: 'average',
                            summaryRenderer: function (value, summaryData, dataIndex) {
                                return 'PROM: ' + value.toFixed(2).toString();
                            },
                            renderer: function (val) {
                                return '<span style="color:red;"> <b>' + val + '</b></span>'
                            }
                        },
                        {
                            text: 'Desempeño',
                            width: 100,
                            menuDisabled: true,
                            dataIndex: 'conceptual',
                            tooltip: 'Escala de desempeño',
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
                                    text: 'J',
                                    dataIndex: 'faltas',
                                    tooltip: 'Ingrese las faltas Justifcadas',
                                    editor: {
                                        xtype: 'textfield',
                                        allowBlank: false,
                                        selectOnFocus: true,
                                        emptyText: '0',
                                        maskRe: /[\d\.]/
                                    },
                                    summaryType: 'sum',
                                    summaryRenderer: function (value, summaryData, dataIndex) {
                                        return 'T: ' + value.toString();
                                    }
                                },
                                {
                                    text: 'I',
                                    dataIndex: 'injustificadas',
                                    tooltip: 'Ingrese las faltas Injustifcadas',
                                    editor: {
                                        xtype: 'textfield',
                                        allowBlank: false,
                                        selectOnFocus: true,
                                        emptyText: '0',
                                        maskRe: /[\d\.]/
                                    },
                                    summaryType: 'sum',
                                    summaryRenderer: function (value, summaryData, dataIndex) {
                                        return 'T: ' + value.toString();
                                    }
                                },
                                {
                                    text: 'R',
                                    dataIndex: 'retraso',
                                    tooltip: 'Ingrese las faltas por llegada tarde a clase',
                                    editor: {
                                        xtype: 'textfield',
                                        allowBlank: false,
                                        selectOnFocus: true,
                                        emptyText: '0',
                                        maskRe: /[\d\.]/
                                    },
                                    summaryType: 'sum',
                                    summaryRenderer: function (value, summaryData, dataIndex) {
                                        return 'T: ' + value.toString();
                                    }
                                }
                            ]
                        }
                    ]
                });
                form.remove('grid1', true);
                form.add(grid);
            }
        });

    },
    onDocument : function (grid, rowIndex, colIndex) {
        var rec = grid.getStore().getAt(rowIndex);
        if (Ext.isEmpty(rec.get('url_archivo'))) {
            this.app.showResult('No hay documento adjunto');
        }else {
            this.onViewDocument(rec.get('url_archivo'),rec.get('mime'));
            var
                gb      = SME.ConfigApp,
                socket  = gb.getSocket(),
                id      = 0;
            socket.emit('sql-query-insert',{
                cTable  : 'historial_material_educ',
                cValues : {
                    id_material : rec.get('id_material'),
                    id_matric   : rec.get('id_matric'),
                    url_enlace  : rec.get('url_archivo')
                }
            });
            socket.on('receiveSqlQueryInsert',function (r, i, e) {
                if (e){
                    id  = 0;
                    me.onError('Error '+e.code);
                }else {
                    id  = i;
                    so  = gb.getSocket();
                    so.emit('sql-query-update',{
                        cTable  : 'historial_material_educ',
                        cValues : [{
                            url_enlace : rec.get('url_archivo')
                        },{
                            id  : id
                        }]
                    });
                }
            });
        }
    },
    onVideo : function (grid, rowIndex, colIndex) {
        var rec = grid.getStore().getAt(rowIndex);
        if (Ext.isEmpty(rec.get('url_video'))) {
            this.app.showResult('No hay video adjunto');
        }else {
            var
                gb      = SME.ConfigApp,
                socket  = gb.getSocket(),
                id      = 0,
                me      = this.app,
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
            var win	= Ext.create('Admin.view.docs.VideoView',{
                html    : cHtml,
                listeners : {
                    cancel : function (me) {
                        socket  = gb.getSocket();
                        socket.emit('sql-query-update',{
                            cTable  : 'historial_material_educ',
                            cValues : [{
                                url_enlace : rec.get('url_video')
                            },{
                                id  : id
                            }]
                        });
                    }
                }
            });
            socket.emit('sql-query-insert',{
                cTable  : 'historial_material_educ',
                cValues : {
                    id_material : rec.get('id_material'),
                    id_matric   : rec.get('id_matric'),
                    url_enlace  : rec.get('url_video')
                }
            });
            socket.on('receiveSqlQueryInsert',function (r, i, e) {
                if (e){
                    id  = 0;
                    win = null;
                    me.onError('Error '+e.code);
                }else {
                    id  = i;
                    win.show();
                }
            });
        }
    },
    onUrl : function (grid, rowIndex, colIndex) {
        var rec = grid.getStore().getAt(rowIndex);
        if (Ext.isEmpty(rec.get('url_enlace'))) {
            this.app.showResult('No hay enlace adjunto');
        }else {
            var
                xUrl    = rec.get('url_enlace'),
                gb      = SME.ConfigApp,
                socket  = gb.getSocket(),
                id      = 0,
                me      = this.app,
                cHtml   = '<object><embed  width="100%" height="100%" src="'+xUrl+'"></object>';
            var win	= Ext.create('Admin.view.docs.VideoView',{
                title 	: 'Vista previa del enlace',
                html  	: cHtml,
                width   : 700,
                height  : 550,
                listeners : {
                    cancel : function (me) {
                        socket  = gb.getSocket();
                        socket.emit('sql-query-update',{
                            cTable  : 'historial_material_educ',
                            cValues : [{
                                url_enlace : rec.get('url_enlace')
                            },{
                                id  : id
                            }]
                        });
                    }
                }
            });
            socket.emit('sql-query-insert',{
                cTable  : 'historial_material_educ',
                cValues : {
                    id_material : rec.get('id_material'),
                    id_matric   : rec.get('id_matric'),
                    url_enlace  : rec.get('url_enlace')
                }
            });
            socket.on('receiveSqlQueryInsert',function (r, i, e) {
                if (e){
                    id  = 0;
                    win = null;
                    me.onError('Error '+e.code);
                }else {
                    id  = i;
                    win.show();
                    me.onOpenUrl(xUrl);
                }
            });
        }
    },
    onSaveInscripciones : function (btn) {
        var win     = btn.up('window'),
            form    = win.down('form'),
            record  = form.getRecord(),
            values  = form.getValues(),
            data    = [],
            store   = Ext.getStore('InscripcionesStore'),
            me      = this,
            data = {
                nro_doc_id      : values.nro_doc_id,
                cod_doc         : values.cod_doc,
                dpto_lug_exp    : values.dpto_lug_exp,
                mun_lug_exp     : values.mun_lug_exp,
                apellido1       : values.apellido1,
                apellido2       : values.apellido2,
                nombre1         : values.nombre1,
                nombre2         : values.nombre2,
                tipo_sangre     : values.tipo_sangre,
                sexo            : values.sexo,
                fecha_nacimiento : values.fecha_nacimiento,
                edad            : values.edad,
                dpto_lug_nac    : values.dpto_lug_nac,
                mun_lug_nac     : values.mun_lug_nac,
                estrato         : values.estrato,
                sisben          : values.sisben,
                nro_sisben      : values.nro_sisben,
                puntaje_sisben  : values.puntaje_sisben,
                cab_familia     : values.cab_familia,
                ben_mad_flia    : values.ben_mad_flia,
                ben_vet_fp      : values.ben_vet_fp,
                ben_her_nan     : values.ben_her_nan,
                cod_eps         : values.cod_eps,
                IPS             : values.IPS,
                direccion       : values.direccion,
                telefono        : values.telefono,
                dpto_lug_res    : values.dpto_lug_res,
                mun_lug_res     : values.mun_lug_res,
                id_zona         : values.id_zona,
                dpto_lug_pobl   : values.dpto_lug_pobl,
                mun_lug_pobl    : values.mun_lug_pobl,
                proviene_sector_priv : values.proviene_sector_priv,
                proviene_otro_mun : values.proviene_otro_mun,
                tipo_discapacidad : values.tipo_discapacidad,
                cap_exc           : values.cap_exc,
                cod_etnia         : values.cod_etnia,
                cod_resgua        : values.cod_resgua,
                cod_flia_accion   : values.cod_flia_accion,
                // Matricula
                id_sede           : values.id_sede,
                cod_grado         : values.cod_grado,
                grupo             : values.grupo,
                id_jorn           : values.id_jorn
            };
        me.onDataSave(record, values, store, data, win);
        win.close();
    },

    /**
     * Funcion para setear los datos que se enviar al servidor para lamar el reporte.
     * @param btn
     */
    onSetReport: function(btn){
        var
            win     = btn.up('window'),
            gb      = SME.ConfigApp.dbConfig,
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
