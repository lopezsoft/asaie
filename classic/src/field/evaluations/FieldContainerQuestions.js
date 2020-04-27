/**
 * Created by LOPEZSOFT2 on 12/12/2016.
 */
Ext.define('Admin.field.FieldContainerQuestions',{
    extend  : 'Ext.form.FieldContainer',
    labelStyle	: 'font-weight:bold',
    layout      : 'anchor',
    alias		: 'widget.FieldContainerQuestions',
    idQuestion  : 0,
    record      : {},
    recordQuest : {},
    nQuest      : 0,
    defaultListenerScope : true,
    items   : [
        {
            xtype   : 'label',
            itemId  : 'label1',
            cls     : 'widget-name-text'
        },
        {
            xtype   : 'label',
            itemId  : 'label2'
        },
        {
            xtype   : 'label',
            itemId  : 'label3',
            cls     : 'widget-name-text space-left-10'
        },
        {
            xtype       : 'fieldSet',
            labelStyle	: 'font-weight:bold',
            title       : 'Digite una respuesta'
        }
    ],
    addControls    : function () {
        var
            me      = this,
            lb      = null,
            fs      = me.down('fieldset'),
            r       = me.record,
            gb      = globales.General,
            socket  = gb.getSocket(),
            data    = [],
            type    = r.tipo;
        lb  = me.down('#label1');
        lb.setHtml('<br>'+me.nQuest.toString()+' de '+me.recordQuest.get('num_preguntas'));
        lb  = me.down('#label2');
        lb.setHtml(Ext.isEmpty(r['descripcion']) ? '' : '<br>'+r['descripcion']);
        lb.setHidden(Ext.isEmpty(r['descripcion']) ? true : false);
        lb  = me.down('#label3');
        lb.setHtml(Ext.isEmpty(r['pregunta']) ? '' : '<br>'+r['pregunta']);
        lb.setHidden(Ext.isEmpty(r['pregunta']) ? true : false);
        if (fs) {
            socket.emit('sql-query-select',{
                cTable  : 'te_respuestas',
                cFields : 'id,id_pregunta,respuesta,valor,verdadera',
                cWhereFields    : 'id_pregunta = ? ',
                cWhereValues    : [r['id']]
            });
            socket.on('receiveSqlQuerySelect',function (res, e) {
                if (e) {
                    me.app.onError(e.code);
                }else {
                    if (res.length > 0) {
                        if (type > 1 ){
                            for (z = 0; z < res.length; z++){
                                rc  = res[z];
                                ob = {
                                    boxLabel    : rc['respuesta'],
                                    inputValue  : rc['valor'],
                                    name        : me.itemId,
                                    idRequest   : rc['id'],
                                    correcta    : rc['verdadera']
                                };
                                Ext.Array.push(data,ob);
                            }
                        }
                        switch (type) {
                            /*General o abierta*/
                            case 1 :
                                fs.setTitle('Digite una respuesta');
                                fs.add({
                                    xtype   : 'textAreaField',
                                    name    : 'respuesta',
                                    idRequest   : res[0]['id'],
                                    correcta    : res[0]['verdadera'],
                                    emptyText   : 'Digite la descripción de la respuesta',
                                    listeners : {
                                        change  : function (me) {
                                            me.up('window').fireEvent('changerequest',me.up('fieldcontainer'));
                                        }
                                    }
                                });
                                break;
                            /*Selección múltiple con única respuesta*/
                            case 2 :
                                fs.setTitle('Seleccione una respuesta');
                                fs.add({
                                    xtype   : 'radioGroup',
                                    items   : data,
                                    listeners : {
                                        change  : function (me, n) {
                                            me.up('window').fireEvent('changerequest',me.up('fieldcontainer'));
                                        }
                                    }
                                });
                                break;
                            /*Selección múltiple con múltiple respuesta*/
                            case 3 :
                                fs.setTitle('Seleccione una o más respuestas');
                                fs.add({
                                    xtype   : 'CheckboxGroup',
                                    items   : data,
                                    listeners : {
                                        change  : function (me, n) {
                                            me.up('window').fireEvent('changerequest',me.up('fieldcontainer'));
                                        }
                                    }
                                });
                                break;
                            /*FALSO/VERDADERO*/
                            case 4 :
                                fs.setTitle('Seleccione una respuesta');
                                fs.add({
                                    xtype   : 'radioGroup',
                                    items   : data,
                                    listeners : {
                                        change  : function (me, n) {
                                            me.up('window').fireEvent('changerequest',me.up('fieldcontainer'));
                                        }
                                    }
                                });
                                break;
                        }
                    }
                }
            });
        }
    }
});