define 'app/modules/home/js/routers/Default', ['app/js/BaseRouter', 'app/modules/home/js/controllers/Default'], (BaseRouter, Controller) ->

  class Default extends BaseRouter

    channelName: 'home'

    controller: new Controller channelName: @options?.channelName

    appRoutes:
        "": "showHome"
        "home": "showHome"
