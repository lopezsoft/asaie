Ext.define('Admin.view.widgets.WidgetUserProfile', {
    extend: 'Ext.panel.Panel',
    xtype: 'WidgetUserProfile',
    cls: 'admin-widget shadow',
    ui      : 'panel-white',
    items: [
        {
            xtype: 'image',
            cls: 'widget-top-container-first-img',
            height: 72,
            width: 72,
            alt: 'profile-image',
            src: 'resources/img/avatars/unknown.png',
            itemId: 'ImgPerfil'
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
                    html    : 'Usuario',
                    itemId  : 'labelName'
                },
                {
                    xtype   : 'toolbar',
                    cls     : 'widget-tool-button',
                    items   : [
                        {
                            ui: 'soft-purple',
                            iconCls: 'x-fa fa-book',
                            text: 'Imagen de perfil',
                            handler: function (btn) {
                                var me = Admin.getApplication();
                                me.onMsgWait();
                                Ext.require([
                                    'Admin.view.docs.FilesView',
                                    'Admin.store.general.perfil.UserStore'
                                ]);
                                Ext.onReady(function (btn) {
                                    me.onStore('docs.ImageBrowserStore');
                                    me.onStore('general.perfil.UserStore');
                                    storeX = Ext.getStore('UserStore');
                                    storeX.load();
                                    var win = Ext.create({
                                        xtype: 'FilesView',
                                        title: 'Seleccionar foto de Perfil',
                                        pathReadFile: 'General/read_images',
                                        pathUploadFile: 'General/upload_foto',
                                        titlePanelLoad: 'Subir foto',
                                        titlePanelView: 'Mis fotos',
                                        textButtonLoad: 'Seleccionar una foto en el equipo',
                                        textButtonApply: 'Establecer como foto de perfil',
                                        listeners: {
                                            afterselect: function (me, r) {
                                                store = Ext.getStore('UserStore');
                                                record = store.getAt(0);
                                                record.set('image', r.get('path_set'));
                                                record.set('mime', r.get('mime'));
                                            },
                                            afterupload: function (me, r) {
                                                store = Ext.getStore('UserStore');
                                                record = store.getAt(0);
                                                record.set('image', r.image);
                                                record.set('mime', r.mime);
                                            },
                                            apply: function (me) {
                                                var
                                                    me = Admin.getApplication(),
                                                    store = Ext.getStore('UserStore'),
                                                    mv = me.getMainView().down('#ImgPerfil'),
                                                    mv2 = me.getMainView().down('#imgUser'),
                                                    record = store.getAt(0),
                                                    foto = record.get('image'),
                                                    mime = record.get('mime'),
                                                    gb = Global.getData().user_data[0];
                                                store.sync();
                                                mv.setSrc(foto);
                                                mv2.setSrc(foto);
                                                gb.image = foto;
                                                gb.mime = mime;
                                            },
                                            cancel: function (me) {
                                                var
                                                    me = Admin.getApplication(),
                                                    store = Ext.getStore('UserStore'),
                                                    mv = me.getMainView().down('#ImgPerfil'),
                                                    mv2 = me.getMainView().down('#imgUser'),
                                                    gb = Global.getData().user_data[0];
                                                store.rejectChanges();
                                                mv.setSrc(gb.image);
                                                mv2.setSrc(gb.image);
                                            }
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
    listeners: {
        afterrender: function (pn) {
            var
                me = Global.getData(),
                data = me.user_data[0];
            nUser = data.last_name == "" ? data.names : data.names + ' ' + data.last_name;
            pn.down('#labelName').setText(nUser);
            foto = me.user_data[0].image;
            mime = me.user_data[0].mime;
            avatarImg = pn.down('#ImgPerfil');
            avatarEmpty = Global.getAvatarUnknoun();
            if (Ext.isEmpty(foto)) {
                avatarImg.setSrc(avatarEmpty);
            } else {
                imgUrl = foto;
                avatarImg.setSrc(imgUrl);
            }
        }
    }
});
