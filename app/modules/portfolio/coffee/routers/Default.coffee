define 'app/modules/portfolio/js/routers/Default', ['app/js/BaseRouter', 'app/modules/portfolio/js/controllers/Default'], (BaseRouter, Controller) ->

  class Default extends BaseRouter

    channelName: 'portfolio'

    controller: new Controller channelName: @options?.channelName

    appRoutes:
      "!/portfolio": "showPortfolio"
      "!/portfolio/:id": "showPortfolioItem"
