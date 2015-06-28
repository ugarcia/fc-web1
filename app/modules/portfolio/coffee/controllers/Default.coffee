define 'app/modules/portfolio/js/controllers/Default', [
  'app/js/BaseController'
  'app/modules/portfolio/js/views/Layout'
  'app/modules/portfolio/js/views/Header'
  'app/modules/portfolio/js/views/PortfolioItem'
  'app/modules/portfolio/js/views/Portfolio'
  'app/modules/portfolio/js/views/PortfolioCarousel'
  'app/modules/portfolio/js/models/PortfolioItem'
  'app/modules/portfolio/js/collections/Portfolio'
], (
  BaseController
  Layout
  Header
  PortfolioItemView
  PortfolioView
  PortfolioCarouselView
  PortfolioItem
  Portfolio
) ->

  class DefaultController extends BaseController

    channelName: 'portfolio'

    mainLayoutClass: Layout

    showPortfolio: ->
      @initLayout()
      portfolio = new Portfolio
      portfolio.fetch()
      @layout.getRegion('header').show new Header channelName: @channelName
      @layout.getRegion('content').show new PortfolioView collection: portfolio, channelName: @channelName

    showPortfolioItem: (id) ->
      @initLayout()
      portfolioItem = new PortfolioItem id: id
      portfolioItem.fetch()
      @layout.getRegion('header').reset()
      @layout.getRegion('content').show new PortfolioItemView model: portfolioItem, channelName: @channelName

    setEvents: ->
      @vent.on 'request:view:portfolio-carousel', (data) =>
        portfolio = new Portfolio
        portfolio.fetch()
        # TODO: Pass here origin request channel??
        data.data = new PortfolioCarouselView collection: portfolio, channelName: @channelName
        @vent.trigger 'module:response', data
