Songdown.onReady(() => {
  $.LoadingOverlaySetup();

  function showLoadingIndicator() {
    $.LoadingOverlay('show');
  }

  function hideLoadingIndicator() {
    $.LoadingOverlay('hide');
  }

  $(document).on('turbolinks:visit', showLoadingIndicator);
  $(document).on('turbolinks:click', showLoadingIndicator);
  $(document).on('turbolinks:load', hideLoadingIndicator);

  $(document).ajaxStart(showLoadingIndicator);
  $(document).ajaxStop(hideLoadingIndicator);
});
