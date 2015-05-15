define 'app/modules/cms/js/routers/Default', ['marionette', 'app/modules/cms/js/controllers/Default'], (Marionette, Controller) ->

    Marionette.AppRouter.extend

        controller: new Controller
        
        appRoutes:
            "posts": "showPosts"
            "post/:id": "showPost"
