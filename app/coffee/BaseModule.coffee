define 'app/js/BaseModule', ['marionette', 'wreqr', 'app/js/BaseRouter'], (Marionette, Wreqr, DefaultRouter) ->

  class BaseModule extends Marionette.Module

    channelName: 'base'

    startWithParent: true

    vent: null

    initialize: (options, moduleName, app) ->
      @channelName = options?.channelName or @channelName
      @vent = Wreqr.radio.channel(@channelName).vent
      @routers or= {}
      @setRouters()
      @setEvents()

    onStart: (options) ->
      console.log "Module #{@moduleName} Started", @

    onStop: (options) ->

    setRouters: ->
      @routers.DefaultRouter = new DefaultRouter channelName: @channelName

    setEvents: ->
      @vent.on 'module:request', (data) =>
        data.source = @moduleName
        @app.vent.trigger 'request', data
      @vent.on 'module:response', (data) =>
        data.target = data.source
        data.source = @moduleName
        @app.vent.trigger 'response', data
      @vent.on 'request', (data) => @vent.trigger "request:#{data.request}", data
      @vent.on 'response', (data) => @vent.trigger "response:#{data.request}", data.data
