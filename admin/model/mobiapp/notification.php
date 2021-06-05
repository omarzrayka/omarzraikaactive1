<?php
class ModelMobiappNotification extends Model {

/**
 * adds a new notification
 * @param array $data contains data regarding a notification
 */
	public function addNotification($data) {

		if (!isset($data['product_category'])) {
			$data['product_category'] = '';
		}

		$this->db->query("INSERT INTO " . DB_PREFIX . "mobiapp_notification SET content = '" . $this->db->escape($data['content']) . "', type = '" . $this->db->escape($data['type']) . "', name = '". $this->db->escape($data['product_category']) ."', pro_cat_id = '". $this->db->escape($data['id']) ."', status = '" . $this->db->escape($data['status']) . "', date_added = NOW() , image = '".$data['image']."'");

		$notification_id = $this->db->getLastId();

		foreach ($data['title'] as $language_id => $title) {
			$this->db->query("INSERT INTO `" . DB_PREFIX . "mobiapp_notification_description` SET title = '" . $title . "', notification_id = '" . $notification_id . "', language_id = '" . $language_id . "'");
		}

		return $notification_id;
	}
/**
 * saves a log of notification send
 * @param  int $message_id contains the message id of sent notification
 * @param  array $fields     contains the fields for GCM
 * @param  array $headers    contains the message and topic details
 * @param  String $error      contains error if exist
 * @return null             none
 */
	public function sendNotification($message_id, $fields, $headers, $error) {
		$this->db->query("INSERT INTO " . DB_PREFIX . "mobiapp_send SET message_id = '" . $message_id . "', fields = '" . $this->db->escape(serialize($fields)) . "', headers = '" . $this->db->escape(serialize($headers)) . "', error = '" . $error . "'");
	}
/**
 * Edits a pre-existing notification
 * @param  integer $notification_id contains the unique id of notification
 * @param  array $data            contains data regarding notification
 * @return none                  null
 */
	public function editNotification($notification_id, $data) {

		if (!isset($data['product_category'])) {
			$data['product_category'] = '';
		}

			$this->db->query("UPDATE " . DB_PREFIX . "mobiapp_notification SET content = '" . $this->db->escape($data['content']) . "', type = '" . $this->db->escape($data['type']) . "', name = '". $this->db->escape($data['product_category']) ."', pro_cat_id = '". $this->db->escape($data['id']) ."', status = '" . $this->db->escape($data['status']) . "', date_added = NOW() , image='".$data['image']."' WHERE notification_id = '" . (int)$notification_id . "'");
		
		$this->db->query("DELETE FROM " . DB_PREFIX . "mobiapp_notification_description WHERE notification_id = '" . (int)$notification_id . "'");

		foreach ($data['title'] as $language_id => $title) {
			$this->db->query("INSERT INTO `" . DB_PREFIX . "mobiapp_notification_description` SET title = '" . $title . "', notification_id = '" . $notification_id . "', language_id = '" . $language_id . "'");
		}

	}
/**
 * Deletes a notification from the database
 * @param  integer $notification_id contains unique ID of a notification
 * @return none                  null
 */
	public function deleteNotification($notification_id) {

		$this->db->query("DELETE FROM " . DB_PREFIX . "mobiapp_notification WHERE notification_id = '" . (int)$notification_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "mobiapp_notification_description WHERE notification_id = '" . (int)$notification_id . "'");

	}
/**
 * returns data of a notification on the basis of its ID
 * @param  integer $notification_id contains the unique ID of a notification
 * @return array                  contains notification data
 */
	public function getNotification($notification_id) {
		$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "mobiapp_notification mn LEFT JOIN " . DB_PREFIX . "mobiapp_notification_description mnd ON (mn.notification_id = mnd.notification_id) WHERE mn.notification_id = '" . (int)$notification_id . "'");

		foreach ($query->rows as $result) {
			$title[$result['language_id']] = $result['title'];
		}

		$notification_info = array(
				'content'	=> $query->row['content'],
				'image'		=> $query->row['image'],
				'type'		=> $query->row['type'],
				'status'	=> $query->row['status'],
				'name'		=> $query->row['name'],
				'pro_cat_id'=> $query->row['pro_cat_id'],
				'date_added'=> $query->row['date_added'],
				'title'		=> $title
			);

		return $notification_info;
	}
/**
 * return the rows of notifications
 * @param  array  $data contains filter data to filter and fetch notifications
 * @return array       contains notifications
 */
	public function getNotifications($data = array()) {
		$implode = array();

		$sql = "SELECT * FROM " . DB_PREFIX . "mobiapp_notification mn LEFT JOIN " . DB_PREFIX . "mobiapp_notification_description mnd ON (mn.notification_id = mnd.notification_id)";

		$implode = array();

		if (!empty($data['filter_title'])) {
			$implode[] = "mnd.title LIKE '" . $this->db->escape($data['filter_title']) . "%'";
		}

		if (!empty($data['filter_type'])) {
			$implode[] = "mn.type = '" . $this->db->escape($data['filter_type']) . "'";
		}

		if (isset($data['filter_status']) && !is_null($data['filter_status'])) {
			$implode[] = "mn.status = '" . (int)$data['filter_status'] . "'";
		}

		if (!empty($data['filter_date_added'])) {
			$implode[] = "mn.DATE(date_added) = DATE('" . $this->db->escape($data['filter_date_added']) . "')";
		}

		$implode[] = "mnd.language_id = '". (int)$this->config->get('config_language_id') ."'";

		if ($implode) {
			$sql .= " WHERE " . implode(" AND ", $implode);
		}

		$sort_data = array(
			'mnd.title',
			'mn.type',
			'mn.status',
			'mn.date_added'
		);

		if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
			$sql .= " ORDER BY " . $data['sort'];
		} else {
			$sql .= " ORDER BY mnd.title";
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
/**
 * return the count of the notification
 * @param  array  $data contains filter data
 * @return integer       contains the number of notifications
 */
	public function getTotalNotifications($data = array()) {
		$sql = "SELECT COUNT(*) AS total FROM " . DB_PREFIX . "mobiapp_notification mn LEFT JOIN " . DB_PREFIX . "mobiapp_notification_description mnd ON (mn.notification_id = mnd.notification_id)";

		$implode = array();

		if (!empty($data['filter_title'])) {
			$implode[] = "mnd.title LIKE '" . $this->db->escape($data['filter_title']) . "'";
		}

		if (!empty($data['filter_type'])) {
			$implode[] = "mn.type = '" . $this->db->escape($data['filter_type']) . "'";
		}

		if (!empty($data['filter_status'])) {
			$implode[] = "mn.status = '" . $this->db->escape($data['filter_status']) . "'";
		}

		if (!empty($data['filter_date_added'])) {
			$implode[] = "mn.DATE(date_added) = DATE('" . $this->db->escape($data['filter_date_added']) . "')";
		}

		$implode[] = "mnd.language_id = '". (int)$this->config->get('config_language_id') ."'";

		if ($implode) {
			$sql .= " WHERE " . implode(" AND ", $implode);
		}

		$query = $this->db->query($sql);

		return $query->row['total'];
	}

	public function getCustomCollectionName($id = 0){
		return $this->db->query("SELECT name FROM " . DB_PREFIX . "mobiapp_custom_collection WHERE id = ".(int)$id)->row['name'];	
	}

	public function getCustomCollection(){
		return $this->db->query("SELECT * FROM " . DB_PREFIX . "mobiapp_custom_collection")->rows;	
	}


}