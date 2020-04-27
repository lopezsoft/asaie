/**
 * Created by LOPEZSOFT on 2/02/2016.
 */
Ext.define('Admin.view.personero.controller.PersoneroController',{
    extend      : 'Admin.base.BaseController',
    alias       :'controller.personero',

    init    : function () {
        me  = this;

        me.setConfigVar();

        me.control({
            'PanelView  button#addButton' : {
                click   : this.onPanelCrud
            },

            'PanelView  button#editButton' : {
                click   : this.onPanelCrud
            },

            'PanelControlView  button#btnSave' : {
                click   : this.onPanelSave
            },

            'MesasVotacionView  button#addButton' : {
                click   : this.onMesasCrud
            },

            'MesasVotacionView  button#editButton' : {
                click   : this.onMesasCrud
            },

            'MesasVotacionSaveView  button#btnSave' : {
                click   : this.onMesasSave
            },

            'SedesAsignadasView  button#addButton' : {
                click   : this.onSedesCrud
            },

            'SedesAsignadasView  button#editButton' : {
                click   : this.onSedesCrud
            },

            'SedesAsignadasSaveView  button#btnSave' : {
                click   : this.onSedesSave
            },

            'JuradosView  button#addButton' : {
                click   : this.onJuradosCrud
            },

            'JuradosView  button#editButton' : {
                click   : this.onJuradosCrud
            },

            'JuradosSaveView  button#btnSave' : {
                click   : this.onJuradosSave
            },

            'CandidatosView  button#addButton' : {
                click   : this.onCandidatosCrud
            },

            'CandidatosView  button#editButton' : {
                click   : this.onCandidatosCrud
            },

            'CandidatosSaveView  button#btnSave' : {
                click   : this.onCandidatosSave
            },

            'CandidatosBlancoSaveView  button#btnSave' : {
                click   : this.onCandidatosSave
            },

            'CandidaturasCrudView  button#addButton' : {
                click   : this.onCandidaturasView
            },
            'CandidaturasCrudView  button#editButton' : {
                click   : this.onCandidaturasView
            },

            'CandidaturaView  button#btnSave' : {
                click   : this.onCandidaturasSave
            },
            'GradosSedesAsignadasCrudView  button#addButton' : {
                click   : this.onCreateGradosMesaView
            },
            'GradosSedesAsignadasCrudView  button#editButton' : {
                click   : this.onCreateGradosMesaView
            },
            'GradosSedesAsignadasView  button#btnSave' : {
                click   : this.onCreateGradosMesaViewSave
            }
        });
    },

    onVotoBlanco : function (btn) {
        var  me  = this,
            store   = Ext.getStore('PanelControlStore');
        store.reload();

        Ext.require([
            'Admin.view.personero.CandidatosView'
        ]);

        Ext.onReady(function() {

            me.app.onStore('personero.CandidatosStore');
            me.app.onStore('personero.CandidatosSearchStore');
            me.app.onStore('personero.CandidaturaStore');

            extra   = {
                pdbTable    : 'tp_voto_blanco',
                pdbType     : 1
            };

            me.app.setParamStore('CandidatosStore',extra);

            if (store.getCount() > 0) {
                win = me.app.getWindow('Voto en blanco', 'Admin.view.personero.CandidatosView');

                win.show();
            } else {
                me.app.showResult('Por favor configure el panel de control...');
            }
        });
    },

    onCreateGradosMesaViewSave : function (btn) {
        var win     = btn.up('window'),
            form    = win.down('form'),
            record  = form.getRecord(),
            values  = form.getValues(),
            me      = this,
            store   = Ext.getStore('GradosMesasSedesStore');

        me.onDataSave(record,values,store,values,win);
    },

    onCreateGradosMesaView : function (btn) {
        var
            me  = this,
            win = me.app.getWindow('Nuevo/Editar Grados sedes mesa de votación','Admin.view.personero.GradosSedesAsignadasView');

        if (btn.itemId == 'editButton'){
            var
                form    = win.down('form'),
                record  = btn.up('window').down('grid').getSelection()[0];

            form.loadRecord(record);
        }

        win.show();
    },

    onCreateGradosMesa : function (btn) {
        var  me  = this;

        Ext.require([
            'Admin.view.personero.GradosSedesAsignadasCrudView'
        ]);

        Ext.onReady(function() {
            me.app.onStore('personero.GradosMesasSedesStore');
            me.app.onStore('general.GradosStore');
            me.app.onStore('general.GrupoStore');

            extra = {
                pdbTable    : 'tp_grados_sedes_mesa',
                pdbMesa     : btn.up('window').down('grid').getSelection()[0].get('id')
            };

            me.app.setParamStore('GradosMesasSedesStore',extra,false);

            win = me.app.getWindow('Grados sedes mesa de votación','Admin.view.personero.GradosSedesAsignadasCrudView');

            win.show();
        });
    },

    onCandidaturasSave : function (btn) {
        var win     = btn.up('window'),
            form    = win.down('form'),
            record  = form.getRecord(),
            values  = form.getValues(),
            data    = null,
            me      = this,
            store   = Ext.getStore('CandidaturaStore');
        me.onDataSave(record,values,store,values,win);
    },

    onCandidaturasView : function (btn) {
        var
            me  = this,
            win = me.app.getWindow(null,'Admin.view.personero.CandidaturaView');

        if (btn.itemId == 'editButton'){
            var
                form    = win.down('form'),
                record  = btn.up('window').down('grid').getSelection()[0];

                form.loadRecord(record);
        }

        win.show();
    },

    onCandidaturas : function (btn) {
        var  me  = this;

        Ext.require([
            'Admin.view.personero.CandidaturasCrudView'
        ]);

        Ext.onReady(function() {
            me.app.onStore('personero.CandidaturaStore');
            win = me.app.getWindow(null,'Admin.view.personero.CandidaturasCrudView');

            win.show();
        });
    },

    /**
     * Funcion que crea la vista del panel de control
     * @param btn
     */

     onPanelControl : function (btn) {
        var win,
            me  = this;
        Ext.require([
            'Admin.view.personero.PanelView'
        ]);

        Ext.onReady(function () {
            me.app.onStore('personero.PanelControlStore');
            win    = me.app.getWindow(null,'Admin.view.personero.PanelView');

            win.show();
        });


     },

    /**
     * Funcion para crear y editar los datos del panel de control
     * @param btn
     */

    onPanelCrud : function (btn) {
        var me      = this,
            win, form,
            record  = btn.up('window').down('grid').getStore();


            if (btn.itemId =='addButton') {
                if (record.getCount() == 0) {

                    win = me.app.getWindow('Nuevo - Panel de control','Admin.view.personero.PanelControlView');
                    win.show();
                }else{
                    me.app.showResult('No se puede agregar más registros...');
                }
            }else {
                win = me.app.getWindow('Edición - Panel de control','Admin.view.personero.PanelControlView');

                record  = btn.up('window').down('grid').getSelection()[0];

                form    = win.down('form');
                form.loadRecord(record);

                win.show();
            }
    },

    /**
     * Funcion para guardar los cambios realizados en el panel de control
     * @param btn
     */

    onPanelSave : function (btn) {
        var win     = btn.up('window'),
            form    = win.down('form'),
            record  = form.getRecord(),
            values  = form.getValues(),
            me      = this,
            store   = Ext.getStore('PanelControlStore');
        me.onDataSave(record,values,store,values,win);
    },

    /**
     * Funcion para crear la vista de las mesas de votacion
     * @param btn
     */
    onMesasVotacion : function (btn) {
       var  me  = this,
        store   = Ext.getStore('PanelControlStore');
        store.reload();

        Ext.require([
            'Admin.view.personero.MesasVotacionView'
        ]);

        Ext.onReady(function () {
            me.app.onStore('personero.MesasVotacionStore');
            me.app.onStore('general.SedesStore');
            me.app.onStore('general.GradosStore');
            me.app.onStore('personero.MesasSedesStore');
            me.app.onStore('personero.JuradosStore');

            if (store.getCount() > 0) {
                win = me.app.getWindow(null,'Admin.view.personero.MesasVotacionView');

                win.show();
            }else{
                me.app.showResult('Por favor configure el panel de control...');
            }
        });
    },

    /**
     * Funcion para crear y editar las mesas de votacion
     * @param btn
     */
    onMesasCrud : function (btn) {
        var me  = this,
            win = null,
            form    = null,
            record  = null;

        win = me.app.getWindow('Nuevo/Editar Mesa de votación','Admin.view.personero.MesasVotacionSaveView');

        if (btn.itemId  == 'editButton') {

            record  = btn.up('window').down('grid').getSelection()[0];

            form    = win.down('form');
            form.loadRecord(record);
        }

        win.show();
    },

    /**
     * Funcion para guardar los cambios realizados en las mesas de votación
     * @param btn
     */
    onMesasSave : function (btn) {
        var win     = btn.up('window'),
            form    = win.down('form'),
            record  = form.getRecord(),
            values  = form.getValues(),
            me      = this,
            store   = Ext.getStore('MesasVotacionStore');

        me.onDataSave(record,values,store,values,win);
    },

    /**
     * Funcion para crear la ventana o vista de los candidatos
     * @param btn
     */
    onCandidatos    : function (btn) {
        var  me  = this,
            store   = Ext.getStore('PanelControlStore');
        store.reload();

        Ext.require([
            'Admin.view.personero.CandidatosView'
        ]);

        Ext.onReady(function() {

            me.app.onStore('personero.CandidatosStore');
            me.app.onStore('personero.CandidatosSearchStore');
            me.app.onStore('personero.CandidaturaStore');

            extra   = {
                pdbTable    : 'tp_candidatos',
                pdbType     : 2
            };

            me.app.setParamStore('CandidatosStore',extra);

            if (store.getCount() > 0) {
                win = me.app.getWindow('Candidatos', 'Admin.view.personero.CandidatosView');

                win.show();
            } else {
                me.app.showResult('Por favor configure el panel de control...');
            }
        });
    },

    onCandidatosCrud : function (btn) {
        var me      = this,
            win     = null,
            form    = null,
            record  = null,
            param   = {};

        param = me.app.getParamStore('CandidatosStore');


        if (param.pdbType == 2){
            win = me.app.getWindow('Nuevo/Editar Candidato','Admin.view.personero.CandidatosSaveView');
        }else{
            win = me.app.getWindow('Nuevo/Editar Voto en blanco','Admin.view.personero.CandidatosBlancoSaveView');
        }

        if(btn.itemId == 'editButton') {

            record  = btn.up('window').down('grid').getSelection()[0];

            console.log(record.get('tipo'));

            form    = win.down('form');
            form.loadRecord(record);
        }

        win.show();
    },

    onCandidatosSave : function (btn) {
        var win     = btn.up('window'),
            form    = win.down('form'),
            record  = form.getRecord(),
            values  = form.getValues(),
            data    = null,
            me      = this,
            store   = Ext.getStore('CandidatosStore');

        data    = {
            id_matric       : values.id_matric,
            nom_candidato   : values.nom_candidato,
            numero          : values.numero,
            candidatura     : values.candidatura,
            estado          : 1
        };

        me.onDataSave(record,values,store,data,win);
    },

    /**
     * Funcion para crear la vista de las sedes por mesa
     * @param btn
     */
    onSedesCreate   : function (btn) {
        var me      = this,
            store   = Ext.getStore('PanelControlStore'),
            records = btn.up('window').down('grid').getSelection()[0];

        record  = store.data.items[0].data;

        if (record.discriminar_x_sede == 1) {

            extra = {
                pdbTable    :'tp_sedes_mesa',
                pdbIdMesa   : records.get('id')
            };

            me.app.setParamStore('MesasSedesStore',extra);

            win = me.app.getWindow(null,'Admin.view.personero.SedesAsignadasView');

            win.show();

        }else {
            me.app.showResult('No es posible realiar esta operación...');
        }
    },

    onSedesCrud : function (btn) {
        var me      = this,
            win     = null,
            form    = null,
            record  = null;

        if(btn.itemId == 'addButton') {

            win = me.app.getWindow('Nuevo - Sede mesa de votación','Admin.view.personero.SedesAsignadasSaveView');

        }else {

            win = me.app.getWindow('Edición - Sede mesa de votación','Admin.view.personero.SedesAsignadasSaveView');

            record  = Ext.ComponentQuery.query('SedesAsignadasView')[0].down('grid').getSelection()[0];

            form    = win.down('form');
            form.loadRecord(record);
        }

        win.show();
    },

    onSedesSave : function (btn) {

        var win     = btn.up('window'),
            form    = win.down('form'),
            record  = form.getRecord(),
            values  = form.getValues(),
            data    = null,
            me      = this,
            store   = Ext.getStore('MesasSedesStore'),
            records = Ext.ComponentQuery.query('MesasVotacionView')[0].down('grid').getSelection()[0];

        data    = {
            id_mesa         : records.get('id'),
            id_sede         : values.id_sede,
            grados_votantes : values.grados_votantes
        };

        me.onDataSave(record,values,store,data,win);
    },

    /**
     * Funcion para crear la vista de los jurados de mesa
     * @param btn
     */
    onJuradosCreate : function (btn) {
        var win     = null,
            me      = this,
            record  = btn.up('window').down('grid').getSelection()[0];

        extra = {
            pdbTable    :'tp_jurados',
            pdbIdMesa   : record.get('id')
        };

        me.app.setParamStore('JuradosStore',extra);

        win = me.app.getWindow('Lista de jurados','Admin.view.personero.JuradosView');

        win.show();
    },

    onJuradosCrud : function (btn) {
        var me      = this,
            win     = null,
            form    = null,
            record  = null;

        if(btn.itemId == 'addButton') {

            win = me.app.getWindow('Nuevo - Jurado de mesa','Admin.view.personero.JuradosSaveView');

        }else {

            win = me.app.getWindow('Edición - Jurado de mesa','Admin.view.personero.JuradosSaveView');

            record  = Ext.ComponentQuery.query('JuradosView')[0].down('grid').getSelection()[0];

            form    = win.down('form');
            form.loadRecord(record);
        }

        win.show();
    },

    onJuradosSave : function (btn) {

        var win     = btn.up('window'),
            form    = win.down('form'),
            record  = form.getRecord(),
            values  = form.getValues(),
            data    = null,
            me      = this,
            store   = Ext.getStore('JuradosStore'),
            records = Ext.ComponentQuery.query('MesasVotacionView')[0].down('grid').getSelection()[0];

        data    = {
            id_mesa         : records.get('id'),
            nom_jurado      : values.nom_jurado,
            cargo           : values.cargo,
            estado          : values.estado
        };

        me.onDataSave(record,values,store,data,win);
    },

    onLoadStudent   : function (btn) {
        var win,
            me      = this.app,
            extra   = {};

        me.setParamStore('CandidatosSearchStore',extra);

        win = me.getWindow(null,'Admin.view.personero.CandidatosSearchView');
        win.show();
    },

    onImportEstudent : function (btn) {
        var win     = btn.up('window'),
            select  = win.down('grid').getSelection(),
            me      = this,
            winCan  = Ext.ComponentQuery.query('CandidatosSaveView')[0];

        if (select.length === 1) {

            idMatrid    = winCan.down('#idMatric');
            nombres     = winCan.down('#nombres');

            idMatrid.setValue(select[0].get('id_matric'));
            nombres.setValue(select[0].get('nombres'));

            win.close();

        }else {
            me.app.showResult('Seleccione un estudiante por favor...');
        }
    },

    onOpenTable : function (btn) {
        var me  = this.app,
            win;

        Ext.require([
            'Admin.view.personero.AbrirJornadaView',
            'Admin.store.personero.CandidatosStore'
        ]);

        Ext.onReady(function () {

            me.onStore('personero.CandidatosStore');
            me.onStore('personero.MesasVotacionStore');
            me.onStore('personero.VotosStore');
            extra   = {
                pdbTable    : 'tp_candidatos',
                pdbType     : 3
            };

            me.setParamStore('CandidatosStore',extra);

            win = me.getWindow('Abrir mesas de jornada electoral','Admin.view.personero.AbrirJornadaView');

            win.show();
        });


    },

    /**
     * Abrir mesa de votacion
     * @param btn
     */

    onOpenTableJorn : function (btn) {
        var record  = btn.up('window').down('grid').getSelection()[0],
            me      = this,
            store   = btn.up('window').down('grid').getStore(),
            storeC  = Ext.getStore('CandidatosStore');

        storeC.reload();

        if (record.get('estado') == 0) {
            Ext.Msg.show({
                title	: 'Abrir mesa',
                message	: 'Desea abrir esta mesa de votación?',
                buttons	: Ext.Msg.YESNO,
                icon	: Ext.Msg.QUESTION,
                fn: function(btn) {
                    if (btn === 'yes') {
                        var dt = new Date();
                        data = {
                            estado      : 1,
                            hora_inicio : Ext.Date.format(dt,'g:i:s')
                        };

                        record.set(data);
                        store.sync({
                            success: function () {
                                var
                                    win = me.app.getWindow(null, 'Admin.view.personero.VotacionView'),
                                    cUrl = me.urlBase + 'c_personero/get_select_candidatos',
                                    form = win.down('form');

                                Ext.Ajax.request({
                                    url: cUrl,

                                    success: function (response) {
                                        var obj = Ext.decode(response.responseText);
                                        if (obj.reccount > 0) {
                                            win.show();
                                        }
                                    },

                                    failure: function (response, opts) {
                                        me.app.onError(response.status);
                                    },
                                    callback: function () {
                                        store.reload();
                                    }
                                });
                            },

                            failure: function () {
                                me.app.onAler('No se ha podido abrir la mesa de votación...');
                            }
                        });
                    }
                }
            });
        }else if (record.get('estado') == 1){
            var record  = btn.up('window').down('grid').getSelection()[0],
                me      = this,
                store   = btn.up('window').down('grid').getStore(),
                storeC  = Ext.getStore('CandidatosStore');

            win = me.app.getWindow(null, 'Admin.view.personero.VotacionView');
            win.show();
        }
        else{
            me.app.onAler('No se puede realizar la operación');
        }
    },

    /**
     * Cerrar mesa de votacion
     * @param btn
     */
    onCloseTableJorn : function (btn) {
        var record  = btn.up('window').down('grid').getSelection()[0],
            me      = this,
            store   = btn.up('window').down('grid').getStore(),
            storeC  = Ext.getStore('CandidatosStore');

        storeC.reload();

        if (record.get('estado') == 0 || record.get('estado') == 1) {
            Ext.Msg.show({
                title	: 'Cerrar mesa',
                message	: 'Desea cerrar esta mesa de votación?',
                buttons	: Ext.Msg.YESNO,
                icon	: Ext.Msg.QUESTION,
                fn: function(btn) {
                    if (btn === 'yes') {
                        var dt = new Date();
                        data = {
                            estado      : 2,
                            hora_final  : Ext.Date.format(dt,'g:i:s')
                        };

                        record.set(data);
                        store.sync({
                            success: function () {
                                store.reload();
                                me.app.onAler('Se realizó el cierre correctamente');
                            },

                            failure: function () {
                                me.app.onAler('No se ha podido cerrar la mesa de votación...');
                            }
                        });
                    }
                }
            });
        }else{
            me.app.onAler('Ya la mesa se encuentra cerrada');
        }
    },

    onLoadCandidatos : function (btn) {
        var me      = this,
            win     = me.app.getWindow(null,'Admin.view.personero.VotacionView'),
            cUrl    = me.urlBase+'c_personero/get_select_candidatos';


        Ext.Ajax.request({
            url : cUrl,

            success: function(response) {
                var obj = Ext.decode(response.responseText);
                win.show();
            },

            failure: function(response, opts) {
              me.app.onError(response.status);
            }
        });

    },

    onVerify    : function (btn) {
        this.app.onAler('Opción no habilitada aún...');
    },

    onPrint : function (btn) {
        var win = null,
            me  = this;
        Ext.require([
            'Admin.view.personero.PersoneroReportView'
        ]);
        Ext.onReady(function () {
            me.app.onStore('general.SedesStore');
            me.app.onStore('general.GradosStore');
            win = me.app.getWindow(null,'Admin.view.personero.PersoneroReportView');

            win.show();
        });
    },

    onResult    : function (btn) {
        var win = null,
            me  = this;

        win = me.app.getWindow(null,'Admin.view.personero.PersoneroReportResultView');

        win.show();
    },

    onSetReport : function (btn) {
        var url     = 'c_personero_report/report_certificado',
            param   = {},
            win     = btn.up('window');

        if (win.alias == "widget.PersoneroReportView") {
            var grado   = win.down('#comboGrados').getSelection(),
                sede    = win.down('#comboSedes').getSelection(),
                report  = win.down('#comboReport').getSelection();

            param = {
                pdbGrado: grado.get('id'),
                pdbSede: sede.get('ID'),
                pdbReport: report.get('id')
            };

        }else{

           var  report  = win.down('#comboReport').getSelection(),
                url     = 'c_personero_report/report_resultados';

            param = {
                pdbReport: report.get('id')
            };
        }

        this.onGenReport(btn,url,param);
    }
});
