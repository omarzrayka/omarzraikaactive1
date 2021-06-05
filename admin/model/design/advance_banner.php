<?php
class ModelDesignAdvanceBanner extends Model {

	public function addBanner($data) {
		$this->db->query("INSERT INTO " . DB_PREFIX . "banner SET name = '" . $this->db->escape($data['name']) . "', status = '" . (int)$data['status'] . "'");
	
		$banner_id = $this->db->getLastId();
	
		if (isset($data['banner_image'])) {
			foreach ($data['banner_image'] as $banner_image) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "banner_image SET banner_id = '" . (int)$banner_id . "', link = '" .  $this->db->escape($banner_image['link']) . "', image = '" .  $this->db->escape($banner_image['image']) . "', mobile_type =  '" . (int)$banner_image['mobile_type'] . "' , mobile_type_id =  '" . (int)$banner_image['mobile_type_id'] . "' , name = '" .  $this->db->escape($banner_image['name']) . "' ");
				
				$banner_image_id = $this->db->getLastId();
				
				foreach ($banner_image['banner_image_description'] as $language_id => $banner_image_description) {				
					$this->db->query("INSERT INTO " . DB_PREFIX . "banner_image_description SET banner_image_id = '" . (int)$banner_image_id . "', language_id = '" . (int)$language_id . "', banner_id = '" . (int)$banner_id . "', title = '" .  $this->db->escape($banner_image_description['title']) . "'");
				}
			}
		}		
	}

	public function editBannerOneInput($banner_id , $value, $attr) {
		if($attr =="status"){
			$this->db->query("UPDATE " . DB_PREFIX . "banner SET  status = '" . (int)$value. "' WHERE banner_id = '" . (int)$banner_id . "'");
		}else{
			$this->db->query("UPDATE " . DB_PREFIX . "banner SET  name = '" . $this->db->escape( $value). "' WHERE banner_id = '" . (int)$banner_id . "'");


		}
			
	}

	public function editBanner($banner_id, $data) {
		$this->db->query("UPDATE " . DB_PREFIX . "banner SET name = '" . $this->db->escape($data['name']) . "', status = '" . (int)$data['status'] . "' WHERE banner_id = '" . (int)$banner_id . "'");

		$this->db->query("DELETE FROM " . DB_PREFIX . "banner_image WHERE banner_id = '" . (int)$banner_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "banner_image_description WHERE banner_id = '" . (int)$banner_id . "'");
			
		if (isset($data['banner_image'])) {
			foreach ($data['banner_image'] as $banner_image) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "banner_image SET banner_id = '" . (int)$banner_id . "', link = '" .  $this->db->escape($banner_image['link']) . "', image = '" .  $this->db->escape($banner_image['image']) . "', mobile_type =  '" . (int)$banner_image['mobile_type'] . "' , mobile_type_id =  '" . (int)$banner_image['mobile_type_id'] . "' , name = '" .  $this->db->escape($banner_image['name']) . "'");
				
				
				$banner_image_id = $this->db->getLastId();
				
				foreach ($banner_image['banner_image_description'] as $language_id => $banner_image_description) {				
					$this->db->query("INSERT INTO " . DB_PREFIX . "banner_image_description SET banner_image_id = '" . (int)$banner_image_id . "', language_id = '" . (int)$language_id . "', banner_id = '" . (int)$banner_id . "', title = '" .  $this->db->escape($banner_image_description['title']) . "'");
				}
				
				
				
				
			}
		}			
	}

	public function editQuickBanner($banner_id, $data) {
	
		$this->db->query("DELETE FROM " . DB_PREFIX . "banner_image WHERE banner_id = '" . (int)$banner_id . "'");

			
		if (isset($data['banner_image'])) {
			foreach ($data['banner_image'] as $banner_image) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "banner_image SET banner_id = '" . (int)$banner_id . "', image = '" . $this->db->escape(html_entity_decode($banner_image['image'], ENT_QUOTES, 'UTF-8')) . "', mobile_type =  '" . (int)$banner_image['mobile_type'] . "' , mobile_type_id =  '" . (int)$banner_image['mobile_type_id'] . "' , name = '" .  $this->db->escape($banner_image['name']) . "'");
			//	$from = preg_replace('/\.[^.]+$/' ,'',$banner_image['image']);
			//	$withoutExt = preg_replace('/\\.[^.\\s]{3,4}$/', '', $banner_image['image']);

			//	copy($banner_image['image'] , DIR_IMAGE. '/'.$withoutExt);	

				
			}
		}			
	}
	
	public function deleteBanner($banner_id) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "banner WHERE banner_id = '" . (int)$banner_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "banner_image WHERE banner_id = '" . (int)$banner_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "banner_image_description WHERE banner_id = '" . (int)$banner_id . "'");
	}

	public function getBanner($banner_id) {
		$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "banner WHERE banner_id = '" . (int)$banner_id . "'");
		
		return $query->row;
	}
	
	public function getBanners($data = array()) {
		$sql = "SELECT * FROM " . DB_PREFIX . "banner   where 1" ;
		
		if (!empty($data['filter_name'])) {
			$sql .= " AND LCASE(name) LIKE '" . $this->db->escape(utf8_strtolower($data['filter_name'])) . "%'";
		}

        if($data['filter_status'] > -1){
            $sql .= " AND status =" . (int)$data['filter_status'] . "";
        }

			$sql .=  " GROUP BY banner_id";

      
		$sort_data = array(
			'name',
			'status'
		);	
		
		if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
			$sql .= " ORDER BY " . $data['sort'];	
		} else {
			$sql .= " ORDER BY name";	
		}
		
		if (isset($data['order']) && ($data['order'] == 'DESC')) {
			$sql .= " DESC";
		} else {
			$sql .= " ASC";
		}
		
		if (isset($data['start']) || isset($data['limit'])) {
			if ($data['start'] < 0) {
				$data['start'] = 0;
			}					

			if ($data['limit'] < 1) {
				$data['limit'] = 20;
			}	

		
			$sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
		}	
		
		
		$query = $this->db->query($sql);

		return $query->rows;
	}
	public function getBannerImages($banner_id) {
		$banner_image_data = array();
		
		$banner_image_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "banner_image WHERE banner_id = '" . (int)$banner_id . "' ORDER BY banner_image_id");
		
		foreach ($banner_image_query->rows as $banner_image) {
			$banner_image_description_data = array();
			 
			$banner_image_description_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "banner_image_description WHERE banner_image_id = '" . (int)$banner_image['banner_image_id'] . "' AND banner_id = '" . (int)$banner_id . "'");
			
			foreach ($banner_image_description_query->rows as $banner_image_description) {			
				$banner_image_description_data[$banner_image_description['language_id']] = array('title' => $banner_image_description['title']);
			}
			
			$banner_image_data[] = array(
				'banner_image_description' => $banner_image_description_data,
				'link'                     => $banner_image['link'],
				'image'                    => $banner_image['image'],
				'mobile_type'              => $banner_image['mobile_type'],
				'mobile_type_id'          => $banner_image['mobile_type_id'],
				'name'                    => $banner_image['name'], 
			);
		}
		
		return $banner_image_data;
	}
	public function getQuickBannerImages($banner_id) {
		$banner_image_data = array();
		
		$banner_image_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "banner_image WHERE banner_id = '" . (int)$banner_id . "' ORDER BY banner_image_id");
		
		foreach ($banner_image_query->rows as $banner_image) {
		
			
			$banner_image_data[] = array(
				
				'image'                    => $banner_image['image'],
				'mobile_type'              => $banner_image['mobile_type'],
				'mobile_type_id'          => $banner_image['mobile_type_id'],
				'name'                    => $banner_image['name'], 
			);
		}
		
		return $banner_image_data;
	}
	public function getBannerImage($banner_id) {
		
		
		$banner_image_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "banner_image WHERE banner_id = '" . (int)$banner_id . "'");
	
		
		return $banner_image_query->rows;
	}
		
	public function getTotalBanners($data = array()) {
     $sql = "SELECT COUNT(*)  AS total FROM " . DB_PREFIX . "banner WHERE 1";

	 if (!empty($data['filter_name'])) {
		$sql .= " AND LCASE(name) LIKE '" . $this->db->escape(utf8_strtolower($data['filter_name'])) . "%'";
	}
	  
	 if($data['filter_status'] > -1){
		$sql .= " AND status =" . (int)$data['filter_status'] . "";
	}
		$query = $this->db->query($sql);
		return $query->row['total'];
      
		
	}	

	public function getTotalBanner() {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "banner");
	  
	  return $query->row['total'];
    }	
}
?>