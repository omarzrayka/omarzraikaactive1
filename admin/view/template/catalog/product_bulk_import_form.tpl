<?php echo $header; ?>
<div id="content">
    <?php if ($success) { ?>
        <div class="warning"><?php echo $success; ?></div>
        <?php } ?>
    <div class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>">
            <?php echo $breadcrumb['text']; ?>
        </a>
        <?php } ?>
    </div>
    <div class="box">
        <div class="heading">
            <h1><img src="view/image/product.png" alt="" />
                <?php echo $heading_title; ?>
            </h1>
            <div class="buttons"><a onclick="$('#form').submit();" class="button">
                    <?php echo $button_save; ?>
                </a><a onclick="location = '<?php echo $cancel; ?>';" class="button">
                    <?php echo $button_cancel; ?>
                </a></div>
        </div>
        <div class="content">
         
            <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
                <div id="tab-general">
                    <div id="languages" class="htabs">
                        <?php foreach ($languages as $language) { ?>
                            <a href="#language<?php echo $language['language_id']; ?>"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a>

                        <?php } ?>
                    </div>
                </div>
                <label>Choose Excel
                    File</label> <input type="file" name="file" id="file" accept=".xls,.xlsx">
            </form>
        </div>
    </div>
    </form>
</div>
</div>
</div>