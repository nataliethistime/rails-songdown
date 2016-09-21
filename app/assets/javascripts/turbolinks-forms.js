'use strict';

(function() {
  Songdown.onReady(function() {
    $('form').off().on('submit', function(e) {
      e.preventDefault();

      if (this.method === 'get') {
        Turbolinks.visit(
          this.action + (this.action.indexOf('?') == -1 ? '?' : '&') + $(this).serialize()
        );
      } else if (this.method === 'post') {
        var url = this.action;
        var data = $(this).serializeJSON();
        Songdown.postData(url, data);
      }
    });
  });
})();
