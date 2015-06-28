define 'app/modules/portfolio/js/views/PortfolioCarousel', [
  'marionette'
  'wreqr'
  'app/modules/portfolio/js/views/PortfolioItemCarousel'
  'tpl!app/modules/portfolio/templates/portfolio-carousel.html'
], (Marionette, Wreqr, PortfolioItemView, tpl) ->

  class PortfolioCarousel extends Marionette.CompositeView

    template: (collection) => tpl collection: collection or {}

    className: 'fc-portfolio-items fc-portfolio-items-carousel'

    channelName: 'portfolio'

    vent: null

    options: null

    childView: PortfolioItemView

    childViewContainer: '.fc-portfolio-carousel-items-container'

    childViewOptions:
      channelName: 'portfolio'

    collectionEvents:
      'update': 'render'

    initialize: (@options) ->
      @channelName = @options?.channelName or @channelName
      @vent = Wreqr.radio.channel(@channelName).vent
      @setEvents()

    setEvents: ->
      @vent.on 'collection:update:portfolio', => @collection.fetch()
