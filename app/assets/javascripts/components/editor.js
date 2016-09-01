'use strict';

(function() {
  var _waiting = false;

  function postInput($inputEl, $outputEl) {
    Songdown.postData('/api/compile_songdown', {
      input: $inputEl.refresh().val()
    }, function(data) {
      _waiting = false;
      $outputEl.refresh().html(data.output);
    });
  }

  function setupEditor($inputEl, $outputEl) {
    $inputEl.on('keydown', function(e) {
      if (!_waiting) {
        _waiting = true;
        setTimeout(_.partial(postInput, $inputEl, $outputEl), 3000);
      }
    });
  }

  Songdown.onReady(function() {
    var $inputEl = $('#songdown_editor_input');
    var $outputEl = $('#songdown_editor_output');

    if ($inputEl.exists() && $outputEl.exists()) {
      setupEditor($inputEl, $outputEl);
    }
  });
})();
