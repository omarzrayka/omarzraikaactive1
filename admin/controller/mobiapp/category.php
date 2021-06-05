<?php
class ControllerMobiappcategory extends Controller {
	public function index(){
		$this->language->load('mobiapp/category');

		$this->document->setTitle($this->language->get('heading_title'));
		$this->load->model('setting/setting');

	if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->load->model('mobiapp/category');
			$categories = $this->request->post['category'];
			$this->model_mobiapp_category->updateIcons($categories);

			$this->session->data['success'] = $this->language->get('text_success');

			$this->redirect($this->url->link('mobiapp/category', 'token=' . $this->session->data['token'], 'SSL'));
		}
		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_form'] = $this->language->get('text_edit');
		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');
		$this->data['text_default'] = $this->language->get('text_default');
		$this->data['text_product'] = $this->language->get('text_product');
		$this->data['text_category'] = $this->language->get('text_category');
		$this->data['entry_name'] = $this->language->get('entry_name');
		$this->data['entry_date'] = $this->language->get('entry_date');
		$this->data['entry_image'] = $this->language->get('entry_image');
		$this->data['entry_status'] = $this->language->get('entry_status');
		$this->data['entry_icon'] = $this->language->get('entry_icon');
		$this->data['entry_sort_order'] = $this->language->get('entry_sort_order');

		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');
		$this->data['button_banner_add'] = $this->language->get('button_banner_add');
		$this->data['button_remove'] = $this->language->get('button_remove');

		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}

		if (isset($this->error['image'])) {
			$this->data['error_image'] = $this->error['image'];
		} else {
			$this->data['error_image'] = array();
		}
		if(isset($this->session->data['success'])) {
			$this->data['success'] = $this->session->data['success'];
			unset($this->session->data['success']);
		}else {
			$this->data['success'] = '';
		}
		$this->data['breadcrumbs'] = array();

		$this->data['breadcrumbs'][] = array(
			'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => false
		);

		$this->data['breadcrumbs'][] = array(
			'text'      => $this->language->get('text_module'),
			'href'      => $this->url->link('mobiapp/category', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => ' :: '
		);
		$this->load->model('mobiapp/category');
		$this->load->model('tool/image');
		$categories =  $this->model_mobiapp_category->getCategories();
		if(!empty($categories)) {
		foreach ($categories as $category) {
			if (is_file(DIR_IMAGE . $category['image'])) {
				$image = $category['image'];
				$thumb = $category['image'];
			} else {
				$image = '';
				$thumb = 'no_image.jpg';
			}
			if (is_file(DIR_IMAGE . $category['category_icon'])) {
				$category_image = $category['category_icon'];
				$category_thumb = $category['category_icon'];
			} else {
				$category_image = '';
				$category_thumb = 'no_image.jpg';
			}
		$this->data['categories'][] = array(
				'id'  => $category['category_id'],
				'name' => $category['name'],
				'status' => $category['status'],
				'date_added' => $category['date_added'],
				'image' => $this->model_tool_image->resize($thumb, 100, 100),
				'icon_image' => $this->model_tool_image->resize($category_thumb, 100, 100),
				'icon_value' => $category_image
			);
		}
	}
			

		$this->data['action'] = $this->url->link('mobiapp/category', 'token=' . $this->session->data['token'], 'SSL');

		$this->data['cancel'] = $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL');

		$this->data['token'] = $this->session->data['token'];


		$this->load->model('design/layout');

		$this->data['layouts'] = $this->model_design_layout->getLayouts();

		$this->template = 'mobiapp/category.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);

		$this->response->setOutput($this->render());
	}

	protected function validate() {
		if (!$this->user->hasPermission('modify', 'mobiapp/category')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		if (!$this->error) {
			return true;
		} else {
			return false;
		}	
	}
}