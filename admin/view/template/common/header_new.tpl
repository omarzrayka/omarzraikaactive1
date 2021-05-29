<?php echo '<?xml version="1.0" encoding="UTF-8"?>' . "\n"; ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>" xml:lang="<?php echo $lang; ?>">

<head>
    <style>
        .navbar-nav li:hover>ul.dropdown-menu {
            display: block;
        }
        
        .dropdown-submenu {
            position: relative;
        }
        
        .dropdown-submenu>.dropdown-menu {
            top: -10%;
            left: 100%;
            margin-top: -6px;
        }
        /* rotate caret on hover */
        
        .dropdown-menu>li>a:hover:after {
            text-decoration: underline;
            transform: rotate(-90deg);
        }
        
        .breadcrumb>li+li:before {
            color: #CCCCCC;
            content: "/ ";
            padding: 0 5px;
        }
        
        .admin-menu-navbar {
            padding-top: 0px !important;
            padding-bottom: 0px !important;
        }
        
        .navbar-dark .navbar-nav .nav-link {
            padding-top: 15px !important;
            padding-bottom: 15px !important;
        }
    </style>
    <title>
        <?php echo $title; ?>
    </title>

    <base href="<?php echo $base; ?>" />
    <link href="/image/website/favicon/adminfavicon.png" sizes="48x48" rel="icon" />
    <?php if ($description) { ?>
    <meta name="description" content="<?php echo $description; ?>" />
    <?php } ?>
    <?php if ($keywords) { ?>
    <meta name="keywords" content="<?php echo $keywords; ?>" />
    <?php } ?>
    <?php foreach ($links as $link) { ?>
    <link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>" />
    <?php } ?>

    <?php foreach ($styles as $style) { ?>
    <link rel="<?php echo $style['rel']; ?>" type="text/css" href="<?php echo $style['href']; ?>" media="<?php echo $style['media']; ?>" />
    <?php } ?>

    <script src="https://code.jquery.com/jquery-3.0.0.js"></script>
    <script src="https://code.jquery.com/jquery-migrate-3.1.0.js"></script>


    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js" integrity="sha256-T0Vest3yCU7pafRw9r+settMBX6JkKN06dqBnpQ8d30=" crossorigin="anonymous"></script>


    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">

    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>

    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-select@1.13.9/dist/css/bootstrap-select.min.css">

    <!-- Latest compiled and minified JavaScript -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap-select@1.13.9/dist/js/bootstrap-select.min.js"></script>

    <script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />

    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.7.14/js/bootstrap-datetimepicker.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.7.14/css/bootstrap-datetimepicker.min.css">

    <script src="https://unpkg.com/gijgo@1.9.13/js/gijgo.min.js" type="text/javascript"></script>
    <link href="https://unpkg.com/gijgo@1.9.13/css/gijgo.min.css" rel="stylesheet" type="text/css" />



    <?php foreach ($scripts as $script) { ?>
    <script type="text/javascript" src="<?php echo $script; ?>"></script>
    <?php } ?>


    <script type="text/javascript">
        //-----------------------------------------
        // Confirm Actions (delete, uninstall)
        //-----------------------------------------
        $(document).ready(function() {
            // Confirm Delete
            $('#form').submit(function() {
                if ($(this).attr('action').indexOf('delete', 1) != -1) {
                    if (!confirm('<?php echo $text_confirm; ?>')) {
                        return false;
                    }
                }
            });

            // Confirm Uninstall
            $('a').click(function() {
                if ($(this).attr('href') != null && $(this).attr('href').indexOf('uninstall', 1) != -1) {
                    if (!confirm('<?php echo $text_confirm; ?>')) {
                        return false;
                    }
                }
            });
        });
    </script>
</head>

