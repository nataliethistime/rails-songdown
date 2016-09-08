'use strict'

var SongdownGlobal = function() {
  this._readyCallbacks = []

  this.onReady = function(callback) {
    if (typeof callback === 'function') {
      this._readyCallbacks.push(callback)
    }
  }

  this.handleReady = function() {
    console.log('[Songdown.handleReady]: handling callbacks')

    _.each(this._readyCallbacks, function(callback) {
      callback.call(window)
    })
  }

  $(document)
    .on('turbolinks:load', _.bind(this.handleReady, this))

  this.postData = function(url, data, successCallback, errorCallback) {
    if (typeof successCallback !== 'function') {
      successCallback = _.noop;
    }

    if (typeof errorCallback !== 'function') {
      errorCallback = _.noop;
    }

    console.log('[Songdown.postData]: posting to', url, 'with', data);

    $.ajax({
      url: url,
      type: 'post',
      data: JSON.stringify(data),
      contentType: 'application/json; charset=utf-8',
      traditional: true,
      success: successCallback,
      error: errorCallback
    });
  }
}

window.Songdown = new SongdownGlobal()
