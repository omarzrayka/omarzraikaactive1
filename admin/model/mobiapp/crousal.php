<?php
class ModelMobiappCrousal extends Model {
	public function getCrousals() {
		$results = $this->db->query("SELECT * FROM ".DB_PREFIX."mobiapp_crousal")->rows;
		return $results;
	}

	public function editCrousal($crousal_products_data) {
		$this->db->query("DELETE FROM ".DB_PREFIX."mobiapp_crousal");
		$crousal_products = $crousal_products_data['crousal_product'];
		foreach ($crousal_products as $crousal_product) {
			if(isset($crousal_product['id']) && $crousal_product['id']){
				$image = $this->db->query("SELECT image FROM ".DB_PREFIX."manufacturer where manufacturer_id = '".(int)$crousal_product['id']."'")->row;
				if(empty($image))
					$image['image'] = '';
				$this->db->query("INSERT INTO ".DB_PREFIX."mobiapp_crousal SET id = '" . (int)$crousal_product['id']. "', name= '" . $crousal_product['name'] . "', sort_order = '" .  $crousal_product['sort_order'] . "', image = '".$image['image']."'");
			}
		}
	}
}