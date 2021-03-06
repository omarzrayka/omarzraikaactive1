<?php 
class ControllerDesignAdvanceBanner extends Controller {
	private $error = array();
 
	public function index() {
		$this->load->language('design/advance_banner');

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('design/advance_banner');
		
		$this->getList();
	}

	public function insert() {
		$this->load->language('design/advance_banner');

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('design/advance_banner');
		
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->model_design_advance_banner->addBanner($this->request->post);
			
		
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
			
			$this->redirect($this->url->link('design/advance_banner', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}

		$this->getForm();
	}

    public function update() {
		$this->load->language('design/advance_banner');

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('design/advance_banner');
		
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {

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
					
			$this->redirect($this->url->link('design/advance_banner', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}

		$this->getForm();
	}

	public function quick_update() {
		$this->load->language('design/advance_banner');

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('design/advance_banner');

		$this->load->model('tool/image');
		
		
		if ($this->request->server['REQUEST_METHOD'] == 'POST') {
			
			
			$this->model_design_advance_banner->editQuickBanner($this->request->get['banner_id'], $this->request->post);
			$count = count($this->request->post['bannerimage']);
		
           
		    for($i=0; $i<$count; $i++){
				if(isset($this->request->post['bannerimage'][$i])){
				$image=	$this->request->post['bannerimage'][$i];
		
		       
			    if($image != "no_image.jpg" & $image !=''  ){
			      $image=	$this->request->post['bannerimage'][$i];
			     
			      $withoutExt = explode("/",  $image) ;
	
	              //echo $withoutExt[1]; // piece2

				  $source = 'banner'.$this->request->get['banner_id'].'/'.$withoutExt[1];
				  $des = DIR_IMAGE.'cache/data/'.$withoutExt[1];

		           copy($source , $des);
				
				  
				   unlink($source); // delete file
				   $img = explode("-",  $source) ;
				   unlink($img[0].'.jpg'); // delete file
				}
			

			    }
		
			 }
			
           // return;
			
		    $path = 'banner'.$this->request->get['banner_id'];

			if(fileperms($path)){

				rmdir($path);

			}
	
			

		    
	//	rmdir($path);
		//return
	//	return;

	
	$this->session->data['temp_list']="";
			$this->session->data['success'] = $this->language->get('text_success');

			$url ='';
					
			$this->redirect($this->url->link('design/advance_banner', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}


		$this->getQuickForm();
	}


	public function upload_image() {
		$this->load->language('design/advance_banner');

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('design/advance_banner');

		$this->load->model('tool/image');
		
		if ($this->request->server['REQUEST_METHOD'] == 'POST') {
			
			// Desired folder structure
			$banner_id = $this->request->get['banner_id'];
            $structure = 'banner'.$banner_id;


            // to mkdir() must be specified.

            if (!is_dir($structure)) {
			mkdir($structure, 0777, true);
            }  
            
			$allowTypes = array('jpg','png','jpeg','gif'); 
			$fileNames = array_filter($_FILES['images']['name']); 
               if(!empty($fileNames)){

				    $temp_list[] = array();
					
             
				    foreach($_FILES['images']['name'] as $key=>$val){ 

                         // File upload path 
                        $fileName = basename($_FILES['images']['name'][$key]); 
                        $targetFilePath = $structure.'/' . $fileName; 
             
                        // Check whether file type is valid 
                        $fileType = pathinfo($targetFilePath, PATHINFO_EXTENSION); 
                        if(in_array($fileType, $allowTypes)){

                             // Upload file to server 
                            if(move_uploaded_file($_FILES["images"]["tmp_name"][$key], $targetFilePath)){ 
                                // Image db insert sql 
				            	$image =	$_FILES["images"]["name"][$key];
					            $dir_image = $structure.'/'.$image;

					            list($width, $height) = getimagesize($dir_image);
								
								$size = number_format(filesize($dir_image)/1024, 2);

								if(isset($size)){

								   $dir_image = $this->model_tool_image->resize_image( $structure,$image, 100, 100);
			
					               $temp_list[] = array('image'=>$dir_image,'image'=>$dir_image, 'width'=> $width, 'height'=>$height, 'size'=> $size);
								 
								}
						
					
                            }
                        }
		        	}

		        }
        
            $url="";

			$this->session->data['temp_list'] = $temp_list;
		

			$this->session->data['success'] = $this->language->get('text_success');
					
			$this->redirect($this->url->link('design/advance_banner/quick_update', 'token=' . $this->session->data['token'] . '&banner_id=' . $this->request->get['banner_id']. $url, 'SSL'));

		}

		//$this->getQuickForm();
	}

	public function delete() {
	
		$this->load->language('design/advance_banner');
 
		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('design/advance_banner');
		
		if (isset($this->request->post['selected']) && $this->validateDelete()) {
			foreach ($this->request->post['selected'] as $banner_id) {
				$this->model_design_advance_banner->deleteBanner($banner_id);
			}
			
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

			$this->redirect($this->url->link('design/advance_banner', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}

		$this->getList();
	}
	private function getList() {

		if(isset($this->request->get['filter_name'])){
            $filter_name = $this->request->get['filter_name'];
        }else{
            $filter_name = null;
        }
        if(isset($this->request->get['filter_status'])){
            $filter_status = $this->request->get['filter_status'];
        }else{
            $filter_status = null;
        }

		if (isset($this->request->get['sort'])) {
			$sort = $this->request->get['sort'];
		} else {
			$sort = 'name';
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
			
		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}
		
		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}
	
		$url = '';

        if(isset($this->request->get['filter_name'])){
			$url .= '$filter_name=' . urlencode(html_entity_decode($this->request->get['filter_name'], ENT_QUOTES, 'UTF-8'));
		}

		if(isset($this->request->get['filter_status'])){
			$url .= '$filter_status=' . urlencode(html_entity_decode($this->request->get['filter_status'], ENT_QUOTES, 'UTF-8'));
		}
        
		
		$this->data['token'] = $this->session->data['token'];

  		$this->data['breadcrumbs'] = array();

		//$url ='';

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('design/advance_banner', 'token=' . $this->session->data['token'] . $url, 'SSL'),
      		'separator' => ' :: '
   		);

    
		$this->data['edit'] = $this->url->link('design/advance_banner/editOneInput', 'token=' . $this->session->data['token'] . $url, 'SSL');  
		$this->data['update'] = $this->url->link('design/advance_banner/update', 'token=' . $this->session->data['token'] . $url, 'SSL');
		$this->data['insert'] = $this->url->link('design/advance_banner/insert', 'token=' . $this->session->data['token'] . $url, 'SSL');
		$this->data['delete'] = 'index.php?route=design/advance_banner/delete&token=' . $this->session->data['token'];

		 
		$this->data['banners'] = array();

	
		

		$this->load->model('tool/image');

		 // here is actionds and buttons
		$data = array(
			'filter_name'       => $filter_name,
			'filter_status'     => $filter_status,
			'sort'              => $sort,
			'order'             => $order,
			'start'             => ($page -1) * 500,
			'limit'             => 500
	
			);
		
       

		$results = $this->model_design_advance_banner->getBanners($data);
		foreach ($results as $result) {
			$action = array();
			
			$action[] = array(
				'text' => $this->language->get('text_edit'),
				'href' => $this->url->link('design/advance_banner/update', 'token=' . $this->session->data['token'] . '&banner_id=' . $result['banner_id'] . $url, 'SSL')
			);

			$action[] = array(
				'text' => $this->language->get('text_quick_edit'),
				'href' => $this->url->link('design/advance_banner/quick_update', 'token=' . $this->session->data['token'] . '&banner_id=' . $result['banner_id'] . $url, 'SSL')
			);
			$banner_image_data = array();
			$count=0;
			$imageBanner = $this->model_design_advance_banner->getBannerImage($result['banner_id']);
			foreach ($imageBanner as $banner_image) {
			
				if ($banner_image['image'] && file_exists(DIR_IMAGE . $banner_image['image'])) {
					$image = $this->model_tool_image->resize($banner_image['image'], 40, 40);
				
				} else {
					$image = $this->model_tool_image->resize('no_image.jpg', 40, 40);
				}
		      if($count <5){
				$banner_image_data[] = $image;
				$count++;
			  }
			}
			
	

			$this->data['banners'][] = array(
				'banner_id' => $result['banner_id'],
				'image'      => $banner_image_data,	
				'name'      => $result['name'],	
				'status'    => ($result['status'] ? $this->language->get('text_enabled') : $this->language->get('text_disabled')),				
				'selected'  => isset($this->request->post['selected']) && in_array($result['banner_id'], $this->request->post['selected']),				
				'action'    => $action
			);
		}

		$total = $this->model_design_advance_banner->getTotalBanners($data);

		$this->data['heading_title'] = $this->language->get('heading_title');
		
		$this->data['text_no_results'] = $this->language->get('text_no_results');
		
		$this->data['column_name'] = $this->language->get('column_name');
		$this->data['column_status'] = $this->language->get('column_status');
		$this->data['column_action'] = $this->language->get('column_action');	

		$this->data['button_insert'] = $this->language->get('button_insert');
		$this->data['button_delete'] = $this->language->get('button_delete');
        
		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');
 
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

		$url = '';

		if ($order == 'ASC') {
			$url .= '&order=DESC';
		} else {
			$url .= '&order=ASC';
		}

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}
		
		$this->data['sort_name'] = $this->url->link('design/advance_banner', 'token=' . $this->session->data['token'] . '&sort=name' . $url, 'SSL');
		$this->data['sort_status'] = $this->url->link('design/advance_banner', 'token=' . $this->session->data['token'] . '&sort=status' . $url, 'SSL');
		
		$url = '';

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}
												
		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		$pagination = new Pagination();
		$pagination->total = $total;
		$pagination->page = $page;
		$pagination->limit = 500;
		$pagination->text = $this->language->get('text_pagination');
		$pagination->url = $this->url->link('design/advance_banner', 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');
			
		$this->data['pagination'] = $pagination->render();
		
		$this->data['filter_name'] = $filter_name;
		$this->data['filter_status'] = $filter_status;
        $this->data['sort'] = $sort;
	    $this->data['order'] = $order;
		
		$this->template = 'design/advance_banner_list.tpl';
		$this->children = array(
			'common/header_new',
			'common/footer_new'
		);
				
		$this->response->setOutput($this->render());
	}

	private function getForm() {
		$this->data['heading_title'] = $this->language->get('heading_title');
		
		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');
		$this->data['text_default'] = $this->language->get('text_default');
		$this->data['text_image_manager'] = $this->language->get('text_image_manager');
 		$this->data['text_browse'] = $this->language->get('text_browse');
		$this->data['text_clear'] = $this->language->get('text_clear');			
				
		$this->data['entry_name'] = $this->language->get('entry_name');
		$this->data['entry_title'] = $this->language->get('entry_title');
		$this->data['entry_link'] = $this->language->get('entry_link');
		$this->data['entry_image'] = $this->language->get('entry_image');		
		$this->data['entry_status'] = $this->language->get('entry_status');
		
		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');
		$this->data['button_add_banner'] = $this->language->get('button_add_banner');
		$this->data['button_remove'] = $this->language->get('button_remove');

		$this->data['token'] = $this->session->data['token'];

 		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}

 		if (isset($this->error['name'])) {
			$this->data['error_name'] = $this->error['name'];
		} else {
			$this->data['error_name'] = '';
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
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('design/advance_banner', 'token=' . $this->session->data['token'] . $url, 'SSL'),
      		'separator' => ' :: '
   		);
							
		if (!isset($this->request->get['banner_id'])) { 
			$this->data['action'] = $this->url->link('design/advance_banner/insert', 'token=' . $this->session->data['token'] . $url, 'SSL');
		} else {
			$this->data['action'] = $this->url->link('design/advance_banner/update', 'token=' . $this->session->data['token'] . '&banner_id=' . $this->request->get['banner_id'] . $url, 'SSL');
		}
		
		$this->data['cancel'] = $this->url->link('design/banner', 'token=' . $this->session->data['token'] . $url, 'SSL');
		
		if (isset($this->request->get['banner_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
			$banner_info = $this->model_design_advance_banner->getBanner($this->request->get['banner_id']);
		}

		if (isset($this->request->post['name'])) {
			$this->data['name'] = $this->request->post['name'];
		} elseif (!empty($banner_info)) {
			$this->data['name'] = $banner_info['name'];
		} else {
			$this->data['name'] = '';
		}
		
		if (isset($this->request->post['status'])) {
			$this->data['status'] = $this->request->post['status'];
		} elseif (!empty($banner_info)) {
			$this->data['status'] = $banner_info['status'];
		} else {
			$this->data['status'] = true;
		}

		$this->load->model('localisation/language');
		
		$this->data['languages'] = $this->model_localisation_language->getLanguages();
		
		$this->load->model('tool/image');
	
		if (isset($this->request->post['banner_image'])) {
			$banner_images = $this->request->post['banner_image'];
		} elseif (isset($this->request->get['banner_id'])) {
			$banner_images = $this->model_design_advance_banner->getBannerImages($this->request->get['banner_id']);
		} else {
			$banner_images = array();
		}

	
		
		$this->data['banner_images'] = array();
		
		foreach ($banner_images as $banner_image) {
			if ($banner_image['image'] && file_exists(DIR_IMAGE . $banner_image['image'])) {
				$image = $banner_image['image'];
			} else {
				$image = 'no_image.jpg';
			}			
			$this->data['banner_images'][] = array(
				'banner_image_description' => $banner_image['banner_image_description'],
				'link'                     => $banner_image['link'],
				'image'                    => $image,
				'thumb'                    => $this->model_tool_image->resize($image, 100, 100),
				'mobile_type'              => $banner_image['mobile_type'],
				'mobile_type_id'           => $banner_image['mobile_type_id'],
				'name'                     => $banner_image['name'],
			);		
		
		} 
	
		$this->data['no_image'] = $this->model_tool_image->resize('no_image.jpg', 100, 100);		

		$this->template = 'design/advance_banner_form.tpl';
		$this->children = array(
			'common/header_new',
			'common/footer_new'
		);
				
		$this->response->setOutput($this->render());
	}

	private function getQuickForm() {
		$this->data['heading_title'] = $this->language->get('heading_title');
		
		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');
		$this->data['text_default'] = $this->language->get('text_default');
		$this->data['text_image_manager'] = $this->language->get('text_image_manager');
 		$this->data['text_browse'] = $this->language->get('text_browse');
		$this->data['text_clear'] = $this->language->get('text_clear');			
				
		$this->data['entry_name'] = $this->language->get('entry_name');
		$this->data['entry_title'] = $this->language->get('entry_title');
		$this->data['entry_link'] = $this->language->get('entry_link');
		$this->data['entry_image'] = $this->language->get('entry_image');		
		$this->data['entry_status'] = $this->language->get('entry_status');
		
		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');
		$this->data['button_add_banner'] = $this->language->get('button_add_banner');
		$this->data['button_remove'] = $this->language->get('button_remove');

		$this->data['token'] = $this->session->data['token'];


 		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}

 		if (isset($this->error['name'])) {
			$this->data['error_name'] = $this->error['name'];
		} else {
			$this->data['error_name'] = '';
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
        if(isset( $this->session->data['temp_list'])){
			$temp_list =  $this->session->data['temp_list'];
		}else{
		    $temp_list= array();
		}
  		$this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('design/advance_banner', 'token=' . $this->session->data['token'] . $url, 'SSL'),
      		'separator' => ' :: '
   		);
							
		 
		
		$this->data['action'] = $this->url->link('design/advance_banner/quick_update', 'token=' . $this->session->data['token'] . '&banner_id=' . $this->request->get['banner_id'] . $url, 'SSL');
	  

		$this->data['action_upload'] = $this->url->link('design/advance_banner/upload_image', 'token=' . $this->session->data['token'] . '&banner_id=' . $this->request->get['banner_id'] . $url, 'SSL');
		
		$this->data['cancel'] = $this->url->link('design/banner', 'token=' . $this->session->data['token'] . $url, 'SSL');
		
		if (isset($this->request->get['banner_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
			$banner_info = $this->model_design_advance_banner->getBanner($this->request->get['banner_id']);
		}

		if (isset($this->request->post['name'])) {
			$this->data['name'] = $this->request->post['name'];
		} elseif (!empty($banner_info)) {
			$this->data['name'] = $banner_info['name'];
		} else {
			$this->data['name'] = '';
		}
		
		if (isset($this->request->post['status'])) {
			$this->data['status'] = $this->request->post['status'];
		} elseif (!empty($banner_info)) {
			$this->data['status'] = $banner_info['status'];
		} else {
			$this->data['status'] = true;
		}
		if(!isset($this->session->data['temp_list'])){
		
			$temp_list = array();
		}else{
			 
			$temp_list = $this->session->data['temp_list'];
		}
		$this->load->model('localisation/language');
		
		$this->data['languages'] = $this->model_localisation_language->getLanguages();
		
		$this->load->model('tool/image');
	
		if (isset($this->request->post['banner_image'])) {
			$banner_images = $this->request->post['banner_image'];
		} elseif (isset($this->request->get['banner_id'])) {
			$banner_images = $this->model_design_advance_banner->getQuickBannerImages($this->request->get['banner_id']);
		} else {
			$banner_images = array();
		}

	
		
		$this->data['banner_images'] = array();
		
		foreach ($banner_images as $banner_image) {
			if ($banner_image['image'] && file_exists(DIR_IMAGE . $banner_image['image'])) {
				$image = $banner_image['image'];
			} else {
				$image = 'no_image.jpg';
			}			
			$this->data['banner_images'][] = array(
				'image'                    => $image,
				'thumb'                    => $this->model_tool_image->resize($image, 100, 100),
				'mobile_type'              => $banner_image['mobile_type'],
				'mobile_type_id'           => $banner_image['mobile_type_id'],
				'name'                     => $banner_image['name'],
			);		
		
		} 
	
		$this->data['no_image'] = $this->model_tool_image->resize('no_image.jpg', 100, 100);	
		$this->data['temp_list'] = $temp_list;

		$this->template = 'design/advance_banner_quick_form.tpl';
		$this->children = array(
			'common/header_new',
			'common/footer_new'
		);
				
		$this->response->setOutput($this->render());
	}

	public function editOneInput(){
		$this->load->model('design/advance_banner');

		   if (($this->request->server['REQUEST_METHOD'] == 'POST')) {

		     	$banner_id =$this->request->post['banner_id'];
		 	    $value = $this->request->post['value'];
			    $selected = $this->request->post['selected'];
			    $attr = $this->request->post['attr'];
			
	        	$this->model_design_advance_banner->editBannerOneInput($banner_id, $value, $attr);
	
		        if( $attr =="status"){
		        if($value == "0"){
		            echo "<span style='color:red'>" .$selected."<span>";
		        }else{
		            echo "<span style='color:black'>" .$selected."<span>";
		        }
	            }else{
					echo $selected;
				}
	        }
	}

	private function validateForm() {
		if (!$this->user->hasPermission('modify', 'design/banner')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if ((utf8_strlen($this->request->post['name']) < 3) || (utf8_strlen($this->request->post['name']) > 64)) {
			$this->error['name'] = $this->language->get('error_name');
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
		
		if (!$this->error) {
			return true;
		} else {
			return false;
		}
	}

	private function validateDelete() {
		if (!$this->user->hasPermission('modify', 'design/banner')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
	
		if (!$this->error) {
			return true;
		} else {
			return false;
		}
	}


}
?>