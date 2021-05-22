<?php
class ModelCatalogProductBulkImport extends Model
{
    public function importProduct($data)
    {
      
        $this->db->query("INSERT INTO " . DB_PREFIX . "product SET model = '" . $this->db->escape($data['model']) . "', quantity = '" . (int)$data['quantity'] . "', price = '" . (float)$data['price'] . "', date_added = NOW()");
        
        $product_id = $this->db->getLastId();
    
   
        $this->db->query("INSERT INTO " . DB_PREFIX . "product_description SET product_id = '" . (int)$product_id . "', language_id ='1' ,name = '" . $this->db->escape($data['name']) . "'");

    }

    public function duplicateProduct($data)
    {
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_description WHERE name = '" . $this->db->escape($data['name']) . "'");
    
        return $query->num_rows;

    }

}
