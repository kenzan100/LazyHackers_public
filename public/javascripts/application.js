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
	
	$('#DefiningScope form').hide();
	$('#Departure').click(function(){
		$('#DefiningScope form').toggle();
		$('#Header h1').toggle();
	});
	
	$('#AddHackTag').change(function(){
	  if($(this).children('option:selected').text() == '新規作成'){
	    $('#WantingNewTag').show();
	  }else{
		  $(this).parents('form#AddingHackTag').submit();
	  }
	});
	
	$('#History #new_progre').hide();
	$('#History #TellUsYourKnowhow').click(function(){
  	$('#History #new_progre').show("slow");
  	$('#History #TellUsYourKnowhow').hide();
	});
	
	$('form.GoWatchThereForm').find('span.ui-btn-text').live('click', function(){
	  $(this).parents('form.GoWatchThereForm').submit();
	});
});
