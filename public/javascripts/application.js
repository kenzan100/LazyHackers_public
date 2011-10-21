// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).bind("mobileinit", function(){ 
  $.mobile.ajaxEnabled = false; // ajaxを無効 
});

$('#Scope').live("pagecreate", function(){
  $('#add_comment').hide();
  
	$('#TellUsYourKnowhow').click(function(){
  	$('#add_comment').show("slow");
  	$('#TellUsYourKnowhow').hide();
  	
});

$('#Scope').live("pageshow", function(){
  $('span.ui-btn-text').css('z-index', '0');
  });
	
	$('#AddHackTag').change(function(){
	  if($(this).children('option:selected').text() == '新規作成'){
	    $('#WantingNewTag').show();
	    $('form#new_users_scope').hide();
	  }else{
		  $(this).parents('form#AddingHackTag').submit();
	  }
	});
	
});

$(function(){

	$('#DefiningScope form').hide();
	$('#Departure').click(function(){
		$('#DefiningScope form').toggle();
		$('#Header h1').toggle();
	});

//	$('form.GoWatchThereForm').find('span.ui-btn-text').live('click', function(){
//	  $(this).parents('form.GoWatchThereForm').submit();
//	});
});
