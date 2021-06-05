<?php
class ControllerMobiappNotification extends Controller {
	private $error = array();

	public function index() {
		$this->load->language('mobiapp/notification');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('mobiapp/notification');

		$this->getList();
	}

	public function add() {
		$lang_array = $this->load->language('mobiapp/notification');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('mobiapp/notification');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {

			if ($this->request->post['type'] == 4) {
				$this->request->post['id'] = $this->request->post['input-custom_id']; 	
				$this->request->post['product_category'] = $this->model_mobiapp_notification->getCustomCollectionName($this->request->post['input-custom_id']);
			}

			$notification_id = $this->model_mobiapp_notification->addNotification($this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			if (isset($this->request->post['send'])) {
				if ($this->config->get('mobiapp_notification_status')) {
					$this->sendNotification($notification_id);
					$this->session->data['success'] = $this->language->get('text_send_success');
				} else {
					$this->session->data['error_warning'] = $this->language->get('text_not_send');
				}				
			}

			$url = '';

			if (isset($this->request->get['filter_title'])) {
				$url .= '&filter_title=' . urlencode(html_entity_decode($this->request->get['filter_title'], ENT_QUOTES, 'UTF-8'));
			}

			if (isset($this->request->get['filter_type'])) {
				$url .= '&filter_type=' . $this->request->get['filter_type'];
			}

			if (isset($this->request->get['filter_status'])) {
				$url .= '&filter_status=' . $this->request->get['filter_status'];
			}

			if (isset($this->request->get['filter_date_added'])) {
				$url .= '&filter_date_added=' . $this->request->get['filter_date_added'];
			}

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}

			$this->redirect($this->url->link('mobiapp/notification', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}

		$this->getForm();
	}

	public function edit() {
		$lang_array = $this->load->language('mobiapp/notification');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('mobiapp/notification');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {

			if ($this->request->post['type'] == 4) {
				$this->request->post['id'] = $this->request->post['input-custom_id'];
				$this->request->post['product_category'] = $this->model_mobiapp_notification->getCustomCollectionName($this->request->post['input-custom_id']);
			}

			$this->model_mobiapp_notification->editNotification($this->request->get['notification_id'], $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			if (isset($this->request->post['send'])) {
				if ($this->config->get('mobiapp_notification_status')) {
					$this->sendNotification($this->request->get['notification_id']);
					$this->session->data['success'] = $this->language->get('text_send_success');
				} else {
					$this->session->data['error_warning'] = $this->language->get('text_not_send');
				}				
			}

			$url = '';

			if (isset($this->request->get['filter_title'])) {
				$url .= '&filter_title=' . urlencode(html_entity_decode($this->request->get['filter_title'], ENT_QUOTES, 'UTF-8'));
			}

			if (isset($this->request->get['filter_type'])) {
				$url .= '&filter_type=' . $this->request->get['filter_type'];
			}

			if (isset($this->request->get['filter_status'])) {
				$url .= '&filter_status=' . $this->request->get['filter_status'];
			}

			if (isset($this->request->get['filter_date_added'])) {
				$url .= '&filter_date_added=' . $this->request->get['filter_date_added'];
			}

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}

			$this->redirect($this->url->link('mobiapp/notification', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}

		$this->getForm();
	}

	public function delete() {
		$lang_array = $this->load->language('mobiapp/notification');

		foreach ($lang_array as $key => $value) {
			$this->data[$key] = $value;
		}

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('mobiapp/notification');

		if (isset($this->request->post['selected']) && $this->validateDelete()) {
			foreach ($this->request->post['selected'] as $notification_id) {
				$this->model_mobiapp_notification->deleteNotification($notification_id);
			}

			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';

			if (isset($this->request->get['filter_title'])) {
				$url .= '&filter_title=' . urlencode(html_entity_decode($this->request->get['filter_title'], ENT_QUOTES, 'UTF-8'));
			}

			if (isset($this->request->get['filter_type'])) {
				$url .= '&filter_type=' . $this->request->get['filter_type'];
			}

			if (isset($this->request->get['filter_status'])) {
				$url .= '&filter_status=' . $this->request->get['filter_status'];
			}

			if (isset($this->request->get['filter_date_added'])) {
				$url .= '&filter_date_added=' . $this->request->get['filter_date_added'];
			}

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}

			$this->redirect($this->url->link('mobiapp/notification', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}

		$this->getList();
	}

	protected function getList() {
		if (isset($this->request->get['filter_title'])) {
			$filter_title = $this->request->get['filter_title'];
		} else {
			$filter_title = null;
		}

		if (isset($this->request->get['filter_type'])) {
			$filter_type = $this->request->get['filter_type'];
		} else {
			$filter_type = null;
		}

		if (isset($this->request->get['filter_status'])) {
			$filter_status = $this->request->get['filter_status'];
		} else {
			$filter_status = null;
		}

		if (isset($this->request->get['filter_date_added'])) {
			$filter_date_added = $this->request->get['filter_date_added'];
		} else {
			$filter_date_added = null;
		}

		if (isset($this->request->get['sort'])) {
			$sort = $this->request->get['sort'];
		} else {
			$sort = 'mnd.title';
		}

		if (isset($this->request->get['order'])) {
			$order = $this->request->get['order'];
		} else {
			$order = 'ASC';
		}

		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}

		$url = '';

		if (isset($this->request->get['filter_title'])) {
			$url .= '&filter_title=' . urlencode(html_entity_decode($this->request->get['filter_title'], ENT_QUOTES, 'UTF-8'));
		}

		if (isset($this->request->get['filter_type'])) {
			$url .= '&filter_type=' . $this->request->get['filter_type'];
		}

		if (isset($this->request->get['filter_status'])) {
			$url .= '&filter_status=' . $this->request->get['filter_status'];
		}

		if (isset($this->request->get['filter_date_added'])) {
			$url .= '&filter_date_added=' . $this->request->get['filter_date_added'];
		}

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
			'href' => $this->url->link('mobiapp/notification', 'token=' . $this->session->data['token'] . $url, 'SSL'),
			'separator' =>  ' :: '
		);

		$this->data['send'] = $this->url->link('mobiapp/notification/send', 'token=' . $this->session->data['token'] . $url, 'SSL');
		$this->data['add'] = $this->url->link('mobiapp/notification/add', 'token=' . $this->session->data['token'] . $url, 'SSL');
		$this->data['delete'] = $this->url->link('mobiapp/notification/delete', 'token=' . $this->session->data['token'] . $url, 'SSL');

		$this->data['notifications'] = array();

		$filter_data = array(
			'filter_title'      => $filter_title,
			'filter_type'       => $filter_type,
			'filter_status'     => $filter_status,
			'filter_date_added' => $filter_date_added,
			'sort'              => $sort,
			'order'             => $order,
			'start'             => ($page - 1) * $this->config->get('config_limit_admin'),
			'limit'             => $this->config->get('config_limit_admin')
		);

		$notification_total = $this->model_mobiapp_notification->getTotalNotifications($filter_data);

		$results = $this->model_mobiapp_notification->getNotifications($filter_data);
		$this->load->model('tool/image');
		foreach ($results as $result) {
			if (is_file(DIR_IMAGE . $result['image'])) {
				$image = $result['image'];
			} else {
				$image = 'no_image.jpg';
			}

			$this->data['notifications'][] = array(
				'notification_id' => $result['notification_id'],
				'title'        => $result['title'],
				'type'         => $result['type'],
				'status'       => $result['status'] ? $this->language->get('text_enabled') : $this->language->get('text_disabled'),
				'content'      => (html_entity_decode($result['content']) > 50) ? substr(html_entity_decode($result['content']), 0, 50).'...' : html_entity_decode($result['content']),
				'date_added'   => date($this->language->get('date_format_short'), strtotime($result['date_added'])),
				'edit'         => $this->url->link('mobiapp/notification/edit', 'token=' . $this->session->data['token'] . '&notification_id=' . $result['notification_id'] . $url, 'SSL'),
				'image'        => $this->model_tool_image->resize($image, 100, 100)
			);
		}

		$lang_array = $this->load->language('mobiapp/notification');

		foreach ($lang_array as $key => $value) {
			$this->data[$key] = $value;
		}

		$this->data['token'] = $this->session->data['token'];

		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}

		if (isset($this->session->data['error_warning'])) {
			$this->data['error_warning'] = $this->session->data['error_warning'];

			unset($this->session->data['error_warning']);
		}

		if (isset($this->session->data['success'])) {
			$this->data['success'] = $this->session->data['success'];

			unset($this->session->data['success']);
		} else {
			$this->data['success'] = '';
		}

		if (isset($this->request->post['selected'])) {
			$this->data['selected'] = (array)$this->request->post['selected'];
		} else {
			$this->data['selected'] = array();
		}

		$url = '';

		if (isset($this->request->get['filter_title'])) {
			$url .= '&filter_title=' . urlencode(html_entity_decode($this->request->get['filter_title'], ENT_QUOTES, 'UTF-8'));
		}

		if (isset($this->request->get['filter_type'])) {
			$url .= '&filter_type=' . $this->request->get['filter_type'];
		}

		if (isset($this->request->get['filter_status'])) {
			$url .= '&filter_status=' . $this->request->get['filter_status'];
		}

		if (isset($this->request->get['filter_date_added'])) {
			$url .= '&filter_date_added=' . $this->request->get['filter_date_added'];
		}

		if ($order == 'ASC') {
			$url .= '&order=DESC';
		} else {
			$url .= '&order=ASC';
		}

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}

		$this->data['sort_title'] = $this->url->link('mobiapp/notification', 'token=' . $this->session->data['token'] . '&sort=mn.title' . $url, 'SSL');
		$this->data['sort_type'] = $this->url->link('mobiapp/notification', 'token=' . $this->session->data['token'] . '&sort=mn.type' . $url, 'SSL');
		$this->data['sort_status'] = $this->url->link('mobiapp/notification', 'token=' . $this->session->data['token'] . '&sort=mn.status' . $url, 'SSL');
		$this->data['sort_date_added'] = $this->url->link('mobiapp/notification', 'token=' . $this->session->data['token'] . '&sort=mn.date_added' . $url, 'SSL');

		$url = '';

		if (isset($this->request->get['filter_title'])) {
			$url .= '&filter_title=' . urlencode(html_entity_decode($this->request->get['filter_title'], ENT_QUOTES, 'UTF-8'));
		}

		if (isset($this->request->get['filter_type'])) {
			$url .= '&filter_type=' . $this->request->get['filter_type'];
		}

		if (isset($this->request->get['filter_status'])) {
			$url .= '&filter_status=' . $this->request->get['filter_status'];
		}

		if (isset($this->request->get['filter_date_added'])) {
			$url .= '&filter_date_added=' . $this->request->get['filter_date_added'];
		}

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}
		$this->data['button_insert'] = $this->language->get('button_insert');	

		$pagination = new Pagination();
		$pagination->total = $notification_total;
		$pagination->page = $page;
		$pagination->limit = $this->config->get('config_limit_admin');
		$pagination->url = $this->url->link('mobiapp/notification', 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');

		$this->data['pagination'] = $pagination->render();

		//$this->data['results'] = sprintf($this->language->get('text_pagination'), ($notification_total) ? (($page - 1) * $this->config->get('config_limit_admin')) + 1 : 0, ((($page - 1) * $this->config->get('config_limit_admin')) > ($notification_total - $this->config->get('config_limit_admin'))) ? $notification_total : ((($page - 1) * $this->config->get('config_limit_admin')) + $this->config->get('config_limit_admin')), $notification_total, ceil($notification_total / $this->config->get('config_limit_admin')));

		$this->load->model('design/layout');
		
		$this->data['layouts'] = $this->model_design_layout->getLayouts();
		
		
		$this->template = 'mobiapp/notification_list.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
			
		$this->data['filter_title'] = $filter_title;
		$this->data['filter_type'] = $filter_type;
		$this->data['filter_status'] = $filter_status;
		$this->data['filter_date_added'] = $filter_date_added;

		$this->data['sort'] = $sort;
		$this->data['order'] = $order;
		$this->response->setOutput($this->render());
	}

	protected function getForm() {
		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_form'] = !isset($this->request->get['notification_id']) ? $this->language->get('text_add') : $this->language->get('text_edit');
		
		$lang_array = $this->load->language('mobiapp/notification');

		foreach ($lang_array as $key => $value) {
			$this->data[$key] = $value;
		}

		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}

		if (isset($this->error['title'])) {
			$this->data['error_title'] = $this->error['title'];
		} else {
			$this->data['error_title'] = '';
		}

		if (isset($this->error['id'])) {
			$this->data['error_id'] = $this->error['id'];
		} else {
			$this->data['error_id'] = '';
		}

		$url = '';

		if (isset($this->request->get['filter_title'])) {
			$url .= '&filter_title=' . urlencode(html_entity_decode($this->request->get['filter_title'], ENT_QUOTES, 'UTF-8'));
		}

		if (isset($this->request->get['filter_type'])) {
			$url .= '&filter_type=' . $this->request->get['filter_type'];
		}

		if (isset($this->request->get['filter_status'])) {
			$url .= '&filter_status=' . $this->request->get['filter_status'];
		}

		if (isset($this->request->get['filter_date_added'])) {
			$url .= '&filter_date_added=' . $this->request->get['filter_date_added'];
		}

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
			'href' => $this->url->link('mobiapp/notification', 'token=' . $this->session->data['token'] . $url, 'SSL'),
			'separator' => ' :: '
		);

