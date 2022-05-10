// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
//= require jquery
//= require jquery_ujs
//import "@hotwired/turbo-rails"
import "controllers"

$(".like-btn").click(function() {
  var emoji = $(this).html().substring($(this).html().length-2);
  var url_path = $(this).data("url-path");
  var params ={user_id: $(this).data("user-id"), target_id: $(this).data("target-id"), target_type: $(this).data("target-type"), emoji: $(this).data("emoji")};
  var doc = $(this);

  $.ajax({
    url: url_path,
    type: "post",
    data: params,
    success: function(data) {
      doc.text(($(JSON.parse(JSON.stringify(data))).length).toString() + " " + emoji);
    },
    error: function(data) {}
  });

});
