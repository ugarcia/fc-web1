define 'app/modules/cms/js/views/Header', ['marionette', 'wreqr', 'tpl!app/modules/cms/templates/header.html'], (Marionette, Wreqr, tpl) ->

    class Header extends Marionette.ItemView

        channelName: 'cms'

        vent: null

        options: null

        template: (model) -> tpl model: model or {}

        events:
            'click .fc-modal-trigger': 'openModalHandler'

        initialize: (@options) ->
            @channelName = @options?.channelName or @channelName
            @vent = Wreqr.radio.channel(@channelName).vent

        openModalHandler: (evt) ->
            @vent.trigger 'modal:open:post'