		if (!isset($this->request->get['notification_id'])) {
			$this->data['action'] = $this->url->link('mobiapp/notification/add', 'token=' . $this->session->data['token'] . $url, 'SSL');
		} else {
			$this->data['action'] = $this->url->link('mobiapp/notification/edit', 'token=' . $this->session->data['token'] . '&notification_id=' . $this->request->get['notification_id'] . $url, 'SSL');
		}

		$this->data['cancel'] = $this->url->link('mobiapp/notification', 'token=' . $this->session->data['token'] . $url, 'SSL');

		if (isset($this->request->get['notification_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
			$notification_info = $this->model_mobiapp_notification->getNotification($this->request->get['notification_id']);
		}
		$this->data['token'] = $this->session->data['token'];

		$this->data['store'] = HTTP_CATALOG;

		if (isset($this->request->post['title'])) {
			$this->data['title'] = $this->request->post['title'];
		} elseif (!empty($notification_info)) {
			$this->data['title'] = $notification_info['title'];
		} else {
			$this->data['title'] = '';
		}
		if(isset($this->request->post['image'])) {
			if (is_file(DIR_IMAGE . $this->request->post['image'])) 
				$image = $this->request->post['image'];
			else 
				$image = 'no_image.jpg';
		} elseif (!empty($notification_info) && $notification_info['image']) {
			if (is_file(DIR_IMAGE . $notification_info['image'])) 
				$image = $notification_info['image'];
			else 
				$image = 'no_image.jpg';
		} else {
				$image = 'no_image.jpg';
		}
		$this->load->model('tool/image');
		$this->data['thumb'] = $image;
		$this->data['image'] = $this->model_tool_image->resize($image, 100, 100);

		if (isset($this->request->post['content'])) {
			$this->data['content'] = $this->request->post['content'];
		} elseif (!empty($notification_info)) {
			$this->data['content'] = $notification_info['content'];
		} else {
			$this->data['content'] = '';
		}

		if (isset($this->request->post['type'])) {
			$this->data['type'] = $this->request->post['type'];
		} elseif (!empty($notification_info)) {
			$this->data['type'] = $notification_info['type'];
		} else {
			$this->data['type'] = '';
		}

		if (isset($this->request->post['name'])) {
			$this->data['name'] = $this->request->post['name'];
		} elseif (!empty($notification_info)) {
			$this->data['name'] = $notification_info['name'];
		} else {
			$this->data['name'] = '';
		}

		if (isset($this->request->post['id'])) {
			$this->data['id'] = $this->request->post['id'];
		} elseif (!empty($notification_info)) {
			$this->data['id'] = $notification_info['pro_cat_id'];
		} else {
			$this->data['id'] = '';
		}

		if (isset($this->request->post['status'])) {
			$this->data['status'] = $this->request->post['status'];
		} elseif (!empty($notification_info)) {
			$this->data['status'] = $notification_info['status'];
		} else {
			$this->data['status'] = '';
		}
		$this->data['no_image'] = $this->model_tool_image->resize('no_image.jpg',100,100);
		
		$this->data['image_name'] = $image;
		
		$this->load->model('localisation/language');

		$this->data['languages'] = $this->model_localisation_language->getLanguages();

		$this->load->model('design/layout');
		
		$this->data['layouts'] = $this->model_design_layout->getLayouts();
		
		$this->data['custom_collections'] = $this->model_mobiapp_notification->getCustomCollection();
		
		$this->template = 'mobiapp/notification_form.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);

		$this->response->setOutput($this->render());
	}


	public function getItemById() {

		$this->load->model('catalog/product');
		$this->load->model('catalog/category');
	
		$json = array();

		
			if ($this->request->post['type'] == 2){

				$results = $this->model_catalog_category->getCategoriesById($this->request->get['filter_name']);
				
            
				foreach ($results as $result) {
					$json[] = array(
						'id'		=> $result['category_id'],
						'name'		=> strip_tags(html_entity_decode($result['name'], ENT_QUOTES, 'UTF-8'))
					);
				}
			}
	
		
		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}

	public function getItem() {
	
		$json = array();

		if (isset($this->request->post['type']) && isset($this->request->get['filter_name'])) {

			$filter_data = array(
				'filter_name' => '%'.$this->request->get['filter_name'],
				'sort'        => 'name',
				'order'       => 'DESC',
				'start'       => 0,
				'limit'       => 8
			);
			


			$this->load->model('catalog/product');
			$this->load->model('catalog/category');
			//product
			if ($this->request->post['type'] == 1) {

				$results = $this->model_catalog_product->getProducts($filter_data);
			
				foreach ($results as $result) {
					$json[] = array(
						'id'		=> $result['product_id'],
						'name'		=> strip_tags(html_entity_decode($result['name'], ENT_QUOTES, 'UTF-8'))
					);
				}				
			//category
			} elseif ($this->request->post['type'] == 2) {

				$results = $this->model_catalog_category->getCategories($filter_data);

				foreach ($results as $result) {
					$json[] = array(
						'id'		=> $result['category_id'],
						'name'		=> strip_tags(html_entity_decode($result['name'], ENT_QUOTES, 'UTF-8'))
					);
				}
				
			
			//manufacturer	
			}elseif ($this->request->post['type'] == 3) {
				$term = $filter_data['filter_name'];

						//brand data
		    	$brands = $this->db->query("SELECT  manufacturer_id, name, image FROM " . DB_PREFIX . "manufacturer WHERE name COLLATE UTF8_GENERAL_CI LIKE '" . $this->db->escape(trim(utf8_strtolower($term))) . "%' ");
		

				foreach ($brands as $brand) {
					$json[] = array(
						'id'		=> $brand['manufacturer_id'],
						'name'		=> strip_tags(html_entity_decode($brand['name'], ENT_QUOTES, 'UTF-8'))
					);
				}
			//seller
			} elseif ($this->request->post['type'] == 4) {
				
				$term = $filter_data['filter_name'];
				$sellers = $this->db->query("SELECT  seller_id, name, image FROM " . DB_PREFIX . "seller WHERE name COLLATE UTF8_GENERAL_CI LIKE '" . $this->db->escape(trim(utf8_strtolower($term))) . "%' ");
			
			
				
				foreach ($sellers as $seller) {
					$json[] = array(
						'id'		=> $seller['seller_id'],
						'name'		=> strip_tags(html_entity_decode($seller['name'], ENT_QUOTES, 'UTF-8'))
					);
				}
			//search
			} elseif ($this->request->post['type'] == 5) {

				//search history 
				$term = $filter_data['filter_name'];
				$keywords = $this->db->query("SELECT DISTINCT  sh.spelling FROM " . DB_PREFIX . "search_history sh where LOWER(sh.keyphrase) like '$term%'  and sh.repeat > 20
				   ORDER BY sh.repeat DESC limit 5");
				 
				 
				foreach ($keywords as $keyword) {
					$json[] = array(
						'id'		=> '0',
						'name'		=> strip_tags(html_entity_decode($keyword['spelling'], ENT_QUOTES, 'UTF-8'))
					);
				}
			}
			
			
			$sort_order = array();

			foreach ($json as $key => $value) {
				$sort_order[$key] = $value['name'];
			}

			array_multisort($sort_order, SORT_ASC, $json);
		}
		
		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}

	public function send() {

		$this->load->language('mobiapp/notification');

		if (isset($this->request->post['selected']) AND $this->request->post['selected']) {
			foreach ($this->request->post['selected'] as $notification_id) {
				if ($this->config->get('mobiapp_notification_status')) {
					$this->sendNotification($notification_id);
					$this->session->data['success'] = $this->language->get('text_notify_send');
				} else {
					$this->session->data['error_warning'] = $this->language->get('text_not_send');
				}
			}
		} else {
			$this->session->data['error_warning'] = $this->language->get('error_notify');
		}
		$this->redirect($this->url->link('mobiapp/notification', 'token=' . $this->session->data['token'] , 'SSL'));
	}

	protected function sendNotification($notification_id) {
		
		$this->load->model('tool/image');

		$notification_info = $this->db->query("SELECT * FROM ". DB_PREFIX ."mobiapp_notification mn LEFT JOIN ". DB_PREFIX ."mobiapp_notification_description mnd ON (mn.notification_id = mnd.notification_id) WHERE mnd.language_id = '". $this->config->get('config_language_id') ."' AND mn.notification_id = '". $notification_id ."'")->row;

		$type = '';

		if ($notification_info['type'] == 1) {
			$type = 'product';
		} elseif ($notification_info['type'] == 2) {
			$type = 'category';
		} elseif ($notification_info['type'] == 3) {
			$type = 'other';
		} elseif ($notification_info['type'] == 4) {
			$type = 'Custom';
		}

		$message = array(					
			'notification_id' => $notification_info['notification_id'],
			'title'		=> $notification_info['title'],
			'type'		=> $type ? $type : $notification_info['type'],
			'id'		=> $notification_info['pro_cat_id'],
			'content'	=> $notification_info['content'],
			'subTitle'	=> strip_tags(html_entity_decode($notification_info['content'])),
			'bannerImage' => HTTP_CATALOG."image/".$notification_info['image'],
			'body'			=> strip_tags(html_entity_decode($notification_info['content'])),
			);

		// Set POST variables
		$url = 'https://fcm.googleapis.com/fcm/send';
		
		$fields = array(
			'to'			=> "/topics/globalAndroid",
			'data'			=> $message,
			'time_to_live'	=> 30,
			'delay_while_idle'	=> true,
			'priority'          => 'high',
			'content_available' => true,
		);

		$headers = array(
			'Authorization: key=' . $this->config->get('mobiapp_gcm_key'),
			'Content-Type: application/json'
		);

		// Open connection
		$ch = curl_init();

		// Set the url, number of POST vars, POST data
		curl_setopt($ch, CURLOPT_URL, $url);

		curl_setopt($ch, CURLOPT_POST, true);
		curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);

		// Disabling SSL Certificate support temporarly
		curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);

		curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($fields));

