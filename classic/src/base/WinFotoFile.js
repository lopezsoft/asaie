Ext.define('Admin.base.WinFotoFile',{
	extend 	: 'Admin.base.CustomWindow',
	alias	: 'widget.WinFotoFile',
	width	: 450,
	height	: 290,
	title	: 'Fotografia',
    iconCls	: 'icon-cloud',
	modal	: true,
	urlPhoto: '',  // Propiedad donde se guarda la URL donde se envirá la petición
	extParam: {},  // Propiedad de tipo objeto, donde se guardan parametros adiciones que se envien en la petición 
	store	: '',  // Propiedad donde se guarda el Store que se actualizará con los datos de la foto (solo INSERT).
	items	: [
		{
			xtype 		: 'form',
			border		: false,
			autoScroll	: true,
			layout		: 'anchor',
            defaults: {
                anchor: '100%'
            },
    		bodyPadding	: 1,
    		items		: [
    			{
    				xtype	: 'container',
    				border	: 0,
   					style	: {
   						margin	: '0 auto'
   					},
    				items	: [
    					{    				
							xtype	: 'image',
							title 	: 'Fotografía',
							width	: 128,
							height	: 128,
							itemId	: 'imgPhoto',
                            style	: {
                                display	: 'block',
								margin	: 'auto'
                            },
							listeners : {
								afterrender : function ( img, eOpts ){
									if(Ext.isEmpty(img.src)){
										img.setSrc('resources/img/avatars/empty.png');
									}
								}
							}
						}
					]
				},
    			{
					xtype		: 'fileuploadfield',
					hideLabel 	: true,
					margin		: '2 0 0 0',
                    allowBlank	: false,
                    msgTarget	: 'side',
                    name		: 'foto',
					listeners	: {
                        change : function (tf, value, eOpts) {
							tf.up('window').down('#imgPhoto').setSrc(value);
                        }
					}
				}
    		],
    		buttons: [{
		        text: 'Subir...',
				iconCls	: 'icon-upload',
				scale	: 'medium',
		        handler: function() {
		            var form 	= this.up('form').getForm(),
		            	win		= this.up('window'),
		            	xParam	= win.extParam,
		            	xFoto 	= win.urlPhoto,
		            	store	= win.store;

		            if(form.isValid()){
		                form.submit({
		                    url: xFoto,
		                    params : xParam,
		                    waitMsg: 'Subiendo foto...',
		                    success: function(fp, o) {
		                    	
		                    	var img 	= win.down('#imgPhoto'),
									imgUrl	= globales.SetUrls.UrlLocation + o.result.foto;
									
								img.setSrc(imgUrl);

								if(!Ext.isEmpty(store)){
									store 	= Ext.getStore(store);
									store.reload();

								}

                                win.close();
		                        Ext.Msg.alert('Alerta','Se ha cargado la fotografía correctamente');
		                    },
		                    failure : function (fp, o) {
								Ext.Msg.alert('ERROR','No se ha cargado la fotografía');
							}
		                });
		            }
		        }
		    }]
		}
	]
});