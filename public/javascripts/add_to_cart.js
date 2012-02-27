var image_add='/images/addtocart.gif';
var image_rem='/images/addtocart2.gif';
function addcart(id)
{

	obj=document.getElementById("addtocart_"+id);
	//obj_check=document.getElementById("addtocartcheck_"+id);


		if (obj!=null) {
				document.getElementById("floatdiv").show();
				obj.src=image_rem;obj.lang=0;
				addToBasket(id);
				document.getElementById("Checkout1").style.display="";
				document.getElementById("Checkout2").style.display="";

		}
		else{
			removeProductFromBasket(id);
			if (obj) {obj.src=image_add;obj.lang=1;}
		}




}

