define 'app/modules/portfolio/js/views/PortfolioItemCarousel', [
  'app/modules/portfolio/js/views/PortfolioItem'
  'tpl!app/modules/portfolio/templates/portfolio-item-carousel.html'
], (PortfolioItem, tpl) ->

  class PortfolioItemCarousel extends PortfolioItem

    tagName: 'div'

    className: 'fc-portfolio-item-carousel item'

    template: (model) => tpl model: model or {}

    onRender: ->
      $(@el).addClass 'active' if @model.get('id') is 1
