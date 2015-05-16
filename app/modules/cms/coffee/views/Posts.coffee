define 'app/modules/cms/js/views/Posts', ['marionette', 'wreqr', 'app/modules/cms/js/views/Post', 'tpl!app/modules/cms/templates/post.html'], (Marionette, Wreqr, PostView, tpl) ->

    class Posts extends Marionette.CollectionView

        channelName: 'cms'

        vent: null

        options: null

        childView: PostView

        childViewOptions:
            channelName: 'cms'

        collectionEvents:
            'update': 'render'

        initialize: (@options) ->
            @channelName = @options?.channelName or @channelName
            @vent = Wreqr.radio.channel(@channelName).vent
            @setEvents()

        setEvents: ->
            @vent.on 'collection:update:posts', => @collection.fetch()