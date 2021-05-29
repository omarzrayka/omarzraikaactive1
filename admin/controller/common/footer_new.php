<?php

class ControllerCommonFooterNew extends Controller
{
    protected function index() {
        $this->template = 'common/footer_new.tpl';
	
    	$this->render();
    }
}
  