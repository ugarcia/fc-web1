define 'app/modules/portfolio/js/views/Portfolio', [
  'marionette'
  'wreqr'
  'app/modules/portfolio/js/views/PortfolioItemSlot'
], (Marionette, Wreqr, PortfolioItemView) ->

    class Portfolio extends Marionette.CollectionView

        className: 'row fc-portfolio-items'

        channelName: 'portfolio'

        vent: null

        options: null

        childView: PortfolioItemView

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