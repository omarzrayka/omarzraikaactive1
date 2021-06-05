<?php
class ControllerMobiappBanner extends Controller {
	private $error = array();

	public function index() {
		$this->load->language('mobiapp/banner');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('mobiapp/banner');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {

			$this->model_mobiapp_banner->editBanner($this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}

			$this->redirect($this->url->link('mobiapp/banner', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}

		$this->getForm();
	}

	protected function getForm() {
		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_form'] = $this->language->get('text_edit');
		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');
		$this->data['text_default'] = $this->language->get('text_default');
		
		$this->data['entry_name'] = $this->language->get('entry_name');
		$this->data['entry_title'] = $this->language->get('entry_title');
		$this->data['entry_type'] = $this->language->get('entry_type');
		$this->data['entry_link'] = $this->language->get('entry_link');
		$this->data['entry_image'] = $this->language->get('entry_image');
		$this->data['entry_status'] = $this->language->get('entry_status');
		$this->data['entry_sort_order'] = $this->language->get('entry_sort_order');

		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');
		$this->data['button_banner_add'] = $this->language->get('button_banner_add');
		$this->data['button_remove'] = $this->language->get('button_remove');

		$this->data['text_product'] = $this->language->get('text_product');
		$this->data['text_category'] = $this->language->get('text_category');
		$this->data['text_manufacturer'] = $this->language->get('text_manufacturer');
		$this->data['text_seller'] = $this->language->get('text_seller');
		$this->data['text_search'] = $this->language->get('text_search');
		
		
		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}

		if (isset($this->session->data['success'])) {
			$this->data['success'] = $this->session->data['success'];
			unset($this->session->data['success']);
		} else {
			$this->data['success'] = '';
		}

		if (isset($this->error['title'])) {
			$this->data['error_title'] = $this->error['title'];
		} else {
			$this->data['error_title'] = '';
		}

		if (isset($this->error['banner_image'])) {
			$this->data['error_banner_image'] = $this->error['banner_image'];
		} else {
			$this->data['error_banner_image'] = array();
		}

		$url = '';

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}

		$this->data['breadcrumbs'] = array();

		$this->data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => false
		);

		$this->data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('mobiapp/banner', 'token=' . $this->session->data['token'] . $url, 'SSL'),
			'separator' => ' :: '
		);

		$this->data['action'] = $this->url->link('mobiapp/banner', 'token=' . $this->session->data['token'] . $url, 'SSL');

		$this->data['cancel'] = $this->url->link('common/home', 'token=' . $this->session->data['token'] . $url, 'SSL');

		$this->data['token'] = $this->session->data['token'];

		$this->load->model('localisation/language');

		$this->data['languages'] = $this->model_localisation_language->getLanguages();

		$this->load->model('tool/image');

		if (isset($this->request->post['banner_image'])) {
			$banner_images = $this->request->post['banner_image'];
		} else {
			$banner_images = $this->model_mobiapp_banner->getBannerImages();
		}

		$this->data['banner_images'] = array();

		foreach ($banner_images as $banner_image) {
			if (is_file(DIR_IMAGE . $banner_image['image'])) {
				$image = $banner_image['image'];
				$thumb = $banner_image['image'];
			} else {
				$image = '';
				$thumb = 'no_image.jpg';
			}

			$this->data['banner_images'][] = array(
				'banner_image_description' => $banner_image['banner_image_description'],
				'type'                     => $banner_image['type'],
				'id'        	           => $banner_image['id'],
				'name'                     => $banner_image['name'],
				'image'                    => $image,
				'thumb'                    => $this->model_tool_image->resize($thumb, 100, 100),
				'sort_order'               => $banner_image['sort_order']
			);
		}

		$this->data['placeholder'] = $this->model_tool_image->resize('no_image.png', 100, 100);
		$this->load->model('design/layout');
		
		$this->data['layouts'] = $this->model_design_layout->getLayouts();
		
		
		$this->template = 'mobiapp/banner.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
		$this->response->setOutput($this->render());
	}

	protected function validateForm() {
		if (!$this->user->hasPermission('modify', 'mobiapp/banner')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if (isset($this->request->post['banner_image'])) {
			foreach ($this->request->post['banner_image'] as $banner_image_id => $banner_image) {
				foreach ($banner_image['banner_image_description'] as $language_id => $banner_image_description) {
					if ((utf8_strlen($banner_image_description['title']) < 2) || (utf8_strlen($banner_image_description['title']) > 64)) {
						$this->error['banner_image'][$banner_image_id][$language_id] = $this->language->get('error_title');
					}
				}
			}
		}

		return !$this->error;
	}
}