define 'app/modules/main/js/routers/Default', ['marionette', 'app/modules/main/js/controllers/Default'], (Marionette, Controller) ->

    class Default extends Marionette.AppRouter

        controller: new Controller
        
        appRoutes:
            "home": "home"
