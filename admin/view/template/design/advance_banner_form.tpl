
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
			<form method="POST" action="<?php echo $action; ?>" enctype="multipart/form-data" class="row" id="form">
				
				<div class="form-group col-sm-2">
				  <label for="name"><?php echo $entry_name; ?></label>
				  <input type="text" class="form-control form-control-sm" id="name" name="name" placeholder="Enter Banner Name" value="<?php echo $name; ?>"">
				</div>
				<div class="form-group col-sm-2">
				  <label for="status"><?php echo $entry_status; ?></label>
				  <select class="form-control form-control-sm" id="status" name="status">
						<option value="0" <?php if($status == '0'){ ?> selected="selected" <?php } ?> ><?php echo $text_disabled; ?></option>
						<option value="1" <?php if($status == '1'){ ?> selected="selected" <?php } ?> ><?php echo $text_enabled; ?></option>
				  </select>
				</div>
                <div class="col-sm-12">
                   <div class="row">     
           <table id="images" class="table table-hover">
            <thead>
            <tr>
              <td class="left"><?php echo $entry_title; ?></td>
              <td class="left"><?php echo $entry_link; ?></td>

              <td class="left"><?php echo $entry_image; ?></td>
              
              <td class="left">Mobile App Type</td>
              <td class="left">Mobile Type Id</td>
              
              <td></td>
            </tr>
           </thead>
           <tbody>
            <?php $image_row = 0; ?>
            <?php foreach ($banner_images as $banner_image) { ?>
            <tr id="image-row<?php echo $image_row; ?>">
              <td class="left"><?php foreach ($languages as $language) { ?>
                <input  type="text" class="form-control" name="banner_image[<?php echo $image_row; ?>][banner_image_description][<?php echo $language['language_id']; ?>][title]" value="<?php echo isset($banner_image['banner_image_description'][$language['language_id']]) ? $banner_image['banner_image_description'][$language['language_id']]['title'] : ''; ?>" />
                <img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /><br />
                <?php if (isset($error_banner_image[$image_row][$language['language_id']])) { ?>
                <span class="error"><?php echo $error_banner_image[$image_row][$language['language_id']]; ?></span>
                <?php } ?>
                <?php } ?></td>
                
              




              <td class="left"><input type="text" class="form-control" name="banner_image[<?php echo $image_row; ?>][link]" value="<?php echo $banner_image['link']; ?>" /></td>
              <td class="left">
				  <a id="thumb-image" class="button-image">
					  <img src="<?php echo $banner_image['thumb']; ?>" alt="" id="product_image<?php echo $image_row; ?>"  data-attr="product-img">
					  <input type="hidden" class="product_image_input" name="banner_image[<?php echo $image_row; ?>][image]" value="<?php echo $banner_image['image']; ?>" id="input-image<?php echo $image_row; ?>"  />
			      </a>
				  
				</td>
              
               <td class="left"><select name="banner_image[<?php echo $image_row; ?>][mobile_type]"  class="form-control">
				<option value="1" <?php if($banner_image['mobile_type']=='1'){ echo 'selected';} ?>> Product id </option>
				<option value="2" <?php if($banner_image['mobile_type']=='2'){ echo 'selected';} ?>> Category id </option>
				<option value="3" <?php if($banner_image['mobile_type']=='3'){ echo 'selected';} ?>> Manufacturer id </option>
				<option value="4" <?php if($banner_image['mobile_type']=='4'){ echo 'selected';} ?>> Seller id </option>
				<option value="5" <?php if($banner_image['mobile_type']=='5'){ echo 'selected';} ?>> Search keyword</option>
				<option value="6" <?php if($banner_image['mobile_type']=='6'){ echo 'selected';} ?>> New Arrivals</option>
				<option value="7" <?php if($banner_image['mobile_type']=='7'){ echo 'selected';} ?>> Special Deals</option>
				</select></td>
				
				<td class="left">

				
				<input type="text" 
				name="banner_image[<?php echo $image_row; ?>][name]"  
				item="banner_image[<?php echo $image_row; ?>][mobile_type]"
			    itemid="banner_image[<?php echo $image_row; ?>][mobile_type_id]"
				class="product_category form-control" 
				value="<?php echo $banner_image['name']; ?>">
				<input type="hidden" name="banner_image[<?php echo $image_row; ?>][mobile_type_id]"  value="<?php echo $banner_image['mobile_type_id']; ?>">
				</td>


				 <td class="left"><button onclick="$('#image-row<?php echo $image_row; ?>').remove();" class="btn btn-primary btn-sm"><?php echo $button_remove; ?></button></td>
				 
            </tr>
            <?php $image_row++; ?>
				    <?php } ?>
          </tbody>
    
          <tfoot>
            <tr>
              <td colspan="5"></td>
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
	   
        if( $.trim($('#name').val()) == ''){
			msg = 'Please enter the name'
			$('#name').focus()
		}else  if($('#status').val() == "-1"){
			msg = 'Please select status'
			$('#status').focus()
		}else{
			$("#form").submit();
		}
		
		if($.trim(msg) != ''){
			$('<div class="alert alert-danger alert-dismissible fade show" role="alert"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i> '+msg+'<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button></div>')
		.insertBefore($('form'))
		}
	}
