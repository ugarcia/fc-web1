define 'app/modules/portfolio/js/views/PortfolioItemSlot', [
  'app/modules/portfolio/js/views/PortfolioItem'
  'tpl!app/modules/portfolio/templates/portfolio-item-slot.html'
], (PortfolioItem, tpl) ->

    class PortfolioItemSlot extends PortfolioItem

        className: 'col-sm-6 col-md-4 col-lg-3 fc-portfolio-item-container'

        template: (model) => tpl model: model or {}
