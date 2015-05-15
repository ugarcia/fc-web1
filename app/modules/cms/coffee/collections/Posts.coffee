define 'app/modules/cms/js/collections/Posts', ['backbone', 'app/modules/cms/js/api/API', 'app/modules/cms/js/models/Post'], (Backbone, API, Model) ->

    Backbone.Collection.extend

        # @property The model associated with collection
        model: Model

        # @property The url associated with collection
        url: null

        # Initialization method called on object creation
        initialize: ->
            @comparator = (m1, m2) -> if m1.get('id')<m2.get('id') then 1 else if m1.get('id')>m2.get('id') then -1 else 0

        # Overrided Backbone sync for a non Restful API
        # @param method [String] The CRUD action method for the model data: 'create', 'read', 'update' or 'delete' 
        # @param model [Object] The affected model instance
        # @param options [Object] The provided Backbone options for handling the action results
        # @option options [Function] success Callback for a successfull response, with (model, response, options) arguments
        # @option options [Function] error Callback for an error response, with (model, xhr, options) arguments
        # @return [Object] Asynchronous response to Backbone system in order to perform the action to the model
        sync: (method, model, options) ->
            count = options.data?.count
            page = options.data?.page
            type = options.data?.type
            apiMethod = options.data?.method
            id = options.data?.id
            # console.log options
            switch method 
                when "read"
                    switch apiMethod
                        when "get_recent_posts"
                            API.getRecentPosts(count, page, type).then (res) => @resolveSync res, options
                        when "get_author_posts"
                            API.getAuthorPosts(id, count, page, type).then (res) => @resolveSync res, options
                        when "get_tag_posts"
                            API.getTagPosts(id, count, page, type).then (res) => @resolveSync res, options
                        when "get_date_posts"
                            API.getDatePosts(id, count, page, type).then (res) => @resolveSync res, options
                        when "get_week_posts"
                            API.getWeekPosts(id, count, page, type).then (res) => @resolveSync res, options
                        when "get_post"
                            API.getPost(id).then (res) => @resolveSync {posts: [res.post]}, options
                        else
                            API.getPosts(count, page, type).then (res) => @resolveSync res, options

        # CRUD to Backbone sync resolver
        # @param res [Object] The CRUD action response 
        # @param options [Object] The provided Backbone options for handling the action results
        # @option options [Function] success Callback for a successfull response, with (model, response, options) arguments
        # @option options [Function] error Callback for an error response, with (model, xhr, options) arguments    
        resolveSync: (res, options) -> options.success res.posts
            # count = res.posts.length
            # if count
            #   for post in res.posts
            #     do (post) -> 
            #       API.getApprovals(post.id).then (apvs) ->
            #         post.approvals = apvs.approvals
            #         post.approved = apvs.approved
            #         if not --count then options.success res.posts
            # else
            #   options.success []

        # Creates a Model and adds it to collection
        # @param formData [Object] The form data containing Model properties 
        createModel: (formData) ->
            API.createPost(formData).then (res) => 
                if res?.post
                    # Very bad trick for displaying the new post the first,
                    # as we've optimized the post rendering for audio/video tags ...
                    newModel = new Model res.post
                    newModel.lastAdded = true
                    @add newModel
