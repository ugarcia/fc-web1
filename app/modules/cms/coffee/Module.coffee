define 'app/modules/cms/js/Module', ['app/js/Application', 'app/modules/cms/js/routers/Default'], (Application, DefaultRouter) ->

    Application.module "CMS", (Module, Application, Backbone, Marionette, $, _) ->

        Module.routers or= {}
        Module.routers.DefaultRouter = new DefaultRouter

        Module.on 'start', -> 
            console.log "Module #{@moduleName} Started", Module
