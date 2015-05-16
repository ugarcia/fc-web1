define 'app/modules/cms/js/controllers/Default', [
    'marionette'
    'wreqr'
    'app/modules/cms/js/api/API'
    'app/modules/cms/js/views/Layout'
    'app/modules/cms/js/views/Header'
    'app/modules/cms/js/views/Post'
    'app/modules/cms/js/views/Posts'
    'app/modules/cms/js/views/PostModal'
    'app/modules/cms/js/models/Post'
    'app/modules/cms/js/collections/Posts'
], (
    Marionette
    Wreqr
    API
    Layout
    Header
    PostView
    PostsView
    PostModal
    Post
    Posts
) ->

    class DefaultController extends Marionette.Controller

        channelName: 'cms'

        vent: null

        layout: null

        options: null

        constructor: (@options) ->
            @channelName = @options?.channelName or @channelName
            @vent = Wreqr.radio.channel(@channelName).vent
            @setEvents()
            @

        setEvents: ->
            @vent.on 'modal:open:post', @openPostModal

        openPostModal: (data) =>
            @openModal new PostModal model: data?.model ? new Post

        openModal: (view) =>
            @layout.getRegion('modal').show view if view

        showPosts: ->
            @initLayout()
            posts = new Posts
            posts.fetch() 
            @layout.getRegion('content').show new PostsView collection: posts, channelName: @channelName 

        showPost: (id) ->
            @initLayout()
            post = new Post id: id
            post.fetch() 
            @layout.getRegion('content').show new PostView model: post              

        initLayout: ->
            if not @layout
                @layout = new Layout
                @layout.render()
                @layout.getRegion('header').show new Header channelName: @channelName
