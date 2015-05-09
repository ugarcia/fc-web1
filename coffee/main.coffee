Backbone.history.start()

class MainController
  doFoo: -> $('body').html('foo!!!')
  doBar: (id) -> $('body').html("Bar ist #{id}")

MyRouter = new Marionette.AppRouter
  controller: new MainController
  appRoutes:
    "foo": "doFoo"
    "bar/:id": "doBar"

