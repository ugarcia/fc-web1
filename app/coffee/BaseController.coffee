define 'app/js/BaseController', [
  'marionette'
  'wreqr'
  'app/js/BaseLayout'
], (
  Marionette
  Wreqr
  Layout
) ->

  class BaseController extends Marionette.Controller

    channelName: 'base'

    vent: null

    layout: null

    mainLayoutClass: Layout

    options: null

    constructor: (@options) ->
      @channelName = @options?.channelName or @channelName
      @vent = Wreqr.radio.channel(@channelName).vent
      @setEvents()
      @

    initLayout: ->
      if not @layout
        @layout = new @mainLayoutClass
        @layout.render()
        @startLayout()

    startLayout: ->

    setEvents: ->

    getPath: ->
      path = window.location.pathname
      /^\/([^/?]*).*$/.exec(path)[1]