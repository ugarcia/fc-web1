define 'app/modules/home/js/Module', ['marionette', 'app/js/Application', 'app/modules/home/js/routers/Default'], (Marionette, Application, DefaultRouter) ->

    class homeModule extends Marionette.Module

        channelName: 'home'

        startWithParent: true

        initialize: (options, moduleName, app) ->
            @channelName = options?.channelName or @channelName
            @routers or= {}
            @routers.DefaultRouter = new DefaultRouter  channelName: @channelName
            
        onStart: (options) ->
            console.log "Module #{@moduleName} Started", @

        onStop: (options) ->

    Application.module "Home", homeModule
