<!DOCTYPE HTML>
<html lang="es" manifest="">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
   
    <meta content="text/html; charset=UTF-8" http-equiv="Content-Type"/>
     
    <title>
    	<?php echo TITLE_ADMIN;?>
    </title>
		
    <link rel="stylesheet" type="text/css" href="<?php echo base_url();?>extjs5/build/packages/ext-theme-classic/build/resources/ext-theme-classic-all.css">
    <link rel="stylesheet" type="text/css" href="<?php echo base_url();?>resources/styles.css">
    <link rel="stylesheet" type="text/css" href="<?php echo base_url();?>design/css/bootstrap-theme.min.css">
    <link rel="stylesheet" type="text/css" href="<?php echo base_url();?>design/css/bootstrap.min.css"> 
    <link rel="stylesheet" type="text/css" href="<?php echo base_url();?>design/template/style.css">
	
  	<script  type="text/javascript" src="<?php echo base_url();?>extjs5/build/ext-all-debug.js"></script>
  	<script  type="text/javascript" src="<?php echo base_url();?>extjs5/build/packages/ext-theme-classic/build/ext-theme-classic.js"></script>
  	<script  type="text/javascript" src="<?php echo base_url();?>extjs5/build/packages/ext-locale/build/ext-locale-es.js"></script>
  	
    <script  type="text/javascript" src="<?php echo base_url();?>app/app.js"></script>   
    
   
</head>
<body>
	<div>
	<div class="header-icon">	
			<a href="<?php echo URL_CLOSE_SESSION_SME; ?>" class="btn btn-primary button-session glyphicon glyphicon-user">
                <?php echo NAME_CLOSE_SESSION_SME; ?>
            </a>
	</div>
	</div>
	<div id="poweredby">
		<?php echo 'Año lectivo: '. $this->session->userdata('user_año');?>
		<br/>
		<?php echo 'Usuario docente: '. $this->session->userdata('user_description');?>
	</div>
</body>
</html>
