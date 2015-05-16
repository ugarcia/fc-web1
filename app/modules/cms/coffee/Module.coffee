define 'app/modules/cms/js/Module', ['marionette', 'app/js/Application', 'app/modules/cms/js/routers/Default'], (Marionette, Application, DefaultRouter) ->

    class CMSModule extends Marionette.Module

        channelName: 'cms'

        startWithParent: true

        initialize: (options, moduleName, app) ->
            @channelName = options?.channelName or @channelName
            @routers or= {}
            @routers.DefaultRouter = new DefaultRouter  channelName: @channelName
            
        onStart: (options) ->
            console.log "Module #{@moduleName} Started", @

        onStop: (options) ->

    Application.module "CMS", CMSModule
