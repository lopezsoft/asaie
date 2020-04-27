Ext.define('Admin.view.main.Main', {
    extend: 'Ext.container.Viewport',
    
    requires: [
        'Ext.button.Segmented',
        'Admin.view.main.MainContainerWrap',
        // 'Admin.view.main.MainModel',
        // 'Admin.button.ButtonChat',
        'Ext.list.Tree'
    ],
    alias       : 'widget.Main',
    controller  : 'main',
    viewModel   : 'main',

    cls         : 'sencha-dash-viewport',
    itemId      : 'mainView',

    layout: {
        type: 'vbox',
        align: 'stretch'
    },

    listeners: {
        render: 'onMainViewRender'
    },
    initComponent: function () {
        var 
            treeStore   = 'NavigationTreeMain',
            nameApp     = AppLang.getSMainMenu();
        switch (parseInt(Global.getData().user_type)) {
            case 4: // Docentes
                treeStore   = 'NavigationTree';
                nameApp     = AppLang.getSTeacherMenu();
                Global.setDataDirGroup(Global.getData().dir_group);
            break;
            case 5: // Estudiantes
                treeStore   = 'NavigationTreeEstudiantes';
                nameApp     = AppLang.getSStudentMenu();
            break;
        }
        this.items = [
            {
                xtype   : 'toolbar',
                cls     : 'sencha-dash-dash-headerbar shadow',
                height  : 64,
                itemId  : 'headerBar',
                items: [
                    {
                        xtype       : 'component',
                        reference   : 'senchaLogo',
                        cls         : 'sencha-logo',
                        html        : '<div class="main-logo"><img src="../../assets/img/asaie-48.png">'+nameApp+'</div>',
                        width       : 250
                    },
                    {
                        margin      : '0 2 0 4',
                        ui          : 'header',
                        iconCls     :'x-fa fa-navicon',
                        id          : 'main-navigation-btn',
                        handler     : 'onToggleNavigationSize'
                    },
                    {
                        xtype		: 'yearField',
                        allowBlank	: false,
                        name		: 'year',
                        value       : (Global.getYear()) ? (Global.getYear()) : 0,
                        width       : 85,
                        fieldLabel  : '',
                        hideTrigger	: false,
                        tooltip     : AppLang.getSToolTipChangeYear(),
                        itemId      : 'nfYear'
                    },
                    {
                        ui          : 'header',
                        iconCls     : 'fas fa-check-double',
                        tooltip     : AppLang.getSToolTipChangeYear(),
                        handler     : function(btn){
                            var me  = Admin.getApplication(),
                                ts  = btn.up('viewport'),
                                store,
                                extra,
                                newValue    = ts.down('#nfYear').getValue(),
                                refs        = ts.getReferences(),
                                mainCard    = refs.mainCardPanel,
                                msg;
                            ts.mask(AppLang.getSGenerating());
                            Ext.onReady(function() {
                                me.onStore('general.YearStore');
                                extra = {
                                    pYear : newValue
                                };
                                store = Ext.getStore('YearStore');
                                me.setParamStore('YearStore',extra,false);
                                store.load({
                                    scope: this,
                                    callback: function(records, operation, success) {
                                        ts.unmask();
                                        if (success){
                                            Global.setYear(newValue);
                                            msg = AppLang.getSDbChangeYear();
                                            if(mainCard){
                                                mainCard.removeAll(true);
                                            }
                                            ts.getController().redirectTo((localStorage.getItem('oldRoute')) ? localStorage.getItem('oldRoute') : 'dashboard',true);
                                        }else {
                                            msg = AppLang.getSDbNotChangeYear();
                                        };
                                        me.showResult(msg);
                                    }
                                });
                            });
                        }
                    },
                    '->',
                    {
                        xtype   : 'btnChat',
                        tooltip: AppLang.getSTootTipHelp()
                    },
                    {
                        xtype   : 'button',
                        iconCls : 'x-fa fa-home',
                        ui      : 'header',
                        itemId  : 'btnHome',
                        handler : 'onToolBarChange',
                        tooltip : 'Inicio'
                    },
                    {
                        xtype   : 'tbtext',
                        cls     : 'top-user-name',
                        itemId  :'btnUser',
                        text    : (Global.getData().user) ? (Global.getData().user) : 'Demo'
                    },
                    {
                        xtype   : 'image',
                        cls     : 'header-right-profile-image',
                        height  : 32,
                        width   : 32,
                        alt     : AppLang.getSToolTipUserProfile(),
                        itemId  : 'imgUser',
                        src     : Global.getAvatarUnknoun(),
                        imgCls  : 'avatar-background',
                        tooltip : AppLang.getSToolTipUserProfile()
                    },
                    {
                        ui      : 'header',
                        iconCls :'x-fa fa-navicon',
                        menu    : [
                            {
                                text    : 'Perfíl',
                                iconCls : 'far fa-id-badge'
                            },'-',
                            {
                                text    : 'Salir',
                                iconCls : 'fas fa-sign-out-alt',  
                                handler : 'onCloseSesion'
                            }
                        ]
                    }
                ]
            },
            {
                xtype       : 'maincontainerwrap',
                id          : 'main-view-detail-wrap',
                reference   : 'mainContainerWrap',
                flex: 1,
                items: [
                    {
                        xtype           : 'treelist',
                        reference       : 'navigationTreeList',
                        itemId          : 'navigationTreeList',
                        ui              : 'navigation',
                        store           : treeStore,
                        micro           : false,
                        width           : 250,
                        expanderFirst   : false,
                        expanderOnly    : false,
                        listeners: {
                            selectionchange: 'onNavigationTreeSelectionChange'
                        }
                    },
                    {
                        xtype       : 'container',
                        flex        : 1,
                        reference   : 'mainCardPanel',
                        cls         : 'panel-body-ligh',
                        itemId      : 'contentPanel',
                        padding     : 5,
                        layout      : {
                            type    : 'card',
                            anchor  : '100%'
                        }
                    }
                ]
            }
        ];
        this.callParent(arguments);
    }
});
