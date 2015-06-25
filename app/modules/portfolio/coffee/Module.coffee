define 'app/modules/portfolio/js/Module', ['marionette', 'app/js/Application', 'app/modules/portfolio/js/routers/Default'], (Marionette, Application, DefaultRouter) ->

    class PortfolioModule extends Marionette.Module

        channelName: 'portfolio'

        startWithParent: true

        initialize: (options, moduleName, app) ->
            @channelName = options?.channelName or @channelName
            @routers or= {}
            @routers.DefaultRouter = new DefaultRouter  channelName: @channelName
            
        onStart: (options) ->
            console.log "Module #{@moduleName} Started", @

        onStop: (options) ->

        # TODO: Improve/refactor this skeleton ...
        checkAuth: ->
            @routers.DefaultRouter.controller.checkAuth (info) -> console.log info

    Application.module "Portfolio", PortfolioModule
