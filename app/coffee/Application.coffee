define 'app/js/Application', ['backbone', 'marionette'], (Backbone, Marionette) ->

    class Application extends Marionette.Application

        initialize: (options) ->
            console.log "App #{@name} initialized", @

            @vent.on 'navigation', (data) =>
                for mkey of @submodules
                    module = @submodules[mkey]
                    for rkey of module.routers
                        router = module.routers[rkey]
                        router.navigate(route, {trigger: true}) for route of router.appRoutes when route is data.target

            @on 'start', ->
                Backbone.history.start
                    pushState: true
                    root: '/'

    window.Application or= new Application name: 'Frontcoder Web', channelName: 'app'

