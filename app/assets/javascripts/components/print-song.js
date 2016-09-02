'use strict';

(function() {
  function handlePrintButton($el) {
    $el.on('click', function() {
      var url = window.location.href.replace(/\/songs\//, '/print_song/');
      window.open(url, 'Print Song window');
    });
  }

  Songdown.onReady(function() {
    var $el = $('#print_song_button');

    if ($el.exists()) {
      handlePrintButton($el);
    }
  });
})();