		// Execute post
		$result = curl_exec($ch);
		if ($result === FALSE) {
			die('Curl failed: ' . curl_error($ch));
		}

		// Close connection
		curl_close($ch);

		$fields = array(
			'to'			=> "/topics/global",
			'data'			=> $message,
			'notification'	=> $message,
			'time_to_live'	=> 30,
			'delay_while_idle'	=> true,
			'priority'          => 'high',
			'content_available' => true,
		);

		// Open connection
		$ch = curl_init();

		// Set the url, number of POST vars, POST data
		curl_setopt($ch, CURLOPT_URL, $url);

		curl_setopt($ch, CURLOPT_POST, true);
		curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);

		// Disabling SSL Certificate support temporarly
		curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);

		curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($fields));

		// Execute post
		$result = curl_exec($ch);
		if ($result === FALSE) {
			die('Curl failed: ' . curl_error($ch));
		}

		// Close connection
		curl_close($ch);

		$this->load->model('mobiapp/notification');

		if (isset(json_decode($result)->message_id)) {
			$message_id = json_decode($result)->message_id;
			$this->model_mobiapp_notification->sendNotification($message_id, $fields, $headers, $error = '');
		} elseif (isset(json_decode($result)->error)) {
			$error = json_decode($result)->error;
			$this->model_mobiapp_notification->sendNotification($message_id = '', $fields, $headers, $error);
		}		
	}

	protected function validateForm() {

		if (!$this->user->hasPermission('modify', 'mobiapp/notification')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if (isset($this->request->post['title'])) {
			foreach ($this->request->post['title'] as $language_id => $title) {
				if ((utf8_strlen($title) < 2) || (utf8_strlen($title) > 64)) {
					$this->error['title'][$language_id] = $this->language->get('error_title');
				}
			}
		}

		if (($this->request->post['type'] == 1 || $this->request->post['type'] == 2) && !$this->request->post['id']) {
					
			$this->error['id'] = $this->language->get('error_id');
		}

		if ( $this->request->post['type'] == 4 && !$this->request->post['input-custom_id']) {
					
			$this->error['id'] = $this->language->get('error_custom_collection');
		}

		return !$this->error;
	}

	protected function validateDelete() {
		if (!$this->user->hasPermission('modify', 'mobiapp/notification')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		return !$this->error;
	}
}