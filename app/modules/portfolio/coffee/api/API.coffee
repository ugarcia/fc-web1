define 'app/modules/portfolio/js/api/API', ['jquery', 'underscore'], ($, _) ->

  cmsHost = 'cms.' + window.location.hostname
  url = window.location.protocol + '//' + cmsHost + '/api'
  DEBUG = no

  $.ajaxSetup
    crossDomain: true
#    xhrFields:
#      withCredentials: true

  # Auto instantiated class for requests to LogQuest Wordpress JSON API
  # The server JSON responses are wrapped into an object which also contains a 'status' field.
  # @example Succesful response for a 'get post' request:
  #   {
  #     status: 'ok'
  #     post: { ... }
  #   }
  # @see http://wordpress.org/plugins/json-api/other_notes/
  class API

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
