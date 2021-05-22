<?php echo $header; ?>
<div id="content">
    <?php if ($success) { ?>
        <div class="warning"><?php echo $success; ?></div>
        <?php } ?>
    <div class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>">
            <?php echo $breadcrumb['text']; ?>
        </a>
        <?php } ?>
    </div>
    <div class="box">
        <div class="heading">
            <h1><img src="view/image/product.png" alt="" />
                <?php echo $heading_title; ?>
            </h1>
            <div class="buttons"><a onclick="$('#form').submit();" class="button">
                    <?php echo $button_save; ?>
                </a><a onclick="location = '<?php echo $cancel; ?>';" class="button">
                    <?php echo $button_cancel; ?>
                </a></div>
        </div>
        <div class="content">
            <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
                <div id="tab-general">
                    <div id="languages" class="htabs">
                        <?php foreach ($languages as $language) { ?>
                            <a href="#language<?php echo $language['language_id']; ?>"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a>

                        <?php } ?>
                    </div>
                </div>
                <label>Choose Excel
                    File</label> <input type="file" name="file" id="file" accept=".xls,.xlsx">
                    
            </form>
        </div>
        <div class="content">
            <table class="list">
                <thead>
                    <tr>
                    <td width="1" style="text-align: center;"><input type="checkbox" onclick="$('input[name*=\'selected\']').attr('checked', this.checked);" /></td>
                    <td><?php echo $column_name; ?></td>
                    <td><?php echo $column_model; ?></td>
                    <td><?php echo $column_sku ;?></td>
                    <td><?php echo $column_quantity; ?></td>
                    <td><?php echo $column_price; ?></td>
                    <td class="right"><?php echo $column_action; ?></td>
                    </tr>
                </thead>
                   
                    <tbody>
                        <?php  if($duplicate_list){ 
                            for($i=0; $i<count($duplicate_list);$i++){ ?>
                        <tr>
                            <td style="text-align: center;"><?php if ($i['selected']) { ?>
                                <input type="checkbox" name="selected[]" value="<?php echo $i; ?>" checked="checked" />
                                <?php } else { ?>
                                <input type="checkbox" name="selected[]" value="<?php echo $product['product_id']; ?>" />
                                <?php } ?>
                            </td>
                            <td><?php echo $duplicate_list[$i]['name'] ;?> </td>
                            <td><?php echo $duplicate_list[$i]['model'] ;?> </td>
                            <td><?php echo $duplicate_list[$i]['sku'] ;?> </td>
                            <td><?php echo $duplicate_list[$i]['quantity'] ;?> </td>
                            <td><?php echo $duplicate_list[$i]['price'] ;?> </td>
                            <td class="right"><?php foreach ($duplicate_list[$i]['action'] as $action) { ?>
                                [ <a href="<?php echo $action['href']; ?>"><?php echo $action['text']; ?></a> ]
                                <?php } ?></td>
                        </tr>
                        <?php } } ;?>
                    </tbody>
            </table>        
        </div>
    </div>
  
</div>
