/**
 * Created by LOPEZSOFT on 18/05/2016.
 */
Ext.define('Admin.view.general.perfil.view.PefilMenuView',{
    extend  : 'Admin.base.WinMenu',
    alias   : 'widget.PefilMenuView',
    requires: [
        'Admin.view.general.perfil.view.PerfilUserView'
    ],
    controller  : 'base',
    height      : 220,
    items       : [
        {
            xtype   : 'customform',
            items   : [
                {
                    xtype   : 'image',
                    cls     : 'width-button-large circular',
                    height  : 128,
                    width   : 128,
                    alt     : AppLang.getSToolTipImageProfile(),
                    itemId  : 'imgUser',
                    imgCls  : 'avatar-background avatar-perfil',
                    title   : AppLang.getSToolTipImageProfile()
                },
                {
                    xtype   : 'tbtext',
                    cls     : 'top-user-name',
                    itemId  :'btnUser',
                    text    : '¿--?'
                }
            ],
            dockedItems: [
                {
                    xtype	: 'toolbar',
                    cls     : 'color-tool',
                    dock	: 'bottom',
                    items   : [
                        {
                            iconCls :'x-fa fa-sign-out',
                            ui      : 'header-red',
                            itemId  : 'btnUserClose',
                            handler : 'onCloseSesion',
                            text: AppLang.getSButtonCloseSession()
                        }
                    ]
                }
            ]
        }
    ],
    listeners : {
        afterrender: function (win) {
            me = Global.getData();
            // data = me.user_data[0];
            // foto = data.image;
            // mime = data.mime;
            // nUser= data.last_name == "" ? data.names : data.names+' '+data.last_name;
            // avatarImg = win.down('#imgUser');

            // avatarEmpty = Global.getAvatarUnknoun();

            // win.down('#btnUser').setText(nUser);

            // if (Ext.isEmpty(foto)) {
            //     avatarImg.setSrc(avatarEmpty);
            // } else {
            //     imgUrl =  foto;
            //     avatarImg.setSrc(imgUrl);
            // }
        }
    }
});
