Songdown.onReady(() => {
  var $el = $('#print_song_button');

  $el.on('click', () => {
    const url = window.location.href.replace(/\/songs\//, '/print_song/');
    window.open(url, 'Print Song window');
  });
});
