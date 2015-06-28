define 'app/modules/home/js/controllers/Default', [
    'marionette'
    'wreqr'
    'app/modules/home/js/views/Layout'
    'app/modules/home/js/views/Header'
    'app/modules/home/js/views/Home'
], (
    Marionette
    Wreqr
    Layout
    Header
    HomeView
) ->

    class DefaultController extends Marionette.Controller

        channelName: 'home'

        vent: null

        layout: null

        options: null

        constructor: (@options) ->
            @channelName = @options?.channelName or @channelName
            @vent = Wreqr.radio.channel(@channelName).vent
            @

        showhome: ->
            @initLayout()
            @layout.getRegion('header').show new Header channelName: @channelName
            homeContent = @layout.getRegion('content')
            homeContent.show new HomeView
            # TODO: HEre messaging with Portfolio module
            homeContent.getRegion('portfolio').reset()

        initLayout: ->
            if not @layout
                @layout = new Layout
                @layout.render()