</script>
<script type="text/javascript"><!--
var image_row = <?php echo $image_row; ?>;

function addImage() {
  html = '<tr id="image-row' + image_row + '">';
	html += '<tr>';
    html += '<td class="left">';
	<?php foreach ($languages as $language) { ?>
	html += '<input type="text" class="form-control" name="banner_image[' + image_row + '][banner_image_description][<?php echo $language['language_id']; ?>][title]" value="" /> <img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /><br />';
    <?php } ?>
	html += '</td>';	
	html += '<td class="left"><input type="text" class="form-control" name="banner_image[' + image_row + '][link]" value="" /></td>';	
	
	  
  
	html += '<td class="left"><div class="image"><img src="<?php echo $no_image; ?>" alt="" id="thumb' + image_row + '" /><input type="hidden" name="banner_image[' + image_row + '][image]" value="" id="image' + image_row + '" /><br /><a onclick="image_upload(\'image' + image_row + '\', \'thumb' + image_row + '\');"><?php echo $text_browse; ?></a>&nbsp;&nbsp;|&nbsp;&nbsp;<a onclick="$(\'#thumb' + image_row + '\').attr(\'src\', \'<?php echo $no_image; ?>\'); $(\'#image' + image_row + '\').attr(\'value\', \'\');"><?php echo $text_clear; ?></a></div></td>';

	
	html += '   <td class="left"> <select name="banner_image[' + image_row + '][mobile_type]" class="form-control"> ';
	html += '   <option value="1">  Product id </option> ';
	html += '   <option value="2">  Category id </option>';
	html += '   <option value="3">  Manufacturer id </option>';
    html += '   <option value="4">  Seller id </option>';
    html += '   <option value="5">  Search key </option>';
    html += '   <option value="6">  New Arrivals </option>';
    html += '   <option value="7">  Special Deals </option>';
	html += '   </select></td>';
	
	html += ' <td class="left"><input type="text" name="banner_image[' + image_row + '][name]" placeholder="Sku, Category, Seller .." class="product_category form-control" item="banner_image[' + image_row + '][mobile_type]" itemid="banner_image[' + image_row + '][mobile_type_id]" /><input type="hidden" name="banner_image[' + image_row + '][mobile_type_id]" value=""></td>';  
	
	
	
		
	
  // html += '<td><div class="image"><img src="" alt="" id="thumb' + image_row + '"  /><br /> <input type="hidden" name="banner_image[' + image_row + '][image]" value="" id="input-image' + image_row + ' "/> <a onclick="image_upload(\'image' + image_row + '\', \'thumb' + image_row + '\');">a</a></div></td>';

	html += '<td class="left"><button onclick="$(\'#image-row' + image_row  + '\').remove();" class="btn btn-primary btn-sm"><?php echo $button_remove; ?></button></td>';

	html += '</tr>';

	
  $('#images tbody').append(html);
	
	image_row++;
}
//--></script>
<script type="text/javascript"><!--
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
					success: function(data) {
						$('#' + thumb).replaceWith('<img src="' + data + '" alt="" id="' + thumb + '" />');
					}
				});
			}
		},	
		bgiframe: false,
		width: 700,
		height: 400,
		resizable: false,
		modal: false
	});
};
//--></script> 


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

</script>

<style type="text/css">
			.myDragClass td, .myDragClass td:hover{
				background: #39363C !important;
				color: #FFFFFF !important;
			}
