$(document).ready(function () {
      var flickerAPI = "http://localhost:3000/app/getitems";
      $.getJSON(flickerAPI).done(function(data) {
          var form = $("<form/>", {
              action:'/app/addorder',
              method: 'post'
          });

          for (var prop in data) {
              if (data.hasOwnProperty(prop)) {
                  form.append('<input type="checkbox" name="PD[]" value="' + prop + '" >' + prop + '   ---   ' + data[prop] + '<br>');
              }
          }

          form.append('<input type="submit" value="Submit">');

          $("#show-items-form").append(form);
      });
});
