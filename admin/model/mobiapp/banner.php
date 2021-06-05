<?php
class ModelMobiappBanner extends Model {
/**
 * Edits the banners data
 * @param  array $data contains the data regarding all banners to be put in database
 * @return none       null
 */
	public function editBanner($data) {

		$this->db->query("DELETE FROM " . DB_PREFIX . "mobiapp_banner");
		$this->db->query("DELETE FROM " . DB_PREFIX . "mobiapp_banner_description");

		if (isset($data['banner_image'])) {
			foreach ($data['banner_image'] as $banner_image) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "mobiapp_banner SET 	type = '" .  $this->db->escape($banner_image['type']) . "', name = '" .  $this->db->escape($banner_image['name']) . "', id = '" .  $this->db->escape($banner_image['id']) . "', image = '" .  $this->db->escape($banner_image['image']) . "', sort_order = '" . (int)$banner_image['sort_order'] . "'");

				$banner_id = $this->db->getLastId();

				foreach ($banner_image['banner_image_description'] as $language_id => $banner_image_description) {
					$this->db->query("INSERT INTO " . DB_PREFIX . "mobiapp_banner_description SET banner_id = '" . (int)$banner_id . "', language_id = '" . (int)$language_id . "', title = '" .  $this->db->escape($banner_image_description['title']) . "'");
				}
			}
		}

	}
/**
 * fetches all the data regarding banners that are saved in database
 * @return array contains data of all banners
 */
	public function getBannerImages() {
		$banner_image_data = array();

		$banner_image_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "mobiapp_banner ORDER BY sort_order ASC");

		foreach ($banner_image_query->rows as $banner_image) {
			$banner_image_description_data = array();

			$banner_image_description_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "mobiapp_banner_description WHERE banner_id = '" . (int)$banner_image['banner_id'] . "'");

			foreach ($banner_image_description_query->rows as $banner_image_description) {
				$banner_image_description_data[$banner_image_description['language_id']] = array('title' => $banner_image_description['title']);
			}

			$banner_image_data[] = array(
				'banner_image_description' => $banner_image_description_data,
				'type'                     => $banner_image['type'],
				'name'                     => $banner_image['name'],
				'id'	                   => $banner_image['id'],
				'image'                    => $banner_image['image'],
				'sort_order'               => $banner_image['sort_order']
			);
		}

		return $banner_image_data;
	}
}