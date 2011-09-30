// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).bind("mobileinit", function(){ 
$.mobile.ajaxEnabled = false; // ajaxを無効 
});

$(function(){
	$('#DefiningScope form').css('display', 'none');
	
	$('#Departure').click(function(){
		$(this).parent().css('display', 'none');
		$('#DefiningScope form').css({
			'display': 'inline-block',
		});
		$('#Header h1').toggle();
	});
	
	$('#AddHackTag').change(function(){
		$(this).parents('form').submit();
	});
	
});
