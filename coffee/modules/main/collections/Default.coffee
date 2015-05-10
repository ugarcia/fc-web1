define 'app/modules/main/collections/Default', ['backbone', 'app/modules/main/api/API', 'app/modules/main/models/Default'], (Backbone, API, Model) ->

    Backbone.Collection.extend

        model: Model

        defaults:
            id: null

        # Overriding Backbone sync for a non Restful API
        sync: (method, model, options) ->
          switch method 
            when "read"
              API.getAllUsers().then (res) -> options.success res.users         