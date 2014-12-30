var DevJobsTweetsApp = DevJobsTweetsApp || {};

DevJobsTweetsApp.isotopeFiltering = function() {

  var $container = $('#index-container').isotope({
    itemSelector: '.isotope-tweet',
    layoutMode: 'fitRows'
  });

  $('#filter-buttons').on( 'click', 'button', function() {
    $(this).blur();
    var filterValue = $(this).attr('data-filter');
    $container.isotope({ filter: filterValue });
    $('#filter-buttons').find('.active-button').removeClass('active-button');
    $(this).addClass('active-button');
  });

};

DevJobsTweetsApp.isotopeSorting = function() {

  var $container = $('#archive-container').isotope({
    layoutMode: 'vertical',
    getSortData: {
      category: '.post-category',
      handle: function(p) {
        var handle = $(p).find(".post-handle").data("handle");
        return handle;
      }
    }
  });

  $('#sort-buttons').on( 'click', 'button', function() {
    $(this).blur();
    var sortValue = $(this).attr('data-sort-value');
    $container.isotope({ sortBy: sortValue });
  });

  $('.button-group').each( function( i, buttonGroup ) {
    var $buttonGroup = $( buttonGroup );
    $buttonGroup.on( 'click', 'button', function() {
      $buttonGroup.find('.active-button').removeClass('active-button');
      $(this).addClass('active-button');
    });
  });
};

DevJobsTweetsApp.setup = function() {
  DevJobsTweetsApp.isotopeFiltering();
  DevJobsTweetsApp.isotopeSorting();
}

$(DevJobsTweetsApp.setup);
