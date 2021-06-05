<?php
class ControllerMobiappCustomcollection extends Controller {
	private $error = array(); 

	public function index() {  

		$this->data = array();

		$this->data = array_merge($this->data,$this->language->load('mobiapp/customcollection'));

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('setting/setting');

		$this->load->model('mobiapp/customcollection');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
	
			if ($this->request->post['type'] == 2) {
				$this->request->post['mobiapp_customcollection_customcollection_product'] = $this->model_mobiapp_customcollection->getLatestProducts($this->request->post['count']);
			}

			if ($this->request->post['type'] == 3) {
				if ($this->request->post['attribute'] == 'price') {
					$this->request->post['mobiapp_customcollection_customcollection_product'] = $this->model_mobiapp_customcollection->getProductsByAttribute($this->request->post['attribute'],$this->request->post['attribute_value_price_min'],$this->request->post['attribute_value_price_max']);
				} else if($this->request->post['attribute'] == 'manufacturer'){
					$this->request->post['mobiapp_customcollection_customcollection_product'] = $this->model_mobiapp_customcollection->getProductsByAttribute($this->request->post['attribute'],$this->request->post['attribute_value_manufacturer']);
				} else {
					$this->request->post['mobiapp_customcollection_customcollection_product'] = $this->model_mobiapp_customcollection->getProductsByAttribute($this->request->post['attribute'],$this->request->post['attribute_value_model']);
				}
					
			}

			$this->request->post['mobiapp_customcollection_customcollection_product_names'] = array();
			
			if ($this->request->post['mobiapp_customcollection_customcollection_product']) {
				foreach ($this->request->post['mobiapp_customcollection_customcollection_product'] as $key =>  $value) {
					$this->request->post['mobiapp_customcollection_customcollection_product_names'][$key] = $this->model_mobiapp_customcollection->getProductName($value);	
				}	
			}
			if (isset($this->request->get['id']) && $this->request->get['id']) {
				$this->model_mobiapp_customcollection->addCollection($this->request->get['id'],$this->request->post);			
			} else {
				$this->model_mobiapp_customcollection->addCollection(0,$this->request->post);		
			}	

			$this->session->data['success'] = $this->language->get('text_success');

			$this->redirect($this->url->link('mobiapp/customcollection', 'token=' . $this->session->data['token'], 'SSL'));
			$this->session->data['success'] = $this->language->get('text_success');
		}

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

		$this->data['breadcrumbs'] = array();

		$this->data['breadcrumbs'][] = array(
			'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => false
		);

		$this->data['breadcrumbs'][] = array(
			'text'      => $this->language->get('text_module'),
			'href'      => $this->url->link('mobiapp/customcollection', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => ' :: '
		);

		$this->data['action'] = $this->url->link('mobiapp/customcollection', 'token=' . $this->session->data['token'], 'SSL');

		$this->data['cancel'] = $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL');

		$this->data['token'] = $this->session->data['token'];

		if (isset($this->request->post['mobiapp_customcollection_customcollection_product'])) {
			$this->data['customcollection_product'] = $this->request->post['mobiapp_customcollection_customcollection_product'];
		} else {
			$this->data['customcollection_product'] = $this->config->get('mobiapp_customcollection_customcollection_product');
		}
		if (isset($this->session->data['success'])) {
			$this->data['success'] = $this->session->data['success'];

			unset($this->session->data['success']);
		} else {
			$this->data['success'] = '';
		}


		$this->load->model('catalog/product');

		if (isset($this->request->post['mobiapp_customcollection_customcollection_product'])) {
			$products =  $this->request->post['mobiapp_customcollection_customcollection_product'];
		} else {		
			$products = $this->config->get('mobiapp_customcollection_customcollection_product');
		}
		$collection_total = $this->model_mobiapp_customcollection->getTotalCollection();

		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}

		$pagination = new Pagination();
		$pagination->total = $collection_total;
		$pagination->page = $page;
		$pagination->limit = $this->config->get('config_limit_admin');
		$pagination->url = $this->url->link('mobiapp/customcollection', 'token=' . $this->session->data['token'] .'&page={page}', 'SSL');

		$this->data['pagination'] = $pagination->render();

