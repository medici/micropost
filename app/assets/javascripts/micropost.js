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
});