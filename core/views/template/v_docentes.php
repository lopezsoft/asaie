<!DOCTYPE HTML>
<html lang="es" manifest="">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
   	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <meta content="text/html; charset=UTF-8" http-equiv="Content-Type"/>
    <meta charset="utf-8">
    <title>
    	<?php echo TITLE_ADMIN;?>
    </title>
	
	<link rel="stylesheet" type="text/css" href="<?php echo base_url();?>extjs6/build/classic/theme-classic/resources/theme-classic-all.css">
    <link rel="stylesheet" type="text/css" href="<?php echo base_url();?>resources/styles.css">
    <link rel="stylesheet" type="text/css" href="<?php echo base_url();?>resources/icons.css">
  	
  	<script  type="text/javascript" src="<?php echo base_url();?>extjs6/build/ext-all.js"></script>
  	<script  type="text/javascript" src="<?php echo base_url();?>extjs6/build/classic/theme-classic/theme-classic.js"></script>
  	<script  type="text/javascript" src="<?php echo base_url();?>extjs6/build/classic/locale/locale-es.js"></script>
  	<script  type="text/javascript" src="<?php echo base_url();?>app/app.js"></script> 
  	<script>
   		Ext.onReady(function(){
   			Ext.Msg.wait('Por favor espere...','Ingresando a la aplicación');
   			Ext.require([
	    		'Admin.view.docentes.Viewport',			    	
		    	'src.button.Button',				    
			    'Admin.controller.cViewport',
			    'Admin.store.docentes.docs.sDocs',
	    		'src.button.BtnLarge',
	    		'Admin.store.login.sUser',
    			'Ext.ux.desktop.TaskBar',
    			'Ext.ux.Crypto.SHA1',	    			    	
	    	]);
	    	
	    	Ext.onReady(function() {
	    	
	    		me	= Admin.getApplication(); 
	    		me.onController('cViewport');
				me.onStore('docentes.docs.sDocs');
			    me.setUrlProxy('sDocs');
		    	Ext.Msg.hide();
		    						    	
				var view 	= Ext.create('Admin.view.docentes.Viewport');
					view.show();	
	    	});
   		});
   </script>   
</head>
<body>
	 
</body>
</html>
