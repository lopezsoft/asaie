<?php
defined('BASEPATH') OR exit('No direct script access allowed');
?>
<!DOCTYPE html>
<html lang="en" xmlns="http://www.w3.org/1999/html">
	<head>
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
		<meta content="text/html; charset=UTF-8" http-equiv="Content-Type"/>
		<meta charset="utf-8">
		<title>
			SME SOFTWARE ESCOLAR ONLINE
		</title>
		<link rel="stylesheet" type="text/css" href="<?php echo base_url();?>ext/build/classic/theme-triton/resources/theme-triton-all.css">
		<link rel="stylesheet" href="<?php echo base_url();?>assets/css/style.css"/>
		<link rel="stylesheet" href="<?php echo base_url();?>assets/css/Admin-all.css"/>
		<script type="text/javascript" src="<?php echo base_url();?>sockets/node_modules/socket.io-client/dist/socket.io.js">
		</script>
		<!-- Extjs -->
		<script type="text/javascript" src="<?php echo base_url();?>ext/build/ext-all-debug.min.js">
		</script>
		<script  type="text/javascript" src="<?php echo base_url();?>ext/build/classic/theme-triton/theme-triton.js">
		</script>
  		<script  type="text/javascript" src="<?php echo base_url();?>ext/build/classic/locale/locale-es.js">
  		</script>
  		<script  type="text/javascript" src="<?php echo base_url();?>app/app.js"></script>
  		<script type="text/javascript">
		    Ext.Loader.setConfig({
			enabled	: true,
				paths	: {
					SME	: "../../app"
				}
			});
		</script>
	</head>
<body>
	
</body>
</html>