define 'app/modules/portfolio/js/views/Portfolio', ['marionette', 'wreqr', 'app/modules/portfolio/js/views/PortfolioItem', 'tpl!app/modules/portfolio/templates/portfolio-item.html'], (Marionette, Wreqr, PortfolioItemView, tpl) ->

    class Portfolio extends Marionette.CollectionView

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