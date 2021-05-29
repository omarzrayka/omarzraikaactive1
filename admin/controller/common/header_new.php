<?php
class ControllerCommonHeaderNew extends Controller
{
	protected function index()
	{
		$this->data['title'] = $this->document->getTitle();

		if (isset($this->request->server['HTTPS']) && (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1'))) {
			$this->data['base'] = HTTPS_SERVER;
		} else {
			$this->data['base'] = HTTP_SERVER;
		}

		$this->data['description'] = $this->document->getDescription();
		$this->data['keywords'] = $this->document->getKeywords();
		$this->data['links'] = $this->document->getLinks();
		$this->data['styles'] = $this->document->getStyles();
		$this->data['scripts'] = $this->document->getScripts();
		$this->data['lang'] = $this->language->get('code');
		$this->data['direction'] = $this->language->get('direction');

		$this->load->language('common/header');

		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_affiliate'] = $this->language->get('text_affiliate');
		$this->data['text_attribute'] = $this->language->get('text_attribute');
		$this->data['text_attribute_group'] = $this->language->get('text_attribute_group');
		$this->data['text_backup'] = $this->language->get('text_backup');
		$this->data['text_banner'] = $this->language->get('text_banner');
		$this->data['text_advance_banner'] = $this->language->get('text_advance_banner');
		$this->data['text_catalog'] = $this->language->get('text_catalog');
		$this->data['text_category'] = $this->language->get('text_category');
		$this->data['text_confirm'] = $this->language->get('text_confirm');
		$this->data['text_country'] = $this->language->get('text_country');
		$this->data['text_coupon'] = $this->language->get('text_coupon');
		$this->data['text_currency'] = $this->language->get('text_currency');
		$this->data['text_base_currency'] = 'Base Currncy';
		$this->data['text_customer'] = $this->language->get('text_customer');
		$this->data['text_customer_group'] = $this->language->get('text_customer_group');
		$this->data['text_customer_blacklist'] = $this->language->get('text_customer_blacklist');
		$this->data['text_sale'] = $this->language->get('text_sale');
		$this->data['text_design'] = $this->language->get('text_design');
		$this->data['text_documentation'] = $this->language->get('text_documentation');
		$this->data['text_download'] = $this->language->get('text_download');
		$this->data['text_error_log'] = $this->language->get('text_error_log');
		$this->data['text_extension'] = $this->language->get('text_extension');
		$this->data['text_feed'] = $this->language->get('text_feed');
		$this->data['text_front'] = $this->language->get('text_front');
		$this->data['text_geo_zone'] = $this->language->get('text_geo_zone');
		$this->data['text_dashboard'] = $this->language->get('text_dashboard');
		$this->data['text_help'] = $this->language->get('text_help');
		$this->data['text_information'] = $this->language->get('text_information');
		$this->data['text_language'] = $this->language->get('text_language');
		$this->data['text_layout'] = $this->language->get('text_layout');
		$this->data['text_localisation'] = $this->language->get('text_localisation');
		$this->data['text_logout'] = $this->language->get('text_logout');
		$this->data['text_contact'] = $this->language->get('text_contact');
		$this->data['text_manufacturer'] = $this->language->get('text_manufacturer');
		$this->data['text_module'] = $this->language->get('text_module');
		$this->data['text_option'] = $this->language->get('text_option');
		$this->data['text_order'] = $this->language->get('text_order');
		$this->data['text_order_status'] = $this->language->get('text_order_status');
		$this->data['text_opencart'] = $this->language->get('text_opencart');
		$this->data['text_payment'] = $this->language->get('text_payment');
		$this->data['text_product'] = $this->language->get('text_product');
		$this->data['text_reports'] = $this->language->get('text_reports');
		$this->data['text_report_sale_order'] = $this->language->get('text_report_sale_order');
		$this->data['text_report_sale_tax'] = $this->language->get('text_report_sale_tax');
		$this->data['text_report_sale_shipping'] = $this->language->get('text_report_sale_shipping');
		$this->data['text_report_sale_return'] = $this->language->get('text_report_sale_return');
		$this->data['text_report_sale_coupon'] = $this->language->get('text_report_sale_coupon');
		$this->data['text_report_product_viewed'] = $this->language->get('text_report_product_viewed');
		$this->data['text_report_product_purchased'] = $this->language->get('text_report_product_purchased');

		$this->data['text_report_customer_order'] = $this->language->get('text_report_customer_order');
		$this->data['text_report_customer_reward'] = $this->language->get('text_report_customer_reward');
		$this->data['text_report_customer_credit'] = $this->language->get('text_report_customer_credit');
		$this->data['text_report_affiliate_commission'] = $this->language->get('text_report_affiliate_commission');
		$this->data['text_report_sale_return'] = $this->language->get('text_report_sale_return');
		$this->data['text_report_product_purchased'] = $this->language->get('text_report_product_purchased');
		$this->data['text_report_product_viewed'] = $this->language->get('text_report_product_viewed');
		$this->data['text_report_customer_order'] = $this->language->get('text_report_customer_order');
		$this->data['text_review'] = $this->language->get('text_review');
		$this->data['text_return'] = $this->language->get('text_return');
		$this->data['text_return_action'] = $this->language->get('text_return_action');
		$this->data['text_return_reason'] = $this->language->get('text_return_reason');
		$this->data['text_return_status'] = $this->language->get('text_return_status');
		$this->data['text_support'] = $this->language->get('text_support');
		$this->data['text_shipping'] = $this->language->get('text_shipping');
		$this->data['text_setting'] = $this->language->get('text_setting');
		$this->data['text_stock_status'] = $this->language->get('text_stock_status');
		$this->data['text_system'] = $this->language->get('text_system');
		$this->data['text_tax'] = $this->language->get('text_tax');
		$this->data['text_tax_class'] = $this->language->get('text_tax_class');
		$this->data['text_tax_rate'] = $this->language->get('text_tax_rate');
		$this->data['text_total'] = $this->language->get('text_total');
		$this->data['text_user'] = $this->language->get('text_user');
		$this->data['text_user_group'] = $this->language->get('text_user_group');
		$this->data['text_users'] = $this->language->get('text_users');
		$this->data['text_voucher'] = $this->language->get('text_voucher');
		$this->data['text_voucher_theme'] = $this->language->get('text_voucher_theme');
		$this->data['text_weight_class'] = $this->language->get('text_weight_class');
		$this->data['text_length_class'] = $this->language->get('text_length_class');
		$this->data['text_zone'] = $this->language->get('text_zone');
		$this->data['text_custom_menu'] = $this->language->get('text_custom_menu');
		$this->data['text_custom_footer'] = $this->language->get('text_custom_footer');
		$this->data['text_new_menu'] = $this->language->get('text_new_menu');



		//Start Custom Algolia Menu 

		$this->data['text_algolia'] = $this->language->get('text_algolia');
		$this->data['text_algolia_products'] = $this->language->get('text_algolia_products');
		$this->data['text_algolia_categories'] = $this->language->get('text_algolia_categories');
		$this->data['text_algolia_brands'] = $this->language->get('text_algolia_brands');
		$this->data['text_algolia_logs'] = $this->language->get('text_algolia_logs');
		$this->data['text_algolia_config'] = $this->language->get('text_algolia_config');

		if (!$this->user->isLogged() || !isset($this->request->get['token']) || !isset($this->session->data['token']) || ($this->request->get['token'] != $this->session->data['token'])) {
			$this->data['logged'] = '';

			$this->data['home'] = $this->url->link('common/login', '', 'SSL');
		} else {
			//$this->data['logged'] = sprintf($this->language->get('text_logged'), $this->user->getUserName());
			$this->data['logged'] =  "Hello, " . $this->user->getUserName();

			$this->data['home'] = $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['affiliate'] = $this->url->link('sale/affiliate', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['attribute'] = $this->url->link('catalog/attribute', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['attribute_group'] = $this->url->link('catalog/attribute_group', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['backup'] = $this->url->link('tool/backup', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['banner'] = $this->url->link('design/banner', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['advance_banner'] = $this->url->link('design/advance_banner', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['category'] = $this->url->link('catalog/category', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['country'] = $this->url->link('localisation/country', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['coupon'] = $this->url->link('sale/coupon', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['currency'] = $this->url->link('localisation/currency', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['lbp_rate'] = $this->url->link('localisation/currency/lbpRate', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['base_currency'] = $this->url->link('localisation/base_currency', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['customer'] = $this->url->link('sale/customer', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['customer_group'] = $this->url->link('sale/customer_group', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['customer_blacklist'] = $this->url->link('sale/customer_blacklist', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['download'] = $this->url->link('catalog/download', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['error_log'] = $this->url->link('tool/error_log', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['feed'] = $this->url->link('extension/feed', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['vqmod_manager'] = $this->url->link('module/vqmod_manager', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['extension_note'] = $this->url->link('extension/note', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['extension_sms'] = $this->url->link('extension/sms', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['customer_order_sms'] = $this->url->link('extension/sms/customerOrderSmsForm', 'token=' . $this->session->data['token'], 'SSL');

			$this->data['aramex_pickup'] = $this->url->link('sale/aramex_bulk_schedule_pickup', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['geo_zone'] = $this->url->link('localisation/geo_zone', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['information'] = $this->url->link('catalog/information', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['language'] = $this->url->link('localisation/language', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['layout'] = $this->url->link('design/layout', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['logout'] = $this->url->link('common/logout', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['contact'] = $this->url->link('sale/contact', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['manufacturer'] = $this->url->link('catalog/manufacturer', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['seller'] = $this->url->link('catalog/seller', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['module'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['option'] = $this->url->link('catalog/option', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['order'] = $this->url->link('sale/order', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['order_comment_suggest'] = $this->url->link('sale/comment_suggest', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['purchase_order'] = $this->url->link('sale/purchase_order', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['order_status'] = $this->url->link('localisation/order_status', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['payment'] = $this->url->link('extension/payment', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['product'] = $this->url->link('catalog/product_ext', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['product_one'] = $this->url->link('catalog/product_one', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['product_order'] = $this->url->link('catalog/product_order', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['products_to_category'] = $this->url->link('module/bulk_product_to_category', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['custom_menu'] = $this->url->link('module/custom_menu', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['new_menu'] = $this->url->link('design/new_menu', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['custom_footer'] = $this->url->link('module/custom_footer', 'token=' . $this->session->data['token'], 'SSL');


			$this->data['mass_product_discount'] = $this->url->link('module/masspdiscoupd', 'token=' . $this->session->data['token'], 'SSL');

			$this->data['product_pricing'] = $this->url->link('catalog/product_pricing', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['product_task'] = $this->url->link('catalog/product_tasks', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['change_upc'] = $this->url->link('catalog/upc', 'token=' . $this->session->data['token'], 'SSL');


			$this->data['report_product_moq'] = $this->url->link('report/product_moq_brief', 'token=' . $this->session->data['token'], 'SSL');

			$this->data['report_sale_order'] = $this->url->link('report/sale_order', 'token=' . $this->session->data['token'], 'SSL');

			$this->data['report_stock'] = $this->url->link('report/stock', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['adv_sales'] = $this->url->link('report/adv_sales', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['adv_sales_profit'] = $this->url->link('report/adv_sales_profit', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['import_export'] = $this->url->link('tool/export', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['report_defected_product'] = $this->url->link('report/defected_product', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['sold_products_details'] = $this->url->link('accounting/sold_products_details', 'token=' . $this->session->data['token'] . '&group_by=product', 'SSL');


			$this->data['report_sale_tax'] = $this->url->link('report/sale_tax', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['report_sale_shipping'] = $this->url->link('report/sale_shipping', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['report_sale_return'] = $this->url->link('report/sale_return', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['report_sale_coupon'] = $this->url->link('report/sale_coupon', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['report_product_viewed'] = $this->url->link('report/product_viewed', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['report_product_purchased'] = $this->url->link('report/product_purchased', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['report_customer_order'] = $this->url->link('report/customer_order', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['report_customer_reward'] = $this->url->link('report/customer_reward', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['report_customer_credit'] = $this->url->link('report/customer_credit', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['report_affiliate_commission'] = $this->url->link('report/affiliate_commission', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['review'] = $this->url->link('catalog/review', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['return'] = $this->url->link('sale/return', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['return_action'] = $this->url->link('localisation/return_action', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['return_reason'] = $this->url->link('localisation/return_reason', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['return_status'] = $this->url->link('localisation/return_status', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['shipping'] = $this->url->link('extension/shipping', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['setting'] = $this->url->link('setting/store', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['store'] = HTTP_CATALOG;
			$this->data['stock_status'] = $this->url->link('localisation/stock_status', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['tax_class'] = $this->url->link('localisation/tax_class', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['tax_rate'] = $this->url->link('localisation/tax_rate', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['total_link'] = $this->url->link('extension/total', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['user'] = $this->url->link('user/user', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['user_group'] = $this->url->link('user/user_permission', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['role_permission'] = $this->url->link('user/role_permission', 'token=' . $this->session->data['token'], 'SSL');

			$this->data['voucher'] = $this->url->link('sale/voucher', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['voucher_theme'] = $this->url->link('sale/voucher_theme', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['weight_class'] = $this->url->link('localisation/weight_class', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['length_class'] = $this->url->link('localisation/length_class', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['zone'] = $this->url->link('localisation/zone', 'token=' . $this->session->data['token'], 'SSL');

			$this->data['order_status_group'] = $this->url->link('localisation/order_status_group', 'token=' . $this->session->data['token'], 'SSL');

			//Start Custom Algolia Menu
			$this->data['algolia_products'] = $this->url->link('cedalgolia/product', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['algolia_categories'] = $this->url->link('cedalgolia/category', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['algolia_brands'] = $this->url->link('cedalgolia/brand', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['algolia_logs'] = $this->url->link('cedalgolia/log', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['algolia_configuration'] = $this->url->link('module/cedalgolia', 'token=' . $this->session->data['token'], 'SSL');
			//End Custom Algolia Menu




			$this->data['importaramex'] = $this->url->link('accounting/importaramex', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['account_statement'] = $this->url->link('accounting/account_statement', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['vat_account_statement'] = $this->url->link('accounting/vat_account_statement', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['vat_expenses'] = $this->url->link('accounting/vat_expenses', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['vat_supplier_payments'] = $this->url->link('accounting/vat_supplier_payments', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['vat_summary'] = $this->url->link('accounting/vat_summary', 'token=' . $this->session->data['token'], 'SSL');
			
			$this->data['payment_methods'] = $this->url->link('accounting/payment_method', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['payment_method_groups'] = $this->url->link('accounting/payment_method_group', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['bank'] = $this->url->link('accounting/bank', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['importcod'] = $this->url->link('accounting/cod', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['salereportexport'] = $this->url->link('report/sale_orderreport', 'token=' . $this->session->data['token'], 'SSL');


			$this->data['allowedstatus'] = $this->url->link('localisation/allowedstatus', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['refill'] = $this->url->link('stock/refill', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['prepare_report'] = $this->url->link('stock/prepare_report', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['clearance'] = $this->url->link('report/clearance', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['adv_product_profit'] = $this->url->link('report/adv_product_profit', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['products_not_selling'] = $this->url->link('report/products_not_selling', 'token=' . $this->session->data['token'], 'SSL');

			$this->data['mobile_widgets'] = $this->url->link('widgets/widgets', 'token=' . $this->session->data['token'], 'SSL');
			$this->data['editorder_new'] = $this->url->link('sale/editorder_new', 'token=' . $this->session->data['token'], 'SSL');


			$this->data['stock'] = $this->url->link('stock/order', 'token=' . $this->session->data['token'], 'SSL');

			$this->data['clear_caches'] = $this->url->link('cache/cache', 'token=' . $this->session->data['token'], 'SSL');



			$this->data['tok'] = $this->session->data['token'];

			$this->data['stores'] = array();




			$this->data['text_report_adv_products'] = $this->language->get('text_report_adv_products');
			$this->data['report_adv_products'] = $this->url->link('report/adv_products', 'token=' . $this->session->data['token'], 'SSL');


			$this->load->model('setting/store');

			$results = $this->model_setting_store->getStores();

			foreach ($results as $result) {
				$this->data['stores'][] = array(
					'name' => $result['name'],
					'href' => $result['url']
				);
			}
		}

		$this->template = 'common/header_new.tpl';

		$this->render();
	}
}
