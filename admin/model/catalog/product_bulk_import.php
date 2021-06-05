<?php
class ModelCatalogProductBulkImport extends Model
{
    public function insertInvoice($data)
    {
    
          $this->db->query("INSERT INTO " . DB_PREFIX . "invoice SET name = '" . $this->db->escape($data['file_name']) . "',date = '" . $this->db->escape($data['file_date']) . "'");
       //
          $invoice_id = $this->db->getLastId();
      
          return  $invoice_id;
    

    }

    public function importProduct($invoice_id, $data)
    {
      
        $this->db->query("INSERT INTO " . DB_PREFIX . "product SET model = '" . $this->db->escape($data['model']) . "', quantity = '" . (int)$data['quantity'] . "', sKu= '" .$this->db->escape($data['sku']) . "', price = '" .(float)$data['price']. "', invoice_id = '" . (int)$invoice_id . "', date_added = NOW()");
        
        $product_id = $this->db->getLastId();
    
   
        $this->db->query("INSERT INTO " . DB_PREFIX . "product_description SET product_id = '" . (int)$product_id . "', language_id ='1' ,name = '" . $this->db->escape($data['name']) . "'");     

    }

    public function duplicateProduct($data)
    {
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product_description WHERE name = '" . $this->db->escape($data['name']) . "'");
    
        return $query->num_rows;

    }

    public function getProducts($invoice_id) {
		
        if ($invoice_id) {

			$sql = "SELECT * FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id) WHERE invoice_id='". (int)$invoice_id ."'";
			
			
			$sql .= " GROUP BY p.product_id";
				
			
			$query = $this->db->query($sql);
		
			return $query->rows;
            
		}
	}

    public function editProduct($data){
        
         $this->db->query("UPDATE " . DB_PREFIX . "product SET  sku = '" . $this->db->escape($data['sku']) . "' WHERE product_id = '" . (int)$data['product_id'] . "'");

  

    }

}
