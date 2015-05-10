define 'app/modules/main/Module', ['app/Application', 'app/modules/main/routers/Default'], (Application, DefaultRouter) ->

    Application.module "Main", (Module, Application, Backbone, Marionette, $, _) ->

        Module.DefaultRouter = new DefaultRouter
        Module.on 'start', -> console.log "Module Started", Module

