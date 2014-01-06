// $(function() { // shorthand for $(document).ready(function(){})

// });

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

$(function() {
  addFavouritesHandler();
});

function showLinkFavouriteNotice(link) {
  var favourited = !!$(link).data('favourited');
  var name = $(link).find('.title').text();
  var message = favourited ?
                name + ' was added to favourites' :
                name + ' was removed from favourites';
  console.log(message);
}
