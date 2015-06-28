define 'app/js/BaseRouter', ['marionette', 'wreqr', 'app/js/BaseController'], (Marionette, Wreqr, Controller) ->

  class BaseRouter extends Marionette.AppRouter

    channelName: 'base'

    vent: null

    controller: new Controller channelName: @options?.channelName

    initialize: (options) ->
      @channelName = options?.channelName or @channelName
      @vent = Wreqr.radio.channel(@channelName).vent
