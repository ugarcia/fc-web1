define 'app/modules/home/js/views/Home', ['app/js/BaseLayout', 'tpl!app/modules/home/templates/content.html'], (BaseLayout, tpl) ->

  class Home extends BaseLayout

    el: '.fc-content'

    template: (model) -> tpl model: model or {}

    regions:
      portfolio: '.fc-home-portfolio'
      misc: '.fc-home-misc'
