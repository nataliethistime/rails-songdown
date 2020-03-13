class SongdownGlobal {
  constructor() {
    this._readyCallbacks = [];
    document.addEventListener('turbolinks:load', () => this.handleReady());
  }

  onReady(callback) {
    if (typeof callback === 'function') {
      this._readyCallbacks.push(callback)
    }
  }

  handleReady() {
    console.log(`[Songdown.handleReady]: ${this._readyCallbacks.length} handling callbacks`);

    for (var cb of this._readyCallbacks) {
      try {
        cb();
      } catch (e) {
        console.error(e);
      }
    }
  }

  postData(url, data, successCallback, errorCallback) {
    if (typeof successCallback !== 'function') {
      successCallback = function(){};
    }

    if (typeof errorCallback !== 'function') {
      errorCallback = function(){};
    }

    console.log('[Songdown.postData]: posting to', url, 'with', data);

    $.ajax({
      url: url,
      type: data._method || 'post',
      data: JSON.stringify(data),
      contentType: 'application/json; charset=utf-8',
      traditional: true,
      success: successCallback,
      error: errorCallback
    });
  }
}

window.Songdown = new SongdownGlobal();
