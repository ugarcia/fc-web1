define 'app/modules/main/js/Module', ['app/js/Application', 'app/modules/main/js/routers/Default'], (Application, DefaultRouter) ->

    Application.module "Main", (Module, Application, Backbone, Marionette, $, _) ->

        Module.routers or= {}
        Module.routers.DefaultRouter = new DefaultRouter
        
        Module.on 'start', -> 
            console.log "Module #{@moduleName} Started", Module
            Module.routers.DefaultRouter.controller.initLayout()

