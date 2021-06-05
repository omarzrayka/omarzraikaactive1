
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
				
                <div class="form-group col-sm-3">
				<label for="name"><?php echo $entry_excel_file; ?></label>
			    <input type="file"  class="form-control" name="file" id="file" accept=".xls,.xlsx">
			    </div>

                <div class="form-group col-sm-3">
				<label for="file_nam">file Name</label>
				<input type="name" class="form-control form-control-sm" id="file_name" name="file_name" placeholder="Enter File Name" value="<?php //echo $file_name; ?>">
			    </div>


                <div class="form-group col-sm-3">
				<label for="file_date">Date</label>
				<input type="date" class="form-control form-control-sm" id="file_date" name="file_date" placeholder="Enter File date" value="<?php //echo $file_date; ?>">
			    </div>
           
            </form>  
        </div>

        <div class="card-footer text-muted">
		    <div style="float: right">
			    <button type="button" class="btn btn-primary btn-sm " onclick="save();">Submit</button>
			</div>
        </div>
      </div>
    </div>
    <br>
   
	<?php if (isset($products)) { ?>
    <div class="container-fluid ">
	   <div class="card text-left">
		<div class="card-header">
			<?php echo $heading_title; ?>
		</div>
        <div class="col-sm-12">
            <div class="row">     
			<table id="data_table" class="table table-sm table-bordered table-hover ">
                <thead>
                    <tr>
                      <td class="noEx1" width="1" style="text-align: center;"><input type="checkbox" onclick="$('input[name*=\'selected\']').attr('checked', this.checked);" /></td>
                      <td><?php echo $column_name; ?></td>
                      <td><?php echo $column_model; ?></td>
                      <td><?php echo $column_sku ;?></td>
                      <td><?php echo $column_quantity; ?></td>
                      <td><?php echo $column_price; ?></td>
                      <td class="right noEx1"><?php echo $column_action; ?></td>
                    </tr>
                </thead>
                   
                <tbody>   
                    <?php foreach ($products as $product) { ?>
                    <tr>
                      <td style="text-align: center;"> <input type="checkbox" name="selected[]" value="<?php echo $product['product_id']; ?>" /> </td>
                      <td class="right"><?php echo $product['name']; ?></td>
                      <td class="right"><?php echo $product['model']; ?></td>
                      <td class="left"><div class="editable-sku" data-id="<?php echo $product['product_id'];?>" ><?php echo $product['sku']; ?></div></td>
					  <td class="left"><?php echo $product['quantity']; ?></td>
                      <td class="left"><?php echo $product['price']; ?></td>
                      <td class="right"><?php foreach ($product['action'] as $action) { ?>
                      [ <a href="<?php echo $action['href']; ?>"><?php echo $action['text']; ?></a> ]
                    <?php } ?></td>
                    </tr>
                  <?php } ?>
                        
                      
                </tbody>
              </table>
			</div>   
        </div>
    </div>
  </div>
  <?php } ?>

