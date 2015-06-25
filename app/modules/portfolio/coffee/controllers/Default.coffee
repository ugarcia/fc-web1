define 'app/modules/portfolio/js/controllers/Default', [
    'marionette'
    'wreqr'
    'app/modules/portfolio/js/api/API'
    'app/modules/portfolio/js/views/Layout'
    'app/modules/portfolio/js/views/Header'
    'app/modules/portfolio/js/views/PortfolioItem'
    'app/modules/portfolio/js/views/Portfolio'
    'app/modules/portfolio/js/models/PortfolioItem'
    'app/modules/portfolio/js/collections/Portfolio'
], (
    Marionette
    Wreqr
    API
    Layout
    Header
    PortfolioItemView
    PortfolioView
    PortfolioItem
    Portfolio
) ->

    class DefaultController extends Marionette.Controller

        channelName: 'portfolio'

        vent: null

        layout: null

        options: null

        constructor: (@options) ->
            @channelName = @options?.channelName or @channelName
            @vent = Wreqr.radio.channel(@channelName).vent
            # @setEvents()
            @

        # setEvents: ->
        #     @vent.on 'modal:open:post', @openPostModal

        # openPostModal: (data) =>
        #     @openModal new PostModal model: data?.model ? new Post

        # openModal: (view) =>
        #     @layout.getRegion('modal').show view if view

        showPortfolio: ->
            @initLayout()
            portfolio = new Portfolio
            portfolio.fetch() 
            @layout.getRegion('content').show new PortfolioView collection: portfolio, channelName: @channelName 

        showPortfolioItem: (id) ->
            @initLayout()
            portfolioItem = new PortfolioItem id: id
            portfolioItem.fetch() 
            @layout.getRegion('content').show new PortfolioItemView model: portfolioItem              

        initLayout: ->
            if not @layout
                @layout = new Layout
                @layout.render()
                @layout.getRegion('header').show new Header channelName: @channelName
   
