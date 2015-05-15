define 'app/modules/cms/js/controllers/Default', [
    'marionette'
    'app/modules/cms/js/api/API'
    'app/modules/cms/js/views/Layout'
    'app/modules/cms/js/views/Header'
    'app/modules/cms/js/views/Post'
    'app/modules/cms/js/views/Posts'
    'app/modules/cms/js/models/Post'
    'app/modules/cms/js/collections/Posts'
], (
    Marionette
    API
    Layout
    Header
    PostView
    PostsView
    Post
    Posts
) ->

    Marionette.Controller.extend

        layout: null

        showPosts: ->
            @initLayout()
            API.getPosts().then (res) =>
                posts = new Posts res.posts
                @layout.getRegion('content').show new PostsView collection: posts          

        showPost: (id) ->
            @initLayout()
            API.getPost(id).then (res) =>
                posts = new Post res.post
                @layout.getRegion('content').show new PostView model: post     

        initLayout: ->
            if not @layout
                @layout = new Layout
                @layout.render()
                @layout.getRegion('header').show new Header
