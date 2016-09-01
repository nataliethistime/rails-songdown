'use strict'

;(function() {
  function moveCursorToEnd(el) {
    if (typeof el.selectionStart === "number") {
      el.selectionStart = el.selectionEnd = el.value.length;
    } else if (typeof el.createTextRange !== "undefined") {
      var range = el.createTextRange();
      range.collapse(false);
      range.select();
    }
  }

  Songdown.onReady(function() {
    var searchField = document.getElementById('song_search_field')

    if (searchField) {
      searchField.focus()
      moveCursorToEnd(searchField)
    }
  })
})()