		$this->data['add'] = $this->url->link('mobiapp/customcollection/add', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['delete'] = $this->url->link('mobiapp/customcollection/delete', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['collections'] = $this->model_mobiapp_customcollection->getCustomCollection();	

		$this->template = 'mobiapp/customcollection_list.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
		$this->response->setOutput($this->render());
	}

	public function add(){
		$this->data = array();

		$this->data = array_merge($this->data,$this->language->load('mobiapp/customcollection'));

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('setting/setting');

		$this->load->model('mobiapp/customcollection');

		$this->load->model('mobiapp/notification');

		

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

		$this->data['breadcrumbs'] = array();

		$this->data['breadcrumbs'][] = array(
			'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
		'separator' => false
		);

		$this->data['breadcrumbs'][] = array(
			'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('mobiapp/customcollection', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => '::'
		);

		$this->data['breadcrumbs'][] = array(
			'text'      => $this->language->get('heading_title_add'),
			'href'      => $this->url->link('mobiapp/customcollection/add', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => '::'
		);

		$this->data['action'] = $this->url->link('mobiapp/customcollection', 'token=' . $this->session->data['token'], 'SSL');

		$this->data['cancel'] = $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL');

		$this->data['token'] = $this->session->data['token'];

		if (isset($this->request->post['mobiapp_customcollection_customcollection_product'])) {
			$this->data['customcollection_product'] = $this->request->post['mobiapp_customcollection_customcollection_product'];
		} else {
			$this->data['customcollection_product'] = '';
		}

		if (isset($this->request->post['name'])) {
			$this->data['customcollection_name'] = $this->request->post['name'];
		} else {
			$this->data['customcollection_name'] = '';
		}

		if (isset($this->session->data['success'])) {
			$this->data['success'] = $this->session->data['success'];

			unset($this->session->data['success']);
		} else {
			$this->data['success'] = '';
		}


		$this->load->model('catalog/product');

		if (isset($this->request->post['mobiapp_customcollection_customcollection_product'])) {
			$products =  $this->request->post['mobiapp_customcollection_customcollection_product'];
		} else {		
			$products = '';
		}
		$this->data['products'] = array();
		if(!empty($products)) {
			foreach ($products as $product_id) {
				$product_info = $this->model_catalog_product->getProduct($product_id);

				if ($product_info) {
					$this->data['products'][] = array(
						'product_id' => $product_info['product_id'],
						'name'       => $product_info['name']
					);
				}
			}	
		}

		$this->template = 'mobiapp/customcollection_form.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
		$this->response->setOutput($this->render());
	}
	protected function validate() {
				
		if (!$this->user->hasPermission('modify', 'mobiapp/customcollection')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if (isset($this->request->post['type']) && !$this->request->post['type']) {
			$this->error['warning'] = $this->language->get('error_type');
		}

		if (isset($this->request->post['type']) && $this->request->post['type'] == 2 && !$this->request->post['count'] > 0) {
			$this->error['warning'] = $this->language->get('error_count');
		}

		if ($this->request->post['type'] == 3) {
			
			if ($this->request->post['attribute'] == 'price') {
				if (!$this->request->post['attribute_value_price_min'] || !$this->request->post['attribute_value_price_max']) {
					$this->error['warning'] = $this->language->get('error_price');
				}
			} else if($this->request->post['attribute'] == 'manufacturer'){
				if (!$this->request->post['attribute_value_manufacturer']) {
					$this->error['warning'] = $this->language->get('error_manufacturer');
				}
			} else {
				if (!$this->request->post['attribute_value_model']) {
					$this->error['warning'] = $this->language->get('error_model');
				}
			}	
		}

		if(!isset($this->request->post['type']))
			return false;
	
		if (!$this->error) {
			return true;
		} else {
			return false;
		}	
	}
	public function delete() {

		$json['success'] = '';
		
		$this->load->model('mobiapp/customcollection');

		$this->language->load('mobiapp/customcollection');
		
		if (isset($this->request->get['id']) && $this->request->get['id']) {
				
			$this->model_mobiapp_customcollection->deleteCollection($this->request->get['id']);
			
			$this->session->data['success'] = $this->language->get('text_success_delete');
			$json['success'] = $this->language->get('text_success_delete');
		}
	
		$this->index();
	}
}
?>