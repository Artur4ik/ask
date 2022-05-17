// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
//= require jquery
//= require jquery_ujs
//= require popper
//= require bootstrap-sprockets
//import "@hotwired/turbo-rails"

import "controllers"
import { createPicker } from 'picmo';

const rootEl = document.querySelector('.pickerContainer');

if(rootEl != null)
{
  const picker = createPicker({ rootElement: rootEl});
  picker.addEventListener('emoji:select', event => {
    document.getElementById(rootEl.getAttribute("target")).value = document.getElementById(rootEl.getAttribute("target")).value + event.emoji;
  });
}

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

var default_avatar = $("#user-avatar").attr("src");

$("#user-email").focusout(function() {
  var url_path = $(this).data("url-path");
  var params = {email: $(this).val()};
  $.ajax({
    url: url_path,
    type: "get",
    data: params,
    dataType: "json",
    success: function(data) {
      console.log(data);
      if(data == null)
      {
        $("#user-avatar").attr("src", default_avatar);
        $("#user-name").text("");
      }
      else
      {
        $("#user-avatar").attr("src", data.avatar_url);
        $("#user-name").text(data.name);
      }
    },
    error: function(data) {}
  });

});
