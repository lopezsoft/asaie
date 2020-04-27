<!DOCTYPE HTML>
<html lang="es" manifest="">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
   
    <meta content="text/html; charset=UTF-8" http-equiv="Content-Type"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <meta charset="utf-8">
    <title>
    	S.M.E (Sistema de Monitoreo Escolar) ÉXODO
    </title>
	
    <link rel="stylesheet" type="text/css" href="<?php echo base_url();?>extjs6/build/classic/theme-classic/resources/theme-classic-all.css">
    <link rel="stylesheet" type="text/css" href="<?php echo base_url();?>resources/styles.css">
     <link rel="stylesheet" type="text/css" href="<?php echo base_url();?>resources/icons.css">
 	
  	<script  type="text/javascript" src="<?php echo base_url();?>extjs6/build/ext-all-debug.js"></script>
  	<script  type="text/javascript" src="<?php echo base_url();?>extjs6/build/classic/theme-classic/theme-classic.js"></script>
  	<script  type="text/javascript" src="<?php echo base_url();?>extjs6/build/classic/locale/locale-es.js"></script>
  	 <script  type="text/javascript" src="<?php echo base_url();?>app/app.js"></script> 
  	 <script>
   		Ext.onReady(function(){
   			
   			Ext.require([
	    		'Admin.view.login.vLogin',
	    		'Admin.store.login.sLogin',	
	    		'Admin.controller.cLogin',
	    		'src.button.BtnLarge',
	    		'Admin.store.login.sUser'		    			    	
	    	]);
	    	
	    	Ext.onReady(function() {
	    		Ext.Msg.wait('Por favor espere...','Inicializando aplicación');
	    		Ext.require([
        			'Ext.ux.Crypto.SHA1',
	    		]);
	    		
	    		me	= Admin.getApplication(); 
	    		
	    		me.onController('cLogin');
	    		me.onStore('login.sLogin');
	    		me.onStore('login.sUser');
		    	me.setUrlProxy('sLogin');				    	
		    					    	
		    	Ext.Msg.hide();
		    	
	    		var view 	=  me.getWindow('ACCESO AL SISTEMA','Admin.view.login.vLogin');
	    			view.show();
	    	});
   		});
   </script>   
</head>
<body>
	 
</body>
</html>
