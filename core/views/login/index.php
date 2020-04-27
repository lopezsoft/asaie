<?php
defined('BASEPATH') OR exit('No direct script access allowed');
?>

<!DOCTYPE html>
<html lang="es" xmlns="http://www.w3.org/1999/html">

    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
        <title>
            <?php echo lang('login_title') ?>
        </title>
        <link rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.1.3/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.13/css/all.css">
        <link rel="stylesheet" href="<?php echo base_url();?>assets/css/styles.min.css">
        <link rel="stylesheet" href="<?php echo base_url();?>assets/alertifyjs/css/alertify.min.css">
        <link rel="stylesheet" href="<?php echo base_url();?>assets/alertifyjs/css/themes/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/5.0.0/normalize.min.css">
    </head>

    <body>
        <!-- Start: Login Form Dark -->
        <div class="login-dark">
            <form class="login" action="<?php echo base_url();?>login/log_in" style="padding: 10px;">
                <div class="illustration" style="padding: 5px;"><i class="fas fa-user-lock"></i></div>
                <div class="form-group">
                    <label style="width: 100%;">
                        <strong><?php echo lang('login_form_message'); ?></strong>
                    </label>
                </div>
                <div class="form-group">
                    <input class="form-control" type="text" name="user" id="user" required=""
                        placeholder="<?php echo lang('login_user') ?>" autofocus="">
                </div>
                <div class="form-group">
                    <input class="form-control" type="password" id="pass" name="pass" required=""
                        placeholder="<?php echo lang('login_password') ?>"></div>

                <div class="form-group">
                    <select class="form-control" name="inst" required="" id="inst">
                        <option value="0"><?php echo lang('login_IDINST') ?></option>
                        <?php 
                            foreach ($schools as $key => $value) {
                                echo '<option value="'.$value['statecode'].'">'.$value['nameschool'].'</option>';
                            }
                        ?>
                    </select>
                </div>
                <div class="form-group">
                    <input class="form-control" type="number" name="year" id="year" required=""
                        value="<?php echo date('Y') ?>" placeholder="<?php echo lang('login_year') ?>" min="2000"
                        max="2050" step="1">
                </div>
                <div class="form-group">
                    <button class="btn btn-primary btn-block">
                        <i class="fa fa-user" aria-hidden="true"></i>
                        <?php echo lang('login_button_text'); ?>
                    </button>
                </div><a href="#" class="forgot"><?php echo lang('login_forgot_password') ?></a>
            </form>
        </div>
        <!-- End: Login Form Dark -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/prefixfree/1.0.7/prefixfree.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.1.3/js/bootstrap.bundle.min.js">
        </script>
        <script src="<?php echo base_url();?>assets/js/index.js"></script>
        <script src="<?php echo base_url();?>assets/js/hash.js"></script>
        <script src="<?php echo base_url();?>assets/alertifyjs/alertify.min.js"></script>
        <!--Start of Tawk.to Script-->
        <script type="text/javascript">
            var Tawk_API=Tawk_API||{}, Tawk_LoadStart=new Date();
            (function(){
            var s1=document.createElement("script"),s0=document.getElementsByTagName("script")[0];
            s1.async=true;
            s1.src='https://embed.tawk.to/5807d50c9ca1830bdc9744c2/default';
            s1.charset='UTF-8';
            s1.setAttribute('crossorigin','*');
            s0.parentNode.insertBefore(s1,s0);
            })();
        </script>
        <!--End of Tawk.to Script-->
    </body>

</html>
