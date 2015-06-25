define 'app/modules/portfolio/js/collections/Portfolio', ['backbone', 'app/modules/portfolio/js/api/API', 'app/modules/portfolio/js/models/PortfolioItem'], (Backbone, API, Model) ->

    class Portfolio extends Backbone.Collection

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
                    API.getPortfolio().then (res) => options.success res.items
