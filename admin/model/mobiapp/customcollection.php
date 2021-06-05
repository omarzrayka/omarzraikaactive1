<?php
class ModelMobiappCustomcollection extends Model {

	public function getLatestProducts($count = 10)
	{
		$queries = $this->db->query("SELECT p.product_id FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_to_store p2s ON (p.product_id = p2s.product_id) WHERE p.status = '1' AND p.date_available <= NOW() AND p2s.store_id = '" . (int)$this->config->get('config_store_id') . "' ORDER BY p.date_added DESC LIMIT " . (int)$count)->rows;
		
		$data = array();
		if ($queries) {
			foreach ($queries as $key => $query) {
				$data[$key] = $query['product_id'];
			}
		}
		return $data;
	}

	public function getProductsByAttribute($attribute = 'price',$attribute_value = 100,$attribute_value_max = 100)
	{	
		$sql = "";
		if ($attribute == 'model') {
			$sql = "p.model = '".$attribute_value."'";
		} elseif ($attribute == 'manufacturer') {
			$manufacturer = $this->db->query("SELECT DISTINCT manufacturer_id FROM " . DB_PREFIX . "manufacturer WHERE name = '".$attribute_value."'" )->row;
			if (isset($manufacturer['manufacturer_id']) && $manufacturer['manufacturer_id']) {
				$sql = "p.manufacturer_id = '".$manufacturer['manufacturer_id']."'";	
			}
		} else {
			$sql = "p.price >= ".$attribute_value." AND p.price <= ".$attribute_value_max;
		}
	
	
		$queries = $this->db->query("SELECT p.product_id FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_to_store p2s ON (p.product_id = p2s.product_id) WHERE p.status = '1' AND ".$sql." AND p2s.store_id = '" . (int)$this->config->get('config_store_id') . "'" )->rows;
		
		$data = array();
		if ($queries) {
			foreach ($queries as $key => $query) {
				$data[$key] = $query['product_id'];
			}
		}
		return $data;		
	}

	public function getProductName($product_id)
	{
		return $this->db->query("SELECT name FROM " . DB_PREFIX . "product_description WHERE product_id = ".(int)$product_id)->row['name'];
		
	}

	public function addCollection($id = 0,$data)
	{	
		$this->db->query("DELETE FROM " . DB_PREFIX . "mobiapp_custom_collection WHERE id = ".(int)$id);
		$this->db->query("INSERT INTO " . DB_PREFIX . "mobiapp_custom_collection SET name = '".$data['name']."' , product_id = '".implode(',', $data['mobiapp_customcollection_customcollection_product'])."' ,product_name = '".implode(',', $data['mobiapp_customcollection_customcollection_product_names'])."'");
	}

	public function getTotalCollection() {
		$sql = "SELECT COUNT(*) AS total FROM " . DB_PREFIX . "mobiapp_custom_collection ";

		$query = $this->db->query($sql);

		return $query->row['total'];
	}

	public function deleteCollection($id = 0) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "mobiapp_custom_collection WHERE id = ".(int)$id);
	}
	public function getCustomCollection(){
		return $this->db->query("SELECT * FROM " . DB_PREFIX . "mobiapp_custom_collection")->rows;	
	}

}