<script type="text/javascript">
	function save(){
		var msg = '';
        if( $.trim($('#file_name').val()) == ''){
			msg = 'Please enter the name'
			$('#file_name').focus()
		}else  if($('#file_date').val() == ""){
			msg = 'Please select date'
			$('#file-date').focus()
		}else{
			$("#form").submit();
		}
		
		if($.trim(msg) != ''){
			$('<div class="alert alert-danger alert-dismissible fade show" role="alert"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i> '+msg+'<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button></div>')
		.insertBefore($('form'))
		}
	}
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
  alert("type_name:" + link_type);
      
      
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
			console.log('TableDnD Added');
			!function(e,t,n,r){var i="ontouchstart"in n.documentElement,s=i?"touchstart":"mousedown",o=i?"touchmove":"mousemove",u=i?"touchend":"mouseup";i&&e.each("touchstart touchmove touchend".split(" "),function(t,n){e.event.fixHooks[n]=e.event.mouseHooks});e(n).ready(function(){function t(e){var t={},n=e.match(/([^;:]+)/g)||[];while(n.length)t[n.shift()]=n.shift().trim();return t}e("table").each(function(){if(e(this).data("table")=="dnd"){e(this).tableDnD({onDragStyle:e(this).data("ondragstyle")&&t(e(this).data("ondragstyle"))||null,onDropStyle:e(this).data("ondropstyle")&&t(e(this).data("ondropstyle"))||null,onDragClass:e(this).data("ondragclass")==r&&"tDnD_whileDrag"||e(this).data("ondragclass"),onDrop:e(this).data("ondrop")&&new Function("table","row",e(this).data("ondrop")),onDragStart:e(this).data("ondragstart")&&new Function("table","row",e(this).data("ondragstart")),scrollAmount:e(this).data("scrollamount")||5,sensitivity:e(this).data("sensitivity")||10,hierarchyLevel:e(this).data("hierarchylevel")||0,indentArtifact:e(this).data("indentartifact")||'<div class="indent">&nbsp;</div>',autoWidthAdjust:e(this).data("autowidthadjust")||true,autoCleanRelations:e(this).data("autocleanrelations")||true,jsonPretifySeparator:e(this).data("jsonpretifyseparator")||"	",serializeRegexp:e(this).data("serializeregexp")&&new RegExp(e(this).data("serializeregexp"))||/[^\-]*$/,serializeParamName:e(this).data("serializeparamname")||false,dragHandle:e(this).data("draghandle")||null})}})});t.jQuery.tableDnD={currentTable:null,dragObject:null,mouseOffset:null,oldX:0,oldY:0,build:function(t){this.each(function(){this.tableDnDConfig=e.extend({onDragStyle:null,onDropStyle:null,onDragClass:"tDnD_whileDrag",onDrop:null,onDragStart:null,scrollAmount:5,sensitivity:10,hierarchyLevel:0,indentArtifact:'<div class="indent">&nbsp;</div>',autoWidthAdjust:true,autoCleanRelations:true,jsonPretifySeparator:"	",serializeRegexp:/[^\-]*$/,serializeParamName:false,dragHandle:null},t||{});e.tableDnD.makeDraggable(this);this.tableDnDConfig.hierarchyLevel&&e.tableDnD.makeIndented(this)});return this},makeIndented:function(t){var n=t.tableDnDConfig,r=t.rows,i=e(r).first().find("td:first")[0],s=0,o=0,u,a;if(e(t).hasClass("indtd"))return null;a=e(t).addClass("indtd").attr("style");e(t).css({whiteSpace:"nowrap"});for(var f=0;f<r.length;f++){if(o<e(r[f]).find("td:first").text().length){o=e(r[f]).find("td:first").text().length;u=f}}e(i).css({width:"auto"});for(f=0;f<n.hierarchyLevel;f++)e(r[u]).find("td:first").prepend(n.indentArtifact);i&&e(i).css({width:i.offsetWidth});a&&e(t).css(a);for(f=0;f<n.hierarchyLevel;f++)e(r[u]).find("td:first").children(":first").remove();n.hierarchyLevel&&e(r).each(function(){s=e(this).data("level")||0;s<=n.hierarchyLevel&&e(this).data("level",s)||e(this).data("level",0);for(var t=0;t<e(this).data("level");t++)e(this).find("td:first").prepend(n.indentArtifact)});return this},makeDraggable:function(t){var n=t.tableDnDConfig;n.dragHandle&&e(n.dragHandle,t).each(function(){e(this).bind(s,function(r){e.tableDnD.initialiseDrag(e(this).parents("tr")[0],t,this,r,n);return false})})||e(t.rows).each(function(){if(!e(this).hasClass("nodrag")){e(this).bind(s,function(r){if(r.target.tagName=="TD"){e.tableDnD.initialiseDrag(this,t,this,r,n);return false}}).css("cursor","move")}})},currentOrder:function(){var t=this.currentTable.rows;return e.map(t,function(t){return(e(t).data("level")+t.id).replace(/\s/g,"")}).join("")},initialiseDrag:function(t,r,i,s,a){this.dragObject=t;this.currentTable=r;this.mouseOffset=this.getMouseOffset(i,s);this.originalOrder=this.currentOrder();e(n).bind(o,this.mousemove).bind(u,this.mouseup);a.onDragStart&&a.onDragStart(r,i)},updateTables:function(){this.each(function(){if(this.tableDnDConfig)e.tableDnD.makeDraggable(this)})},mouseCoords:function(e){if(e.pageX||e.pageY)return{x:e.pageX,y:e.pageY};return{x:e.clientX+n.body.scrollLeft-n.body.clientLeft,y:e.clientY+n.body.scrollTop-n.body.clientTop}},getMouseOffset:function(e,n){var r,i;n=n||t.event;i=this.getPosition(e);r=this.mouseCoords(n);return{x:r.x-i.x,y:r.y-i.y}},getPosition:function(e){var t=0,n=0;if(e.offsetHeight==0)e=e.firstChild;while(e.offsetParent){t+=e.offsetLeft;n+=e.offsetTop;e=e.offsetParent}t+=e.offsetLeft;n+=e.offsetTop;return{x:t,y:n}},autoScroll:function(e){var r=this.currentTable.tableDnDConfig,i=t.pageYOffset,s=t.innerHeight?t.innerHeight:n.documentElement.clientHeight?n.documentElement.clientHeight:n.body.clientHeight;if(n.all)if(typeof n.compatMode!="undefined"&&n.compatMode!="BackCompat")i=n.documentElement.scrollTop;else if(typeof n.body!="undefined")i=n.body.scrollTop;e.y-i<r.scrollAmount&&t.scrollBy(0,-r.scrollAmount)||s-(e.y-i)<r.scrollAmount&&t.scrollBy(0,r.scrollAmount)},moveVerticle:function(e,t){if(0!=e.vertical&&t&&this.dragObject!=t&&this.dragObject.parentNode==t.parentNode)0>e.vertical&&this.dragObject.parentNode.insertBefore(this.dragObject,t.nextSibling)||0<e.vertical&&this.dragObject.parentNode.insertBefore(this.dragObject,t)},moveHorizontal:function(t,n){var r=this.currentTable.tableDnDConfig,i;if(!r.hierarchyLevel||0==t.horizontal||!n||this.dragObject!=n)return null;i=e(n).data("level");0<t.horizontal&&i>0&&e(n).find("td:first").children(":first").remove()&&e(n).data("level",--i);0>t.horizontal&&i<r.hierarchyLevel&&e(n).prev().data("level")>=i&&e(n).children(":first").prepend(r.indentArtifact)&&e(n).data("level",++i)},mousemove:function(t){var n=e(e.tableDnD.dragObject),r=e.tableDnD.currentTable.tableDnDConfig,i,s,o,u,a;t&&t.preventDefault();if(!e.tableDnD.dragObject)return false;t.type=="touchmove"&&event.preventDefault();r.onDragClass&&n.addClass(r.onDragClass)||n.css(r.onDragStyle);s=e.tableDnD.mouseCoords(t);u=s.x-e.tableDnD.mouseOffset.x;a=s.y-e.tableDnD.mouseOffset.y;e.tableDnD.autoScroll(s);i=e.tableDnD.findDropTargetRow(n,a);o=e.tableDnD.findDragDirection(u,a);e.tableDnD.moveVerticle(o,i);e.tableDnD.moveHorizontal(o,i);return false},findDragDirection:function(e,t){var n=this.currentTable.tableDnDConfig.sensitivity,r=this.oldX,i=this.oldY,s=r-n,o=r+n,u=i-n,a=i+n,f={horizontal:e>=s&&e<=o?0:e>r?-1:1,vertical:t>=u&&t<=a?0:t>i?-1:1};if(f.horizontal!=0)this.oldX=e;if(f.vertical!=0)this.oldY=t;return f},findDropTargetRow:function(t,n){var r=0,i=this.currentTable.rows,s=this.currentTable.tableDnDConfig,o=0,u=null;for(var a=0;a<i.length;a++){u=i[a];o=this.getPosition(u).y;r=parseInt(u.offsetHeight)/2;if(u.offsetHeight==0){o=this.getPosition(u.firstChild).y;r=parseInt(u.firstChild.offsetHeight)/2}if(n>o-r&&n<o+r)if(t.is(u)||s.onAllowDrop&&!s.onAllowDrop(t,u)||e(u).hasClass("nodrop"))return null;else return u}return null},processMouseup:function(){var t=this.currentTable.tableDnDConfig,r=this.dragObject,i=0,s=0;if(!this.currentTable||!r)return null;e(n).unbind(o,this.mousemove).unbind(u,this.mouseup);t.hierarchyLevel&&t.autoCleanRelations&&e(this.currentTable.rows).first().find("td:first").children().each(function(){s=e(this).parents("tr:first").data("level");s&&e(this).parents("tr:first").data("level",--s)&&e(this).remove()})&&t.hierarchyLevel>1&&e(this.currentTable.rows).each(function(){s=e(this).data("level");if(s>1){i=e(this).prev().data("level");while(s>i+1){e(this).find("td:first").children(":first").remove();e(this).data("level",--s)}}});t.onDragClass&&e(r).removeClass(t.onDragClass)||e(r).css(t.onDropStyle);this.dragObject=null;t.onDrop&&this.originalOrder!=this.currentOrder()&&e(r).hide().fadeIn("fast")&&t.onDrop(this.currentTable,r);this.currentTable=null},mouseup:function(t){t&&t.preventDefault();e.tableDnD.processMouseup();return false},jsonize:function(e){var t=this.currentTable;if(e)return JSON.stringify(this.tableData(t),null,t.tableDnDConfig.jsonPretifySeparator);return JSON.stringify(this.tableData(t))},serialize:function(){return e.param(this.tableData(this.currentTable))},serializeTable:function(e){var t="";var n=e.tableDnDConfig.serializeParamName||e.id;var r=e.rows;for(var i=0;i<r.length;i++){if(t.length>0)t+="&";var s=r[i].id;if(s&&e.tableDnDConfig&&e.tableDnDConfig.serializeRegexp){s=s.match(e.tableDnDConfig.serializeRegexp)[0];t+=n+"[]="+s}}return t},serializeTables:function(){var t=[];e("table").each(function(){this.id&&t.push(e.param(this.tableData(this)))});return t.join("&")},tableData:function(t){var n=t.tableDnDConfig,r=[],i=0,s=0,o=null,u={},a,f,l,c;if(!t)t=this.currentTable;if(!t||!t.id||!t.rows||!t.rows.length)return{error:{code:500,message:"Not a valid table, no serializable unique id provided."}};c=n.autoCleanRelations&&t.rows||e.makeArray(t.rows);f=n.serializeParamName||t.id;l=f;a=function(e){if(e&&n&&n.serializeRegexp)return e.match(n.serializeRegexp)[0];return e};u[l]=[];!n.autoCleanRelations&&e(c[0]).data("level")&&c.unshift({id:"undefined"});for(var h=0;h<c.length;h++){if(n.hierarchyLevel){s=e(c[h]).data("level")||0;if(s==0){l=f;r=[]}else if(s>i){r.push([l,i]);l=a(c[h-1].id)}else if(s<i){for(var p=0;p<r.length;p++){if(r[p][1]==s)l=r[p][0];if(r[p][1]>=i)r[p][1]=0}}i=s;if(!e.isArray(u[l]))u[l]=[];o=a(c[h].id);o&&u[l].push(o)}else{o=a(c[h].id);o&&u[l].push(o)}}return u}};t.jQuery.fn.extend({tableDnD:e.tableDnD.build,tableDnDUpdate:e.tableDnD.updateTables,tableDnDSerialize:e.proxy(e.tableDnD.serialize,e.tableDnD),tableDnDSerializeAll:e.tableDnD.serializeTables,tableDnDData:e.proxy(e.tableDnD.tableData,e.tableDnD)})}(window.jQuery,window,window.document);
			}
			}catch(err){
			  console.log('Already Design TableDND');
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
<script>
$("#file").on("change", function() {
  var file = $(this).val().split("\\").pop();
  var index = file.lastIndexOf(".");
  var fileName = file.substring(0,index);
  $(this).siblings("#file_name").addClass("selected").html(fileName);
  document.getElementById("file_name").value = fileName;
});
</script>


<script src="https://cdn.ckeditor.com/ckeditor5/16.0.0/classic/ckeditor.js"></script>

<script type="text/javascript" src="view/javascript/jeditable/jquery.jeditable.js"></script>
<script type="text/javascript" src="view/javascript/jeditable/jquery.jeditable.datepicker.js"></script>

<script>
$(".editable-sku").editable("<?php echo str_replace("&amp;","&",$edit) ;?>" ,{
data: function(value) {
	var id = $(this).attr("data-id")
	return value
	
},
submitdata: function() {
	var id = $(this).attr("data-id")
	var value = $(this).find($("input:text")).val()


	return {
		product_id: id,
		sku: value,
		selected: value,
		attr: ""
	};

},

style: "inherit",
});

</script>

<?php echo $footer_new; ?>
