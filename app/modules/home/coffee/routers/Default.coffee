define 'app/modules/home/js/routers/Default', ['marionette', 'app/modules/home/js/controllers/Default'], (Marionette, Controller) ->

    class Default extends Marionette.AppRouter

        controller: new Controller channelName: @options?.channelName
        
        appRoutes:
            "home": "showhome"
