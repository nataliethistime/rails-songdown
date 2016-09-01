'use strict';

// A quick jquery mod to make life easier.
(function($) {
  $.fn.exists = function() {
    return this.length > 0;
  };
})(jQuery);

