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
      <h1><img src="view/image/product.png" alt="" /> <?php echo $text_form; ?></h1>

     <div class="buttons"> 
      <a onclick ="$('#form-crousal').submit()" class="button"><?php echo $button_save; ?></a>
      <a href="<?php echo $cancel; ?>"  class="button"><?php echo $button_cancel; ?></a>
      </div>
      </div>
      <div class="content">
        <form  method="post" enctype="multipart/form-data" id="form-crousal" class="form-horizontal">
          <table id="images" class="form">
            <thead>
              <tr>
                <td class="left"><?php echo $entry_link; ?></td>
                <td class="right"><?php echo $entry_sort_order; ?></td>
              </tr>
            </thead>
            <tbody>
              <?php $image_row = 0; ?>
              <?php if(isset($crousal_products)){?>
              <?php foreach ($crousal_products as $crousal_product) { ?>
              <tr id="image-row<?php echo $image_row; ?>">
                   <td class="text-left" style="width: 30%;"><input type="text" name="crousal_product[<?php echo $image_row; ?>][name]" value="<?php echo $crousal_product['name']; ?>" placeholder="<?php echo $entry_link; ?>" class="form-control manufacturer" item="crousal_product[<?php echo $image_row; ?>][type]" itemid="crousal_product[<?php echo $image_row; ?>][id]" /><input type="hidden" name="crousal_product[<?php echo $image_row; ?>][id]" value="<?php echo $crousal_product['id']; ?>"></td>

                   <td class="text-left"><a href="" id="thumb-image<?php echo $image_row; ?>" data-toggle="image" class="img-thumbnail"><img src="<?php echo $crousal_product['thumb']; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" /></a>
                    <input type="hidden" name="crousal_product[<?php echo $image_row; ?>][image]" value="<?php echo $crousal_product['image']; ?>" id="input-image<?php echo $image_row; ?>" /></td>

                  <td class="text-right"><input type="text" name="crousal_product[<?php echo $image_row; ?>][sort_order]" value="<?php echo $crousal_product['sort_order']; ?>" placeholder="<?php echo $entry_sort_order; ?>" class="form-control" /></td>

                <td class="text-left"><a class="button" onclick="$('#image-row<?php echo $image_row; ?>, .tooltip').remove();"><?php echo $button_remove; ?></a></td>
              </tr>
              <?php $image_row++; ?>
              <?php }} ?>
            </tbody>
            <tfoot>
              <tr>
                <td colspan="5"></td>
                <td class="text-left"><a class="button" onclick="addImage();" data-toggle="tooltip" title="" class="button"><?php echo 'Add Carousel'; ?></a></td>
              </tr>
            </tfoot>
          </table>
        </form>
      </div>
    </div>
  </div>
<script>
jQuery(function(){
   $(document.body).on('click', '.manufacturer' ,function(){
     var link_name = $(this).attr('name');
     var link_id = $(this).attr('itemid');
$('.manufacturer').autocomplete({
  source: function(request, response) {
    $.ajax({
      url: 'index.php?route=catalog/manufacturer/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request.term),
      dataType: 'json',
      success: function(json) {   
        response($.map(json, function(item) {
          return {
            label: item.name,
            value: item.manufacturer_id
          }
        }));
      }
    });
  }, 
  select: function(event, ui) {
    $("input[name=\'"+ link_name +"\']").attr('value', ui.item.label);
    $("input[name=\'"+ link_id +"\']").attr('value', ui.item.value);
  
    return false;
  },
  focus: function(event, ui) {
      return false;
   }
});
});
});
</script>
  <script type="text/javascript"><!--
var image_row = <?php echo $image_row; ?>;

function addImage() {
  html  = '<tr id="image-row' + image_row + '">';
   html += ' <td class="text-left"><input type="text" name="crousal_product[' + image_row + '][name]" value="" placeholder="<?php echo $entry_link; ?>" class="form-control manufacturer" item="crousal_product[' + image_row + '][type]" itemid="crousal_product[' + image_row + '][id]" /><input type="hidden" name="crousal_product[' + image_row + '][id]" value=""></td>'; 
   html += '    <td class="left"><div class="image"><img src="" alt="" id="thumb' + image_row + '" /><input type="hidden" name="crousal_product[' + image_row + '][image]" value="" id="image' + image_row + '" /><br /><a onclick="image_upload(\'image' + image_row + '\', \'thumb' + image_row + '\');"><?php echo "Browse"; ?></a>&nbsp;&nbsp;|&nbsp;&nbsp;<a onclick="$(\'#thumb' + image_row + '\').attr(\'src\', \'\'); $(\'#image' + image_row + '\').attr(\'value\', \'\');"><?php echo "Clear"; ?></a></div></td>';
   html += '  <td class="text-right"><input type="text" name="crousal_product[' + image_row + '][sort_order]" value="" placeholder="<?php echo $entry_sort_order; ?>" class="form-control" /></td>';
   html += '  <td class="text-left"><a class="button" onclick="$(\'#image-row' + image_row  + '\').remove();"><?php echo $button_remove; ?></a></td>';
  html += '</tr>';
  
  $('#images tbody').append(html);
  
  image_row++;
}

function image_upload(field, thumb) {
  $('#dialog').remove();
  
  $('#content').prepend('<div id="dialog" style="padding: 3px 0px 0px 0px;"><iframe src="index.php?route=common/filemanager&token=<?php echo $token; ?>&field=' + encodeURIComponent(field) + '" style="padding:0; margin: 0; display: block; width: 100%; height: 100%;" frameborder="no" scrolling="auto"></iframe></div>');
  
  $('#dialog').dialog({
    title: '<?php echo "Image Maneger"; ?>',
    close: function (event, ui) {
      if ($('#' + field).attr('value')) {
        $.ajax({
          url: 'index.php?route=common/filemanager/image&token=<?php echo $token; ?>&image=' + encodeURIComponent($('#' + field).attr('value')),
          dataType: 'text',
          success: function(text) {
            $('#' + thumb).replaceWith('<img src="' + text + '" alt="" id="' + thumb + '" />');
          }
        });
      }
    },  
    bgiframe: false,
    width: 800,
    height: 400,
    resizable: false,
    modal: false
  });
};
</script></div>
<?php echo $footer; ?>