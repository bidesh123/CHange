$j(document).ready(function(){

	$j("#basketItemsWrap li:first").hide();

	$j(".productPriceWrapRight a img").click(function() {
		var productIDValSplitter 	= (this.id).split("_");
		var productIDVal 			= productIDValSplitter[1];

		var productX 		= $j("#productImageWrapID_" + productIDVal).offset().left;
		var productY 		= $j("#productImageWrapID_" + productIDVal).offset().top;

		if( $j("#productID_" + productIDVal).length > 0){
			var basketX 		= $j("#productID_" + productIDVal).offset().left;
			var basketY 		= $j("#productID_" + productIDVal).offset().top;
		} else {
			var basketX 		= $j("#basketTitleWrap").offset().left;
			var basketY 		= $j("#basketTitleWrap").offset().top;
		}

		var gotoX 			= basketX - productX;
		var gotoY 			= basketY - productY;

		var newImageWidth 	= $j("#productImageWrapID_" + productIDVal).width() / 3;
		var newImageHeight	= $j("#productImageWrapID_" + productIDVal).height() / 3;

		$j("#productImageWrapID_" + productIDVal + " img")
		.clone()
		.prependTo("#productImageWrapID_" + productIDVal)
		.css({'position' : 'absolute'})
		.animate({opacity: 0.4}, 100 )
		.animate({opacity: 0.1, marginLeft: gotoX, marginTop: gotoY, width: newImageWidth, height: newImageHeight}, 1200, function() {
																																																																										  			$(this).remove();

			$j("#notificationsLoader").html('<img src="/images/loader.gif">');

			$j.ajax({
				type: "POST",
				url: "/carts/add_to_cart",
				data: { productID: productIDVal, action: "addToBasket"},
				success: function(theResponse) {

					if( $j("#productID_" + productIDVal).length > 0){
						$j("#productID_" + productIDVal).animate({ opacity: 0 }, 500);
						$j("#productID_" + productIDVal).before(theResponse).remove();
						$j("#productID_" + productIDVal).animate({ opacity: 0 }, 500);
						$j("#productID_" + productIDVal).animate({ opacity: 1 }, 500);
						$j("#notificationsLoader").empty();

					} else {
						$j("#basketItemsWrap li:first").before(theResponse);
						$j("#basketItemsWrap li:first").hide();
						$j("#basketItemsWrap li:first").show("slow");
						$j("#notificationsLoader").empty();
					}

				}
			});

		});

	});



	$j("#basketItemsWrap li img").live("click", function(event) {
		var productIDValSplitter 	= (this.id).split("_");
		var productIDVal 			= productIDValSplitter[1];

		$j("#notificationsLoader").html('<img src="images/loader.gif">');

		$j.ajax({
			type: "POST",
			url: "/carts/add_to_cart",
			data: { productID: productIDVal, action: "deleteFromBasket"},
			success: function(theResponse) {

				$j("#productID_" + productIDVal).hide("slow",  function() {$(this).remove();});
				$j("#notificationsLoader").empty();

			}
		});

	});

});
