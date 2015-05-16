define 'app/modules/cms/js/api/API', ['jquery', 'underscore'], ($, _) ->

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
    getPosts: (count, page, type) ->
      @call( 'GET', "core", "get_posts",
        count: count
        page: page
        type: type
      )
      .then (res)->
        ## LOGGING ##
        console.groupCollapsed "API Response:", res.posts.length, "posts"
        console.log res
        res.posts.forEach (post) ->
          console.groupCollapsed post.title, "by", post.author.name
          console.info post
          console.log post.excerpt
          if post.attachments.length
            console.group "Attachments"
            console.log attachment for attachment in post.attachments
            console.groupEnd()
          console.groupEnd()
        console.groupEnd()
        ## /LOGGING ##
        res

    # Requests a post given its id
    # @param id [Integer] The post id
    # @return [Object] A Promise with the JSON response from the server
    # @example Get the post with id=34 from the server:
    #     getPost 34
    #       .then (response) -> alert response.post.title, response.post.content
    getPost: (id) ->
      @call( 'GET', "core", "get_post",
        id: id
      )
      .then (res)-> res

    # Requests a page of recent posts of certain type 
    # @param count [Integer] The number of posts to request
    # @param page [Integer] The page number to request
    # @param type [String] The type of requested posts
    # @return [Object] A Promise with the JSON response from the server
    # @example Get the second page of 12 recent posts of type 'news':
    #     getRecentPosts 12, 2, 'news'
    #       .then (response) -> console.log post.title, post.content for post in response.posts
    getRecentPosts: (count, page, type) ->
      @call( 'GET', "core", "get_recent_posts",
        count: count
        page: page
        type: type
      )
      .then (res)-> res

    # Requests a page of posts of certain type and from certain author
    # @param author [Integer] The posts author id
    # @param count [Integer] The number of posts to request
    # @param page [Integer] The page number to request
    # @param type [String] The type of requested posts
    # @return [Object] A Promise with the JSON response from the server
    # @example Get the first page of 8 recent posts of type 'log' of author with id=8:
    #     getAuthorPosts 8, 8, 1, 'log'
    #       .then (response) -> console.log post.title, post.content for post in response.posts
    getAuthorPosts: (author, count, page, type) -> 
      @call( 'GET', "core", "get_author_posts",
        id: author
        count: count
        page: page
        post_type: type
      ).then (res)-> res

    # Requests a page of posts of certain type and from certain tag
    # @param tag [Integer] The posts tag id
    # @param count [Integer] The number of posts to request
    # @param page [Integer] The page number to request
    # @param type [String] The type of requested posts
    # @return [Object] A Promise with the JSON response from the server
    # @example Get the first page of 8 recent posts of type 'log' of tag with id=8:
    #     getTagPosts 8, 8, 1, 'log'
    #       .then (response) -> console.log post.title, post.content for post in response.posts
    getTagPosts: (tag, count, page, type) -> 
      @call( 'GET', "core", "get_tag_posts",
        id: tag
        count: count
        page: page
        post_type: type
      ).then (res)-> res

    # Requests a page of posts of certain type and for a certain date
    # @param date [String] The date for the search
    # @param count [Integer] The number of posts to request
    # @param page [Integer] The page number to request
    # @param type [String] The type of requested posts
    # @return [Object] A Promise with the JSON response from the server
    # @example Get the first page of posts of type 'log' on Jan 2014:
    #     getDatePosts '2014-01', 8, 1, 'log'
    #       .then (response) -> console.log post.title, post.content for post in response.posts
    getDatePosts: (date, count, page, type) -> 
      @call( 'GET', "core", "get_date_posts",
        date: date
        count: count
        page: page
        post_type: type
      ).then (res)-> res

    # Requests a page of posts for a provided week (0 to 53)
    # @param week [Number] The week for the search
    # @param count [Integer] The number of posts to request
    # @param page [Integer] The page number to request
    # @param type [String] The type of requested posts
    # @return [Object] A Promise with the JSON response from the server
    # @example Get the first page of posts of type 'log' on week 7 (over February)
    #     getWeekPosts 7, 8, 1, 'log'
    #       .then (response) -> console.log post.title, post.content for post in response.posts
    getWeekPosts: (week, count, page, type) -> 
      @call( 'GET', "core", "get_posts",
        w: week
        count: count
        page: page
        post_type: type
      ).then (res)-> res

    # Requests the dates tree & permalinks for all the posts
    # @return [Object] A Promise with the JSON response from the server
    # @example Get all the dates
    #     getDateIndex()
    #       .then (response) -> console.log year for year in response.tree
    getDateIndex: -> 
      @call( 'GET', "core", "get_date_index").then (res)-> res

    # Requests the dates tree by day for all the posts
    # @return [Object] A Promise with the JSON response from the server
    # @example Get all the dates
    #     getDateDaysIndex()
    #       .then (response) -> console.log year for year in response.tree
    getDateDaysIndex: -> 
      @call( 'GET', "posts_custom", "date_scrubber").then (res)-> res

    # Submits a new post
    # @param postdata [FormData] A form object containing the post data
    # @option postdata [String] title The post title
    # @option postdata [String] content The post content
    # @option postdata [String] tags [optional] The post tags, separated with spaces
    # @option postdata [Blob] attachment [optional] A file(blob) attachment for the post
    # @return [Object] A Promise with the JSON response from the server
    # @note The Wordpress JSON API needs the name and email parameters to be sent to work (hope they fix it)
    # @example Post a thought:
    #     formData = new FormData
    #     formData.append 'title', 'my thought'
    #     formData.append 'content', 'I think this is a simple post'
    #     formData.append 'tags', 'thought, post, sample'
    #     formData.append 'name', 'Me'
    #     formData.append 'email', 'it@is.me'
    #     createPost formData
    #       .then (response) -> console.log "Posted: ", response.post.title
    createPost: (postdata) ->
      throw new Error("postdata isn't FormData!") unless postdata instanceof FormData
      @getNonce('posts', 'create_post').then (nonce) =>
        postdata.append 'nonce', nonce
        @call( "POST", "posts", "create_post", postdata,
          processData: false
          contentType: false
        ).then (res) -> res

    # Updates a post
    # @param postdata [FormData] A form object containing the post data
    # @option postdata [Integer] id The post id    
    # @option postdata [String] title The post title
    # @option postdata [String] content The post content
    # @option postdata [String] tags [optional] The post tags, separated with spaces
    # @option postdata [Blob] attachment [optional] A file(blob) attachment for the post
    # @return [Object] A Promise with the JSON response from the server
    # @note The Wordpress JSON API needs the name and email parameters to be sent to work (hope they fix it)
    # @example Post a thought:
    #     formData = new FormData
    #     formData.append 'title', 'my thought'
    #     formData.append 'content', 'I think this is a simple post'
    #     formData.append 'tags', 'thought, post, sample'
    #     formData.append 'name', 'Me'
    #     formData.append 'email', 'it@is.me'
    #     updatePost formData
    #       .then (response) -> console.log "Updated: ", response.post.title
    updatePost: (postdata) ->
      throw new Error("postdata isn't FormData!") unless postdata instanceof FormData
      @getNonce('posts', 'update_post').then (nonce) =>
        postdata.append 'nonce', nonce
        @call( "POST", "posts", "update_post", postdata,
          processData: false
          contentType: false
        ).then (res) -> res


    # Submits a new comment for a given post
    # @param commentdata [Object] An object containing the comment data
    # @option commentdata [String] content The comment content
    # @option commentdata [String] name The author name
    # @option commentdata [String] email The author email
    # @return [Object] A Promise with the JSON response from the server
    # @note The Wordpress JSON API needs the name and email parameters to be sent to work (hope they fix it)
    # @example Comment a post:
    #     submitComment content: 'I like your post', name: 'Me', email: 'it@is.me'
    #       .then (response) -> console.log "Commented: ", response.comment.content
    submitComment: (commentdata) ->
      throw new Error("commentdata isn't FormData!") unless commentdata instanceof FormData
      @getNonce('respond', 'submit_comment').then (nonce) =>
        commentdata.append 'nonce', nonce
        @call( 'POST', "respond", "submit_comment", commentdata,
          processData: false
          contentType: false
        ).then (res) -> res

    # Submits an approval a given post
    # @param post_id [Integer] The post id
    # @return [Object] A Promise with the JSON response from the server
    # @example Approve a post:
    #     approve post_id: 334
    #       .then (response) -> console.log "Post approvals: ", response.approvals
    approve: (post_id) -> 
      @getNonce('approvals', 'approve').then (nonce) =>
        @call('POST', 'approvals', "approve", 
          post_id: post_id
          nonce: nonce
        ).then (res) => res

    # Gets the approvals for a given post
    # @param post_id [Integer] The post id
    # @return [Object] A Promise with the JSON response from the server
    # @example Get post approvals:
    #     getApprovals post_id: 334
    #       .then (response) -> console.log "Approvals: ", response.approvals, "by me: ", response.approved
    getApprovals: (post_id) ->
      @call('POST', 'approvals', "get_status", 
        post_id: post_id
      ).then (res) => res





    # Gets all the available quests for the current user
    # @return [Object] A Promise with the JSON response from the server
    # @example Get my quests:
    #     getMyQuests()
    #       .then (response) -> console.log "I've got #{response.quests.length} quests"
    getMyQuests: -> @call( 'GET', "quests", "my").then (res)-> res

    # Gets a quest data from its id
    # @param [Integer] id The quest id
    # @return [Object] A Promise with the JSON response from the server
    # @example Get a quest data:
    #     getQuest 5
    #       .then (response) -> console.log response.quest.title, response.quest.goals
    getQuest: (id) -> 
      @call( 'GET', "quests", "get",
        quest_id: id
      ).then (res)-> res

    # Gets the goals for a quest
    # @param [Integer] id The quest id
    # @return [Object] A Promise with the JSON response from the server
    # @example Get a quest goals:
    #     getQuestGoals 5
    #       .then (response) -> console.log goal for goal in response.goals
    getQuestGoals: (id) -> 
      @call( 'GET', "quests", "get_goals",
        quest_id: id
      ).then (res)-> res

    # Gets the last completed goals for the current user
    # @return [Object] A Promise with the JSON response from the server
    # @example Get the user last completed goals:
    #     getLastCompletedGoals()
    #       .then (response) -> console.log goal for goal in response.goals
    getLastCompletedGoals: -> 
      @call( 'GET', "quests", "get_last_completed_goals").then (res)-> res

    # Gets a goal data from its id
    # @param [Integer] id The goal id
    # @return [Object] A Promise with the JSON response from the server
    # @example Get a goal data:
    #     getGoal 43
    #       .then (response) -> console.log response.goal.title, response.goal.actions
    getGoal: (id) -> 
      @call( 'GET', "quests", "get_goal",
        goal_id: id
      ).then (res)-> res

    # Gets the actions for a goal
    # @param [Integer] id The goal id
    # @return [Object] A Promise with the JSON response from the server
    # @example Get a goal actions:
    #     getGoalActions 21
    #       .then (response) -> console.log action for action in response.actions
    getGoalActions: (id) -> 
      @call( 'GET', "quests", "get_actions",
        goal_id: id
      ).then (res)-> res

    # Gets the last completed actions for the current user
    # @return [Object] A Promise with the JSON response from the server
    # @example Get the user last completed actions:
    #     getLastCompletedActions()
    #       .then (response) -> console.log action for action in response.actions
    getLastCompletedActions: -> 
      @call( 'GET', "quests", "get_last_completed_actions").then (res)-> res

    # Gets the  active actions for the current user
    # @return [Object] A Promise with the JSON response from the server
    # @example Get the user active actions:
    #     getMyActions()
    #       .then (response) -> console.log action for action in response.actions
    getMyActions: -> 
      @call( 'GET', "quests", "my_actions").then (res)-> res

    # Gets an action data from its id
    # @param [Integer] id The action id
    # @return [Object] A Promise with the JSON response from the server
    # @example Get an action data:
    #     getAction 12
    #       .then (response) -> console.log response.action.title, response.action.status
    getAction: (id) -> 
      @call( 'GET', "quests", "get_action",
        action_id: id
      ).then (res)-> res

    # Posts a goal status
    # @param [Integer] id The goal id
    # @param [String] status The goal current status
    # @return [Object] A Promise with the JSON response from the server
    # @example Set a goal as 'accepted':
    #     setGoalStatus 11, 'accepted'
    #       .then (response) -> console.log "goal status changed to accepted"
    setGoalStatus: (id, status) ->
      @call( 'POST', "quests", "#{status}_goal",
        goal_id: id
      ).then (res)-> res

    # Posts the action started status
    # @param [Integer] id The action id
    # @return [Object] A Promise with the JSON response from the server
    # @example Set an action as 'started':
    #     doAction 11
    #       .then (response) -> console.log "action started"
    doAction: (id) ->
      @call( 'POST', "quests", "do_action",
        action_id: id
      ).then (res)-> res

    # Posts an action rate
    # @param [Integer] id The action id
    # @param [String] reaction The action rating as a string (liked, disliked, etc.)
    # @return [Object] A Promise with the JSON response from the server
    # @example Rate an action as 'liked':
    #     rateAction 13, 'liked'
    #       .then (response) -> console.log "action rated"
    rateAction: (id, reaction) ->
      @call( 'POST', "quests", "rate_action",
        action_id: id
        reaction: reaction
      ).then (res)-> res

    # Posts an action share
    # @param [Integer] id The action id
    # @param [String] url The url to share for the action
    # @return [Object] A Promise with the JSON response from the server
    # @example Share an action url 'http://my.url':
    #     shareAction 13, 'http://my.url'
    #       .then (response) -> console.log "action shared"
    shareAction: (id, url) ->
      @call( 'POST', "quests", "share_action",
        action_id: id
        url: url
      ).then (res)-> res

    # This method is provisional and only for testing purposes
    # @todo Scrap this out once app is in production
    getDataQuest: ->
      @call('GET', 'quests', 'gimmi_dat_quest').then (res) -> res



    # Requests authentication/data from current user
    # @return [Object] A Promise with the JSON response from the server
    # @example Get my data:
    #     whoami
    #       .then (response) -> console.log response.user_id, response.user.first_name
    whoami: -> @call('GET', 'users','whoami').then (res) -> res

    # Requests login for current user
    # @param data [Object] An object with the authentication data
    # @option data [String] user The user login
    # @option data [String] pass The user password
    # @return [Object] A Promise with the JSON response from the server
    # @example Login me:
    #     login user: 'me', pass:'mypass'
    #       .then (response) -> console.log response.user
    login: (data) -> @call("POST", "users", "login",
        user: data.user
        pass: data.pass
        remember: 1
      ).then (res) -> res

    # Requests logout for current user
    # @return [Object] A Promise with the JSON response from the server
    # @example Logout me:
    #     logout())
    #       .then (response) -> console.log 'logged out properly'
    logout: -> @call('GET', 'users','logout').then (res) -> res

    # Requests register for current user
    # @param data [Object] An object with the registration data
    # @option data [String] user The user login
    # @option data [String] pass The user password
    # @option data [String] email The user email
    # @return [Object] A Promise with the JSON response from the server
    # @example Register me:
    #     register user: 'me', pass:'mypass', email: 'my@email.mine'
    #       .then (response) -> console.log response.user
    register: (data) -> @call("POST", "users", "register",
        user: data.user
        pass: data.pass
        email: data.email
      ).then (res) -> res

    # Requests a list of all users in the current project
    # @return [Object] A Promise with the JSON response from the server
    # @example Get the users
    #     getAllUsers()
    #       .then (response) -> console.log user.first_name for user in response.users
    getAllUsers: -> @call('GET', 'users', 'get_all').then (res) -> res

    # Requests an user in the current project by its id
    # @param id [Integer] The user id
    # @return [Object] A Promise with the JSON response from the server
    # @example Get a user
    #     getUser 3
    #       .then (response) -> console.log response.user.first_name, response.user.email
    getUser: (id) -> 
      @call('GET', 'users', 'get',
        user_id: id
      ).then (res) => res




    # Requests the current project performance health.
    # @return [Object] A Promise with the JSON response from the server
    # @example Get the health
    #     getProjectHealth()
    #       .then (response) -> console.log response.health
    getProjectHealth: -> 
      @call('GET', 'performance', 'get_health').then (res) => res


    # Requests a project given its id
    # @param id [Integer] The project id
    # @return [Object] A Promise with the JSON response from the server
    # @todo Not implemented yet server-side
    # @example Get the project with id=7 from the server:
    #     getProject 7
    #       .then (response) -> alert response.project.name, response.project.end_date
    getProject: (id) ->
      @call( 'GET', "projects", "get_project",
        id: id
      )
      .then (res)-> res

    # Submits a new project
    # @param postdata [FormData] A form object containing the project data
    # @option postdata [String] name The project name
    # @option postdata [String] start_date The project start date
    # @option postdata [String] end_date The project end date
    # @option postdata [Array<Number>] skills An array with the skills ids
    # @return [Object] A Promise with the JSON response from the server
    # @todo Not implemented yet server-side
    # @example Create the byebye project:
    #     formData = new FormData
    #     formData.append 'name', 'byebye'
    #     formData.append 'start_date', '2014-02-21'
    #     formData.append 'end_date', '2014-02-28'
    #     formData.append 'skills', [34, 57, 12]
    #     createProject formData
    #       .then (response) -> console.log "Created project: ", response.project.name
    createProject: (postdata) ->
      throw new Error("postdata isn't FormData!") unless postdata instanceof FormData
      @getNonce('projects', 'create_project').then (nonce) =>
        postdata.append 'nonce', nonce
        @call( "POST", "posts", "create_project", postdata,
          processData: false
          contentType: false
        ).then (res) -> res

    # Submits an user event over a given post
    # @param post_id [Integer] The post id
    # @param event_type [String] The type of triggered event
    # @return [Object] A Promise with the JSON response from the server
    # @example Fire a video track played event
    #     trackEvent post_id: 24, type: 'play_video'
    #       .then (response) -> console.log response
    trackEvent: (post_id, event_type) ->
      @call('POST', 'events', "track", 
        post_id: post_id
        event: event_type
      ).then (res) => res

    # Gets the last notifications from server
    # @return [Object] A Promise with the JSON response from the server
    # @example
    #     getEvents())
    #       .then (response) -> console.log 'this changed: ', response.changes
    getEvents: -> 
      @call('GET', 'events', 'get_notifications').then (res) -> res


  new API;
