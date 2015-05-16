define 'app/modules/cms/js/models/Post', ['backbone', 'app/modules/cms/js/api/API'], (Backbone, API) ->

    class Post extends Backbone.Model
    
        # @property The default attributes for the Model
        defaults:
            type: ''
            slug: ''
            url: ''            
            status: 'draft' #String ("draft", "published", or "pending")
            title: ''          
            title_plain: ''  
            content: '' # String (modified by read_more query var)
            excerpt: ''
            date: '' # String (modified by date_format query var)
            modified: '' # String (modified by date_format query var)
            categories: [] # Array of objects
            tags: [] # Array of objects
            author: null # Object
            comments: [] # Array of objects
            attachments: [] # Array of objects
            comment_count: 0 # Integer
            comment_status: 'open' # String ("open" or "closed")
            thumbnail: ''
            custom_fields: null # Object (included by using custom_fields query var)
            approvals: null # Now we've got the approvals here

        # Overrided Backbone sync for a non Restful API
        # @param method [String] The CRUD action method for the model data: 'create', 'read', 'update' or 'delete' 
        # @param model [Object] The affected model instance
        # @param options [Object] The provided Backbone options for handling the action results
        # @option options [Function] success Callback for a successfull response, with (model, response, options) arguments
        # @option options [Function] error Callback for an error response, with (model, xhr, options) arguments
        # @return [Object] Asynchronous response to Backbone system in order to perform the action to the model
        sync: (method, model, options) ->
            switch method 

                when "read"
                    API.getPost(@id).then (res) -> options.success res.post

                when "create"
                    formData = new FormData
                    # FIXME: Acthung, setting to published here!!
                    formData.append 'status', 'publish'
                    formData.append 'title', model.get 'title'
                    formData.append 'content', model.get 'content'
                    API.createPost(formData).then (res) -> options.success res.post

                 when "update"
                    formData = new FormData
                    formData.append 'id', model.get 'id'
                    formData.append 'title', model.get 'title'
                    formData.append 'content', model.get 'content'
                    API.updatePost(formData).then (res) -> options.success res.post         