</style>

	<script type="text/javascript">
			try{
			if(typeof(tableDnD)=='undefined'){
			// console.log('TableDnD Added');
			!function(e,t,n,r){var i="ontouchstart"in n.documentElement,s=i?"touchstart":"mousedown",o=i?"touchmove":"mousemove",u=i?"touchend":"mouseup";i&&e.each("touchstart touchmove touchend".split(" "),function(t,n){e.event.fixHooks[n]=e.event.mouseHooks});e(n).ready(function(){function t(e){var t={},n=e.match(/([^;:]+)/g)||[];while(n.length)t[n.shift()]=n.shift().trim();return t}e("table").each(function(){if(e(this).data("table")=="dnd"){e(this).tableDnD({onDragStyle:e(this).data("ondragstyle")&&t(e(this).data("ondragstyle"))||null,onDropStyle:e(this).data("ondropstyle")&&t(e(this).data("ondropstyle"))||null,onDragClass:e(this).data("ondragclass")==r&&"tDnD_whileDrag"||e(this).data("ondragclass"),onDrop:e(this).data("ondrop")&&new Function("table","row",e(this).data("ondrop")),onDragStart:e(this).data("ondragstart")&&new Function("table","row",e(this).data("ondragstart")),scrollAmount:e(this).data("scrollamount")||5,sensitivity:e(this).data("sensitivity")||10,hierarchyLevel:e(this).data("hierarchylevel")||0,indentArtifact:e(this).data("indentartifact")||'<div class="indent">&nbsp;</div>',autoWidthAdjust:e(this).data("autowidthadjust")||true,autoCleanRelations:e(this).data("autocleanrelations")||true,jsonPretifySeparator:e(this).data("jsonpretifyseparator")||"	",serializeRegexp:e(this).data("serializeregexp")&&new RegExp(e(this).data("serializeregexp"))||/[^\-]*$/,serializeParamName:e(this).data("serializeparamname")||false,dragHandle:e(this).data("draghandle")||null})}})});t.jQuery.tableDnD={currentTable:null,dragObject:null,mouseOffset:null,oldX:0,oldY:0,build:function(t){this.each(function(){this.tableDnDConfig=e.extend({onDragStyle:null,onDropStyle:null,onDragClass:"tDnD_whileDrag",onDrop:null,onDragStart:null,scrollAmount:5,sensitivity:10,hierarchyLevel:0,indentArtifact:'<div class="indent">&nbsp;</div>',autoWidthAdjust:true,autoCleanRelations:true,jsonPretifySeparator:"	",serializeRegexp:/[^\-]*$/,serializeParamName:false,dragHandle:null},t||{});e.tableDnD.makeDraggable(this);this.tableDnDConfig.hierarchyLevel&&e.tableDnD.makeIndented(this)});return this},makeIndented:function(t){var n=t.tableDnDConfig,r=t.rows,i=e(r).first().find("td:first")[0],s=0,o=0,u,a;if(e(t).hasClass("indtd"))return null;a=e(t).addClass("indtd").attr("style");e(t).css({whiteSpace:"nowrap"});for(var f=0;f<r.length;f++){if(o<e(r[f]).find("td:first").text().length){o=e(r[f]).find("td:first").text().length;u=f}}e(i).css({width:"auto"});for(f=0;f<n.hierarchyLevel;f++)e(r[u]).find("td:first").prepend(n.indentArtifact);i&&e(i).css({width:i.offsetWidth});a&&e(t).css(a);for(f=0;f<n.hierarchyLevel;f++)e(r[u]).find("td:first").children(":first").remove();n.hierarchyLevel&&e(r).each(function(){s=e(this).data("level")||0;s<=n.hierarchyLevel&&e(this).data("level",s)||e(this).data("level",0);for(var t=0;t<e(this).data("level");t++)e(this).find("td:first").prepend(n.indentArtifact)});return this},makeDraggable:function(t){var n=t.tableDnDConfig;n.dragHandle&&e(n.dragHandle,t).each(function(){e(this).bind(s,function(r){e.tableDnD.initialiseDrag(e(this).parents("tr")[0],t,this,r,n);return false})})||e(t.rows).each(function(){if(!e(this).hasClass("nodrag")){e(this).bind(s,function(r){if(r.target.tagName=="TD"){e.tableDnD.initialiseDrag(this,t,this,r,n);return false}}).css("cursor","move")}})},currentOrder:function(){var t=this.currentTable.rows;return e.map(t,function(t){return(e(t).data("level")+t.id).replace(/\s/g,"")}).join("")},initialiseDrag:function(t,r,i,s,a){this.dragObject=t;this.currentTable=r;this.mouseOffset=this.getMouseOffset(i,s);this.originalOrder=this.currentOrder();e(n).bind(o,this.mousemove).bind(u,this.mouseup);a.onDragStart&&a.onDragStart(r,i)},updateTables:function(){this.each(function(){if(this.tableDnDConfig)e.tableDnD.makeDraggable(this)})},mouseCoords:function(e){if(e.pageX||e.pageY)return{x:e.pageX,y:e.pageY};return{x:e.clientX+n.body.scrollLeft-n.body.clientLeft,y:e.clientY+n.body.scrollTop-n.body.clientTop}},getMouseOffset:function(e,n){var r,i;n=n||t.event;i=this.getPosition(e);r=this.mouseCoords(n);return{x:r.x-i.x,y:r.y-i.y}},getPosition:function(e){var t=0,n=0;if(e.offsetHeight==0)e=e.firstChild;while(e.offsetParent){t+=e.offsetLeft;n+=e.offsetTop;e=e.offsetParent}t+=e.offsetLeft;n+=e.offsetTop;return{x:t,y:n}},autoScroll:function(e){var r=this.currentTable.tableDnDConfig,i=t.pageYOffset,s=t.innerHeight?t.innerHeight:n.documentElement.clientHeight?n.documentElement.clientHeight:n.body.clientHeight;if(n.all)if(typeof n.compatMode!="undefined"&&n.compatMode!="BackCompat")i=n.documentElement.scrollTop;else if(typeof n.body!="undefined")i=n.body.scrollTop;e.y-i<r.scrollAmount&&t.scrollBy(0,-r.scrollAmount)||s-(e.y-i)<r.scrollAmount&&t.scrollBy(0,r.scrollAmount)},moveVerticle:function(e,t){if(0!=e.vertical&&t&&this.dragObject!=t&&this.dragObject.parentNode==t.parentNode)0>e.vertical&&this.dragObject.parentNode.insertBefore(this.dragObject,t.nextSibling)||0<e.vertical&&this.dragObject.parentNode.insertBefore(this.dragObject,t)},moveHorizontal:function(t,n){var r=this.currentTable.tableDnDConfig,i;if(!r.hierarchyLevel||0==t.horizontal||!n||this.dragObject!=n)return null;i=e(n).data("level");0<t.horizontal&&i>0&&e(n).find("td:first").children(":first").remove()&&e(n).data("level",--i);0>t.horizontal&&i<r.hierarchyLevel&&e(n).prev().data("level")>=i&&e(n).children(":first").prepend(r.indentArtifact)&&e(n).data("level",++i)},mousemove:function(t){var n=e(e.tableDnD.dragObject),r=e.tableDnD.currentTable.tableDnDConfig,i,s,o,u,a;t&&t.preventDefault();if(!e.tableDnD.dragObject)return false;t.type=="touchmove"&&event.preventDefault();r.onDragClass&&n.addClass(r.onDragClass)||n.css(r.onDragStyle);s=e.tableDnD.mouseCoords(t);u=s.x-e.tableDnD.mouseOffset.x;a=s.y-e.tableDnD.mouseOffset.y;e.tableDnD.autoScroll(s);i=e.tableDnD.findDropTargetRow(n,a);o=e.tableDnD.findDragDirection(u,a);e.tableDnD.moveVerticle(o,i);e.tableDnD.moveHorizontal(o,i);return false},findDragDirection:function(e,t){var n=this.currentTable.tableDnDConfig.sensitivity,r=this.oldX,i=this.oldY,s=r-n,o=r+n,u=i-n,a=i+n,f={horizontal:e>=s&&e<=o?0:e>r?-1:1,vertical:t>=u&&t<=a?0:t>i?-1:1};if(f.horizontal!=0)this.oldX=e;if(f.vertical!=0)this.oldY=t;return f},findDropTargetRow:function(t,n){var r=0,i=this.currentTable.rows,s=this.currentTable.tableDnDConfig,o=0,u=null;for(var a=0;a<i.length;a++){u=i[a];o=this.getPosition(u).y;r=parseInt(u.offsetHeight)/2;if(u.offsetHeight==0){o=this.getPosition(u.firstChild).y;r=parseInt(u.firstChild.offsetHeight)/2}if(n>o-r&&n<o+r)if(t.is(u)||s.onAllowDrop&&!s.onAllowDrop(t,u)||e(u).hasClass("nodrop"))return null;else return u}return null},processMouseup:function(){var t=this.currentTable.tableDnDConfig,r=this.dragObject,i=0,s=0;if(!this.currentTable||!r)return null;e(n).unbind(o,this.mousemove).unbind(u,this.mouseup);t.hierarchyLevel&&t.autoCleanRelations&&e(this.currentTable.rows).first().find("td:first").children().each(function(){s=e(this).parents("tr:first").data("level");s&&e(this).parents("tr:first").data("level",--s)&&e(this).remove()})&&t.hierarchyLevel>1&&e(this.currentTable.rows).each(function(){s=e(this).data("level");if(s>1){i=e(this).prev().data("level");while(s>i+1){e(this).find("td:first").children(":first").remove();e(this).data("level",--s)}}});t.onDragClass&&e(r).removeClass(t.onDragClass)||e(r).css(t.onDropStyle);this.dragObject=null;t.onDrop&&this.originalOrder!=this.currentOrder()&&e(r).hide().fadeIn("fast")&&t.onDrop(this.currentTable,r);this.currentTable=null},mouseup:function(t){t&&t.preventDefault();e.tableDnD.processMouseup();return false},jsonize:function(e){var t=this.currentTable;if(e)return JSON.stringify(this.tableData(t),null,t.tableDnDConfig.jsonPretifySeparator);return JSON.stringify(this.tableData(t))},serialize:function(){return e.param(this.tableData(this.currentTable))},serializeTable:function(e){var t="";var n=e.tableDnDConfig.serializeParamName||e.id;var r=e.rows;for(var i=0;i<r.length;i++){if(t.length>0)t+="&";var s=r[i].id;if(s&&e.tableDnDConfig&&e.tableDnDConfig.serializeRegexp){s=s.match(e.tableDnDConfig.serializeRegexp)[0];t+=n+"[]="+s}}return t},serializeTables:function(){var t=[];e("table").each(function(){this.id&&t.push(e.param(this.tableData(this)))});return t.join("&")},tableData:function(t){var n=t.tableDnDConfig,r=[],i=0,s=0,o=null,u={},a,f,l,c;if(!t)t=this.currentTable;if(!t||!t.id||!t.rows||!t.rows.length)return{error:{code:500,message:"Not a valid table, no serializable unique id provided."}};c=n.autoCleanRelations&&t.rows||e.makeArray(t.rows);f=n.serializeParamName||t.id;l=f;a=function(e){if(e&&n&&n.serializeRegexp)return e.match(n.serializeRegexp)[0];return e};u[l]=[];!n.autoCleanRelations&&e(c[0]).data("level")&&c.unshift({id:"undefined"});for(var h=0;h<c.length;h++){if(n.hierarchyLevel){s=e(c[h]).data("level")||0;if(s==0){l=f;r=[]}else if(s>i){r.push([l,i]);l=a(c[h-1].id)}else if(s<i){for(var p=0;p<r.length;p++){if(r[p][1]==s)l=r[p][0];if(r[p][1]>=i)r[p][1]=0}}i=s;if(!e.isArray(u[l]))u[l]=[];o=a(c[h].id);o&&u[l].push(o)}else{o=a(c[h].id);o&&u[l].push(o)}}return u}};t.jQuery.fn.extend({tableDnD:e.tableDnD.build,tableDnDUpdate:e.tableDnD.updateTables,tableDnDSerialize:e.proxy(e.tableDnD.serialize,e.tableDnD),tableDnDSerializeAll:e.tableDnD.serializeTables,tableDnDData:e.proxy(e.tableDnD.tableData,e.tableDnD)})}(window.jQuery,window,window.document);
			}
			}catch(err){
			//   console.log('Already Design TableDND');
			}
			$( document ).ready(function() {
				$("#images").tableDnD({
					onDragClass: "myDragClass",
					onDrop: function(table, row) {

					},
					onDragStart: function(table, row) {
						/* $('#debugArea').html("Started dragging row "+row.id); */
					}
				});
			});

	</script>

			<!--file manager-->
