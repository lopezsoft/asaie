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
        let 
            me          = this,
            treeStore   = 'NavigationTreeMain',
            nameApp     = AppLang.getSMainMenu()
            reports     = Global.getData().reports_data[0],
            membership  = Global.getData().membership,
            schoolData  = Global.getData().school_data[0];
        switch (parseInt(Global.getData().user_type)) {
            case 4: // Docentes
                treeStore   = 'NavigationTree';
                nameApp     = AppLang.getSTeacherMenu();
                Global.setDataDirGroup(Global.getData().dir_group);
            break;
            case 5: // Estudiantes
                treeStore   = 'NavigationTreeStudents';
                nameApp     = AppLang.getSStudentMenu();
            break;
        }
        me.items = [
            {
                xtype   : 'toolbar',
                cls     : 'sencha-dash-dash-headerbar-blue',
                height  : 64,
                items   : [
					{
						xtype       : 'tbtext',
						cls			: 'membership-icon',
						html		: '<i class="fas fa-award"></i>'
					},
					{
						xtype       : 'label',
						cls			: (membership.state == 1) ? 'membership-text-active' : 'membership-text-inactive', 
						text 		: (membership.state == 1) ? 'membresia activa hasta: ' + membership.lockdate : 'membresia inactiva'
					},
                    '->',
                    {
                        xtype   : 'tbtext',
                        cls     : 'name-text',
                        text    : (membership.nameschool) ? membership.nameschool : 'Escuela Demo'
                    },
                    {
                        xtype   : 'image',
                        cls     : 'header-right-profile-image',
                        height  : 32,
                        width   : 32,
                        alt     : 'Logo institucional',
                        src     : (Ext.isEmpty(reports.logo)) ? Global.getAvatarUnknoun() : reports.logo,
                        imgCls  : 'avatar-background',
                        tooltip : 'Logo institucional'
                    }
                ]
            },
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
                                        ts.getController().redirectTo((localStorage.getItem('currentRoute')) ? localStorage.getItem('currentRoute') : 'dashboard',true);
                                    }else {
                                        msg = AppLang.getSDbNotChangeYear();
                                    };
                                    me.showResult(msg);
                                }
                            });
                        }
                    },
                    '->',
                    ,'-',
                    {
                        xtype       : 'badgebutton',
                        badgeCls    : 'x-btn-badgeCls-green',
                        tooltip     : 'Actividades',
                        itemId      : 'activityButton',
                        iconCls     : 'x-fa fa-spinner',
                        initComponent   : function(){
                            this.callParent(arguments);
                            this.setVisible(parseInt(Global.getData().user_type) == 5 ? true : false);
                        },
                        listeners   : {
                            scope       : this,
                            afterrender : function (btn) {
                                var
                                    me      = this,
                                    socket  = Global.getSocket(),
                                    e       = Ext.getElementById('notif_docs');
                                socket.on('receiveActivity',function (d) {
                                    if(d.cfg.db == Global.getDbName()){
                                        xsocket      = Global.getSocket();
                                        xsocket.emit('querySelect',{
                                            dataName    : Global.getDbName(),
                                            fields      : 'COUNT(activity_id) total ',
                                            table       : 'ta_shared_online_activities',
                                            where       : 'enrollment_id = ? AND leido = ? ',
                                            values      : [Global.getData().enrollment[0].id,0]
                                        },(error, d)=>{
                                            if (d) {
                                                if (d.length > 0) {
                                                    let val   = d[0].total,
                                                        btn  = me.down('#activityButton');
                                                    if (val > 0 ){
                                                        cls  = 'x-btn-badgeCls';
                                                        if (e) {
                                                            e.play();
                                                        }
                                                    }else {
                                                        cls  = 'x-btn-badgeCls-green';
                                                    }
                                                    btn.setBadgeCls(cls);
                                                    btn.setBadgeText(val.toString());
                                                }
                                            }
                                        });
                                    }
                                });
                            }
                        },
                        handler     : 'onStudentsActivities'
                    },
                    {
                        xtype       : 'badgebutton',
                        badgeCls    : 'x-btn-badgeCls-green',
                        tooltip     : 'Evaluaciones',
                        iconCls     : 'x-fa fa-question-circle',
                        itemId      : 'evaluationButton',
                        initComponent   : function(){
                            this.callParent(arguments);
                            this.setVisible(parseInt(Global.getData().user_type) == 5 ? true : false);
                        },
                        listeners   : {
                            scope       : this,
                            afterrender : function (btn) {
                                var
                                    me      = this,
                                    e       = Ext.getElementById('notif_eval'),
                                    socket  = Global.getSocket();
                                socket.on('receiveEvaluation',function (d) {
                                    if(d.cfg.db == Global.getDbName()){
                                        xsocket     = Global.getSocket();
                                        xsocket.emit('querySelect',{
                                            dataName    : Global.getDbName(),
                                            fields      : 'COUNT(evaluation_id) total ',
                                            table       : 'te_shared_evaluation',
                                            where       : 'enrollment_id = ? AND eread = ? ',
                                            values      : [Global.getData().enrollment[0].id,0]
                                        },(error, d)=>{
                                            if (d) {
                                                if (d.length > 0) {
                                                    let val   = d[0].total,
                                                        btn  = me.down('#evaluationButton');
                                                    if (val > 0 ){
                                                        cls  = 'x-btn-badgeCls';
                                                        if (e) {
                                                            e.play();
                                                        }
                                                    }else {
                                                        cls  = 'x-btn-badgeCls-green';
                                                    }
                                                    btn.setBadgeCls(cls);
                                                    btn.setBadgeText(val.toString());
                                                }
                                            }
                                        });
                                    }
                                });
                            }
                        },
                        handler     : 'onStudentsEvaluations'                     
                    },
                    {
                        xtype       : 'badgebutton',
                        badgeCls    : 'x-btn-badgeCls-green',
                        itemId      : 'emailButton',
                        visible     : false,
                        tooltip     : 'Correos recividos',
                        handler     : function (btn) {
                            var
                                e  = Ext.getElementById('notif_email');
                            if (e) {
                                e.play();
                            }
                        },
                        iconCls     : 'x-fa fa-envelope'
                    },
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
                        src     : (Ext.isEmpty(Global.getData().user_data[0].image)) ? Global.getAvatarUnknoun() : Global.getData().user_data[0].image,
                        imgCls  : 'avatar-background',
                        tooltip : AppLang.getSToolTipUserProfile()
                    },
                    {
                        ui      : 'header',
                        iconCls :'x-fa fa-navicon',
                        menu    : [
                            {
                                text    : 'Perfíl',
                                iconCls : 'far fa-id-badge',
                                handler : 'onProfile'
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
                flex        : 1,
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
        me.callParent(arguments);

        switch (parseInt(Global.getData().user_type)) {
            case 5: // Estudiantes
                socket      = Global.getSocket();
                socket.emit('querySelect',{
                    dataName    : Global.getDbName(),
                    fields      : 'COUNT(evaluation_id) total ',
                    table       : 'te_shared_evaluation',
                    where       : 'enrollment_id = ? AND eread = ? ',
                    values      : [Global.getData().enrollment[0].id,0]
                },(error, d)=>{
                    if (d) {
                        if (d.length > 0) {
                            var val   = d[0].total,
                                btn  = me.down('#evaluationButton');
                            if (val > 0 ){
                                cls  = 'x-btn-badgeCls';
                            }else {
                                cls  = 'x-btn-badgeCls-green';
                            }
                            btn.setBadgeCls(cls);
                            btn.setBadgeText(val.toString());
                        }
                    }
                });

                xsocket      = Global.getSocket();
                xsocket.emit('querySelect',{
                    dataName    : Global.getDbName(),
                    fields      : 'COUNT(activity_id) total ',
                    table       : 'ta_shared_online_activities',
                    where       : 'enrollment_id = ? AND leido = ? ',
                    values      : [Global.getData().enrollment[0].id,0]
                },(error, d)=>{
                    if (d) {
                        if (d.length > 0) {
                            var val   = d[0].total,
                                btn  = me.down('#activityButton');
                            if (val > 0 ){
                                cls  = 'x-btn-badgeCls';
                            }else {
                                cls  = 'x-btn-badgeCls-green';
                            }
                            btn.setBadgeCls(cls);
                            btn.setBadgeText(val.toString());
                        }
                    }
                });
            break;
        }

    }
});
