(function() {
  var _timeout = '';

  function postInput() {
    var $inputEl = $('#songdown_editor_input');
    var $outputEl = $('#songdown_editor_output');

    Songdown.postData('/api/compile_songdown', {
      input: $inputEl.val()
    }, function(data) {
      $outputEl.html(data.output);
      clearTimeout(_timeout);
      _timeout = '';
    });
  }

  function setupEditor($inputEl) {
    $inputEl.on('keydown', function(e) {
      if (_timeout) {
        clearTimeout(_timeout);
        _timeout = '';
      }

      _timeout = setTimeout(postInput, 3000);
    });
  }

  Songdown.onReady(function() {
    var $inputEl = $('#songdown_editor_input');
    var $outputEl = $('#songdown_editor_output');

    if ($inputEl.exists() && $outputEl.exists()) {
      setupEditor($inputEl);
    }
  });
})();
