'use strict';

(function() {
  window.Growlyflash.defaults = $.extend(true, window.Growlyflash.defaults, {
    delay: 10 * 1000,
    dismiss: false,
    target: '#notifications',
  });

  $(document).on("touchstart.alert click.alert", ".growlyflash", function(e) {
    e.preventDefault();
    e.stopPropagation();
    $(this).alert('close');
  });
})();
