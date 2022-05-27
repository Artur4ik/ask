// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
//= require jquery
//= require jquery_ujs
//= require popper
//= require bootstrap-sprockets
//import "@hotwired/turbo-rails"

import "controllers"
import { createPicker } from 'picmo';


//$(".ce").hide();

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
  var content_type;
  var target_id;
  if($(this).data("target-type") == "Q")
  {
    content_type = "question";
  }
  if($(this).data("target-type") == "A")
  {
    content_type = "answer";
  }
  target_id = $(this).data("target-id");
  $.ajax({
    url: url_path,
    type: "post",
    data: params,
    success: function(data) {
      doc.text(($(JSON.parse(JSON.stringify(data))).length).toString() + " " + emoji);
      //$("#t-"+content_type + target_id).css("box-shadow", "0 0 20px rgb(255, 238, 0)");
    },
    error: function(data) {}
  });

});

var default_avatar = $("#user-avatar").attr("src");

$("#user-email").focusout(function() {
  var url_path = $(this).data("url-path");
  var params = {email: $(this).val()};
  $("#loading").removeAttr("hidden");
  $("#loading").show(300);
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
        $("#loading").hide(300);
      }
      else
      {
        $("#user-avatar").attr("src", data.avatar_url);
        $("#user-name").text(data.name);
        $(".field-email").hide(300);
        $("#loading").hide(300);
      }
    },
    error: function(data) {}
  });

});

$(".btn.show-ce").click(function() {
  $($(this).data("id")).toggle(300);
});

$(".aside-menu").click(function() {
  window.location.href=$(this).data("url-path");
});

$(".btn.cu").click(function() {
  var edit_form_selector = "#ce-form-" + $(this).data("content-type") + $(this).data("id");
  var url_path = $(this).data("url-path");
  var params = {body: $(edit_form_selector).val()};
  var text_selector = $(this).data("content-type") + $(this).data("id");
  $.ajax({
    url: url_path,
    type: "patch",
    data: params,
    dataType: "json",
    success: function(data) {
      if(data != null)
      {
        $("#"+ text_selector).text(data.body);
        $("#ce-" + text_selector).hide(300);
      }
    },
    error: function(data) {}
  });
});


$(".btn.delete-c").click(function() {
  var form_selector = $(this).data("id");
  var url_path = $(this).data("url-path");
  var params = {};
  $.ajax({
    url: url_path,
    type: "delete",
    data: params,
    dataType: "json",
    success: function(data) {
      $(form_selector).hide(300);
    },
    error: function(data) {}
  });
});

$(".img-logo").click(function() {
  $("#quote-card").toggle(500);
});
