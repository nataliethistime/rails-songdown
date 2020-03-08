(function() {
  function handleKeySelector($el) {
    $el.on('change', function() {
      // Grab the song id from the URL
      var matches = window.location.href.match(/\/songs\/(\d+)/);
      var songId = parseInt(matches[1], 10);
      var newKey = $(this).val();

      Songdown.postData('/api/transpose_song', {
        song_id: songId,
        new_key: newKey
      }, function(data) {
        $('.sd-song').each(function() {
          $(this).html(data.transposed_song);
        });

        if (window.history && window.history.replaceState) {
          var l = window.location;
          window.history.replaceState({}, '', l.pathname + '?key=' + newKey);
        }
      });
    });
  }

  Songdown.onReady(function() {
    var $el = $('#song_transpose');

    if ($el.exists) {
      handleKeySelector($el);
    }
  });
})();
