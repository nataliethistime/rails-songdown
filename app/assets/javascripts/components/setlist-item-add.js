(function() {
  function int(number) {
    return parseInt(number, 10);
  }

  function setSelectedSong(songs, songId) {
    var song = _.chain(songs)
      .filter(function(song) {
        return int(song.id) === int(songId);
      })
      .first()
      .value();

    if (song) {
      console.log('Selected:', song);

      $('#setlist_item_title').val(song.title);
      $('#setlist_item_song_id').val(song.id);
      $('#setlist_item_artist').val(song.artist);
      $('#setlist_item_key').val(song.key);
    } else {
      console.log('Song not found', songs, songId);
    }
  }

  function handleSearchResults(e, data, status, xhr) {
    var songs = JSON.parse(xhr.responseText).results;
    var list = [];

    _.each(songs, function(song) {
      list.push([
        '<li>',
          '<a class="fancy-link" data-song-id="' + song.id + '" href="#">' +
            song.artist + ' - ' + song.title +
          '</a>',
        '</li>'
      ].join(''));
    });

    $('#results').html(
      [
        '<h2>Results</h2>',
        '<ul>',
          list.join(''),
        '</ul>'
      ].join('')
    );

    $('a', '#results').off()
      .on('click', function(e) {
        e.preventDefault();
        setSelectedSong(songs, $(this).attr('data-song-id'));
        $('body').scrollTop(0);
      }).on('ajax:error', function(e, data, status, error) {
        $('#results').append('ERROR');
      });
  };

  Songdown.onReady(function() {
    var $el = $('#find_song');

    if ($el.exists()) {
      $el.on('ajax:success', handleSearchResults);
    }
  });
})();
