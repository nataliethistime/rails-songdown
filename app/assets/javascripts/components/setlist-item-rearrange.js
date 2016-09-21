'use strict';

(function() {
  function handleItemDrop() {
    // Make sure the "Rearrange Songs" button is shown.
    $('#setlist_items_rearrange_button').show();

    // Reoder the songs
    $('tr', '#setlist_item_rearrange').each(function(i) {
      $(this).attr({
        'data-position': i
      });
    });
  }

  function setupDragula(el) {
    dragula([el]).on('drop', handleItemDrop);
  }

  function handleRearrangeButtonClick(e) {
    e.preventDefault();
    var items = [];

    $('tr', '#setlist_item_rearrange').each(function(i) {
      items.push({
        position: i,
        id: $(this).attr('data-id')
      });
    });

    var url = window.location.href
      .replace(/edit_items$/, 'rearrange_items');

    Songdown.postData(url,
      {
        items: items
      },
      function() {
        $('#setlist_items_rearrange_button').hide();
      }
    )
  }

  Songdown.onReady(function() {
    var $el = $('#setlist_item_rearrange');

    if ($el.exists()) {
      setupDragula($el[0]);
    }

    $('div:first', '#setlist_items_rearrange_button').on('click', handleRearrangeButtonClick)
  });
})();
