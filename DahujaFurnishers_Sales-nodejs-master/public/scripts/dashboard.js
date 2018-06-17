var URL = location.protocol + '//' + location.host;

var ordersWaitingTableConstructor = [];
var ordersInHospitalTableConstructor = [];
var freecustomItemsTableConstructor = [];
var dynamicTableClickable = true;

$(document).ready(function() {
  var ordersAPI = URL + "/app/getorders";
  $.getJSON(ordersAPI).done(function(orders) {
	  var customItemsAPI = URL + "/app/getcustomItems";
	  $.getJSON(customItemsAPI).done(function(customItems1) {

          // iterate through all customItems
	  	  for(var customItem in customItems1) {
		  	  var freecustomItemsRowConstructor = [];

              if (customItem !== 'nocustomItem' && customItems1[customItem] === false) {
		  	  	  freecustomItemsRowConstructor.push(customItem);
		  	  	  freecustomItemsTableConstructor.push(freecustomItemsRowConstructor);
		  	  }
		  }

		  for(var i = 0; i < orders.length; i++) {
			  var order = orders[i];

			  var ordersRowConstructor = [];
			  ordersRowConstructor.push(order["_id"]);
        ordersRowConstructor.push(order["name"] + " " + order["address"]);
			  	  ordersRowConstructor.push(order["orderDate"]);

			  	  ordersWaitingTableConstructor.push(ordersRowConstructor);

		  }

		  $('#orders-waiting').dataTable({
		       data: ordersWaitingTableConstructor,
		       columns: [{
             visible: false,
		       	 title: "<span class=\"fa fa-child fa-fw\" style=\"color: black;\"></span>   " + "  no.",
                     width: "30%"
		       }, {
		           title: "orders waiting",
                     width: "40%"
		       }, {
		           title: "order date",
                     width: "30%"
		       }],
		       scrollY: '60vh',
		       scrollCollapse: true,
		       paging: false,
		       resposnive: true,
		       info: false,
                 language: {
                   searchPlaceholder: "Search order waiting...",
                   sSearch: ""
                 },
               aaSorting: [[2, 'asc']],
               fnCreatedRow: function(nRow, aData, iDisplayIndex) {
                    // nRow - this is the HTML element of the row
                    // aData - array of the data in the columns. Get column 4 data: aData[3]
                    // iDataIndex - row index in the table

                   // color the Items field
                   if (aData[2] > 35) { // red
                       $('td:eq(2)', nRow).css("background-color", "#ffad99");
                   } else if (aData[2] >=25) { // orange
                       $('td:eq(2)', nRow).css("background-color", "#ffdd99");
                   } else if (aData[2] >= 5) { // yellow
                       $('td:eq(2)', nRow).css("background-color", "#ffffcc");
                   }
               }
		   });


            //   Set dashboard data in the three boxes on the top

            var ordersWaitingTotal = ordersWaitingTableConstructor.length || 0;
            var currDate = new Date();
            currDate.setHours(0,0,0,0);
            console.log(currDate);
            var ordersWaitingToday = 0;
            var ordersWaitingWeek = 0;
            var dashToday = new Date();
            dashToday.setDate(currDate.getDate()+1)
          //  console.log(dashToday);
            var dashWeek = new Date();
            dashWeek.setDate(currDate.getDate()+7)
          //  console.log(dashWeek);

            for(i=0;i<ordersWaitingTotal;i++){
              var orderDateStr = ordersWaitingTableConstructor[i][2];
              //console.log(orderDateStr);
              var orderDateStrDate = new Date(orderDateStr);
              var orderDate = new Date();
              orderDate.setDate(orderDateStrDate.getDate()+1);
              console.log(orderDate);
              if(orderDate.getTime() >= currDate.getTime() && orderDate.getTime() < dashToday.getTime()){
                ordersWaitingToday=ordersWaitingToday +1;
              }

              if(orderDate.getTime() >= currDate.getTime() && orderDate.getTime() < dashWeek.getTime()){
                ordersWaitingWeek =ordersWaitingWeek+1;
              }
            }




            $("#orders-waiting-today").html(ordersWaitingToday);
            $("#orders-waiting-week").html(ordersWaitingWeek);
            $("#orders-waiting-total").html(ordersWaitingTotal);

	  });
  });
});

$("#orders-waiting").ready(function() {
    $("#orders-waiting > tbody > tr").select(function() {
        $(this).children('td')[3].css({"backgroung-colour": "yellow"});
    });
});

var clicks = 0;



$("body").on('dblclick', '#orders-waiting > tbody > tr', function() {
    // var NHSnumber = $(this).children('td')[0];
    var dtTable = $('#orders-waiting').DataTable();
    console.log(dtTable);
     var NHSnumber = dtTable.row(this).data();
     console.log(NHSnumber[0]);
     //NHSnumber = NHSnumber.textContent;
     window.location.href = URL + "/app/order/" + NHSnumber[0];
});

/*
     Google analytics
*/
(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
})(window,document,'script','https://www.google-analytics.com/analytics.js','ga');

ga('create', 'UA-97568701-1', 'auto');
ga('send', 'pageview');
