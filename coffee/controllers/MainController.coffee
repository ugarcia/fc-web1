define 'app/controllers/MainController', [], ->
  class MainController
    doFoo: -> $('body').html('foo!!!')
    doBar: (id) -> $('body').html("Bar ist #{id}")
