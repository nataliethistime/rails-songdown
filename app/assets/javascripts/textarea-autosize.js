'use strict';

(function() {
  Songdown.onReady(function() {
    $('textarea').each(function() {
      $(this).css({
        height: (this.scrollHeight) + 'px',
        'overflow-y': 'hidden'
      });
    }).on('input', function() {
      this.style.height = 'auto';
      this.style.height = (this.scrollHeight) + 'px';
    });
  });
})();
