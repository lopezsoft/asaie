/**
 * Created by LOPEZSOFT on 30/04/2016.
 */
Ext.define('Admin.view.general.perfil.view.PerfilUserView',{
    extend  : 'Ext.container.Container',
    alias   : 'widget.PerfilUserView',
    xtype   : 'PerfilUserView',
    controller  : 'base',
    iconCls     : 'x-fa fa-user', 
    bodyPadding: 10,
    items   : [
        {
            xtype       : 'customform',
            title       : AppLang.getSTitleViewProfile(),
            defaultType : 'TextField',
            items: [                
                {
                    fieldLabel  : 'Nombre(s)',
                    name        : 'names'
                },
                {
                    fieldLabel  : 'Apellido(s)',
                    name        : 'last_name'
                },
                {
                    fieldLabel  : 'Nombre de usuario',
                    name        : 'username'
                },
                {
                    fieldLabel  : 'Fecha de nacimiento',
                    name        : 'birth_date',
                    xtype       : 'DateField'
                },
                {
                    fieldLabel  : 'Teléfonos',
                    name        : 'phone',
                    allowBlank  : true
                },
                {
                    fieldLabel  : 'Correo electróncio',
                    name        : 'email',
                    vtype       : 'email',
                    emptyText   : 'example@email'
                },
                {
                    fieldLabel  : 'Contraseña',
                    name        : 'pasw',
                    inputType	: 'password',
                    itemId      : 'pasw1',
                    allowBlank  : true
                },
                {
                    fieldLabel  : 'Confirmar contraseña',
                    inputType	: 'password',
                    itemId      : 'pasw2',
                    name        : 'pasw2',
                    allowBlank  : true
                }
            ],
            listeners: {
                afterrender: function (frm, eOpts) {  
                    var me = Admin.getApplication();
                    me.onStore('general.perfil.UserStore');
                    var store = Ext.getStore('UserStore');
                    store.reload({
                        callback: function (records) {
                            frm.loadRecord(records[0]);
                        }
                    });
                }
            }
        }
    ]
});