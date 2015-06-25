define 'app/modules/portfolio/js/api/API', ['jquery', 'underscore'], ($, _) ->

  url = 'https://cms.frontcoder.local/api'
  DEBUG = no

  $.ajaxSetup
    crossDomain: true
    xhrFields:
      withCredentials: true

  # Auto instantiated class for requests to LogQuest Wordpress JSON API
  # The server JSON responses are wrapped into an object which also contains a 'status' field.
  # @example Succesful response for a 'get post' request:
  #   {
  #     status: 'ok'
  #     post: { ... }
  #   }
  # @see http://wordpress.org/plugins/json-api/other_notes/
  class API

    # Requests an one-use hash (nonce) for a subsequent request to the server.
    # This is intended as a security rule.
    # @param controller [String] A controller in the JSON API 
    # @param method [String] A method defined for the controller above
    # @return [Object] A Promise with the JSON response from the server
    # @example Get a nonce for submitting a post:
    #     getNonce 'core', 'submit_post'
    #       .then (response) -> submit_the_post response.nonce, post_data
    getNonce: (controller, method) ->
      throw new Error("No controller specified!") unless controller
      throw new Error("No method specified!") unless method
      @call( 'GET', "core", "get_nonce",
        controller: controller
        method: method
      )
      .then (res) -> res.nonce

    # Parameterized method for generical requests.
    # @param method [String] The HTTP method (GET, POST, ...)
    # @param controller [String] A controller in the JSON API 
    # @param func [String] A method defined for the controller above
    # @param data [Object] An object containing the query parameters
    # @param extra [Object] An object containing extra headers for the request
    # @return [Object] A Promise with the JSON response from the server
    # @example Get a post from the server given its id:
    #     call 'GET', 'core', 'get_post', { id: the_post_id }, { Accept: 'application/json' }
    #       .then (response) -> alert response.post.title, response.post.content
    call: (method, controller, func, data, extra) ->
      req = 
        url: "#{url}/#{controller}/#{func}/"
        type: method
        data: data
        dataType: 'json'
      _.extend(req, extra)
      $.ajax(req).then(@apiFilter)

    # Filters a server response.
    # @param res [Object] The JSON response from the server
    # @return [Object] A Promise with the response if success, an error message on fail.
    # @example Filter a succesful response
    #     apiFilter { status: 'OK', post: { ... } }
    #     > API call succeeded: { status: 'OK', post: { ... } }
    # @example Filter an unsuccessful response
    #     apiFilter { status: 'Not found' }
    #     > API Call failed: Not found
    apiFilter: (res) ->
      d = new $.Deferred;
      if res.status isnt "ok"
        d.reject res.error, res.status
        console.error("API Call failed:", res.error)
      else
        d.resolve res
        console.info( "API call succeeded:", res ) if DEBUG
      d.promise()

    # Dumps out to the console all available info about the server JSON API
    # @example
    #     getInfo()
    #     > API Version 1.1.1with 8 controllers active
    #           Core
    #             Basic introspection methods
    #             Methods
    #               get_recent_posts
    #               get_posts
    #                ......
    #           Posts
    #             Data manipulation methods for posts
    #             Methods
    #               create_post
    #               update_post
    #            ...... 
    getInfo: () ->
      @call( 'GET', "core", "info").then (res) => 
        $.when.apply($, res.controllers.map (ctlr) => @call  'GET', "core", "info", controller: ctlr )
        .then () ->
          console.groupCollapsed "API Version " + res.json_api_version + " with " + res.controllers.length + " controllers active";
          _.each arguments, (res) ->
            console.groupCollapsed res.name
            console.log res.description
            console.group "Methods"
            _.each res.methods, (name) -> console.log name
            console.groupEnd()
            console.groupEnd()
          console.groupEnd()

    # Requests a page of posts of certain type 
    # @param count [Integer] The number of posts to request
    # @param page [Integer] The page number to request
    # @param type [String] The type of requested posts
    # @return [Object] A Promise with the JSON response from the server
    # @example Get the second page of 12 posts of type 'log':
    #     getPosts 12, 2, 'log'
    #       .then (response) -> console.log post.title, post.content for post in response.posts
    getPortfolio: ->
      @call( 'GET', "portfolio", "get_portfolio").then (res)-> res


    # Requests a post given its id
    # @param id [Integer] The post id
    # @return [Object] A Promise with the JSON response from the server
    # @example Get the post with id=34 from the server:
    #     getPost 34
    #       .then (response) -> alert response.post.title, response.post.content
    getPortfolioItem: (id) ->
      @call( 'GET', "portfolio", "get_portfolio_item", id: id).then (res)-> res


  new API;
