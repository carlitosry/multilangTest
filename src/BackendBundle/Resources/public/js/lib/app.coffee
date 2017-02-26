SymfonyApp = {
  ajax : {
    method : {
      GET : 'get'
      POST: 'post'
    }

    fail : (xhr) ->
#login required - not authorized
      if(xhr.status == 401)
#necesita login
#window.location = window.location
      else
        alert('ERROR: ' + xhr.responseText );
      return;

#make ajax request
    do : (url, data, method = 'post', success, fail, complete) ->
      self = SymfonyApp;
      #overlay = self.createOverlay().show();
      return $.ajax({
        type: method
        url: url
        data: data
        success: (data, status, xhr) ->
          type = xhr.getResponseHeader("content-type")
          html = false;
          # If response is html, then we assume we are handling an error (possibly a form post with validation errors)
          # and we will return back the whole form instead of a json response
          if(type && type.indexOf('text/html') > -1)
            html = true;
          else if(typeof data == 'string')
            data = $.parseJSON(data);

          success?(data, html);
          return;
        error : (xhr) ->
          if fail then fail(xhr) else self.ajax.fail(xhr);
          return;

        complete : (xhr, status) ->
          complete?(xhr, status);
          #overlay.hide();
          return;
      });

    get : (url, data, callback, fail, complete) ->
      self = SymfonyApp;
      return self.ajax.do(url, data, self.ajax.method.GET, callback, fail, complete);

    post : (url, data, callback, fail, complete) ->
      self = SymfonyApp;
      return self.ajax.do(url, data, self.ajax.method.POST, callback, fail, complete);

  }

  init: () ->
    self = this;

    return self;
};

window.App = SymfonyApp.init();