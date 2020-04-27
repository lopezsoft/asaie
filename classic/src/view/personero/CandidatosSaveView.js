/**
 * Created by LOPEZSOFT on 11/02/2016.
 */
Ext.define('Admin.view.personero.CandidatosSaveView',{
    extend  : 'Admin.base.CustomWindow',
    alias   : 'widget.CandidatosSaveView',
    controller  : 'personero',
    title       : 'Candidatos',
    height      : 300,
    items       : [
        {
            xtype   : 'customform',
            items   : [
                {
                    xtype       : 'customnumberfield',
                    name        : 'id_matric',
                    fieldLabel  : 'Código',
                    itemId      : 'idMatric',
                    readOnly    : true
                },
                {
                    xtype       : 'fieldcontainer',
                    layout      : 'hbox',
                    items       : [
                        {
                            xtype       : 'TextField',
                            flex        : 3,
                            fieldLabel  : 'Candidato',
                            readOnly    : true,
                            name        : 'nombres',
                            itemId      : 'nombres',
                            allowBlank  : true
                        },
                        {
                            xtype   : 'customButton',
                            iconCls : 'x-fa fa-upload',
                            text    : 'Importar',
                            itemId  : 'btnLoadStudent',
                            margin  : '0 0 0 2',
                            handler : 'onLoadStudent'
                        }
                    ]
                },
                {
                    xtype       : 'TextField',
                    fieldLabel  : 'Número',
                    name        : 'numero'
                },
                {
                    xtype       : 'CbCandidaturas'
                }
            ]
        }
    ]
});