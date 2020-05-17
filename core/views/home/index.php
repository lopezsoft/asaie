<?php
defined('BASEPATH') OR exit('No direct script access allowed');
?>
<!DOCTYPE html>
<html lang="es">
	<head>
		<meta http-equiv="Expires" content="0">
		<meta http-equiv="Last-Modified" content="0">
		<meta http-equiv="Cache-Control" content="no-cache, mustrevalidate">
		<meta http-equiv="Pragma" content="no-cache">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
		<meta content="text/html; charset=UTF-8" http-equiv="Content-Type"/>
		<meta charset="utf-8">
		<title>
			<?php echo lang('login_title') ?>
		</title>
    	<!-- <link rel="stylesheet" href="<?php echo base_url();?>assets/css/bootstrap-theme.min.css"/> -->
		<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css" integrity="sha384-50oBUHEmvpQ+1lW4y57PTFmhCaXp0ML5d60M1M7uH2+nqUivzIebhndOJK28anvf" crossorigin="anonymous">
    	<link rel="stylesheet" href="<?php echo base_url();?>assets/css/mystyle.css"/>
    	<link rel="stylesheet" href="<?php echo base_url();?>assets/css/site.css"/>
    	<link rel="stylesheet" href="<?php echo base_url();?>assets/import.css"/>
        <script src="<?php echo base_url()?>assets/js/socket.io.js"></script>
        <script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
		<script src="<?php echo base_url()?>assets/js/toastr.min.js"></script>
		<script type="text/javascript">
            // toastr.info('Are you the 6 fingered man?');
        var Ext = Ext || {}; // Ext namespace won't be defined yet...

        // This function is called by the Microloader after it has performed basic
        // device detection. The results are provided in the "tags" object. You can
        // use these tags here or even add custom tags. These can be used by platform
        // filters in your manifest or by platformConfig expressions in your app.
        //
        Ext.beforeLoad = function (tags) {
            var s = location.search,  // the query string (ex "?foo=1&bar")
                profile;

            // For testing look for "?classic" or "?modern" in the URL to override
            // device detection default.
            //
            if (s.match(/\bclassic\b/)) {
                profile = 'classic';
            }
            else if (s.match(/\bmodern\b/)) {
                profile = 'modern';
            }
            // uncomment this if you have added native build profiles to your app.json
            /*else if (tags.webview) {
                if (tags.ios) {
                    profile = 'ios';
                }
                // add other native platforms here
            }*/
            else {
                //profile = tags.desktop ? 'classic' : 'modern';
                profile = tags.phone ? 'modern' : 'classic';
            }

            Ext.manifest = profile; // this name must match a build profile name

            // This function is called once the manifest is available but before
            // any data is pulled from it.
            //
            //return function (manifest) {
                // peek at / modify the manifest object
            //};
        };
    </script>
	<!-- The line below must be kept intact for Sencha Cmd to build your application -->
    <script id="microloader" type="text/javascript" src="bootstrap.js"></script>
    <script src="<?php echo base_url();?>assets/js/hash.min.js"></script>
	</head>
<body>
	<audio id="notif_eval">
      <source src="<?php echo base_url('assets/sounds/notify.ogg');?>" type="audio/ogg">
      <source src="<?php echo base_url('assets/sounds/notify.mp3');?>" type="audio/mpeg">
      <source src="<?php echo base_url('assets/sounds/notify.wav');?>" type="audio/wav">
    </audio>
    <audio id="notif_docs">
      <source src="<?php echo base_url('assets/sounds/Chime.ogg');?>" type="audio/ogg">
      <source src="<?php echo base_url('assets/sounds/Chime.mp3');?>" type="audio/mpeg">
      <source src="<?php echo base_url('assets/sounds/Chime.wav');?>" type="audio/wav">
    </audio>
     <audio id="notif_messages">
      <source src="<?php echo base_url('assets/sounds/notify_message.ogg');?>" type="audio/ogg">
      <source src="<?php echo base_url('assets/sounds/notify_message.mp3');?>" type="audio/mpeg">
      <source src="<?php echo base_url('assets/sounds/notify_message.wav');?>" type="audio/wav">
    </audio>
     <audio id="notif_email">
      <source src="<?php echo base_url('assets/sounds/Trill.ogg');?>" type="audio/ogg">
      <source src="<?php echo base_url('assets/sounds/Trill.mp3');?>" type="audio/mpeg">
      <source src="<?php echo base_url('assets/sounds/Trill.wav');?>" type="audio/wav">
    </audio>    
	<div id="global-spinner" class="spinner">
        <div class="blob blob-0"></div>
        <div class="blob blob-1"></div>
        <div class="blob blob-2"></div>
        <div class="blob blob-3"></div>
        <div class="blob blob-4"></div>
        <div class="blob blob-5"></div>
    </div>
</body>
</html>