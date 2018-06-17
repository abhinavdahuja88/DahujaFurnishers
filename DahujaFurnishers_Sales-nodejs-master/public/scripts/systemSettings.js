var URL = location.protocol + '//' + location.host;

$(document).ready(function() {
    var itemsAPI = URL + "/app/getitems/";

    $.getJSON(itemsAPI).done(function(allitems) {
           var itemsScoresCheckboxes = [];

           for(var item in allitems) {
             var itemscoreCheckbox = [];
        	   itemscoreCheckbox[0] = item;
        	   //itemscoreCheckbox[1] = allitems[item]; // This is the items.
             itemscoreCheckbox[1] = "<input type=\"checkbox\" name=\"DD[]\" value=\"" + item + "\">";

        	   itemsScoresCheckboxes.push(itemscoreCheckbox)
           }

           $('#items-table').dataTable({
		      data: itemsScoresCheckboxes,
		      columns:[{
	              title: "Item",
                  width: "50%"
	          },{
	              title: "Select",
                  width: "30%"
	          }],
		      scrollY: '40vh',
		      scrollCollapse: true,
		      paging: false,
                info: false,
                language: {
                  searchPlaceholder: "Search item...",
                  sSearch: ""
                },
		 });
    });
});


// fill the customItems table
$(document).ready(function() {
    var customItemsAPI = URL + "/app/getcustomItems/";

    $.getJSON(customItemsAPI).done(function(allcustomItems) {
           var customItemsScoresCheckboxes = [];

           for(var customItem in allcustomItems) {
               if (customItem !== 'nocustomItem') {
                    var customItemscoreCheckbox = [];
                    customItemscoreCheckbox[0] = customItem;
                    customItemscoreCheckbox[1] = "<input type=\"checkbox\" name=\"RD[]\" value=\"" + customItem + "\">";

                    customItemsScoresCheckboxes.push(customItemscoreCheckbox);
               }
           }

           $('#customItems-table').dataTable({
		      data: customItemsScoresCheckboxes,
		      columns:[{
	              title: "CustomItem",
                  width: "60%"
                },{
	              title: "Select",
                  width: "40%"
	           }],
		      scrollY: '40vh',
		      scrollCollapse: true,
		      paging: false,
                info: false,
                language: {
                  searchPlaceholder: "Search customItem...",
                  sSearch: ""
                },
		 });
    });
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