<body>



    <nav class="navbar navbar-expand-md navbar-dark bg-dark admin-menu-navbar">
        <div class="collapse navbar-collapse" id="navbarNavDropdown">
            <ul class="navbar-nav">
                <li id="dashboard" class="nav-item dropdown">
                    <a class="nav-link" href="<?php echo $order; ?>">
                        <?php echo $text_dashboard; ?> <span class="sr-only">(current)</span>
                    </a>
                </li>

                <li id="catalog" class="nav-item dropdown">
                    <a class="nav-link" id="navbarDropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <?php echo $text_catalog; ?>
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
                        <li>
                            <a class="dropdown-item" href="<?php echo $category; ?>">
                                <?php echo $text_category; ?>
                            </a>
                        </li>
                        <li>
                            <a class="dropdown-item" href="<?php echo $product; ?>">
                                <?php echo $text_product; ?>
                            </a>
                        </li>
                        <li><a class="dropdown-item" href="<?php echo $product_order; ?>">Product Sort Orders</a></li>
                        <li><a class="dropdown-item" href="<?php echo $product_one; ?>">Product One</a></li>
                        <li><a class="dropdown-item" href="<?php echo $products_to_category; ?>">Product To Category</a></li>
                        <li><a class="dropdown-item" href="<?php echo $product_pricing; ?>">Product Pricing</a></li>
                        <li><a class="dropdown-item" href="<?php echo $product_task; ?>">Product Tasks</a></li>

                        <li class="dropdown-submenu">
                            <a class="dropdown-item dropdown-toggle">
                                <?php echo $text_attribute; ?>
                            </a>
                            <ul class="dropdown-menu">
                                <li>
                                    <a class="dropdown-item" href="<?php echo $attribute; ?>">
                                        <?php echo $text_attribute; ?>
                                    </a>
                                </li>
                                <li>
                                    <a class="dropdown-item" href="<?php echo $attribute_group; ?>">
                                        <?php echo $text_attribute_group; ?>
                                    </a>
                                </li>
                            </ul>
                        </li>
                        <li>
                            <a class="dropdown-item" href="<?php echo $option; ?>">
                                <?php echo $text_option; ?>
                            </a>
                        </li>
                        <li>
                            <a class="dropdown-item" href="<?php echo $manufacturer; ?>">
                                <?php echo $text_manufacturer; ?>
                            </a>
                        </li>
                        <li>
                            <a class="dropdown-item" href="<?php echo $download; ?>">
                                <?php echo $text_download; ?>
                            </a>
                        </li>
                        <li>
                            <a class="dropdown-item" href="<?php echo $review; ?>">
                                <?php echo $text_review; ?>
                            </a>
                        </li>
                        <li>
                            <a class="dropdown-item" href="<?php echo $information; ?>">
                                <?php echo $text_information; ?>
                            </a>
                        </li>
                        <li><a class="dropdown-item" href="<?php echo $seller; ?>">Seller</a></li>
                        <li><a class="dropdown-item" href="<?php echo $change_upc; ?>">Change UPC</a></li>
                    </ul>
                </li>

                <li id="extension" class="nav-item dropdown">
                    <a class="nav-link" id="navbarDropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <?php echo $text_extension; ?>
                    </a>

                    <ul class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
                        <li>
                            <a class="dropdown-item" href="<?php echo $module; ?>">
                                <?php echo $text_module; ?>
                            </a>
                        </li>
                        <li>
                            <a class="dropdown-item" href="<?php echo $shipping; ?>">
                                <?php echo $text_shipping; ?>
                            </a>
                        </li>
                        <li>
                            <a class="dropdown-item" href="<?php echo $payment; ?>">
                                <?php echo $text_payment; ?>
                            </a>
                        </li>
                        <li>
                            <a class="dropdown-item" href="<?php echo $total; ?>">
                                <?php echo $text_total; ?>
                            </a>
                        </li>
                        <li>
                            <a class="dropdown-item" href="<?php echo $feed; ?>">
                                <?php echo $text_feed; ?>
                            </a>
                        </li>
                        <li><a class="dropdown-item" href="<?php echo $vqmod_manager; ?>">VQMod Manager</a></li>
                        <li><a class="dropdown-item" href="<?php echo $extension_note; ?>">Note Extension</a></li>
                        <li><a class="dropdown-item" href="<?php echo $extension_sms; ?>">SMS Extension</a></li>
                        <li><a class="dropdown-item" href="<?php echo $customer_order_sms; ?>">Customer Order SMS</a></li>
                    </ul class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
                </li>

                <li id="sale" class="nav-item dropdown">
                    <a class="nav-link" id="navbarDropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <?php echo $text_sale; ?>
                    </a>

                    <ul class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
                        <li>
                            <a class="dropdown-item" href="<?php echo $order; ?>">
                                <?php echo $text_order; ?>
                            </a>
                        </li>
                        <li><a class="dropdown-item" href="<?php echo $editorder_new; ?>">Edit Order New</a></li>
                        <li><a class="dropdown-item" href="<?php echo $aramex_pickup; ?>">Aramex Pickup</a></li>
                        <li>
                            <a class="dropdown-item" href="<?php echo $return; ?>">
                                <?php echo $text_return; ?>
                            </a>
                        </li>
                        <li class="dropdown-submenu">
                            <a class="dropdown-item dropdown-toggle">
                                <?php echo $text_customer; ?>
                            </a>
                            <ul class="dropdown-menu">
                                <li>
                                    <a class="dropdown-item" href="<?php echo $customer; ?>">
                                        <?php echo $text_customer; ?>
                                    </a>
                                </li>
                                <li>
                                    <a class="dropdown-item" href="<?php echo $customer_group; ?>">
                                        <?php echo $text_customer_group; ?>
                                    </a>
                                </li>
                                <li>
                                    <a class="dropdown-item" href="<?php echo $customer_blacklist; ?>">
                                        <?php echo $text_customer_blacklist; ?>
                                    </a>
                                </li>
                            </ul>
                        </li>
                        <li>
                            <a class="dropdown-item" href="<?php echo $affiliate; ?>">
                                <?php echo $text_affiliate; ?>
                            </a>
                        </li>
                        <li>
                            <a class="dropdown-item" href="<?php echo $coupon; ?>">
                                <?php echo $text_coupon; ?>
                            </a>
                        </li>
                        <li class="dropdown-submenu">
                            <a class="dropdown-item dropdown-toggle">
                                <?php echo $text_voucher; ?>
                            </a>
                            <ul class="dropdown-menu">
                                <li>
                                    <a class="dropdown-item" href="<?php echo $voucher; ?>">
                                        <?php echo $text_voucher; ?>
                                    </a>
                                </li>
                                <li>
                                    <a class="dropdown-item" href="<?php echo $voucher_theme; ?>">
                                        <?php echo $text_voucher_theme; ?>
                                    </a>
                                </li>
                            </ul>
                        </li>
                        <li>
                            <a class="dropdown-item" href="<?php echo $contact; ?>">
                                <?php echo $text_contact; ?>
                            </a>
                        </li>
                        <li><a class="dropdown-item" href="<?php echo $order_comment_suggest; ?>">Comment Suggest</a></li>
                        <li><a class="dropdown-item" href="<?php echo $purchase_order; ?>">Purchase Order</a></li>

                    </ul>
                </li>

                <li id="system" class="nav-item dropdown">
                    <a class="nav-link" id="navbarDropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <?php echo $text_system; ?>
                    </a>

                    <ul class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
                        <li>
                            <a class="dropdown-item" href="<?php echo $setting; ?>">
                                <?php echo $text_setting; ?>
                            </a>
                        </li>
                        <li class="dropdown-submenu">
                            <a class="dropdown-item dropdown-toggle">
                                <?php echo $text_design; ?>
                            </a>
                            <ul class="dropdown-menu">
                                <li>
                                    <a class="dropdown-item" href="<?php echo $layout; ?>">
                                        <?php echo $text_layout; ?>
                                    </a>
                                </li>
                                <li>
                                    <a class="dropdown-item" href="<?php echo $banner; ?>">
                                        <?php echo $text_banner; ?>
                                    </a>
                                </li>
                                <li>
                                    <a class="dropdown-item" href="<?php echo $advance_banner; ?>">
                                        <?php echo $text_advance_banner; ?>
                                    </a>
                                </li>
                                <li>
                                    <a class="dropdown-item" href="<?php echo $custom_menu; ?>">
                                        <?php echo $text_custom_menu; ?>
                                    </a>
                                </li>
                                <li>
                                    <a class="dropdown-item" href="<?php echo $new_menu; ?>">
                                        <?php echo $text_new_menu; ?>
                                    </a>
                                </li>
                                <li>
                                    <a class="dropdown-item" href="<?php echo $custom_footer; ?>">
                                        <?php echo $text_custom_footer; ?>
                                    </a>
                                </li>
                            </ul>
                        </li>
                        <li class="dropdown-submenu">
                            <a class="dropdown-item dropdown-toggle">
                                <?php echo $text_users; ?>
                            </a>
                            <ul class="dropdown-menu">
                                <li>
                                    <a class="dropdown-item" href="<?php echo $user; ?>">
                                        <?php echo $text_user; ?>
                                    </a>
                                </li>
                                <li>
                                    <a class="dropdown-item" href="<?php echo $user_group; ?>">
                                        <?php echo $text_user_group; ?>
                                    </a>
                                </li>
                                <li><a class="dropdown-item" href="<?php echo $role_permission; ?>">Role Permission</a></li>
                            </ul>
                        </li>
                        <li class="dropdown-submenu">
                            <a class="dropdown-item dropdown-toggle">
                                <?php echo $text_localisation; ?>
                            </a>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="<?php echo $allowedstatus; ?>">Allowed Status</a
                    class="dropdown-submenu"></li>
                <li><a class="dropdown-item" href="<?php echo $language; ?>">
                    <?php echo $text_language; ?>
                  </a class="dropdown-submenu"></li>
                  <li><a class="dropdown-item" href="<?php echo $lbp_rate; ?>">
                    LBP Daily Rate
                  </a class="dropdown-submenu"></li>
                <li><a class="dropdown-item" href="<?php echo $currency; ?>">
                    <?php echo $text_currency; ?>
                  </a class="dropdown-submenu"></li>
                  
                <li><a class="dropdown-item" href="<?php echo $base_currency; ?>">
                    <?php echo $text_base_currency; ?>
                  </a class="dropdown-submenu"></li>
                <li><a class="dropdown-item" href="<?php echo $stock_status; ?>">
                    <?php echo $text_stock_status; ?>
                  </a class="dropdown-submenu"></li>
                <li><a class="dropdown-item" href="<?php echo $order_status; ?>">
                    <?php echo $text_order_status; ?>
                  </a class="dropdown-submenu"></li>
                <li><a class="dropdown-item" href="<?php echo $order_status_group; ?>">Order Status Group</a
                    class="dropdown-submenu"></li>
                <li class="dropdown-submenu"><a class="dropdown-item dropdown-toggle">
                    <?php echo $text_return; ?>
                  </a>
                                    <ul class="dropdown-menu">
                                        <li>
                                            <a class="dropdown-item" href="<?php echo $return_status; ?>">
                                                <?php echo $text_return_status; ?>
                                            </a>
                                        </li>
                                        <li>
                                            <a class="dropdown-item" href="<?php echo $return_action; ?>">
                                                <?php echo $text_return_action; ?>
                                            </a>
                                        </li>
                                        <li>
                                            <a class="dropdown-item" href="<?php echo $return_reason; ?>">
                                                <?php echo $text_return_reason; ?>
                                            </a>
                                        </li>
                                    </ul>
                                </li>
                                <li>
                                    <a class="dropdown-item" href="<?php echo $country; ?>">
                                        <?php echo $text_country; ?>
                                    </a>
                                </li>
                                <li>
                                    <a class="dropdown-item" href="<?php echo $zone; ?>">
                                        <?php echo $text_zone; ?>
                                    </a>
                                </li>
                                <li>
                                    <a class="dropdown-item" href="<?php echo $geo_zone; ?>">
                                        <?php echo $text_geo_zone; ?>
                                    </a>
                                </li>
                                <li class="dropdown-submenu">
                                    <a class="dropdown-item dropdown-toggle">
                                        <?php echo $text_tax; ?>
                                    </a>
                                    <ul class="dropdown-menu">
                                        <li>
                                            <a class="dropdown-item" href="<?php echo $tax_class; ?>">
                                                <?php echo $text_tax_class; ?>
                                            </a>
                                        </li>
                                        <li>
                                            <a class="dropdown-item" href="<?php echo $tax_rate; ?>">
                                                <?php echo $text_tax_rate; ?>
                                            </a>
                                        </li>
                                    </ul>
                                </li>
                                <li>
                                    <a class="dropdown-item" href="<?php echo $length_class; ?>">
                                        <?php echo $text_length_class; ?>
                                    </a>
                                </li>
                                <li>
                                    <a class="dropdown-item" href="<?php echo $weight_class; ?>">
                                        <?php echo $text_weight_class; ?>
                                    </a>
                                </li>
                            </ul>
                        </li>
                        <li>
                            <a class="dropdown-item" href="<?php echo $error_log; ?>">
                                <?php echo $text_error_log; ?>
                            </a>
                        </li>
                        <li>
                            <a class="dropdown-item" href="<?php echo $backup; ?>">
                                <?php echo $text_backup; ?>
                            </a>
                        </li>
                        <li><a class="dropdown-item" href="<?php echo $import_export; ?>">Export / Import</a></li>
                        <li><a class="dropdown-item" href="<?php echo $clear_caches; ?>">Clear Caches</a></li>
                    </ul>
                </li>

                <li class="nav-item dropdown" id="reports">
                    <a class="nav-link" id="navbarDropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <?php echo $text_reports; ?>
                    </a>

                    <ul class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
                        <li class="dropdown-submenu">
                            <a class="dropdown-item dropdown-toggle">
                                <?php echo $text_sale; ?>
                            </a>

                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="<?php echo $adv_sales; ?>">ADV Sales</a></li>
                                <li><a class="dropdown-item" href="<?php echo $adv_sales_profit; ?>">ADV Sales & Pofit</a></li>
                                <hr>
                                <li>
                                    <a class="dropdown-item" href="<?php echo $report_sale_order; ?>">
                                        <?php echo $text_report_sale_order; ?>
                                    </a>
                                </li>
                                <li><a class="dropdown-item" href="<?php echo $report_stock; ?>">Stock Report</a></li>
                                <li>
                                    <a class="dropdown-item" href="<?php echo $report_sale_tax; ?>">
                                        <?php echo $text_report_sale_tax; ?>
                                    </a>
                                </li>
                                <li>
                                    <a class="dropdown-item" href="<?php echo $report_sale_shipping; ?>">
                                        <?php echo $text_report_sale_shipping; ?>
                                    </a>
                                </li>
                                <li>
                                    <a class="dropdown-item" href="<?php echo $report_sale_return; ?>">
                                        <?php echo $text_report_sale_return; ?>
                                    </a>
                                </li>
                                <li>
                                    <a class="dropdown-item" href="<?php echo $report_sale_coupon; ?>">
                                        <?php echo $text_report_sale_coupon; ?>
                                    </a>
                                </li>
                            </ul>
                        </li>
                        <li class="dropdown-submenu">
                            <a class="dropdown-item dropdown-toggle">
                                <?php echo $text_product; ?>
                            </a>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="<?php echo $sold_products_details ?>">Sold Products Details</a></li>
                                <li><a class="dropdown-item" href="<?php echo $report_product_moq ?>">Product Sellers Moq</a></li>
                                <li><a class="dropdown-item" href="<?php echo $report_adv_products ?>">ADV Products</a></li>
                                <li>
                                    <a class="dropdown-item" href="<?php echo $report_product_viewed; ?>">
                                        <?php echo $text_report_product_viewed; ?>
                                    </a>
                                </li>
                                <li><a class="dropdown-item" href="<?php echo $clearance; ?>">Clearance Products</a></li>
                                <li><a class="dropdown-item" href="<?php echo $adv_product_profit; ?>">ADV Purshased & Profit</a></li>
                                <li><a class="dropdown-item" href="<?php echo $products_not_selling; ?>">Product Not Selling</a></li>
                                <li><a class="dropdown-item" href="<?php echo $report_defected_product; ?>">Defected Product</a></li>
                            </ul>
                        </li>
                        <li class="dropdown-submenu">
                            <a class="dropdown-item dropdown-toggle">
                                <?php echo $text_customer; ?>
                            </a>

                            <ul class="dropdown-menu">
                                <li>
                                    <a class="dropdown-item" href="<?php echo $report_customer_order; ?>">
                                        <?php echo $text_report_customer_order; ?>
                                    </a>
                                </li>
                                <li>
                                    <a class="dropdown-item" href="<?php echo $report_customer_reward; ?>">
                                        <?php echo $text_report_customer_reward; ?>
                                    </a>
                                </li>
                                <li>
                                    <a class="dropdown-item" href="<?php echo $report_customer_credit; ?>">
                                        <?php echo $text_report_customer_credit; ?>
                                    </a>
                                </li>
                            </ul>
                        </li>
                        <li class="dropdown-submenu">
                            <a class="dropdown-item dropdown-toggle">
                                <?php echo $text_affiliate; ?>
                            </a>
                            <ul class="dropdown-menu">
                                <li>
                                    <a class="dropdown-item" href="<?php echo $report_affiliate_commission; ?>">
                                        <?php echo $text_report_affiliate_commission; ?>
                                    </a>
                                </li>
                            </ul>
                        </li>
                    </ul>
                </li>

                <li id="accounting" class="nav-item dropdown">
                    <a class="nav-link" id="navbarDropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> Accounting</a>
                    <ul class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
                        <li>
                            <a class="dropdown-item" href="<?php echo $account_statement ?>">Seller Account Statement</a>
                        </li>

                        <li>
                            <a class="dropdown-item" href="<?php echo $importcod ?>">Import Cod</a>
                        </li>

                        <li>
                            <a class="dropdown-item" href="<?php echo $salereportexport ?>">Export Orders</a>
                        </li>

                        <li class="dropdown-submenu">
                            <a class="dropdown-item dropdown-toggle">
                                <?php echo $text_localisation; ?>
                            </a>
                            <ul class="dropdown-menu">
                                <li>
                                    <a class="dropdown-item" href="<?php echo $payment_methods ?>">Payment Methods</a>
                                </li>
                                <li>
                                    <a class="dropdown-item" href="<?php echo $payment_method_groups ?>">Payment Method Group</a>
                                </li>
                                <li>
                                    <a class="dropdown-item" href="<?php echo $bank ?>">Banks</a>
                                </li>
                            </ul>
                        </li>

                        <li class="dropdown-submenu"><a class="dropdown-item dropdown-toggle">VAT</a>
                            <ul class="dropdown-menu">
                                <li>
                                    <a class="dropdown-item" href="<?php echo $vat_account_statement; ?>">Account Statement</a>
                                    <a class="dropdown-item" href="<?php echo $vat_expenses; ?>">Expenses</a>
                                    <a class="dropdown-item" href="<?php echo $vat_supplier_payments; ?>">Supplier Payments</a>
                                    <a class="dropdown-item" href="<?php echo $vat_summary; ?>">Summary</a>
                                </li>
                            </ul>
                        </li>
                    </ul>
                </li>

                <li id="accounting" class="nav-item dropdown">
                    <a class="nav-link" id="navbarDropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> Mobile</a>
                    <ul class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
                        <li>
                            <a class="dropdown-item" href="<?php echo $mobile_widgets ?>">Mobile Widgets</a>
                        </li>
                    </ul>
                </li>



                <li id="stock" class="nav-item dropdown">
                    <a class="nav-link" id="navbarDropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> Stock</a>
                    <ul class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
                        <li>
                            <li><a class="dropdown-item" href="<?php echo $stock; ?>">Order</a></li>
                        </li>
                    </ul>
                </li>


            </ul>
        </div>

        <div class="collapse navbar-collapse" id="navbarSupportedContent-4">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item active">
                    <a onclick="window.open('http://www.ishtari.com/');" class="nav-link">
            Ishtari
          </a>
                </li>
                <li class="nav-item active">
                    <a class="nav-link" href="<?php echo $logout; ?>">
            Logout</a>
                </li>

        </div>

    </nav>


    <style>
        .dropdown-item,
        .nav-link {
            cursor: pointer;
        }
        
        @media (min-width: 768px) {
            .navbar-expand-md .navbar-nav .dropdown-menu {
                margin-top: -1px;
            }
        }
        
        .breadcrumb {
            display: inline-block !important;
            background: none !important;
            border-radius: 0 !important;
            margin: 0px !important;
        }
        
        .breadcrumb>li {
            margin: 5px !important;
            display: inline-block !important;
        }
        
        .page-header h4 {
            display: inline !important;
        }
    </style>