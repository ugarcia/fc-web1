define 'app/js/Application', ['backbone', 'marionette'], (Backbone, Marionette) ->

  class Application extends Marionette.Application

    initialize: (options) ->
      console.log "App #{@name} initialized", @
      @setEvents()

    setEvents: ->
      @vent.on 'navigation', (data) =>
        data.target or= 'home'
        for mkey of @submodules
          module = @submodules[mkey]
          for rkey of module.routers
            router = module.routers[rkey]
            router.navigate(route, {trigger: true}) for route of router.appRoutes when route is data.target

      @vent.on 'request', (data) =>
        @submodules[mkey].vent.trigger 'request', data for mkey of @submodules when mkey isnt data.source

      @vent.on 'response', (data) =>
        @submodules[data.target].vent.trigger 'response', data

      @on 'start', ->
        Backbone.history.start
          pushState: true
          root: '/'

  window.Application or= new Application name: 'Frontcoder Web', channelName: 'app'
