<?php
class ModelMobiappCategory extends Model {
	public function getCategories(){
		$result = $this->db->query("SELECT DISTINCT c.* , cd.name,m.category_icon FROM ".DB_PREFIX."category c LEFT JOIN ".DB_PREFIX."category_description cd on(c.category_id = cd.category_id) LEFT JOIN ".DB_PREFIX."mobiapp_category m on (m.category_id=c.category_id) WHERE parent_id = 0 AND cd.language_id =".$this->config->get('config_language_id'))->rows;
		return $result;
	}
	public function updateIcons($postData){
		$this->db->query("DELETE FROM ".DB_PREFIX."mobiapp_category");
		
		foreach ($postData as $data) {
			$this->db->query("INSERT INTO ".DB_PREFIX."mobiapp_category VALUES(".$data['category_id'].", '".$data['name']."', '".$data['status']."', '".$data['icon']."')");
		}
	}
}