<script type="text/javascript" src="view/javascript/common/common.js"></script>
<script type="text/javascript">	
    $(document).ready(function() {
        // Image Manager
            $('body').on('click','.button-image', function() {
                $element = $('.button-image').parent();
                var $button = $(this);
                var $icon   = $button.find('> i');
                var target = $(this).children('input')
                var img = $(this).children('img')
           

                var loader = '<div class="spinner-border img-loader" role="status"><span class="sr-only">Loading...</span></div>';

                $(this).append(loader)
                target.hide()
                img.hide()
                $('#modal-image').remove();
    
                $.ajax({
                    url: 'index.php?route=common/filemanager_bootstrap&token=<?php echo $token; ?>&target=' + target.attr('id') + '&thumb=' + img.attr('id') + '&directory='+currenct_dir + '&page='+file_manager_page,
                    dataType: 'html',
                    success: function(html) {
                        $('body').append('<div id="modal-image" class="modal">' + html + '</div>');
                        target.show()
                        img.show()
                        $('.img-loader').remove()
                        $('#modal-image').modal({'show' : true});
                       // jQuery('#modal-image').modal('show');
                    }
                });                  
            });
    
            $('#button-clear').on('click', function() {
                $element = $('#parent_image');
                $element.children('img').attr('src', $element.children('img').attr('data-placeholder'));    
                $element.children('input').val('');   
            });
        });
    
</script>
