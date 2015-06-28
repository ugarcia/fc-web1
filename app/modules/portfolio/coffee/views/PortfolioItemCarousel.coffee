define 'app/modules/portfolio/js/views/PortfolioItemSlot', [
  'app/modules/portfolio/js/views/PortfolioItem'
  'tpl!app/modules/portfolio/templates/portfolio-item-carousel.html'
], (PortfolioItem, tpl) ->

    class PortfolioItemCarousel extends PortfolioItem

        className: 'fc-portfolio-item-container'

        template: (model) => tpl model: model or {}
