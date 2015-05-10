define 'app/modules/main/routers/Default', ['marionette', 'app/modules/main/controllers/Default'], (Marionette, Controller) ->

    Marionette.AppRouter.extend

        controller: new Controller
        
        appRoutes:
            "main/foo": "doFoo"
            "main/bar/:id": "doBar"
