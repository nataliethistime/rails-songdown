'use strict';

(function() {
  Songdown.onReady(function() {
    $.LoadingOverlaySetup();

    function showLoadingIndicator() {
      $.LoadingOverlay('show');
    }

    function hideLoadingIndicator() {
      $.LoadingOverlay('hide');
    }

    $(document).on('turbolinks:click', showLoadingIndicator);
    $(document).on('turbolinks:load', hideLoadingIndicator);

    $(document).ajaxStart(showLoadingIndicator);
    $(document).ajaxStop(hideLoadingIndicator);
  });
})();
