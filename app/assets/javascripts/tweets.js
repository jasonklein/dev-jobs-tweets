var DevJobsTweetsApp = DevJobsTweetsApp || {};

DevJobsTweetsApp.filter_with_isotope = function() {

  var $container = $('#tweets-container').isotope({
    itemSelector: '.isotope-tweet',
    layoutMode: 'fitRows'
  });

  $('#filter-buttons').on( 'click', 'button', function() {
    var filterValue = $(this).attr('data-filter');
    $container.isotope({ filter: filterValue });
  });

};

$(DevJobsTweetsApp.filter_with_isotope);
