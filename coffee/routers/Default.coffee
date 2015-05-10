define 'app/routers/Default', ['marionette', 'app/controllers/Default'], (Marionette, Controller) ->

    Marionette.AppRouter.extend

        controller: new Controller

        appRoutes:
            "/": "home"
            ".*": "home" 
