'use strict';

(function() {
  Songdown.onReady(function() {
    $("a[rel~=popover], .has-popover").popover();
    $("a[rel~=tooltip], .has-tooltip").tooltip();
  });
})();
