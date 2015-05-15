define 'app/modules/main/js/routers/Default', ['marionette', 'app/modules/main/js/controllers/Default'], (Marionette, Controller) ->

    Marionette.AppRouter.extend

        controller: new Controller
        
        appRoutes:
            "home": "home"
