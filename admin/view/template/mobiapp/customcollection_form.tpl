<?php echo $header; ?>
<div id="content">
 <div class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
        <?php } ?>
    </div>
     <?php if ($error_warning) { ?>
    <div class="warning"> <?php echo $error_warning; ?></div>
    <?php } ?>
    <?php if ($success) { ?>
    <div class="success"><?php echo $success; ?> </div>
    <?php } ?>
    <div class="box">
      <div class="heading">
      <h1><img src="view/image/product.png" alt="" /> <?php echo $text_list; ?></h1>

     <div class="buttons">
     <a onclick="$('#form').submit();" class="button"><?php echo $button_save;?></button>
       <a href="<?php echo $cancel; ?>" class="button"><?php echo $button_cancel; ?></a>
      </div>
      </div>
      <div class="content">
         <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">

         <table class="list">
          <tbody>
            <tr>
              <td><?php echo $text_name; ?></td>
              <td><input type="text" name="name" value="" placeholder="" id="name" class="form-control" /></td>
            </tr>

            <tr>
              <td><?php echo $text_create; ?></td>
              <td>
                <select name="type" id="input-type" class="form-control">
                  <option value="0"><?php echo $text_select; ?> </option>
                  <option value="1"><?php echo $text_product_id; ?> </option>
                  <option value="2"><?php echo $text_product_count; ?> </option>
                  <option value="3"><?php echo $text_product_attribute; ?> </option>
                </select>
              </td>
            </tr>

            <tr class="hide" id="form-group_product">
              <td><?php echo $entry_product; ?></td>
              <td>
                <input type="text" name="product" value="" placeholder="" id="input-product" class="form-control" />
                <div id="customcollection-product" class="well well-sm" style="height: 150px; overflow: auto;">
                  <?php foreach ($products as $product) { ?>
                  <div id="customcollection-product<?php echo $product['product_id']; ?>"><i class="fa fa-minus-circle"></i> <?php echo $product['name']; ?>
                    <input type="hidden" name="mobiapp_customcollection_customcollection_product[]" value="<?php echo $product['product_id']; ?>" />
                  </div>
                  <?php } ?>
                </div>
              </td>
            </tr>

            <tr class="hide" id="form-group_count">
              <td><?php echo $text_product_count; ?></td>
              <td><input type="text" name="count" value="" placeholder="" id="input-count" class="form-control" /></td>
            </tr>

            <tr class="hide" id="form-group_attribute">
              <td><?php echo $text_product_attribute; ?></td>
              <td>
                <select name="attribute" id="input-attribute" class="form-control">
                  <option value="<?php echo $text_price; ?>"><?php echo $text_price; ?> </option>
                  <option value="<?php echo $text_manufacturer; ?>"><?php echo $text_manufacturer; ?> </option>
                  <option value="<?php echo $text_model; ?>"><?php echo $text_model; ?> </option>
                </select> 
              </td>
            </tr>

            <tr class="hide" id="form-group_attribute_value">
              <td colspan="2">
                <table>
                  <tr class="hide" id="form-group_attribute_value_price">
                    <td><?php echo $text_attribute_value; ?></td>
                    <td>
                      <input type="text" name="attribute_value_price_min" id="input-attribute_value_price" value="" placeholder="Price From" class="form-control" />
                      <input type="text" name="attribute_value_price_max" id="input-attribute_value_price" value="" placeholder="Price To" class="form-control" />
                    </td>
                  </tr>
                  <tr class="hide" id="form-group_attribute_value_manufacturer">
                    <td><?php echo $text_attribute_value; ?></td>
                    <td>
                      <input type="text" name="attribute_value_manufacturer" id="input-attribute_value_manufacturer" value="" placeholder="" class="form-control" />
                    </td>
                  </tr>
                  <tr class="hide" id="form-group_attribute_value_model">
                    <td><?php echo $text_attribute_value; ?></td>
                    <td>
                      <input type="text" name="attribute_value_model" id="input-attribute_value_model" value="" placeholder="Model" class="form-control" />
                    </td>
                  </tr>
                </table>
              </td>
            </tr>
          </tbody>
        </table>
          
      </form>
      </div>
    </div>
  </div>
