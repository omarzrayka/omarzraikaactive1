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

     <div class="buttons"> <a href="<?php echo $add; ?>" class="button"><?php echo $button_insert; ?></a><a onclick="confirm('<?php echo $text_confirm_send; ?>') ? notificationSend() : false;" class="button"><?php echo $button_send; ?></a><a onclick="confirm('<?php echo $text_confirm; ?>') ? $('#form-notification').submit() : false;" class="button"><?php echo $button_delete; ?></a>
      </div>
      </div>
      <div class="content">
         <form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form-notification">
            <table class="list">
              <thead>
                <tr>
                  <td width="1" style="text-align: center;"><input type="checkbox" onclick="$('input[name*=\'selected\']').prop('checked', this.checked);" /></td>
                   <td  class="right"><?php echo $column_banner; ?></td>
                  <td class="left"><?php if ($sort == 'title') { ?>
                    <a href="<?php echo $sort_title; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_title; ?></a>
                    <?php } else { ?>
                    <a href="<?php echo $sort_title; ?>"><?php echo $column_title; ?></a>
                    <?php } ?></td>
                  <td class="left"><?php if ($sort == 'type') { ?>
                    <a href="<?php echo $sort_type; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_type; ?></a>
                    <?php } else { ?>
                    <a href="<?php echo $sort_type; ?>"><?php echo $column_type; ?></a>
                    <?php } ?></td>
                  <td class="right"><?php echo $column_content; ?></td>
                  <td class="left"><?php if ($sort == 'status') { ?>
                    <a href="<?php echo $sort_status; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_status; ?></a>
                    <?php } else { ?>
                    <a href="<?php echo $sort_status; ?>"><?php echo $column_status; ?></a>
                    <?php } ?></td>
                  <td class="left"><?php if ($sort == 'date_added') { ?>
                    <a href="<?php echo $sort_date_added; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_date_added; ?></a>
                    <?php } else { ?>
                    <a href="<?php echo $sort_date_added; ?>"><?php echo $column_date_added; ?></a>
                    <?php } ?></td>
                  <td  class="right"><?php echo $column_action; ?></td>

                </tr>
              </thead>
              <tbody>
              <tr class="filter">
              <td></td>
              <td></td>
              <td> <input type="text" name="filter_title" value="<?php echo $filter_title; ?>" placeholder="<?php echo $entry_title; ?>" id="input-title"  /></td>
              <td> <select name="filter_type" id="input-type">
                  <option value=""></option>
                  <?php if ($filter_type == 1) { ?>
                  <option value="1" selected="selected"><?php echo $text_product; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_product; ?></option>
                  <?php } ?>
                  <?php if ($filter_type == 2) { ?>
                  <option value="2" selected="selected"><?php echo $text_category; ?></option>
                  <?php } else { ?>
                  <option value="2"><?php echo $text_category; ?></option>
                  <?php } ?>
                  <?php if ($filter_type == 3) { ?>
                  <option value="3" selected="selected"><?php echo $text_other; ?></option>
                  <?php } else { ?>
                  <option value="3"><?php echo $text_other; ?></option>
                  <?php } ?>
                </select></td>
              <td></td>
              <td align="left"> <select name="filter_status" id="input-status" >
                  <option value=""></option>
                  <?php if ($filter_status) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <?php } ?>
                  <?php if (!$filter_status && !is_null($filter_status)) { ?>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select></td>
              <td align="right"></td>
              <td align="right"><a  id="button-filter" class="button"><?php echo $button_filter; ?></a></td>
            </tr>
                <?php if ($notifications) { ?>
                <?php foreach ($notifications as $notification) { ?>
                <tr>
                  <td class="left"><?php if (in_array($notification['notification_id'], $selected)) { ?>
                    <input type="checkbox" name="selected[]" value="<?php echo $notification['notification_id']; ?>" checked="checked" />
                    <?php } else { ?>
                    <input type="checkbox" name="selected[]" value="<?php echo $notification['notification_id']; ?>" />
                    <?php } ?></td>
                    <td class="center"><img src="<?php echo $notification['image']; ?>" alt="<?php echo $notification['title']; ?>" style="padding: 1px; border: 1px solid #DDDDDD;" /></td>
                  <td class="left"><?php echo $notification['title']; ?></td>
                  <td class="left">
                    <?php if ($notification['type'] == 1) {
                        echo $text_product;
                    } elseif ($notification['type'] == 2) {
                        echo $text_category;
                    } elseif ($notification['type'] == 3) {
                        echo $text_other;
                    } elseif ($notification['type'] == 4) {
                        echo $text_customcollection;
                    } ?>
                  </td>
                  <td class="right"><?php echo $notification['content']; ?></td>
                  <td class="left"><?php echo $notification['status']; ?></td>
                  <td class="left"><?php echo $notification['date_added']; ?></td>
                  <td class="right"> <a href="<?php echo $notification['edit']; ?>"><?php echo $button_edit; ?></a> ]</td>
                </tr>
                <?php } ?>
                <?php } else { ?>
                <tr>
                  <td class="center" colspan="8"><?php echo $text_no_results; ?></td>
                </tr>
                <?php } ?>
              </tbody>
            </table>
        </form>
          <div class="pagination"><?php echo $pagination; ?></div>
      </div>
    </div>
  </div>
  <script type="text/javascript"><!--
$('#button-filter').on('click', function() {
  url = 'index.php?route=mobiapp/notification&token=<?php echo $token; ?>';
  
  var filter_title = $('input[name=\'filter_title\']').val();
  
  if (filter_title) {
    url += '&filter_title=' + encodeURIComponent(filter_title);
  }
  
  var filter_type = $('select[name=\'filter_type\']').val();
  
  if (filter_type) {
    url += '&filter_type=' + encodeURIComponent(filter_type);
  }
  
  var filter_status = $('select[name=\'filter_status\']').val();
  
  if (filter_status) {
    url += '&filter_status=' + encodeURIComponent(filter_status);
  }
    
  var filter_date_added = $('input[name=\'filter_date_added\']').val();
  
  if (filter_date_added) {
    url += '&filter_date_added=' + encodeURIComponent(filter_date_added);
  }
  
  location = url;
});
//--></script> 
<script type="text/javascript"><!--

function notificationSend () {
  var str = '<?php echo $send; ?>';
  var action = str.replace(/&amp;/g, "&");
  $('#form-notification').attr('action',action);
  $('#form-notification').submit();
}
//--></script></div>
<?php echo $footer; ?>