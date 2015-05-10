define 'app/collections/Default', ['backbone', 'app/api/API', 'app/models/Default'], (Backbone, API, Model) ->

    Backbone.Collection.extend

        model: Model

        defaults:
            id: null

        # Overriding Backbone sync for a non Restful API
        sync: (method, model, options) ->
          switch method 
            when "read"
              API.getAllUsers().then (res) -> options.success res.users            