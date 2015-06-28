define 'app/modules/main/js/routers/Default', ['app/js/BaseRouter', 'app/modules/main/js/controllers/Default'], (BaseRouter, Controller) ->

  class Default extends BaseRouter

    channelName: 'main'

    controller: new Controller channelName: @options?.channelName

    appRoutes:
      "home": "home"
