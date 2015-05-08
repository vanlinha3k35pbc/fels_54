// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require turbolinks
//= require_tree .
//= require jquery.turbolinks

function remove_fields(link) {  
  $(link).prev().val("true"); 
  $(link).closest('.fields').hide();
} 

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var re = new RegExp(association, 'g');
  $(link).parent().prev().append(content.replace(re, new_id));
} 

$(document).ready(function(){
  $(".answersheet").each(function(e) {
    if (e != 0) $(this).hide();
  });

  $("#next").click(function(){
    var nextDiv = $(".answersheet:visible").next(".answersheet");
    if (nextDiv.length == 0) nextDiv = $(".answersheet:first")
    $(".answersheet:visible").hide();
    nextDiv.show();
  });

  $("#prev").click(function(){
    var prevDiv = $(".answersheet:visible").prev(".answersheet");
    if (prevDiv.length == 0) prevDiv = $(".answersheet:last")
    $(".answersheet:visible").hide();
    prevDiv.show();
  });
});
