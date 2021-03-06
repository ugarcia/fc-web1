define 'app/modules/portfolio/js/views/Header', ['marionette', 'wreqr', 'tpl!app/modules/portfolio/templates/header.html'], (Marionette, Wreqr, tpl) ->

    class Header extends Marionette.ItemView

        className: 'fc-portfolio-header'

        channelName: 'portfolio'

        vent: null

        options: null

        template: (model) -> tpl model: model or {}

        initialize: (@options) ->
            @channelName = @options?.channelName or @channelName
            @vent = Wreqr.radio.channel(@channelName).vent

