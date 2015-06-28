define 'app/modules/home/js/views/Header', ['marionette', 'wreqr', 'tpl!app/modules/home/templates/header.html'], (Marionette, Wreqr, tpl) ->

    class Header extends Marionette.ItemView

        className: 'fc-home-header'

        channelName: 'home'

        vent: null

        options: null

        template: (model) -> tpl model: model or {}

        initialize: (@options) ->
            @channelName = @options?.channelName or @channelName
            @vent = Wreqr.radio.channel(@channelName).vent

