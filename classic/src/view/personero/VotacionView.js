/**
 * Created by LOPEZSOFT on 14/02/2016.

Ext.define('Admin.view.personero.VotacionView',{
    extend  : 'Admin.base.CustomWindow',
    alias   : 'widget.VotacionView',
    maximized   : true,
    title       : 'Candidatos a Personero',
    items       : [
        {
            xtype   : 'customform',
            items   : [

            ],
            dockedItems: []
        }
    ]
});*/
Ext.define('Admin.view.personero.VotacionView', {
    extend: 'Admin.base.CustomWindow',
    uses: [
        'Ext.layout.container.Border',
        'Ext.form.field.Text',
        'Ext.form.field.ComboBox',
        'Ext.toolbar.TextItem',
        'Ext.layout.container.Fit',
        'Admin.store.personero.VotosStore'
    ],
    height  : 600,
    width   : 600,
    maximized   : true,
    maximizable : false,
    title       : 'Elecciones escolares',
    controller  : 'personero',
    initComponent: function() {
        this.items = [
            {
                xtype: 'panel',
                region: 'center',
                layout: 'fit',
                items: [
                    {
                        xtype       : 'ImagenBrowserView',
                        scrollable  : true,
                        id          : 'img-chooser-view',
                        listeners: {
                            scope   : this,
                            selectionchange : this.onIconSelect,
                            itemdblclick    : this.onIconSelect
                        }
                    }
                ]
            }
        ];

        this.buttons = [
            /*{
                xtype   : 'customButton',
                iconCls	: 'x-fa fa-thumbs-o-up',
                text    : 'Votar',
                scope   : this,
                handler : function (btn) {

                }
            },*/
            {
                xtype   : 'closebutton',
                iconAlign	: 'left'
            }

        ];

        this.callParent(arguments);
    },

    /**
     * Called whenever the user clicks on an item in the DataView. This tells the info panel in the east region to
     * display the details of the image that was clicked on
     */
    onIconSelect: function(dataview, selections) {
        var selected = selections[0],
            me       = Admin.getApplication(),
           cApp      =  this,
            cUrl     = me.getUrlBase()+'c_personero/insert_votos';
        if (selected) {
            Ext.Msg.prompt('Código identidad', 'Por favor digite su código de votación:', function(btn, text){
                if (btn == 'ok'){
                    if (!Ext.isEmpty(text)) {
                        cApp.el.mask('Procesando voto...');

                       var  mesa    = Ext.ComponentQuery.query('AbrirJornadaView')[0].down('grid').getSelection()[0],
                            id_mesa = mesa.get('id');

                        data = {
                            id_matric   : text,
                            id_candidato: selected.get('id'),
                            id_mesa     : id_mesa,
                            estado      : selected.get('estado'),
                            tipo        : selected.get('candidatura')
                        };

                        Ext.Ajax.request({
                            url     : cUrl,
                            params  : data,
                            method  : 'POST',
                            success: function (response) {
                                value   = Ext.decode(response.responseText);

                                switch (value.estado) {
                                    case 0 :
                                        msg = "Ya habia realizado el proceso de votación";
                                        break;
                                    case 1 :
                                        msg = "Se realizó el proceso de voto correctamente";
                                        break;
                                    case 2 :
                                        msg = "No se encontró registro de matricula para el código ingresado";
                                        break;
                                    case 3 :
                                        msg = "No se realizó la operación de voto, ya que la mesa se encuentra cerrada.";
                                        break;
                                }

                               me.onAler(msg+'.');
                            },

                            failure: function (response) {
                                me.onError(response.status);
                            },

                            callback: function (response) {
                                dataview.deselect(selected);
                                cApp.el.unmask();
                            }
                        });
                    }else{
                        dataview.deselect(selected);
                        msg ='Debe digitar un código de identidad';
                        Ext.Msg.alert('Alerta Personero',msg+'.');
                    }
                }else{
                    dataview.deselect(selected);
                }
            });
        }
    }
});