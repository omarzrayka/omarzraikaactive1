<?php echo $header; ?>
<div id="content">
<i class="fa fa-trash-o" aria-hidden="true"></i>
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

     <div class="buttons"> <a href="<?php echo $add; ?>" class="button"><?php echo $button_insert; ?></a>
      
      </div>
      </div>
      <div class="content">
         <form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form-notification">
            <div class="table-responsive">
            <table class="table table-bordered table-hover list">
              <thead>
                <tr>
                  <td class="text-center"><?php echo $column_id; ?></td>
                  <td class="text-center"><?php echo $column_name; ?></td>
                  <td class="text-center"><?php echo $column_product_id; ?></td>
                  <td class="text-center"><?php echo $column_product_name; ?></td>
                  <td class="text-right"><?php echo $column_action; ?></td>
                </tr>
              </thead>
              <tbody>
                <?php if ($collections) { ?>
                <?php foreach ($collections as $collection) { ?>
                <tr>
                  <td class="text-center"><?php echo $collection['id']; ?></td>
                  <td class="text-center"><?php echo $collection['name']; ?></td>
                  <td class="text-center"><?php echo $collection['product_id']; ?></td>
                  <td class="text-center"><?php echo $collection['product_name']; ?></td>
                  <td class="text-center">
                    <button type="button" id="<?php echo $collection['id']; ?>" data-toggle="tooltip" title="<?php echo $button_delete; ?>" class="btn btn-danger delete" > Delete </button>
                  </td>
                </tr>
                <?php } ?>
                <?php } else { ?>
                <tr>
                  <td class="text-center" style="text-align:center;" colspan="8"><?php echo $text_no_results; ?></td>
                </tr>
                <?php } ?>
              </tbody>
            </table>
          </div>
        </form>
          <div class="pagination"><?php echo $pagination; ?></div>
      </div>
    </div>
  </div>
</div>

<script type="text/javascript">
  $('.delete').on('click',function(){
    var id = $(this).attr('id');
    if (confirm('<?php echo $text_confirm; ?>')) {
      $.ajax({
        url: 'index.php?route=mobiapp/customcollection/delete&token=<?php echo $token; ?>',
        method: 'GET',
        dataType: 'json',
        data : { id : id },
        success: function (json) {
           window.location.reload(); 
        },
        error : function(error){
          console.log(error);
        },
        async: false
      });  
    }
  });
</script>

<?php echo $footer; ?>