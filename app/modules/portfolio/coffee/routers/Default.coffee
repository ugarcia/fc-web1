define 'app/modules/portfolio/js/routers/Default', ['marionette', 'app/modules/portfolio/js/controllers/Default'], (Marionette, Controller) ->

    class Default extends Marionette.AppRouter

        controller: new Controller channelName: @options?.channelName
        
        appRoutes:
            "portfolio": "showPortfolio"
            "portfolio/:id": "showPortfolioItem"
