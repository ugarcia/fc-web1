define 'app/modules/portfolio/js/views/PortfolioItem', [
  'marionette'
  'wreqr'
  'tpl!app/modules/portfolio/templates/portfolio-item.html'
], (Marionette, Wreqr, tpl) ->

    class PortfolioItem extends Marionette.ItemView

        tagName: 'article'

        className: 'fc-portfolio-item-container'

        channelName: 'portfolio'

        vent: null

        options: null

        template: (model) => tpl model: model or {}

        modelEvents:
            'change': 'render'

        initialize: (@options) ->
            @channelName = @options?.channelName or @channelName
            @vent = Wreqr.radio.channel(@channelName).vent            

