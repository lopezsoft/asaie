Ext.define('Admin.view.docs.LiveBroadcast',{
    extend          : 'Admin.base.CustomWindow',
    alias           : 'widget.livebroadcast',
    closable        : false,
    iconCls			: '',
    constrainHeader	: false,
    fixed           : true,
    hideShadowOnDeactivate : false,
    animateShadow   : true,
    border          : false,
    resizable       : true,
    bodyBorder      : false,
    cls             : 'menu-win',
    maximizable     : false,
	header          : false,
	maximized		: true,
    task            : true,
    config          : {
		email			: 'soporte@asaie.co',
		displayName 	: 'ASIAE EXODO',
		subject			: 'Sala de pruebas.',
		attached		: '',
		weather	    	: 0,
		minutes			: 0,
		seconds			: 0,
		record          : null,
		test			: true,
		api				: null
    },
    defaultListenerScope : true,
    initComponent   : function(){
		let me  = this;
		me.items    = [
			{
				xtype       : 'form',
				ui			: 'panel-white',
				layout 		: 'anchor',
				items 		: [
					{
						xtype 	: 'container',
						id		: 'meet'
					}
				],
				dockedItems: [{
					xtype		: 'toolbarSave',
					items   : [
						{
							xtype   : 'label',
							itemId  : 'lbWeather',
							cls     : 'widget-name-text',
							html    : 'Tiempo'
						},
						'->',
						{
							iconCls     : 'fas fa-paperclip',
							ui			: 'header-blue',
							disabled	: Ext.isEmpty(me.getAttached()),
							tooltip     : 'Documento adjunto',
							href		: me.getAttached()
						},
						{
							iconCls     : 'fas fa-play-circle',
							text        : 'Iniciar',
							ui			: 'header-green',
							handler		: function (){
								this.up('window').startTransmission();
							}
						},'-',
						{
							iconCls     : 'far fa-stop-circle',
							text		: 'Parar',
							ui			: 'header-red',
							handler		: function (){
								this.up('window').stopTransmission();
							}
						},'-',
						{
							xtype		: 'closebutton',
							handler: function () {
								this.up('window').onCloseWin();
							}
						}
					]
				}],
			}
		]
        me.callParent();
	},
	listeners   : {
		afterrender : function(){
			this.startTransmission();
		}
	},
	onCloseWin	: function (){
		let me      = this;
		me.stopClock();
		if (me.getTest()){
			me.stopTransmission();
			me.close();
		}else{
			Ext.Msg.show({
				title	: 'Cerrar sala virtual',
				message	: 'Desea cerrar  la sesión de la sala virtual?',
				buttons	: Ext.Msg.YESNO,
				icon	: Ext.Msg.QUESTION,
				fn: function(btn) {
					me.savechanges();
				}
			});
		}
	},
    runClock : function () {
        var
            me      = this,
            clock   = me.down('#lbWeather'),
            next    = 0,
            count   = 0,
            text    = 60,
            fin     = false,
			min     = parseInt(me.getWeather() - 1);
			if(parseInt(me.getWeather()) == 0){
				me.task	= Ext.TaskManager.start({
					run	: function () {
						next	++;
						clock.setHtml(("0" + me.minutes.toString()).slice (-2) + ':' + ("0" + next.toString()).slice (-2));
						me.seconds ++;
						if(next == 60) {
							next	= 0;
							me.minutes  ++;
							clock.setHtml(("0" + me.minutes.toString()).slice (-2) + ':' + ("0" + next.toString()).slice (-2));
							me.seconds = 0;
						}

						if(parseInt(me.getMinutes()) >= 60){
							me.stopClock();
							me.stopTransmission();
							me.savechanges();
						}
					},
					interval	: 1000
				});
			}else{
				me.task	= Ext.TaskManager.start({
					run	: function () {
						next	++;
						count = text - next;
						clock.setHtml('Tiempo restante: ' + ("0" + min.toString()).slice (-2) + ':' + ("0" + count.toString()).slice (-2));
						me.seconds ++;
						if(next == 60) {
							min --;
							count	= 0;
							next	= 0;
							me.minutes  ++;
							me.seconds = 0;
							if (fin){
								me.app.showResult('Lamentablemente se ha agotado el tiempo.!');
								me.stopClock();
								me.savechanges();
							}
						}
						if (min == 0) {
							fin = true
						};
					},
					interval	: 1000
				});
			}

    },
    stopClock   : function () {
        var
            me  = this;
        Ext.TaskManager.stop(me.task);
	},
	startTransmission : function(){
		let	me	= this,
			api	= me.getApi();
		const domain = 'meet.asaie.co';
		const options = {
			roomName    : 'meet.asie.co.example',
			width       : '100%',
			height      : 700,
			parentNode  : document.querySelector('#meet'),
			devices: {
				audioInput  : '<deviceLabel>',
				audioOutput :'<deviceLabel>',
				videoInput  : '<deviceLabel>'
			},
			configOverwrite: { startWithAudioMuted: true },
			userInfo: {
				email       : me.getEmail(),
				displayName : me.getDisplayName()
			},
			interfaceConfigOverwrite: { 
				SHOW_JITSI_WATERMARK : false,
				ENABLE_FEEDBACK_ANIMATION : true,
				TOOLBAR_BUTTONS: [
					'microphone', 'camera', 'closedcaptions', 'desktop', 'fullscreen',
					'fodeviceselection', 'profile', 'chat', 'recording',
					'livestreaming', 'etherpad', 'sharedvideo', 'settings', 'raisehand',
					'videoquality', 'filmstrip', 'invite', 'feedback', 'stats', 'shortcuts',
					'tileview', 'videobackgroundblur', 'download', 'help', 'mute-everyone',
					'e2ee', 'security'
				]
			},
		};
		if(!api){
			me.setApi(new JitsiMeetExternalAPI(domain, options));
			api = me.getApi();
			api.on('participantJoined', (data) => {
				console.log(data);
			});
			api.on('participantLeft ', (data) => {
				console.log(data);
			});
			api.on('readyToClose', (data) => {
				console.log(data);
			});
		}
		api.executeCommand('subject', me.getSubject());
		me.runClock();
	},
	stopTransmission: function(){
		let	me	= this,
			api	= me.getApi();
		if(api){
			api.executeCommand('hangup');
			api.dispose();
			me.setApi(null);
		}
	},
	savechanges : function () {
		let me = this;
		if(me.getTest()){
			me.close();
		}else{

		}
	}
});
