var URL = location.protocol + '//' + location.host;

$(document).ready(function() {
    var orderId= window.location.pathname.split('/');
    console.log(orderId);
    var orderAPI = URL + "/app/getorder/" + orderId[3];
    console.log(orderId);
    

    $("#form-order").attr("action", "/app/updateorder/" + orderId[3]);
    $("#delete-button").attr("href", "/app/deleteorder/" + orderId[3]);

    $.getJSON(orderAPI).done(function(order) {
       $("#first-name-disabled").attr("placeholder", order["name"]);
       $("#last-name-disabled").attr("placeholder", order["address"]);
       $("#orderId-disabled").attr("placeholder", order["orderId"]);
       $("#order-items").html(order["items"]);


/*
       Sex of the order
*/
       // if (order["sex"] === true) {
       //     $("#order-sex-disabled").attr("placeholder", "Male");
       // } else if (order["sex"] === false) {
       //     $("#order-sex-disabled").attr("placeholder", "Female");
       // }

/*
      CustomItem of the order
*/
       if (order["customItem"] === "nocustomItem") {
           $("#order-customItem-disabled").attr("placeholder", 'No customItem assigned');
       } else {
           $("#order-customItem-disabled").attr("placeholder", 'CustomItem: ' + order["customItem"]);

           var orderDeleteCustomItemLink = "/app/updatecustomItem/" + orderId[3] + "/nocustomItem";
           $("#order-customItem-disabled").after("<a id=\"delete-customItem-button\" class=\"btn btn-primary btn-lg btn-block\" href=\"" + orderDeleteCustomItemLink +"\">Move to waiting list</a>");
       }

/*
       Items panel
*/
       if (order["items"] <=5) {
           $("#panel-items").attr("class", "panel panel-primary");
       } else if (order["items"] < 25) {
           $("#panel-items").attr("class", "panel panel-yellow");
       } else if (order["items"] <= 35) {
           $("#panel-items").attr("class", "panel panel-orange");
       } else {
           $("#panel-items").attr("class", "panel panel-red");
       }

       var itemsAPI = URL +"/app/getitems";
       $.getJSON(itemsAPI).done(function(allitems) {
           var itemsScoresCheckboxes = [];

           for(var item in allitems) {
             var itemscoreCheckbox = [];
        	   itemscoreCheckbox[0] = item;
        	   itemscoreCheckbox[1] = allitems[item]; // This is the items.

        	   var input;
               if (order["items"].length !== 0) {
                   for(var i = 0; i < order["items"].length; i++) {
            	   	   if(item === order["items"][i]) {
            	   	   	   input = "<input type=\"checkbox\" name=\"PD[]\" value=\"" + item + "\" checked>";
            	   	   	   break;
            	   	   } else {
            	   	        input = "<input type=\"checkbox\" name=\"PD[]\" value=\"" + item + "\">";
            	   	   }
            	   }
               } else {
                   input = "<input type=\"checkbox\" name=\"PD[]\" value=\"" + item + "\">";
               }

          	itemscoreCheckbox[2] = input;
        	     itemsScoresCheckboxes.push(itemscoreCheckbox)
           }

           // Add name, sex, number, age before the table.
           $('#diagnosis').dataTable({
		      data: itemsScoresCheckboxes,
		      columns:[{
	              title: "Item"
	           },{
	              title: "Items"
	           },{
	              title: "Diagnosis"
	           }],
		      scrollY: '40vh',
		      scrollCollapse: true,
		      paging: false,
                info: false,
                language: {
                sSearch: "Search item"
              }
		   });
       });
    });
});
