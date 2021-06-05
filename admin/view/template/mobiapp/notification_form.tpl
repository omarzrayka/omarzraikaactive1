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
<div class="box">
      <div class="heading">
      <h1><img src="view/image/product.png" alt="" /> <?php echo " ".$text_form; ?></h1>
   <div class="buttons"> <a onclick="confirm('<?php echo $text_confirm_send_save; ?>') ? notificationSend() : false;" class="button"><?php echo $button_send; ?> &amp; <?php echo $button_save; ?></a>
     <a onclick ="$('#form-notification').submit()" form="form-notification"  class="button"><?php echo $button_save; ?></a>
     <a href="<?php echo $cancel; ?>"  class="button"><?php echo $button_cancel; ?></a>
      </div>
    </div>
    <div class="content">
        <form  method="post" enctype="multipart/form-data" id="form-notification" class="form-horizontal">
            <table class="form">
            <tr>
            <td><?php echo $entry_title; ?></td>
            <td>

              <?php foreach ($languages as $language) { ?><div class="input-group"><span class="input-group-addon"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> </span>
                <input type="text" name="title[<?php echo $language['language_id']; ?>]" value="<?php echo isset($title[$language['language_id']]) ? $title[$language['language_id']] : ''; ?>" placeholder="<?php echo $entry_title; ?>" class="form-control" size="100" /></div>
              <?php if (isset($error_title[$language['language_id']])) { ?>
              <div class="text-danger"><?php echo $error_title[$language['language_id']]; ?></div>
              <?php } ?>
              <?php } ?></td>
              </tr>
          <tr><td><?php echo $entry_content; ?></td>
          <td>
              <textarea name="content" rows="5" placeholder="<?php echo $entry_content; ?>" id="description" cols="40" rows="5"><?php echo $content; ?></textarea>
            </td></tr>
          <tr><td><?php echo $entry_type; ?></td>
          <td>
              <select name="type" id="input-type" style="width: 34%;">
                <option value="1" <?php if($type == 1) echo 'selected';?>>  <?php echo $text_product; ?> </option>
                <option value="2" <?php if($type == 2) echo 'selected';?>>  <?php echo $text_category; ?> </option>
                <option value="3" <?php if($type == 3) echo 'selected';?>>  <?php echo $text_other; ?> </option>
                <option value="4" <?php if($type == 4) echo 'selected';?>>  <?php echo $text_customcollection; ?> </option>
              </select>
            </td>
            </tr>
            <tr class="<?php if($type == 4) echo 'hide';?>" id="form-group_product">
              <td><?php echo $entry_id; ?></td>
              <td>
                <input type="text" name="product_category" value="<?php echo $name; ?>" placeholder="<?php echo $entry_id; ?>" id="input-id" size="100" />
                <input type="hidden" name="id" value="<?php echo $id; ?>" >
                <?php if ($error_id) { ?>
                <div class="text-danger"><?php echo $error_id; ?></div>
                <?php } ?>
              </td>
            </tr>

            <tr class="<?php if($type != 4) echo 'hide';?>" id="form-group_collection">
              <td><?php echo $entry_custom_id; ?></td>
              <td>
                <select name="input-custom_id" id="input-custom_id" class="form-control">
                  <option value="0"><?php echo $text_select; ?> </option>
                  <?php if(isset($custom_collections) && $custom_collections) {
                    foreach($custom_collections as $custom_collection){ ?>
                      <option value="<?php echo $custom_collection['id']; ?>" <?php if($custom_collection['id'] == $id) echo "selected"; ?> ><?php echo $custom_collection['name']; ?></option>
                  <?php  }
                  } ?>
                </select>
                <?php if ($error_id) { ?>
                <div class="text-danger"><?php echo $error_id; ?></div>
                <?php } ?>
              </td>
            </tr>

          <tr><td><?php echo $entry_status; ?></td>
            <td>
              <select name="status" id="input-status" style="width: 34%;">
                <option value="0" <?php if(!$status) echo 'selected';?>>  <?php echo $text_disabled; ?> </option>
                <option value="1" <?php if($status) echo 'selected';?>>  <?php echo $text_enabled; ?> </option>
              </select>
            </td>
            </tr>
            <tr>
              <td><?php echo $entry_image; ?></td>
              <td><div class="image"><img src="<?php echo $image; ?>" alt="" id="thumb" /><br />
                  <input type="hidden" name="image" value="<?php echo $thumb; ?>" id="image" />
                  <a onclick="image_upload('image', 'thumb');"><?php echo $text_browse; ?></a>&nbsp;&nbsp;|&nbsp;&nbsp;<a onclick="$('#thumb').attr('src', '<?php echo $no_image; ?>'); $('#image').attr('value', '');"><?php echo $text_clear; ?></a></div></td>
            </tr>
        </form>
        </table>
    </div>
  </div>
<script type="text/javascript">
  // $('#input-content').summernote({height: 200});
  if ($('#input-type').val() == 3) {
    $('#input-id').attr('disabled','true');
  };

  function notificationSend () {
    $('#form-notification').append('<input type="hidden" name="send">');
    $('#form-notification').submit();
  }
</script>
<script>
jQuery(function(){
  $('#input-type').on('change', function () {
    var type = $('#input-type').val();

    if (type == 4) {
      $('#form-group_product').addClass('hide');
      $('#form-group_collection').removeClass('hide');
    } else {
      $('#form-group_collection').addClass('hide');
      $('#form-group_product').removeClass('hide');
    }

    if (type == 3) {
      $('#input-id').attr('disabled','true');
      $('input[name=\'id\']').val('');
    } else {
      $('#input-id').removeAttr('disabled');
    }
  });
  $('input[name=\'product_category\']').autocomplete({
  source: function(request, response) {
    $.ajax({
      url: 'index.php?route=mobiapp/notification/getItem&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request.term),
      data :({type : $('#input-type').val()}),
      dataType: 'json',
       type: 'post',
      success: function(json) {   
        response($.map(json, function(item) {
          return {
            label: item.name,
            value: item.id
            }
        }));
      }
    });
  }, 
  select: function(event, ui) {
    $('input[name=\'product_category\']').attr('value', ui.item.label);
    $('input[name=\'id\']').attr('value', ui.item.value);
  
    return false;
  },
  focus: function(event, ui) {
      return false;
   }
});
});
</script>
<script type="text/javascript" src="view/javascript/ckeditor/ckeditor.js"></script> 
<script type="text/javascript"><!--
CKEDITOR.replace('description', {
  filebrowserBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
  filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
  filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
  filebrowserUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
  filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
  filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>'
});
function image_upload(field, thumb) {
  $('#dialog').remove();
  
  $('#content').prepend('<div id="dialog" style="padding: 3px 0px 0px 0px;"><iframe src="index.php?route=common/filemanager&token=<?php echo $token; ?>&field=' + encodeURIComponent(field) + '" style="padding:0; margin: 0; display: block; width: 100%; height: 100%;" frameborder="no" scrolling="auto"></iframe></div>');
  
  $('#dialog').dialog({
    title: '<?php echo $text_image_manager; ?>',
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
//--></script> 
<?php echo $footer; ?>