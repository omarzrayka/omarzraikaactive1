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
      <a onclick ="$('#form-category').submit()" class="button"><?php echo $button_save; ?></a>
      <a href="<?php echo $cancel; ?>"  class="button"><?php echo $button_cancel; ?></a>
      </div>
      </div>
      <div class="content">
        <form  method="post" enctype="multipart/form-data" id="form-category" class="form-horizontal">
          <table id="images" class="form">
            <thead>
              <tr>
                <td class="left" style="width:300px;"><?php echo $entry_image; ?></td>
                <td class="left" style="width:165px;"><?php echo $entry_name; ?></td>
                <td class="left" style="width:165px;"><?php echo $entry_status; ?></td>
                <td class="left" style="width:165px;"><?php echo $entry_date; ?></td>
                <td class="left" style="width:165px;"><?php echo $entry_icon; ?></td>
              </tr>
            </thead>
            <tbody>
            <?php $image_row = 0; ?>
              <?php foreach ($categories as $category) { ?>
              <tr>
                 <td class="center"><img src="<?php echo $category['image']; ?>" alt="<?php echo $category['name']; ?>" style="padding: 1px; border: 1px solid #DDDDDD;" /><input type="hidden" name="category[<?php echo $image_row;?>][category_id]" value="<?php echo $category['id']; ?>" /></td>
                <td name="name"><?php echo $category['name']; ?><input type="hidden" name="category[<?php echo $image_row;?>][name]" value="<?php echo $category['name']; ?>" /></td>
                <td name="status"><?php if($category['status']) echo $text_enabled; else echo $text_disabled ; ?><input type="hidden" name="category[<?php echo $image_row;?>][status]" value="<?php echo $category['status']; ?>" /></td>
                <td name="date"><?php echo $category['date_added']; ?><input type="hidden" name="category[<?php echo $image_row;?>][date_added]" value="<?php echo $category['date_added']; ?>" /></td>
                <td><div class="image">
                <img src="<?php echo $category['icon_image']; ?>" alt="" id= "thumb<?php echo $image_row; ?>"/><br />
                  <input type="hidden" name="category[<?php echo $image_row; ?>][icon]" value="<?php echo $category['icon_value'];?>" id="image<?php echo $image_row; ?>" />
                  <a onclick="image_upload('image<?php echo $image_row; ?>', 'thumb<?php echo $image_row;?>')"><?php echo 'Browse' ?></a>&nbsp;&nbsp;|&nbsp;&nbsp;<a onclick="$('#thumb<?php echo $image_row; ?>').attr('src', ''); $('#image<?php echo $image_row; ?>').attr('value', '');"><?php echo 'Clear'; ?></a></div></td> 
              </tr>

              <?php $image_row++; } ?>          
             </tbody>
          </table>
        </form>
      </div>
    </div>
  </div>

  <script type="text/javascript"><!--
var image_row = <?php echo $image_row; ?>;

// function addImage() {
//   html  = '<tr id="image-row' + image_row + '">';
//     html += '  <td class="text-left">';
//   <?php foreach ($languages as $language) { ?>
//   html += '    <div class="input-group">';
//   html += '      <span class="input-group-addon"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /></span><input type="text" name="banner_image[' + image_row + '][banner_image_description][<?php echo $language['language_id']; ?>][title]" value="" placeholder="<?php echo $entry_title; ?>" class="form-control" />';
//     html += '    </div>';
//   <?php } ?>
//   html += '  </td>';  
//   html += '   <td> <select name="banner_image[' + image_row + '][type]" id="input-type" class="form-control"> ';
//   html += '   <option value="1">  <?php echo $text_product; ?> </option> ';
//   html += '   <option value="2">  <?php echo $text_category; ?> </option>';
//   html += '   </select></td>';
//   html += ' <td class="text-left"><input type="text" name="banner_image[' + image_row + '][name]" value="" placeholder="<?php echo $entry_link; ?>" class="form-control product_category" item="banner_image[' + image_row + '][type]" itemid="banner_image[' + image_row + '][id]" /><input type="hidden" name="banner_image[' + image_row + '][id]" value=""></td>';  

// html += '    <td class="left"><div class="image"><img src="" alt="" id="thumb' + image_row + '" /><input type="hidden" name="banner_image[' + image_row + '][image]" value="" id="image' + image_row + '" /><br /><a onclick="image_upload(\'image' + image_row + '\', \'thumb' + image_row + '\');"><?php echo "Browse"; ?></a>&nbsp;&nbsp;|&nbsp;&nbsp;<a onclick="$(\'#thumb' + image_row + '\').attr(\'src\', \'\'); $(\'#image' + image_row + '\').attr(\'value\', \'\');"><?php echo "Clear"; ?></a></div></td>';
//   html += '  <td class="text-right"><input type="text" name="banner_image[' + image_row + '][sort_order]" value="" placeholder="<?php echo $entry_sort_order; ?>" class="form-control" /></td>';
//   html += '  <td class="text-left"><a class="button" onclick="$(\'#image-row' + image_row  + '\').remove();"><?php echo $button_remove; ?></a></td>';
//   html += '</tr>';
  
//   $('#images tbody').append(html);
  
//   image_row++;
// }

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