// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require jquery
//= require bootstrap-sprockets

//= require_tree .

$(document).on("turbolinks:load", function(){
  
  $(window).on("resize", function(){
    $(".container-fluid").height($(window).height())
  });
  $(window).trigger("resize");
  
  $("#song_avatar, #user_avatar").on("change", function(e){
    var reader = new FileReader()
    reader.onload = function(e){
      if($(".avatar").length > 0){
        $(".avatar").attr("src", e.target.result)      
      }else{
        var $avatar = $("<img>").attr("src", e.target.result)
        $(".image").prepend($avatar)
      }
    };
    reader.readAsDataURL(e.target.files[0]);
  })
  
  $(".sidebar").on(
    {"mouseover": function(){
    $(".main-content").stop().animate({
      "opacity": 0.3
    }, 500)
    $(this).stop().animate({
      "left": 0,
    }, 500)},
    "mouseout": function(){
      $(".main-content").stop().animate({
        "opacity": 1
      }, 500)
      $(this).stop().animate({
        "left": "-180px",
      }, 500)
    }
  })
})