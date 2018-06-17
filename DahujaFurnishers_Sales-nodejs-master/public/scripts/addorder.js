var URL = location.protocol + '//' + location.host;
//var syncGoogle = require('./server/scripts/quickstart.js');


$(document).ready(function() {
    var itemsAPI = URL + "/app/getitems";




    $.getJSON(itemsAPI).done(function(allitems) {
         var itemsScoresCheckboxes = [];

         for(var item in allitems) {
             var itemscoreCheckbox = [];
             itemscoreCheckbox[0] = item;
             itemscoreCheckbox[1] = allitems[item]; // This is the items.

             var input = "<input type=\"checkbox\" name=\"PD[]\" value=\"" + item + "\">";
             itemscoreCheckbox[2] = input;

             itemsScoresCheckboxes.push(itemscoreCheckbox)
         }

         $('#add-new-order').dataTable({
               data: itemsScoresCheckboxes,
               columns:
               [
                   {
                       title: "Item"
                   },
                   {
                       title: "Items"
                   },
                   {
                       title: "Diagnosis"
                   },
               ],
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

/*
     Google analytics
*/
(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
})(window,document,'script','https://www.google-analytics.com/analytics.js','ga');

ga('create', 'UA-97568701-1', 'auto');
ga('send', 'pageview');
