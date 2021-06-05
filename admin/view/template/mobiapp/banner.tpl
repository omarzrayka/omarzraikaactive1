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
      <a onclick ="$('#form-banner').submit()" class="button"><?php echo $button_save; ?></a>
      <a href="<?php echo $cancel; ?>"  class="button"><?php echo $button_cancel; ?></a>
      </div>
      </div>
      <div class="content">
        <form  method="post" enctype="multipart/form-data" id="form-banner" class="form-horizontal">
          <table id="images" class="form">
            <thead>
              <tr>
                <td class="left" style="width:300px;"><?php echo $entry_title; ?></td>
                <td class="left" style="width:165px;"><?php echo $entry_type; ?></td>
                <td class="left"><?php echo $entry_link; ?></td>
                <td class="left"><?php echo $entry_image; ?></td>
                <td class="right"><?php echo $entry_sort_order; ?></td>
                <td></td>
              </tr>
            </thead>
            <tbody>
              <?php $image_row = 0; ?>
              <?php foreach ($banner_images as $banner_image) { ?>
              <tr id="image-row<?php echo $image_row; ?>">
                <td class="text-left"><?php foreach ($languages as $language) { ?>
                  <div class="input-group pull-left"><span class="input-group-addon"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> </span>
                    <input type="text" name="banner_image[<?php echo $image_row; ?>][banner_image_description][<?php echo $language['language_id']; ?>][title]" value="<?php echo isset($banner_image['banner_image_description'][$language['language_id']]) ? $banner_image['banner_image_description'][$language['language_id']]['title'] : ''; ?>" placeholder="<?php echo $entry_title; ?>" class="form-control" />
                  </div>
                  <?php if (isset($error_banner_image[$image_row][$language['language_id']])) { ?>
                  <div class="text-danger"><?php echo $error_banner_image[$image_row][$language['language_id']]; ?></div>
                  <?php } ?>
                  <?php } ?></td>
                <td>                  
                  <select name="banner_image[<?php echo $image_row; ?>][type]" id="input-type" class="form-control">
                    <option value="1" <?php if($banner_image['type'] == 1) echo 'selected';?>>  <?php echo $text_product; ?> </option>
                    <option value="2" <?php if($banner_image['type'] == 2) echo 'selected';?>>  <?php echo $text_category; ?> </option>
                    <option value="3" <?php if($banner_image['type'] == 3) echo 'selected';?>>  <?php echo $text_manufacturer; ?> </option>
                    <option value="4" <?php if($banner_image['type'] == 4) echo 'selected';?>>  <?php echo $text_seller; ?> </option>
                    <option value="5" <?php if($banner_image['type'] == 5) echo 'selected';?>>  <?php echo $text_search; ?> </option>
                  </select>
                </td>
                <td class="text-left" style="width: 30%;"><input type="text" name="banner_image[<?php echo $image_row; ?>][name]" value="<?php echo $banner_image['name']; ?>" placeholder="<?php echo $entry_link; ?>" class="form-control product_category" item="banner_image[<?php echo $image_row; ?>][type]" itemid="banner_image[<?php echo $image_row; ?>][id]" /><input type="hidden" name="banner_image[<?php echo $image_row; ?>][id]" value="<?php echo $banner_image['id']; ?>"></td>


                  <td><div class="image"><img src="<?php echo $banner_image['thumb']; ?>" alt="" id="thumb" /><br />
                  <input type="hidden" name="banner_image[<?php echo $image_row; ?>][image]" value="<?php echo $banner_image['image']; ?>" id="image" />
                  <a onclick="image_upload('image', 'thumb');"><?php echo 'Browse' ?></a>&nbsp;&nbsp;|&nbsp;&nbsp;<a onclick="$('#thumb').attr('src', ''); $('#image').attr('value', '');"><?php echo 'Clear'; ?></a></div></td> 


                <!-- <td class="text-left"><a href="" id="thumb-image<?php echo $image_row; ?>" data-toggle="image" class="img-thumbnail"><img src="<?php echo $banner_image['thumb']; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" /></a>
                  <input type="hidden" name="banner_image[<?php echo $image_row; ?>][image]" value="<?php echo $banner_image['image']; ?>" id="input-image<?php echo $image_row; ?>" /></td> -->
                <td class="text-right"><input type="text" name="banner_image[<?php echo $image_row; ?>][sort_order]" value="<?php echo $banner_image['sort_order']; ?>" placeholder="<?php echo $entry_sort_order; ?>" class="form-control" /></td>
                <td class="text-left"><a class="button" onclick="$('#image-row<?php echo $image_row; ?>, .tooltip').remove();"><?php echo $button_remove; ?></a></td>
              </tr>
              <?php $image_row++; ?>
              <?php } ?>
            </tbody>
            <tfoot>
              <tr>
                <td colspan="5"></td>
                <td class="text-left"><a class="button" onclick="addImage();" data-toggle="tooltip" title="" class="button"><?php echo 'Add Banner'; ?></a></td>
              </tr>
            </tfoot>
          </table>
        </form>
      </div>
    </div>
  </div>
