// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).bind("mobileinit", function(){ 
$.mobile.ajaxEnabled = false; // ajaxを無効 
});

$(function(){
	$('#UsersInThisScope a').click(function(){
		var hoge = $(this).siblings('.user_id').text();
		//$('#Cheering').html(hoge);
		$('#Cheering #user_id').val(hoge);
		$('#SeeProfile').html('<a href="/users/'+hoge+'/">この人のプロフィールを見る</a>')
	});
	
	$('#Footer').click(function(){
		$('#History input.MeToo').siblings().css('top', '-18px');
	});
	
	$('#DefiningScope form').css('display', 'none');
	$('#StandOutForm').css('display', 'none');
	
	$('#StandOut').click(function(){
		$('#StandOutForm').toggle();
	});
	$('#Departure').click(function(){
		$(this).parent().css('display', 'none');
		$('#DefiningScope form').css({
			'display': 'inline-block',
		});
		$('#Header h1').toggle();
	});
	
	$('#AddHackTag').change(function(){
		$(this).parents('form#AddingHackTag').submit();
	});
	
	$('#MeToo').siblings().css('top', '-18px');
});
