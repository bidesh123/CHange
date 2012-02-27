$("#basketItemsWrap li:first").hide();

$(".productPriceWrapRight a img").click(function() {
	var productIDValSplitter 	= (this.id).split("_");
	var productIDVal 			= productIDValSplitter[1];

	var productX 		= $("#productImageWrapID_" + productIDVal).offset().left;
	var productY 		= $("#productImageWrapID_" + productIDVal).offset().top;

	if( $("#productID_" + productIDVal).length > 0){
		var basketX 		= $("#productID_" + productIDVal).offset().left;
		var basketY 		= $("#productID_" + productIDVal).offset().top;
	} else {
		var basketX 		= $("#basketTitleWrap").offset().left;
		var basketY 		= $("#basketTitleWrap").offset().top;
	}

	var gotoX 			= basketX - productX;
	var gotoY 			= basketY - productY;

	var newImageWidth 	= $("#productImageWrapID_" + productIDVal).width() / 3;
	var newImageHeight	= $("#productImageWrapID_" + productIDVal).height() / 3;

	$("#productImageWrapID_" + productIDVal + " img")
	.clone()
	.prependTo("#productImageWrapID_" + productIDVal)
	.css({'position' : 'absolute'})
	.animate({opacity: 0.4}, 100 )
	.animate({opacity: 0.1, marginLeft: gotoX, marginTop: gotoY, width: newImageWidth, height: newImageHeight}, 1200, function() {
																																																																												$(this).remove();

		$("#notificationsLoader").html('<img src="images/loader.gif">');

		$.ajax({
		type: "POST",
		url: "inc/functions.php",
		data: { productID: productIDVal, action: "addToBasket"},
		success: function(theResponse) {

		if( $("#productID_" + productIDVal).length > 0){
			$("#productID_" + productIDVal).animate({ opacity: 0 }, 500);
			$("#productID_" + productIDVal).before(theResponse).remove();
			$("#productID_" + productIDVal).animate({ opacity: 0 }, 500);
			$("#productID_" + productIDVal).animate({ opacity: 1 }, 500);
			$("#notificationsLoader").empty();

		} else {
			$("#basketItemsWrap li:first").before(theResponse);
			$("#basketItemsWrap li:first").hide();
			$("#basketItemsWrap li:first").show("slow");
			$("#notificationsLoader").empty();
		}

		}
		});

	});

});