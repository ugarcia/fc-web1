define 'app/modules/cms/js/views/Post', ['marionette', 'wreqr', 'tpl!app/modules/cms/templates/post.html'], (Marionette, Wreqr, tpl) ->

    class Post extends Marionette.ItemView

        channelName: 'cms'

        vent: null

        options: null

        template: (model) => tpl model: model or {}

        modelEvents:
            'change': 'render'

        events:
            'click .fc-post-edit-trigger': 'editPostHandler'

        initialize: (@options) ->
            @channelName = @options?.channelName or @channelName
            @vent = Wreqr.radio.channel(@channelName).vent            

        editPostHandler: (evt) ->
            @vent.trigger 'modal:open:post', model: @model

