<?php
/**
* Mobiapp module's controller
*/
class ControllerModuleMobiapp extends Controller {
	private $error = array();

	public function install() {
		$this->load->model('module/mobiapp');
		$this->model_module_mobiapp->createTable();
	}

	public function uninstall() {
		$this->load->model('module/mobiapp');
		$this->model_module_mobiapp->deleteTable();
	}

	public function index() {
		$lang_array = $this->load->language('module/mobiapp');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('setting/setting');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_setting_setting->editSetting('mobiapp', $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$this->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
		}

		foreach ($lang_array as $key => $value) {
			$this->data[$key] = $value;
		}

		$errorData = array(
			'warning',
			'playstore_link',
			'applestore_link',
		);

		foreach($errorData as $key) {
			if (isset($this->error[$key])) {
				$this->data['error_'.$key] = $this->error[$key];
			} else {
				$this->data['error_'.$key] = '';
			}
		}

		if (isset($this->session->data['success'])) {
			$this->data['success'] = $this->session->data['success'];

			unset($this->session->data['success']);
		} else {
			$this->data['success'] = '';
		}

		$this->data['breadcrumbs'] = array();

		$this->data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => false
		);

		$this->data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_module'),
			'href' => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => ' :: '
		);

		$this->data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('module/mobiapp', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => ' :: '
		);

		$this->data['action'] = $this->url->link('module/mobiapp', 'token=' . $this->session->data['token'], 'SSL');

		$this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');

		$config_array = array(
					'mobiapp_status',
					'mobiapp_api_key',
					'mobiapp_api_password',
					'mobiapp_banner_status',
					'mobiapp_notification_status',
					'mobiapp_gcm_key',
					'mobiapp_carousel_status',
					'mobiapp_featured_status',
					'mobiapp_theme_status',
					'mobiapp_theme_value',
					'mobiapp_playstore_link_status',
					'mobiapp_applestore_link_status',
					'mobiapp_playstore_link',
					'mobiapp_applestore_link',
					'mobiapp_header_status',
					'mobiapp_footer_status',
					'mobiapp_front_text'
			);

		foreach ($config_array as $config_val) {

			if (isset($this->request->post[$config_val])) {
				$this->data[$config_val] = $this->request->post[$config_val];
			} else {
				$this->data[$config_val] = $this->config->get($config_val);
			}

		}
		$this->data['modules'] = array();
		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');
		$this->data['text_content_top'] = $this->language->get('text_content_top');
		$this->data['text_content_bottom'] = $this->language->get('text_content_bottom');
		$this->data['text_column_left'] = $this->language->get('text_column_left');
		$this->data['text_column_right'] = $this->language->get('text_column_right');

		$this->data['entry_layout'] = $this->language->get('entry_layout');
		$this->data['entry_position'] = $this->language->get('entry_position');
		$this->data['entry_status'] = $this->language->get('entry_status');
		$this->data['entry_sort_order'] = $this->language->get('entry_sort_order');
		$this->load->model('design/layout');

		$this->data['layouts'] = $this->model_design_layout->getLayouts();


		$this->template = 'module/mobiapp.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);

		$this->response->setOutput($this->render());
	}

	protected function validate() {

		if(isset($this->request->post['mobiapp_playstore_link_status']) && $this->request->post['mobiapp_playstore_link_status']) {
			$this->request->get['application_url'] = $this->request->post['mobiapp_playstore_link'];
			if(!$this->checkUrl()['status']) {
				$this->error['playstore_link'] = $this->language->get('error_store_link');
			}
		}

		if(isset($this->request->post['mobiapp_applestore_link_status']) && $this->request->post['mobiapp_applestore_link_status']) {
			$this->request->get['application_url'] = $this->request->post['mobiapp_applestore_link'];
			if(!$this->checkUrl()['status']) {
				$this->error['applestore_link'] = $this->language->get('error_store_link');
			}
		}

		if (!$this->user->hasPermission('modify', 'module/mobiapp')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		return !$this->error;
	}

	public function checkUrl() {
		if(isset($this->request->get['application_url']) && $this->request->get['application_url']) {
			$url = $this->request->get['application_url'];
			$ch = @curl_init($url);
			@curl_setopt($ch, CURLOPT_HEADER, TRUE);
			@curl_setopt($ch, CURLOPT_NOBODY, TRUE);
			@curl_setopt($ch, CURLOPT_FOLLOWLOCATION, FALSE);
			@curl_setopt($ch, CURLOPT_RETURNTRANSFER, TRUE);
			$status = array();
			preg_match('/HTTP\/.* ([0-9]+) .*/', @curl_exec($ch) , $status);
			if(isset($status[1]) && $status[1] == 200) {
				$json = array('status' => true );
			} else {
				$json = array('status' => false );
			}
		} else {
			$json = array('status' => false );
		}
		curl_close($ch);
		if(isset($this->request->post['mobiapp_api_key'])) {
			return $json;
		}
		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}
}
