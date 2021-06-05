<?php echo $header_new; ?>
<div class="page-header">
	<div class="container-fluid">

		<h4 class="mt-3 mb-3"><?php echo $heading_title; ?></h4>
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

<div class="container-fluid">
 <div class="card-header row">
		
        <div class="col-sm-6">
            <h4><?php echo $heading_title; ?></h4>
        </div>
        <div class="col-sm-6 text-right">
            <a href="<?php echo $insert; ?>" class="btn btn-primary btn-sm btn-sm " ><i class="fa fa-plus" aria-hidden="true"></i> <?php echo $button_insert; ?></a>
			<button type="button" class="btn btn-danger btn-sm btn-sm "  data-toggle="modal" data-target="#remove_modal" ><i class="fa fa-trash" aria-hidden="true"></i> Remove</button>

        </div>
        
    </div>

	<table id="data_table" class="table table-sm table-bordered table-hover ">
		<thead>
			<tr>
		    	<th><input type="checkbox" onclick="$('input[name*=\'selected\']').attr('checked', this.checked).trigger('change');"></th>
				<th>image</th>
				<th>name</th>
				<th>status</th>
				<th class="noExl">Action</th>
			</tr>
		</thead>
		
			<tr class="filter-row noExl">
				<td></td>
				<td></td>
				<td>
				<input  id="filter_name" name="filter_name" class="form-control form-control-sm" id="myInput" type="text" placeholder="Search..">
				</td>
				<td class="noExl">
					<select id="filter_status" name="filter_status" class="form-control form-control-sm">
					    <option value="-1" >-- none --</option>
						<option value="0" <?php if (strtolower($filter_status) == '0') { ?> selected="selected" <?php } ?>><?php echo $text_disabled; ?></option>
						<option value="1" <?php if (strtolower($filter_status) == '1') { ?> selected="selected" <?php } ?>><?php echo $text_enabled; ?></option>
					</select>
				</td>
				<td class="d-flex justify-content-center align-items-center noExl">
					<button type="button" id="btn_filter" class="btn btn-primary btn-sm"><i class="fa fa-filter" aria-hidden="true"></i> Filter</button>
				</td>
			</tr>
		<tbody>
			
			<?php foreach ($banners as $banner) { ?>
				<tr> 
			     	<td><input type="checkbox" name="selected[]" value="<?php echo $banner['banner_id']; ?>" /></td>

					<td class="center"><?php 
					$image = $banner['image'];
					for($i=0; $i<count($image);$i++){ ?>

						<img src="<?php echo $image[$i]; ?>" alt="<?php echo $image[$i]; ?>" style="padding: 1px; border: 1px solid #DDDDDD;" />

                                <?php } ?></td>
					<td  ><div data-id="<?php echo $banner["banner_id"] ?>" class="editable-text"><?php echo $banner['name']; ?></div></td>
					<td  style="color:<?php if($banner["status"] == 'Enabled') {echo '';}else {echo 'red';}  ?>"><div data-id="<?php echo $banner["banner_id"] ?>" class="editable-select"   data-id="<?php echo $banner["banner_id"] ?>" class="editable-select "><?php echo $banner['status']; ?></div></td>
					<td class="right"><?php foreach ($banner['action'] as $action) { ?>
							<a href="<?php echo $action['href']; ?>" class="btn btn-primary btn-sm"><?php echo $action['text']; ?></a> 
						<?php } ?></td>
				</tr>
			<?php  } ?>

		</tbody>
	</table>
	<div class="row">
		<div class="ml-left container-fluid">
			<nav aria-label="Page navigation">
				<?php echo $pagination; ?>
			</nav>

		</div>

	</div>
</div>

<div class="modal" tabindex="-1" role="dialog" id="remove_modal" aria-labelledby="remove_modal" aria-hidden="true">
	<div class="modal-dialog" role="document">
	  <div class="modal-content">
		<div class="modal-header">
		  <h5 class="modal-title">Remove</h5>
		  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			<span aria-hidden="true">&times;</span>
		  </button>
		</div>
		<div class="modal-body">
		  <p>Are you sure to delete selected banner?</p>
		</div>
		<div class="modal-footer">
		  <button id="btn_remove" type="button" class="btn btn-danger" onclick="remove()"><i class="fa fa-trash" aria-hidden="true"></i> Remove</button>
		  <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
		</div>
	  </div>
	</div>
</div>

<script type="text/javascript">
	$('#btn_filter').on('click', function() {
		var url = 'index.php?route=design/advance_banner&token=<?php echo $token; ?>';

		var filter_name = $('#filter_name').val();

		if (filter_name) {
			url += '&filter_name=' + encodeURIComponent(filter_name);
		}

		
		var filter_status = $('#filter_status').val();

        if (filter_status) {
	        url += '&filter_status=' + encodeURIComponent(filter_status);
		}

		
		location.href = url
	});
</script>
<script src="https://cdn.ckeditor.com/ckeditor5/16.0.0/classic/ckeditor.js"></script>

<script type="text/javascript" src="view/javascript/jeditable/jquery.jeditable.js"></script>
<script type="text/javascript" src="view/javascript/jeditable/jquery.jeditable.datepicker.js"></script>

<?php echo $footer_new; ?>
<script>
 
	// inline select
	$(".editable-select").editable("<?php echo str_replace("&amp;","&",$edit) ;?>"  , {
		type: "select",
       
		// this data will be sorted by value
		data: function(value) {
			var id = $(this).attr("data-id")
	     	var selected ='';
		   if (value =="Enabled") {
				selected = 1
		 	} else {
		 	   selected = 0
			}
			return '{"1":"Enabled","0":"Disabled", "selected":"' + selected + '"}'
               
		},
		submitdata: function() {
			var id = $(this).attr("data-id")
			var selected_value = $(this).find($("option:selected")).val()
			var selected = $(this).find($("option:selected")).text()
			return {
				banner_id: id,
				value: selected_value,
				selected: selected,
				attr: "status"
			};

		},
	
		style: "inherit",
	});

	$(".editable-text").editable("<?php echo str_replace("&amp;","&",$edit) ;?>"  , {

		data: function(value) {
			var id = $(this).attr("data-id")
			
			return value
			
		},
		submitdata: function() {
			var id = $(this).attr("data-id")
			var value = $(this).find($("input:text")).val()

		
			return {
				banner_id: id,
				value: value,
				selected: value,
				attr: ""
			};

		},
	
		style: "inherit",
	});


	
   //remove
	function remove(){
		$('#btn_remove').attr('disabled',true)
		$('#btn_remove').html('<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span><span class="sr-only">Loading...</span>')

		$.ajax({
			url:'<?php echo $delete; ?>',
			type:'POST',
			data:$('tbody input[type="checkbox"]').serialize(),
			success:function(){
				location.reload()
			}
		})
	}

   
</script>