</div>

<script>
  $('#input-attribute').on('change', function () {
    var type = $('#input-attribute').val();
    if (type == 'price') {
      $('#form-group_attribute_value_model').addClass('hide');
      $('#form-group_attribute_value_manufacturer').addClass('hide');
      $('#form-group_attribute_value_price').removeClass('hide');
    } else if(type == 'manufacturer') {
      $('#form-group_attribute_value_price').addClass('hide');
      $('#form-group_attribute_value_model').addClass('hide');
      $('#form-group_attribute_value_manufacturer').removeClass('hide');
    } else {
      $('#form-group_attribute_value_price').addClass('hide');
      $('#form-group_attribute_value_manufacturer').addClass('hide');
      $('#form-group_attribute_value_model').removeClass('hide');
    }
  });

  // Manufacturer
  $('input[name=\'attribute_value_manufacturer\']').autocomplete({
    'source': function(request, response) {
      $.ajax({
        url: 'index.php?route=catalog/manufacturer/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request),
        dataType: 'json',
        success: function(json) {
          response($.map(json, function(item) {
            return {
              label: item['name'],
              value: item['manufacturer_id']
            }
          }));
        }
      });
    },
    'select': function(item) {
      $('input[name=\'attribute_value_manufacturer\']').val(item['label']);
    }
  });

</script>

<script>
jQuery(function(){
  $('#input-type').on('change', function () {
    var type = $('#input-type').val();
    if (type == 1) {
      $('#form-group_product').removeClass('hide');
    } else {
      $('#form-group_product').addClass('hide');
    }

    if (type == 2) {
      $('#form-group_count').removeClass('hide');
    } else {
      $('#form-group_count').addClass('hide');
    }

    if (type == 3) {
      $('#form-group_attribute').removeClass('hide');
      $('#form-group_attribute_value').removeClass('hide');
    } else {
      $('#form-group_attribute').addClass('hide');
      $('#form-group_attribute_value').addClass('hide');
    }

  });

  // Items
  $('input[name=\'product_category\']').autocomplete({
    'source': function(request, response) {
      $.ajax({
        url: 'index.php?route=mobiapp/notification/getItem&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request),
        dataType: 'json',
        data: ({type : $('#input-type').val()}),
        type: 'post',
        success: function(json) {
          response($.map(json, function(item) {
            return {
              label: item['name'],
              value: item['id']
            }
          }));
        }
      });
    },
    'select': function(item) {
      $('input[name=\'product_category\']').val(item['label']);
      $('input[name=\'id\']').val(item['value']);
    }
  });
});
</script>

<script type="text/javascript"><!--
$('input[name=\'product\']').autocomplete({
  source: function(request, response) {
    $.ajax({
      url: 'index.php?route=catalog/product/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request.term),
      dataType: 'json',
      success: function(json) {
        response($.map(json, function(item) {
          return {
            label: item['name'],
            value: item['product_id']
          }
        }));
      }
    });
  },
  select: function(item,ui) {
    $('input[name=\'product\']').val('');
    $('#customcollection-product' + ui.item.value).remove();
    
    $('#customcollection-product').append('<div id="customcollection-product' + ui.item.value + '">' + ui.item.label + '<img src="view/image/delete.png" alt="" /><input type="hidden" name="mobiapp_customcollection_customcollection_product[]" value="' + ui.item.value + '" /></div>');  

    $('#customcollection-product div:odd').attr('class', 'odd');
    $('#customcollection-product div:even').attr('class', 'even');
    
    data = $.map($('#customcollection-product input'), function(element){
      return $(element).attr('value');
    });
          
    return false;
  }
});
  
$('#customcollection-product div img').live('click', function() {
  $(this).parent().remove();
  
  $('#customcollection-product div:odd').attr('class', 'odd');
  $('#customcollection-product div:even').attr('class', 'even');

  data = $.map($('#featured-product input'), function(element){
    return $(element).attr('value');
  });
          
});
//--></script>

<?php echo $footer; ?>
<style type="text/css">
.hide{
  display: none;
}
</style>