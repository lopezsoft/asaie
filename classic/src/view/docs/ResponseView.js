/**
 * Created by LOPEZSOFT2 on 24/04/2017.
 */
Ext.define('Admin.view.docs.ResponseView',{
    extend  : 'Admin.base.CustomWindow',
    alias   : 'widget.ResponseView',
    closable        : false,
    iconCls			: '',
    constrainHeader	: false,
    fixed           : true,
    hideShadowOnDeactivate : false,
    animateShadow   : true,
    border      : false,
    resizable   : true,
    bodyBorder  : false,
    cls         : 'menu-win',
    width       : 800,
    height      : '100%',
    maximizable : false,
    header      : false,
    alwaysOnTop	: false,
    maximized   : false,
    task        : true,
    intentos    : 0,
    minutos     : 0,
    segundos    : 0,
    defaultListenerScope : true,
    app         : null,
    requires    : [
        'Admin.group.CheckboxGroup',
        'Admin.field.FieldContainerQuestions'
    ],
    constructor : function (config) {
        var me  = this;
        me.app  = Admin.getApplication();
        Ext.apply(me.config, config);
        this.callParent(arguments);
        me.on('cancel',function (me) {

        });
        me.on('changerequest',function (me) {

        });
        me.on('savechanges',function (form,values) {

        });
        return me;
    },
    items   : [
        {
            xtype   : 'customform',
            bodyPadding		: 20,
            items   : [
                {}
            ],
            dockedItems   : [
                {
                    xtype	: 'toolbarSave',
                    cls     : 'widget-tool-button',
                    flex    : 1,
                    dock	: 'top',
                    items   : [
                        ,'->',
                        {
                            xtype   : 'saveButton',
                            itemId  : 'btnSave',
                            ui      : 'header-red',
                            text    : 'Finalizar y envíar',
                            handler : function (b) {
                                Ext.Msg.show({
                                    alwaysOnTop : true,
                                    title       : 'Guardar evaluación?',
                                    message     : 'Desea finalizar la evaluación y guardar los cambios?',
                                    buttons     : Ext.Msg.YESNO,
                                    icon        : Ext.Msg.QUESTION,
                                    fn: function(btn) {
                                        if (btn === 'yes') {
                                            b.up('window').fireEvent('savechanges',b.up('form'),b.up('form').getValues());
                                        }
                                    }
                                });
                            }
                        },
                        {
                            xtype   : 'imagecomponent',
                            glyph   : 'xf017@FontAwesome',
                            cls     : 'top-info-container',
                            html    : '39:59 ',
                            itemId  : 'btnClock'
                        },' ',
                        {
                            xtype   : 'imagecomponent',
                            glyph   : 'xf046@FontAwesome',
                            cls     : 'top-info-container',
                            html    : 'Preguntas respondidas 20/20 ',
                            itemId  : 'btnRequest'
                        }
                    ]
                }
            ]
        }
    ],
    recordValues : function (r) {
        var me      = this,
            form    = me.down('form'),
            gb      = SME.ConfigApp,
            socket  = gb.getSocket(),
            nCount  = 0,
            rg      = null,
            cg      = null,
            fd      = null,
            rCheck  = null,
            idEvalEst   = 0;
        me.on('savechanges',function (form,values) {
            var items   = form.items.items,
                data    = {},
                obj     = null,
                nVerdaderas = 0,
                nFalsas     = 0,
                nSuma       = 0.0,
                nAbiertas   = 0;
            nCount  = 0;
            for (i = 0; i < items.length; i++){
                obj  = items[i];
                if (obj.xtype == 'FieldContainerQuestions'){
                    rg   = obj.down('radiogroup');
                    cg   = obj.down('checkboxgroup');
                    fd   = obj.down('textareafield');
                    if (rg){
                        rCheck  = rg.getChecked()[0];
                        data    = {
                            id_evaluacion_compartida    : r.get('id'),
                            id_pregunta                 : obj.idQuestion,
                            id_respuesta                : rCheck.idRequest,
                            intento                     : me.intentos,
                            respuesta_abierta           : '',
                            valor                       : rCheck.inputValue,
                            calificada                  : 1,
                            correcta                    : rCheck.correcta
                        };
                        nSuma   += rCheck.inputValue;
                        if (rCheck.correcta == 1) {
                            nVerdaderas ++;
                        }else {
                            nFalsas ++;
                        }
                        socket  = gb.getSocket();
                        socket.emit('sql-query-insert',{
                            cTable : 'te_respuestas_historial',
                            cValues: data
                        });
                    }else if(cg){
                        rCheck = cg.getChecked();
                        for (z = 0; z < rCheck.length; z++){
                            data    = {
                                id_evaluacion_compartida    : r.get('id'),
                                id_pregunta                 : obj.idQuestion,
                                id_respuesta                : rCheck[z].idRequest,
                                intento                     : me.intentos,
                                respuesta_abierta           : '',
                                valor                       : rCheck[z].inputValue,
                                calificada                  : 1,
                                correcta                    : rCheck[z].correcta
                            };
                            nSuma   += rCheck[z].inputValue;
                            if (rCheck[z].correcta == 1) {
                                nVerdaderas ++;
                            }else {
                                nFalsas ++;
                            }
                            socket  = gb.getSocket();
                            socket.emit('sql-query-insert',{
                                cTable : 'te_respuestas_historial',
                                cValues: data
                            });
                        }
                    }else if (fd){
                        data    = {
                            id_evaluacion_compartida    : r.get('id'),
                            id_pregunta                 : obj.idQuestion,
                            id_respuesta                : fd.idRequest,
                            intento                     : me.intentos,
                            respuesta_abierta           : fd.getValue(),
                            valor                       : 0,
                            calificada                  : 0,
                            correcta                    : 0
                        };
                        nAbiertas   ++;
                        socket  = gb.getSocket();
                        socket.emit('sql-query-insert',{
                            cTable : 'te_respuestas_historial',
                            cValues: data
                        });
                    }
                }
            }
            socket  = gb.getSocket();
            socket.emit('sql-query-update',{
                cTable : 'te_evaluaciones_estudiantes',
                cValues: [{
                    res_verdaderas  : nVerdaderas,
                    res_falsas      : nFalsas,
                    res_abiertas    : nAbiertas,
                    tiempo          : me.minutos,
                    segundos        : me.segundos,
                    punataje        : nSuma
                },{
                    id              : idEvalEst
                }]
            });
            socket  = gb.getSocket();
            socket.emit('sql-query-call',{
                cCall   : 'sp_evaluacion_estudiantes_update_nota',
                cParam  : r.get('id')
            });
           var win = Ext.create('Admin.view.docs.VideoView',{
                height  : 250,
                width   : 360,
                alwaysOnTop	: false,
                items   :[
                    {
                        xtype   : 'form',
                        items   : [
                            {
                                xtype: 'container',
                                cls: 'widget-bottom-first-container postion-class',
                                height: 220,
                                padding: '30 0 0 0',
                                layout: {
                                    type: 'vbox',
                                    align: 'center'
                                },
                                items: [
                                    {
                                        xtype   : 'label',
                                        cls     : 'widget-name-text',
                                        html    : 'Respuestas correctas: '+nVerdaderas.toString()
                                    },
                                    {
                                        xtype   : 'label',
                                        cls     : 'widget-name-text',
                                        html    : 'Respuestas incorrectas: '+nFalsas.toString()
                                    },
                                    {
                                        xtype   : 'label',
                                        cls     : 'widget-name-text',
                                        html    : 'Respuestas abiertas y sin calificar: '+nAbiertas.toString()
                                    },
                                    {
                                        xtype   : 'label',
                                        cls     : 'widget-name-text',
                                        html    : 'Intento: '+me.intentos.toString()
                                    },
                                    {
                                        xtype   : 'label',
                                        cls     : 'widget-name-text',
                                        html    : 'Tiempo de respuesta: '+("0" + me.minutos.toString()).slice (-2)+' MIN.'+
                                            ' con '+("0" + me.segundos.toString()).slice (-2)+' SEG.'
                                    },
                                    {
                                        xtype   : 'label',
                                        cls     : 'widget-name-text',
                                        html    : 'Nota obtenida: '+nSuma.toString()
                                    }
                                ]
                            }
                        ]
                    }
                ]
            });
            me.stopClock();
            me.close();
            win.show();
        });
        me.on('changerequest',function (obj) {
           var items    = form.items.items,
               comp     = null;
           nCount  = 0;
          for (i = 0; i < items.length; i++){
              comp  = items[i];
               if (comp.xtype == 'FieldContainerQuestions'){
                   rg   = comp.down('radiogroup');
                   cg   = comp.down('checkboxgroup');
                   fd   = comp.down('textareafield');
                   if (rg){
                       rCheck = rg.getChecked();
                       if (rCheck.length > 0){
                           nCount  ++;
                       }
                   }else if(cg){
                       rCheck = cg.getChecked();
                       if (rCheck.length > 0){
                           nCount  ++;
                       }
                   }else if (fd){
                       if (!Ext.isEmpty(fd.getValue())){
                           nCount  ++;
                       }
                   }
               }
          }
          me.down('#btnRequest').setHtml('Respuestas realizadas '+nCount.toString()+'/'+r.get('num_preguntas')+' ');
        });
        form.mask('Cargando preguntas');
        me.down('#btnRequest').setHtml('Respuestas realizadas 0/'+r.get('num_preguntas')+' ');
        form.add({
            xtype: 'container',
            cls: 'widget-bottom-first-container postion-class',
            layout: {
                type: 'vbox',
                align: 'center'
            },
            items: [
                {
                    xtype   : 'label',
                    cls     : 'widget-name-text',
                    html    : r.get('nombre')
                },
                {
                    xtype   : 'label',
                    cls     : 'widget-name-text',
                    html    : r.get('asignatura')
                },
                {
                    xtype   : 'label',
                    cls     : 'widget-name-text',
                    html    : r.get('docente')
                },
                {
                    xtype   : 'label',
                    html    :  r.get('descripcion')+'<br>'
                }
            ]
        });
        socket.emit('sql-query-insert',{
            cTable : 'te_evaluaciones_estudiantes',
            cValues: {
                id_evaluacion_compartida    : r.get('id'),
                intento                     : me.intentos,
                estado                      : 1
            }
        });
        socket.on('receiveSqlQueryInsert',function (r, id, err) {
            idEvalEst   = id;
        });
        socket  = gb.getSocket();
        socket.emit('sql-query-select',{
            cTable  : 'te_preguntas',
            cFields : 'id,id_evaluacion,pregunta,descripcion,valor,tipo,num_respuestas',
            cWhereFields    : 'id_evaluacion = ? ',
            cWhereValues    : [r.get('id_evaluacion')]
        });
        socket.on('receiveSqlQuerySelect',function (res, e) {
           if (e) {
               me.app.onError(e.code);
           }else {
               me.setQuestions(res,r);
               me.runClock(r.get('tiempo'));
           }
        });
    },
    setQuestions : function (req,r) {
        var
            me      = this,
            form    = me.down('form'),
            count   = 0,
            rc      = null,
            aleator = r.get('esquema') == 1 ? false : false;
        if (aleator) {

        }else{
            for (i = 0; i < req.length; i++){
                count   ++;
                rc      = req[i];
                cont    = Ext.create({
                    xtype       : 'FieldContainerQuestions',
                    idQuestion  : rc['id'],
                    record      : rc,
                    recordQuest : r,
                    nQuest      : count,
                    itemId      : 'question'+i.toString()
                });
                cont.addControls();
                form.add(
                    {
                        xtype   : cont
                    },
                    {
                        xtype   : 'box',
                        cls     : 'mail-body'
                    }
                );
            }
            form.unmask();
        }
    },
    runClock : function (val) {
        var
            me      = this,
            clock   = me.down('#btnClock'),
            next    = 0,
            count   = 0,
            text    = 60,
            fin     = false,
            min     = val - 1;
            me.task	= Ext.TaskManager.start({
                run	: function () {
                    next	++;
                    count = text - next;
                    clock.setHtml(("0" + min.toString()).slice (-2)+':'+("0" + count.toString()).slice (-2)+' ');
                    me.segundos ++;
                    if(next == 60) {
                        min --;
                        count	= 0;
                        next	= 0;
                        me.minutos  ++;
                        me.segundos = 0;
                        if (fin){
                            me.app.showResult('Lamentablemente se ha agotado el tiempo para responder la evaluación!');
                            me.fireEvent('savechanges',me.down('form'),me.down('form').getValues());
                            me.stopClock();
                        }
                    }
                    if (min == 0) {
                        fin = true
                    };
                },
                interval	: 1000
            });

    },
    stopClock   : function () {
        var
            me  = this;
        Ext.TaskManager.stop(me.task);
    }
});
