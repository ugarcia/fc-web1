define 'app/routers/MainRouter', ['marionette', 'app/controllers/MainController'], (Marionette, MainController) ->
  Marionette.AppRouter.extend
    controller: new MainController
    appRoutes:
      "foo": "doFoo"
      "bar/:id": "doBar"
