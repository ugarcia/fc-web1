define 'app/modules/portfolio/js/models/PortfolioItem', ['backbone', 'app/modules/portfolio/js/api/API'], (Backbone, API) ->

    class PortfolioItem extends Backbone.Model
    
        # @property The default attributes for the Model
        defaults:
            img: ''
            caption: ''
            link: ''            
            title: ''          
            content: '' # String (modified by read_more query var)
          
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
                    API.getPortfolioItem(@id).then (res) -> options.success res.item    
