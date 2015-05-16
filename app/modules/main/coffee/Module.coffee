define 'app/modules/main/js/Module', ['marionette', 'app/js/Application', 'app/modules/main/js/routers/Default'], (Marionette, Application, DefaultRouter) ->

    class MainModule extends Marionette.Module

        startWithParent: true

        initialize: (options, moduleName, app) ->
            @routers or= {}
            @routers.DefaultRouter = new DefaultRouter            

        onStart: (options) ->
            console.log "Module #{@moduleName} Started", @
            @routers.DefaultRouter.controller.initLayout()

        onStop: (options) ->

    Application.module "Main", MainModule