<script>
jQuery(function(){
    $(document.body).on('click', '.product_category' ,function(){
      var type_name = $(this).attr('item');

      var link_name = $(this).attr('name');
      var link_id = $(this).attr('itemid');
      var link_type = $("select[name='"+type_name+"']").val();
      console.log(link_type);
      // Items
      $('.product_category').autocomplete({

        'source': function(request, response) {
          $.ajax({
            url: 'index.php?route=mobiapp/notification/getItem&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request.term),
            dataType: 'json',
            data: ({type : link_type}),
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
    html += '  <td class="text-left">';
  <?php foreach ($languages as $language) { ?>
  html += '    <div class="input-group">';
  html += '      <span class="input-group-addon"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /></span><input type="text" name="banner_image[' + image_row + '][banner_image_description][<?php echo $language['language_id']; ?>][title]" value="" placeholder="<?php echo $entry_title; ?>" class="form-control" />';
    html += '    </div>';
  <?php } ?>
  html += '  </td>';  
  html += '   <td> <select name="banner_image[' + image_row + '][type]" id="input-type" class="form-control"> ';
  html += '   <option value="1">  <?php echo $text_product; ?> </option> ';
  html += '   <option value="2">  <?php echo $text_category; ?> </option>';
   html += '   <option value="3">  <?php echo $text_manufacturer; ?> </option>';
    html += '   <option value="4">  <?php echo $text_seller; ?> </option>';
     html += '   <option value="5">  <?php echo $text_search; ?> </option>';
  html += '   </select></td>';
  html += ' <td class="text-left"><input type="text" name="banner_image[' + image_row + '][name]" value="" placeholder="<?php echo $entry_link; ?>" class="form-control product_category" item="banner_image[' + image_row + '][type]" itemid="banner_image[' + image_row + '][id]" /><input type="hidden" name="banner_image[' + image_row + '][id]" value=""></td>';  
  // html += '<td><div class="image"><img src="<?php echo $placeholder; ?>" alt="" id="thumb' + image_row + '"  /><br /> <input type="hidden" name="banner_image[' + image_row + '][image]" value="" id="input-image' + image_row + ' "/> <a onclick="image_upload(\'image' + image_row + '\', \'thumb' + image_row + '\');"><?php echo "a"; ?></a></div></td>';

html += '    <td class="left"><div class="image"><img src="" alt="" id="thumb' + image_row + '" /><input type="hidden" name="banner_image[' + image_row + '][image]" value="" id="image' + image_row + '" /><br /><a onclick="image_upload(\'image' + image_row + '\', \'thumb' + image_row + '\');"><?php echo "Browse"; ?></a>&nbsp;&nbsp;|&nbsp;&nbsp;<a onclick="$(\'#thumb' + image_row + '\').attr(\'src\', \'\'); $(\'#image' + image_row + '\').attr(\'value\', \'\');"><?php echo "Clear"; ?></a></div></td>';

  // html += '  <td class="text-left"><a href="" id="thumb-image' + image_row + '" data-toggle="image" class="img-thumbnail"><img src="<?php echo $placeholder; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" /></a><input type="hidden" name="banner_image[' + image_row + '][image]" value="" id="input-image' + image_row + '" /></td>';
  html += '  <td class="text-right"><input type="text" name="banner_image[' + image_row + '][sort_order]" value="" placeholder="<?php echo $entry_sort_order; ?>" class="form-control" /></td>';
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
//--></script></div>
<?php echo $footer; ?>