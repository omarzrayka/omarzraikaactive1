
<?php echo $header_new; ?>

<div class="page-header">
	<div class="container-fluid">

		<ol class="breadcrumb">
			<?php foreach ($breadcrumbs as $breadcrumb) { ?>
				<li style="margin: 5px;">
					<a href="<?php echo $breadcrumb['href']; ?>">
						<?php echo $breadcrumb['text']; ?>
					</a>
				</li>
			<?php } ?>
		</ol>
	</div>
</div>

  <div class="container-fluid ">
	
	<div class="card text-left">
		<div class="card-header">
			<?php echo $heading_title; ?>
		</div>
		<div class="card-body">
		<?php  // $temp_list = $this->session->data['temp_list'];
		      
			  if(count($temp_list)< 2){ ?>
			<form method="POST" action="<?php echo $action_upload; ?>" enctype="multipart/form-data" class="row" id="form1">
			
                <div class="form-group col-sm-2">
				  <label for="images"><?php echo $entry_name; ?></label>
				  <input type="file" class="form-control-sm" id="images" name="images[]" placeholder="" value="" multiple >
				</div>

            </form>
			<?php } ?>
			<form method="POST" action="<?php echo $action; ?>" enctype="multipart/form-data" class="row" id="form">
                <div class="col-sm-12">
                   <div class="row">     
			 <form method="POST" action="<?php echo $action; ?>" enctype="multipart/form-data" class="row" id="form">
           <table id="images" class="table table-hover">
            <thead>
            <tr>
        
              <td class="left"><?php echo $entry_image; ?></td>
			  <td></td>
              
              <td class="left">Mobile App Type</td>
              <td class="left">Mobile Type Id</td>
              
              <td></td>
            </tr>
           </thead>
           <tbody>
		   <?php 
		   
		//  copy('banner6/download (3).jpg' , DIR_IMAGE.'cache/data/download (3).jpg');	 ?>
       
	        <?php $image_row = 0; ?>
            <?php foreach ($banner_images as $banner_image) { ?>
            <tr id="image-row<?php echo $image_row; ?>">
               <td class="">
				  <a id="thumb-image" class="button-image">
					  <img src="<?php echo $banner_image['thumb']; ?>" alt="" id="product_image<?php echo $image_row; ?>"  data-attr="product-img">
					  <input type="hidden" class="product_image_input"  name="banner_image[<?php echo $image_row; ?>][image]" value="<?php echo $banner_image['image']; ?>" id="input-image<?php echo $image_row; ?>"  />
					  <input type="hidden"  name="bannerimage[<?php echo $image_row; ?>]" value="<?php echo $banner_image['image']; ?>"   />
			      </a>
				 
				</td>
				<td></td>
              
               <td class="left"><select name="banner_image[<?php echo $image_row; ?>][mobile_type]"  class="form-control">
				<option value="1" <?php if($banner_image['mobile_type']=='1'){ echo 'selected';} ?>> Product id </option>
				<option value="2" <?php if($banner_image['mobile_type']=='2'){ echo 'selected';} ?>> Category id </option>
				<option value="3" <?php if($banner_image['mobile_type']=='3'){ echo 'selected';} ?>> Manufacturer id </option>
				<option value="4" <?php if($banner_image['mobile_type']=='4'){ echo 'selected';} ?>> Seller id </option>
				<option value="5" <?php if($banner_image['mobile_type']=='5'){ echo 'selected';} ?>> Search keyword</option>
				<option value="6" <?php if($banner_image['mobile_type']=='6'){ echo 'selected';} ?>> New Arrivals</option>
				<option value="7" <?php if($banner_image['mobile_type']=='7'){ echo 'selected';} ?>> Special Deals</option>
				</select></td>
				
				<td>
				<input type="text" 
				name="banner_image[<?php echo $image_row; ?>][name]"  
				item="banner_image[<?php echo $image_row; ?>][mobile_type]"
			    itemid="banner_image[<?php echo $image_row; ?>][mobile_type_id]"
			    id="banner_image[<?php echo $image_row; ?>][mobile_type_id]"
				class="product_category form-control" 
				value="<?php echo $banner_image['name']; ?>">
				<input type="text" item="banner_image[<?php echo $image_row; ?>][mobile_type]" class="mobile_type_id"   name="banner_image[<?php echo $image_row; ?>][mobile_type_id]"  value="<?php echo $banner_image['mobile_type_id']; ?>" onkeyup="showMe(this)">
				</td>


				 <td class="left"><button onclick="$('#image-row<?php echo $image_row; ?>').remove();" class="btn btn-primary btn-sm"><?php echo $button_remove; ?></button></td>
				 
            </tr>        
		                	<?php  $image_row++; ?>	
           
				    <?php } ?>

				     <?php    
					            if(isset($temp_list)){ 
							
                                for($i=0; $i<count($temp_list);$i++){ 
									if(isset($temp_list[$i]['size'])){	?>
								

            <tr id="image-row<?php echo $image_row; ?>">
               <td class="left">
				  <a id="thumb-image" class="button-image">
					  <img src="<?php echo $temp_list[$i]['image'] ?>" alt="" id="product_image<?php echo $image_row; ?>"  data-attr="product-img">
					  <input type="hidden" class="product_image_input" name="banner_image[<?php echo $image_row; ?>][image]" value="<?php echo $temp_list[$i]['image']; ?>" id="input-image<?php echo $image_row; ?>"  />
					  <input type="hidden"  name="bannerimage[<?php echo $image_row; ?>]" value="<?php echo $temp_list[$i]['image']; ?>"   />

			      </a>
				</td>
				<td>
		
				 width: <span style="color:<?php if($temp_list[$i]['width'] > 100){ echo 'red';} ?>"><?php echo $temp_list[$i]['width'] ?></span><br>
				 height: <span style="color:<?php if($temp_list[$i]['height'] > 100){ echo 'red';} ?>"><?php echo $temp_list[$i]['height']  ?></span><br>
				 size: <span style="color:<?php if($temp_list[$i]['size'] > 13){ echo 'red';} ?>"><?php echo $temp_list[$i]['size'] ?></span>
				 
				  
				</td>
              
               <td class="left"><select name="banner_image[<?php echo $image_row; ?>][mobile_type]"  class="form-control">
				<option value="1"> Product id </option>
				<option value="2"> Category id </option>
				<option value="3"> Manufacturer id </option>
				<option value="4"> Seller id </option>
				<option value="5"> Search keyword</option>
				<option value="6"> New Arrivals</option>
				<option value="7"> Special Deals</option>
				</select></td>
				
				<td class="left">
				<input type="text" 
				name="banner_image[<?php echo $image_row; ?>][name]"  
				item="banner_image[<?php echo $image_row; ?>][mobile_type]"
			    itemid="banner_image[<?php echo $image_row; ?>][mobile_type_id]"
			    id="banner_image[<?php echo $image_row; ?>][mobile_type_id]"
				class="product_category form-control" 
				value="">
				<input type="hidden" name="banner_image[<?php echo $image_row; ?>][mobile_type_id]"  value="">
				</td>


				 <td class="left"><button onclick="$('#image-row<?php echo $image_row; ?>').remove();" class="btn btn-primary btn-sm"><?php echo $button_remove; ?></button></td>
				 
            </tr>
			                        <?php  $image_row++; ?>	
								    <?php } ;?>
								<?php } ;?>
							<?php } ;?>
							
								
          </tbody>
    
          <tfoot>
            <tr>
              <td colspan="4"></td>
              <td class="left"><button onclick="addImage();" class="btn btn-primary btn-sm"><?php echo $button_add_banner; ?></button></td>
            </tr>
          </tfoot>
        </table>
      </div>   
     </div>
      </form>
    </div>
    <div class="card-footer text-muted">
			<div style="float: right">
				<button type="button" class="btn btn-primary btn-sm " onclick="save()">Submit</button>
			</div>
    </div>
  </div>
</div>
<?php echo $footer_new; ?>

<script type="text/javascript">
	function save(){
		var msg = '';
	  
			$("#form").submit();
	
		
		if($.trim(msg) != ''){
			$('<div class="alert alert-danger alert-dismissible fade show" role="alert"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i> '+msg+'<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button></div>')
		.insertBefore($('form'))
		}
	}
</script>

<script>


   $("#images").change(function(){

	
	$("#form1").submit();

   });   



</script>


<script>

jQuery(function(){
   
   $(document.body).on('keyup', '.product_category' ,function(){
  
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

function showMe(e) {



	var id = $(e).parent().parent().find($("td:nth-child(3)")).find("select").val()
	console.log(id)
// i am spammy!



 $.ajax({
 		url: 'index.php?route=mobiapp/notification/getItemById&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(e.value),
 		dataType: 'json',
		data: ({type : id}),
		type: 'post', 	success: function(json) {
	console.log(json[0]['name']);

	 $(e).parent().parent().find($("td:nth-child(3)")).find("input").text();

		}
		
	  });




}




</script>

<style type="text/css">
			.myDragClass td, .myDragClass td:hover{
				background: #39363C !important;
				color: #FFFFFF !important;
			}
</style>