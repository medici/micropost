$(document).ready(function() {
  $('.reply').click(function() {
  	var reply_form = $(this).parent().children('.reply_form');
  	if(reply_form.is(':hidden')) {
  		reply_form.show();
  	}
  	else {
  		reply_form.hide();
  	}
  });

  $('.retweet').click(function() {
  	var reply_form = $(this).parent().children('.retweet_form');
  	var user_name = $(this).parent().children('.user').children('a').text();
  	var content = $(this).parent().children('.content').text();
  	if(reply_form.is(':hidden')) {
  		reply_form.show();
  		reply_form.find('textarea').text(user_name + ': ' + content);
  	}
  	else {
  		reply_form.hide();
  	}
  });
});