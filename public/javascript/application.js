function showLinkFavouriteNotice(link) {
  var favourited = !!$(link).data('favourited');
  var name = $(link).find('.title').text();
  var message = favourited ?
                name + ' was added to favourites' :
                name + ' was removed from favourites';
                // jQuery addClass('flash notice') equiv. to addClass('flash').addClass('notice')
  var flash = $("<div></div>").addClass('flash notice').html(message);
  $(flash).appendTo('#flash-container');
  // add tmeout so flash message dissapear after 3 seconds
  setTimeout(function() {
    $(flash).fadeOut(); // NOTE: flash variable here stored until fadeOut() executed
  }, 3000);
}

function addFavouritesHandler() {
  $(".star.solid").click(function(event){ /* NO SPACE means class star AND  class solid */
    var link = $(this).parent();
    var favourited = !!$(link).data('favourited'); // !! casts 'undefined' to 'false'!
    var newOpacity = favourited ? 0 : 1
    // var newOpacity = 1 - parseInt($(this).css('opacity'));
    $(link).data('favourited', !favourited);
    $(this).animate({opacity: newOpacity}, 500); // pass animate to object passed to jQuery
    showLinkFavouriteNotice(link);
  });
}

functon prepareFormHandler() {
  var form = $('#container #ajax-form form');
  form.submit(function(event) {
    var addLink = function(data) {
      $('#links').prepend(data);
    }
    var formData = form.serialize();
    $.post(form.attr('action'), formData, addLink);
    event.preventDefault();
  });
}

function prepareRemoteFormsHandler() {
  $('.new-link', '.new-user', '.new-session').click(function(event){
    // jQuery GET takes URL - attr('href') and function with data
    $.get($(this).attr('href'), function(data) {
      // check if container id length is zero ensures prepend only executed if container empty :)
      // ** jQuery on CSS selectors that dn't exist returns [] **
      if($('#ajax-form').length == 0) {
        //dynamically create a new div id to hold the form data
        $('#container').prepend("<div id='ajax-form'></div>");
      }
      // this line injects the form data as html to the dynamically created
      // ajax form inside the container id and renders it on the page
      $('#container #ajax-form').html(data);
      prepareFormHandler()
    });
    event.preventDefault();
  });
}

$(function() { // shorthand for $(document).ready(function(){})
  addFavouritesHandler();
  prepareRemoteFormsHandler();
});
