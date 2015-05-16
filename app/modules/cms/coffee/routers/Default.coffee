define 'app/modules/cms/js/routers/Default', ['marionette', 'app/modules/cms/js/controllers/Default'], (Marionette, Controller) ->

    class Default extends Marionette.AppRouter

        controller: new Controller channelName: @options?.channelName
        
        appRoutes:
            "posts": "showPosts"
            "posts/:id": "showPost"
