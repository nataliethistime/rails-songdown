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
    .ready(_.bind(this.handleReady, this))
    .on('page:load', _.bind(this.handleReady, this))
}

window.Songdown = new SongdownGlobal()
