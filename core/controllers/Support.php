<?php

/**
 * Created by IntelliJ IDEA.
 * User: LOPEZSOFT
 * Date: 2/06/2016
 * Time: 12:17 PM
 */
class Support extends SME_Controller
{
    function __construct()
    {
        parent::__construct();
    }

    public function  index() {
        $this->load->view('template/chat_view');
    }
}